Return-Path: <linux-kernel+bounces-84753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C886AB11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB1AB219B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF822065;
	Wed, 28 Feb 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJynUbTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB22E64F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112012; cv=none; b=k1jOsG0eKBARfw1Ra7Lmbj6bK5vJ9l5X+WWH6K2DngS2BOHLFhxYG4WMbQHya2+YebdtvbZg5AzIg3+Za7olAR2D+ywqc/3tEmRnKeyOy8S1Sp5F8wjd2woi+89Mh4AKZycTEq6vA+CLoIMLKZfjexEgFZbzOuQBfiUgmtlNCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112012; c=relaxed/simple;
	bh=HnyQ8g0HLMtXdCZ8EJhrVdx4C/CLJyXQkFRs51GeN3o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DduTfKwgw3VcgpOh+6Nc6WW7c9nHNHEFWFZSZRE9MrXk8FK4FGfvC0S2mBf3gu2i/o8/Eeti36DdC0rkJ5kDPvF3skX9NoOFYI9M4vwVXY2BAmdQFjJZL9l5IsaKOXjq7fsrvn6OpVcyIoGLWnWIVJqs+4H+U0Vxaw4+uupbzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJynUbTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3338C433C7;
	Wed, 28 Feb 2024 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709112012;
	bh=HnyQ8g0HLMtXdCZ8EJhrVdx4C/CLJyXQkFRs51GeN3o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gJynUbTVCFxqBN9o2Wnyssp2HwEVYmz+PwITJtV8iHWL6Ts0bHCKq9ICqNix4aeSh
	 CGIlzDPa/q6VCjJ0nZXRuaZTxMUiiunVxo6bT7EpoSznv4y6QdkQl2SBEorMPQSFL3
	 9aZK34wNXZ4MJPKLC1DsYh+VK8MTxDsI2+UNOdI+Yc5EDB65m9QBTSsqV2ddiCnVFB
	 hd+ERmqEoyJa/4nIqO72m3MuwoMOX4uiqE0wyp5PwAgMBUNRLft5h3Hz8ZPyX5s9pf
	 7IILd2js0y8hk+vapT7qCCcYBRtJ/TaRycuaVFpWeMMNkcP0Bcuuwft5Ig8zgMEi66
	 fVTDid9TGgVtA==
Date: Wed, 28 Feb 2024 10:20:13 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    =?ISO-8859-15?Q?Carlos_L=F3pez?= <clopez@suse.de>, cve@kernel.org, 
    linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Jonas Gorski <jonas.gorski@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
In-Reply-To: <2024022706-kindle-tapering-5f66@gregkh>
Message-ID: <nycvar.YFH.7.76.2402281011470.21798@cbobk.fhfr.pm>
References: <2024022709-magazine-handshake-50da@gregkh> <20240227150744.GA235367@bhelgaas> <2024022706-kindle-tapering-5f66@gregkh>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Feb 2024, Greg Kroah-Hartman wrote:

> > 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()") added
> > pci_dev_for_each_resource(), which expands to:
> > 
> >   for (...; res = (&(dev)->resource[(bar)]), bar < PCI_NUM_RESOURCES; ...)
> > 
> > We compute "res" before the bounds-check of "bar", so the pointer may
> > be out-of-bounds, but the body of the pci_dev_for_each_resource() loop
> > is never executed with that out-of-bounds value.
> > 
> > So I don't think this is a security issue, no matter how
> > pci_dev_for_each_resource() is used, unless the mere presence of an
> > invalid address in a register is an issue.
> 
> Ah, yeah, now I remember, stuff like this was fixed up in other loops as
> just reading off into the wild can be a speculation issue and so we had
> to fix up a bunch of places in the kernel where we did have "invalid
> data" in a register.  The code didn't use that, but the processor would
> fetch from there, and boom, speculation mess.  There's a whole research
> paper published on this type of thing somewhere...

Greg, could you please elaborate on this?

Where in this whole construct do you see a potential for *_uncached_* (!) 
memory access that'd cause CPU to speculate into the wild? I just don't 
see it.

Thanks,

-- 
Jiri Kosina
SUSE Labs


