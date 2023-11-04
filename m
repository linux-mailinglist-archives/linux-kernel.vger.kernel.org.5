Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3417E0E7B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjKDJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:01:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C512D42
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:01:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da2b9211dc0so2829333276.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699088477; x=1699693277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhoss6COa2UBytJz6Pi1nWe06LTBBnpCq5bWg5P1Vw4=;
        b=j3acVPP3IJnVmD10f43IguL3O/aAB3Rv4XGtjtaGgtdNuvS8MdlvDN8I6sesOjBPQs
         vTXf7bRmnPp0dnvncjVSC1d2dNGt30rlDe4KT/agrz0hBVq2UiHuHyhHX7H6Xy3zoUgL
         M2RffYH8CQGnmY9f6DHy2BcnBKnMcsTu7XYtxP2HAgVEVPA/o8xtVnkDp5AuvoZWSgjj
         nKcaF55do+QIb3A+frIP/6hobwI720srcLKHGw8aK7/MKw90GEmclPGDjOpoNLRmefGn
         H9hFFn1k//p4+RoKcCBvY16c4jty1/EIYJnuui8ykeB1oH+tQx21Rliv+iPOtFlZ569a
         hS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699088477; x=1699693277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xhoss6COa2UBytJz6Pi1nWe06LTBBnpCq5bWg5P1Vw4=;
        b=RblVMWMAXlthzRCWq/pFQGudzgzB1rjfWPqJBBxHCKViNn2tb69Xil5zRJQWPnle4Z
         YBomJRjvQwB6tqk+pCqvbbYuM/zqvuSJRO7GFgw4o+5y7ImilB38mQTRFBEZLJPlnj/6
         t7G56jGhdvVMiEyRXIdaxCzwhbG9YDYfiZke++P12ADh8B3A+TmoD2zC5iGrcBQP1mQr
         TEDi7X8ir41+dibCXOwBx/Z6TgWlJQop5HlkjxoS3QL7ygRswFJHlpHX2qvlx6O7hVSw
         xv3beuNm/NLHHTjBNiBBswYzWT8tYvc+aE0KmBwhkxN0i8XajH1EJx4xjmms0L8OYnOp
         /Rmw==
X-Gm-Message-State: AOJu0Yy5TtU6HetQOd4X+FX5yR47L4l3tb3TFVM1i8rRR/R/pS0pHUOO
        +qXRZ5jFLD5QBRO6Rhbef2Y=
X-Google-Smtp-Source: AGHT+IGY5YcuCFNUOCMu0RmA/OXshk06e1L4c6H8CSlwaMe5BYZD5uaKQXa0q6KNiLRGMyTd1x/npA==
X-Received: by 2002:a25:d51:0:b0:d7e:b88b:1de8 with SMTP id 78-20020a250d51000000b00d7eb88b1de8mr21549450ybn.9.1699088477544;
        Sat, 04 Nov 2023 02:01:17 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b0068842ebfd10sm2667596pfg.160.2023.11.04.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:01:17 -0700 (PDT)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wuyun.abel@bytedance.com, linux-kernel@vger.kernel.org,
        s921975628@gmail.com
Subject: [PATCH v4 0/1] sched/fair: Track current se's EEVDF parameters
Date:   Sat,  4 Nov 2023 17:00:53 +0800
Message-Id: <20231104090054.124945-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry that there was an obvious error in the previous submissions
that caused EEVDF to always be unable to find the eligible se......
This patch should address those issues.

Changelog:
v3 -> v4:
    - Fix incorrect changes which make EEVDF picks the first entity
instead of the eligible one
v2 -> v3:
    - Simplify how we avg_vruntime_add() and avg_vruntime_sub() when
neeed
    - Do not avg_vruntime_add() the contributions of 'curr' again when
put_prev_entity()
v1 -> v2:
    - Consider the contribution to avg_vruntime for 'curr'


 kernel/sched/fair.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

-- 
2.34.1

