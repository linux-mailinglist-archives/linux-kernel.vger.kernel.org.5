Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9D7F9FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjK0MtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjK0MtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:49:07 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED0AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:49:13 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce353df504so2618048a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701089351; x=1701694151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieu48mWtx/AGY7G3tD2fY03z7c/nOBNRos6wLlP3Rhs=;
        b=np6Bzfs7VqLuzB0Pwt1IMBfQSZWLV9titUtXgmF0iy5eNzaK6/ufg0S/df9HYIEOCi
         5jc5jwyCk4LlkqOysOZlS+xgAl79gVlDNy80EcD3hmRFfSY6BTTWQC5xdcteYfQLU2go
         /gLDm4kBE6Ab77GONaitouuPsbt0Iq0PHPt9nR1YqVXzxxiAoeo8D5raJcAqiT5c/28Z
         JQhZZ5v2D8p7aiOyvEARMpg2FVey7asKHsauQI9vI+zuNeqOSXSVUXYX7oapQmLocJdJ
         G/Icouy/+EX/QozKdokCD+tlxAn8WrKWa1/RqUYxGsu7zenGoXvqV+oF1M0EA68P9kjZ
         1qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089351; x=1701694151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ieu48mWtx/AGY7G3tD2fY03z7c/nOBNRos6wLlP3Rhs=;
        b=HC/oTffLQF2qIcQt4C84UThtaCpaKDYbh/On/1jyJ5jQfEZd46H3a53oApJjv9yHEL
         D/wyFKsgKnF6Xi+TJ1LgmyR7Rok7tOLi315Jt5WN/SaJmUFzPXCuSbWteLIYWLBZQAp4
         +/Kpw70X9OLZt+4igCCZ0e4jWXSpmCVTKQjWPR8mF4b+/WGljeaGBTtpnHAmMo3hnlw+
         jKBQ0T+892X/omDYTYMX8iZXLsxRE7F1F2PTOPGkFnpHXPUhl9MNKQpGB99HWJ/zxYXO
         dlaOHTzIOTkS9v20qnEP0e7ItBNj5xyqq0Nuk6wsWqsQgnOwW/sTtpiQLM07qkpBhIBm
         oprQ==
X-Gm-Message-State: AOJu0YwP53gC2HgNXu2pAEdnJ+bkEkyacHkVSTGf54RWENWrulP5VGfv
        sKsfsKuGcGMDS667hWv02Emv2226dZPI
X-Google-Smtp-Source: AGHT+IHpwfLDGqEfzXdyVNiIShg7gjONi0qKZfuJnvp+fS9YWPg9LMAOQMDjuLXpnpIA037Qg5nMHg==
X-Received: by 2002:a05:6870:213:b0:1f4:b1d6:573f with SMTP id j19-20020a056870021300b001f4b1d6573fmr14385524oad.13.1701089351668;
        Mon, 27 Nov 2023 04:49:11 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d75d9000000b006d7f6adcbb6sm1309861otl.78.2023.11.27.04.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:49:11 -0800 (PST)
From:   Ted Chen <znscnchen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        Ted Chen <znscnchen@gmail.com>
Subject: [PATCH] x86/ioremap: Combine prot calulation in __ioremap_caller()
Date:   Mon, 27 Nov 2023 20:48:48 +0800
Message-Id: <20231127124848.90361-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine prot calculation in __ioremap_caller() to make code more readable.
There's no need to handle pcm for UC-, WC, WT separately.

No functional change expected.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
 arch/x86/mm/ioremap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d279321ea..6179921df3b1 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -271,16 +271,9 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 				cachemode2protval(_PAGE_CACHE_MODE_UC));
 		break;
 	case _PAGE_CACHE_MODE_UC_MINUS:
-		prot = __pgprot(pgprot_val(prot) |
-				cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS));
-		break;
 	case _PAGE_CACHE_MODE_WC:
-		prot = __pgprot(pgprot_val(prot) |
-				cachemode2protval(_PAGE_CACHE_MODE_WC));
-		break;
 	case _PAGE_CACHE_MODE_WT:
-		prot = __pgprot(pgprot_val(prot) |
-				cachemode2protval(_PAGE_CACHE_MODE_WT));
+		prot = __pgprot(pgprot_val(prot) | cachemode2protval(pcm));
 		break;
 	case _PAGE_CACHE_MODE_WB:
 		break;
-- 
2.25.1

