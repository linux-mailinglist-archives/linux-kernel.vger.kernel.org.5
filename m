Return-Path: <linux-kernel+bounces-69828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84B858F2B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883751F226F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BECE69DF5;
	Sat, 17 Feb 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="GpxFqwiU"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293E69DE7
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708170330; cv=none; b=cDvBvFOjlpiUoXedaLdYsdu6UEzeJHsRfwVFptS9yvT7Yce/fRcxyD9B2rgDN6xwVAd3qJhIviizFQqkB0kDi7GiOwMb+Be/GOLU9VGuL4kbUX42x19xjVi12S6maZ3KZ9vD2PCQxy4+mURJ59PTOW1sEV6ASW9txD04RHqvMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708170330; c=relaxed/simple;
	bh=v9icTgsg3xm4DV/7J3o8nPQ107m2PfBcWQvGK1OONZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y9ZFCioYfyO+EFipEgz9Mj4uY6Xu2otd6mIr9RuwyxXDXCWBa5rSELZdIbgqYOiwmUoUX7x5Frl3M8MmOm/XOD1Csh/NYGMZ7QsRBKnwlHrMx43xeRGUZbOW5/zhXA1CGxNQpz4wG2swBqk46s/OVE03f+1QVfjuoonG3OWV+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=GpxFqwiU; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c132695f1bso2122392b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 03:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708170327; x=1708775127;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lag4XHeCZet1+vKhZAhtGBsbBX5d4Oil7LYE5l7I2AI=;
        b=DqSaSsDy/X7yEXOuoA6YB5ctOfeebSIiWBz5yHrfDXUAmJ7WM7PrxAsZCWXAf8jbgu
         rjr8Z2OtCucz0EcS+HInGJpSAI9+y67LbXF0zwEMRE77hj9YTNxPCXpzdeUrPkWi8+9v
         EpuHhGrWnh6pH96DS7hbt4ZGh8ojbWs6mkYTT12SzReLCqoXTzD7rR7iOJ5DfojVbpRR
         jB3eBjSwg5Fuca7k63Akg9kzm4NwkLcHsrNzkzhlbIoPQ38QbdtLerfeKFjkWIqx7uSD
         hpxhaM2MZt2l59n0KNykh+1DJ2Ahok2DL0mruX0XhVYony7q3UerNJqv1rFSR2Dw43XB
         H03g==
X-Forwarded-Encrypted: i=1; AJvYcCWsxGlqlIy/1KhkDNVCVzFlarzkJxsZX/2v0mA+MDDOY1AV9ca7aet+nSOPSPPjhh1slXRzG4iQBps6dWfRiZ6mSW8/+eoJJrya2c+l
X-Gm-Message-State: AOJu0YwiRg1Uu0OnTJNHCgRqjh5zlCFtcGBXavGeV1hLblecTVoDOHjd
	vCEgSgJCe1tYBFwZNoSQj8qs6cQtTL3cG9kRuynHv30/oVDk/zXv+kjMnwMW
X-Google-Smtp-Source: AGHT+IFxg3uML7ydnKRltDjN+A/0mgFdrm7SKBEKuhS0wsyfYTKtmMQCzg66ccY6BjEQd8zkEi9y3Q==
X-Received: by 2002:a05:6808:10d3:b0:3c0:b3f3:c30f with SMTP id s19-20020a05680810d300b003c0b3f3c30fmr8762322ois.9.1708170326735;
        Sat, 17 Feb 2024 03:45:26 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id r30-20020aa79ede000000b006d638fd230bsm1530032pfq.93.2024.02.17.03.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 03:45:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708170324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lag4XHeCZet1+vKhZAhtGBsbBX5d4Oil7LYE5l7I2AI=;
	b=GpxFqwiUqaYKdzHW+NM2sHPb3FU8d+wpm7hIoX/2Fm9KY1ocbza2LcOs3Qt3cuECbH4Mkz
	r5Pw+1FpUx7C0OLmlVzMHTlQfW9yl6/6fHuClTriJYDESmwQARqx/G9Or35EPoZM5IsAJR
	gL28siywENHUq7x4zYLGIz5x/pkFUjp9A4hvxntQkNF8qagUhwhBW5G7O6WYZH0l1PuU0T
	AOZY2aWP9zsIHO9JB7QBMIZmk+5xSEyDiiJoZdRjm2t3oo9HV6UNCkkQZ7naW14lf74/0Z
	DrsOmuCpcntbT0ONjpss0AlzlR9bu10b7yWleUBVDChRam1SuEzReYAwmFpWhg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 08:45:56 -0300
Subject: [PATCH] staging: gdm724x: constantify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-staging-v1-1-286479d9a3f0@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHOc0GUC/x2MQQqAIBAAvxJ7Tigxor4SEbK72kJYaEUQ/j3pO
 DAzLySOwgnG6oXItyTZQ4G2rgBXGzwrocKgG20a3faKioS84MY2XIdKp/USvHLUEyOS7QYDJT4
 iO3n+8TTn/AE88dzUaAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=v9icTgsg3xm4DV/7J3o8nPQ107m2PfBcWQvGK1OONZg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0Jx9OrJCr8/dOtOY4V0TamFGZqLauiaU31iNk
 zl42IhR8qeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdCcfQAKCRDJC4p8Y4ZY
 pvVPEACWNV+xonBSaB6VMk16zpdP3pglb+12BZvoH24HcJEHWbZMidwwlA4Gg9YzKRB0ymg7mz6
 MKW0vXWUjNJ872AVuUY0rs7uhZmNH5DpBBHtT2aPPPZFq4ihiSsFcBdcWyEm9nHi5zS9qVlbKcm
 tvU4mF4WtMqYj9HEcoW0piKnOqzDqUPq4OUnjtdhNTypr5HKwnWoo2OC+BhceE0wy0JjlGjQEjY
 qp6YZEthUxGYW0WmilTP5cjVFhh/QU55UCwqV1y4RBBXURBwJfwPN3Cnl761cYI+26DMARCY3b6
 yg6m/73tOCNxJCU0D9bKGPAijeBDHE11drwSgd2jX6RT+/55T0fSWM/PkDltdP4PZaznaeWZtPT
 izF9I/f49aPwb04vWuCRYK1a/flytLJ2PnBTIqd5XoibuNXenycIH0oQ06WDe3sQyPuHVXrmdpl
 E+Ejr7HvTH3P2jBACEYS5nBqyQTT/l9sZd+myGTyKRsq2cJFl6XRjw7grUDBouEr+/CmR86bfOI
 sJMeDl1X+Yy2W+MVcWdYz7spzSjIGO+hTsJOKW7eADBrjW8sEbkT9t+tIWhvLfh2XG4E9u1p4cC
 Z0/ZdpbztZdh3Miq7FXB78Ts0nU7Tv1YQBe4IHg8aIlPtnsqQdp7VZQBK+rivZcRsn8nq4Py6Dj
 0k/rVJLEDpJUwwg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the
driver core can properly handle constant struct device_type. Move the
wwan_type variable to be a constant structure as well, placing it into
read-only memory which can not be modified at runtime.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/staging/gdm724x/gdm_lte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 5703a9ddb6d0..eb754b231429 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -43,7 +43,7 @@ static struct {
 	struct sock *sock;
 } lte_event;
 
-static struct device_type wwan_type = {
+static const struct device_type wwan_type = {
 	.name   = "wwan",
 };
 

---
base-commit: ce54e9342124ededf0a00ed4e8a8aee535bfbf00
change-id: 20240217-device_cleanup-staging-fd7deccda594

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


