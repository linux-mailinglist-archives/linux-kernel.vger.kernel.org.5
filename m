Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8E77C1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjHNU7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjHNU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:58:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CCDD;
        Mon, 14 Aug 2023 13:58:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317f1c480eeso4205339f8f.2;
        Mon, 14 Aug 2023 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692046719; x=1692651519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5L1+5yGpSJI+g1yL7XlfKIJOzrf/CQQnYIldi3eBMU=;
        b=Qo49m5X1YEOdSr9l4PyPwEgCC7X2A8WO9sZYNEyf78SlhLbu9rgFI0IQ6GRfnn5zeN
         ONYKyDvu6OGRWjdN6punKlDdiEBYH0FRbXO9dSOJl76lsH7PFUqrTJWfnN/nVxE+J335
         af91eo4ZkMm0S+8Cs21pojVw3yeH9c+0zmxZCvoqUzVeQHf43TkGWXEz+bpHy6YrNtmW
         XswHMzi4fqFrZyz4tghmtR3/lq9kc1KRykF+FGcPZJ+TG53UAZIwLZjO71H6GbC96lSg
         8nCQ0bgizdCI1Rvx9A9EzQB2pC4EVOQUhU2FEoynKmpZC9ceD+aBNHE6eBt7vkhlmRh3
         aKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046719; x=1692651519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5L1+5yGpSJI+g1yL7XlfKIJOzrf/CQQnYIldi3eBMU=;
        b=XNILIM8jHvHh15jbtxoPzaoFPs9JRKpmfaJvZAi0Ru9MBh3TDaH8tdylV9RVJrOGub
         ggMd+URZPaVuyWsg3uoaFFRGGcLIY6ba0xwo8LN/NmblvhXRTOuSVyTBmBh+Qa/tZDw5
         U1ANjj9HV67VtaFYk6pR/MpLDM3FfEIWIjkstNoGM/oNstEn9oO6WMmo3VGz+dQ4MxYx
         j9BfNypWCIgEZG/u5QBMgvL7t2OiPJEtKdVkycuqXGYcC1i/auixy4eQLhQudn9HAOuA
         SQg8aroR/EZBpoREIzgk5qzUXu6Gst0j0xt+bHIHZjCEMuHzqgSgrxkJr2DpEMUzTF22
         HIRg==
X-Gm-Message-State: AOJu0YzsLCgbnZ9PZ5i5k7yJSPH4BA9Aun9bpqIn9ouKTufFDm7Dm6oR
        yY6zyW94vZNStmlEGMevnKA=
X-Google-Smtp-Source: AGHT+IEGUEKllE6snxZ0ydVaACU86gYvyO801qw/abUe/oKyFe/KQsWgHCpE56aN1XWFayfNJZOUoQ==
X-Received: by 2002:adf:e784:0:b0:319:6d91:28c2 with SMTP id n4-20020adfe784000000b003196d9128c2mr4963676wrm.61.1692046718732;
        Mon, 14 Aug 2023 13:58:38 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id h5-20020adffa85000000b003197efd1e7bsm2161806wrr.114.2023.08.14.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:58:38 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v11 1/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Mon, 14 Aug 2023 21:57:14 +0100
Message-Id: <20230814205719.79647-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add Andes Technology to the vendors list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v10 -> v11
* No change

v9 -> v10
* Included TB tag from Conor

v8 -> v9
* Included RB tag from Geert

v7 -> v8
* No change

v6 -> v7
* No change

v5 -> v6
* No change

v4 -> v5
* Included RB tags

RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/vendorid_list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index cb89af3f0704..e55407ace0c3 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -5,6 +5,7 @@
 #ifndef ASM_VENDOR_LIST_H
 #define ASM_VENDOR_LIST_H
 
+#define ANDESTECH_VENDOR_ID	0x31e
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
-- 
2.34.1

