Return-Path: <linux-kernel+bounces-39475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954D83D1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDE91C23558
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FE816;
	Fri, 26 Jan 2024 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fv9cm1tR"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD271C11
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230423; cv=none; b=bBrwCH9Jq55H5SHIF7OEFJOV36PK9SLEIqTfZL4ZmkwojICWDHT3itiFac4bX5LoVsG8nPBk2p9c1Cy9+T4JRHvyw+woBOBi8OE1N0E74YU7snRyB+KrDvlEMmkdUuYM3b074S/wi9h9iJwLB4gNli1rtZe5RnRWzhkn1kmwCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230423; c=relaxed/simple;
	bh=QuxxZaE5L8GrPM+q3t1r7YN+Zo56XqoDR/6PrJaKyeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBPhJSHFQ6NQOEY5yyS6P0OvAny1TC1yexrmlwh/ySkHJ6Uneg7QyEfJSr05+eDAgTmHNmWkYfVFr0TJS5/StD+GDxCn97K9+hQjEvBrNX6+JtYNErCFj1NSvZzO735Mu+AqCnAFplc7OwAupEgsBH7as1H3KGkVCs+aesa9DF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fv9cm1tR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-214de82b6ddso335234fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706230421; x=1706835221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYpbwXcXYiJ6roKOkYLJmrvPmRofsX5FO7Hr83jUdbQ=;
        b=fv9cm1tRuj04y4OsZoCeKlWR6Mr1nSrUOYCB2ZdSdW8fOmODGKMgl9WaOmORNmISGD
         8HFLUbvzCIa1iL70GOrmS+6Ijp4vT8vFxGccWyELewdEyYjY6YMlLcP5XkDpTDz8YEIx
         001HzGxu/pUf9Gokg4PxwfnJPrI18i+WfCbzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230421; x=1706835221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYpbwXcXYiJ6roKOkYLJmrvPmRofsX5FO7Hr83jUdbQ=;
        b=bFSV252rb0nrlJUHoEvB13Nw7AgA/cz86euobe8eq9XK1fYA4XW/stmmlCwlyJr4tm
         HaFJwonw6x+wUKDi1rZhWwSvIfstIHxal5a52+b7HgX2kXG9/wPVMPd9fj+m8U/3Llyd
         qhl0M51n1fAgoiVl4kXHlrVvekXgiE2jw2gpwb5ZMXBVnqJEvX63t35O5LvGgxM99xiH
         dmGFTHi/qA+2acp7Er3+hZ2DypFoZElySXQc82K0zDo3EBSoMdly9yoG8kTC8G9zUMlL
         WhqdY/yNPE8IxT8kreFPBqhbDFuS4aItbOB8CWyEIYB8Mxr2DnkUpOmkfOcXfEwZR9kT
         t++Q==
X-Gm-Message-State: AOJu0YzLvim/6RfZ8VesItbYqVn5M31hPb12ZS0KCzxSu2Mt1fvj941B
	oyu3IbW6qgtMEJsUPZr9RakKXoDBdLqqdbmcIHa6SBJ0/qOZnCX/rZSdvp7paQ==
X-Google-Smtp-Source: AGHT+IE6u99yVo493L/bDH8mc50JjPU3nBjlkljRQufnwfOBxjjHm5jgbmWXPaXAguCaWwhDpGZgKA==
X-Received: by 2002:a05:6871:530b:b0:210:a7d4:44ef with SMTP id hx11-20020a056871530b00b00210a7d444efmr572248oac.110.1706230421521;
        Thu, 25 Jan 2024 16:53:41 -0800 (PST)
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id o15-20020a63e34f000000b005c2420fb198sm123208pgj.37.2024.01.25.16.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 16:53:41 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: gregkh@linuxfoundation.org
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH] coding-style: Add guidance to prefer dev_dbg
Date: Thu, 25 Jan 2024 16:53:11 -0800
Message-ID: <20240125165311.1.I8d9c88e747e233917e527c7dad1feb8a18f070e2@changeid>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During review, it was suggested that drivers only emit messages when
something is wrong or it is a debug message. Document this as a formal
recommendation.

https://lore.kernel.org/linux-usb/2024012525-alienate-frown-916b@gregkh/

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
I'm sending up the change to documentation while this is still fresh.
Will send an update to checkpatch.pl afterwards.

 Documentation/process/coding-style.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index c48382c6b477..f8ec23fa89bc 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -899,7 +899,8 @@ which you should use to make sure messages are matched to the right device
 and driver, and are tagged with the right level:  dev_err(), dev_warn(),
 dev_info(), and so forth.  For messages that aren't associated with a
 particular device, <linux/printk.h> defines pr_notice(), pr_info(),
-pr_warn(), pr_err(), etc.
+pr_warn(), pr_err(), etc. When drivers are working properly they are quiet,
+so prefer to use dev_dbg/pr_debug unless something is wrong.
 
 Coming up with good debugging messages can be quite a challenge; and once
 you have them, they can be a huge help for remote troubleshooting.  However
-- 
2.43.0.429.g432eaa2c6b-goog


