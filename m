Return-Path: <linux-kernel+bounces-72517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4B85B4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654E728289D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56CE5C903;
	Tue, 20 Feb 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+nggSxm"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F965C5EC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416739; cv=none; b=YahD4WEHXOp8pvZUTb6wofmwyWGGD27JCiwlM3iT4OYhpNxi9bLi5s3zbeATWGsYWLwjqKkhRnrgUPObxM1AUM/E+MJCYB7mxEvoSUuqTiIZ+teLC8HgnZUzQs5EE1IB1wFccuvCLlp7mX71Q4mtA7dMcFDnrV+q0SUPCH/Tz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416739; c=relaxed/simple;
	bh=/rabM4Ojv3qXPABWhPOzcXvWzcE1bpcBe1707Z9xKgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VdD7HBzFQXiw1nQeYsUYd5hboBG7Q/tZTeCn/8oaz+Cm+FngrS/Qo3sJPcKoaE2uULGdeAXQ+UuDgoGY2z9R6/ddgjL7hkkrdYtn7JtLsWOtsAza6QsaxRIOUkisnclnOgQjntvKTwiNujptKKJrkhKMOid4U5dmLVMCzFRF/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--raychi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+nggSxm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--raychi.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so6911642276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708416736; x=1709021536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7NyTQc14Zf/h2SqeLHUekdRb34OTt1i2UvuEmj+OuFE=;
        b=g+nggSxmQkbCXvjQQMjfd+GJrhqjetnwR3vH3J7tBDV3Mki9t9r4v1QDZnCPz5OK88
         kG6dQSYSd73EVxG6bae7vMB7ZAP+fbZanubSs/NaF8qvgLPygjoSgLLS+ZUhO+TC3zy6
         lvYQcIoD1oYrhwiyo6s2bNb9OQ8/J7BgLzwxBN/iFSoax/63sS82m6waRJSSYe26oOp0
         c6DlUqQYAQEllT78ObvQYJg7nN5+WCor/I4P62AVuztaruIblbXmezvm6tTFkJlwmnzL
         DKyZW8x2J1vf+gOCdsx8h7krEexg/qz7i0R7bc9C29X9FUOcw8j4Qzg6iR+kmJ0iYi3x
         JpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708416736; x=1709021536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NyTQc14Zf/h2SqeLHUekdRb34OTt1i2UvuEmj+OuFE=;
        b=r8uyVOXMfoj1xkbV/1wT9e2IllauyDcXDRlDeotzN7jNqRUpYvtlJxrl6KQDFfk9/J
         bazAUnvk3gLxYBhUFpPpnIQMuLgNxfkMQULLX6NRd9NH6w8LhUKpIHltxtPd81DBzO4d
         XZ55GXD1gE0qDEl2Wo3XwUESL6dXmWhaPxiHaK3I2yCWLV35wR0WIO2wqOS6hI45BEHt
         vC5w4sT7wK6ffjdIXTYedpP0m0jMmYg4IQOMIgANDM7qCmKAsSK2U+LhCgkUV2Bda++b
         StPA7JFk/EKiLFtd8pLWY/QnKActsMeJDzHZA746+WkKPNM8cOAAOZska3YCUqine1hX
         Q/BA==
X-Forwarded-Encrypted: i=1; AJvYcCWxbrrK3b0RU/DJ8RW7sFVpnXrToKZKpv6dPeUYjhfNAFIBE7X1xk+zncxvsZUpAyvRp8FgEHfZeWH0ZD/R+0ICq5yw1X8w/os6dQjy
X-Gm-Message-State: AOJu0YzaWyb+tnyysgIIUTgGIgI2kqM/TB7ZO+lNqevsi79qpTHepICZ
	ubN3JFb5To68KojppsRawlB/EZidzAqJKt4ZSLdDvis3chXgqKacURC/+/qK6rUA3I6N8+ukTQm
	ljQ==
X-Google-Smtp-Source: AGHT+IHNQS6LSHevRMTxDokV0cAYaI5EkrQn4V1Y4tZL0I+ejqlFuzOyBy3AA2eQbWjAGfgyiPZewI6v+oY=
X-Received: from raychi-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:d899:e5b8:ba5f:3c9])
 (user=raychi job=sendgmr) by 2002:a25:abec:0:b0:dcc:94b7:a7a3 with SMTP id
 v99-20020a25abec000000b00dcc94b7a7a3mr495450ybi.12.1708416736722; Tue, 20 Feb
 2024 00:12:16 -0800 (PST)
Date: Tue, 20 Feb 2024 16:12:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220081205.135063-1-raychi@google.com>
Subject: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
From: Ray Chi <raychi@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	quic_uaggarwa@quicinc.com
Cc: albertccwang@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ray Chi <raychi@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The dwc3->gadget_driver is not initialized during the dwc3 probe
process. This leads to a warning when the runtime power management (PM)
attempts to suspend the gadget using dwc3_gadget_suspend().

This patch adds a check to prevent the warning.

Cc: stable@vger.kernel.org
Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend")
Signed-off-by: Ray Chi <raychi@google.com>
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 28f49400f3e8..de987cffe1ec 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4708,6 +4708,9 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
+	if (!dwc->gadget_driver)
+		return 0;
+
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
-- 
2.44.0.rc0.258.g7320e95886-goog


