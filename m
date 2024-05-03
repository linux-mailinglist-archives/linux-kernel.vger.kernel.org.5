Return-Path: <linux-kernel+bounces-167110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45958BA49F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57111C225A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B694101EC;
	Fri,  3 May 2024 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKheCkuq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D1FC11
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696784; cv=none; b=ZkMO/mbv02TGEF8rM5HsJo9liW8RFqV0ptPAyPDLM4hWL3fG9kFqyylehrgsRao7PWMFEwaZ9AfKwVWNsSSWbrOVaABH2rNrbim+8Du/HIhj+L8rVncDYtcEGzVvB9VIy0PG4ixShCoZ1IN84kRPiJb/w40z/8POa+qSwSo1Lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696784; c=relaxed/simple;
	bh=UP93LeOYyXTB+HImKxRgh7AV1DkTaG5cFD8ox7MDsiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpBr1/Cw/haTHOAaYhh9o6iNS788YKOvdLCo/wQbNQiCFRiy/Vb8+Gadk9FLx/awcnJDnj/I8bq7mbkygVm1n/xLI8LwiY38EEUeRN6+Wka6Ad1HuDmDvrFTZvy+6xAeGi9GTTvymsc31ZJPLE9LHSsO/Lrkigjo3ZjR6s8K4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKheCkuq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60321ce6cso8559465276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714696782; x=1715301582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y7QwxP/IR8IteTIhBkWFiOVh6L2OPrMA6wzDacMquRE=;
        b=JKheCkuqmzYFl1QYiE6JECplSgRWMunYiDmQtviLllTN8XRBZxBs+Won/AWf92PI3x
         MdILQ5EaVyYePNfSioCzUGzUA5qouPnoHVx2Wdc4Mkt6mrSRup2hOjz0Z0fAI53o010F
         TGbOZvv8IWcNMF43veWAzAlr+/b4HN0adWXu5VUCUjgVvBaaQp3Z31o75bpiATL5BSPO
         vQ4Oi5RoYRxxC2ppiVbCYx9sRp8/MaICnV8ZFx5s4TG0+/0RQ7mh3nsdza5S/e3GIwJc
         G1rbB9534TTN0asHBMeSjNwXgsPKI5wk38sLEGfOp0o6dxB1sqgVUTSY6qHt5b7XmWyF
         7IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714696782; x=1715301582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7QwxP/IR8IteTIhBkWFiOVh6L2OPrMA6wzDacMquRE=;
        b=mZOISfqMbEuTwbXySiwqCF+CFW/qcf/tgjFCk6lVH7Fn+iBvhHUKcUlr445zQNN/lz
         cFG/xmTeDUN+dtaOSkFXVPh7T/ohuLSGiLUo7V5zuCEkVq4INP1Kx/P6usvv5FNDznwX
         2r1NEjCxAKF/Kluqim3jX6p0DiC6e/6z8OsB73VhBuKHDFFkNrI+pwYiQhtFusFEAJ1R
         1t9EpgHE7m7iOaL3QHp9XkUTtaIWeLW+MIYHzvLEozSXGsamz+OlVKLoOhCDP5W7ptd0
         RpQSbfbk+I8X+Qoamsw/oR89wwMiY01g6vlwEvYvVYan6ZtrtslzIVHetb/qAzYTMJ0p
         RoPA==
X-Forwarded-Encrypted: i=1; AJvYcCU4fEmI3LDE+KCgOwAktFRN+I1D4CXPX6/mP3y8SYEdL8raWkn9WEvNkVtRfpAW8ocnI7/Dy6v+pwDS0rnleRcpj0bLqOb5kwHg6rQx
X-Gm-Message-State: AOJu0YwheUL62fIyKZJwQ0my/lNdoFiUxQt+dH+P2sL8385zd+7/TuQN
	IKPi2XU9QrB27XpJg2HHFQzvXCcOifgQ66R3IlBTfvqcnyWrVg3juYWzt31n3vwnMcWGHQ9Ty01
	Oag==
X-Google-Smtp-Source: AGHT+IGA7rE3BAM0KG2lZo/Ms/y2c4C3BtZJwhhhC+5ZNSIrGkbjl7DC+rrug/J1iX6eTsVMQyasB7za2KM=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:2b89:b0:de5:2325:72dc with SMTP id
 fj9-20020a0569022b8900b00de5232572dcmr426447ybb.5.1714696782126; Thu, 02 May
 2024 17:39:42 -0700 (PDT)
Date: Fri,  3 May 2024 00:39:17 +0000
In-Reply-To: <20240503003920.1482447-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503003920.1482447-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503003920.1482447-2-jthies@google.com>
Subject: [PATCH v3 1/4] usb: typec: ucsi: Fix null pointer dereference in trace
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

ucsi_register_altmode checks IS_ERR on returned pointer and treats
NULL as valid. When CONFIG_TYPEC_DP_ALTMODE is not enabled
ucsi_register_displayport returns NULL which causese a NULL pointer
dereference in trace. Rather than return NULL, call
typec_port_register_altmode to register DisplayPort alternate mode
as a non-controllable mode when CONFIG_TYPEC_DP_ALTMODE is not enabled.

Reviewed-by: Jameson Thies <jthies@google.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Changes in V3:
- Returns typec_port_register_altmode call from
ucsi_register_displayport when CONFIG_TYPEC_DP_ALTMODE is not enabled.

Changes in V2:
- Checks for error response from ucsi_register_displayport when
registering DisplayPort alternate mode.

 drivers/usb/typec/ucsi/ucsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index c4d103db9d0f8..f66224a270bc6 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


