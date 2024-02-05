Return-Path: <linux-kernel+bounces-51961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384128491FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C29FB2208C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650012F32;
	Mon,  5 Feb 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="QWATiXE0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC3A20
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707091507; cv=none; b=ojXOiE8yKo5tvXhalbiAExWvfXskC1vf24+cl8zdF3BiUU90IuNc8HXGVjCdv7E/g9U7WSKFMHk/ZfYDQehDuXNXVBQE907LFLYMuvRxULpUN1q5Vc3IpVoaUfC+/AOI/RczZKw3tZ+XHyJfxbliebNrCj7bdruxw1fwMLf7JOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707091507; c=relaxed/simple;
	bh=AjRq3tAtkWmofnUVyDyjPCLlJxCrhzWzpItfMik+c6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YbNItE8MVllSp4GP+s+JZYGN5JCJKs0sFm/HHy/jZeMz+AHhjgYIfilOnpd7y1ek65SNKdHxO1Cf/JdpTF81bGDIoxgEp6D/hBs4an2Zu1JY1IZpeOrSoHUKyBraB5NxrFp+4W6p2r/3tjIeR0FTA/aFFMKoCNpnTgg+6kRtGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=QWATiXE0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fb804e330so35317795e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 16:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707091503; x=1707696303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWKljW3OQWKG3gLM0dMSuQJwcAILTgzcp7Kc5MiBzeY=;
        b=QWATiXE0dGa8k3GCbpnClciDACjeCaQHIycZED6EmHPuTyBFb5S7P8T4ag7jyGm8a6
         6HxdlXG66AO0MP9RHxbKNb9pcVkBot3W09+kViCQ1I8QWx1Duce8Aw5tLvmDJxz9kbwB
         St1u2GDV8lK6xBPhxuBhZojbq9aI+hdG3mtoDOLCu4PltTRMt7LvnEdlelmlduN4P05z
         hbRbJKac2GbZA3ELeLwXi33DYVdnoRfiMIQgWBTMC5tIXfzdu1WHh+Ki2EvKeuM5QBVn
         uRzLXXhZlJ8u8UHRs7erWe6MmFeGqpqs2RsS1dsWoBtGDtkm3Yl8t6HGE0Rmse3TUr+a
         FRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707091503; x=1707696303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWKljW3OQWKG3gLM0dMSuQJwcAILTgzcp7Kc5MiBzeY=;
        b=lLVoyqBCWHF0mglUk1A6J19ZKvPJlIBrfO1kUTFrFWuVPsnAPgk+BH75f6zCnAgTQr
         Tgpz5kyoeTJ6x5x4v9mL5g4X2a6KcarXj2EE2GIL6WLBJxEjPrYtlIWrZdZnQ/ayHZ/b
         n9xZ10mf8Y2RwfQFmbpw/1oy2cvz3WLcSTvpwRCVR7mtZP/WLicFWNG9w7nGizjGZFrK
         +NKIezvyNdWrm8dzWvbxfVA4MqLpv3eqVGO4lBTTBsFM9fanPQdE+er0CZOXCJX/YT4b
         rFRsxbcjO2bkaH89BaUFXseo2G+ypaGyurG1hLPfAsvjG8JoNC8jA9tJ4VD1tXH8iFU9
         oVbw==
X-Gm-Message-State: AOJu0Yx+v15jdqIGVKoMn4TWyxVOqBe5ZNzHEla+HMTs/DiJXy8OEX6y
	1FIX2f7SA7ExsmvMvMa3zx/ol7UHZmR7DKNaB1UylnTOsuA2ltP+gfwLERVOric=
