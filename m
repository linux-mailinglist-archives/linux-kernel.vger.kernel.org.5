Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CB979C36A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjILC5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbjILC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:57:08 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D68ED48A;
        Mon, 11 Sep 2023 16:20:22 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68fb7fb537dso1598636b3a.2;
        Mon, 11 Sep 2023 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694474047; x=1695078847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG2hvXvpu+CwXLe5RvYP5VHJgs2lpeX9gvCj9Y1+mnw=;
        b=XsDYWwakFO+7jKSteMsIzsz3WXlZtY0GZLnhrshfKBU4uTJMDpcykziyNpmqu8ykF2
         ZnHiOoNjmS0zHiMmAh8rCJqLLlMd8HBrWFb7ttRI8UOHtdeFMTabS6rZZ202wJfmRbaA
         zGSh+/tf8hEQWXqQKGwWtLpgqFifpLG3Ry7SX3SY8rVx8POYpaUPRePy9MULj6Kj86lW
         w3H1L/iRYexbRB2V/PNehEcilp5Ra1MEj0xpTTOwrfg8lfwiHeHOj97U09Nl9d/MoFqz
         pvdcFHA2yyhle4zfuZeH9F3XQGEkRo5bE4LW98+aWNrt/ka5RM+9Sjmhh+cjh7SO4MsP
         d0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474047; x=1695078847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG2hvXvpu+CwXLe5RvYP5VHJgs2lpeX9gvCj9Y1+mnw=;
        b=ousK76bVr7lv4OdkhKRs6HZGEhlW/EESHdIk81G+eAdm9t7+JiIhf9ZVBaHbelhUAW
         9k8eUGJ1jxNAQ8TELFmH45qwijFB4GDTyw9LUzEzxx0RFAubEUOtEr6ggIviinVvoCyD
         HSTbOuVUWFBVkAC07YhElhgZjgfLdBSsAp+QkmX0iuVVKQIt5caUk10gDXmCjnKzZwWA
         U72E48wOQ0kla816zOFD4JJIfDfae2hjlhMqLUw0jEQWJSyBYnPJjRQRmxUqQ0vNND4i
         4DfsW/jlxR2V6m1Jr85M4h/XEDc+PaAHUARiv2kIcww6epnL+k1S5TvdM51k4kq7Y1GD
         02MA==
X-Gm-Message-State: AOJu0YwUKKmLga8m/CzDsOZdgtFnbrn+3VrMMrhQ5t1R5egxeeuvRnV7
        QNkyVHbftAV8npFoX4GilnvmglVKD8WkLQ==
X-Google-Smtp-Source: AGHT+IGhoZR/xi71flAbPieb3hsWi2v+VcLM/kavgf+PV8b2YYOhFDThzUzK1pVKlVI353E6TakjrQ==
X-Received: by 2002:a5e:cb44:0:b0:792:4d29:ecc7 with SMTP id h4-20020a5ecb44000000b007924d29ecc7mr12515289iok.15.1694473727936;
        Mon, 11 Sep 2023 16:08:47 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 04/22] dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
Date:   Mon, 11 Sep 2023 17:08:20 -0600
Message-ID: <20230911230838.14461-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add query_module param to ddebug_apply_class_bitmap().  This allows
its caller to update just one module, or all (as currently).  We'll
use this later to propagate drm.debug to each USEr as they're
modprobed.

No functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

after `modprobe i915`, heres the module dependencies,
though not all on drm.debug.

bash-5.2# lsmod
Module                  Size  Used by
i915                 3133440  0
drm_buddy              20480  1 i915
ttm                    90112  1 i915
i2c_algo_bit           16384  1 i915
video                  61440  1 i915
wmi                    32768  1 video
drm_display_helper    200704  1 i915
drm_kms_helper        208896  2 drm_display_helper,i915
drm                   606208  5 drm_kms_helper,drm_display_helper,drm_buddy,i915,ttm
cec                    57344  2 drm_display_helper,i915
---
 lib/dynamic_debug.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8b46d56f73a5..592a700adcb8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -601,7 +601,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new bitmap to the sys-knob's current bit-state */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits)
+				     unsigned long *new_bits, unsigned long *old_bits,
+				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
@@ -609,7 +610,8 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
+		  query_modname ?: "");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -618,12 +620,15 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
+		  query_modname ?: "");
+
 	return matches;
 }
 
@@ -679,7 +684,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -689,7 +694,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -752,7 +757,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -765,7 +770,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.41.0

