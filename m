Return-Path: <linux-kernel+bounces-160590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746D8B3FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0981C21545
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371B4BE55;
	Fri, 26 Apr 2024 19:00:04 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D188C04
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158003; cv=none; b=QEJSYoCBfmGvE4Qol6grLTJwRaoNCAt+RfBYQBHmFXrvn3ZnQEr5Mb+IQpDwN9q2+J7MzAftP04GoliZdyfweSXO26xAh2b+qnq+fR9TbXrf4OWGcXAOWJSJPiBrVT9+y09o6+ytsDDtewYJC0wo7jIm8omTWFrSNTBLzH/Epv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158003; c=relaxed/simple;
	bh=8Ox2+l5MR9tOdPVsRQBBlGlqk5HKgQkld0q9gnMi/B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpA9ly699eiocJRIzrIimG0gRXCaRKe+VxtYfl1i/iKuN06qDSK6nilE6BUhFdrTdPGldejELEF24o/WQCdq5x4uWmvWK7bFuBCURdkwFOgSVeJtNg7hu2On7JVKm9dTc4DEJNnx4AAQ0qoIrB940wUt/mXeVJLVLA2mqCNd5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id AA44F300608BF;
	Fri, 26 Apr 2024 20:59:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7B5DE1EC32D; Fri, 26 Apr 2024 20:59:51 +0200 (CEST)
Date: Fri, 26 Apr 2024 20:59:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] sysfs: Allow bin_attributes to be added to groups
Message-ID: <Ziv5p3SMEIw3XZkK@wunner.de>
References: <e140f6bf8dc99c24cc387f7ac3c7908c8830587f.1714030457.git.lukas@wunner.de>
 <662be72549aaf_db82d294c7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <662be72549aaf_db82d294c7@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Apr 26, 2024 at 10:40:53AM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > Commit dfa87c824a9a ("sysfs: allow attributes to be added to groups")
> > introduced dynamic addition of sysfs attributes to groups.
> > 
> > Allow the same for bin_attributes, in support of a forthcoming commit
> > which adds various bin_attributes every time a PCI device is
> > authenticated.
> > 
> > Addition of bin_attributes to groups differs from regular attributes in
> > that different kernfs_ops are selected by sysfs_add_bin_file_mode_ns()
> > vis-à-vis sysfs_add_file_mode_ns().
> > 
> > So call either of those two functions from sysfs_add_file_to_group()
> > based on an additional boolean parameter and add two wrapper functions,
> > one for bin_attributes and another for regular attributes.
> > 
> > Removal of bin_attributes from groups does not require a differentiation
> > for bin_attributes and can use the same code path as regular attributes.
> > 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > ---
> > Submitting this ahead of my PCI device authentication v2 patches.
> > Not sure if the patch is acceptable without an accompanying user,
> > but even if it's not, perhaps someone has early review feedback
> > or wants to provide an Acked-by?  Thank you!
> 
> On the one hand it makes sense from a symmetry perspective, on the other
> hand the expectation and the infrastructure for dynamic sysfs visibilty
> has increased since 2007.
> 
> That is why I would like to see the use case to understand why a
> dynamically added a bin_attribute is needed compared with a statically
> defined attribute with dynamic visibility.

I assume "would like to see" means "on the mailing list", which would
(or will) be as part of the PCI device authentication v2 patches.

But in case you're curious, the use case is the log of signatures
presented by the device.  Each signature is exposed as a bin_attribute
in a signatures/ directory below a PCI device's sysfs directory,
for verification by a remote attester (or user space in general).

Here's the code:

https://github.com/l1k/linux/commit/ca420b22af05

The signature's bin_attribute is accompanied by several other
bin_attributes containing ancillary data, such as nonces
(to allow user space to ascertain that a fresh nonce has been used).

The signatures/ directory is an empty attribute group to which the
signatures received from the device are dynamically added using
sysfs_add_bin_file_to_group() (introduced by the present patch).

All of that was done to address an objection raised by James Bottomley
at Plumbers that it is "not good enough" if the kernel keeps the
challenge-response received from the device to itself and doesn't
allow a remote attester to verify it.

Here is the recording, in his own words:

https://www.youtube.com/watch?v=ZqMIlZ5lPAw&t=2345s

A static attribute with dynamic visibility doesn't cut it in this case:

Each signature needs a unique filename and the number of signatures
that can be generated is essentially unlimited.  (Though older ones
are likely uninteresting and can be culled.)  If you want to expose,
say, up to 1000 signatures per device, you'd have to allocate an array
of 1000 signatures (for each device!), even though the actual number
of signatures received might be much lower.  It would be a waste of
memory.  It is much more economical to add signature attributes
dynamically on demand.

It has the additional benefit that it allows user space to dynamically
adjust the maximum number of signatures retained in the log.
That's more difficult to implement with static attributes, as you'd
have to reallocate the attributes array and adjust all the pointers
pointing to it.

Thanks,

Lukas

