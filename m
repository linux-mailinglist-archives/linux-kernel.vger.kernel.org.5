Return-Path: <linux-kernel+bounces-85558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6254286B7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943691C26451
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106871EC3;
	Wed, 28 Feb 2024 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fFdpTz0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE271EB0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146285; cv=none; b=ciB19obIniA8gCiF0P0cJr7CqB0mZ3/f7onuFys24jktH7w2URc1I5bDL4QoW+cXNlGPNvxfeHC52Z7R+oFZPrxW6Hdzupa6XLGKmDlgHXyVuSO+Vx3hOXfvZO45XhLFebYInWw/uIZGpQJiBPwspNrWOKTXaDT8yx+bmhY0euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146285; c=relaxed/simple;
	bh=74xrWMGlTWlkqjlt9MN9TpLqx1sShodBXiCj0AvmP38=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ru6KobZgsKke9Ol4u8f6QZptVcFPfj7i7iRh5QSeAxWkHsKzKoAAMvibybi6d2bgDsKh5Y29tGRUaxsY/E9OJKwGksEaWY8cgFziE6QKy+vPMKALTNlSaarFtRB/IvVwVQxGU5/+U8V5YtyfMqozVvYnDeLgstIMB6mUFpcAvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fFdpTz0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so222989276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709146283; x=1709751083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q995VDUT1rCWamECeHTo++lWCTqa/WTcSCUgzRaXW40=;
        b=4fFdpTz0jZsGXDB2XeKVNB4Ld/y696qu1FM6CnC3OQ36xJJRIixw1uif0KTXX+OfTZ
         DaZbU/7uNpbZxwqNv2PV+Q1C03VJZElU+uRntihu+kkOiQiiVqCR0udTr7/o4ZiX8j67
         CYkBaaL66K819azaiLcSwr8v6PvnCp44ku8Cs2yNLThzs1vvTofW+VqmTe0zf688KzZd
         qa27wLQMKHzpehYRxiiWfSE26Yf/Wj6loVzfamU+smLq4rSpV5VdwOOGEvB7iX2HTEyB
         UEwzswJuJBEQ8FbnlgH5lQ3QHXmVxOqb8wD72A3KSgWQL6105s4Gc+MVUICOuYzisJAf
         NZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146283; x=1709751083;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q995VDUT1rCWamECeHTo++lWCTqa/WTcSCUgzRaXW40=;
        b=kTWSHL6LK3alt00qvoC+lMwE0hf4P0XoBEig1CPyjwCkNSM9Xwjx7aqnRjTlm7TFBe
         g/ljH0kpJhKQ9E2nRhDGcUI7/obn8dZomURGz1pWI72P21xp0lfdhE7+0nHR2tKrjbSF
         Sa4NFcVu4OTokkfBT8ua8enTSTAPD4jcU/VF/XrFQ8qE6zNBfcqVP43eHyhCFktm6TgZ
         oJ8N2ypnwlViRoNxu/RczStGbvIiGUhuJ+H7gDb5tkxeHWa5/182m5gBo5z9bdwycKIx
         hDj32SjzeNwbCgyLlc5Fj6W3Rju0AgVrZLiw5mkl1/Iuh461ymMAS71uhiner3+WKMEJ
         KUrw==
X-Forwarded-Encrypted: i=1; AJvYcCUG2mgrcdWv3xzJnBpxFQ0psj50VN0wHDU8nxwWpb0wqT9J0vSVLjrx7d0AiJnLivGm7x+tm4LGJCVpx4tDhEyznHbHh4qzasuezBSL
X-Gm-Message-State: AOJu0Yyp0bn/XGl4C80Qudl9YVqB4wweOY/JTRkRZNk8H6CJoMUK5+Xx
	Wxkm6nBIxQxWeIyrYMrYx0VvuS31G3PR0jhXJtp2HU9uV+jQ3ly+x9MQYCAjHHiN12RtYL0JkbN
	EeB5nZAUqqWfoSDJKKF5qWhSDIuA7Ow==
X-Google-Smtp-Source: AGHT+IGnnmWYe3kzdu/ZFn7IzaatprsDRrYZpULNetR7ouB2Ba0CntgRLWuFHTTETzBJffD/BE1RNdgRwXmu5DK9wX8U
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:6902:1885:b0:dc6:fec4:1c26 with
 SMTP id cj5-20020a056902188500b00dc6fec41c26mr8000ybb.1.1709146283403; Wed,
 28 Feb 2024 10:51:23 -0800 (PST)
Date: Thu, 29 Feb 2024 00:21:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228185116.1269-1-vamshigajjela@google.com>
Subject: [PATCH] spmi: hisi-spmi-controller: Do not override device identifier
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

'nr' member of struct spmi_controller, which serves as an identifier
for the controller/bus. This value is a dynamic ID assigned in
spmi_controller_alloc, and overriding it from the driver results in an
ida_free error "ida_free called for id=xx which is not allocated".

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver")
Cc: stable@vger.kernel.org
---
 drivers/spmi/hisi-spmi-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 674a350cc676..fa068b34b040 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -300,7 +300,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


