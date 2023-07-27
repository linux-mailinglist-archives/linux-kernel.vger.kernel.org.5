Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F310B7643A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjG0CCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjG0CCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:02:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FA9E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbdc05a93bso1541635ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423333; x=1691028133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkfxuI1Afe6clKYZSZbRtLRAuJsgjCF95/9Z0266VFg=;
        b=JrDvtHHv/eA9Poq4CK6QbxvJJ1AnvGlazNBpzdenxYaliF75E6Zno3D+MjjymQm3xv
         A2SnNJ2UCs6R6Al+NQ8SVrhs6WFmOC7vt772TzUjK7+fAwYAv8lN6bQ0bxL2neo0Z2eh
         c/Aqdsc4/lYfMEVt1kZCGbXWnT1G0Pc252CyuLIQ1LVZQLDJbyI6KcrI8TZwwffcv4CW
         dM7DreUjgBM2c/52gJG7dB4C71ImJF1Z6qWEbWDO0Vj/nU+wt5ewkHvzSDmoYUa+Ec9j
         O4RrWQ1lMyX9IXXP70UawUj4C6oOYKggMB/apYnCIQe6qNGBlLlrBgPUJ9oo2tY8AVa0
         +5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423333; x=1691028133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkfxuI1Afe6clKYZSZbRtLRAuJsgjCF95/9Z0266VFg=;
        b=ZP2/b9mc+NlOzeFESjCYRhlSISJETpYM5qZSdtWz8OZBy01Li4csLq2cYcOC27Cd2m
         0WVDt+Gn94DZhdwT7DvEpOSk6afn5LatYMdMuSTDCig/vnOzSONKIcqT1VZMJzplUzZ3
         XYht5L4KgXFa4FBpIW0ec4sRX+N5aJEpdN04PDgq8jdC9dE/3qGaOJENbaSdnwqi3VVw
         JezfC8wNKNdOvtPSUy6m7u6ODbkZZP45p0WjIeuGRB/h+Gdfy1dzxfkTjTC7b18dhD26
         eCDHtGt8ux6RZW2MA+723vvRKgZDUckdUwNfuFdaLKWO6wdcavKNO5I2Q7dhzrnd2uOd
         iCOw==
X-Gm-Message-State: ABy/qLZCFUzhfoVY5vd1ATs/SATXe3hePfgwkfvAhs/3FzOG/CX94FVR
        Z6zABcblneK7VZiribYSLoSlmvDvIFT8aw==
X-Google-Smtp-Source: APBJJlGutoKSLSjfCipLWXHgTpSapDv2FLGbjdBvF0v4MKKT4wzaKIPw1tny4/KdyPAlrA2ZPRJT8w==
X-Received: by 2002:a17:902:8216:b0:1b8:9b17:f63d with SMTP id x22-20020a170902821600b001b89b17f63dmr2752321pln.23.1690423332627;
        Wed, 26 Jul 2023 19:02:12 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001adf6b21c77sm230580plx.107.2023.07.26.19.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:02:12 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/6] bitmap: cleanup bitmap_*_region() implementation
Date:   Wed, 26 Jul 2023 19:02:01 -0700
Message-Id: <20230727020207.36314-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_{allocate,find_free,release}_region() functions are implemented
on top of _reg_op() machinery. It duplicates existing generic functionality
with no benefits. In fact, generic alternatives may work even better
because they optimized for small_const_nbits() case and overall very well
optimized for performance and code generation.

This series drops _reg_op() entirely.

Yury Norov (6):
  bitmap: fix opencoded bitmap_allocate_region()
  bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
  bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
  bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
  bitmap: drop _reg_op()
  bitmap: move functions

 include/linux/bitmap.h |  65 ++++++++++++++++++-
 lib/bitmap.c           | 140 -----------------------------------------
 2 files changed, 62 insertions(+), 143 deletions(-)

-- 
2.39.2

