Return-Path: <linux-kernel+bounces-85574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0C86B7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CB81F284D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEFD74409;
	Wed, 28 Feb 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck4oQstW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F987441B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147133; cv=none; b=hH59Q1ysqMhGvKOgkrpmnSWF0HyPpvGi6hfiA9BIC+9dRxrPsSw+m+wx0bF60Gdf1fkPizg99YBmgLILHH2YMmva7BuZ0N3oc0pQ9QWL2xSsJpZXkQjLRs5WYTQLEvb1QTChADorMHUMep2D94KL/d7CzLbj31jNF0lzM165CrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147133; c=relaxed/simple;
	bh=KaB0o15QcxAJuDwbyWWEXp4xm4+9e6vAMCuWsrGK0EQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xehq9fkuSusAQOpdIDKHMI2/DRGHl/h20hEycv4TyGLsYWn3dbI8SDUm5LLrzqYnhC8mpa3i7rDN9/3SS4ZroIwO2iuW3LeCkFMd8onLWVUB1aKFzOcjHAFZg0H2Fc3iN5sD99vAKvFYDK5jCdNLOdqTiKyV5fwK3xrIRHKnSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ck4oQstW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so1653837b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709147130; x=1709751930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVIW5BWDLxsObFFWPOJ5xbNTd0o4JPD6uXro2iUXPvE=;
        b=Ck4oQstWBSKIGIxOi0albw5eHUoktwTJUkIsmut8HfL7duLmFUQt5ZCbYxnxafRjiY
         wpLxHrvoyH7ajS4B5cRSIKaKVPYcRUlfG5jVgrWtOvu9GiZzNTPPspJfJqSg8Xt/ApUr
         1Bb2irPctZBxUqQ7VZQ5t3bVb0JapXXQBZoS1DFQpbOzOZvpHSsfGDQFUYyxxT6J2wej
         xsP66bu5qTQ1Gxzm/E19QqiQB772hWxXK3wfQNR7gDA3p2xLrayQoXMT52OEWzI8Lkyj
         KeugkcbpjMQTuRDVjHfzCTjAMBJ2odKVj2dMphOHKlI40rQZFA3My54fCyEAKnNg3a4J
         e+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709147130; x=1709751930;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVIW5BWDLxsObFFWPOJ5xbNTd0o4JPD6uXro2iUXPvE=;
        b=cZNtf/ylKvF+h5CHZdYRba0+PIyAwgAiMCIOdVV0KdT1Evf7KQv11UDKmyxN2eLPJN
         RkYdLBQRPTuCzRUmLHmNebklFWkd47qCLSkBN+blEb/O8gjt6OMVq/ZR31VRDwA3KpaT
         VGjDKi4ZP10XgOoiJvi8pJuJPnxf6AY7/1/D76+uxCwwNw6792184gdlKFrS0++mOhxY
         zxHXLs+A0eBW/6Hq/uRxYk547Xc1g0AksMaVvVM84XgmsbAKYy8jWxKB/OlJlWs/C792
         4k0BstSEDqQDNXe4jZLSoJHI1/pxg6Z7REP5otS4YE5oVFDmU9NRUSmMJFs0psUEaEzj
         ZNow==
X-Forwarded-Encrypted: i=1; AJvYcCXo90tfmorG3jXsEW6Emc5jyzbpN8ewJAedzXsEclUHnQ9XUFG1bg9jJx38J0kkbCAiNQOFytNXHHPaMgi5xY7TfSjDdOhX573+zPad
X-Gm-Message-State: AOJu0YzU3FgAGbpnkdGq/r/2pBANzHBL9ZyA2yWMpBxvqur6zO/JSf6x
	ZPWi93eK/vDZoS6iibljWYNJS4z2nPNLvaAS7X+Ppnwkivmr6gkA6VOeGUghY2Aeqd9okP+0t2D
	AJbt2nB1sZ3krAWTApGWseaFcbXz+fA==
X-Google-Smtp-Source: AGHT+IH1AhAesxvlkBalEeQQZ+SI7ym9xb7nQdJfiP8EDMhCX7nsBoAIT2pad/v5zgT7MG3Caqe+s+cFYpIpe+1HfJ1Y
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:9d:b0:609:254f:85ae with
 SMTP id be29-20020a05690c009d00b00609254f85aemr1080823ywb.1.1709147130454;
 Wed, 28 Feb 2024 11:05:30 -0800 (PST)
Date: Thu, 29 Feb 2024 00:35:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228190523.8377-1-vamshigajjela@google.com>
Subject: [PATCH v2] spmi: hisi-spmi-controller: Fix kernel panic on rmmod
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure consistency in spmi_controller pointers between
spmi_controller_remove/put and driver spmi_del_controller functions.
The former requires a pointer to struct spmi_controller, while the
latter passes a pointer of struct spmi_controller_dev, leading to a
"Null pointer exception".

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver")
Cc: stable@vger.kernel.org
---
v2:
- Split into two separate patches
- add Fixes and Cc stable

 drivers/spmi/hisi-spmi-controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 9cbd473487cb..4b6189d8cc4d 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -326,7 +326,8 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 static void spmi_del_controller(struct platform_device *pdev)
 {
-	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
+	struct spmi_controller_dev *spmi_controller = platform_get_drvdata(pdev);
+	struct spmi_controller *ctrl = spmi_controller->controller;
 
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
-- 
2.44.0.rc1.240.g4c46232300-goog


