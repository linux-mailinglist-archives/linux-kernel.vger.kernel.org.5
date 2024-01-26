Return-Path: <linux-kernel+bounces-40256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D039383DD47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBAD2882DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB381CF91;
	Fri, 26 Jan 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQImG3ab"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96B1CD34;
	Fri, 26 Jan 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282373; cv=none; b=DighApd7kkOli+NJHK4D8dSEbk3T8JQO54VqnTpsSVaQUxa7Bjn1OmcpIVet0XTz/IA9oUckMI4Ta4XYjOHQ3WhVyyRq3fUe5UuoREBY0iWF9TXhCeYMTadWcMzY9Lsf68U5SUAbINIcvEzHn13UwKF0T+ebaz20waVl1EHx5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282373; c=relaxed/simple;
	bh=hYiazrEbt565yABrCeDAbioOA2B0ovx/3njE6OTcBxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WHdv/+instTti9uVAH3vb307pmu9AkFvozLqNIz7oKPxaNj16pnmolH5QXxjZmhq+ymlxM1/adq5VEN11c4ikB77t65vd2e8qE5IoFiO1donmOjlw9KDsYNtJeeuWvnL8YjRslR7/zPzCV30bT3RnfMEBdeKBeD6AorEEWXzg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQImG3ab; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100c2f7a16so434874e87.1;
        Fri, 26 Jan 2024 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706282370; x=1706887170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3O5ltxOMjNOT3zVkrFdSHnL7bx4JRmZ0jGii/eg5aM=;
        b=MQImG3abZ/PCjj2ABDAzs92mx6w0W4Da6CXDAvjG3tbDHjqdMrYHvjuXuwpJn65gIx
         srlziuU3JfthD1WDmiPbS/4iQNSU1w5Oa/aNTIDQdPqdQfbhEhkDAamWLouOVY7IUr/m
         IONbs56JKySDHBLdj2O7Yyje2Q+BMCfph/eOBMp71Kf71oAhUBsjpy/w9QDJlGXJai76
         Xz2c74/a5ULKwPaeEERILV1/z/VNPll4vkE9s6/wEfzcE1zY0AoLLbRS62UrRF+YAJF2
         c31ARDPQjsbxbOD4a5P5bFfPdzDSH9t9z8OibwaVIB8raZt44FAEzd7ISCPRMjUdbvhm
         HF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282370; x=1706887170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3O5ltxOMjNOT3zVkrFdSHnL7bx4JRmZ0jGii/eg5aM=;
        b=rnNquadKaOEjeh8YLwnGUYpgT92f16NxQRB/ZGty6Zly6FXOjPIrRl/XWioqFpoV1r
         Z84jmNcxK6RSHFfltzIlHKnqZVw/cLRC8oWJZD23Zzo8jmR07EeGbouV524CnhykaDl7
         XntaOw+FFH0Exdc3wAR7EVtF8GjFvcb4Im4EvtgDpeYCwexdh6F63Bxp1rpDvRTIJrE3
         PgO+KoUvrKH5pMOhhc+k2XVOmmk6I3bYWZhxonrfhSm2Ro4FrpFvR57ETQJm6O84TcRH
         eqYYyDQLTQMVGVTosHD7U9yKj43qFHCYUmbG5G/Gdxa+wCNMKxwegutMr3drLVz7pZjq
         iYkg==
X-Gm-Message-State: AOJu0Yx/duE0h49HU5zIYbNF7qnWe8m7Ab46HMv2D4XXPmS6CKAtJCQb
	JFB/hFeRuu+hIiEVJLC1v5ZHc84c3VN4v6e2lmmDPgPbaJrQgVYZ
X-Google-Smtp-Source: AGHT+IEJ4N5LA2V09QWkMAaPosg1hrxhS92nNtqvQ/QYpz6Q5L4iwwV8CpEPgeMvZhqe6Lcn12a9DQ==
X-Received: by 2002:a19:8c03:0:b0:510:1590:a193 with SMTP id o3-20020a198c03000000b005101590a193mr737956lfd.30.1706282369753;
        Fri, 26 Jan 2024 07:19:29 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id j2-20020a2e8242000000b002cf46aa24e0sm186264ljh.10.2024.01.26.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:19:29 -0800 (PST)
From: Konstantin Aladyshev <aladyshev22@gmail.com>
To: 
Cc: aladyshev22@gmail.com,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus/mp2975) Fix driver initialization for MP2975 device
Date: Fri, 26 Jan 2024 18:19:19 +0300
Message-Id: <20240126151920.288-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")
has introduced a bug that makes it impossible to initialize MP2975
device:
"""
mp2975 5-0020: Failed to identify chip capabilities
i2c i2c-5: new_device: Instantiated device mp2975 at 0x20
i2c i2c-5: delete_device: Deleting device mp2975 at 0x20
"""
Since the 'read_byte_data' function was removed from the
'pmbus_driver_info ' structure the driver no longer reports correctly
that VOUT mode is direct. Therefore 'pmbus_identify_common' fails
with error, making it impossible to initialize the device.

Restore 'read_byte_data' function to fix the issue.

Tested:
- before: it is not possible to initialize MP2975 device with the
'mp2975' driver,
- after: 'mp2975' correctly initializes MP2975 device and all sensor
data is correct.

Fixes: 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 drivers/hwmon/pmbus/mp2975.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index b9bb469e2d8f..1052282427f7 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -126,6 +126,22 @@ static const struct regulator_desc __maybe_unused mp2975_reg_desc[] = {
 
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
+static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+      switch (reg) {
+      case PMBUS_VOUT_MODE:
+              /*
+               * Enforce VOUT direct format, since device allows to set the
+               * different formats for the different rails. Conversion from
+               * VID to direct provided by driver internally, in case it is
+               * necessary.
+               */
+              return PB_VOUT_MODE_DIRECT;
+      default:
+              return -ENODATA;
+      }
+}
+
 static int
 mp2975_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
 			u16 mask)
@@ -869,6 +885,7 @@ static struct pmbus_driver_info mp2975_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
+	.read_byte_data = mp2975_read_byte_data,
 	.read_word_data = mp2975_read_word_data,
 #if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
 	.num_regulators = 1,
-- 
2.25.1


