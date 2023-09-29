Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69B57B295A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjI2AHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjI2AHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:07:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B4F3;
        Thu, 28 Sep 2023 17:07:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40652e5718cso11559195e9.3;
        Thu, 28 Sep 2023 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695946060; x=1696550860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm3MReQA9cm+BZNe/kSQElihaB6e5dEwV1F0BtOWf0o=;
        b=ITGTgJoRQLNlLtPH9M7dMqi7/bsE5FvLQPby41FDoBZfe1hCZWTRM7tyTjPS8ysCeK
         ZZ4EcSPiUt/MwqsXgq8qVON+fcn7ZxSLh0Sy6FmMuQfk2MbGbEFV3/955xpTayPhnb0K
         gALwfqvP8TsmMcNV6rI8KefQZu5FeyhvdKCJHfVjdr1z0LsZcz79v43XiIiSkraosEvn
         3g8jGMvJQFYClTyThYeTGxV5GykC3bb9UXhQ5E2iSHCC5PaO63bew/qlL6UdYd2g7KxH
         0w0cCHUEMbx7Ir+z+bC7QiRAm8hsswymQfQdFPgPZ+but7480oW8Gfhm2t9rdIztO4px
         Bdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946060; x=1696550860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pm3MReQA9cm+BZNe/kSQElihaB6e5dEwV1F0BtOWf0o=;
        b=eNJVde9x/CGOk+zO0myolUBrgiA01OhC8zlb0ATq/uHceSQ/XiXWHzbcdVoqZoWGkz
         PZISvHvYP38PZUc2OB7WE4zK9U9l9DCXM04VsqdFfOaJVCoOStpEjQ8+6jmV2whegy7I
         W8yOgZa5PM5P5KqE2UUonPW2Z22iErKJEynDDJ96XOkVu4We7bDGnzbrAdrZlMNWuLZs
         wWY15pL7QNZ7ap1ASxGWWp0aKAwFkQJ0XblUtHNufiChrtfLiPT7iKyR7Hr22dK2TRgG
         G/LHS9Qz/xCsIaSItyMXkl3rcnYLxjE4UuCqOtkUhrA0VNHDhbEhhr2S+JUwkymMdRUQ
         62FQ==
X-Gm-Message-State: AOJu0Yw+lDw8HcASwZOXXElzHlv9O0E0eD0a93zFX6dBsbpYMbh02Bf1
        G+KHgBFS983CKSRa43tgXWo=
X-Google-Smtp-Source: AGHT+IFWzGmco5cPbyfqxkrqCJyu84aUIbOKGKp+ve4yALFAWxrMQaa4gbTmfwoH8DYCTzRn8jum7g==
X-Received: by 2002:a05:600c:252:b0:403:b64:ad0a with SMTP id 18-20020a05600c025200b004030b64ad0amr2423544wmj.26.1695946060336;
        Thu, 28 Sep 2023 17:07:40 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fe98:5e2c:1821:4cb6])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b004030e8ff964sm245667wmj.34.2023.09.28.17.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:07:39 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/5] riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
Date:   Fri, 29 Sep 2023 01:07:01 +0100
Message-Id: <20230929000704.53217-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

RZ/Five is a noncoherent SoC so to indicate this add dma-noncoherent
property to RZ/Five SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index c8d63a8f7d86..b0796015e36b 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -43,6 +43,7 @@ cpu0_intc: interrupt-controller {
 };
 
 &soc {
+	dma-noncoherent;
 	interrupt-parent = <&plic>;
 
 	plic: interrupt-controller@12c00000 {
-- 
2.34.1

