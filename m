Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7831B7F6C25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbjKXGIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjKXGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:07:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ECA2D43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 22:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ar1rwHdCl3y9JDD69vl8bkIGheNCwRo/KQtZMmsfIVw=; b=tgCUAqVV4FyohYEzujI8LM3j60
        5bF1S9Mzx38eyly9faACv0hev+BJbvED2RRb8L9CNQJVSsDkpQz9JoSsjb8ab+j4Q6pc7d89mewiy
        1bvNsT5hRjfhMycqYw84PA3iLQ9KtZXjkvo1YjaQWc+Ucwvd5vHPFPLxcOKCZH2qbfgwLonGKt7FF
        vr94dromewT5LykLJvWt5j+iWC+rRfVjv3uUf4XcOxx9bYtvPMr7wFvZl5Z/XCmDjHcjPOEIHtaf+
        xTdvBspyHYZEX7eTr4WR0yjp2hi80dtfMYsriMEAUi2FSUYM1t6AK8pIvnlRXvCZI+9ELhPcAjVN2
        +RzGdp/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6PJJ-008Gcb-3y; Fri, 24 Nov 2023 06:05:05 +0000
Date:   Fri, 24 Nov 2023 06:05:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, fengwei.yin@intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, hughd@google.com, david@redhat.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Message-ID: <ZWA9EVlsuHIBi0xb@casper.infradead.org>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122140052.4092083-1-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:00:52PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
> in application, which leading to an unexpected performance issue[1].
> 
> This caused by temporarily cleared pte during a read/modify/write update
> of the pte, eg, do_numa_page()/change_pte_range().

What I haven't quite understood yet is why we need to set the pte to
zero on x86 in the specific case of do_numa_page().  I understand that
ppc needs to.

Could someone explain why the _default_ definition of
ptep_modify_prot_start() is not:

+++ b/include/linux/pgtable.h
@@ -1074,7 +1074,7 @@ static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
                                           unsigned long addr,
                                           pte_t *ptep)
 {
-       return __ptep_modify_prot_start(vma, addr, ptep);
+       return *ptep;
 }

 /*

