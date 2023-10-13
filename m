Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5060C7C907C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjJMWsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjJMWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:48:36 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EED2C2;
        Fri, 13 Oct 2023 15:48:34 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3514bf96fd2so9835845ab.0;
        Fri, 13 Oct 2023 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237313; x=1697842113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C+2NMg1JH09l8lpRwB0Ubzh+mfktnl5vVkwETAlRt8=;
        b=SGCt92dXVRwgsqlt9uHTs9zhiUwb9epgQJbKDVGy84RIkPKESqf12K9MyFzFuDGV/c
         HCiaoT0kwng0muTb08KuwkmrmmZ+16pX4yvr1/7g6cC9MTQZnGoZ8y8ChitfUwn960D4
         VesmSCStKKpgxuCNGxXfUGajmGjTPAryvuI9G1Oc7zhi27ObWzz9V2ZaMWZZ7o6mmao5
         xnHo6ezR7zdsROiKf0uwTCNKHwqOTgMn7eaBVWMNzw5iLCB9G1FqlZY10dieZQoHj+AZ
         AarrSvvZtTKYg+aVG68EjMK87N3arGSvqBWkR0cgE40qq61dN2jezf57a0Oazr0sopHn
         1UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237313; x=1697842113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C+2NMg1JH09l8lpRwB0Ubzh+mfktnl5vVkwETAlRt8=;
        b=og8XrPgISBrKjuHTj5GyiyiCICv0ptXDg8aNkQTACjMDCm7bMP+1UEhi5yX8AXHJkE
         Ugqxu+DdgsYmx8mQzCzUDMqDbDU4h4LpUZxc4gHUb0lb5rgzvNDOquvplp1H0TRb7zCS
         5C4kKicnQn48MTNFg2o8znHeMgZsLswc1+XAzNwxZOz32nawv9cMuf3FOpNVSfIXkYb4
         /acM3RBk34QA/tER+j6d/yyfzh6QLCzm+38XcbLBrkTWQiPiAqdmQvcc2+F9pOdgdqbw
         nlFRL8NmlJdQL4Tptb8rEjef1mj+BtF5s5nsQwM9Vmg89SYqNyifewkYGNnRZgYapxv6
         xmhg==
X-Gm-Message-State: AOJu0Ywe0caXnjF5Wc4UEYj8HrGyyijAYkBdR44MdLUxwgXKhi+RVVB6
        730brHZyMVEMfIyCkTMalu2M4u1QNWZ36Q==
X-Google-Smtp-Source: AGHT+IERN8pJIP8+ddoE+eB01U1+UXtsDPSDnnzIVYSoLKnjpR6o8aO6/OIr3x06+l+lRtKcnjJmFQ==
X-Received: by 2002:a92:c56b:0:b0:34f:f5a4:3e68 with SMTP id b11-20020a92c56b000000b0034ff5a43e68mr37533699ilj.30.1697237313527;
        Fri, 13 Oct 2023 15:48:33 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:33 -0700 (PDT)
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
Subject: [PATCH v7b 03/25] dyndbg: make ddebug_class_param union members same size
Date:   Fri, 13 Oct 2023 16:47:55 -0600
Message-ID: <20231013224818.3456409-4-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param, make both flavors use the same unsigned long under-type.
ISTM this is simpler and safer.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..5231aaf361c4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ceb3067a5c83..b984ce338921 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -796,7 +796,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.41.0

