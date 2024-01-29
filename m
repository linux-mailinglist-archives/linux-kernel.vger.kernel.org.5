Return-Path: <linux-kernel+bounces-43540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D98A841549
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5373F286D32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D529159560;
	Mon, 29 Jan 2024 21:57:10 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DB158D68;
	Mon, 29 Jan 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565430; cv=none; b=hOP0TOWVYq8fMBYN9/3grTxKeu5ylgHaAZ1SVQXRL3BUF67GQRjNRhuxlpEv67k4WkHtMvzjGPyDDvXnoXoEIDBT9gm9W9ZcTbzqo8G9iakQREregx1z4U4HUhVb0TbqRqjSfq91oKqD4wl9zLgl3Erf/KV+atX+OcsoaC6FWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565430; c=relaxed/simple;
	bh=mPC+xQ4Dz5ztfF5Vr0v6InEG2owUyBpyLFQaFv8aEG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWpWTJ0jl4aJQf8MOXrAJeoivQPtG5f3Zoo2l/lkozA8dIteUS5fde6NlG17YG4MNTGfs+crcmToPc7Xa/eFbWqAF48+62XNioEtOgyflBNFDUfwFU/vCp+3B1P4aQQXGFn5XKLtGJnlf6pXPk8mXgDkKnlj5w9LRa4+tso0+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 8161E1402F9; Mon, 29 Jan 2024 22:57:04 +0100 (CET)
Date: Mon, 29 Jan 2024 22:57:04 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: typec_altmode_release =?utf-8?B?4oaS?=
 =?utf-8?Q?_refcount=5Ft=3A?= underflow; use-after-free.
Message-ID: <ZbgfMEmpsuzLc1Hv@cae.in-ulm.de>
References: <e12b5e52-1c94-472d-949b-2ee158857584@molgen.mpg.de>
 <Zbf3M2+r5RP9K8jJ@cae.in-ulm.de>
 <b1f77ee7-0684-4260-bcaf-d826af19978d@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1f77ee7-0684-4260-bcaf-d826af19978d@molgen.mpg.de>


Hi Paul,

On Mon, Jan 29, 2024 at 10:27:44PM +0100, Paul Menzel wrote:
> Dear Christian,
> 
> 
> Am 29.01.24 um 20:06 schrieb Christian A. Ehrhardt:
> 
> > On Mon, Jan 29, 2024 at 12:57:11PM +0100, Paul Menzel wrote:
> 
> > > I noticed the message first time with Linux 6.6.8 on December 26th, and also
> > > with 6.6.11, 6.7 and 6.7.1. I am unsure how to reproduce it though.
> > > 
> > > Here the trace from Linux 6.7.1-1~exp1:
> > > 
> > > ```
> > > [    0.000000] Linux version 6.7-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-13 (Debian 13.2.0-10) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.90.20240115) #1 SMP PREEMPT_DYNAMIC Debian 6.7.1-1~exp1 (2024-01-22)
> > > […]
> > > [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> > > […]
> > > [ 9068.294345] ucsi_acpi USBC000:00: failed to re-enable notifications (-110)
> > > [ 9068.499156] ------------[ cut here ]------------
> > > [ 9068.499172] refcount_t: underflow; use-after-free.
> > > [ 9068.499199] WARNING: CPU: 0 PID: 5598 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
> 
> […]
> > > [ 9068.499517] Call Trace:
> > > [ 9068.499521]  <TASK>
> > > [ 9068.499522]  ? refcount_warn_saturate+0xbe/0x110
> > > [ 9068.499526]  ? __warn+0x81/0x130
> > > [ 9068.499533]  ? refcount_warn_saturate+0xbe/0x110
> > > [ 9068.499545]  ? report_bug+0x171/0x1a0
> > > [ 9068.499549]  ? console_unlock+0x78/0x120
> > > [ 9068.499553]  ? handle_bug+0x3c/0x80
> > > [ 9068.499557]  ? exc_invalid_op+0x17/0x70
> > > [ 9068.499565]  ? asm_exc_invalid_op+0x1a/0x20
> > > [ 9068.499570]  ? refcount_warn_saturate+0xbe/0x110
> > > [ 9068.499576]  typec_altmode_release+0x49/0xc0 [typec]
> > > [ 9068.499615]  device_release+0x34/0x90
> > > [ 9068.499624]  kobject_put+0x78/0x190
> > > [ 9068.499629]  ucsi_unregister_altmodes+0x41/0xa0 [typec_ucsi]
> > > [ 9068.499648]  ucsi_unregister_partner.part.0+0x77/0xa0 [typec_ucsi]
> > > [ 9068.499662]  ucsi_handle_connector_change+0x1bb/0x310 [typec_ucsi]
> > > [ 9068.499671]  process_one_work+0x171/0x340
> > > [ 9068.499676]  worker_thread+0x27b/0x3a0
> > > [ 9068.499679]  ? __pfx_worker_thread+0x10/0x10
> > > [ 9068.499681]  kthread+0xe5/0x120
> > > [ 9068.499690]  ? __pfx_kthread+0x10/0x10
> > > [ 9068.499693]  ret_from_fork+0x31/0x50
> > > [ 9068.499698]  ? __pfx_kthread+0x10/0x10
> > > [ 9068.499700]  ret_from_fork_asm+0x1b/0x30
> > > [ 9068.499714]  </TASK>
> > > [ 9068.499715] ---[ end trace 0000000000000000 ]---
> > > ```
> > > 
> > > Please find the full output of `dmesg` attached.
> > 
> > This should be fixed by
> > 
> > | commit 5962ded777d689cd8bf04454273e32228d7fb71f
> > | Author: RD Babiera <rdbabiera@google.com>
> > | Date:   Wed Jan 3 18:17:55 2024 +0000
> > |
> > |     usb: typec: class: fix typec_altmode_put_partner to put plugs
> > 
> > which is in mainline and 6.7.2.
> 
> Awesome. Thank you for mentioning this, and nice timing, as the commit
> referenced in the Fixed-by tag is from v4.19-rc1 from August 2018. ;-)

A first attempt to fix that 2018 commit made it into 6.7 and caused
the regression and the warning (b17b7fe6dd5c). This commit was then
reverted (9c6b789e954f). The final fix (5962ded777d6) is a new
version of the reverted fix that does not cause regressions.

The Fixes: tag for the revert does point into the post 6.7 range.

    regards  Christian


