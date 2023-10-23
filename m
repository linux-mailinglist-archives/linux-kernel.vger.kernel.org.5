Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C021D7D2CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjJWIbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJWIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:30:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA36D7F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so2155755b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049829; x=1698654629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwqRYcNnh3bL2bnUHbsBXwm7mmQqzZo0pVLQzAgbeF0=;
        b=ZIJ3GaaKbcga50C/dczsvfOIZV8U+JvyFtPaKRxNMgLu+KiqGYMhAuw9avgnk2yeLy
         QbP+xyj7FkSP5VtNlHnJU3B3WNh+9ZN8GudRSuoeLVkfdEpCj4VI1t0eedIL2S9HKTAQ
         JwI1VKPPYAMvmo42+zqvG2EiubACFBU25T1aTw6UNruI+zHShNBsD9+pcH399WQ8y2kT
         utVRjCq4num5qoPFTx70Wu8FPRJcTvvn8KKygVbqPFyQF7/U49hwMwZaqFpOYGxNs3Hd
         LfUB0+Li3YduCbfadzRq8Gv1ymQPz+gW+jhWZnXHiG/ur5TyQRk+4neH/SbnuV5WmXq/
         /tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049829; x=1698654629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwqRYcNnh3bL2bnUHbsBXwm7mmQqzZo0pVLQzAgbeF0=;
        b=ihWK3M5ys8WzQSut+0G6tssraBCjuIy/uNGHd0NdAydjX3fnV+9IspqKaXyNpwhmaD
         GilFsKf8aYI5Hi0Y2H8yC2/RpuTf9OSHbYwZain/wMiCr2C9tECG3ylZ6yH4cemWkMNs
         WYRAlKhtnQtZ68K3VZU5mFQd5Y5jM+/PbSLNR4EMuPKujOBhnIpNiPsav+IfFAzLfCcH
         ldmJC0BBpvxhHWfgYFBRAkn8siaE626uCll4oKViDakWziEEk7tcymf3jo66oQnx8Las
         lExMAiqHceegs+kVBQwb4UFWtgZvF6+Bu2hCVIrqgiuGTGsIi2vXq4HChdBIpcw2FMuW
         rCiw==
X-Gm-Message-State: AOJu0YxzMkFwo/TGjdCOkpvdBcGtDkP6iPmawvQU8Wg5E/dbYqBXIjCu
        P6TwgyA/eE2mJ3Q9Z1OrDZztXw==
X-Google-Smtp-Source: AGHT+IGyFbUXBRXdZQh2eZcjKZcfVc6v/Ld3/FBhlNzBXs9NtpZ6v0cDf/3miDn1ZPth5cbBQ//TYA==
X-Received: by 2002:a05:6a21:498b:b0:17b:d39c:1d6 with SMTP id ax11-20020a056a21498b00b0017bd39c01d6mr5328684pzc.30.1698049829431;
        Mon, 23 Oct 2023 01:30:29 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.30.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:30:28 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 12/12] riscv: Enable CONFIG_RISCV_PSEUDO_NMI in default
Date:   Mon, 23 Oct 2023 16:29:11 +0800
Message-Id: <20231023082911.23242-13-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables CONFIG_RISCV_PSEUDO_NMI in default. Now pseudo NMI
feature is defaultly enabled on RISC-V.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 487e4293f31e..ecccdc91563f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -672,7 +672,7 @@ config RISCV_BOOT_SPINWAIT
 config RISCV_PSEUDO_NMI
 	bool "Support for NMI-like interrupts"
 	depends on !RISCV_M_MODE
-	default n
+	default y
 	help
 	  Adds support for mimicking Non-Maskable Interrupts through the use of
 	  CSR_IE register.
-- 
2.20.1

