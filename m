Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659337F66C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjKWS6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:58:22 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3CAD43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c8879a1570so15031781fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765906; x=1701370706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGDig6YgBY65aRC6yCBQTLGsMwfbG6Dc++Rh1cU7fbM=;
        b=DrC1T99i0M2ZaIhu7Xi8wj3jQMkFXQpgn77EmwbppqJvw9LThxqAgjxu07PvCPrJEY
         wp3jkXWKXWWbwTGWonmdyNL93JlQjRTEP5MUmfEgzHVPPvfAzAWBXOBQIlbdwquX3TQT
         g8IX6/YCdVbGu0B4tiNVgiZ/GUbKU+eh8KijcRCNny7Snl8wuvpQ+gunhezXWPvfvUlM
         aY1BAsZJ4l2gtTNwqmXSyuuyaa0Rw7tuKwwgONQ4WqXlZme+1Qc1j0BseJjV/Rxchat3
         hhyHShY7A02RsC3i5B4jfVPczmaSlDhM/IRuBVVLfLAYM3EqQnMqnJH5DwusAgX9K3Ap
         3c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765906; x=1701370706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGDig6YgBY65aRC6yCBQTLGsMwfbG6Dc++Rh1cU7fbM=;
        b=qvccCmagMSxLaEMdS9zAimvKPm0T+coq+phJ0WWU2PO/QPYtByrnqDQjGgVnsaXl3s
         4tw7SBdPvU4jcPieO/E9LPemH6Wt3VMnRnGzszzfV03UgRlBb7fDbJ1czAf/+3p59j4X
         adBu+sTRrXsFhGTEPPT7V7fai6Lz0zD39dpHSZgNsUFO5SgByDH6h4WOF0bQ1M8/wMdI
         oZrl41btfOylcZ6Tt0Hs6b0OeAyFddIhjEiPfNg+NkRiV0hNJGwI7HTLQDwwOVo7clze
         of1q2IfhMkBgvS6hU4hYuQCoCZ5UD6kBM6vz9VvvQ4jyt6rKIXjeWk/Xn3qwPnzCH3gF
         /tBg==
X-Gm-Message-State: AOJu0YxUS9wm57u2ReKIO+Nm5Z4hLOAQQJupFcInsIkchL8UV1CfuR8D
        Izbd2CKPLCrPvoPrXqnjcsgaHg==
X-Google-Smtp-Source: AGHT+IFY1/C0dQe7cOOy2B31dSRmgNpyJ4PnGGQCob4NYZKF2UsPTkohGqYxikaY7xsNsW23oO0U/w==
X-Received: by 2002:a2e:9ac3:0:b0:2c5:14da:91f2 with SMTP id p3-20020a2e9ac3000000b002c514da91f2mr219754ljj.22.1700765906008;
        Thu, 23 Nov 2023 10:58:26 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:25 -0800 (PST)
From:   Christoph Muellner <christoph.muellner@vrull.eu>
To:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 0/5] tools: selftests: riscv: Fix compiler warnings
Date:   Thu, 23 Nov 2023 19:58:16 +0100
Message-ID: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

When building the RISC-V selftests with a riscv32 compiler I ran into
a couple of compiler warnings. While riscv32 support for these tests is
questionable, the fixes are so trivial that it is probably best to simply
apply them.

Note that the missing-include patch and some format string warnings
are also relevant for riscv64.

Christoph Müllner (5):
  tools: selftests: riscv: Fix compile warnings in hwprobe
  tools: selftests: riscv: Fix compile warnings in cbo
  tools: selftests: riscv: Add missing include for vector test
  tools: selftests: riscv: Fix compile warnings in vector tests
  tools: selftests: riscv: Fix compile warnings in mm tests

 tools/testing/selftests/riscv/hwprobe/cbo.c               | 6 +++---
 tools/testing/selftests/riscv/hwprobe/hwprobe.c           | 4 ++--
 tools/testing/selftests/riscv/mm/mmap_test.h              | 3 +++
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c   | 2 +-
 tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 3 +++
 tools/testing/selftests/riscv/vector/vstate_prctl.c       | 4 ++--
 6 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.41.0

