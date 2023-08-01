Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD876BAAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjHAREU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjHARDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD0E30C0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:31 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a28de15c8aso4761284fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909410; x=1691514210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QseyuhLBDEROpWLKKgP32sjOtlfO2lCBfXeYS3rrNc=;
        b=Q5G+JcciKhpmlKdNBmFqVMNbAO+OGElyu/0fqZZFek4iH6+umRyZbHzBKQw3G62Wil
         FFdU0TutAWFZmfcMxp1skvl0fyiTq8YJ4G+/4s/iDoz1GBgqY8bPDaT7oihtHJ74ahbG
         l4+7las1LcfB+ur7Vldh3KzyRNFxHWrbdWtgO0vyPesSJHvPUyGA1+wgC6t3ucUrAdGk
         nD34pgbWLo/ApxxHxNLuyVikv/sNIHu4GU6MZxnkJKM5CiRcsjFwh8wgvtRVX7wjLgWP
         yVI+ErNITz0XAS03UVv9VpIDOXNb3I9iN2v8Z0mqYKwCrf2LEjC54ZcTnB1O/lkOEfwE
         oTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909410; x=1691514210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QseyuhLBDEROpWLKKgP32sjOtlfO2lCBfXeYS3rrNc=;
        b=I+nN3Og4F2CAsyPy6AcmPF0bJjGUwE2N6slN+M/YoViGy+ythAiyZhq2iSAbz/HHni
         Nv6ZY9XT+9u7tRjJ+Wo1Iavum+DByj2mWwL94OeFDDlzQQFCQVAqh2iTylBcaRy1XwXu
         pNW8Vp8Tr/+6BbnchsS99eP7Se7wIwf2Zl7xARrM6OeLWEtqPYO3lI6zsrWnJsm95TW3
         W2YMCrxa+XMdKtsHg0NbKphF8+WYSdUhAK6y5J61+f1edpqEGILjeawAe9jvAyxj6lu+
         l5TEmqeji1oBooHldHmJh1DEgUaG8pjya98nais+S/QnD0yYkWtV8wCzNQ6nCnpu5FvB
         1T3A==
X-Gm-Message-State: ABy/qLZhGu/ogNTBIMqBnSJKu5xmNc7+tBLrZjgIfnqIDXaSJpLp8zCP
        bndO2tVv1+f8nrqXRmTiFN8=
X-Google-Smtp-Source: APBJJlHMBpo+oXqHwqmyK93SCbNu62SVNq4IAkahzrWBVtIg4N4OfCddb3wFLCtBclliS88yld0UTQ==
X-Received: by 2002:a05:6871:10b:b0:1bb:84f4:d78b with SMTP id y11-20020a056871010b00b001bb84f4d78bmr15193692oab.58.1690909410378;
        Tue, 01 Aug 2023 10:03:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 11/22] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date:   Tue,  1 Aug 2023 11:02:43 -0600
Message-ID: <20230801170255.163237-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f392f692b452..abdb54e3ddfa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -592,7 +592,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -601,12 +602,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -618,9 +619,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -677,7 +678,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -687,7 +688,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -741,7 +742,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -754,7 +755,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.41.0

