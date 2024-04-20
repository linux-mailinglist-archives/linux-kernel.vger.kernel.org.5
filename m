Return-Path: <linux-kernel+bounces-152157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B58AB9F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7FD1B20F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF410965;
	Sat, 20 Apr 2024 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg8kF4Gy"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762D205E32
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713593711; cv=none; b=MloC/lroaRJe5MJNQEMwwbJKQXrHoEP81nAIojtDC60xiCSUkh2KKyPZmkau50YiiKjCPJ63l97z1BtwQLT7Qic0+QUwrhrZulv+RSDdelCaOfPXlLxPTMJkyWG5TiZa38ogmeUn8qurpk5wtyIjyblOcdIKpR+MuduvZia3u0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713593711; c=relaxed/simple;
	bh=ZolRI2ztsSyqYXap63TOzAtzW5UT+oyhSNBzd5uy1Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9kcEcliBmDbUDGDYNvgTW0ajR6h8y4NXeBOLXVxqgpFKeA4OWnMIsX0H1EoSDEoIN12H2Q6GeYw+4O0MickP6NnnGalxXEYSGLJmsPAOBtmdUPLNh9fS+EwW1emr8eXKxB+RazyAS1A/mHHP/RTZmWkxVjhG8Dqe/yEB1Mk250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg8kF4Gy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1797638a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 23:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713593709; x=1714198509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlC9FsdeF0rfQMdZj7e6J8+wbY+rNUqhDWpmqrph2kE=;
        b=Qg8kF4GyrbMYpygolQejTAhpuMEenESv5nZe63GweDAZ/P0duR4famgxiDktUwvbIO
         MJF3ikz6Fe+WPW00CeA8EYWl1RTDQ3LARbHjB9uu/wAd8LnVWXmvaj+PbaQwxcqtObMY
         byUlvSR5uf8mxv5y4t6K2dS3unVxNtzj3tH9qWAj7t4N4f5RJdN06Ze8yPPsroGFP1gf
         iniY1OGtVkMI52Jni/58aVC6dEeqtkk/wZS7xv4kYwVUvRJWqRuA7OAC0jmCOdZOTnuP
         BMGJ6tkXqyOpO6I6rnbmJQsypF5tClfPhXX6PkSslKXdODmay1EJUwHpaWLGK3D+nlHs
         4Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713593709; x=1714198509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlC9FsdeF0rfQMdZj7e6J8+wbY+rNUqhDWpmqrph2kE=;
        b=wKFxmjtOFqyzFUI4VUWrOFFPqwH5+LtW4Y0eT6oZ5kry+CzgyWEGQjA6qHNECdu96Y
         TXbA0BURPyNibOdqiQIFlLze4hLpIy68u52YXtK/yL/Tyz3Jqku4AYe1hHAFRwCFY7Mk
         /5y0FkKPgsYbXqeoW9QN0irb1h/Y0PXEJ29xbfL7TkTlOc4hU3vVMfORdhSHZrUYiCIw
         EKpHnKRlJGkTiU6iH6UQ0RC8t2Y32NLVuA5DKiZj8N2KS9PWf8CHH5GB9Xw2ciJYC6iX
         IyfRbdn5Z+yByy8MU7aEmt+pUqPt1Yo6ISMVEOreIiz32GYUDQfLBEjCSvQo8vI7Bz5R
         SUkA==
X-Gm-Message-State: AOJu0YzLnSFsIGVVg1JWXP5QanbUK+ux0MrAEz0JZR8BsAqBXQLQu3jh
	mZZpEASf33mRjdrfh3hrbzrNMCknFskd3kr8DHZEvbZlQoGjaNAGXQGeEd4Ymt8=
X-Google-Smtp-Source: AGHT+IHGpfiTq24KebTzUO6zupQ0+w0WXQlTrWgBUbY7ZE+7booh5eMWYuU4wjQejiGMx8ENm6/XVA==
X-Received: by 2002:a05:6a20:3951:b0:1aa:a473:3ee0 with SMTP id r17-20020a056a20395100b001aaa4733ee0mr5059294pzg.6.1713593708848;
        Fri, 19 Apr 2024 23:15:08 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id jv21-20020a170903059500b001e89827e2e8sm3774338plb.305.2024.04.19.23.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 23:15:08 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in input_event (2)
Date: Sat, 20 Apr 2024 15:15:05 +0900
Message-Id: <20240420061505.62849-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000006d6f4105d2fe05ed@google.com>
References: <0000000000006d6f4105d2fe05ed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test deadlock in input_event

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/input/evdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 51e0c4954600..181c798b232b 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -258,7 +258,7 @@ static void evdev_pass_values(struct evdev_client *client,
 	event.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
 
 	/* Interrupts are disabled, just acquire the lock. */
-	spin_lock(&client->buffer_lock);
+	spin_lock_irq(&client->buffer_lock);
 
 	for (v = vals; v != vals + count; v++) {
 		if (__evdev_is_filtered(client, v->type, v->code))
@@ -278,7 +278,7 @@ static void evdev_pass_values(struct evdev_client *client,
 		__pass_event(client, &event);
 	}
 
-	spin_unlock(&client->buffer_lock);
+	spin_unlock_irq(&client->buffer_lock);
 
 	if (wakeup)
 		wake_up_interruptible_poll(&client->wait,
-- 
2.34.1

