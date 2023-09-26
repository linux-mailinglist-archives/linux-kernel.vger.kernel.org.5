Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164ED7AE3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjIZC22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIZC20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:28:26 -0400
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB36BF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:28:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695695298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24R2pLWXym7jBk3gQ8do08nmij8cuCrMpT9bPlzajlk=;
        b=TEhoScQTWSZIipzs1D9pe1uyEHGfcmmtCj9ptoytsHPVwo6AiBuhJ1JR95a+JRUOSoFjS/
        gHwT0E6TXXEd3Eln8SKeOPWdcqYTdIgFO/3Hicn4e6PpFMPb+a2x56VusG6YNCKPiU5YH1
        wBmnoWDIzOB7cfm/8tl1kRC22cJrXAM=
Mime-Version: 1.0
Subject: Re: [PATCH v6 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230925234837.86786-5-mike.kravetz@oracle.com>
Date:   Tue, 26 Sep 2023 10:27:39 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7DF23E7C-F039-44F4-8204-BA463534B09F@linux.dev>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
 <20230925234837.86786-5-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2023, at 07:48, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> The routine update_and_free_pages_bulk already performs vmemmap
> restoration on the list of hugetlb pages in a separate step.  In
> preparation for more functionality to be added in this step, create a
> new routine hugetlb_vmemmap_restore_folios() that will restore
> vmemmap for a list of folios.
> 
> This new routine must provide sufficient feedback about errors and
> actual restoration performed so that update_and_free_pages_bulk can
> perform optimally.
> 
> Special care must be taken when encountering an error from
> hugetlb_vmemmap_restore_folios.  We want to continue making as much
> forward progress as possible.  A new routine bulk_vmemmap_restore_error
> handles this specific situation.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks for your continue working on this.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


