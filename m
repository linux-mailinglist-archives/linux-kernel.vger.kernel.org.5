Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FEE7A8CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjITT2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjITT2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F5CF;
        Wed, 20 Sep 2023 12:28:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so388987e87.2;
        Wed, 20 Sep 2023 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238103; x=1695842903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSZwUqk2LhSLToURZdxj4BC7qr/BbA6pyW8daToL0QU=;
        b=GOGFa5ZnwkOyvD39t7dB/bRq9FH81IB5xGCcpy2qCyGmjF1ZGJ/kqJeMUCXPgqg9hB
         uhjgGHAlfQW2mO6E03NCubxWAhGFvOnuoozdEreTErIEXUZEasazSd54ECyuB6mlCJS7
         Q8iUhktLkOy5RNY4K26Ed6S3rWbOKU4r0LT/9j1C4KLU/gnwJi2EzEp5mCopfVhHsRgq
         zg23FUo8xdtL0LgWoFIyDFypEwwxaAqe09ONTJM6YLmzTk2McnB1uOh3Jvg4p8F/c+2a
         YkvLEqh/9zCzpLvBqoLgJaDDR+i06Bi3FRjYEKsMePj7n/qA+F+Iw5KYBLCScjJp/tTU
         4brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238103; x=1695842903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSZwUqk2LhSLToURZdxj4BC7qr/BbA6pyW8daToL0QU=;
        b=uxfS3YSwyoCsI8+h9kLVqRgwCnLwBMrVfUYaqk60TPWCKW59sYiwRPvdO3w5+OGmR3
         uXSWDvk4efaKXuLKqnBNBRjV4wzaf3azYl4xyjnfgiNi3OMYXgFRP0oQ+LFKIo3WJ15V
         dJz+apn1Ft0+IRLzDG7hGfj1KBtP92jUzwNYoMnI5losoQ2GIMCrXAVuZnJrATnkcYsj
         Kf13TwhkP26o7IjOz9iVDEAQ1p0vmsfBleAl4PN9MsIEaj4qlZgrygEwEcyhxUa9tt0Q
         0UlCzlXLCSYsH5PEs+MNNrwQHIbPWzfngG9hCar9rwwQkmGV75QLO3WtjIwMtkJYVOpa
         Q2+g==
X-Gm-Message-State: AOJu0YxaYBmmJBaUjYFXaKG4v22Sze7WwBREWMrQAg5hqKxwBfVat7mk
        C6FZg6vNUOhhJZILbyWiTQE=
X-Google-Smtp-Source: AGHT+IHu9ipPueyvMIh6eHJbINo45HFjPnT1i9SCVvpQktfQ6hYhHXC08wGvzUA0gWFFZYqbkjqqLQ==
X-Received: by 2002:a19:ca03:0:b0:500:b42f:1830 with SMTP id a3-20020a19ca03000000b00500b42f1830mr2620543lfg.63.1695238103285;
        Wed, 20 Sep 2023 12:28:23 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id i25-20020a056512007900b0050332394bcasm802769lfo.150.2023.09.20.12.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:22 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/18] EDAC/mc: Extend memtypes with LPDDR(mDDR) and LPDDR2
Date:   Wed, 20 Sep 2023 22:26:47 +0300
Message-ID: <20230920192806.29960-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These are normal memory types [1] which can be met on the real hardware.
DW uMCTL2 DDRC IP-core can be configured to have them supported [2,3].
Extend the EDAC memory types enumeration with the corresponding IDs then.

[1] https://en.wikipedia.org/wiki/LPDDR
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.501
[3] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.1717

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/edac_mc.c | 2 ++
 include/linux/edac.h   | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 634c41ea7804..e353e98e01e2 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -151,10 +151,12 @@ const char * const edac_mem_types[] = {
 	[MEM_RDR]	= "Registered-SDR",
 	[MEM_DDR]	= "Unbuffered-DDR",
 	[MEM_RDDR]	= "Registered-DDR",
+	[MEM_LPDDR]	= "Low-Power-(m)DDR-RAM",
 	[MEM_RMBS]	= "RMBS",
 	[MEM_DDR2]	= "Unbuffered-DDR2",
 	[MEM_FB_DDR2]	= "FullyBuffered-DDR2",
 	[MEM_RDDR2]	= "Registered-DDR2",
+	[MEM_LPDDR2]	= "Low-Power-DDR2-RAM",
 	[MEM_XDR]	= "XDR",
 	[MEM_DDR3]	= "Unbuffered-DDR3",
 	[MEM_RDDR3]	= "Registered-DDR3",
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..89167a4459d5 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -157,6 +157,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  *			This is a variant of the DDR memories.
  *			A registered memory has a buffer inside it, hiding
  *			part of the memory details to the memory controller.
+ * @MEM_LPDDR:		Low-Power DDR memory (mDDR).
  * @MEM_RMBS:		Rambus DRAM, used on a few Pentium III/IV controllers.
  * @MEM_DDR2:		DDR2 RAM, as described at JEDEC JESD79-2F.
  *			Those memories are labeled as "PC2-" instead of "PC" to
@@ -167,6 +168,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  *			a chip select signal.
  * @MEM_RDDR2:		Registered DDR2 RAM
  *			This is a variant of the DDR2 memories.
+ * @MEM_LPDDR2:		Low-Power DDR2 memory.
  * @MEM_XDR:		Rambus XDR
  *			It is an evolution of the original RAMBUS memories,
  *			created to compete with DDR2. Weren't used on any
@@ -199,10 +201,12 @@ enum mem_type {
 	MEM_RDR,
 	MEM_DDR,
 	MEM_RDDR,
+	MEM_LPDDR,
 	MEM_RMBS,
 	MEM_DDR2,
 	MEM_FB_DDR2,
 	MEM_RDDR2,
+	MEM_LPDDR2,
 	MEM_XDR,
 	MEM_DDR3,
 	MEM_RDDR3,
@@ -230,10 +234,12 @@ enum mem_type {
 #define MEM_FLAG_RDR		BIT(MEM_RDR)
 #define MEM_FLAG_DDR		BIT(MEM_DDR)
 #define MEM_FLAG_RDDR		BIT(MEM_RDDR)
+#define MEM_FLAG_LPDDR		BIT(MEM_LPDDR)
 #define MEM_FLAG_RMBS		BIT(MEM_RMBS)
 #define MEM_FLAG_DDR2		BIT(MEM_DDR2)
 #define MEM_FLAG_FB_DDR2	BIT(MEM_FB_DDR2)
 #define MEM_FLAG_RDDR2		BIT(MEM_RDDR2)
+#define MEM_FLAG_LPDDR2		BIT(MEM_LPDDR2)
 #define MEM_FLAG_XDR		BIT(MEM_XDR)
 #define MEM_FLAG_DDR3		BIT(MEM_DDR3)
 #define MEM_FLAG_RDDR3		BIT(MEM_RDDR3)
-- 
2.41.0

