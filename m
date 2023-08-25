Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2D788F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHYTsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHYTsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:48:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6512686
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:47:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0db66af1bso6451155ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692992876; x=1693597676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2eAlo9fjSE47gDq8UwikbKqRdW2epxnqoMlapicBOVo=;
        b=MV8ZmLMqm57BRXUhrO2ABSba51WklkZbfUG7qXPOI6PbKD2UpMX1hwBOpogM5aLFcz
         tqTE08LFvVbtEYund8FpK1ozaGBHElO/yhTJIQFm+JJOwiljVWmn4w1Ez6liFk1zQFJo
         BijH78sFlvk9b9/WxKTD03v6b9U2mb+qZW7PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692992876; x=1693597676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eAlo9fjSE47gDq8UwikbKqRdW2epxnqoMlapicBOVo=;
        b=DUXIeXpgrrf+nqhyNCnCiyTlOHeGDtoVWIirUra4yoyVV9fYXV4Mig2/SjdYIf/v8q
         rngxVT+p4LNiDjeqMYfDHz2dePwymUiyWXFTxwqjwqBukSxfJYP30/dkCaZWRE0mpdtj
         79KofzVRS54HlWziaFNBdRHB1StTx9No85F6XvrZNRpbXW84EUQzhjL1B3D8PoaYG4yu
         u5xc5ptFAs5cwySYSz2CQ5aL9+jRIrlLfejkJXpo550zo6iecv20DCvN2xSbJSiRuUws
         DDhONwA52t1BxdrDV+xY6h6XY9YJPG5/ratiYZ0q3kQGcnGzmDAL7rPefq6VxaNOIxb8
         rxoA==
X-Gm-Message-State: AOJu0YxkZaayUSnk9PZ8v9Knc2ScjO/VJ2GKuCNHVit4sAAvQ+8dDp/9
        Ib3W+kMenXP1zacFmeNXEvGyn59V0pqF6tUFnPI=
X-Google-Smtp-Source: AGHT+IGxcpanMsKBVZgKv/Yq93mXGufH+Af8FwFxALkGKO/g/5fDq3MRLYBXtsa8BQ/uRSV5+dgzUQ==
X-Received: by 2002:a17:902:f68a:b0:1b8:2ba0:c9c0 with SMTP id l10-20020a170902f68a00b001b82ba0c9c0mr19091463plg.59.1692992876671;
        Fri, 25 Aug 2023 12:47:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001bdc209b9a0sm2127104plk.201.2023.08.25.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:47:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] kbuild: Show Kconfig fragments in "help"
Date:   Fri, 25 Aug 2023 12:47:51 -0700
Message-Id: <20230825194329.gonna.911-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5155; i=keescook@chromium.org;
 h=from:subject:message-id; bh=v1dFNPv8CIhPkvxYivSEa1AvUQm838lqlgbgtyuDhao=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk6QVpcTKUn7qqPn10MgMfRhkYIt+AsVuNBKMPQ
 xjEfa7v0KOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZOkFaQAKCRCJcvTf3G3A
 JiiXEACuT7VwLDIoXTeIecrMyMglPUbKPt7yUzWO3/54TGsSft96acY1dzB1vA7qrGa9t1Cdo9v
 R13OX57o0IJT2V2rlOgzIcV672EkcYj8onx7ErDcMmui0FpMoy7PxyJQlbMuF/va0qIrTAABk/c
 7FVHlMtL8QNfzwffmzL3/prEJ1FOVTerYWIdlzsoUtxqY2tRQT9XNW+91QKmKXwu5wuV0LtbZHe
 LJXY8jOpoAqoRh8LfxuVxYyzHhX2rnsxIZV4PpW/MurNesETGNW27Axnw6zDS3SURGqdSM8rK8o
 5ba5fSaoDMTza0TNdMdDLe0MaeC5v/YkHK5+W3ymGNF/xCIq0k5npCjRtifmrUabKOtznAM5UyD
 b+vijr2Ppt5ibT7kha8c1gx+OcPvz8Q8wbguQxUhMDJrwyO+dZ6E5YjMyrYqZwYyM5IsPFZ1bdG
 oHZDtbyRinFIIK7R4E3eaID7Ln+ugtxStkmhOXE/wla3uiFkjs8MB6Ng7HZbW+SOxY5lW4u8rE0
 yIYiPlxv9dcZV78jyYILn15t8EIDWR+BXJKIntgzqwTrHXIrGnVpMny3qjFs2m8AotyH3mAqXKX
 3Xnv6M5GUGn4L2vIRCvJeyzyrhxv6H9oJFtsb8GgriE+578mNn9MnTFC+RnySu6r9pgT9oyIpjJ
 hRc0FPP 4F/47bRw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is my series to show *.config targets in the "help" target so these
various topics can be more easily discoverd.

v2:
 - split .fragment from .config to hide "internal" fragments
 - fix various typos
 - avoid duplicate entries
v1: https://lore.kernel.org/all/20230824223606.never.762-kees@kernel.org

Thanks!

-Kees

