Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D4E770D27
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjHEBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjHEBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:41:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A54EE3;
        Fri,  4 Aug 2023 18:41:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bcd6c0282so371066966b.1;
        Fri, 04 Aug 2023 18:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691199663; x=1691804463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrZhJuBZ/p/kB7eAJ7wkZMXYy4z27d7SxCkdQYoXcFI=;
        b=e2LSsMwpTbJj+0y1OvB21AZNJedoyaE9xVEN1I9/z8k3TRz6eyC1li3j6FXDW9oarE
         mwo9HQkx0Sz8aGXnhsxmcHLWSuvRwutOd6il8SS3+j5lYhKJEC3Q8n4gj2L/5B1VTVsA
         mBmbwUuQSjZT5StcXvUjUfwGEqE7JsV//ZAnJofF4XrwCB7MzlvJuR8avxEIRcAlHuBr
         hMhtWxFA671d7Rk7xfzkAJrFXllL/oFMWrMECJiR7WS2y2tB0f3RC5fjpdZhyy3gz1zI
         6rkJNKZtD3+OIt1DuDlHLEWzPSBJH/8USSD1bVHnio9rwXC8SohaAd1oi9j3pVssBb40
         gjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691199663; x=1691804463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrZhJuBZ/p/kB7eAJ7wkZMXYy4z27d7SxCkdQYoXcFI=;
        b=PItIjhN0wQlg49DWp191RCTAXeww/kaCUPGAKAenp+4rtjSsapcRTVP75cXiPOzr5v
         UV41OBz6HshFTT4G1Bq4mLc19i4st5Ak71ZCddmrE+987WYXj+ErAgwa4AQZh0rCpBjN
         yL6/PU9To2HGyeuJscs3fts15rBkJY4ugrYIkobbZyHTxyoDVP3zNzkkqvwb+UAkoaLn
         zvQSMB5ZC4A8Sk1n+XLJML0ftbKtHZupiFmVVtusVbJZo0IKqaUvojMSVuooB+P8TI7t
         5M2D155ti6vdOUPunJmNzci0CThWBtwqfsZZzrg6Hf2gjorHOUV5Nxf1c0c8BxFfs/r/
         jXsA==
X-Gm-Message-State: AOJu0Yw+0P5kMFEs3p+p3APEc5CbSiBKdZoa3Sgr8VE7h2RczngMr+tv
        OQX59TqXNRCzzM0DEGTvhqMIkUW+Z2wpUw==
X-Google-Smtp-Source: AGHT+IERod05hJXo6cGKkuv7I0uKIK3EqzY5zJp3dDkZClt35v/1PgD+YVyvqoOsNE9m2TfbK+SiYg==
X-Received: by 2002:a17:906:5193:b0:994:4095:3abf with SMTP id y19-20020a170906519300b0099440953abfmr2842128ejk.14.1691199663279;
        Fri, 04 Aug 2023 18:41:03 -0700 (PDT)
Received: from f.. (cst-prg-21-219.cust.vodafone.cz. [46.135.21.219])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906520400b0099bd7b26639sm2052397ejm.6.2023.08.04.18.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 18:41:02 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     surenb@google.com
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm: move dummy_vm_ops out of a header
Date:   Sat,  5 Aug 2023 03:40:55 +0200
Message-Id: <20230805014055.1280320-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Otherwise the kernel ends up with multiple copies:
$ nm vmlinux | grep dummy_vm_ops
ffffffff81e4ea00 d dummy_vm_ops.2
ffffffff81e11760 d dummy_vm_ops.254
ffffffff81e406e0 d dummy_vm_ops.4
ffffffff81e3c780 d dummy_vm_ops.7

[if someone has better ideas where to put it, please move it]

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/mm.h | 6 +++---
 mm/init-mm.c       | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..14898e76bbf1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -756,17 +756,17 @@ static inline void vma_mark_detached(struct vm_area_struct *vma,
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+
 /*
  * WARNING: vma_init does not initialize vma->vm_lock.
  * Use vm_area_alloc()/vm_area_free() if vma needs locking.
  */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
-	static const struct vm_operations_struct dummy_vm_ops = {};
-
 	memset(vma, 0, sizeof(*vma));
 	vma->vm_mm = mm;
-	vma->vm_ops = &dummy_vm_ops;
+	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
 	vma_numab_state_init(vma);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index efa97b57acfd..cfd367822cdd 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -17,6 +17,8 @@
 #define INIT_MM_CONTEXT(name)
 #endif
 
+const struct vm_operations_struct vma_dummy_vm_ops;
+
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
  * at the end of the structure, the size of which depends on the maximum CPU
-- 
2.39.2

