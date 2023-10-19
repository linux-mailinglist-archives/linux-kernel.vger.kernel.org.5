Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF277CF58E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbjJSKpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjJSKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:45:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27F121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:44:46 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bf106fb6a0so1448198a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697712286; x=1698317086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64H3QN+A9R2sRr7RGdVxi+oXdXHxQ2lNCm595aF0dp8=;
        b=NXOlZP8zjdYCSX6Al2vfrelytOF9+u1y1+GIfVdZ2tdIn9hB/tW0W2OL3wP8/9NQOY
         IKEXFh7NFNbwxRG90fIKQieEtuASv8+Z+Soa2MYwFnMbvLdOoPPCWzaFx7Nn01jK69m5
         +n9vur7rsl10MWpUNBSECARQoavaCPobipofWN9hhQ+R/x//nvK8Of8W4wn8yaY+So23
         QkqkAgh6dpPK665EDXILb9LpjI5/s1N20dK/wTj2wjiHFLgR2ZL3NqaPfkBvH4T6kFwE
         TRxEM4fq03jYcF2MLgDHVXfLWssrHPl1BEfPVUrOK3OYZqcqaPchkI2KF7Mf3KU9nqN+
         bIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712286; x=1698317086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64H3QN+A9R2sRr7RGdVxi+oXdXHxQ2lNCm595aF0dp8=;
        b=kI+OfT+q+scKDTR+Rffvoq4eQKgNdf1HIFxKmX2yA/LHzpvs71S/Y1FfqVcS5iW+hH
         7RVWWSQrQKEZ7MPRpyQkQ1WJFKUo/YR+ttkItJWn+XPaWXUgnHwg/usm2iF8FLYoq8E+
         C7BT+eAUsk6OCsC/6J4XT34ErQp3v/q46vpeSj9o9ThSExDFY5FjqGy7uz14fV5V/fCi
         zyjV4tL+P0ZJtTE6nSE0KF1QWjpr0kF1oCj1fcP30BPTM1PuB4F0eMu/vSVJX6+8QHDy
         R6HVEz+p0P7yesmwRhObHH1bSClkA+qd0wbovicdfkvAgYLcZLJBeN7uzMeGcR4r5dR/
         ND0Q==
X-Gm-Message-State: AOJu0YzB2NXguc5zJmceTF/G5mH2TXtTDlA9XXA2c7lBng4XsVAmc/Ds
        7Myl2perXEBS0kM6kiQNjZduPw==
X-Google-Smtp-Source: AGHT+IGmQ7tp2g0PgPG6tIdPzqmqZ06XuIisgKjjciqf3+wmU3m2x81u9ZMFkpX3YsvzD2U8HH42GA==
X-Received: by 2002:a9d:7c89:0:b0:6bf:5010:9d35 with SMTP id q9-20020a9d7c89000000b006bf50109d35mr2051996otn.3.1697712286148;
        Thu, 19 Oct 2023 03:44:46 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y13-20020aa79e0d000000b006bdfb718e17sm4812290pfq.124.2023.10.19.03.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:44:45 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/2] handle memoryless nodes more appropriately
Date:   Thu, 19 Oct 2023 18:43:53 +0800
Message-Id: <cover.1697711415.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Currently, in the process of initialization or offline memory, memoryless
nodes will still be built into the fallback list of itself or other nodes.

This is not what we expected, so this patch series removes memoryless
nodes from the fallback list entirely.

This series is based on the next-20231018.

Comments and suggestions are welcome.

Thanks,
Qi

Changlog in v2 -> v3:
 - add a comment in [PATCH v2 2/2] (suggested by David Hildenbrand)
 - collect Acked-bys

Changlog in v1 -> v2:
 - modify the commit message in [PATCH 1/2], mention that it can also fix the
   specific crash. (suggested by Ingo Molnar)
 - rebase onto the next-20231018

Qi Zheng (2):
  mm: page_alloc: skip memoryless nodes entirely
  mm: memory_hotplug: drop memoryless node from fallback lists

 mm/memory_hotplug.c | 6 +++++-
 mm/page_alloc.c     | 7 +++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.30.2

