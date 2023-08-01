Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4776BA8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjHAREC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjHARDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:41 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9C2D40
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7908ff76516so553439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909405; x=1691514205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwG/t09lzKH4vpOX7xC63yDDKsVGwGMxzSidRaMZ9O8=;
        b=MvFvlOqxSTxkUjWyeHVbt5COPbx69GHi8iLxoojIibfF0X6a64n5rbp0R/Q1+VYf1W
         VmTe5HNPv0jQOMI2zox6Kap/PxtAUa8oVU3l6ufNlwa+dVHxBUFjtwmcaeKunH9OBn7j
         4+GaYidG4ARdSJEZ9c4ISkWVHHsL8AOuV/uyHFl8Ov1V1qZJZNa9ZUPLpNcEX1JmHMnk
         emSbJ3e5X9cl0OBUtshD1lKoreiTcXd1prr6gFU/k9gnzsmi+Mvyh4ZzfSk8tSzvMJef
         Hk87a41eWG3gJIqOd/ZBMHNuxdUfUO4WSL7TV0PBDB1Ve1utsxht7FyZzY4i8mfXIW5m
         zE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909405; x=1691514205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwG/t09lzKH4vpOX7xC63yDDKsVGwGMxzSidRaMZ9O8=;
        b=OCIJPnLlV/BSxxkMQs/3kOGR+LoniGa1mbWQDIYyDjBXggZjMECoV6QE8LcyGlXoeU
         JGMO/9mjc+UilOL1dIA2nwLfq1eaybaq1EDe+RfRA6rrhkQo/gQaC3SsBwzMRp/nOVKa
         GJpd3/kYnv9AdJD1eC2Vbtrb+3VbdFKmZhCQqC9SQx8cgh+tvU7/EfvvprZF9eU8LtU4
         0+nubOXk6rWd1b0UEkSjbUu48QcNK7coNJjtI7yamqtNselF50E9xqifFTMaxqiOoo7N
         mRQjRG02HY+iCYvw5czO96Yt8P/S54ZWkWWivJ3xSThAi0FNWUsdwmgeVG5S9U1W46GQ
         FlPw==
X-Gm-Message-State: ABy/qLZOzXFwQ8pUbfjS3x5C7MVEVIKeeIyAyrQYPF6LuNPT8z1+3Ymo
        IxlfFYFSwiQc1jxXOFxZRgk=
X-Google-Smtp-Source: APBJJlFSK7GfkOXPJ8LM7Dl3khr4eyz3CWu6Ob++B/ZOX6BM13b3O/NQh9abJbXSDSZtYQDzxAbkfw==
X-Received: by 2002:a05:6e02:13ea:b0:348:d3e3:9a8f with SMTP id w10-20020a056e0213ea00b00348d3e39a8fmr11667577ilj.11.1690909405355;
        Tue, 01 Aug 2023 10:03:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 07/22] dyndbg: drop NUM_TYPE_ARRAY
Date:   Tue,  1 Aug 2023 11:02:39 -0600
Message-ID: <20230801170255.163237-8-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 596d0664c29f..719c5b6ad0f9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -104,11 +104,9 @@ struct ddebug_class_map {
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

