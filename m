Return-Path: <linux-kernel+bounces-21861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BB82955A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA5DB24F12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8763C47D;
	Wed, 10 Jan 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Mth3+QK9"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FE3C467
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9bd63ec7fso2065186b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704876436; x=1705481236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrFYtdFHy0dekIS+EQHaYj3FzdnI4ZilQGeBdruHSrs=;
        b=Mth3+QK94wnW5+Wpr/qnJKk3X3/AKUfNLHmCOAOwLEXZcpXQIOFSE+tgdW9Upv4jHg
         kowW0jwrzyC8Kla+RMl8r81Vbf40OWtevjcriBNxBV2S0F5Y3WgDbPob6NR3ntrniKSm
         vAvvHwHbraPMBcJqKdAkllVq1KMZXpPdm56N+X0iipkLrPIkEC5zS2fGnYXN8+xIHfI2
         I+jK4mBcZ3tS9vBaocVZNixBoOInCe94Clvjt5hCFBeKgF16s+V0tckoXnONaWcG1QtX
         /F4TIi7UxsdS1QriuJz/EBBEY1G4CBJQyalpRuymcvvZsxnSmoG/kiq9GzvmPasxb3KL
         v5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704876436; x=1705481236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrFYtdFHy0dekIS+EQHaYj3FzdnI4ZilQGeBdruHSrs=;
        b=c61T7pHuGWY39meTN0Y4tGML92ca6778Lr79SyazF23UvqdPQ4XgfKrKHIQpHM8lQ4
         S39oWcyGWWhPPthaSP61UadApxQzkVLjm53YqXm0bBHnI3f6kf9uo8Klziu+kUaOpLIv
         F78j2MlSKdEHqQA99YUoUbAstaxWmhde6/r3IAl+fjCW0Eol8gOOr9i783a2dFMvbEZH
         zOoBd12gsxdFGRoF8yqaiYERKyB13SmvLa+VDg6EBxhBaKZcc+z+L/UBIeySOVDCY65R
         gTujY7hKR+KicXrlad3fO4QgpViEk/VvKHv3Ny0oUpB1/DT49wcf0BRD3tznBeXZ316Q
         /CRw==
X-Gm-Message-State: AOJu0Yw7RsrrEsQQG1n1ZEsFo9QiV0LqKom4+7O7IFUKA1cVCnZosrXY
	xwsqMnvxMhPiuDWoXf3E1Pk+uAP3fZBfOw==
X-Google-Smtp-Source: AGHT+IGELo8LQap2T2LTUajAaEUMGUUrnUSXc0oi668dRr6EXDUBlg2FFO0Me00p9KLkNBUBveR4FA==
X-Received: by 2002:a05:6a00:1490:b0:6d9:9dde:8999 with SMTP id v16-20020a056a00149000b006d99dde8999mr604312pfu.58.1704876434354;
        Wed, 10 Jan 2024 00:47:14 -0800 (PST)
Received: from 3PW47C3.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id x21-20020aa793b5000000b006dabe67bb85sm2973690pff.216.2024.01.10.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:47:14 -0800 (PST)
From: Bin Zhong <zhongbin@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	john.fastabend@gmail.com,
	daan.j.demeyer@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liubo.0617@bytedance.com,
	zhangjinshan.smile@bytedance.com,
	Bin Zhong <zhongbin@bytedance.com>
Subject: [PATCH net] af_unix: Avoid a wakeup if data has been not arrived
Date: Wed, 10 Jan 2024 16:47:03 +0800
Message-Id: <20240110084703.2708053-1-zhongbin@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following scenarios, unnecessary wake-up may occur.
When a thread sends a piece of data and then immediately
calls recv to wait for the server's data, the server, upon
receiving this thread's data, calls back unix_write_space
to wake up this thread.

Therefore, add the filtering conditions of EPOLLIN and
EPOLLERR in the callback function of the waiting queue in
the unix_stream_data_wait function to reduce unnecessary
wake-ups.

Signed-off-by: Bin Zhong <zhongbin@bytedance.com>
---
 net/unix/af_unix.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ac1f2bc18fc9..bd4e7beb02d5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2500,6 +2500,14 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	return recv_actor(sk, skb);
 }
 
+static int unix_stream_data_wake_function(wait_queue_entry_t *wait, unsigned int mode,
+					int sync, void *key)
+{
+	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
 /*
  *	Sleep until more data has arrived. But check for races..
  */
@@ -2509,7 +2517,7 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 {
 	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
 	struct sk_buff *tail;
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_FUNC(wait, unix_stream_data_wake_function);
 
 	unix_state_lock(sk);
 
-- 
2.25.1


