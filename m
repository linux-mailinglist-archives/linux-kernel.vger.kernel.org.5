Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AD809987
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573006AbjLHCxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHCxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:02 -0500
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038E0171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:07 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702003983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RgAHVYTr05aBZP5gwX6wkJhQrJFR+7p9J4OyUiik14Q=;
        b=bM5YHNJMsiPP7Mwk8RRfz94bVPAFboFI53wRgX2BsAdbKgW/QsNQlTUt8k8fNDZRsBmagI
        +Huu65FRujg6hfv9bGexcmytUc+4DIrTnxbh1XSDJIHUlWDQSvcquLsNdxCXVbj17nguso
        bjukddYUuSdpiVcRcTB602XbO10Khpc=
From:   Gang Li <gang.li@linux.dev>
To:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ligang.bdlg@bytedance.com, Gang Li <gang.li@linux.dev>
Subject: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on boot
Date:   Fri,  8 Dec 2023 10:52:35 +0800
Message-Id: <20231208025240.4744-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, hugetlb init parallelization has now been updated to v2.

To David Hildenbrand: padata multithread utilities has been used to reduce
code complexity.

To David Rientjes: The patch for measuring time will be separately included
in the reply. Please test during your free time, thanks.

# Introduction
Hugetlb initialization during boot takes up a considerable amount of time.
For instance, on a 2TB system, initializing 1,800 1GB huge pages takes 1-2
seconds out of 10 seconds. Initializing 11,776 1GB pages on a 12TB Intel
host takes 65.2 seconds [1], which is 17.4% of the total 373.78 seconds boot
time. This is a noteworthy figure.

Inspired by [2] and [3], hugetlb initialization can also be accelerated
through parallelization. Kernel already has infrastructure like
padata_do_multithreaded, this patch uses it to achieve effective results
by minimal modifications.

[1] https://lore.kernel.org/all/783f8bac-55b8-5b95-eb6a-11a583675000@google.com/
[2] https://lore.kernel.org/all/20200527173608.2885243-1-daniel.m.jordan@oracle.com/
[3] https://lore.kernel.org/all/20230906112605.2286994-1-usama.arif@bytedance.com/

# Test result
        test          no patch(ms)   patched(ms)   saved   
 ------------------- -------------- ------------- -------- 
  256c2t(4 node) 2M           2624           956   63.57%  
  256c2t(4 node) 1G           2679          1582   40.95%  
  128c1t(2 node) 2M           1788           684   61.74%  
  128c1t(2 node) 1G           3160          1618   48.80%  

# Change log
Changes in v2:
- Reduce complexity with `padata_do_multithreaded`
- Support 1G hugetlb

v1:
- https://lore.kernel.org/all/20231123133036.68540-1-gang.li@linux.dev/
- parallelize 2M hugetlb initialization with workqueue

Gang Li (5):
  hugetlb: code clean for hugetlb_hstate_alloc_pages
  hugetlb: split hugetlb_hstate_alloc_pages
  padata: dispatch works on different nodes
  hugetlb: parallelize 2M hugetlb allocation and initialization
  hugetlb: parallelize 1G hugetlb initialization

 include/linux/hugetlb.h |   2 +-
 include/linux/padata.h  |   2 +
 kernel/padata.c         |   8 +-
 mm/hugetlb.c            | 201 +++++++++++++++++++++++++++-------------
 mm/mm_init.c            |   1 +
 5 files changed, 148 insertions(+), 66 deletions(-)

-- 
2.30.2

