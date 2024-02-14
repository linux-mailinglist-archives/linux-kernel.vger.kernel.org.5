Return-Path: <linux-kernel+bounces-65408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD27854C84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9831F29CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E675D729;
	Wed, 14 Feb 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2hEG41fZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC65D471;
	Wed, 14 Feb 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923980; cv=none; b=NfMo+HPHtXuL7wM7HpYYHtyur0dbEW7xKU2yglqwVh37G8OFRvhJg+PUJ1V0WgZa7XtLabOBv96ZGbu2/etOeX7ii5IQfS49uu9IQc/ItPuZVPpp3DhJGBDY+mPrD0jVR8cgheJV3OSmfljaV2fNJkxHy/THg1cGzRocDViGS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923980; c=relaxed/simple;
	bh=rZnMjB7GTkAm89uF/LbKJcHyP/SinVsqT/qoZ+4bkGU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TPKjdCPU0kAK12/sTvGccUGgtpF1goq4+LVz3v9BPPplPw4+HaQC0gU/e28UXZrGnwe/dlXZzAQ/aBiuja/zRPnx/dR/ddn/0ZL+UjGnZ4yOn3zUNsmxMKFyiBGJCC7+YyDXY4sfmZLc0qvowFFOfTJSGEKkAINwK4MA9YdTAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2hEG41fZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AFFC433C7;
	Wed, 14 Feb 2024 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707923979;
	bh=rZnMjB7GTkAm89uF/LbKJcHyP/SinVsqT/qoZ+4bkGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2hEG41fZ3VNDsyykWpeUdthDACFf9OegnoOKsk+a+NIDZ5yW/Zvj8Ra9RJRJgidco
	 hrpdaWN5EeHcHM/q8FlVQz+2MXmHBPgIR4ivW4zXWihWaiBSBaKZXQAu/MZU+65Kyw
	 5Azr31P4/P6s1NF40XUftLHkQMP2dMqjeD6Ic7bc=
Date: Wed, 14 Feb 2024 07:19:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Oscar Salvador <osalvador@suse.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20240214071938.f8ca072c08e618b483bae1c7@linux-foundation.org>
In-Reply-To: <20240214145719.1cc4f320@canb.auug.org.au>
References: <20240214145719.1cc4f320@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 14:57:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the mm tree, today's linux-next build (sparc defconfig)
> failed like this:
> 
> In file included from include/linux/page_ext.h:7,
>                  from include/linux/mm.h:22,
>                  from fs/sysfs/file.c:18:
> include/linux/stackdepot.h:59:39: error: 'CONFIG_STACKDEPOT_MAX_FRAMES' undeclared here (not in a function)
>    59 |                 unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /* Frames */
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> (and many more)
> 
> Caused by commit
> 
>   18d4230bb372 ("lib/stackdepot: move stack_record struct definition into the header")

Thanks, I'll try this.


--- a/include/linux/stackdepot.h~lib-stackdepot-move-stack_record-struct-definition-into-the-header-fix
+++ a/include/linux/stackdepot.h
@@ -39,6 +39,7 @@ typedef u32 depot_stack_handle_t;
 #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
 			       STACK_DEPOT_EXTRA_BITS)
 
+#ifdef CONFIG_STACKDEPOT
 /* Compact structure that stores a reference to a stack. */
 union handle_parts {
 	depot_stack_handle_t handle;
@@ -73,6 +74,7 @@ struct stack_record {
 		};
 	};
 };
+#endif
 
 typedef u32 depot_flags_t;
 
_


