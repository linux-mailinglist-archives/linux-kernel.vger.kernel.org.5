Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170E9784845
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjHVRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHVRPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:15:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9330D4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EC2X8oKwCSIWlwpcBI3Hrnd8qPKLnaGSiKpmv5+mejQ=; b=VFZT8UUEY5ekfYzupBEvDwNFWE
        oOV4V8iSR4D5FdkaM3daPBzA79z+P5ex/ur/JgPe2bOHMvfOZMbMaNyCI7oOxCNSWkaLlcKmIVNK8
        uS8xmTawDmXMcewmwmHhE/sQQg8cpFwFgcbwX0MCOxztXZfJ8wmYWmb6DLZV5x+Bg0ekQ13otCI1G
        1Ak6NBmGRRQUj3AoZac9DIZgwtyKkbiES2EW3SNPzbl5omS12iD4rEP1lNFlMRWyrYqy3raMRQiZ3
        3J3CcyeHYC2qSp62BDO20mRhfBGQzxM+6cOUoKd/DjDFj9Zh+ag0lNjhNuOF7ssbjMVhBt2iM6DqA
        vaUI9PJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYUyS-00HXc6-0b; Tue, 22 Aug 2023 17:15:24 +0000
Date:   Tue, 22 Aug 2023 18:15:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
Message-ID: <ZOTtK1Kfa5gCS3Gb@casper.infradead.org>
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:18:36AM -0700, Sidhartha Kumar wrote:
> @@ -890,8 +867,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
>  					unsigned long address)
>  {
>  	pgoff_t pgoff;
> -	if (unlikely(is_vm_hugetlb_page(vma)))
> -		return linear_hugepage_index(vma, address);
>  	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
>  	pgoff += vma->vm_pgoff;
>  	return pgoff;

This is the last use of linear_hugepage_index(), so please remove the
function and its declaration too.
