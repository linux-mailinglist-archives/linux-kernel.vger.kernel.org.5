Return-Path: <linux-kernel+bounces-9115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC981C0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E511285EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E877F10;
	Thu, 21 Dec 2023 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1GRPxZ7b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD727763A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFDAC433C7;
	Thu, 21 Dec 2023 22:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703196504;
	bh=GZnak5fMCSFehBPFlJ9iudVAVRz/t843L8EYKs7DzGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1GRPxZ7b311HpzBeZf2P8zlj7pnwlHOqjK2zu2QKRZjC9gpFum5xJ/h47c6/G6vDT
	 l4RviXTke0ZLEiff7cmrFFjI/vggofwRA/5gc8soFea3DHyKRDVyHExh5iT3FQFHAa
	 xeRN/bW7u1lOpatORbe9ptWfl52eRqxDsj+nGJTk=
Date: Thu, 21 Dec 2023 14:08:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiajun Xie <jiajun.xie.sh@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: fix unmap_mapping_range high bits shift bug
Message-Id: <20231221140823.2908189514c0081ae9efbda8@linux-foundation.org>
In-Reply-To: <CADOw95fss1AY_xuQV+4iOLZOA0ofYAaK7uCJHPiuVVLZDZBa6A@mail.gmail.com>
References: <20231220052839.26970-1-jiajun.xie.sh@gmail.com>
	<20231220095343.326584f605e8ce995ac151d0@linux-foundation.org>
	<CADOw95fss1AY_xuQV+4iOLZOA0ofYAaK7uCJHPiuVVLZDZBa6A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 13:40:11 +0800 Jiajun Xie <jiajun.xie.sh@gmail.com> wrote:

> > (obviously bad, but it's good to spell it out) and under what
> > circumstances it occurs?
> 
> Thanks for the quick reply.
> 
> The issue happens in Heterogeneous computing, where the
> device(e.g. gpu) and host share the same virtual address space.
> 
> A simple workflow pattern which hit the issue is:
>         /* host */
>     1. userspace first mmap a file backed VA range with specified offset.
>                         e.g. (offset=0x800..., mmap return: va_a)
>     2. write some data to the corresponding sys page
>                          e.g. (va_a = 0xAABB)
>         /* device */
>     3. gpu workload touches VA, triggers gpu fault and notify the host.
>         /* host */
>     4. reviced gpu fault notification, then it will:
>             4.1 unmap host pages and also takes care of cpu tlb
>                   (use unmap_mapping_range with offset=0x800...)
>             4.2 migrate sys page to device
>             4.3 setup device page table and resolve device fault.
>         /* device */
>     5. gpu workload continued, it accessed va_a and got 0xAABB.
>     6. gpu workload continued, it wrote 0xBBCC to va_a.
>         /* host */
>     7. userspace access va_a, as expected, it will:
>             7.1 trigger cpu vm fault.
>             7.2 driver handling fault to migrate gpu local page to host.
>     8. userspace then could correctly get 0xBBCC from va_a
>     9. done
> 
> But in step 4.1, if we hitted the bug this patch mentioned, then user space
> would never trigger cpu fault, and still get the old value: 0xAABB.

Thanks.  Based on the above, I added cc:stable to the changelog so the
fix will be backported into earlier kernels (it looks like that's 20+
years worth!).  And I pasted the above text into that changelog.


