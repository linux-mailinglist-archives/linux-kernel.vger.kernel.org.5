Return-Path: <linux-kernel+bounces-162950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109388B62A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D03EB2113A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741913D610;
	Mon, 29 Apr 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDtUld2d"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DE13C802;
	Mon, 29 Apr 2024 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419580; cv=none; b=Lyi1GPXlbHONm2+IDxBF+9DsYaZXEsQBklBauQhCCPSzagxiaJrOiCNpeQBpV4xKR7fRMQNjInsCQ/2SYSWW6+30wu/hRyqmFR3r+zRNxEja1GWJYi/aBeaFTUJ2Y4schwbHghvl+Un1PAByMn2fSIJdrqjEXLnSAlyZwK7Zu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419580; c=relaxed/simple;
	bh=U780VYhQBVmQ4A4oes6nF5utJAlo3Ae/eVBWYl6LKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv2iYfGguWZ65yKpyaHgpZrQo21B5Nlw6PCXfmJQ3SS5a+CKvGQxQEGYAUJCoZsz19stj8Jq9mwOYb/0tYR7PUNIgJheq/J6Cmcpz7jaWikxhco99dUMJWbt7TJJ3XpM91Mki62eWZrNVIf1QPaa7oqOa7W3X6PBSlXR7TMy3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDtUld2d; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7da09662332so160426839f.0;
        Mon, 29 Apr 2024 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419578; x=1715024378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz40dojOamaMr3XzSBo+G+I5OCec93qZ3mLYpBVy9xE=;
        b=mDtUld2d6I2VHdB7VJ829E7f9x+TaXiRf+W8eErCSdpXUsI90/crOIRy4SfQAen39F
         uGG6Te2L4LN9l7HF3cU2ZJeKQ2Ip6Wh+aXe74gHhTf/nKs8wuOEn3aHqnRBUT+A3chtN
         SpfwxCSz1pxPC32n/0ORLEmqLHo2i6nCwxUHATm7sADFVpcI/VNHZD1eqmsb6LQJbiQb
         A0hdcjT2fwqMR0ya6Eom8tfLOJOuWfzWzITLNBsjFJVGnRa74YqCAS4saDZPy8maR2Dc
         qtdW3dLhTw6TpWP10cpueu7KgaQSrFSceduBi0aJIQS9d7RTbx/4ALj7igdOxHB2smgY
         rTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419578; x=1715024378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz40dojOamaMr3XzSBo+G+I5OCec93qZ3mLYpBVy9xE=;
        b=MxpQx4loSkndwIPhrqJuSe8TLEFb8E0wVYM2I5TwIVSYuW4mC0IaVGBHbQvPXkt9bi
         sOsjBvLV+6AuJuukOpAztEa4oPILsECluD3jdV8UNW4FwiM9kuxzTNCw8C4jEypofJMq
         Oi74OkT8bUD+6iUOr9mDeitDzMbw8Kq8uRLzh0x7+2310wUj68rTa/h4oxrSQ4mg9YoS
         FiXQKXUegc+byhlqc8JYnZ89ZBvIymZfMxHIVrrp40SKeCHd2ApbV/4iF0g/H/cCFzmt
         xtNDawMNjKXnnP5iG5eXgeEx1Oqua3p60r1AV9uMgRD7JU8NNaLfOEciF7L0aEB9eeSW
         3njg==
X-Forwarded-Encrypted: i=1; AJvYcCWZAekC4eK6mlfuYC9cdvCnTHTpM5zVHfCXTCDCrckrwdNs8T57PUAtK0WMzZmi0eimtJuOMS6iNh3p9C9D+JyHGLh52QwXJt+YAQny9CjI3b61wAZfx4sa+NjsDLUcY13UGhlOg4Y0
X-Gm-Message-State: AOJu0Yx9JbgQuSO87tlYbxecmLK8KSMbOaUCtPdcnhj1wx1T8iY6WYnX
	mKkhuBAewQyq3k9vOIcpxDg9CKHKnhG+CqpDsYZcdvYnnTiUCBbxw8kSI1t5
X-Google-Smtp-Source: AGHT+IEwjLTZjJthckf74C1CX3uaiE3oCQMny0EnG/l4mAH8Dbjs9ZTAj5NSSjRC7OpGprs2S+b1UA==
X-Received: by 2002:a6b:6814:0:b0:7de:c47d:a740 with SMTP id d20-20020a6b6814000000b007dec47da740mr558970ioc.8.1714419578408;
        Mon, 29 Apr 2024 12:39:38 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 29/35] dyndbg: add __counted_by annotations
Date: Mon, 29 Apr 2024 13:39:15 -0600
Message-ID: <20240429193921.66648-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tell the compiler about our vectors (array,length), in 2 places:

h: struct _ddebug_info, which keeps refs to the __dyndbg_* ELF/DATA
sections, these are all vectors with a length.

c: struct ddebug_table, which has sub-refs into _ddebug_info.*

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 6 +++---
 lib/dynamic_debug.c           | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 090fe9554db7..c54d2a4e1d48 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -146,9 +146,9 @@ struct ddebug_class_user {
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-	struct _ddebug *descs;
-	struct ddebug_class_map *classes;
-	struct ddebug_class_user *class_users;
+	struct _ddebug *descs __counted_by(num_descs);
+	struct ddebug_class_map *classes __counted_by(num_classes);
+	struct ddebug_class_user *class_users __counted_by(num_class_users);
 	unsigned int num_descs;
 	unsigned int num_classes;
 	unsigned int num_class_users;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 625838bd74aa..390a35508fb6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -49,9 +49,9 @@ extern struct ddebug_class_user __stop___dyndbg_class_users[];
 struct ddebug_table {
 	struct list_head link;
 	const char *mod_name;
-	struct _ddebug *ddebugs;
-	struct ddebug_class_map *classes;
-	struct ddebug_class_user *class_users;
+	struct _ddebug *ddebugs __counted_by(num_ddebugs);
+	struct ddebug_class_map *classes __counted_by(num_classes);
+	struct ddebug_class_user *class_users __counted_by(num_class_users);
 	unsigned int num_ddebugs, num_classes, num_class_users;
 };
 
-- 
2.44.0


