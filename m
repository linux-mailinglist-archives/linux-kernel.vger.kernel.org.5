Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3531A765D92
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjG0Uq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjG0Uqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:46:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99882D47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fde57684d7so14158905e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690490794; x=1691095594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/2kTGP5bmExpEckq+8Rz1vqcaG4uRUICK5uorcV/EQ=;
        b=BuN5xyW/6weGNXRlIjeHAIrAgftiJaDdwcAFdinE25QOj+gk0KxhfbPi6NDrWScFMY
         VMJS1fp/fwlHj4io7fNeedGnL3Vq6LPtuewysLC8Sjo6xuSSwb5C7A3QVA6pUp3BuGal
         peUgBBXdkLuyAG0r0MtOAu8bJxWihdBSiUkx7+JUoxmU92FDCSc3+a203D99Te3djvrE
         GFjNEAyNZJnsGcpwIVLN7dd8/TClS2qfeDsn0scV9uZaGKj9iuXLvZP5q+GVR9jZNOl4
         uoPcfh3+yJsGI/CKwLu45iuV0qqJWtVosbUaOpv+ylvrytQ2cUfc7YMZnclJk3oiesVt
         HmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490794; x=1691095594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/2kTGP5bmExpEckq+8Rz1vqcaG4uRUICK5uorcV/EQ=;
        b=frvOzM0GhjlH7wz+Y2s9u7rO5iDv1IBP7Y94bM3QteHwrnIsXQ3p6kq83SxTpfhtWF
         DEhetDq/R3iPTwmupCO5f6HuxsUf91bs6qtb9VXP5d+7nsCjW9810GM/Ci0zf26t8CrS
         hSvFdZ0tTKysOaR41PcaMocLtbSlSFyYsvSCzlxCGm7mJMN8MervEdztWpjN3TrPzfEu
         nVCDdAuOUYrJ1IBI9bNzxaeNZZKN2l+Q2cfmg46NylWd3Q+TQ6Z09DFQTDM4xErgXCWx
         eJCj+4tAdwZope0VQOBcL/+zHCzEAr2LRrA5yIWn1v7Hm60VhD4SPlVTTR5HxbHO2tWM
         jW6Q==
X-Gm-Message-State: ABy/qLarESVAETB2HGzxazjrEN7FD3r3QL7i1pd9WNo/Vm7xael1K7/6
        plbcrkQwKm5ZLpTElt6/qdNwjw==
X-Google-Smtp-Source: APBJJlFsQ9jv1pf3Fn+r5CYo5PNZoF1WnIrPiX/ItiAceHqurCAQzDyFXe3uUVsJ5LM8vIz8zQ9d8g==
X-Received: by 2002:a05:600c:21cf:b0:3fd:ee50:d6a4 with SMTP id x15-20020a05600c21cf00b003fdee50d6a4mr141098wmj.17.1690490794119;
        Thu, 27 Jul 2023 13:46:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc401000000b003fc06169abdsm2701400wmi.2.2023.07.27.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:46:33 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v1 3/6] memblock: add parameter to memblock_setclr_flag for selecting memblock_type
Date:   Thu, 27 Jul 2023 21:46:21 +0100
Message-Id: <20230727204624.1942372-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727204624.1942372-1-usama.arif@bytedance.com>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in preparation for setting flags (for e.g. to not initialize
struct pages) on reserved memory region.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/memblock.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index f9e61e565a53..4fd431d16ef2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -897,11 +897,16 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
  * Return: 0 on success, -errno on failure.
  */
 static int __init_memblock memblock_setclr_flag(phys_addr_t base,
-				phys_addr_t size, int set, int flag)
+				phys_addr_t size, int set, int flag, bool reserved)
 {
-	struct memblock_type *type = &memblock.memory;
+	struct memblock_type *type;
 	int i, ret, start_rgn, end_rgn;
 
+	if (reserved)
+		type = &memblock.reserved;
+	else
+		type = &memblock.memory;
+
 	ret = memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
 	if (ret)
 		return ret;
@@ -928,7 +933,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
  */
 int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG, 0);
 }
 
 /**
@@ -940,7 +945,7 @@ int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG, 0);
 }
 
 /**
@@ -957,7 +962,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
 
 	system_has_some_mirror = true;
 
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR, 0);
 }
 
 /**
@@ -977,7 +982,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP, 0);
 }
 
 /**
@@ -989,7 +994,7 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP, 0);
 }
 
 static bool should_skip_region(struct memblock_type *type,
-- 
2.25.1