X-Google-Smtp-Source: AGHT+IGqtYW+vwVOR9OL3U8HQ7aXrgLU1V19Ac6+cyj43/d731sJIdFCI/GPtRA5vJm4UW9q7YSLjg==
X-Received: by 2002:a5d:5f46:0:b0:33b:2856:5188 with SMTP id cm6-20020a5d5f46000000b0033b28565188mr6625740wrb.44.1707091502562;
        Sun, 04 Feb 2024 16:05:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYpe6QP2jd13nzPNmWxtq9nITyM938xleEeIYbPo+iNImWxS6a+eU3kFM8I8ylBjWMHo2pLLYWRtbnO8sMWle1o0w1w7boTJsgOWKFJlpVi0ThzSfmy85JY9EIQKEc6GYgJdBgBi5uZvhVRCX1h4dIBVMXNESdSYfNYexS2FXH5tXN4onWqC2sTOakpxHyiqUI6BJq9dyN2Y2ixZc+k9OD84asLBK4Mn2TIFhjpfvCOTF1u5LfjWFjAgzhMKlO0dYak5RiNFaB/T0=
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id c6-20020a056000104600b0033b35ca71c0sm2535671wrx.108.2024.02.04.16.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 16:05:02 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: willy@infradead.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thorsten.blum@toblux.com,
	workflows@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation: multiple .rst files: Fix grammar and more consistent formatting
Date: Mon,  5 Feb 2024 01:01:17 +0100
Message-Id: <20240205000117.3285-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZcAFi9ZW07fOLQaW@casper.infradead.org>
References: <ZcAFi9ZW07fOLQaW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sphinx.rst:
- Remove unnecessary newline
- Fix grammar s/on/in/
- Fix grammar s/check/checks/
- Capitalize heading "The C domain"

changes.rst:
- Remove colon after "pahole" to be consistent with other entries

howto.rst:
- Fix grammar s/you will/will you/
- Hyphenate "real-world problems"

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes in v2:
- Preserve Reviewed-by: tags
- s/on/in/ in sphinx.rst as suggested by Matthew Wilcox <willy@infradead.org>
---
 Documentation/doc-guide/sphinx.rst | 7 +++----
 Documentation/process/changes.rst  | 4 ++--
 Documentation/process/howto.rst    | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 3d125fb4139d..709e19821a16 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -63,8 +63,7 @@ Image output
 ------------
 
 The kernel documentation build system contains an extension that
-handles images on both GraphViz and SVG formats (see
-:ref:`sphinx_kfigure`).
+handles images in both GraphViz and SVG formats (see :ref:`sphinx_kfigure`).
 
 For it to work, you need to install both GraphViz and ImageMagick
 packages. If those packages are not installed, the build system will
@@ -108,7 +107,7 @@ further info.
 Checking for Sphinx dependencies
 --------------------------------
 
-There's a script that automatically check for Sphinx dependencies. If it can
+There's a script that automatically checks for Sphinx dependencies. If it can
 recognize your distribution, it will also give a hint about the install
 command line options for your distro::
 
@@ -283,7 +282,7 @@ Here are some specific guidelines for the kernel documentation:
   from highlighting. For a short snippet of code embedded in the text, use \`\`.
 
 
-the C domain
+The C domain
 ------------
 
 The **Sphinx C Domain** (name c) is suited for documentation of C API. E.g. a
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 50b3d1cb1115..4c1552160321 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -144,8 +144,8 @@ Bison
 Since Linux 4.16, the build system generates parsers
 during build.  This requires bison 2.0 or later.
 
-pahole:
--------
+pahole
+------
 
 Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
 generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 6c73889c98fc..eebda4910a88 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -351,8 +351,8 @@ Managing bug reports
 --------------------
 
 One of the best ways to put into practice your hacking skills is by fixing
-bugs reported by other people. Not only you will help to make the kernel
-more stable, but you'll also learn to fix real world problems and you will
+bugs reported by other people. Not only will you help to make the kernel
+more stable, but you'll also learn to fix real-world problems and you will
 improve your skills, and other developers will be aware of your presence.
 Fixing bugs is one of the best ways to get merits among other developers,
 because not many people like wasting time fixing other people's bugs.
-- 
2.39.2


