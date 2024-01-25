Return-Path: <linux-kernel+bounces-39000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C583C989
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3371BB26F03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911213DB8C;
	Thu, 25 Jan 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6FtVgb9"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE213667D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202397; cv=none; b=oTCgfvmnkFRSBX0wBpbY6mjCV/esjamRAMB1/0YiLnoqzq2RvwTEuvIp3SNtnV3SZm+zkrgkd46yr9sOb11vhiBydXFInuG9C6r9O2WYSwYPsgcfJyRCAGLO5Lmc0ZRCEAPXAwHxEUdduUaOF63+l3G+UGdbRsbskslvnB++HTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202397; c=relaxed/simple;
	bh=M9m/Jy9Gw+jdj/vfc/MJd5VwxVDjgNlm5eObswq3By8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYF17t+1U+LZzzMkY48cu3aJuaLrq/SXEHb0K1dqLDXJNnHmHlN1PBy6H6CfU+LA39Ux3ng/PRjVbnGqUcriRFR+YAy3+espyjyf2oBhzwre0v+DvXSf+ffQXisW3QMvLalVXKsjgOUU4hdO3RPpp8K0W/lJDun9eAjZpl83HHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6FtVgb9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so504689b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202395; x=1706807195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOYkM/qLWTiwy9Fw63ezSNvZi7VG4jWrtKoEUh14gqg=;
        b=K6FtVgb9Mh7uxqoCmHsYuEV5mQYiyjjKDHcoiJaSSAZ4S/ze29mQRaqHWxZOut8aK8
         rkeoh8XZbPSed9J/GT33OcL8vQZhf0SzelT+ZbdFPl+mh8ctcToaJMgjoTp9KDCIpidD
         se0P5wqNnuojxOeVxQGeMa39KD5mDeLdztYbaTULRlrLSTB0zZYtgTraJDtW+Dya5heH
         n2W4pYx7UmSdCsaH7KC6J7r8Sg/00KntRaCQDUiME77/4iax7yVpq6mgPP/6u1/hh8Va
         UP9qkMUog4i1DPggSYiVevwiUr+iBAuG010w4Q17/pB0aSbMvUBYiRVLDQAzDcrBYrY0
         Kxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202395; x=1706807195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YOYkM/qLWTiwy9Fw63ezSNvZi7VG4jWrtKoEUh14gqg=;
        b=pY0jPVqplE56/jKTdVzKmAe3+rxMODWCqIHhqHnK38Y6PT6E66vC4BQ/k7aCJUm/t0
         N50PqAToI/w6LQelTkka7wZFPg8FXZNMK6HoThb9oZgcdcfIe/jICfXqeRRTZUauRc+d
         yW2ncP82QkBmdBHZGl0XtEaiBGGpT0Hcl4cN0l1G/B3rmFlZeRGRjq4o/ausswmbGndQ
         9Qerv9wwNACd5Umcxx2GFJIcwqwNJdO4iDmQ4Dyzolx5BrORaptWvxqPoQ3hrLJlIud/
         9T6JIzPov/nqbeHsGTEoTXDp03YdTNngv12GjUetIGjLDd64GGZcqsJPbWvQv4cvgBW0
         UlOA==
X-Gm-Message-State: AOJu0Yy3U8CWgJb17qN/WDfInaYiB9q6/e+KFcwWPLooLCWLqvqz92ny
	9zzCfGnww0hb+PzVuu9nbAayrZ5U1uIxaTe6nExr6kd7cAGzhp9t
X-Google-Smtp-Source: AGHT+IEwntHPTbrgS7Xj+gWyzBhxAfP8cO8ZGJBD/bnc0p6uVJizZl16B4OAcP6S8IFUAsVPB7h8kA==
X-Received: by 2002:a17:902:e54e:b0:1d4:bcfa:2b0e with SMTP id n14-20020a170902e54e00b001d4bcfa2b0emr1264727plf.93.1706202395118;
        Thu, 25 Jan 2024 09:06:35 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id s17-20020a170903321100b001d738e94557sm8227996plh.4.2024.01.25.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
Date: Thu, 25 Jan 2024 07:05:56 -1000
Message-ID: <20240125170628.2017784-4-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125170628.2017784-1-tj@kernel.org>
References: <20240125170628.2017784-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for unbound nr_active handling improvements, move work activation
part of pwq_activate_inactive_work() into __pwq_activate_work() and add
pwq_activate_work() which tests WORK_STRUCT_INACTIVE and updates nr_active.

pwq_activate_first_inactive() and try_to_grab_pending() are updated to use
pwq_activate_work(). The latter conversion is functionally identical. For
the former, this conversion adds an unnecessary WORK_STRUCT_INACTIVE
testing. This is temporary and will be removed by the next patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9e75535c4aeb..3a4c269204f3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1461,16 +1461,36 @@ static bool pwq_is_empty(struct pool_workqueue *pwq)
 	return !pwq->nr_active && list_empty(&pwq->inactive_works);
 }
 
-static void pwq_activate_inactive_work(struct work_struct *work)
+static void __pwq_activate_work(struct pool_workqueue *pwq,
+				struct work_struct *work)
 {
-	struct pool_workqueue *pwq = get_work_pwq(work);
-
 	trace_workqueue_activate_work(work);
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
 	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
+}
+
+/**
+ * pwq_activate_work - Activate a work item if inactive
+ * @pwq: pool_workqueue @work belongs to
+ * @work: work item to activate
+ *
+ * Returns %true if activated. %false if already active.
+ */
+static bool pwq_activate_work(struct pool_workqueue *pwq,
+			      struct work_struct *work)
+{
+	struct worker_pool *pool = pwq->pool;
+
+	lockdep_assert_held(&pool->lock);
+
+	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
+		return false;
+
 	pwq->nr_active++;
+	__pwq_activate_work(pwq, work);
+	return true;
 }
 
 static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
@@ -1478,7 +1498,7 @@ static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_inactive_work(work);
+	pwq_activate_work(pwq, work);
 }
 
 /**
@@ -1616,8 +1636,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		 * management later on and cause stall.  Make sure the work
 		 * item is activated before grabbing.
 		 */
-		if (*work_data_bits(work) & WORK_STRUCT_INACTIVE)
-			pwq_activate_inactive_work(work);
+		pwq_activate_work(pwq, work);
 
 		list_del_init(&work->entry);
 		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
-- 
2.43.0


