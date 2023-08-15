Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5084A77D6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbjHOXhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbjHOXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14613E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68879fc4871so394352b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142593; x=1692747393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYztBmgNlm9MJ5Kmi7zazvwgzFgVLarkDPadWS8g8wE=;
        b=ortk1ZAOIxBlEFQptNzkpoS6aKGJnPqJX8Kteb1t1sSMoLM96jhi/aRNaF06wtt3XI
         w49NlLKrLLyOXAP44qKsgmwwXNG0apbuLkoi4cH/t6RScoTFE+hhtCu4hQIofHGmYtlD
         +SLBzGdN/yVIiotr8sOMJ+VYpv9fONdkYLhfAJwcwj6h8lQyomzQQuVeE6JoaGqhN7Cz
         MVA9z1lncYcs+eNGMDkEYdMhnwx00MC1/nGozMuk0GZK2H7Ksurw97ZaLofpxaQMswXx
         aoKc71pZ/VynoiojEHYblLZmNTIjaH4/i6Lfcpw1F0E8jP6FED7n5nsPoZov9W3g1Ow8
         2bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142593; x=1692747393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYztBmgNlm9MJ5Kmi7zazvwgzFgVLarkDPadWS8g8wE=;
        b=A/clTcTJZA3qXkFR6etlSoz26kRhA4qwUqcvT2wgnq8vBAbgQz79ZPuYp6DMQ/dxVg
         +gycqX3k8B8zJOBPyJL/wvn8vuagFNNp10n4f5faZukiL83upyOrqqviMO7UF+doj2mc
         8pTe3NY8weaZAywsLSUcMA+C9igroTNi3xvolivwmTGyjzEJXuFDZ4Gema0hiystGRtN
         CjvbZHcx6upDi4sDJuWwdal87EO6aXTwofTeWf0DvJdcgeOjqgff2gsnvn5z2icOqjAI
         SO75d95jTUMCjU0nlF1DpqqymznLin4/fZwqhfxZzSptxuKvR/NBKQUgS0SoLyb9V4Kv
         snEw==
X-Gm-Message-State: AOJu0YyBvHMTjNvwknKsz7V2Njw9OY5IgDxCxIcHFbXuifqwvHTS1LRD
        nJXnWPjqkmNZo0S+sl/WWcsBbIMBLik=
X-Google-Smtp-Source: AGHT+IE8jo8sGBvzNPJzwt7fRLeCzwfaBMnZ23+sQKvS5KeMGJqKG1Cl+GTp5vBl+iOJiyWaq+FBOA==
X-Received: by 2002:a05:6a20:3d89:b0:133:6e6e:2b11 with SMTP id s9-20020a056a203d8900b001336e6e2b11mr421015pzi.2.1692142592839;
        Tue, 15 Aug 2023 16:36:32 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id q22-20020a62ae16000000b00682a27905b9sm44832pff.13.2023.08.15.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:32 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 0/8] bitmap: cleanup bitmap_*_region() implementation
Date:   Tue, 15 Aug 2023 16:36:20 -0700
Message-Id: <20230815233628.45016-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

v2: https://lore.kernel.org/lkml/20230811005732.107718-2-yury.norov@gmail.com/T/
v3:
 - add test for the functions;
 - fix bitmap_alloc_region();
 - fix comments and wrappers style.

Yury Norov (8):
  bitmap: align __reg_op() wrappers with modern coding style
  bitmap: add test for bitmap_*_region() functions
  bitmap: fix opencoded bitmap_allocate_region()
  bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
  bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
  bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
  bitmap: drop _reg_op() function
  bitmap: move bitmap_*_region functions to bitmap.h

 include/linux/bitmap.h |  63 ++++++++++++++++++-
 lib/bitmap.c           | 140 -----------------------------------------
 lib/test_bitmap.c      |  24 +++++++
 3 files changed, 84 insertions(+), 143 deletions(-)

-- 
2.39.2

