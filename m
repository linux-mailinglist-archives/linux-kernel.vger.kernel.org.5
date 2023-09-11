Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210F279C26C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjILCMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjILCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:12:03 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BAE931A;
        Mon, 11 Sep 2023 16:19:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76dc7b0da9fso266740285a.1;
        Mon, 11 Sep 2023 16:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694474234; x=1695079034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRKwABwSVQ1OTkJFIkg8SfKEtpKioqDF4/CYpQb4P2w=;
        b=rPmx/yw+z3Wt61pNz3DrzOGFnTSOwPqxeEbE4T01P9dKyLxYYzsq3TmONHmv/GwSrF
         VAMq2f1kyk3zXpRoSUhrS/6Tq8WardHGPYJjYV701+2tOe3op1si3N+sr6PRnJ00nrdb
         XpBgx/kOugQvYDfCptiv3OtGDCTzHVpBfGilCpkNalTYL8tcadSpxFZGIxSN1Qd8Jgto
         nGX78HKhM+jTY8N5HY9HBjfFvMUto37zC6wuP0HK5W7n/POKJL64ajpjMSC9WEn5Xww9
         fALQ+kIo3H6SIIxj6Dp6tbi2IpTDl20f0wdf3LHdrIIzkkF2/GCjr6VKcQCuwBwzMTAu
         UCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474234; x=1695079034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRKwABwSVQ1OTkJFIkg8SfKEtpKioqDF4/CYpQb4P2w=;
        b=MjjIjDef8Ys2aQzy+7GvpJRsx2fkb1JKWGrNPqjL/7ZWD5SzCuNcEURW6TYrHhvyNW
         Mxv6POKrD0N++/Hem8qaCUJ7I5DB3LhoKfbz7d3uBzpFGfHhXHSP0tGh06Wf01cS6Xwi
         j25yDauKaT91xyTCDDzkN1zqDIC/68viFg5+f6WHegvY/4Luhd6Q0GYkt0DGI0Aq4CQN
         gVG8RTjR273hzT+kXwTNQQ8GipKHsDNMS9WLiLoUqDdmnn/bhPdRp3rVh61I4FYaRHQP
         kief0xo1Wfk5h06qTwzzq7IiRIyqQiF7/ygg896kZ9NkOe4rwGduTwh9A5DVKYFYbXmx
         Y2mA==
X-Gm-Message-State: AOJu0YwK+Mn8fm1OImORwPwsn8XIXk9Eey2gfnS5xaJkU4NhcFAnA/EE
        F5Bs2aDncZiwFwBaNMn4JYB3MmorUS4vwQ==
X-Google-Smtp-Source: AGHT+IGnBiv6UbJsu+sBM5Hhx9sTk4Vk8peUvrBdp3UqCNKfl/LsZspNoj46K2gBb3H7JdLQgmF4mw==
X-Received: by 2002:a5e:8912:0:b0:792:9a3e:2dd with SMTP id k18-20020a5e8912000000b007929a3e02ddmr13540344ioj.3.1694473737580;
        Mon, 11 Sep 2023 16:08:57 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 13/22] dyndbg: add for_each_boxed_vector
Date:   Mon, 11 Sep 2023 17:08:29 -0600
Message-ID: <20230911230838.14461-14-jim.cromie@gmail.com>
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

Add a for_each iterator to walk a counted vector member in a struct
(ie the box), and use it to replace 8 open-coded loops.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5- parens-on-box-force-precedence
---
 lib/dynamic_debug.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 018578923897..851e7f9de085 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -158,6 +158,9 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  _dt->num_class_users);				\
 	})
 
+#define for_each_boxed_vector(_box, _vec, _len, _ct, _curs)		\
+	for (_ct = 0, _curs = (_box)->_vec; _ct < (_box)->_len; _ct++, _curs++)
+
 #define __outvar /* filled by callee */
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
@@ -167,7 +170,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_user *cli;
 	int i, idx;
 
-	for (i = 0, map = dt->classes; i < dt->num_classes; i++, map++) {
+	for_each_boxed_vector(dt, classes, num_classes, i, map) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -175,7 +178,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 			return map;
 		}
 	}
-	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++) {
+	for_each_boxed_vector(dt, class_users, num_class_users, i, cli) {
 		idx = match_string(cli->map->class_names, cli->map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + cli->map->base;
@@ -1058,11 +1061,11 @@ static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp
 	struct ddebug_class_user *cli = dt->class_users;
 	int i;
 
-	for (i = 0; i < dt->num_classes; i++, map++)
+	for_each_boxed_vector(dt, classes, num_classes, i, map)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
-	for (i = 0; i < dt->num_class_users; i++, cli++)
+	for_each_boxed_vector(dt, class_users, num_class_users, i, cli)
 		if (class_in_range(dp->class_id, cli->map))
 			return cli->map->class_names[dp->class_id - cli->map->base];
 
@@ -1216,7 +1219,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	struct ddebug_class_map *cm;
 	int i, nc = 0;
 
-	for (i = 0, cm = di->classes; i < di->num_classes; i++, cm++) {
+	for_each_boxed_vector(di, classes, num_classes, i, cm) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			vpr_cm_info(cm, "classes[%d]:", i);
@@ -1229,7 +1232,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
 
 	/* now iterate dt */
-	for (i = 0, cm = dt->classes; i < dt->num_classes; i++, cm++)
+	for_each_boxed_vector(di, classes, num_classes, i, cm)
 		ddebug_apply_params(cm, cm->mod_name);
 }
 
@@ -1249,7 +1252,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	 * module's refs, save to dt.  For loadables, this is the
 	 * whole array.
 	 */
-	for (i = 0, cli = di->class_users; i < di->num_class_users; i++, cli++) {
+	for_each_boxed_vector(di, class_users, num_class_users, i, cli) {
 
 		if (WARN_ON(!cli || !cli->map || !cli->user_mod_name))
 			continue;
@@ -1264,8 +1267,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	}
 	dt->num_class_users = nc;
 
-	/* now iterate dt */
-	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++)
+	for_each_boxed_vector(di, class_users, num_class_users, i, cli)
 		ddebug_apply_params(cli->map, cli->user_mod_name);
 
 	vpr_dt_info(dt, "attach-client-module: ");
-- 
2.41.0

