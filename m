Return-Path: <linux-kernel+bounces-90463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D690186FF91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103F01C2252C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99C8376FD;
	Mon,  4 Mar 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1K40EewO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65820B27;
	Mon,  4 Mar 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549712; cv=none; b=Ow9t3pdhcJi0umAm8Q80EWUzmKyKxjy14gyTo3U5wAezTFk7RAXYaaSXKJbF0CkFy3gJFxso5rxYkan37pX+CTajNLsRYzp3tI+9fqBdjNO2zyoArXRZHCFdM2HJ+O4H1s/toc/MPmEL7kgFLBlJ76YzNwzoCzlozkUUsXEGqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549712; c=relaxed/simple;
	bh=2GTgWYPHRfiketuGiSZ+xc5gpJiISME1rqgrih8dSjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZWKJkAcEgJnHXbQ8qexrP8Ghn919PbjL49T+zRcq0bPAYRjqsoTP5ClhJCjY02BRymUrjUoYp7puV8DLfmRZsp1vh7sySccTwCoDpaXS26cG2tQSRRBeS5gNYduQPENblnlXf+U56PUDWi5b31LRfwobdusdrZwaDRyeMwUBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1K40EewO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57DDC433F1;
	Mon,  4 Mar 2024 10:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709549711;
	bh=2GTgWYPHRfiketuGiSZ+xc5gpJiISME1rqgrih8dSjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1K40EewOqqKhMO09Pwg9iskE4Oi7gH1tdkIbeVGeSlXtJl3ceOsd1OuyfTSyTq3d+
	 8ud6U5hnx518A+gXTwFftpTcUHBUMv4yOX1/gg2FPx3fBzJRAcbmPDRtJ32aY9Eujm
	 9m/i6rtgzgFRQyAFOWVkdbjAgsqtUYEM7NHxiSJ0=
Date: Mon, 4 Mar 2024 11:55:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
	jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
	stable@vger.kernel.org, alexandre.chartre@oracle.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, yuanzhu@bytedance.com
Subject: Re: [PATCH v2 0/3] Support intra-function call validation
Message-ID: <2024030404-conjoined-unlined-05c0@gregkh>
References: <20240228024535.79980-1-qirui.001@bytedance.com>
 <2024030438-dropout-satisfy-b4c4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024030438-dropout-satisfy-b4c4@gregkh>

On Mon, Mar 04, 2024 at 11:41:46AM +0100, Greg KH wrote:
> On Wed, Feb 28, 2024 at 10:45:32AM +0800, Rui Qi wrote:
> > Since kernel version 5.4.217 LTS, there has been an issue with the kernel live patching feature becoming unavailable. 
> > When compiling the sample code for kernel live patching, the following message is displayed when enabled:
> > 
> > livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
> > 
> > Reproduction steps:
> > 1.git checkout v5.4.269 -b v5.4.269
> > 2.make defconfig
> > 3. Set CONFIG_LIVEPATCH=y、CONFIG_SAMPLE_LIVEPATCH=m
> > 4. make -j bzImage
> > 5. make samples/livepatch/livepatch-sample.ko
> > 6. qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage -nographic -append "console=ttyS0" -initrd initrd.img -m 1024M
> > 7. insmod livepatch-sample.ko
> > 
> > Kernel live patch cannot complete successfully.
> > 
> > After some debugging, the immediate cause of the patch failure is an error in stack checking. The logs are as follows:
> > [ 340.974853] livepatch: klp_check_stack: kworker/u256:0:23486 has an unreliable stack
> > [ 340.974858] livepatch: klp_check_stack: kworker/u256:1:23487 has an unreliable stack
> > [ 340.974863] livepatch: klp_check_stack: kworker/u256:2:23488 has an unreliable stack
> > [ 340.974868] livepatch: klp_check_stack: kworker/u256:5:23489 has an unreliable stack
> > [ 340.974872] livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
> > ......
> > 
> > BTW,if you use the v5.4.217 tag for testing, make sure to set CONFIG_RETPOLINE = y and CONFIG_LIVEPATCH = y, and other steps are consistent with v5.4.269
> > 
> > After investigation, The problem is strongly related to the commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool"),
> > which would cause incorrect ORC entries to be generated, and the v5.4.217 version can undo this commit to make kernel livepatch work normally. 
> > It is a back-ported upstream patch with some code adjustments,from the git log, the author also mentioned no intra-function call validation support.
> > 
> > Based on commit 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269), This patchset adds stack validation support for intra-function calls, 
> > allowing the kernel live patching feature to work correctly.
> > 
> > Alexandre Chartre (2):
> >   objtool: is_fentry_call() crashes if call has no destination
> >   objtool: Add support for intra-function calls
> > 
> > Rui Qi (1):
> >   x86/speculation: Support intra-function call validation
> > 
> >  arch/x86/include/asm/nospec-branch.h          |  7 ++
> >  include/linux/frame.h                         | 11 ++++
> >  .../Documentation/stack-validation.txt        |  8 +++
> >  tools/objtool/arch/x86/decode.c               |  6 ++
> >  tools/objtool/check.c                         | 64 +++++++++++++++++--
> >  5 files changed, 91 insertions(+), 5 deletions(-)
> 
> All now queued up, thanks!

Nope, these break the build:

./arch/x86/include/asm/nospec-branch.h:313: Error: no such instruction: `unwind_hint_empty'
./arch/x86/include/asm/nospec-branch.h:313: Error: no such instruction: `unwind_hint_empty'

How did you test them?  I'll go drop them from the queue now, sorry.
Please fix them up and resend when you have something that works.

greg k-h

