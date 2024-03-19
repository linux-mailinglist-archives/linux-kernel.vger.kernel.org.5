Return-Path: <linux-kernel+bounces-107184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06F87F895
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01922825BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5633537FA;
	Tue, 19 Mar 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YzxvfIc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C461E536;
	Tue, 19 Mar 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834717; cv=none; b=OEDRoq5wjvjptIGwNQKnpjwyNrpzUH9bKpWNe87Tmn8EDXWVH3DusHinTaEv5xzMfMfvdAm47c5VlReaU45y00M5bGTh1L2dxGYy3uU52wSLPSt2I8hm9l9munkLT0WwtqcVZnSiQuC4iG4hoI7IhEfctWvvQf+Oji4llB5AecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834717; c=relaxed/simple;
	bh=kef+Np91HURoIvxVyGouxjdT+2g3hg7LLKenupgyyto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyUuXTYp8GroPy6IV8/WCXle0oxuO2ohYizvhG+KZaGBvJkouuZYLdnli/iorprj+Z2Jg3xwBLWYqsndFLLCP6UpwXXx/+9dh4SSHhk7/eqgcHuwGrlyuIsAQWzQvmTPM3PxHj8VP2TpNMesue7g6/dZrMedTWpjc/XBy9Jg0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YzxvfIc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE0C433C7;
	Tue, 19 Mar 2024 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710834716;
	bh=kef+Np91HURoIvxVyGouxjdT+2g3hg7LLKenupgyyto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzxvfIc+MwsNvx2iHqu0lDN3Ndd0PD/7gfzMR/d1rQe0Mgjnd5CXg2N//LW18isZl
	 wCII7vpkJWrrBHCJOM75xKOuTgOBGXEzSmjKr1V3LXCAiH5C2CaTZ8k8EtOd35ZdLq
	 c1LOa7cpB72GLfhz2RjYnBvMuuVpNyDbhbmp13Tw=
Date: Tue, 19 Mar 2024 08:51:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/1] mei: vsc: Unregister interrupt handler for system
 suspend
Message-ID: <2024031915-manhole-winnings-43d4@gregkh>
References: <20240318080126.2813476-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318080126.2813476-1-sakari.ailus@linux.intel.com>

On Mon, Mar 18, 2024 at 10:01:26AM +0200, Sakari Ailus wrote:
> Unregister the MEI VSC interrupt handler before system suspend and
> re-register it at system resume time. This mirrors implementation of other
> MEI devices.
> 
> This patch fixes the bug that causes continuous stream of MEI VSC errors
> after system resume.
> 
> Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8
> Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/mei/platform-vsc.c | 17 ++++++-
>  drivers/misc/mei/vsc-tp.c       | 84 +++++++++++++++++++++++----------
>  drivers/misc/mei/vsc-tp.h       |  3 ++
>  3 files changed, 78 insertions(+), 26 deletions(-)

What is the git commit id of this in Linus's tree?

thanks,

greg k-h


