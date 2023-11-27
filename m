Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F196C7FACEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjK0WFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0WFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:05:10 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3781A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:05:16 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1f5da5df68eso2860033fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701122715; x=1701727515; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ddP9Seydg6uEHR4Cvl6RvAssgCZN9rnWQDGKZ5eImoI=;
        b=ncEyNEJbvWhsaBY29eJFOGggCC34Ka0RjJ4NQBqiLZ7viuMrEYpcP/Wt99+lI9MqOC
         XTj4dGFtdGnxSU0Q4CgqvE1GJEswqrYqGrfnkBuHCl/hUkvT+2jUCsV2RgDaBHpmGPEM
         O93paTRA018yacQrvlyrR7clJLmCY3H9gzeRMqgSHAcJLfNAbqHaRtQaiaihP6n91HiJ
         /4m+kG7ikeLeUtuej0X6etHW20NZMfeBVlkhUzt+QvKDUqSewD4VGAr7s/FRZ6NKCCBq
         o7PUy2/oeb+ubNt28RKdndhH5GCGsu2lZ6PYgsDHPLTZE3kVFM/8ANy/rhm9A5K9VUUr
         Gd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122715; x=1701727515;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddP9Seydg6uEHR4Cvl6RvAssgCZN9rnWQDGKZ5eImoI=;
        b=Iyh9/wk8E1c/kjI0ygqdV9l8qOQLYkxP+3pA6pb53Pqra8QrZ5oKjZvWQCee/ZFoKo
         4qZdxwpEFXZhENHRzxeVILP1w6oL7o9LlrLQnngHWVjCLKdX9ZFkHweqnkmUESuBz66T
         KpX3Fk92cMNDuhhxRWNksxOiXGsED5ofw+3yUXLy2GpnuZHprC3BWRfu+amBToQhDA4i
         GLuPdOtY9GmaoVcsvkhlzFTiVSKmn8aHJkSxbzZHDHbno1xbrj7EKr58xAemhR9WmXGQ
         iuGIRuLkz3BYjwyhm/AFqRrZAFPjqHaySrvQJpvB5Rz7tx6yCYXxpKIet3eZVFORtFeB
         GrKg==
X-Gm-Message-State: AOJu0Ywg14eNDNrQoOO1jZlr1Io5FrqU4imkZ94WrfyhTLngysnTAqGs
        WXvjiDNYbNbj+J8BkeSlI2doYA==
X-Google-Smtp-Source: AGHT+IEnj7s/9ky803AWh0qNXrHLp8Gp+Nrp25b0P7l4iEHKpfaZkXNiO6XBdHlUg8afXhaq7X7Hjg==
X-Received: by 2002:a05:6870:b88:b0:1fa:1c63:738d with SMTP id lg8-20020a0568700b8800b001fa1c63738dmr14171941oab.7.1701122715440;
        Mon, 27 Nov 2023 14:05:15 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x23-20020a056830115700b006d679b53e8asm1458890otq.24.2023.11.27.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 14:05:15 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 0/2] riscv: Fix issues with module loading
Date:   Mon, 27 Nov 2023 14:04:58 -0800
Message-Id: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIoSZWUC/4XNwQrCMAyA4VcZPVtZ01U3T76HiGxtqsGtlVaLM
 vbudp5EFE/hD+TLyCIGwsg2xcgCJorkXY5qUTB9at0ROZncDEqQQkDJB29uPR56cmdyx4MNiHl
 y6FQrO1CqU8jy8SWgpfsL3u1znyhefXi8/iQxb/+SSXDBrbW1MGuoG6u3gZKP5PRS+4HNaoJ3S
 fyUIEvNuuqsNnK1qvCLJN8l+ClJXvIaG6wEtFKW6kOapukJKCp0/lMBAAA=
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701122714; l=1275;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ktmhIbS4nLRNl0CJgpmhOEvy8Ne38cd75WPfhvHt4w8=;
 b=LvG3ouNrZDAB8lSTyo77I0DXPO2z8KvBEY0edkFxLi/zJhf9q/nZbwvTknADYULxy6qmtlgoV
 Wb0g/PZstEtAy3ZNIDk8PWwi5awR4QNle4aGVl8+hSrIs5vPyWmNvGc
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module loading did not account for multiple threads concurrently loading
modules. This patch fixes that issue. There is also a small patch to fix
the type of a __le16 variable.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v4:
- Make functions only used internally static
- Free data structures on kmalloc failure (Andreas)
- Link to v3: https://lore.kernel.org/r/20231122-module_linking_freeing-v3-0-8e9e412a3305@rivosinc.com

Changes in v3:
- Cleanup pointer passing (Samuel)
- Correct indentation (Samuel)
- Check for kmalloc failures (Samuel)
- Link to v2: https://lore.kernel.org/r/20231121-module_linking_freeing-v2-1-974bfcd3664e@rivosinc.com

Changes in v2:
- Support linking modules concurrently across threads.
- Link to v1: https://lore.kernel.org/r/20231120-module_linking_freeing-v1-1-fff81d7289fc@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Safely remove entries from relocation list
      riscv: Correct type casting in module loading

 arch/riscv/kernel/module.c | 114 +++++++++++++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 30 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231120-module_linking_freeing-2b5a3b255b5e
-- 
- Charlie

