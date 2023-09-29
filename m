Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC47B2962
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjI2AHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjI2AHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:07:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427AB180;
        Thu, 28 Sep 2023 17:07:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so33732875e9.0;
        Thu, 28 Sep 2023 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695946062; x=1696550862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QykmGOhFH5Jg2YbpjBw5TT8uCu2shmkEPyDr16ah5mo=;
        b=gzZNZaN9YLQXtDOgmzrITqdifrwrXZtF/B2/wdcbjbhKI1cwZ42Oq4K74l5zlB3Enc
         ODVidH1NDX/RvcXIyhmu7rbuNxB8IKN1JEajk7q9+ONkZaGg9Zlou8iQG1gH1iaN5ssa
         HMGSVVhmTDF7QCZ64Fs4nJBOfabD0MwHWBGHxnYI9ZFeQ5KmzukInNjRdf1JnVZbPckZ
         pW+uvrhAhNZBReooCHggAcgpo5llwE+h0vfcNu/aok0EKEKb1loE2FnaOVlBnruBYf6v
         uj1215D8zpg6Vh6+qgh5qmsp+P47wPpk8bjm97vCzF/5UCgI1+63J/MiYk8M01A6l0C5
         FgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946062; x=1696550862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QykmGOhFH5Jg2YbpjBw5TT8uCu2shmkEPyDr16ah5mo=;
        b=RcPFumi52wFM6kfbbKRXOrD2UVlCbrNowORzjEwlupDA+FU1FVxv3RgicTAsL/nD4G
         OFRYoreInaW2lbDIG9HP2dT4lC5/ovAJoBNMAWPUuAOBmPaKgD1/9HJRaJse955nZalt
         EniLJBynJacb6SfoQ8UrakBLbCEGR2IqTHQLefiucR7LEffyLodT2ZWM0c9bHNCKc91V
         KHPvVBz7XGdFExbmwytIN1LFV08R6rS4vI0+V/ugUorY/fHdltSHhWc1dqOek+gR3RqP
         SLv0d8lxr6G3SYf9rfHKzbyhMIx2lIO9Tak+bIuVX5XqBsV+YyTbimLDwDusaHniCUc9
         qaXg==
X-Gm-Message-State: AOJu0YxH5p4lC06RCDMVIdTCoyfwQ5XQnwpdxT/oUu/Te6KOiKBkG0wN
        KdVfsfiQfKnmUDo51a39YZE=
X-Google-Smtp-Source: AGHT+IGcyD2e2QJk+LbGAQCmTqrP38BeiU/fWbbAOj645xzShm9qaJzxb8HaVmLacKAeJbhw5CVjJw==
X-Received: by 2002:a05:600c:21c5:b0:406:45c1:a657 with SMTP id x5-20020a05600c21c500b0040645c1a657mr2522204wmj.6.1695946062630;
        Thu, 28 Sep 2023 17:07:42 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fe98:5e2c:1821:4cb6])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b004030e8ff964sm245667wmj.34.2023.09.28.17.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:07:42 -0700 (PDT)
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
Subject: [PATCH 4/5] riscv: dts: renesas: rzfive-smarc: Drop dma properties from SSI1 node
Date:   Fri, 29 Sep 2023 01:07:03 +0100
Message-Id: <20230929000704.53217-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

With DMA enabled audio capture/playback has some echo noise. So for
now switch to PIO mode until fixed.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
index a8573fdfd8b1..85f96e24a96e 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -6,3 +6,8 @@
  */
 
 #include <arm64/renesas/rzg2ul-smarc.dtsi>
+
+&ssi1 {
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+};
-- 
2.34.1

