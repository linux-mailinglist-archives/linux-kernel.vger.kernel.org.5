Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CCD7C90DB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjJMWtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjJMWtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:49:06 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03BE4;
        Fri, 13 Oct 2023 15:48:46 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3514bf96fd2so9836505ab.0;
        Fri, 13 Oct 2023 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237325; x=1697842125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wAzNX+7w+sJ5TtvQhRQmDSm4kIZa4oQoQoPV+qFJVk=;
        b=f0NbShkXPGeeNbM4Yqcl2UYeU+xNHiIZaScNxFfprT3NH+kBEL4gbDOmUyapOb67vk
         iJxfbPeUv4LslQgR9sclqSCmAyeNb/8Stkcdj4060m/fXx5G22Th9GhT6lbyiHRZLQ7p
         gaDFMd3bKa8VVutedARzhqxDD63P+8MNc2/t6cDDuNnPuKL9J2iY30c+dn4Z7yiknK2S
         sIRyYP+9UqXLnVfTvzh+KBhThPMyl4L03IXAVCeWTg7pjuXReuhm9aD+xAD0ObZZ+9AG
         ivS24cZRWsDkP0DFOhGEdTQFXGOlxwCCfQChnZIUVW1a55Rgn0+MziAJRWTcrs88sLBD
         YGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237325; x=1697842125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wAzNX+7w+sJ5TtvQhRQmDSm4kIZa4oQoQoPV+qFJVk=;
        b=ovQWaUDoxhMbGPFhYPqrthljh0lsfSOK7xGlK615L2gYcjT9J+aijclLnPfKm0CYIM
         EZ3MTIHzn8q8bSBeYqM065fE9kcbkaGaR5rZU+t6TjkQaCvmA3ln0Y/F4cLi49rf0ia5
         Gp0m6naEbRw5YrOS/8BXs9AVJj0+Yvi/T4vUw4rAeLitdocIFHrZ7pKenDs1IyHC2SSI
         MnaqVT33FdOQZKZD7kQado+CggAoAEQmt2FYb7Sps7v8C1Rsa3VWkrViyfd14j2X/bhp
         ieC/kTEP4hv2H0ZFYHV8bfuWcAs0KAIFtlSzI+jhHr+7Rgr+z2NkjFG4yQGs1ZIv7c9M
         3dcg==
X-Gm-Message-State: AOJu0YyxJjL8+naKTpnWw6TFOzPcgspMIVfVz5pFFCDTE6nMy8ugR2fc
        O8rm5fo7Fruejq2sCeGGxSpPuK+1jf9iVQ==
X-Google-Smtp-Source: AGHT+IH5CWZDYBGFOR0RCEdCYFz3/bYbZONuNsRfPEUzYHHjevpEbmEjOO34iA8jcgYwrKJnmRoFxg==
X-Received: by 2002:a05:6e02:219a:b0:351:111d:9cfc with SMTP id j26-20020a056e02219a00b00351111d9cfcmr39311248ila.21.1697237325162;
        Fri, 13 Oct 2023 15:48:45 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7b 13/25] dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
Date:   Fri, 13 Oct 2023 16:48:05 -0600
Message-ID: <20231013224818.3456409-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013224818.3456409-1-jim.cromie@gmail.com>
References: <20231013224818.3456409-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

Remove the NAMED class types; these 2 classmap types accept class
names at the PARAM interface, for example:

  echo +DRM_UT_CORE,-DRM_UT_KMS > /sys/module/drm/parameters/debug_names

