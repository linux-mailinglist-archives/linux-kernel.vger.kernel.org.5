Return-Path: <linux-kernel+bounces-50704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB5847D16
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DED71F26541
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D412C7F6;
	Fri,  2 Feb 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="NZgH3sjn"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5E8594C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915789; cv=none; b=X7eOH1+7TmHBNg+pOFXpmurhLENdqKKEQiOGAXNktXDoHYFwrFTgB+hXfJfyGCXJyYVUlZZyIC16qt+2fZ6CcQFtYy5ioavsfmCKzr9t0nM5rKEHTXU9MGwBA/jeySFc7CWFhyTn3bm5j6whcMCjDg2Bf/WFTdkKBwmTdTtvMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915789; c=relaxed/simple;
	bh=cv/llAgdLFffQPBImWTkKAwlAxaOXdvBY69NlckOG7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SI9sn+mt4rYuBNnxXz4Yujsa1Glw6LDLI9NYSyMg24e7UE6krNSGD2Vy4eFDQcijzlsH6oCsYSNWf9Zr3WXeNX7SzzDYBwOevgmte5Q1m6QNZC4BVwHM7UriDHr8m0DO14ujwZu0f4Oz/ffMmA6F0bEnsLIi3pRAdzho6+369uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=NZgH3sjn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b123f99d6so1629647f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1706915786; x=1707520586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PteMdXSGEfK/S/yRN4kmhpTCq4Nr6CXKbchr8j0sDPk=;
        b=NZgH3sjnBJy4FsVl7DyHkqfujQlUJn1G9oTeMsbC+GfmyQsVfWfdFBh9w2O0/peUbM
         OoNEv19t+XZMD2rYm+YbnUlJTeEZa1m8VZRbWnU3c3vUXTchdUCBbxnSUXS9O08qgM9a
         fHFH1SeHnbCYeHYxj60FAs6poODgFHMBFCkezlfebrvRftyAR/3lT0qtouAji35AvfTP
         KfHRBOaykKFg22TPVhudMQz+ZXv15750SmR9/kXk39u8yU7jiVVVDcn6vTW8+StkrgXg
         Dto8pNsQ40FsbHkz44yXIbQaznHhciy1D+LsVvTwxvP1C+CYeN2NxMTQPLcpNGdntQz8
         Y9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706915786; x=1707520586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PteMdXSGEfK/S/yRN4kmhpTCq4Nr6CXKbchr8j0sDPk=;
        b=wwDdW31G4nzaAvqtfE95BJXeMz1Hjk9POxPMdyKh6/yJQsW+8Y0wTgen6BCrxSsme/
         7ojC8oIk3UkUf6149YStcKFe6TTIYHr4pSybs2zXRF+Ti4tf7+Vwoxa8FTtXQxZcH0cX
         JsKvvKBuk2Op2MiSG3hFLpHrYHj4vyBHO9D/y69Su9czzusL6ZTUgDcH1NgVp4F0Se54
         1uSClYIatzlZ/2koQRH54NUXR/v2ufAxIyS/v8ev7VU/96VAH36d2fth4GHmyzl+mNGm
         L6gednqAQjQ0UJzjR+gMomEr6t5Cb/zOPnnlx2VxIhIOpF44jSt17tVuVZTJg7MyW7Il
         j/jQ==
X-Gm-Message-State: AOJu0YwpfcdAaqsl9DaWQwwIVcUCPFVIo5zCV20QAH4t8GS4RQpVRkAi
	hIkxyb8gfQxPEdJ9UxDH21Nbo3nNNoTm9xiGb3I7ozz9F9qRevCHzfB8SUxNAak=
X-Google-Smtp-Source: AGHT+IFx4fm66Jzjbq0kt3hMUWT/G1epWGZ2gABGvJrKNxgkFJHIu/iKrl7ttppsosE1Fe2ij5km7w==
X-Received: by 2002:a5d:4b04:0:b0:33b:e5f:edec with SMTP id v4-20020a5d4b04000000b0033b0e5fedecmr5438030wrq.16.1706915785888;
        Fri, 02 Feb 2024 15:16:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXy/HLNwyclEcV5Hu57vuuLGE5wfjlgNnKpn4JHUvlHt0ALwXw0P7QQYV03ANhBNKLn5dsOBX7d6nHr+CQ6tyoU675hjXgtF/n2HPm2piEJlio1H2FXTm0WIESpHymxlbH6B1eRug0GvFAFNhQBe5+wIFia3Q0DU7Bpo9Fc9UkNdpXxdKjg0KI2QB+fcB7cI+8nGB43MDo2M7eF0ltgGbxW1Qi+NHXw+YeP1wtxHOY4tAI+hIK0i9u7qlQErit2eURN8uMm9DCrwzsRcN8XCYzqRu60U0OG5Q6R+Z1ZneJOBCp9qFP6dGttW6KJ5LbpuvboEustfMEk0Y0ee7p8diUTQMPVwCoUJDOicH8U2Xq9
