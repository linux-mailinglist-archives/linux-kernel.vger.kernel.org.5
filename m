Return-Path: <linux-kernel+bounces-83715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926A869D97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AB21F21816
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA114AD23;
	Tue, 27 Feb 2024 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F15y5ubP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A71487D7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054681; cv=none; b=UCExPvUtOqZqdIAe7tYxY7L47JhVhllqLB0m9eGkGpMV5ovNnD2yIiaBfLeJK5+up5D529ZdNJBKhyIGKG7OECrKieI+g+IYnH3S67DM5c6trurg5UzNcaAQa46Yu8e2M2qsowfXmNGpWZgnIuM1oClMAX0CniLny6bQdUFi97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054681; c=relaxed/simple;
	bh=z9R4HN6mKB3PtRfX63p1vdZ5UsCmrH/WC3mMKJ6Fbsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/HMzikKUtBjJq15N5HCassR4mw9cULJYn5yFI4mvn6QiW7Flbz9OLjl4xXns8HkW5dhiMod0GKzwnMmjUqcPuCsoyPSFC1KtT5glHkYCo39IP4owHyHc0scVpudgZughBieDAHVdpJthp+a3U5bHWMt6Z5CCiK6Qyoun20746w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F15y5ubP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44CEC433F1;
	Tue, 27 Feb 2024 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709054681;
	bh=z9R4HN6mKB3PtRfX63p1vdZ5UsCmrH/WC3mMKJ6Fbsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F15y5ubPJGmEVExQrAuTwHbjKQBpFE7Wlqt7umnPeV5d06ZEaPh4xOBqWOcM+nIcQ
	 Zv3cEgb3M0FSrVpszz3L/55tG1ddZ5dktgQ4XZFPQhNg6K0ZW/pq6vdws2ZCImtQAx
	 Y5XQj+5nMXMFhhPXlyraICY8sre1JYslDlSp+nOA=
Date: Tue, 27 Feb 2024 18:24:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Message-ID: <2024022706-kindle-tapering-5f66@gregkh>
References: <2024022709-magazine-handshake-50da@gregkh>
 <20240227150744.GA235367@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227150744.GA235367@bhelgaas>

On Tue, Feb 27, 2024 at 09:07:44AM -0600, Bjorn Helgaas wrote:
> [+cc Mika, author of 09cc90063240]
> 
> On Tue, Feb 27, 2024 at 02:26:26PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 27, 2024 at 02:18:51PM +0100, Carlos López wrote:
> > > On 25/2/24 9:16, Greg Kroah-Hartman wrote:
> > > > There is no actual issue right now because we have another check
> > > > afterwards and the out-of-bounds read is not being performed. In
> > > > any case it's better code with this fixed, hence the proposed
> > > > change.
> > > 
> > > Given that there is no actual security issue this looks more like a
> > > hardening, and thus not deserving of a CVE, no?
> > 
> > This was a tricky one, I think it's needed as we do not know how people
> > are really using these macros, right?  If the PCI maintainer agrees (on
> > the cc:), I'll be glad to revoke it, it's their call.
> 
> 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()") added
> pci_dev_for_each_resource(), which expands to:
> 
>   for (...; res = (&(dev)->resource[(bar)]), bar < PCI_NUM_RESOURCES; ...)
> 
> We compute "res" before the bounds-check of "bar", so the pointer may
> be out-of-bounds, but the body of the pci_dev_for_each_resource() loop
> is never executed with that out-of-bounds value.
> 
> So I don't think this is a security issue, no matter how
> pci_dev_for_each_resource() is used, unless the mere presence of an
> invalid address in a register is an issue.

Ah, yeah, now I remember, stuff like this was fixed up in other loops as
just reading off into the wild can be a speculation issue and so we had
to fix up a bunch of places in the kernel where we did have "invalid
data" in a register.  The code didn't use that, but the processor would
fetch from there, and boom, speculation mess.  There's a whole research
paper published on this type of thing somewhere...

So let's keep this as a CVE unless someone really doesn't want it marked
as such.  Again, it is a "weakness that is fixed" in the kernel, and
because of that, a CVE can be allocated for it.

thanks,

greg k-h

