Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860887BE483
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376540AbjJIPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376366AbjJIPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:19:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B0B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:19:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb673so45167775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696864751; x=1697469551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4PvYOaVB2LfCKyNyEgmRFPDdLDakSJl6mv7yLdqqSA=;
        b=c6oKpCj4JDMSGijVPucbuU0eLKWH1s33e4853t5Z1A9FDd93uPIQZdmurSVb+YS7aH
         vqK5JVZPpklY5yTOPaVi4N61Mz42eZNA1mHSx22k0ww1c/mjqVMQ0evO6wZs2IFcP4+k
         clTDKHfrty0jMDw490nZylaJrGz6TzSsvLjtgaePd+ZRvCvAxrAR49ODBpgEQXyckc9A
         rHaaHw3flz3KcvO6frtD6P30T59RrbW0PGGlM57nTMH8dU8m+/HYAGg3VCVRrG6cc4Ha
         GpvA34aZmjIWEhEl4nj06rHglst2i7bryeb33tlTBXugk7fHXW0PDzk4FrtSKHP1Hhxt
         9CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864751; x=1697469551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4PvYOaVB2LfCKyNyEgmRFPDdLDakSJl6mv7yLdqqSA=;
        b=HGVSD95I60gogYRy/YxNp5frjm4iPmltJXebCsNbil3gfNpJCIrVjBiZ2LTvEwx3aS
         Zlwf5zdkwDKqTdPDbjRQKSVVo+g7knbIIPxX0Sw5uZScRZ9GIwUiK+q66CzbL9jKsJlp
         5rybtsRJzA4in9OME3k21TamliDEfv6NgkrDppsinWJC/44MUUQ9n6sjDtlBZ3JAKXLB
         3YyDkuwrLWJis6GE409sUL44vZdxMAZ5wVYC/nFGilxc2L1GJskuMxmU1rxz5wYpHC0S
         6U7m/No8eTI6QB+c2+oVrNUh6tgTXFtpNxRAt17Pz2zJsCipj1ZUi9Pvg+h3Bd0f/VpJ
         fG+g==
X-Gm-Message-State: AOJu0YwQV8SLhu1peS+Y2AxqEHzcsUvGOvW2c8WqfD0TRZadR9gffgdG
        pRWCZnI+jTNxj62v0ExR1yhbsw==
X-Google-Smtp-Source: AGHT+IFuACbcoZMRy23F40Qe1mGH7p+/4U8K68rTkDVcu7dwan8czyedSSU1A4QiSJA/Or/vJGEP9A==
X-Received: by 2002:a05:600c:2197:b0:406:5227:86f0 with SMTP id e23-20020a05600c219700b00406522786f0mr13023961wme.5.1696864750947;
        Mon, 09 Oct 2023 08:19:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:c1b1:1479:6449:a1ff])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c320200b0040641ce36a8sm7075008wmp.1.2023.10.09.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:19:10 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 0/1] mm: hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions
Date:   Mon,  9 Oct 2023 16:18:29 +0100
Message-Id: <20231009151830.2248885-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 
Usama Arif (1):
  hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions

 mm/hugetlb.c         | 10 +++++-----
 mm/hugetlb_vmemmap.c | 42 ++++++++++++++++++++++--------------------
 mm/hugetlb_vmemmap.h |  8 ++++----
 3 files changed, 31 insertions(+), 29 deletions(-)

-- 
2.25.1

