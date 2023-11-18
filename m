Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8467EFD6C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjKRDcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjKRDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:32:32 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272DACE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:32:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c115026985so2735921b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700278348; x=1700883148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiER6+GNhM8NqF28QHJqC7UhszFlWWtCYJC8eU1ccH8=;
        b=IxlGyFRWhGxkHRMcp73W9+Iv+1K2kyWlOMOFcN3vVwUE4MgCsmMoJERdxTfouup9kl
         O1w+yjn0vvDANgJqaJvGQ5GHEZjsFhqR5TPNLWxpiTGi/Odhsyjl+sPABnXXq3L1GE7i
         fjwEZMxwc3eti1RiOKzzpjYYtlGwQEeXjrg+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278348; x=1700883148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiER6+GNhM8NqF28QHJqC7UhszFlWWtCYJC8eU1ccH8=;
        b=FiM3009seV7LbK43ehvJSgeL/jtVHJyKXq5YQcA2qn54WD7eMc/EfdTtHjWTWtvY1M
         JPaYrU/8etHNsZMISgVaBKuu82IIjY/5AFe/9e/3jp+QSWpi89jaQfPE1HSDCArusl4k
         jRe/MHrbi+hVSbQiHSNo+EGP8jtrrM32gSIvyuvM0ChbPntCy5YTtJ6VkdaEhr5ZsFcc
         zytN+uPNncm0zM16gpK9shjLJFpPUN92Sd6U85PCp5Nr9phpMdClPgTXG+YvAuVpiCM3
         f3RWpWot5x/oAuArmANgAXlt1OVZL9OJYotCgN1phbbYav7nU32DwlxlRqZ936uULPg7
         vjUw==
X-Gm-Message-State: AOJu0YxgwuJ5x0iZnq5E1fXZzB/lz6Lg29WrmJjbY1Q+i7FwO2I15kd0
        QHYNAaIW4GPLICsyjhKDjThZ2w==
X-Google-Smtp-Source: AGHT+IElC4nlkdRBYCPskViEJXuZO3rJQiaQ0pjZMGGYDmFJR4zN8M2X3/kauDNjipobGyDxda48Sw==
X-Received: by 2002:a05:6a00:93a4:b0:68e:4303:edb8 with SMTP id ka36-20020a056a0093a400b0068e4303edb8mr1659893pfb.30.1700278348601;
        Fri, 17 Nov 2023 19:32:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b005657495b03bsm2145144pgi.38.2023.11.17.19.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:32:26 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] qnx4: Avoid confusing compiler about buffer lengths
Date:   Fri, 17 Nov 2023 19:32:21 -0800
Message-Id: <20231118032638.work.955-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=keescook@chromium.org;
 h=from:subject:message-id; bh=OMCLpZGQCXtDrFtSkwPrEvTz65pZ01+xbtIVOPQFtnA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlWDBGj6KV93xXmd7bqlrjS6DRqhDkK533J9F4U
 Xqp5Vjhc+mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVgwRgAKCRCJcvTf3G3A
 JsaID/9LJTAd4OyUK7Sv5F2BQlJx7xBQDMCck87P/+EqLsaPZPhMgexI14/dvnE36YR63MTGAQe
 jc/WTfRpxi2vn7T4S3+Y9xpqIkqT+6t0DuKZ+lG8LMPuaXfH4FXKf0qJ3jAJ45kpjW6dqQW8x38
 pd+1DpMh2/sXecHgv1gx2BuUgnUX2O0zCq1mllM61OgKVdtB1U2eq4KFNdixXU/GaozjiRz6dWg
 w/q0i32LumgYnN0cIecZKr6pfp7eIluXBkThjMkMC6h+o8gxr1w2Wrd+KPsayJt2M9E9tqJ0Tpi
 CrhQa68PUZpk0GM1aPXalSarCaJxDK/ox13vvUOnNO45uHzFRuZo0+I4jilsWujnDeUDp6E6cpz
 o7ynfot8hgByy2p3LpIQqblI3G/q/vnrNHUlFg9HUI/ZevijcXuaop+YrTI6tSiNo9IpiHl01r+
 uqaZsRL3tsJNkJ453t8c9Ww+4uUdBzozmeW9w+6/Csnsvm4qW9wRQGaVrLmJTB1ZSYEpdb3hbjk
 /cyPUXIzwZn9/dQnSaPBOpL1LZt0oMkqQXeNWBKG57loKutLemyJk1WXeaP8CbsGxSo8xVqlTyL
 jb2C4ENFU/8s50B6Rk20z8Rxwx83pzMtjiHqyPTXnbTg6hU7RM4/s+htVPwaoosHrzpymFRwyqT
 6wpwAow2 k+a2s4g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
too-short struct buffer when reading the string, by using the existing
struct union.

-Kees

[1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/

Kees Cook (2):
  qnx4: Extract dir entry filename processing into helper
  qnx4: Use get_directory_fname() in qnx4_match()

 fs/qnx4/dir.c   | 52 ++++++-------------------------------------
 fs/qnx4/namei.c | 29 +++++++++---------------
 fs/qnx4/qnx4.h  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 63 deletions(-)

-- 
2.34.1

