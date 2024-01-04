Return-Path: <linux-kernel+bounces-17160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EC82490E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB79B1C224AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F52C1B2;
	Thu,  4 Jan 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fU/o5oPz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159EE2C19E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f53b4554b6so13270237b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704396699; x=1705001499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dKx45HTp0b4xIO1bOxeSuZrQBl5REepZTvzMnrfd4hI=;
        b=fU/o5oPzrbPUIfqFh2HFkFoNd+RMo3dkrg5muCXbgfwzu11c4bgqkk9FSn+2ZlnASg
         bUHO+du4lOKMR63GYLkRFJv30jeALzZNehagmLeGmhIdvwTmef6mhYaBDJV5lV0GET45
         UcfbVJDTRw+k+wBS/9uvVLWwrHXUVomAOxwVHXv6pM+Q8xQ4vDj9puW2KOLfvwz24SJI
         SbrDYPYIlP80W6IsqpXA/ZHs5jCtQ86Nj4k/h/2Pd741lZKxXp5i7jpMYulyEvewC/Oo
         uQO15b70kinsfxOOizjELUXrl9clhxyreLfZYMpa+4hEMteYUADQBvd9GuUuUc5jvSe6
         vLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396699; x=1705001499;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKx45HTp0b4xIO1bOxeSuZrQBl5REepZTvzMnrfd4hI=;
        b=mtfZMIjZDPjEXl09YCQb7eXA94/C6wAMIer/pl0LE3/LYkXFlLFlafWQ9HBfLa0AW0
         ogEZHgd/vPBhqyuPAONnxzKaRR7lJsD+tV0ZhWlGfvM9f6E31xu2fpsIzxXZg+rTcz0L
         yheMjOEPRby+j5OD69Ws/P/YqXG2EjXtrn77MPsAoWQqGBAfXrRJxu9IanKDfkAdnNwV
         xBZpyVZwMgO603rYnnYU9FIlrX9hhFeDwxbIAuCqV1ApKcOHfByd4GbfWrHJ4+Ot4RJt
         7HKtCm/hZdicWcUIXeSxz4FeyNqBlza80JMSsRr6ZLrmjgd8iBdWkZMungYw+/kEh7/Q
         A90g==
X-Gm-Message-State: AOJu0Yw3WNHzfQzwMaezgLXB3tW8lqWECvzYwELtXOofx1HASOxrOL7K
	PmS7U8Byc4knhvNQOLl7sYTYtw32jQAg6eqDzcE=
X-Google-Smtp-Source: AGHT+IGFPOpQPZcVAcZaS8m+YGry0n/a8P4727XpuPp5J19oo6vmywqKUyE2onkIULmizhldKPH62SnDi4zb
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:690c:3383:b0:5f4:f576:642d with SMTP
 id fl3-20020a05690c338300b005f4f576642dmr420242ywb.2.1704396699032; Thu, 04
 Jan 2024 11:31:39 -0800 (PST)
Date: Thu, 04 Jan 2024 19:31:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJcHl2UC/3XMQQ7CIBCF4as0sxYDCI115T1MFxTGlsR2mkGJp
 uHuYvcu/5e8b4OEHDHBpdmAMccUaamhDg34yS0jihhqg5baSCWNYJwpY3ityEwsuqHtrHHSW+2 hnlbGe3zv4K2vPcX0JP7sfla/9S+VlVACnZdhQHtu1ek6Eo0PPHqaoS+lfAEoJBEyrQAAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704396697; l=1023;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=o8ZjFGvVRgAOV0PoxZM4zUboX/hIcxwiDge9/iyOGQM=; b=5lAIJ80+siN62VvzAwvXsNzu6CG4HnB9waOM/hpOGI7dmfcK8AWqFSAUB2Lzqv/JuwTxw79S1
 H73yzEWogqSAfA67hbQMirOJ7jGBq1A6gFfWkkHkZIXxvC64foLHimI
X-Mailer: b4 0.12.4
Message-ID: <20240104-removeduperror-v1-1-d170d4b3675a@google.com>
Subject: [PATCH] android: removed duplicate linux/errno
From: Tanzir Hasan <tanzirh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Nick Desaulniers <nnn@google.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

There are two linux/errno.h inclusions in this file. The second one has
been removed and the file builds correctly.

Fixes: 54ffdab82080 ("android: binder: binderfs.c: removed asm-generic/errno-base.h")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---

---
 drivers/android/binderfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index d04ff6029480..3001d754ac36 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -29,7 +29,6 @@
 #include <linux/uaccess.h>
 #include <linux/user_namespace.h>
 #include <linux/xarray.h>
-#include <linux/errno.h>
 #include <uapi/linux/android/binder.h>
 #include <uapi/linux/android/binderfs.h>
 

---
base-commit: 0c9ae0b8605078eafc3bea053cc78791e97ba2e2
change-id: 20240104-removeduperror-9b6954a0c52c

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


