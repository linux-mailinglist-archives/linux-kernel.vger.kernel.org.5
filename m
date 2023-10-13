Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CC7C7D05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjJMFbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:31:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F4B7;
        Thu, 12 Oct 2023 22:31:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso1450925b3a.0;
        Thu, 12 Oct 2023 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697175089; x=1697779889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy7TboT1tjJJztCz7Esa81WmhMy+A2tzF01Kh4RO/iQ=;
        b=hMOTfQyfrjZM6y50wztdhjY8ELj0TV1uwXYQEf8iYKWd9DWxVjO2oyB6FPL/o/Weaq
         UgHM0ecovmA2tkUY8dbtnFq5W2F+M4E3Ct+A0rKcO8simZjEKGPhaUmT2nrC5INsFFw3
         T0kuHRJToZaetPUYVDbk9OFGuQfYqdO9yrYC31g+b2zMY0JkBA+08a2EuwKjhtIZDvZH
         WJQlmaVZPQ2OEBvuGe5e2QKriNqOS3Q92+KORmfKGj8+yyZpsT3iif1OC6Y9RyvA6Pyn
         BvF3VIdCsCgMKTa8sIWHd8l89ovvnszeB081Ja28rcael9GtR+h3oAvQE+GsJler4GB2
         gnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697175089; x=1697779889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jy7TboT1tjJJztCz7Esa81WmhMy+A2tzF01Kh4RO/iQ=;
        b=kc2jMP8xwQaz0GkfoMJ399qNWCAxrVKkPTY8KbM25ptj/6oqxGXiYsyZNcLIc9flJs
         xtz9dGPcBp2/uuEXPLbD7MqHQM0VBTftd5cwxft/XaIUE3Rxkrx2qFgoxwVEaTh28kPr
         0El0WLSumtl1Co5XP9H4kxBFP6a0lMF8M2zfHLwVVsDD20/Lh9o5wn6htcx58/7N3glj
         Ev+vB6Q7/lM2qm9VD7Wi3HyxZju7xkJupOMnXsGqBUQOWEj77prRuOho+/L0cakIlDSV
         tW5IwHj1ayySa920DcXU5zhnXwtfIT7jznvIf5hYjFMpLwwHyw3AZkmIAgi6kSyw2MmV
         YUkA==
X-Gm-Message-State: AOJu0Yx0Fat0ExQyhwB0M18LG5EiQUBfVvcPvYZAH/KXAxgXW6BGermC
        tAmdaSH2P3KNd5aCRPLyqec=
X-Google-Smtp-Source: AGHT+IHySDr3oEw1qDXbIuzEx4XcRygIfCFWDj/u4f5YrKZqXJ1e1m2fIFG1DX9JEnpa3d6n1wKU4w==
X-Received: by 2002:a05:6a20:729c:b0:15e:bcd:57f5 with SMTP id o28-20020a056a20729c00b0015e0bcd57f5mr26569539pzk.3.1697175089434;
        Thu, 12 Oct 2023 22:31:29 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b00274bbfc34c8sm2764917pjv.16.2023.10.12.22.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:31:29 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     martin.lau@linux.dev, yonghong.song@linux.dev,
        john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead' typo
Date:   Fri, 13 Oct 2023 10:31:18 +0500
Message-Id: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fixed 'instead' typo

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7f91ea064c08..bc7f92ec7f2d 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -940,7 +940,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				 * !fp->aux->verifier_zext. Emit NOP otherwise.
 				 *
 				 * Note that "li reg_h,0" is emitted for BPF_B/H/W case,
-				 * if necessary. So, jump there insted of emitting an
+				 * if necessary. So, jump there instead of emitting an
 				 * additional "li reg_h,0" instruction.
 				 */
 				if (size == BPF_DW && !fp->aux->verifier_zext)
-- 
2.27.0

