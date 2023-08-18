Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2E780D40
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377534AbjHRN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbjHRN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:57:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3063F4202;
        Fri, 18 Aug 2023 06:57:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fedba79923so712625e9.2;
        Fri, 18 Aug 2023 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692367057; x=1692971857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZWgrNspKoB0gULl9FriOTlRKkFCV7w76E4xQuu9Nl0=;
        b=KexVFDCysQJSKwqA2PHchcATu/fVdyN5dzj+MnC9lvuupAvcgUaERaEYU8fXez0XgX
         i43PyJBskBi//E9RB/S6PXpqLnh7lVciHUBjCJrYluBxaugnWRttJsl65oP7BNNKMu+c
         Jo24rl1VRSKWTnOfSNsHzTvaK81unipTMIddNapREu5xSZvMKQsgqda/UV4fJ5eU+FTL
         nunF8fYQsfMs04sEcizsvSn8l33AIieOkPvSKY/WC80+MPb9Q/o9joZ4/hnHvkDL1ExZ
         dASoED2bMcJ5sIRWxELsXgJFK9N9IuhLSu+NhvNxLgGLKjXkZicQt2ladZ9gwnTmZ6Hn
         JJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692367057; x=1692971857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZWgrNspKoB0gULl9FriOTlRKkFCV7w76E4xQuu9Nl0=;
        b=detV1jFpEf+CLRtEKvVlGmTlq+6M/+gEDrCfDLhprd7oBWzaUqViWBEcmMzeTTe37l
         Kcy2jczDFPZc1N1/OJG5ITyagzmqnqAVhRW+DWi0Wzm6jF+g1R6Up3G9JqroDLqxWpsN
         iBu/11/jNTJmEA2WiDi4reyxfaEMYoYebPMziROrrgLob1FJY2N1B1+aqnXW2Bs579Zb
         UqtLFeBUy7JuhYJK/RHdbA04218zRGMeAr+gbdq+0btwFbBzZ3p+5RgSEm40ygZAt2ut
         g4o78GVc/z6UP/vSwCeR8oH6EXlK0YC1Vn+9lY9NaM/XJJBLrLoMKbdkDivJgybI9p6y
         8o6g==
X-Gm-Message-State: AOJu0Yzx/Rb4bXs2wSPLNN/lof1EgKM2CvfYXuUAluK5UhBvLKkunAQq
        UnHQaUV5uzW5xskJVW5KNTA=
X-Google-Smtp-Source: AGHT+IGfQ7eoFxZQPgul7H6egLkGZJmIPP+0IzqWmxmsHEkAGop6rTnMrsK2OAKWZEjHE+l7fbJF1w==
X-Received: by 2002:a7b:c4ce:0:b0:3fa:99d6:47a4 with SMTP id g14-20020a7bc4ce000000b003fa99d647a4mr2214398wmk.22.1692367057449;
        Fri, 18 Aug 2023 06:57:37 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:4b30:13e8:1d57:42fb])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c044e00b003fa96fe2bd9sm6444055wmb.22.2023.08.18.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:57:36 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v12 1/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Fri, 18 Aug 2023 14:57:18 +0100
Message-Id: <20230818135723.80612-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add Andes Technology to the vendors list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v11 -> v12
* No change

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

