Return-Path: <linux-kernel+bounces-69974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F10B859124
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29EF1F21EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4237D3F8;
	Sat, 17 Feb 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y//yXWlc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F07D3EA;
	Sat, 17 Feb 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188275; cv=none; b=Yl7tprGeK8/JQrAkJXaKIB2T7x57vVRL/K/lh2+hqTQAo2zy4AOAh07bRwvqA1bUiyZUNv+IIJSTjNU5G1VXhFczxFtFc883U6sf//IhyyH3lId6H5BclRLHsiptO5an2heJTdxP8vWu3/vn+iiVVhCNO9jTSC1uNq7cxgWVvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188275; c=relaxed/simple;
	bh=NT8S/OKI4BTTc1aSNQpV52RM8baFUiBxCd2A9Yd/1S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+iGJzgSzTtoGOqWubFzUXLYiYtPlJR1rarYFBsn2lW2+UbseRw7RR8Ukh4f2tKFOxTPJnwyIfdY84VxaIyv2r+hephi/FuEd9Gkd6vikjwaPI5Ifmai3SdYeIlJLkW+j+0VWzFi/1jgta3imv9HeqlptnInOM9PiQN1n6Efe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y//yXWlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23950C43394;
	Sat, 17 Feb 2024 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708188274;
	bh=NT8S/OKI4BTTc1aSNQpV52RM8baFUiBxCd2A9Yd/1S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y//yXWlcSQorg2mtXC6aewIhtxTVBw/R0GVf35WO0DGEuNAmdv9/V8hn/cUjJBY0E
	 jjdFnDf2mpcMOvrvdWcvLBFT/rECdfBZE66ke3j1ZjDuNiJA4B8gjvPwgJggqD5roI
	 I3VYxTTfzK74p4UqHmaBNURzQvgeDh1VMwFemImA=
Date: Sat, 17 Feb 2024 17:44:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 4/5] serial: 8250_exar: Use 8250 PCI library to map
 and assign resources
Message-ID: <2024021723-spellbind-citadel-d2c1@gregkh>
References: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
 <20240214171044.3551032-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214171044.3551032-5-andriy.shevchenko@linux.intel.com>

On Wed, Feb 14, 2024 at 07:09:37PM +0200, Andy Shevchenko wrote:
> 8250 PCI library provides a common code to map and assign resources.
> Use it in order to deduplicate existing code and support IO port
> variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 10 +++++-----
>  drivers/tty/serial/8250/Kconfig     |  1 +
>  2 files changed, 6 insertions(+), 5 deletions(-)

Looks like you have a build error :(