The code works, but its only used by test-dynamic-debug, and wasn't
asked for by anyone else, so simplify things for now.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  19 ++-----
 lib/dynamic_debug.c           | 103 +++-------------------------------
 lib/test_dynamic_debug.c      |  12 ----
 3 files changed, 12 insertions(+), 122 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 8116d0a0d33a..8eaf8eabdc8d 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -61,24 +61,13 @@ struct _ddebug {
 enum class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
 	/**
-	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, one per bit.
-	 * expecting hex input. Built for drm.debug, basis for other types.
+	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, mapped to bits[0..N].
+	 * Expects hex input. Built for drm.debug, basis for other types.
 	 */
 	DD_CLASS_TYPE_LEVEL_NUM,
 	/**
-	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0-N.
-	 * N turns on just bits N-1 .. 0, so N=0 turns all bits off.
-	 */
-	DD_CLASS_TYPE_DISJOINT_NAMES,
-	/**
-	 * DD_CLASS_TYPE_DISJOINT_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * classes are independent, like _DISJOINT_BITS.
-	 */
-	DD_CLASS_TYPE_LEVEL_NAMES,
-	/**
-	 * DD_CLASS_TYPE_LEVEL_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * intended for names like: INFO,DEBUG,TRACE, with a module prefix
-	 * avoid EMERG,ALERT,CRIT,ERR,WARNING: they're not debug
+	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0..N.
+	 * Input N turns on bits 0..N-1
 	 */
 };
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 45870a699507..91c8b67fd8f8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -632,77 +632,6 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
-/* accept comma-separated-list of [+-] classnames */
-static int param_set_dyndbg_classnames(const char *instr, const struct kernel_param *kp)
-{
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
-	unsigned long curr_bits, old_bits;
-	char *cl_str, *p, *tmp;
-	int cls_id, totct = 0;
-	bool wanted;
-
-	cl_str = tmp = kstrdup(instr, GFP_KERNEL);
-	p = strchr(cl_str, '\n');
-	if (p)
-		*p = '\0';
-
-	/* start with previously set state-bits, then modify */
-	curr_bits = old_bits = *dcp->bits;
-	vpr_info("\"%s\" > %s:0x%lx\n", cl_str, KP_NAME(kp), curr_bits);
-
-	for (; cl_str; cl_str = p) {
-		p = strchr(cl_str, ',');
-		if (p)
-			*p++ = '\0';
-
-		if (*cl_str == '-') {
-			wanted = false;
-			cl_str++;
-		} else {
-			wanted = true;
-			if (*cl_str == '+')
-				cl_str++;
-		}
-		cls_id = match_string(map->class_names, map->length, cl_str);
-		if (cls_id < 0) {
-			pr_err("%s unknown to %s\n", cl_str, KP_NAME(kp));
-			continue;
-		}
-
-		/* have one or more valid class_ids of one *_NAMES type */
-		switch (map->map_type) {
-		case DD_CLASS_TYPE_DISJOINT_NAMES:
-			/* the +/- pertains to a single bit */
-			if (test_bit(cls_id, &curr_bits) == wanted) {
-				v3pr_info("no change on %s\n", cl_str);
-				continue;
-			}
-			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
-			*dcp->bits = curr_bits;
-			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id]);
-			break;
-		case DD_CLASS_TYPE_LEVEL_NAMES:
-			/* cls_id = N in 0..max. wanted +/- determines N or N-1 */
-			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
-			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
-
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
-			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
-			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id], old_bits, curr_bits);
-			break;
-		default:
-			pr_err("illegal map-type value %d\n", map->map_type);
-		}
-	}
-	kfree(tmp);
-	vpr_info("total matches: %d\n", totct);
-	return 0;
-}
-
 static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *modnm)
@@ -711,29 +640,17 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	const struct ddebug_class_map *map = dcp->map;
 	unsigned long inrep, new_bits, old_bits;
 	int rc, totct = 0;
-
-	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
-	case DD_CLASS_TYPE_LEVEL_NAMES:
-		/* handle [+-]classnames list separately, we are done here */
-		return param_set_dyndbg_classnames(instr, kp);
-
-	case DD_CLASS_TYPE_DISJOINT_BITS:
-	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* numeric input, accept and fall-thru */
-		rc = kstrtoul(instr, 0, &inrep);
-		if (rc) {
-			pr_err("expecting numeric input: %s > %s\n", instr, KP_NAME(kp));
-			return -EINVAL;
-		}
-		break;
-	default:
-		pr_err("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
+	char *nl;
+
+	rc = kstrtoul(instr, 0, &inrep);
+	if (rc) {
+		nl = strchr(instr, '\n');
+		if (nl)
+			*nl = '\0';
+		pr_err("expecting numeric input, not: %s > %s\n", instr, KP_NAME(kp));
 		return -EINVAL;
 	}
 
-	/* only _BITS,_NUM (numeric) map-types get here */
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
@@ -798,12 +715,8 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 	const struct ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
-
-	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index a01f0193a419..229eaadee838 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -102,10 +102,6 @@ static void do_cats(void)
 {
 	pr_debug("doing categories\n");
 
-	prdbg(LOW);
-	prdbg(MID);
-	prdbg(HI);
-
 	prdbg(D2_CORE);
 	prdbg(D2_DRIVER);
 	prdbg(D2_KMS);
@@ -129,14 +125,6 @@ static void do_levels(void)
 	prdbg(V5);
 	prdbg(V6);
 	prdbg(V7);
-
-	prdbg(L1);
-	prdbg(L2);
-	prdbg(L3);
-	prdbg(L4);
-	prdbg(L5);
-	prdbg(L6);
-	prdbg(L7);
 }
 
 static void do_prints(void)
-- 
2.41.0

