Return-Path: <linux-kernel+bounces-53984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303DA84A8CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F461C264B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E25C5F0;
	Mon,  5 Feb 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOUfYnWb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39765B67C;
	Mon,  5 Feb 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169770; cv=none; b=DaDPKTse1oDWTjAbvOPFwBMhtsS3R7WyNfzmVLINpa9kS38+cAx2jxGrd4loVHFrh6HmlX6pWp6kAYco8+QhqqMXqifaTbwLuTppTm+yBcyLS1M8erXw8MTzOxmqWjUflL6ZrmwaqrTQkFJYv1T7YevLTQEsWpAY0BlMfTmkhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169770; c=relaxed/simple;
	bh=nMy5k7EtAlhx2FUGhxz4Aj9a0X7Rvf6ugPK6E86NEJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GU7H5hMIw6nBpUv/f1jYci67MR8rl8ML1vaYaQpEHv3+SL4Y9nMiAel5aj9PI1YIvay0btYWtEHZbVkpZhGfytKWzTLpuNi9jVBazFsjnP2aqES9AKmBH7qNsGFlHhMuwROqiC2r2C1RQeEAcbzyhY0Ot2/Mnyws/JmVEeDK7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOUfYnWb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b402116e5so685706f8f.1;
        Mon, 05 Feb 2024 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169767; x=1707774567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9fqRIwKVaJXAVoXSjrYm1TW9ua3bpkx5wdeoNkzRRA=;
        b=ZOUfYnWb3uvRzSnbxUSgj+Nt7TFLMJ4RMD5apWL35znpWcgZL75okSyVo1YFZiwheS
         RcIToap3yh0sjpkVxEnyGzC4rv/tmJ2SjBYDO+xnO46Cy0s/GbkimWv8m3mul0RO+6dc
         Rb+mzpX8vnxYRTq8ooY4NJconyH/2HCvNU80q02Wil/FEw2Bf4MgrUheEVux+U7tjP+N
         UmiEaRtetjIt5x9+/vuuh6pzWuDqL9vIPf9ERFmvmfpMgOaJdSn+FJzbbGOwHR+V+4r2
         HatI7F1UO8vLHOaMoT1Uy8Wcp1mURFSk8xSHZgnitCrw5MbOibgJCgltbJEEJ7Glj/17
         Fy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169767; x=1707774567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9fqRIwKVaJXAVoXSjrYm1TW9ua3bpkx5wdeoNkzRRA=;
        b=IztnU2mtTmf2bibiNAqFVwAj0LxydOg624YmNW7dWEJVBfmtguSgjh/Oq/axT3iKp9
         e8H5/s9MHv8AqnJG3pg+4cXCywP2y0SwrrJgiVrRTPBhHiJPhMLMEd2NFd74on/O7g9u
         mXmV4zwgS9MOcP5drA29Nve5DoS/8VFXyOqoARW/58XBAJaT5iQh08HnE380byaDBxLD
         5RCteH2voFEcKldLapRtdvsHCSNQLCFpI0dQqNiYBLJ/S07GdvRXb9q7rGKZK2chs+h/
         hD2u4DqRPWkwSKgzuLfMS0lUp/Vqvy65XiiVssla6QmN6bQ1sj4jNUZacbqyieouR6cw
         R5OQ==
X-Gm-Message-State: AOJu0YxmAm3yK6ZDjm3Ve1tiuqLab133WrjTqKYCXzfJ73ErJ30ll8B2
	zLsff59gUeC30vBjqxbNrFMslskAyKnrYQX3cavjt6NJN8+gnQVs
X-Google-Smtp-Source: AGHT+IEgni7nHDizO51JbKho406hmlWCC2qB1nv1f26UJVs1mivST3+rWoUKq1UKTCNlQCuZ8M1SPw==
X-Received: by 2002:adf:f749:0:b0:33a:f484:811d with SMTP id z9-20020adff749000000b0033af484811dmr468722wrp.28.1707169766612;
        Mon, 05 Feb 2024 13:49:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWZD/aUvxoKek+pOOYCcBvm1swGZNUxtIgCn/RFD40DlUYZWtfBFeckaFES8AvysA7xw5hNVHKrEjwxNXZPKOjr5uNKbXX4DKABYJZVEOp9X5JH49Oq0pwSoqFiIATDIErPnj85lHlc1HxxQaZPdSyfqPwYb21gRSITMKGzzN/q/KEddX4zz9ezs+/EVBP9XHDSSwi75A==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d4b47000000b0033ae4a3b285sm517098wrs.36.2024.02.05.13.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:49:25 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Michael Krufky <mkrufky@linuxtv.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: tda18271: remove redundant assignment to variable bcal
Date: Mon,  5 Feb 2024 21:49:25 +0000
Message-Id: <20240205214925.1850926-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable bcal is being initialized with a value that is never
read, it is being re-assigned in both paths of an if statement near
the end of the function. The initialization is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/media/tuners/tda18271-fe.c:473:2: warning: Value stored
to 'bcal' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/tuners/tda18271-fe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/tuners/tda18271-fe.c b/drivers/media/tuners/tda18271-fe.c
index f0371d004b36..a7e721baaa99 100644
--- a/drivers/media/tuners/tda18271-fe.c
+++ b/drivers/media/tuners/tda18271-fe.c
@@ -470,7 +470,6 @@ static int tda18271_powerscan(struct dvb_frontend *fe,
 	/* algorithm initialization */
 	sgn = 1;
 	*freq_out = *freq_in;
-	bcal = 0;
 	count = 0;
 	wait = false;
 
-- 
2.39.2


