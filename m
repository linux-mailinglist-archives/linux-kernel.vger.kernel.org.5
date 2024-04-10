Return-Path: <linux-kernel+bounces-139305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF71E8A012F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E95E1F214D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088A181B88;
	Wed, 10 Apr 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G93U9dw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40311DFC7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780518; cv=none; b=ONnO7SCZJ0INf/eRoIzmXTv4Op37fKT7sejIWEoNYzdpb6RYymIxAjnBfGFNI8Ge4ub4JMInLmbGa4NPXS+H4IrVOO4yf/WqQqulNlY0skGD+JjhpytgBBa4D/mlpS7ZlFiYWLeCV/vneMkGofPeHdU55Rq1nI3rL4XDqE1rqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780518; c=relaxed/simple;
	bh=jUE5hUNDOoO4dkgzMZga08IqaP40DlvL9+dPrYWaDeI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hwVzTlzLDe3FYoXrQWuxu8CibQqGc+xZ3goqEHxWEp0ImwypkeuPbBgm8HhsU5SEcaLQOpRBRtW1w1YwqpXsjuolDklgQ1JCtAIwv/benDpseKGtUxBawHoK5sJq0/EnfXlgBtd3e43ZNFpIuqlWHlX6vn1X9XIDq2rbqfvAVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G93U9dw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF689C433C7;
	Wed, 10 Apr 2024 20:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712780518;
	bh=jUE5hUNDOoO4dkgzMZga08IqaP40DlvL9+dPrYWaDeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G93U9dw3WdFE1Gz1DHEVRE8oFj43IggB+4gmxCTsEnDIw6l1YYubgBjhMYe5X0035
	 3ORwfo6AyHOb3zauNwZCrU5QtDlaBRgotCKTGdPna6HLqcX69OpWMGY0UjFB4vbCWY
	 JfxH8Qn+6ZVNdZqwElhZuI+2c6U2xDbcwLvthUcI=
Date: Wed, 10 Apr 2024 13:21:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <brauner@kernel.org>, <oleg@redhat.com>, <tandersen@netflix.com>,
 <mjguzik@gmail.com>, <willy@infradead.org>, <kent.overstreet@linux.dev>,
 <zhangpeng.00@bytedance.com>, <hca@linux.ibm.com>,
 <mike.kravetz@oracle.com>, <muchun.song@linux.dev>, <thorvald@google.com>,
 <Liam.Howlett@Oracle.com>, <jane.chu@oracle.com>
Subject: Re: [PATCH] fork: defer linking file vma until vma is fully
 initialized
Message-Id: <20240410132157.b0e54f59b066f2c1d322d425@linux-foundation.org>
In-Reply-To: <20240410091441.3539905-1-linmiaohe@huawei.com>
References: <20240410091441.3539905-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 17:14:41 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Thorvald reported a WARNING [1]. And the root cause is below race:
> 
>  CPU 1					CPU 2
>  fork					hugetlbfs_fallocate
>   dup_mmap				 hugetlbfs_punch_hole
>    i_mmap_lock_write(mapping);
>    vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
>    i_mmap_unlock_write(mapping);
>    hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
> 					 i_mmap_lock_write(mapping);
>    					 hugetlb_vmdelete_list
> 					  vma_interval_tree_foreach
> 					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
>    tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
> 					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
> 					 i_mmap_unlock_write(mapping);
> 
> hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
> i_mmap_rwsem lock while vma lock can be used in the same time. Fix this
> by deferring linking file vma until vma is fully initialized. Those vmas
> should be initialized first before they can be used.

Cool.  I queued this in mm-hotfixes (for 6.8-rcX) and I added a cc:stable.

