Return-Path: <linux-kernel+bounces-148671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBCE8A85E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90142834B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4499F1411FF;
	Wed, 17 Apr 2024 14:23:55 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CAAA352F86
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363834; cv=none; b=KiJskKQtsru4U+jZBKHGYHfSM7h3PDXXKys2mxWI3WJEXdimmiDyrKoU4M+cidgBPVX3FukfCZGRFr9tFGwT6VRnNuThFJiWl5dmGNv8YgvukP2hN4bzugbvKchdTXlxPJ88L7BFul6eeOWi/2YsV5poOJyPlhrBy6IsAMwUmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363834; c=relaxed/simple;
	bh=cxUQhRnqHadkF6BkpNtuin2PtIpnIK0xeBndPTSzJT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBthdGfjaz3g9iEaor5pzwyTstuV5qqaRSZ+BLtS4YN+vNf1Xz7ASsOA0oe1B1/7VCLSjlue+0LGvKxt+oMCamSekUJE+HerRYspfo3+Kw6OqO/Ku9gUzRRDM9HbmzNZvqJfBBvdnzwqB3wBgxMmsYs3+PM3Hxp6gvfSzpGfEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 201056 invoked by uid 1000); 17 Apr 2024 10:23:51 -0400
Date: Wed, 17 Apr 2024 10:23:51 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org,
  ricardo@marliere.net, hkallweit1@gmail.com, heikki.krogerus@linux.intel.com,
  mathias.nyman@linux.intel.com, royluo@google.com,
  syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] general protection fault in disable_store
Message-ID: <de997acf-300a-4592-87c5-024171d19c29@rowland.harvard.edu>
References: <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
 <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
 <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>
 <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
 <CAEkJfYNJyyGhR9AAWc0V7o8i6pmS+OB=KSbh6XqVWAAGetS9hA@mail.gmail.com>
 <5704ac63-5e5b-416c-a2a1-57528e76a02f@rowland.harvard.edu>
 <CAEkJfYMSwuikpBJudOaFYrxgf9e=_O4nig6sTPLLAtpdEKQuyQ@mail.gmail.com>
 <5f3526a6-6ede-4181-a4ff-076e022cfb49@rowland.harvard.edu>
 <CAEkJfYMPQJn+kYzxFwwix3fwKeu3aAdYKgp+Ksvq=o4CoTXEWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkJfYMPQJn+kYzxFwwix3fwKeu3aAdYKgp+Ksvq=o4CoTXEWQ@mail.gmail.com>

On Wed, Apr 17, 2024 at 03:39:02PM +0800, Sam Sun wrote:
> On Wed, Apr 17, 2024 at 12:35 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > It turns out that patch is no good.  The reason is mentioned in the
> > changelog for commit 543d7784b07f ("USB: fix race between hub_disconnect
> > and recursively_mark_NOTATTACHED"); it says that the port devices have to
> > be removed _after_ maxchild has been set to 0.
> >
> 
> I checked the commit you mentioned. Maybe your first fix is all we
> need to fix the problem? At least no race would occur for
> hdev->maxchild and usb_set_intfdata().

No, the first patch won't help, even though it passed your testing.  The 
race it eliminates is a harmless one -- or at least, it's harmless in 
this context.  If usb_hub_to_struct_hub() sees bad values for 
hdev->maxchild or usb_get_intfdata(), it will simply return NULL.  But 
this can happen even with the first patch applied, if the user tries to 
access disable_store() during the brief time between when hdev->maxchild 
is set to 0 and when the port devices are removed.

The true fix is simply to check whether the return value from 
usb_hub_to_struct_hub() is NULL, which is what this patch does.

> I applied this patch and it also can fix the warning. I am not sure
> which one is better.

I'm quite sure that this one is better.  I will submit it shortly, with 
your Tested-by:.

Thanks a lot; the work you have done on this has been a big help.

Alan Stern

