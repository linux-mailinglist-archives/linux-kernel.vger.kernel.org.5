Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE67F66CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjKWS6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjKWS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:58:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F4D46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so1598115a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765911; x=1701370711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gBMT1D8EIh0bBWoj7ImRklCKaan3pldMceeCzs+vUQ=;
        b=Wut90YIgGWdeYAfFnYgnkugdn4Ab3YQZLngX+t7BRQtw0bQlJapmf/um1Yd5xyAIDU
         yzjHihrUKawz6T/TgU0M6EAU6hsuivLBqbHORBy2xZOhOgNjlAnMfVBf6wOOpg8tZmiK
         7/n+6oC533vD+5tGEQRkJ7UjS0xYxqAUjH9QFMao/cP2hBBJczlXc6ijT+LfHn1RMyfc
         p+XX/GP3L5LTeWf3cQKGspTvXh5kmwEziwHFyLlRTD3X6NfS4Hc1b0ei9qhrS6jP9ZBA
         1yleh2JLIUzbn/JCqJHoia363GAfwnQ7+VflDk6ysr1WAVF7PkMNSpjVp911t+DCZig0
         2t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765911; x=1701370711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gBMT1D8EIh0bBWoj7ImRklCKaan3pldMceeCzs+vUQ=;
        b=qV1g/4hoTWBkEtNgyC6YyPs4Fm3hFrYH7tdGfVjGj18nMU+61OxUp+NPoIBwmkjX15
         AkMieZ7+u5ZHCslXoNimzQaX2INH2DwAzeiN/5WGRecD16fm6rauT89Oi6hF5KpL82Be
         yBxXDr+7b7uwpx10ezQSkO8RDW4iCSK8LHY89kT6hgd/3q7FbLfma7lu8E92xGTTaHkA
         zR2IT/S7rRktzVcEtiKEweghyd9mwosAIaKNvlf8KHUecueWa4dC7qWcU3uXt5kaDssi
         l6JLDgQF+NytUoIwAhjTuhxvELHVGkUeMkH8GTVgimZZgHeUeKohAvi7WhwTJpvZdmER
         tRWw==
X-Gm-Message-State: AOJu0YxgO/ELyk1R/J1q5pCBpcpSvNyjhVcgiR/O7eRQ5p+VAgt8UIWk
        iU5XyWNrLKq3Tko5StNStPZNUQ==
X-Google-Smtp-Source: AGHT+IHM33vf1NCGDtR+L8oDLbeP6Km4LXuLVeIqB8PR1IIY6cQtOKQe4/t/v35w1zVrGzfmN4G2PA==
X-Received: by 2002:a17:907:d30c:b0:9bf:d65d:dc0f with SMTP id vg12-20020a170907d30c00b009bfd65ddc0fmr232442ejc.4.1700765911728;
        Thu, 23 Nov 2023 10:58:31 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:31 -0800 (PST)
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
Subject: [PATCH 3/5] tools: selftests: riscv: Add missing include for vector test
Date:   Thu, 23 Nov 2023 19:58:19 +0100
Message-ID: <20231123185821.2272504-4-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

GCC raises the following warning:
  warning: 'status' may be used uninitialized
The warning comes from the fact, that the signature of waitpid() is
unknown and therefore the initialization of GCC cannot be guessed.
Let's add the relevant header to address this warning.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
index 2c0d2b1126c1..1f9969bed235 100644
--- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/wait.h>
+
 #define THIS_PROGRAM "./vstate_exec_nolibc"
 
 int main(int argc, char **argv)
-- 
2.41.0

