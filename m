Return-Path: <linux-kernel+bounces-94908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCEA87468F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2EF1C216AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B58DF55;
	Thu,  7 Mar 2024 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvsQp752"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13263C7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780968; cv=none; b=mCVnc2iac9g4QXmH+6KUeJfhlW0mKPcJJxJP4OY5WgdsRevIwbF0infU9LhYD7DinNjImuisdXlNY8QTnHDS9VjSKILgOzWw2xOrj+l0aOgzAA0BBfsDpfH8aqq4uvKxvRUdth3zTC4WqcXDWLJToEN8ejet297EIsYqmH0LTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780968; c=relaxed/simple;
	bh=9VKCNfoO34uLb81d+s+T+24G9GZ1ZWMwJkSj0hyrqZY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jcgON5eIp9t39tbz9qogtD+LjgYRZ5t+r/J7HlEcvH46+cyCKUQcEewIFsvd7FCtgeHgD3ujN+4HRzWobanptal0rR+bRHMBRBWZfS409HlzV8kGdAQ2Jm5/eRb3EUJu1ZlWc9JzLdS0UkHico9fpd+45C36fn/EjZNEk8iQXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvsQp752; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609d8275c70so7372767b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 19:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709780966; x=1710385766; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H5Ul/l6h3QQByB9upBvQ9wSmoGLdWz++Sa5jGQeBypo=;
        b=uvsQp752U+bq5zn6RGkp/M49d2MSATTBfqhBXMZdHv5v+NC1zVMNHmCTmZr/xbS3JX
         SeTUwNFLfN6FjSKEAfKwFycAH2qpCDzYWAjBpDEqARXIV3t+10auKnbUEQ6p2aFBvdqA
         nVmNQo6oIKdtbuMQcMeCARYhOch/UK3gKC+HfODRRbDa5x/PUOrRU5uAKakz7Z/6UiZN
         yvNw8tqq4w4xg7s2u6P2VoF8fog6CO8JF+/tY93iJVVvLgAhy+wRvUiFp9eYp5tbx4Hi
         761onZY42phWeARNUQLWK1ZTeaPqHd2snlZPgSbwmmw6W74tgQDMKGqIa/5JZ7unlrLd
         i2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709780966; x=1710385766;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5Ul/l6h3QQByB9upBvQ9wSmoGLdWz++Sa5jGQeBypo=;
        b=m9xl45pCrE9LqsNQi5Fwmr/YJLLA9fw/2LV0It0FBuXHq9VVpYayDpvnVxlRMG0Pli
         t2YyWyqTbp/9lXpC1pDuzApnFsOGBKvk8ul2Xz21DKyur/ee7p8p13PgRyuUVyfKiaeS
         BctIFgbEYxPvMoRpf9GCaW1OvSKz4LJT2GVtGVOV/zKxCazsjv+aKCwfV5wZ2unp7MU6
         mGkfTaXljnsm40VmXZpfHfW4J6pbLGuwBGwkXAig/bka8daWUi6sLFDKbxqUAxbzucsV
         8BAlM+wXmvsC2X1zS95mRIDb/smLCTQPIfKflruhor1Pz5fFg4e8i0QBol9Glt4PpyX2
         3cwg==
X-Forwarded-Encrypted: i=1; AJvYcCXYKysghWURikCgxNqViS3sVE0MHKAkuu89arnlKoNPtzPXW4rhfipBl9XSjOJ8iEMwwEAKmpqtYHsdv3U3+67tJ3bzT3hkMaKBdMqU
X-Gm-Message-State: AOJu0Yy4Vsq24l/h2PcjKoVCIuAYQDj8IajA2QVLREXdGISxb7hRLiAx
	ZnBeUh4wSHw4N1I4UK/7Hjx7w1CSk6IlqbyEs5GR6DSHoi+8PSxaAEoQV8pyG3JPBpGdTa3XhgR
	0VA==
X-Google-Smtp-Source: AGHT+IHeaYvtkY0Bcfb1Npr2PybT8dlXhavGfsAAIqzbqBoTOs8R7yumV2r/35rHceoTxqMk4lHGh/7MQQo=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a05:690c:3612:b0:607:a30d:8cf with SMTP id
 ft18-20020a05690c361200b00607a30d08cfmr3779456ywb.4.1709780966471; Wed, 06
 Mar 2024 19:09:26 -0800 (PST)
Date: Thu,  7 Mar 2024 03:09:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307030922.3573161-1-royluo@google.com>
Subject: [PATCH v1] USB: gadget: core: create sysfs link between udc and gadget
From: Roy Luo <royluo@google.com>
To: royluo@google.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, 
	badhri@google.com, quic_kriskura@quicinc.com, francesco.dolcini@toradex.com, 
	quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

udc device and gadget device are tightly coupled, yet there's no good
way to corelate the two. Add a sysfs link in udc that points to the
corresponding gadget device.
An example use case: userspace configures a f_midi configfs driver and
bind the udc device, then it tries to locate the corresponding midi
device, which is a child device of the gadget device. The gadget device
that's associated to the udc device has to be identified in order to
index the midi device. Having a sysfs link would make things much
easier.

Signed-off-by: Roy Luo <royluo@google.com>
---
 drivers/usb/gadget/udc/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d59f94464b87..876b8635b16f 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1419,8 +1419,16 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	if (ret)
 		goto err_free_id;
 
+	ret = sysfs_create_link(&udc->dev.kobj,
+				&gadget->dev.kobj, "gadget");
+	if (ret)
+		goto err_del_gadget;
+
 	return 0;
 
+ err_del_gadget:
+	device_del(&gadget->dev);
+
  err_free_id:
 	ida_free(&gadget_id_numbers, gadget->id_number);
 
@@ -1529,6 +1537,7 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	mutex_unlock(&udc_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
+	sysfs_remove_link(&udc->dev.kobj, "gadget");
 	flush_work(&gadget->work);
 	device_del(&gadget->dev);
 	ida_free(&gadget_id_numbers, gadget->id_number);

base-commit: 67be068d31d423b857ffd8c34dbcc093f8dfff76
-- 
2.44.0.278.ge034bb2e1d-goog


