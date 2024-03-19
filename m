Return-Path: <linux-kernel+bounces-107182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCB87F88B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F41F21749
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C942537ED;
	Tue, 19 Mar 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrvtbxoS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470971E536
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834213; cv=none; b=u+ph7k55+eDXNuNufbTmG1FNEPUx/rw+Ca5g0LCsCgdJsyrZgV2mr4K3r9sFp5AQSOhtD6ufs6BjVbD7KPhmmoVxSfV84doKlZD8VueaN3nRhXt2BT6Z8Zd/8NM/BzRdtTZwEkZYGKRdIfJ7rFikEZwIGPWgyrBgDY3b8sLNy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834213; c=relaxed/simple;
	bh=HD6kQ+ioRHxPGSTP8IsOyUFZW7mQgOF13zNVMkezjnM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XCvJEB+vDeOreNm+OHs3Qig/E6oB6FgFh7etEn7VRWU7ZtrKyPc1+LEEB24vX+zEPVNwvpMk/sV4sMCBtNdtjCIw4g5xXioVsK5wOlU6RrEAeFtu3TWzDQRRDeDxXRXTM0TWh0CPWbOsZwkBjkIpBXiiZro0MSADWZgcagAKEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrvtbxoS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so8428094276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710834211; x=1711439011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OnwyORFqYkzH8hHLHjIf5KeiogbCHS6CJlbafRrvsPA=;
        b=VrvtbxoSY3waMrjWNC/AGaYlDvPANZv8vkPkRNMbz9UgTAWSy62LIQRz98qIMSHMqu
         Pt3M11+reS1L4uLeFR0zx+7Xs1tL+lGv1s/LL+bAuZdr4Gp7UCpTuabNpZH1SM4airGt
         yNsksEe4o8wUMXsfv8Df7RnNTgNTHa/jlv0UVm93/u5Me3nSAfXlYgCbLmlo+sAQFaJo
         rEBN5IxygtAmvjzYep9h3Zu8iyDUA1s3qDyeCRk6XwAX8dfxIm8C+cjNMFSDN7EXW2sY
         ifvjDihmShjE4UnbI32sd3KhFmAeOLi+4qvJZ6lUr8T2wMZrge6K7GvHWyKsRbwGM1WQ
         7fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710834211; x=1711439011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnwyORFqYkzH8hHLHjIf5KeiogbCHS6CJlbafRrvsPA=;
        b=JhODQhag0cYFmXDM/l9m3Sck3HivSYEdVKLubDx5ubKWPcg3tjT6+bduD0jQTE+Ogu
         dVAHvqMiEqgGwr/GhnOZ7xXC3BmIzGarxpgWli5xMJ/j8c7eOVSZbDtK5c5r8bme3ZEj
         DInSCj6YR4A3Tyk0WOQMob5zPrmrzQtpKc75Z4nG+n1KAzTWPj3hthw6viskT60Sy060
         pm6PNGEcmZaAEiHxCwWinZ4Y0gggNv53YCB3ihwOO2tLDcCDtsIl3oR26P4FftgVhmqp
         G7y5GrZF3CjbWmK0nL0/83l6qGXY8BPVuHS76hA7muuxLp1RLn/8zvOtEY9lxFxecn0B
         FOug==
X-Forwarded-Encrypted: i=1; AJvYcCX8xak2diGryvY3NYmzdOE/aCGxmmPKmR2/AWdqidLCwpA3xsgBhnfGbZQvb6g2kOreHVlITIB402i1lwm1yKGjzSPiejwWJE1syxqb
X-Gm-Message-State: AOJu0YxUWc6uN74WAuF8R5yKaEgxBm/laFRIsdJnO7FkKRl6lrEHO+LF
	W3oo7ryXVwoQWab91awUgqM9vWGFslTxnfz3vY+clGNY5gwyFZGfecv8zZtfly/oUn/doS5tXPp
	RSPsVUw==
X-Google-Smtp-Source: AGHT+IH6atxfqMs0Z5PSMVfV6XRX3NOJZvi6OTsXrgS1I78Y0u2K25gag5+nyxOg0DCLkK9hS6meBUKwHlq3
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:2f6c:fc01:709:12f4])
 (user=kyletso job=sendgmr) by 2002:a05:6902:e09:b0:dc6:dfd9:d431 with SMTP id
 df9-20020a0569020e0900b00dc6dfd9d431mr394859ybb.1.1710834211438; Tue, 19 Mar
 2024 00:43:31 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:43:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319074309.3306579-1-kyletso@google.com>
Subject: [PATCH v1] usb: typec: Return size of buffer if pd_set operation succeeds
From: Kyle Tso <kyletso@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The attribute writing should return the number of bytes used from the
buffer on success.

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/class.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 389c7f0b8d93..9610e647a8d4 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1310,6 +1310,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
 {
 	struct typec_port *port = to_typec_port(dev);
 	struct usb_power_delivery *pd;
+	int ret;
 
 	if (!port->ops || !port->ops->pd_set)
 		return -EOPNOTSUPP;
@@ -1318,7 +1319,11 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
 	if (!pd)
 		return -EINVAL;
 
-	return port->ops->pd_set(port, pd);
+	ret = port->ops->pd_set(port, pd);
+	if (ret)
+		return ret;
+
+	return size;
 }
 
 static ssize_t select_usb_power_delivery_show(struct device *dev,
-- 
2.44.0.291.gc1ea87d7ee-goog


