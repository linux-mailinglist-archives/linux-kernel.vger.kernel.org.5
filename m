Return-Path: <linux-kernel+bounces-109480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96650881A10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CA61F22089
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC1186128;
	Wed, 20 Mar 2024 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q76+N/er"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E56BFDB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975889; cv=none; b=C465AjGvutgsHcCq+Sa+fmNu2DyYyS3yVnf/eBoCItHIgZcjUzOl6sX8caMJftSMzfOZuSKIyIJ3lx2ONwDjVvku/TDr33IQD+KzUKNJL2CuXD777Dcqd0uGVYyDy6KGIkz+a2a/8xrKysEbtPmgdMdbYVMfL/uIvC1C7PrmPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975889; c=relaxed/simple;
	bh=xdt3WcZtzp6V+dVSO0oQ0nQ4PjO+mTElm8qjYyLdYhc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AVZYBuen3hmcoRBGlh97rgsmncENb4XKAf6wZZ3K+Sp+/wLvWF2d33cnKXm+pEycQkzeF3oj11ZlwQnZbExto80i7YqUPmPV5EDISAgFoWOyk30I2KL/d1ovrthu8gwqUJUYTIDLRvrE7Fn6BxWZVexUewFemY3UrizCCqrbiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q76+N/er; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-366c3152af9so3618865ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710975887; x=1711580687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g2+RO3cMaS60sPuOhp6UDFq45HF6306U2TZ9coJYJqo=;
        b=Q76+N/erYG4HtEVqddQUCkoP6uaBdSlr/7SIL5ilXWCfLNZV8voEEccSiVjDX7ZUT2
         JTZz38Mo2VJOI57FfdHbdIVL4xcFr/Utqwz3bYIuIoDfAnALOPY1gNUint4hd84Eb4bD
         Hx27l25S2yOx9dvDB9Q4dsHnAZoEWLPYOHeSgPaszW+KYh2/GsNFE8NHMfcQV0WGSO+z
         YZL4KANTuoSqL7gl0NIha6SX8Gyw+Q50qce20yBhak9s6VYlI6RROqsOyjjKuEQAYDa2
         SNUxmERbOcYsPIhXVj86sRJAF6CPB+9dsePqXiP/DDEHCKTfwM/SGm4/iDQDazHoomfR
         bgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710975887; x=1711580687;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2+RO3cMaS60sPuOhp6UDFq45HF6306U2TZ9coJYJqo=;
        b=giZRBCkIkx0tEOypminr/T+K42uV5Nfzdc0NrB7Hyv1/dNtKaqQzqKA0AGGXATMmkf
         1eqe3s5K7ia3vDGU60xAY1d8xIxH/CDRhqUpb1kpeYXnc8+x2l69PFuAw08CELyvflAo
         S2/+TK0+KYQElge56eznft8J4oy7W8NH4vWNIfv9RB+HWKmM3w2LzbgEUCwmNBY41fvP
         +qMMbPS6kg/MLHFGPvKnSyn8Gsr61i/1bdM52lpb4x1MzO4S/VXtTVMFL09+xvnz4xYR
         M4pGem4UuVvUYDJ/+8UMjRqZeuafzYgjsw3rKwJaIRH+guxZ7Y0GLVOXhzJ1u7ijf/We
         IoYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa5xRyTpD4IP4rdlbQfq8755qpc3aQIZueFnwJlZS/2D/8agRyzsxb3LOMlQb1FnhgmrM0pZOUtDxoo5O7XhpDp9aVoU1CytfF16Xu
X-Gm-Message-State: AOJu0Yys6WRJm3XnFXBer59NmOUlgjsZY16rpcVydxazctZXjdak41wQ
	yzNmOYHvWKya4JPnOi5zDK2Q48BwC5EtgFOHLO7CEx6iY/gW7P5MITSueaGfwZsrDcWoMvj46Pf
	bBR2EceOPFLz57z8/4pbOkA==
X-Google-Smtp-Source: AGHT+IE0SUB2ouJtetdQjpyRX2R1ogJVbIpFy4IGejw06L4AAiIp+tvbaFIe6uUWSz0Q/ZKxotmWusw1YlBBb6OKEg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6e02:1d92:b0:366:a77e:62dc with
 SMTP id h18-20020a056e021d9200b00366a77e62dcmr201298ila.2.1710975886819; Wed,
 20 Mar 2024 16:04:46 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:04:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAItr+2UC/x3NwQrCMAyA4VcZORuoXSnDVxEPW5pqLt1INEzG3
 t3i8bv8/wHGKmxwGw5QdjFZW8f1MgC95vZklNINMcQUxhjQ3tpo+2JRcVZDl8Ir1qWw48fZ5ro gYRpznihxzTRBb23KVfb/5/44zx9EVBqXdwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710975885; l=2023;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xdt3WcZtzp6V+dVSO0oQ0nQ4PjO+mTElm8qjYyLdYhc=; b=f19YsudHfgvlM7ugu8UM5KyMcxaGHMzV60fbyToO/flwakuV05BaMfUOCc7dw5o6ikznP7JLg
 lq8Lb1GsU1SB6+LQuJnlOA6neOghUGwiYYU+BFbN8vqiabgKJN2iJdY
X-Mailer: b4 0.12.3
Message-ID: <20240320-strncpy-drivers-video-fbdev-uvesafb-c-v1-1-fd6af3766c80@google.com>
Subject: [PATCH] fbdev: uvesafb: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect v86d_path to be NUL-terminated based on its use with the
C-string format specifier in printf-likes:
|	pr_err("failed to execute %s\n", v86d_path);
and
|	return snprintf(buf, PAGE_SIZE, "%s\n", v86d_path);

Let's also opt to pad v86d_path since it may get used in and around
userspace:
|	return call_usermodehelper(v86d_path, argv, envp, UMH_WAIT_PROC);

Considering the above, strscpy_pad() is the best replacement as it
guarantees both NUL-termination and NUL-padding on the destination
buffer.

Note that this patch relies on the _new_ 2-argument versions of
strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index e1f421e91b4f..8b554fcf1bfb 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1867,7 +1867,7 @@ static ssize_t v86d_show(struct device_driver *dev, char *buf)
 static ssize_t v86d_store(struct device_driver *dev, const char *buf,
 		size_t count)
 {
-	strncpy(v86d_path, buf, PATH_MAX - 1);
+	strscpy_pad(v86d_path, buf);
 	return count;
 }
 static DRIVER_ATTR_RW(v86d);

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-drivers-video-fbdev-uvesafb-c-43668c4ef6c8

Best regards,
--
Justin Stitt <justinstitt@google.com>


