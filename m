Return-Path: <linux-kernel+bounces-127877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62F1895224
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C8F1F24762
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A769979;
	Tue,  2 Apr 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="keTjQP/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B71EA8D;
	Tue,  2 Apr 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058257; cv=none; b=fGzAEjT/u+RPHqPBMtIEY7Ee7iriLqe/fFkjtjPmFTfufx119PIRXsIAZSoqgb5CHkkUMs+HrMJHYf4790+/80RjQexYqp3xh30yKuc6eiIZQG/Vlh4QCJxlUCr0xK3wipuj76jcnhSEXFHZSbgbHzYtUDFwTWDeL3tbTyv924k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058257; c=relaxed/simple;
	bh=DpQ1x3R3SARZhczID3H+l6QkUcoWZQNWBI3Aop4zjd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr5tSKqmxPUA1RAqyWbDvhscOD2twTAjnVq/+8RToSiAMraj0O71OcosxA6/dEVZIDgErECUu3/27D06CddbVaWTC2Huvwh48SzJ0QLe3Skc2EFYFxhIjPWDprHpFFBHHrczQH2n6uk9P8OYyK8Dwu7qzS7qKT89tyytpsjWbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=keTjQP/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A7EC43390;
	Tue,  2 Apr 2024 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712058256;
	bh=DpQ1x3R3SARZhczID3H+l6QkUcoWZQNWBI3Aop4zjd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keTjQP/TuNEFmuDJ/ndqUWVWzKYfOvgfFKfqNN1VFR3mFZpD/bcMF19oRva66l40J
	 TP/WZx/xGTr8svgzpHSpdKh5uRIaL6B1pdxeAPF1TKw+E7yTlclI8Iukm0ycrapwyk
	 tHj9SQQbNxN8roAmHWpZH3e6duGhE77ioZFxRHhk=
Date: Tue, 2 Apr 2024 13:44:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alexander Wetzel <alexander@wetzel-home.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
Message-ID: <2024040258-disk-smokiness-5baf@gregkh>
References: <20240401152547.867452742@linuxfoundation.org>
 <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
 <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
 <1d1071f3-641a-4b7c-bd35-a629ba8d5a7b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1071f3-641a-4b7c-bd35-a629ba8d5a7b@moroto.mountain>

On Tue, Apr 02, 2024 at 01:37:50PM +0300, Dan Carpenter wrote:
> On Mon, Apr 01, 2024 at 09:22:52PM +0200, Alexander Wetzel wrote:
> > 
> > > Following kernel warnings have been noticed on qemu-x86_64 while running LTP
> > > cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
> > > 6.8.3-rc1.
> > > 
> > > We have started bi-secting this issue.
> > > Always reproduced.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
> > > ------------[ cut here ]------------
> > > [   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
> > > sg_remove_sfp_usercontext+0x145/0x150
> > > [   36.609445] Modules linked in:
> > > [   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
> > > [   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > > BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > [   36.612872] Workqueue: events sg_remove_sfp_usercontext
> > > [   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150
> > > 
> > > <trim>
> > > 
> > > [   36.621539] Call Trace:
> > > [   36.621953]  <TASK>
> > > [   36.622444]  ? show_regs+0x69/0x80
> > > [   36.622819]  ? __warn+0x8d/0x150
> > > [   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
> > > [   36.623558]  ? report_bug+0x171/0x1a0
> > > [   36.623881]  ? handle_bug+0x42/0x80
> > > [   36.624070]  ? exc_invalid_op+0x1c/0x70
> > > [   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
> > > [   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
> > > [   36.625408]  process_one_work+0x141/0x300
> > > [   36.625769]  worker_thread+0x2f6/0x430
> > > [   36.626073]  ? __pfx_worker_thread+0x10/0x10
> > > [   36.626529]  kthread+0x105/0x140
> > > [   36.626778]  ? __pfx_kthread+0x10/0x10
> > > [   36.627059]  ret_from_fork+0x41/0x60
> > > [   36.627441]  ? __pfx_kthread+0x10/0x10
> > > [   36.627735]  ret_from_fork_asm+0x1b/0x30
> > > [   36.628293]  </TASK>
> > > [   36.628604] ---[ end trace 0000000000000000 ]---
> > > ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked
> > > 
> > > Suspecting commit:
> > > -----
> > > scsi: sg: Avoid sg device teardown race
> > > commit 27f58c04a8f438078583041468ec60597841284d upstream.
> > > 
> > 
> > Correct. The issue is already been worked on.
> > 
> > commit 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race") fixed a real
> > issue. But also added an incorrect WARN_ON_ONCE(). Thus the scary - but
> > otherwise harmless - error message.
> 
> If you have Reboot on Oops turned on (apparently Android enables this)
> then WARN() will reboot the system so it can be pretty annoying.

Agreed, I've dropped this stable change for now because of this.

greg k-h

