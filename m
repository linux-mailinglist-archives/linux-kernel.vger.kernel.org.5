Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EB759EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGSTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGSTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:34:59 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3426B6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3e1152c23so30895b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795266; x=1690400066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKs32IhtjLCxiTXuNk8Uk4pJZW2VlUAJQXvCnEO8tTw=;
        b=ttEo92CKB+yR7JU7SvNGV8Atfkln1N918fvtYmF+Wgf2jy4/UvkxLvZRx27dLz5xpa
         MK28QZNyj3okLeYSDgB53bNVDZxBUGsJIzl7b0oHpt1mjYQlvG742DV2OfZqfp/toq6S
         cqv66fUUijUqZgzvJveQtk6qJyo4+Its4OkrqFa3ow6PzmvaLPj3RDllFbjds40oEybI
         2GhbBCEJRA/5XrGCEgfKz/bCXBbANcUZY6dwuHG8oPTtVgjEK2yl85TLej5y5liOEynz
         +B83Dx+fGKsqspEcpyTw+uOBVovf/8uysb74AEM26+yzu0N1vlrrsUTsxZJlKdR5cWqB
         AE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795266; x=1690400066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKs32IhtjLCxiTXuNk8Uk4pJZW2VlUAJQXvCnEO8tTw=;
        b=HnwiYRib4he8Qylic8RLKwlZMBgwBcLJslj9jC7+0Is1FsSVkEGKpIkKq3Xjc+iwl9
         GY7XeOeFHlIXiV6BlTyWI9LICn6R4RnHo4L49417jcoZO0RLPocY2Y03phQjzmtjLqML
         RxpX1WJa7wI9yPc/Hft1gn3rlLOs1WG+rLWSPjRf3DPDl6NuBy5mWrhqvZpfC9CYvWrX
         ce2bf695nmQ+qz9Vr2KNUhi9OtcLUXMjaLFy/3tCQ1acILSXjahdodO603FkerFWhkhv
         OdILGRHEYkRIHO4oKycPOUfQ7BZmnWflN9GHCwLahS/mINnwf/mKvup/HRmVruwLssuG
         F5bQ==
X-Gm-Message-State: ABy/qLZeTw8V3JGHUWz/yaXuBN62RlUXSMCPMRGZWskC0l9WszxmWEBp
        b3uEhNeWld++fcB5TJXg3Ge7yQ==
X-Google-Smtp-Source: APBJJlF46NxrjlcdpKJudq/OXjPgbmDMiFkMVyFxOnpopja4waUL727ujepZ1ywnk72M22OszAadog==
X-Received: by 2002:a05:6808:30a4:b0:3a4:f7b:4490 with SMTP id bl36-20020a05680830a400b003a40f7b4490mr21501434oib.57.1689795266359;
        Wed, 19 Jul 2023 12:34:26 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:26 -0700 (PDT)
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
Subject: [PATCH 02/11] RISC-V: arch/riscv/config: enable RISC-V IOMMU support
Date:   Wed, 19 Jul 2023 12:33:46 -0700
Message-Id: <961d125558137f7cb960de65e5f71da5d299d3bc.1689792825.git.tjeznach@rivosinc.com>
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

---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0a0107460a5c..1a0c3b24329f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -178,6 +178,7 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_RISCV_IOMMU=y
 CONFIG_SUN8I_DE2_CCU=m
 CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
-- 
2.34.1

