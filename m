Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5180E197
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjLLC2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjLLC23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:29 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A57F4;
        Mon, 11 Dec 2023 18:28:16 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5e190c4ce5cso7278287b3.0;
        Mon, 11 Dec 2023 18:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348095; x=1702952895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW7aEi7LQrQfNXQqa0tMP+bXSv9DvWRxnTO5wl1idJ4=;
        b=UP2a2USKrShHVJmc1pJ1JxSxP+Uf1oT1csatlzz41PBAewtD9P1DcJKNUlap36t+AD
         wM1pBSk8EugNFNkOSBBeaNRbMzKLPYgT/LUh+t90Nc1Md93dtNBGAkKm+nXVQE8W1oBt
         DdrLAJ6CrKEg5YtnywkJ18RLYs9Ha/i+BPwNpmODqD0hVmgL60kq1H3D5KuPhkWIx3GE
         UOnobVybftCui++I49oc4XLM96HwVHtl5m/qTPnKicau3YnWxWzV+j5YazNxtooC8xcU
         I/Stcrfo+vJ4F65XOBiS7TtuLpl25WmZ38RICcnv8g/2VqHk7u5oTdGMhb/jKzN/J2SZ
         RrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348095; x=1702952895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW7aEi7LQrQfNXQqa0tMP+bXSv9DvWRxnTO5wl1idJ4=;
        b=vxarRVFk130coVv5D4DZy9W2YKN2OK3lvg3BRW+rmj0A54yDG06t07f7shRg512FII
         H78ouAMWEMATHeRhNMrd4X4DdjBAfNh0/blIQ6M8cDEAB8k49B6foKByNB3xwFK8MP0/
         bhllF+EuBGlWbcXWAwlS38BfoV02noWieH09uLO4uC3uGDtXUqtlho/MRUFGYhgm+JFr
         vnldwrXXB7NPnXXwdFL7IfbmMsGckuJTzGcshYxiNdoCmN9lnxFx1xYp7pFx4mGV0xj7
         /OijCe4UWk3VRVl81/tf/QKuzrQlBPAAkY/WjLFROpJ/Rw84REgzk2wrUV900538X5+u
         yVOw==
X-Gm-Message-State: AOJu0YyeaUPNA3dDmZP7FFgS/3QAgSfkGsj1Sk7XQF5d9JYc8zljF4xk
        NQttpwk3CXR0q5wyKHfQUJJM465zD6JzAQ==
X-Google-Smtp-Source: AGHT+IHHWvSQyuABmmeVPTmzsAjYfqzXxwkm0O3x532HPaimszmWMpt+0kSUQrit6p2ttjj/W10lLw==
X-Received: by 2002:a0d:c9c3:0:b0:5d8:164c:7e6c with SMTP id l186-20020a0dc9c3000000b005d8164c7e6cmr4024379ywd.26.1702348094876;
        Mon, 11 Dec 2023 18:28:14 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id ff1-20020a05690c320100b005e173835ffesm557743ywb.105.2023.12.11.18.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:14 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v3 14/35] PCI: hv: Optimize hv_get_dom_num() by using find_and_set_bit()
Date:   Mon, 11 Dec 2023 18:27:28 -0800
Message-Id: <20231212022749.625238-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

The function traverses bitmap with for_each_clear_bit() just to allocate
a bit atomically. Simplify it by using dedicated find_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-hyperv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 30c7dfeccb16..033b1fb7f4eb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3605,12 +3605,9 @@ static u16 hv_get_dom_num(u16 dom)
 	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
 		return dom;
 
-	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
-		if (test_and_set_bit(i, hvpci_dom_map) == 0)
-			return i;
-	}
+	i = find_and_set_bit(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
 
-	return HVPCI_DOM_INVALID;
+	return i < HVPCI_DOM_MAP_SIZE ? i : HVPCI_DOM_INVALID;
 }
 
 /**
-- 
2.40.1

