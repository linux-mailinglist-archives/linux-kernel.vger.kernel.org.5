Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872D7B53B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbjJBNNx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:13:52 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C493
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:13:49 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qnIjv-00088s-2O;
        Mon, 02 Oct 2023 09:13:35 -0400
Message-ID: <5c6c554ad749531826e71083f56cde90f336942a.camel@surriel.com>
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and
 page fault
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Date:   Mon, 02 Oct 2023 09:13:35 -0400
In-Reply-To: <20231002043958.GB11194@monkey>
References: <20231001005659.2185316-1-riel@surriel.com>
         <20231001005659.2185316-3-riel@surriel.com> <20231002043958.GB11194@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-01 at 21:39 -0700, Mike Kravetz wrote:
> 
> Looks like vma->vm_file is NULL and __hugetlb_zap_begin is trying to
> do
> i_mmap_lock_write(vma->vm_file->f_mapping).
> 
> Guess I did look closely. :)

Ugh. It looks like the fix for this bug ended up getting pulled
into patch 3, instead of patch 2.  I've had it in my code for a
while now :/

Let me move the fix for this thing into patch 2.

void __hugetlb_zap_begin(struct vm_area_struct *vma,
                         unsigned long *start, unsigned long *end)
{
        adjust_range_if_pmd_sharing_possible(vma, start, end);
        hugetlb_vma_lock_write(vma);
        if (vma->vm_file)
                i_mmap_lock_write(vma->vm_file->f_mapping);
}


-- 
All Rights Reversed.
