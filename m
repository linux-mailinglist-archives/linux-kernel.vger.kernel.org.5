Return-Path: <linux-kernel+bounces-38999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B7C83C988
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D56296982
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D9C137C30;
	Thu, 25 Jan 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnaI5bV2"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8C13666A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202395; cv=none; b=aK4nH9Eiw4C/7VltCHEAOKLM1t9Xo+ZKfkjR8/lrhY6ugxQKvhZsuD5PRT4RUMG7NWZJhKHAeqI1rgLEeuXneZr9AOdy+QKjceLcvpKrWJHzitfoH5A46E1woFcy+9RlUdAIcBbapzeM/5NQqKaXK0By1mbXH/4Z41bugXR2BC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202395; c=relaxed/simple;
	bh=bPT/6QybvQwTjJ4PqND1NYBq6WKHpme6IYiLGQgRAmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVNJZ/AVJ1CMkLDQ9krwLRlOWbovOu4bOBoiovjcC9OD3/d91S1WtXPcWa5BMiNk/3ihI7l3DiNd9zcfYLUqkZdPNpns2ZpEUE46T3IKW8rwNp01E2sltxlm7ukbKtntThTbKPFTaYDtt/uJS0Lfe8S1UcZY5YP8PbCl5KoXzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnaI5bV2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so3415461a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202393; x=1706807193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP6tkjIkf0A+I5KjZDOQhEvv2uLtPVAkIsL2SzHsOxw=;
        b=FnaI5bV2oebwds6+3PU5QZ5Wtb/1NtoBSGXizNgPWvCBq8yaM/+/TcATxGhUFCObmb
         5XuMHGZMee7NP0NL/fgGONRDbRo2jRLkee7LUPiwvL+51AvquvhdVj7cfhA4aeMy22fJ
         cHx1SEML+DZacXCZAkQMc/duLsuBEE71zIObqs15pcq7ZpvRUzi9cCO/hbobF3eyvIyZ
         dmG+cE7ECXZ7LNDBZhuhg+8k+QqthTVW3wrwHsTSY/WXurdl+jW6s/FBt6wyMm3z4IHs
         ypX/04WgGZ6TMCdU3EB9lvc6vLv8vrtGJCEKn8tYVr9eqD/Q6D4SO3PjcDwVhw8WZLgs
         5BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202393; x=1706807193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EP6tkjIkf0A+I5KjZDOQhEvv2uLtPVAkIsL2SzHsOxw=;
        b=e2eWp3PiRhI5ikuDlbYDXOOyk1TYS4EHyRJ3vqZsPYVAzvnxtBLOgnjV0dF4x9PdHr
         s1xTmbs18iWhPk/Il3jtQjl9F7IvCuc20wjZLA9+GQzi30Q1122+l7vQIp99FQB+8Jc0
         ekkLsyRBMvNIYmyQDHXASBULvQxcBE7GOIAmxBSVglJTb7yLKGrhLpLhR2vN0cigqaDx
         EVUuYUkpvtA7IuX0+0MRuTvY44e842v2jAIO4AyiIDnRh8W1UWj+AaLx04Dx0cCqS3lW
         OQ2o8Zc0+f7BZG5Cjo8SYHFlT6VWW1A4PHr8fwk+ZrMPxS2QMju+bt9YbgYsd/Cg6vk9
         5uaA==
X-Gm-Message-State: AOJu0YwmXmqgdm2hiErf47BxP1SQtH2ZdvsLeEIV3LqPOt4Qpa8V9Ofq
	I2zq3VAI7avSTD9E4O7DtgDi6qq1yyjrHyTQvnQ54JZt/SV9kRvF
X-Google-Smtp-Source: AGHT+IHl0cJlj6qIU+AjlaWK9GMDxCUeTMcgMqi/pcYX010iWepRIcyR8Fu/RlSd5U7MS1ifRKdjLg==
X-Received: by 2002:a05:6a20:8f07:b0:19c:2a5e:ac41 with SMTP id b7-20020a056a208f0700b0019c2a5eac41mr1211740pzk.71.1706202393650;
        Thu, 25 Jan 2024 09:06:33 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id f11-20020a056a00238b00b006ddd182bf1csm1555549pfc.46.2024.01.25.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/10] workqueue: Factor out pwq_is_empty()
Date: Thu, 25 Jan 2024 07:05:55 -1000
Message-ID: <20240125170628.2017784-3-tj@kernel.org>
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

"!pwq->nr_active && list_empty(&pwq->inactive_works)" test is repeated
multiple times. Let's factor it out into pwq_is_empty().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 67d9ac1f0990..9e75535c4aeb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1456,6 +1456,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 	}
 }
 
+static bool pwq_is_empty(struct pool_workqueue *pwq)
+{
+	return !pwq->nr_active && list_empty(&pwq->inactive_works);
+}
+
 static void pwq_activate_inactive_work(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
@@ -3326,7 +3331,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
+		drained = pwq_is_empty(pwq);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -4776,7 +4781,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+	if (!pwq_is_empty(pwq))
 		return true;
 
 	return false;
@@ -5214,7 +5219,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 	unsigned long flags;
 
 	for_each_pwq(pwq, wq) {
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			idle = false;
 			break;
 		}
@@ -5226,7 +5231,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 
 	for_each_pwq(pwq, wq) {
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			/*
 			 * Defer printing to avoid deadlocks in console
 			 * drivers that queue work while holding locks
-- 
2.43.0


