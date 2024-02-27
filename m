Return-Path: <linux-kernel+bounces-83749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67914869DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E34628DE61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254A84EB47;
	Tue, 27 Feb 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkhd1iZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCF4EB45
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055568; cv=none; b=AkkDJul0ZXDqvxs0HQBI/w3OCOEkArEdE24R5Z8wPkUp9bYvmshbV2+5sTS1quBvXZRd09X0zhTxxVRfeybSPG0S0sGOt5GGySLquQqQo+HagI21wyfyl5XYSwDm05uuwXHnpvaJv6SfXBSTRFovYsXvkH7IjnoTW07xdrBo+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055568; c=relaxed/simple;
	bh=4lIrLbA2e0AWKuLo9IgLJsmE+6Bg8bKIJsvGgGTTZVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CLQHCQ0KqZRt1JKfVxyu0+kGqaky0YcMr0uH+PdWBM6Gak2mXK7HYCY4+BytR3ATibXmnSF6d9uB0xefNzrs44ZUHisDUGg76WLuTCBY1m42wqUdJoZhrXoqPNuEwolQ2os/Zrwz+hON81zOS3cueQYjs76TI/L+juNz/S9PQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkhd1iZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAB0C433F1;
	Tue, 27 Feb 2024 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709055568;
	bh=4lIrLbA2e0AWKuLo9IgLJsmE+6Bg8bKIJsvGgGTTZVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dkhd1iZNaYO+Va0TqWdrMFKDkkD/XQKkf3vLF3hKY+58SpzRuSQPLHnB3xBzb+BIB
	 se64ON50z6sgRsX3XH2QlQdb9FqrGTZWfGRYatnYOd6aJ3i6nDzWL4zq2HC0q7Fw7Q
	 OKG8hBVE3E6YJIFUhWUAfwSour3hIh+da21ysg2yYMhMFx9IhhBTlMK2+JwASbIQ3g
	 nRohXQ/jihsgMXhUPDTiYrClSQ0lI8rWZ+6zuZUHJZfKcfKCqbzqTXnoBcJSOdCki2
	 PaUg5C10MIkxn5kch3PpwhGM8eZD4aay+JmZK2DEuiIx8iIsNvIrpzw0W3NpL3W/to
	 HAbh659zfRpRQ==
Date: Tue, 27 Feb 2024 11:39:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Message-ID: <20240227173926.GA242161@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024022706-kindle-tapering-5f66@gregkh>

On Tue, Feb 27, 2024 at 06:24:38PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 27, 2024 at 09:07:44AM -0600, Bjorn Helgaas wrote:
> > [+cc Mika, author of 09cc90063240]
> > 
> > On Tue, Feb 27, 2024 at 02:26:26PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 27, 2024 at 02:18:51PM +0100, Carlos López wrote:
> > > > On 25/2/24 9:16, Greg Kroah-Hartman wrote:
> > > > > There is no actual issue right now because we have another check
> > > > > afterwards and the out-of-bounds read is not being performed. In
> > > > > any case it's better code with this fixed, hence the proposed
> > > > > change.
> > > > 
> > > > Given that there is no actual security issue this looks more like a
> > > > hardening, and thus not deserving of a CVE, no?
> > > 
> > > This was a tricky one, I think it's needed as we do not know how people
> > > are really using these macros, right?  If the PCI maintainer agrees (on
> > > the cc:), I'll be glad to revoke it, it's their call.
> > 
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
> 
> So let's keep this as a CVE unless someone really doesn't want it marked
> as such.  Again, it is a "weakness that is fixed" in the kernel, and
> because of that, a CVE can be allocated for it.

Sounds good, I'm happy to have it as a CVE.  Thanks for the
speculation details; I'm certainly not an expert on that.

Bjorn

