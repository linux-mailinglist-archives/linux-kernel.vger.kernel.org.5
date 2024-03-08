Return-Path: <linux-kernel+bounces-96761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C8876114
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C5F1F24619
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B953814;
	Fri,  8 Mar 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLVOa8mx"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8254729
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890857; cv=none; b=rcI2oYKarNEmZ1xj+TFEMVG7BDWhRAKIVy7uT6k6hqJ6bRVhvHmJmBrgigt3tSXpcb6bDoL+L44atY9570RczNZEHhs0AgLpEIRDLGSAoT9Q0N37eFvqkxxEWeOdEz9jXiVCL9xEl2GY1l+KnS9TRrXmvUqzzrGxw5Z6pLgizG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890857; c=relaxed/simple;
	bh=C9XK9ZxSXymb1vMc31LtX73tBcw9vGPwzW4aTnLQO/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Is1oxysJxbKQGc6X2Gyv5M+B748GKjrOX2tdnkjtefCSra67j/3BTpp/IrLEb2NCxMMNIeVyTAXRzrbTqjDUWV7TZ80tNvEXCKh7T0+xQmkQcGiR43lVEsW5J9quxo87yAiS/q/LjGBIaMK2kjljX/NsqL/YIwzceEzV22/Z9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLVOa8mx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29abd02d0d9so477944a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890854; x=1710495654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mwwKF7cZe8a4mOKgrVDHuor07KbATDTuF27fGKtoeQ=;
        b=lLVOa8mxwn22U5jZgmebnBWGZlQPI5jF/AlEhV9NKx9rWUE/yVVZPGoDH8wVCCzJ+1
         ajtpy9TjP5z6zSIWZBDd1oFv0cwIgcC7SbomtXnafiKZ5TfFBx/c1Wi98HDeAcRYQgvO
         eUZzjEB7asgsLrTEeiTmZRQIy8qtBRBDWj6BcBjK0A9baIXkvl5/W5VoW1ktzkiRoT+v
         SEBbkkg+Wk2CqWu4N3bRnxIaUL1wU1LX527tFcLmgRj0Q08yS15wbFpx3Jqd4QQOZtg/
         OD/YdoY+ZcuOiFWhAk6fbjPPR+tCEKn7DXA+EzKN+xiHLVi39vCokwdlZniWor3Ysr+R
         HS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890854; x=1710495654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mwwKF7cZe8a4mOKgrVDHuor07KbATDTuF27fGKtoeQ=;
        b=tGqK/T7s3REajNDOMLVAnQnb4v4XeQlShA0sQ2UN4x2ff7gBL+SnSwE53xzYG0xCPV
         4Lrtqd3W8FHmmbdkRnqXzbCSjfx5j18hqndBsSqPTNXgibP+PEmNd9JM/0TWUBXQj2hZ
         CKCCswlcNvo4fRiFUSydVbmzb58ObEgpGtdBGTLGPhlU3EntCS1+PxqDbiqBclc+7jDr
         fkpQb7KAEeXctW+I2vRBHO11Dm2LQRJMWOHLWrC9tURuEf5C5R9S/g/2qiy8Y9nwts7e
         JNJ188D4MJ/YPnk8HycY408gQtKsmDSVkmNNm8C6dIgslS7fKN+n3q4np6XqRJy1muS2
         e4dw==
X-Gm-Message-State: AOJu0Yw7c+uRT52v4N4Xi0E7cMXTeBxV6uOEveSzq/jcEq2EQlaNhRql
	LtSodJkoCBZjQ7QAd7mDVgPvmjutzLa05tkMP1P/ALrLmOuXdVgCvljVjvcR
X-Google-Smtp-Source: AGHT+IGM9lc21mIP4OhnVWKEZ9QWWnWvDTrfxi1fKe8ArvriZhhH4yVjKOrJKMkEMwAWSVLPGJI+OA==
X-Received: by 2002:a17:90a:3d45:b0:29b:125c:a97a with SMTP id o5-20020a17090a3d4500b0029b125ca97amr16812237pjf.43.1709890854295;
        Fri, 08 Mar 2024 01:40:54 -0800 (PST)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a2ec300b0029ba7731d38sm1324463pjs.7.2024.03.08.01.40.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:40:53 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/4] workqueue: Use list_last_entry() to get the last idle worker
Date: Fri,  8 Mar 2024 17:42:53 +0800
Message-Id: <20240308094253.2104-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240308094253.2104-1-jiangshanlai@gmail.com>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

It is clearer than open code.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3bb71cfd3e06..7a3392aab395 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2940,7 +2940,7 @@ static void idle_worker_timeout(struct timer_list *t)
 		unsigned long expires;
 
 		/* idle_list is kept in LIFO order, check the last one */
-		worker = list_entry(pool->idle_list.prev, struct worker, entry);
+		worker = list_last_entry(&pool->idle_list, struct worker, entry);
 		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
 		do_cull = !time_before(jiffies, expires);
 
@@ -2982,7 +2982,7 @@ static void idle_cull_fn(struct work_struct *work)
 		struct worker *worker;
 		unsigned long expires;
 
-		worker = list_entry(pool->idle_list.prev, struct worker, entry);
+		worker = list_last_entry(&pool->idle_list, struct worker, entry);
 		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
 
 		if (time_before(jiffies, expires)) {
-- 
2.19.1.6.gb485710b


