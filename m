Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B071E7C744C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379608AbjJLRWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379615AbjJLRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC6C6;
        Thu, 12 Oct 2023 10:21:50 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fe8986355so47273039f.2;
        Thu, 12 Oct 2023 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131309; x=1697736109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C+2NMg1JH09l8lpRwB0Ubzh+mfktnl5vVkwETAlRt8=;
        b=heO2lV/HLG6Izd2EJhFBzEb2SkEBs+16EZTMQLV2aUeLrpkI3Gsqvczn4gBTfL2JIj
         voXT13IKWwMgL0YMjeEPhdktX7blXraC+H+jvX3I9V428JUyF1HWZ/CdVDU14x93B2PR
         74/WeDgn/beHsvbUMuflzMLp+WCkyc3pkR2QdStzIbl3eo3qda/jUo9tTJa9gddkgdVI
         q2m+BK00KVQXPOHN7O0Yo9dHlLv13K+kLbMajIJltok0VHPreNC6rOci2tZ9roDXeTCK
         yHulCtBMgoxZ7Fvo/GGpRyrAM892xrsg/Dm5dAO6BRYtvG15NfTMkOl1q0G9u8RfDtY1
         wa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131309; x=1697736109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C+2NMg1JH09l8lpRwB0Ubzh+mfktnl5vVkwETAlRt8=;
        b=pskgyHdrWdH3WwFVBxz4scrZOzW2m4x1rV1NdA4nqFhGFORoJQ1jx5Bzo/1kqMltD7
         xuiGg0cD/qwXTAbu0mSUr60/L3JHUmsriXvOvf8RUXoKjAgLGWOE7q/fZsGFe5bjFTR1
         44F6mnE2ci5Ec/I0P3XSr2GqOzCy0wCd8qnsF98fEcwgP7UsWrcpc7jExb6BO3I8kuG+
         JKmJBwAvP8E4E8+Uz+Nk/NIqdwoCFnMz7nuNPzsVulFT4qcYkmzdjKHNN02XfMuLsePS
         iiHuDcbxKVnkZEJg0XojkS1/95cD4GEmqZGKgTg4IgZJWGg7qeqT2Jo//vwTKd9mBRd2
         2iYA==
X-Gm-Message-State: AOJu0Yx9CyjcelKkCDDBoqS28Ph8A/hGxp6BYTOWfbPfdX/09pk/fdg6
        KV2IDZ1DGuAo5UaI9iswVDeylG437IzVdQ==
X-Google-Smtp-Source: AGHT+IFv9+9ZSJVEOdNuMEayE6v+GU7M5y/7ncblYUcEZI8Bcli8ik/hEPbo6CFkwlP3gRTVK7jmtA==
X-Received: by 2002:a5e:aa0c:0:b0:794:e96f:b87d with SMTP id s12-20020a5eaa0c000000b00794e96fb87dmr27629465ioe.0.1697131309330;
        Thu, 12 Oct 2023 10:21:49 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:21:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 03/25] dyndbg: make ddebug_class_param union members same size
Date:   Thu, 12 Oct 2023 11:21:14 -0600
Message-ID: <20231012172137.3286566-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
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

