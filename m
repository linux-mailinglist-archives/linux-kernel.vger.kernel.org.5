Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD547C5745
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346888AbjJKOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjJKOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:46:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D9A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:46:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32615eaa312so6292189f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697035561; x=1697640361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dEraot6kEamCI8zFvL/bgS9G73k4qnRRb3n2GrA2Hyo=;
        b=dN/4Z+Qc/LycnQMO1sGKk/lMRuwOLVCECwVDFF9r+Yn05n8Ij2LMYRu/fvTI5V+BWT
         rmApiDeYHVkzOPrkj65IIhsKV0vRvaEO4l7uJPGz7y+TdRTXIagMMoVeYlRZ80/RxgI0
         MxIVYDOO9Z7eSVGqs79kZGnpgoZTqhpx1MPo9/+ymg2oLt8RfPQ1trA889q5y8Vj/kFy
         BoOIaaxkd78QNm19nKuc1iY4p1C6g/RHackuSKpQxwDV/ZtNpbc2ETNw9CVKaoylQ60x
         2KmY7858VqTeaDtocDVZxiAZLNSsA48w3DvHZQlus1z4yQDyR9L6GabHyN5mejB3lLLk
         pUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035561; x=1697640361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEraot6kEamCI8zFvL/bgS9G73k4qnRRb3n2GrA2Hyo=;
        b=Tv4HQ5JpklVIeC+RxJ6uLr/KyhIW6z5G74yS+lc28duOjeznjL9heBJED+/uR+UOYe
         YBQVIri4wLwoV3C2VereGRi5J+8606rRklv65hzotUprAVCk/VjgZLL+bxsMC26ru0r5
         qLm0KA/3cKYVq9zKK5FUvOuK97usufGr8BtuDGjCIz9K1lYyE0aAE+UEWacCVOH8znTF
         1NyRkEU3yxFd6Bj9QDcFtD/ViVQp8MPRItK16+bJ8I+6ud+AzHx2fpEreBoR83r29aMS
         +FnZ0ie63J9VKT+8Nd+IgbSLvy3aCzqpOlD9TwN62po6f/ZftfIG0IebCPtthn0zXdPN
         cHQA==
X-Gm-Message-State: AOJu0Yxg29CUsJ0BShs0Fc4srn33eEv4iDlvoRTVKcU2DuS+ep+/r27l
        /jdkgFIa209v0TUPznuuPRJvbQ==
X-Google-Smtp-Source: AGHT+IFEXMJ2OAxzV/GBVlbsgGfkm7Pkt31K3AhN5LiEjwb0hZJX6Dg5bUEhKIQdJkL4s7pZycgNFQ==
X-Received: by 2002:a5d:58ca:0:b0:31f:f65f:74ac with SMTP id o10-20020a5d58ca000000b0031ff65f74acmr16963189wrf.70.1697035560724;
        Wed, 11 Oct 2023 07:46:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:2cc4:b980:5314:b759])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d6904000000b0032710f5584fsm15580267wru.25.2023.10.11.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:46:00 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [v2 0/1] mm: hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions
Date:   Wed, 11 Oct 2023 15:45:56 +0100
Message-Id: <20231011144557.1720481-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most function calls in hugetlb.c are made with folio arguments.
This brings hugetlb_vmemmap calls inline with them by using folio
instead of head struct page. Head struct page is still needed
within these functions.

This patch is on top of the patch
"hugetlb: batch TLB flushes when restoring vmemmap" to avoid merge conflicts.

[v1->v2]:
- (Muchun Song) add _folio suffix to (__)hugetlb_vmemmap_optimize/hugetlb_vmemmap_restore
  functions.

Usama Arif (1):
  hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions

 mm/hugetlb.c         | 14 ++++++-------
 mm/hugetlb_vmemmap.c | 50 +++++++++++++++++++++++---------------------
 mm/hugetlb_vmemmap.h |  8 +++----
 3 files changed, 37 insertions(+), 35 deletions(-)

-- 
2.25.1

