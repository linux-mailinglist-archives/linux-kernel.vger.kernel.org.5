Return-Path: <linux-kernel+bounces-151752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC588AB36A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFB41F231C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F340130AEB;
	Fri, 19 Apr 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUV+a5uJ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971ED7F7C7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544435; cv=none; b=mx86JRcRNQVePhQUltIoJHerc8IqFYZzDH/kaCfwRtzoLL8428Cim1ClAHKGybCvtdH0XyrT2KpWM8FRNIFZqnQe2WAYwcBbD/XHK0b9HFers+RJwaPp30+NvKLU+RPuXMH46eKYKXUdIFMfSRo7gHc/XhymNubkpZetOIlZu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544435; c=relaxed/simple;
	bh=sgCSOUrC5ChzQ9bGbhGDj4Ib9Y4rYjst+19uVQIoYds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rxe6/G5ZjNj5O7PGipXhCPbi4iYUvhEkCwAtPYTOrtVED3KJVbtrg940MUY4NrK3ni0BMV9r/4W88o60GWj20X7b4MhH4tOQgUGzY1qB0KFvj0LC82f2yOXF2lC3aDCSR6L6fyCVRXxKMeJP7iE/VkqUTM7iumBQJcA9h1VzahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUV+a5uJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f00f24f761so1961884b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713544434; x=1714149234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f/kdiwp4iNmzHb7qOG4xqLdzvYd8qDHQhZ+IysrBv8=;
        b=CUV+a5uJE+nEmJLzv1uRuRNcXXiQh/Kp9+MpDChlLY5oW20Bt8BbEhnLPpHhaNYtr3
         yrnB93eLaJ1dHse/i6b02CRMqoWEfNNghhg9VUl/QX5/uV+nFmF5MVmyY8HdO6a7M2or
         N3KtWUwkW4AIojj7KJnAkYoOKnPAe6Pj2rI8qtUso/swph/Qvbg27nM+oCudT8VwbHy+
         htdxzDiZh4LCqkv+tp5w/SyWChPXCl4XN/v2fM/yRJ4oJQCunrCcMGOugNDdFWh6LnHc
         mnEnnq99jdd9Pqf15GKBigSjzHQgcxm8iGF7NJhl2plxlP1V/VYF4/Tq7lmtS3DFSrPY
         KopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544434; x=1714149234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+f/kdiwp4iNmzHb7qOG4xqLdzvYd8qDHQhZ+IysrBv8=;
        b=u4oOWk1mni0wehT7vJ0+F2Z+SqDbdqX+fTuNivc2rhStZLx4OnH9own4O1qVuGH9fS
         oWVaJyMFWMX77yc3E1Huqo940urfmRSlZJqAtcwPw4aGpRze1iLifLb/N/CaefgYGuDF
         ZjLRdAaPcB3uvIt7jPgavQygW3vXPxfWcvUjmR19tFwfkRdCSEwYhPABP/d3prGuF1K7
         TGuX74H9OFBJ9HPKWkw91k+EeZZ7Cip7IyIEAGa//mVK4yrd2WELdMc0ipteSQAG95mM
         ZgDj0GnOgIbEAtvc182lMQm3B6hUCAD5VnwlOwj4C9l+m/iuXED2YEEeSSE1RF0ZnAub
         6wbg==
X-Gm-Message-State: AOJu0Yz6T08yX/4Ov71haqo3d4rKHkeG5mwBAWeWjHFi6z8SFzORFqpk
	v4lpuJ9xqzG70qgeVftcoj20vFHKHp5L5id/N6Yar5VCdZrZJoPl
X-Google-Smtp-Source: AGHT+IGlchinwQaHRtqz+GijWCiJDaHZtZvym4f0Q8uFUqz2oVlVsOznvySB0J4CRTervNCESw9bAg==
X-Received: by 2002:a05:6a21:6d85:b0:1ac:dead:b221 with SMTP id wl5-20020a056a216d8500b001acdeadb221mr172296pzb.40.1713544433702;
        Fri, 19 Apr 2024 09:33:53 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a00000500b006ed4aa9d5c0sm3419410pfk.188.2024.04.19.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:33:53 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in input_event (2)
Date: Sat, 20 Apr 2024 01:33:49 +0900
Message-Id: <20240419163349.20540-1-aha310510@gmail.com>
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
 fs/fcntl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 54cc85d3338e..30f4d75fdb03 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -829,7 +829,7 @@ int send_sigurg(struct fown_struct *fown)
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
-	unsigned long flags;
+	unsigned long flags, read_flags;
 	int ret = 0;
 	
 	read_lock_irqsave(&fown->lock, flags);
@@ -848,11 +848,11 @@ int send_sigurg(struct fown_struct *fown)
 			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		read_lock_irqsave(&tasklist_lock, read_flags);
 		do_each_pid_task(pid, type, p) {
 			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		read_unlock_irqrestore(&tasklist_lock, read_flags);
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
-- 
2.34.1

