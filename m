Return-Path: <linux-kernel+bounces-20954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15578287C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF12810E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0039879;
	Tue,  9 Jan 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Uj2ZY9TA"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE139863
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-557678c50feso571353a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704809364; x=1705414164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfBxqDS9hHlXmsmRF9XL3tSKxrM0B3suizklfFVNCPU=;
        b=Uj2ZY9TA6GFg1CkGdvuthSLcaB+62PRymZtizDPe2vATZmurnhpryKzjHbioMIE0g8
         vHEGXmxGnELPKrKMyKZacIX0u0sXa/efvWLwKcLNTLOjgCz2eqz6/LanHPL21jIlGg/o
         W9Ao7AvREwIkEDeZOMEn0RRf58zKU6bcw3xO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809364; x=1705414164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfBxqDS9hHlXmsmRF9XL3tSKxrM0B3suizklfFVNCPU=;
        b=KyiYAO+sTCWdgy8Gbofj6e5EDY98hHVlXMeFc35G1Xe2lUd3wpia5IIJ2FtEO6eugj
         bF51L0IuIVkwlavsH16GWLH1/5dcFYpOcYySqBold469QEsHdbFc2seJhc/7PlakqPGP
         DGIr0RU6XPlWIJZ0a+Mt0BN3dyzK4ia5BTgHk/XUovaLeMnrIVzyWwh9bamdhQnyKZfX
         ExE9dJHc6fMZpiM4RgZYavz/a3TbsmHOihcUAM+c/bItk2K5upJaEdamRDHOYMC7ruh9
         hGXcE3neig6q7hTiVJVG+fojV4RlpYlQr5ylPh5gzz3xKsVTuRClzy6iNNnZlDpWgogf
         jlhA==
X-Gm-Message-State: AOJu0YxCvPAlobpSC12XndDn6Mp8m6DXxVs/t11fZTxQmuDp8zfDj144
	yrPbwkJT4Y1mcLzeSH1WJC4A85C2AYhZeELI6E52PkAs4xU=
X-Google-Smtp-Source: AGHT+IFy0E+eIQjrX/iymTN4VUkB9dTkTMY4EJTa9tSrFbeWJr42iW8bPR9nUN+pr7lUJKLaWkgU2Q==
X-Received: by 2002:a50:cdc5:0:b0:557:4249:44 with SMTP id h5-20020a50cdc5000000b0055742490044mr6444656edj.1.1704809363734;
        Tue, 09 Jan 2024 06:09:23 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id el10-20020a056402360a00b00557f54cceb6sm907262edb.4.2024.01.09.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:09:23 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] kernel-doc: document object-like preprocessor macros
Date: Tue,  9 Jan 2024 15:03:45 +0100
Message-ID: <20240109140345.3344094-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had no idea this exists, but Randy pointed out it's been added quite
a long time ago in cbb4d3e6510b ("scripts/kernel-doc: handle
object-like macros"). Definitely way before I started to write all the
drm docs sadly, so there's a few things where I skipped writing
kernel-doc since I didn't know it was possible.

Fix this asap by documenting the two possible kernel-doc flavours for
preprocessor definitions.

References: https://lore.kernel.org/dri-devel/dd917333-9ae8-4e76-991d-39b6229ba8ce@infradead.org/
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 Documentation/doc-guide/kernel-doc.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 6ad72ac6861b..a966f1fd5c30 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -341,6 +341,32 @@ Typedefs with function prototypes can also be documented::
    */
    typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
 
+Preprocessor defines documentation
+----------------------------------
+
+There are two ways to document preprocessor defines. The first works more or
+less like kernel-doc for functions, including parameters::
+
+  /**
+   * FUNC_NAME() - Brief description
+   * @arg1: description of arg1
+   * @arg2: description of arg2
+   *
+   * Description of the preprocessor function, may have multiple paragraphs.
+   */
+  #define FUNC_NAME(arg1, arg2)
+
+The second type is different and for object-like preprocessor macros without any
+parameters::
+
+  /**
+   * define MACRO - Brief description
+   *
+   * Description of the object-like preprocessor macro, may have multiple
+   * paragraphs.
+   */
+   #define MACRO
+
 Highlights and cross-references
 -------------------------------
 
-- 
2.43.0