Received: from debian.fritz.box (aftr-82-135-80-223.dynamic.mnet-online.de. [82.135.80.223])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b0033aedfc5581sm2834766wrx.32.2024.02.02.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:16:25 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] Documentation: coding-style: Fix indentation in code-blocks
Date: Sat,  3 Feb 2024 00:13:16 +0100
Message-Id: <20240202231316.7606-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Remove spaces in C code-blocks to align error labels consistently
- Replace tab characters with spaces in emacs-lisp code blocks

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 Documentation/process/coding-style.rst                    | 6 +++---
 Documentation/translations/it_IT/process/coding-style.rst | 6 +++---
 Documentation/translations/sp_SP/process/coding-style.rst | 6 +++---
 Documentation/translations/zh_CN/process/coding-style.rst | 4 ++--
 Documentation/translations/zh_TW/process/coding-style.rst | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index c48382c6b477..c1e070f5c750 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -586,9 +586,9 @@ fix for this is to split it up into two error labels ``err_free_bar:`` and
 
 .. code-block:: c
 
-	 err_free_bar:
+	err_free_bar:
 		kfree(foo->bar);
-	 err_free_foo:
+	err_free_foo:
 		kfree(foo);
 		return ret;
 
@@ -679,7 +679,7 @@ values.  To do the latter, you can stick the following in your .emacs file:
           (c-offsets-alist . (
                   (arglist-close         . c-lineup-arglist-tabs-only)
                   (arglist-cont-nonempty .
-		      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
+                      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
                   (arglist-intro         . +)
                   (brace-list-intro      . +)
                   (c                     . c-lineup-C-comments)
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 5f244e16f511..284a75ac19f8 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -575,9 +575,9 @@ due parti ``err_free_bar:`` e ``err_free_foo:``:
 
 .. code-block:: c
 
-	 err_free_bar:
+	err_free_bar:
 		kfree(foo->bar);
-	 err_free_foo:
+	err_free_foo:
 		kfree(foo);
 		return ret;
 
@@ -671,7 +671,7 @@ segue nel vostro file .emacs:
           (c-offsets-alist . (
                   (arglist-close         . c-lineup-arglist-tabs-only)
                   (arglist-cont-nonempty .
-		      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
+                      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
                   (arglist-intro         . +)
                   (brace-list-intro      . +)
                   (c                     . c-lineup-C-comments)
diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/Documentation/translations/sp_SP/process/coding-style.rst
index a0261ba5b902..a37274764371 100644
--- a/Documentation/translations/sp_SP/process/coding-style.rst
+++ b/Documentation/translations/sp_SP/process/coding-style.rst
@@ -604,9 +604,9 @@ Normalmente la solución para esto es dividirlo en dos etiquetas de error
 
 .. code-block:: c
 
-	 err_free_bar:
+	err_free_bar:
 		kfree(foo->bar);
-	 err_free_foo:
+	err_free_foo:
 		kfree(foo);
 		return ret;
 
@@ -698,7 +698,7 @@ sanos. Para hacer esto último, puede pegar lo siguiente en su archivo
           (c-offsets-alist . (
                   (arglist-close         . c-lineup-arglist-tabs-only)
                   (arglist-cont-nonempty .
-		      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
+                      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
                   (arglist-intro         . +)
                   (brace-list-intro      . +)
                   (c                     . c-lineup-C-comments)
diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index fa28ef0a7fee..3bc2810b151d 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -523,9 +523,9 @@ Linux 里这是提倡的做法，因为这样可以很简单的给读者提供
 
 .. code-block:: c
 
-	 err_free_bar:
+	err_free_bar:
 		kfree(foo->bar);
-	 err_free_foo:
+	err_free_foo:
 		kfree(foo);
 		return ret;
 
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index f11dbb65ca21..c7ac504f6f40 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -526,9 +526,9 @@ Linux 裏這是提倡的做法，因爲這樣可以很簡單的給讀者提供
 
 .. code-block:: c
 
-	 err_free_bar:
+	err_free_bar:
 		kfree(foo->bar);
-	 err_free_foo:
+	err_free_foo:
 		kfree(foo);
 		return ret;
 
-- 
2.39.2


