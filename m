Return-Path: <linux-kernel+bounces-149302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCDB8A8F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6EA1C2169A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401528563B;
	Wed, 17 Apr 2024 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFo5v/8m"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3DFC1F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395226; cv=none; b=Qqpms4FFn8Q3pRz/40XOV0RVQ3FO8uiROVXGe2tIvDJsn6ZAN36pX9i9jjaVWYC81PkEq3GiKHz61IqXVGY4ZmjCz2GmZFuqjPUn2CJysD9b1YJHEzEkeLzELwBKI9uKuSi5kK+unvPXMN9VemDDOj7BntvORnD0tjkNWqeA4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395226; c=relaxed/simple;
	bh=HOqShe5yeUWnPhZuqFM8RSUH+/kbodWzz7HN7N/L39s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q0swAGaxCXX0Xx2jIrVNXVVNGqa1Lw420ZiH26RyNr+oH3kl9ipgkfzbe4u+54O/NFbOg677Qgo44y9rEAoRWuXtmM3SegpL59jHdQVeJ7J7pg1f1R6qM8w4RY/ATAZvkUzs3ecI7r1fxkB1vYRNUzNTzfhnzX0LXkNyhgxq85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dtokazaki.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFo5v/8m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dtokazaki.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso597029276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713395223; x=1714000023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ESREvptBFDtywOEXVmXxmfhUoPX5JiubFR54p3zkXt8=;
        b=dFo5v/8mnwluqRKc11dgyzr00/r5T10/jqnYUjRHZQiRYIw5o/3LcMRNDBLcih5Z4v
         9vPRogsNA/G9VdalfkAm6tICr0JFhIQ0KpUOHq4O9IHHUy2npj0A5ofVjB4vU9TZvDSW
         M/Sxr8Fu+D9TALp3h3sAFoGjTkGh8yy3PCCXw6SbYs+3RID64OY6832czwKskAImmPY5
         sJfX3zRL1Bdx5kLXycbi1o5B1G4HNaSU1VygOJ9qrfvm3K3ljIzvxjeFVm8IizuyeHI6
         xNyTx8Q7UeFzBHp4jLvBSRvIqWILV/VkcVP8IZ0jM0xDpR1P7ud1Uo8+ZcAfj2+Grswf
         FYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713395223; x=1714000023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESREvptBFDtywOEXVmXxmfhUoPX5JiubFR54p3zkXt8=;
        b=d1M/QuWabxYmjKYSn76lph4D6cXJkEGRqkBLySGV47p+D/sznsA/kAQ/Z8RjH2xcnP
         nto72znxXyun9oy1PMGz2ltD494lVjW3AhHGuszEOQxxXvFn5feuvx4rV0x7zfI9wrCo
         DlL6zL09RsH9SqbG9G+s4vWbXJJ1zmr3XA7JC5tg0k7pBlu7BFh1FKfNBeN8UPm3UZ1v
         5bcDtWz9rhw2Sla86F7/7RwdwzSZjNcf+Cob55IeMoLn25C1pZ2vnL8kmqx5r05Aq/or
         AkRH8Oc0bHXZ1wrgaaMuykS+xWZjTBxTMRoEtG6O1tIs4D6FtLy/OqQfYZaB5Bd7X4Rm
         qj/w==
X-Forwarded-Encrypted: i=1; AJvYcCV+lOI6fhevYk3Kol9IjCHHmuwW6adDti5xeF2DZLql7C1R0Z8UoCpVUxlMU95jZ4vEUIpx42R3izbsKyO65VR1E/UyH4xBsnqcyJ6H
X-Gm-Message-State: AOJu0YySAMNf7d8MCeKBlsKBfaA3Mm++kcoweEmGrsAVYGI3am8b/a1O
	PXDoX78n0gXulYumYKATdPCaUBO2u1Sf3trwOMeBVV/k4TLVuY3Lhz3nIG3DFH4Cu661MUe8luZ
	MN/OzyYxaYfF17g==
X-Google-Smtp-Source: AGHT+IGGsP/v0b31hwVFbOVuj7xjAQQur1JVUVq8/Z6h8KToJPaV1mBk8qXmfn6bjBb9KyeSVufWf3nDl3XHdLE=
X-Received: from dtokazaki-pixel.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1a03])
 (user=dtokazaki job=sendgmr) by 2002:a05:6902:1005:b0:dc2:5456:d9ac with SMTP
 id w5-20020a056902100500b00dc25456d9acmr106101ybt.5.1713395223203; Wed, 17
 Apr 2024 16:07:03 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:06:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417230637.2592473-1-dtokazaki@google.com>
Subject: [PATCH v1] at24: fix memory corruption race condition
From: Daniel Okazaki <dtokazaki@google.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Okazaki <dtokazaki@google.com>, kernel-team@android.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the eeprom is not accessible, an nvmem device will be registered, the
read will fail, and the device will be torn down. If another driver
accesses the nvmem device after the teardown, it will reference
invalid memory.

Move the failure point before registering the nvmem device.

Signed-off-by: Daniel Okazaki <dtokazaki@google.com>
---
 drivers/misc/eeprom/at24.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 572333ead5fb..4bd4f32bcdab 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -758,15 +758,6 @@ static int at24_probe(struct i2c_client *client)
 	}
 	pm_runtime_enable(dev);
 
-	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
-	if (IS_ERR(at24->nvmem)) {
-		pm_runtime_disable(dev);
-		if (!pm_runtime_status_suspended(dev))
-			regulator_disable(at24->vcc_reg);
-		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
-				     "failed to register nvmem\n");
-	}
-
 	/*
 	 * Perform a one-byte test read to verify that the chip is functional,
 	 * unless powering on the device is to be avoided during probe (i.e.
@@ -782,6 +773,15 @@ static int at24_probe(struct i2c_client *client)
 		}
 	}
 
+	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(at24->nvmem)) {
+		pm_runtime_disable(dev);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
+		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
+				     "failed to register nvmem\n");
+	}
+
 	/* If this a SPD EEPROM, probe for DDR3 thermal sensor */
 	if (cdata == &at24_data_spd)
 		at24_probe_temp_sensor(client);
-- 
2.44.0.683.g7961c838ac-goog


