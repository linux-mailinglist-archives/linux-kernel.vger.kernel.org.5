Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADBB7A715D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjITD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjITD6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:58:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A5DF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A1BPMwH2UDIlMDkUUSRsazWTjzTwQxn28F0/xEN7Fd4=; b=swRfjP1TPecEPIMAREeGgZUpCV
        gyR9XRsySpjeM4V6BJvBRG2OpeK6665cqxzP2t59HDLQ4KawzavOowyjJVBtf+HuZ0ijua423WLzF
        SbDyI8V1NzhvMSjyD2HCWnEYr18f3vzWkCL/Tu/x9m+VhA/rcg+sXuJrkspvNuhvPBDNBiFQkW5eC
        PUa3IH/XU+OQC25+8qO5IzX/3JQ9b2IHHwgpDkZqvlLjt49Jzzbte8o6HQwxQCmqH6yY/CEQkA+S3
        xHbUsbfwH1vCG22QG69ZrBp4NFP8L/JxgpQbtwtw0pUE33jYQCEYj+LaGc92BjHt/L42kLS+NLqZk
        oK3dPDpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qioLF-003aQw-7D; Wed, 20 Sep 2023 03:57:33 +0000
Date:   Wed, 20 Sep 2023 04:57:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, leit@meta.com
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <ZQptrdK69wvJ2NXP@casper.infradead.org>
References: <20230920021811.3095089-1-riel@surriel.com>
 <20230920021811.3095089-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920021811.3095089-2-riel@surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:16:09PM -0400, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Extend the locking scheme used to protect shared hugetlb mappings
> from truncate vs page fault races, in order to protect private
> hugetlb mappings (with resv_map) against MADV_DONTNEED.
> 
> Add a read-write semaphore to the resv_map data structure, and
> use that from the hugetlb_vma_(un)lock_* functions, in preparation
> for closing the race between MADV_DONTNEED and page faults.

This feels an awful lot like the invalidate_lock in struct address_space
which was recently added by Jan Kara.
