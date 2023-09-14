Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947979F858
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjINCqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjINCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:46:32 -0400
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E1110C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:46:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694659587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNlmK8sw6xG6QY0l/2V8zfE7G5CNskIjBLsl+kdEZH8=;
        b=oVWKTsKacC7sYnt07p2aSlF8q+bWgEwEBN6sdSowILDAjUOlAn15t283+jwi8RghilJxgI
        gh62f0J6KAFluqC7I1Hf3fGTgD0pKYnkV7IpemQ8yKRCTYLOzEEVysLGHEf/I7kr92kq84
        iP4OjlwuJ0XyPhx7XMaDRqEnWbG5nEA=
Mime-Version: 1.0
Subject: Re: [v5 4/4] mm: hugetlb: Skip initialization of gigantic tail struct
 pages if freed by HVO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230913105401.519709-5-usama.arif@bytedance.com>
Date:   Thu, 14 Sep 2023 10:45:38 +0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <53B87FC1-5854-4E54-B28F-C13D3EA662C3@linux.dev>
References: <20230913105401.519709-1-usama.arif@bytedance.com>
 <20230913105401.519709-5-usama.arif@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 13, 2023, at 18:54, Usama Arif <usama.arif@bytedance.com> =
wrote:
>=20
> The new boot flow when it comes to initialization of gigantic pages
> is as follows:
> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> the region after the first struct page is marked as noinit.
> - This results in only the first struct page to be
> initialized in reserve_bootmem_region. As the tail struct pages are
> not initialized at this point, there can be a significant saving
> in boot time if HVO succeeds later on.
> - Later on in the boot, the head page is prepped and the first
> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct =
pages
> are initialized.
> - HVO is attempted. If it is not successful, then the rest of the
> tail struct pages are initialized. If it is successful, no more
> tail struct pages need to be initialized saving significant boot time.
>=20
> The WARN_ON for increased ref count in gather_bootmem_prealloc was =
changed
> to a VM_BUG_ON.  This is OK as there should be no speculative =
references
> this early in boot process. The VM_BUG_ON's are there just in case =
such code
> is introduced.
>=20
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks for your work.