Kees Cook (2):
  kbuild: Show Kconfig fragments in "help"
  kbuild: Split internal config targets from .config into .fragment

 Makefile                                      |  1 -
 arch/arm/configs/dram_0x00000000.config       |  1 +
 arch/arm/configs/dram_0xc0000000.config       |  1 +
 arch/arm/configs/dram_0xd0000000.config       |  1 +
 arch/arm/configs/lpae.config                  |  1 +
 arch/arm64/configs/virt.config                |  1 +
 arch/powerpc/Makefile                         | 26 +++++++++----------
 .../{32-bit.config => 32-bit.fragment}        |  1 +
 arch/powerpc/configs/64-bit.config            |  1 -
 arch/powerpc/configs/64-bit.fragment          |  2 ++
 ...{85xx-32bit.config => 85xx-32bit.fragment} |  1 +
 ...{85xx-64bit.config => 85xx-64bit.fragment} |  1 +
 .../{85xx-hw.config => 85xx-hw.fragment}      |  1 +
 .../{85xx-smp.config => 85xx-smp.fragment}    |  1 +
 .../{86xx-hw.config => 86xx-hw.fragment}      |  1 +
 .../{86xx-smp.config => 86xx-smp.fragment}    |  1 +
 arch/powerpc/configs/altivec.config           |  1 -
 arch/powerpc/configs/altivec.fragment         |  2 ++
 arch/powerpc/configs/be.config                |  1 -
 arch/powerpc/configs/be.fragment              |  2 ++
 .../{book3s_32.config => book3s_32.fragment}  |  1 +
 ...enet_base.config => corenet_base.fragment} |  1 +
 arch/powerpc/configs/debug.config             |  1 +
 arch/powerpc/configs/disable-werror.config    |  1 +
 .../configs/{dpaa.config => dpaa.fragment}    |  1 +
 ...mb-nonhw.config => fsl-emb-nonhw.fragment} |  1 +
 .../configs/{guest.config => guest.fragment}  |  1 +
 arch/powerpc/configs/le.config                |  1 -
 arch/powerpc/configs/le.fragment              |  2 ++
 ...85xx_base.config => mpc85xx_base.fragment} |  1 +
 ...86xx_base.config => mpc86xx_base.fragment} |  1 +
 .../{ppc64le.config => ppc64le.fragment}      |  1 +
 arch/powerpc/configs/security.config          |  4 ++-
 arch/riscv/configs/32-bit.config              |  1 +
 arch/riscv/configs/64-bit.config              |  1 +
 arch/s390/configs/btf.config                  |  1 +
 arch/s390/configs/kasan.config                |  1 +
 arch/x86/Makefile                             |  4 ---
 arch/x86/configs/tiny.config                  |  2 ++
 {kernel => arch/x86}/configs/x86_debug.config |  1 +
 arch/x86/configs/xen.config                   |  2 ++
 kernel/configs/debug.config                   |  2 ++
 kernel/configs/kvm_guest.config               |  1 +
 kernel/configs/nopm.config                    |  2 ++
 kernel/configs/rust.config                    |  1 +
 kernel/configs/tiny-base.config               |  1 -
 kernel/configs/tiny-base.fragment             |  2 ++
 kernel/configs/tiny.config                    |  2 ++
 kernel/configs/xen.config                     |  2 ++
 scripts/Makefile.defconf                      | 12 ++++++---
 scripts/kconfig/Makefile                      | 16 +++++++++---
 51 files changed, 87 insertions(+), 32 deletions(-)
 rename arch/powerpc/configs/{32-bit.config => 32-bit.fragment} (53%)
 delete mode 100644 arch/powerpc/configs/64-bit.config
 create mode 100644 arch/powerpc/configs/64-bit.fragment
 rename arch/powerpc/configs/{85xx-32bit.config => 85xx-32bit.fragment} (76%)
 rename arch/powerpc/configs/{85xx-64bit.config => 85xx-64bit.fragment} (78%)
 rename arch/powerpc/configs/{85xx-hw.config => 85xx-hw.fragment} (98%)
 rename arch/powerpc/configs/{85xx-smp.config => 85xx-smp.fragment} (59%)
 rename arch/powerpc/configs/{86xx-hw.config => 86xx-hw.fragment} (98%)
 rename arch/powerpc/configs/{86xx-smp.config => 86xx-smp.fragment} (58%)
 delete mode 100644 arch/powerpc/configs/altivec.config
 create mode 100644 arch/powerpc/configs/altivec.fragment
 delete mode 100644 arch/powerpc/configs/be.config
 create mode 100644 arch/powerpc/configs/be.fragment
 rename arch/powerpc/configs/{book3s_32.config => book3s_32.fragment} (52%)
 rename arch/powerpc/configs/{corenet_base.config => corenet_base.fragment} (64%)
 rename arch/powerpc/configs/{dpaa.config => dpaa.fragment} (80%)
 rename arch/powerpc/configs/{fsl-emb-nonhw.config => fsl-emb-nonhw.fragment} (98%)
 rename arch/powerpc/configs/{guest.config => guest.fragment} (85%)
 delete mode 100644 arch/powerpc/configs/le.config
 create mode 100644 arch/powerpc/configs/le.fragment
 rename arch/powerpc/configs/{mpc85xx_base.config => mpc85xx_base.fragment} (94%)
 rename arch/powerpc/configs/{mpc86xx_base.config => mpc86xx_base.fragment} (86%)
 rename arch/powerpc/configs/{ppc64le.config => ppc64le.fragment} (65%)
 rename {kernel => arch/x86}/configs/x86_debug.config (90%)
 delete mode 100644 kernel/configs/tiny-base.config
 create mode 100644 kernel/configs/tiny-base.fragment

-- 
2.34.1

