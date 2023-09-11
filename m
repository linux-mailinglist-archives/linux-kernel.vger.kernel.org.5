Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C307C79C3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbjILDOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjILDOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:14:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F77B08DB;
        Mon, 11 Sep 2023 16:15:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-573e0d471ceso3311869a12.2;
        Mon, 11 Sep 2023 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694474057; x=1695078857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OB8bUmBTX5kKvQ4ZxUIAC9aMicC4lfL3UKEwiwbQF4=;
        b=rE9iSlm2Nb9YbjQHS4uwWrj59RCV69nGqI9G6NclZ5b3Ee1rUnIwUBrI923eQZvKZW
         zHk+qN1C9y6eN60t5Tcyf3D1xufdV0iz2HREnC3N0GLR6io+e+/CMy+OeD536TaFnJ6f
         rQEPgRh4/+GoPGBuChUl23TZDISi8M6grkTzXF8RQWwn2wQb3KBsv+LmRR6DfdPhLnM1
         8/08mtKWW2JHO9XzdA0Nu6cdBPoH05unlkSnFFcZOTEdYfX1+iPGQyLcXm0QFOaHEZb/
         NRiPI4p+p888qX/NZvWeQjbShqUaoGZ/XNWr1SabB/kSVOmx9plLrRXXo0FIn1LM3KDm
         Iqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474057; x=1695078857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OB8bUmBTX5kKvQ4ZxUIAC9aMicC4lfL3UKEwiwbQF4=;
        b=KrVjtIvXX9VRpNsk4Hj8KYhLVzAyVGgaitZHslJW0nELxld1MxRXc4nD7EnZ00/DDO
         A/mcBIeA3behx7GbseEDQwvyu4x2M55l2cCnN3joComRgBRRAO3mfRu7pUMWYL9GgsZ2
         iRJ447UrQvkiMmpIxNp7LiZKc7LvKSGhwuRPmrGEi85hFsDWc71M797EdRT9DeoN0GuS
         HWs7k8dO0vnTHabmUSj3QntehRpoc3BRgtBBIwo5EFrSvTQC32uw8VqnGo/+9yUOSCzs
         LMK6VCark1TVJSuld19RMZf6TQc5uIaWtkXjM0snI621PuS5nZRu0I24VbWzd1rgHga9
         IHHw==
X-Gm-Message-State: AOJu0YzzF8zPviYgUFsu++LiFVWRvstfOsn+he7QwH2E8DIJA7yB3Bkf
        avdPodKOswIkhlbp4nVPTwja4iQYit6epQ==
X-Google-Smtp-Source: AGHT+IFF0NIg0EvQsa4Dg6fo1g7OF6OwEySZ6KWY/DeO+qCaWimrRUc++BjjQsZ9sd7GXWD+9FOgYA==
X-Received: by 2002:a5d:9d18:0:b0:794:eaef:f43e with SMTP id j24-20020a5d9d18000000b00794eaeff43emr13191253ioj.1.1694473728918;
        Mon, 11 Sep 2023 16:08:48 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 05/22] dyndbg: split param_set_dyndbg_classes to module/wrapper fns
Date:   Mon, 11 Sep 2023 17:08:21 -0600
Message-ID: <20230911230838.14461-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
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

rename param_set_dyndbg_classes: add _module_ name & arg, old name is
wrapper to new.  New arg allows caller to specify that only one module
is affected by a prdbgs update.

Outer fn preserves kernel_param interface, passing NULL to inner fn.
This selectivity will be used later to narrow the scope of changes
made.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 592a700adcb8..153e02c3af45 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -708,18 +708,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 	return 0;
 }
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
- */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *modnm)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -756,8 +747,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -770,7 +761,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -779,6 +770,22 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - class FOO >control
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * Enable/disable prdbgs by their class, as given in the arguments to
+ * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
+ * levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
-- 
2.41.0

