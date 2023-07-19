Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E85759EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGSTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGSTfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:35:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424FA199A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:32 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34896a1574dso595695ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795268; x=1690400068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsGoT51dWJmzQKPxb3tGZnxKgH62aNnVUMM3GK3B70I=;
        b=25R+yCvMKbfvQR87JPugzrtI45C63mU3sviX8G0Vy3Wvo5ueLJ6LoiuXaMFt1wKE/9
         J2h7M7wC9mw8pp112AUlWRQnBXuQYeNqWCUrHT4s/bSKKKVibQt5pMn4JpFlbK212NTU
         Sh9aDJz8I0G32u8J5s8SbpYs7u5AYuv0KdPzsQzp4A4tsU6FfR5KRmDtU19hydphE8fS
         Dvwd2miaFaVXcHQq7Pao/6dE0JkI4ofWpL3JzgHPGwqTAgtKWllYKsvDJSJBHZ4k4ptP
         KcOM7qqQwWLW6QhyEFO3/HD64siCzcAvSJ8/yq3MiSdTk8+aGW6aGukJ4KThrK/kYnKa
         PovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795268; x=1690400068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsGoT51dWJmzQKPxb3tGZnxKgH62aNnVUMM3GK3B70I=;
        b=XJABypGPAbnPfJEtqFLSxOdGSDQmOiP11ac4k9ikpC7+zxn/e9dGgE3bsDTs2OtuDg
         uZnTzcvjvTXMQJD0NRAQ8GV9wY3YWOwZ6sFGUk/RDiwARlAQWGkUbzwzBpr9tPbiYGAU
         lFF99Lsds65+Ve2msFSj7QT6bl9hx8/NU86H71jKGtvzbxuyH2mU/+EGO+cqWlXlMIaT
         yPE3UmrUO6R87CaJMUJ9k8/u/NV3HMfHlIgKgtx7rfKZr51z3qUuhbIaH8s+Ta1BBCAG
         a//SdfdP6ACaiorcdUa99KrLUfJjFnILzTX5DErNLsF0HAo/P4MW/tUGS1GXTFdV8tmc
         IyJg==
X-Gm-Message-State: ABy/qLYRDOiV1CtYo0C0UypOacCxG2ciDepEisKDsZYBSRqkJl2XMLee
        GkGse0fHqE30ZRdxxSu1/bn77w==
X-Google-Smtp-Source: APBJJlG+MFbJEKkJ1B9LQsQ5MgT1jSSRYuMm6X1iFGTwoFDCvk/QYGkIlda8SXG94SgiZ9wVyGnQjg==
X-Received: by 2002:a05:6e02:1c49:b0:346:e850:6cc8 with SMTP id d9-20020a056e021c4900b00346e8506cc8mr3677361ilg.9.1689795268696;
        Wed, 19 Jul 2023 12:34:28 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:28 -0700 (PDT)
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 04/11] MAINTAINERS: Add myself for RISC-V IOMMU driver
Date:   Wed, 19 Jul 2023 12:33:48 -0700
Message-Id: <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689792825.git.tjeznach@rivosinc.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630eca..d28b1b99f4c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18270,6 +18270,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V IOMMU
+M:	Tomasz Jeznach <tjeznach@rivosinc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+F:	drivers/iommu/riscv/
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
-- 
2.34.1

