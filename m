Return-Path: <linux-kernel+bounces-83333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7198693AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C9B3036D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655813B7AE;
	Tue, 27 Feb 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OH4driMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8E2F2D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041446; cv=none; b=Ukb+mWHc73QaO2VnJlVwFvOgB2sSjxHDf4eYJWtB8vf9V8oamqTT909wU3NSpMtwUOJi897U5RWGh167c+qni2rwkpuu1rpXimuVkkzI5lioNyxxqYm8PmWE7orPkqXJxSP5dfbMsS4G9dGYO5149jG82lkfxCicNdZDSh6IGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041446; c=relaxed/simple;
	bh=95cFWjeY5LEieUX1HL6jGK837jYAzO+4vi3tON4jwus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRJY3BKTegGPThrdeaMnebxCD7p6gFYLmdQ3aNMfinDpIuZveB9k6gJa/FGvH+rho7mXQQ3wkzURc12ja8zxRM+QA0Gw4HLG25duuq9jyCyJyqEIdgGm7TfcdNxPYioz7UmT1NRtdl0YCLLO+6iTAEiYKVTOIumnzy3un77U/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OH4driMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9886C433C7;
	Tue, 27 Feb 2024 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041446;
	bh=95cFWjeY5LEieUX1HL6jGK837jYAzO+4vi3tON4jwus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OH4driMVg+uVN8HYZp45ERZH7mDSv4Hlahoz+P5VpBaw8ckB+18KbFKvWbp6RzXp7
	 R/2acRnc3nUVvEJUlsWZeEZC1FKltddBZFj9TUY7wy3D5ecJG9GEeslQNPRtKN9wqb
	 R6Gd9yvFozuHZmOOMrM199slzq/U/WsqKOyYgSSw=
Date: Tue, 27 Feb 2024 14:26:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Message-ID: <2024022709-magazine-handshake-50da@gregkh>
References: <2024022544-CVE-2023-52466-fea5@gregkh>
 <084e7c38-ebce-4091-af40-42283e344ccc@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <084e7c38-ebce-4091-af40-42283e344ccc@suse.de>

On Tue, Feb 27, 2024 at 02:18:51PM +0100, Carlos López wrote:
> 
> Hi,
> 
> On 25/2/24 9:16, Greg Kroah-Hartman wrote:
> > There is no actual issue right now because we have another check afterwards
> > and the out-of-bounds read is not being performed. In any case it's better
> > code with this fixed, hence the proposed change.
> 
> Given that there is no actual security issue this looks more like a
> hardening, and thus not deserving of a CVE, no?

This was a tricky one, I think it's needed as we do not know how people
are really using these macros, right?  If the PCI maintainer agrees (on
the cc:), I'll be glad to revoke it, it's their call.

And thanks for the review, much appreciated!

greg k-h

