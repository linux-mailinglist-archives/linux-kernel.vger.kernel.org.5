Return-Path: <linux-kernel+bounces-44842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C084280E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114D828C626
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8F823D5;
	Tue, 30 Jan 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="WRcDLtQo"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63898823A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628552; cv=none; b=ga78o5fDv6jqx5ri0Jx7VSU2WnlsabsWOrgaf73xI4toBlkQyDRNww/Lh/EBvvrsIgXIC2vsVAihq1ShlHhIJXt69mc5Fh0XK7GHQcuBfqJ9ROgMR0shQ0cFIOLw0crEcjxWmxyXbeZxPb7eOqxA6kHbBxslvRCpbBhthpaYY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628552; c=relaxed/simple;
	bh=f7vh7CU8f3xf9WNo29CQlCllyeFojlMOf302dp2eR80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rln8Avggy0piRHnjZX2aI+lK51q6/qbXNfuqQaZ/vngTSwJi5TQRB8ekp+zkAxxJNsv9jSRsJAs+g7i7i6JkDHKuAE6scszBypShY3pD5kF563JVgyLcuxLFGbuvQdUXvf7f0yGMnmvHAaZnkGSljkmuHRwQay74vAtL3NlJIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=WRcDLtQo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-510f37d673aso3530380e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706628548; x=1707233348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cxab9c1GLUbr8ktMoVPuxVQEtnmwbdONtYqM9ZydT8=;
        b=WRcDLtQo553sR4CyII+D876Z3PFwmrfLiN8TulBEQvEGMV9TZko2nQ9a2bSnCSqg4n
         AdFweCZjmGNcHgsImZ6WRBhVy/iK0Urkk+FljHUGUcu6Nir3Ph02IBYk9j/LhPl8RXtb
         qt2Mz7J4Wi2by1I/X/asnR16WFZ5hzDf5B/Lc/kCtA/mqdDL4wf2EbaHf8mSXPgKq1m/
         rDxYpga6L8UJj+JVi6V2fH8m094otzru32Ud0kc6tTGdQyciE8e2VfXhaM4DFPG7v8xd
         oPeewYoACh5o27qVlQiykeXHrZjOuuhm5lfuxQW1RpM7m6zFjBK0InqG1PgdJ2+bjmXb
         mk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706628548; x=1707233348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cxab9c1GLUbr8ktMoVPuxVQEtnmwbdONtYqM9ZydT8=;
        b=nF4Eco25aepB2+qlNdPy63t/JKlailx8DeggU/i04m+jRLXHURYljsIyctRQnHmfJu
         72QrqnHeOiF+NzywTpofs4I03zuL+vwjPnHueQcqpp1TBOR7o69PnGfQHvI9gsDnBpKC
         WWlK0TD0g96FVyXNwrw0gjzoQeOlacd2RqZiKIPf+gp0vUf2Bdc1znzDlmPHOl6zyrqG
         CQCOK+GKVjAPVmG62bYLrETt0Nw4JfC9ZmlsCYPJEkqcTGkZiQ8IMPbyUBzKghbW1OvK
         O3A3QOtC0y416NUEp+1jvow9qnLP7Q0SFhOJP+7UBlsVePBE1uhV2oRELSaeds05MGJg
         H0Eg==
X-Gm-Message-State: AOJu0YxyW6Eiuvi9qSVEmO//rJYywdsVMX1EEcBmQlnlElIkO7RpZWw6
	8ZOlvvrMV8D8SLAYXclMm3YqDslT+JbNl5G1Z3t/La+iG1XtO28TayG/CfInIB8=
X-Google-Smtp-Source: AGHT+IHRWWiuqSXJHYBa2mWLkoAEmi0JD/TCwrJIulgko8uqY0Cl9Ng6mMs04IFk85wfJzEcQWrnVg==
X-Received: by 2002:ac2:5fc2:0:b0:50e:8e74:6406 with SMTP id q2-20020ac25fc2000000b0050e8e746406mr6673763lfg.36.1706628548324;
        Tue, 30 Jan 2024 07:29:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfocgrKJv+URBYzOY4RWauWTJgEQJn237C3KiCgKl3fWxUsDDcduOSTYvhoMSfdhNqjFLGrP7He9j9Q1Wuht+bdScLyL+EqZ7EdbUw7G8US0Edc/rUXIhhQXAv+Ix8LrgRGPgigC3TEywbRftUXQCXQU5pxUE07GDfoqCOa9GXN8xopXzojLuCosi84PTS7971Hz+S7igF5wOXe5o4T5iANdbjzyA2wdChOemY2uDURi8ipQC2T3H+oA==
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c34c400b0040efcf63492sm2975039wmq.18.2024.01.30.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:29:07 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>
Cc: mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus_core) Allow to hook PMBUS_SMBALERT_MASK
Date: Tue, 30 Jan 2024 20:59:03 +0530
Message-ID: <20240130152903.3651341-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Use _pmbus_write_word_data to allow intercepting writes to
PMBUS_SMBALERT_MASK in the custom chip specific code.

This is required for MP2971/MP2973 which doesn't follow the
PMBUS specification for PMBUS_SMBALERT_MASK.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 1363d9f89181..cb4c65a7f288 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3188,7 +3188,7 @@ static int pmbus_regulator_notify(struct pmbus_data *data, int page, int event)
 
 static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
 {
-	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
+	return _pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
 }
 
 static irqreturn_t pmbus_fault_handler(int irq, void *pdata)

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.42.0


