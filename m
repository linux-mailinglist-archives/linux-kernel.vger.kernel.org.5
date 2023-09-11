Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8360E79C298
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjILCRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbjILCRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:17:42 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008EE3C05;
        Mon, 11 Sep 2023 16:10:13 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34f359949afso16193895ab.1;
        Mon, 11 Sep 2023 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694473730; x=1695078530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEjUcd2gIGh+rcuXSmEeq7H3LSdL8L2dg7mL1DHpCLA=;
        b=ASO/gCBVMz/RJd6PZ9BAME2Fvmw5PGyUx6hD+ebsaE1A6K19Z3ZdaF2W+bB3249hEU
         P4M+0eSBoxQm96j8ahaiaSgxi9NOYCuMyM5WqZYexQo+/ScIbmNiHAKiSGew0dyna2iV
         DX92s3QBin49PWpmmkazpeqESP/Eu2Cabbd3SpWK2waIfxFwMdqvYtnfHDy3IYiA23J1
         LCr73sV9dRGYPWei5flwXuLu4NIxzJNtAYkWgqd0tIHrEIww4J3nbhb8SWOMsjlgmSlZ
         aC7SEREOcor0Ocv1hzQBJDwnQ136aoXm+tFjnRp30ajJ0kllVFvi5aECpg5Afuv1phtd
         f6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473730; x=1695078530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEjUcd2gIGh+rcuXSmEeq7H3LSdL8L2dg7mL1DHpCLA=;
        b=op7aET9RHuVf2xriorKjed+AfspdMY0jJy03Vsp1yvWU1PcTGKCyoI/y+BKVJoK47F
         w4bEXvIK/2rdjpMDvpYYbCeEz+jQOe5Zhnw5jAI73g0IeZxjZ4kp9aVrPkg7Z7yCuGfC
         BAD9qLil2QGkN45CIhir/haGRlrd/r/fHZ3RzBoWfcxlsUlMaH9eyTMaO7eOSUYm9TuJ
         D59qqBCQGcRJoGqtI4KKWCADisDgYOp/+pKtn0sggfbqBJG3Hqkr3bg33PymB9zpvdZ6
         dEB85IdiGEaxvH4X5kOCknv0n4EVtaiRFkx9NvLzcpuTtPIyIs2LRIfb0Se/gOH+Tj5r
         iOWQ==
X-Gm-Message-State: AOJu0YwWzlVWAKINUrA4kLFj5Z5am+rl26if0PNBkRqS8RC9hBWPAYaS
        muhpGAoldc13LOXimwUk04w=
X-Google-Smtp-Source: AGHT+IGw9roeHaTtQyntmQ3xkyrxGL7naAB4H6rnS/E49+h4wJE5jfxNNoP6S5fKLhiwQwEVXDx5rg==
X-Received: by 2002:a05:6e02:20cc:b0:34c:e84b:4c5c with SMTP id 12-20020a056e0220cc00b0034ce84b4c5cmr13702891ilq.27.1694473729966;
        Mon, 11 Sep 2023 16:08:49 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 06/22] dyndbg: drop NUM_TYPE_ARRAY
Date:   Mon, 11 Sep 2023 17:08:22 -0600
Message-ID: <20230911230838.14461-7-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b53217e4b711..8116d0a0d33a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -106,11 +106,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.41.0

