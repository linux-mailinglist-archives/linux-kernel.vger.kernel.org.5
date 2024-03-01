Return-Path: <linux-kernel+bounces-89142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC886EB18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB4A284DF5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236F57892;
	Fri,  1 Mar 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ddf9XgjT"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332057872
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328250; cv=none; b=LAhMFpW+p5nDwhXjvTP4Un9NcZRUFPF0gEhxhytrzWlGr8QNzsN9PyKT9tBSDWujJ0LCsYOj6a44muh2fXY+wsO1ns7775I0XyJeR/M15w1uoFDGC+9A7++cQxfgEtY4Er3S9ZC1va5R1NdcXAikqyOkvSRMVWqHxTm1eZM9hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328250; c=relaxed/simple;
	bh=HPEx7q9YeqPD8Fs26Mm2XVZAJVX8dLxSFoyKT+0rhQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QBklFPHY+A4m782c00023rlNDME5NaLTIjbNAj3zoBs6Qb9FIHGjdrdCwgn+mWbRyEXLW9jhRqoEbk3O/LxP5AoLXGBEr7wBLquqYvb4pLRkdM7Q0vz1NvI+JeIkeOX1bdhUnR4bCCOO5lugeKGNYbjPa7MUGrIT4OxKhgazy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ddf9XgjT; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb9d54575cso1736101b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 13:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709328248; x=1709933048;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp0fkz4lNEmpnn/7oL43O7kf2DDQQSr2VJ+P1LkrmLA=;
        b=AyIlCjdv8CXO4rBEXtgUEIqfxo9zWrOZEEglxugzmbdgvbMJ5a9TBjn5famTva0ao0
         PsaMulWrrU2LhEEYcfZVcuV/DTcQzYeWh1v/Abscs1kTLF5efypoLH23l8k3am8ncrGs
         9vot+AxpX1nGPG1K/7i8SAMyS8VFs10U+7IGASrdU+YY/wecbpK37v1gggjtQbJ2pDB0
         fVVqsAusPfZEu/P74onho8+putSY1gBTXVDmZozaZeur3TN+d/lh6e1oPYcHUv3FSmGz
         bdIOYzwxi0iAyuu6OT/771nFfhN1+r7kq9CCnahcu90Ef68lux1nZCD2f1NsiabVj/mV
         a46g==
X-Forwarded-Encrypted: i=1; AJvYcCWTgSkj8MGFRryCrA6unxEoSEg15rHUbYONKcvz3csBElqi2ffDw6f+rABQ/zOT13WPDBodOMX7sxxyjCFEPWzhVOXblAOppYhwsuT7
X-Gm-Message-State: AOJu0YznjvqWoYh0/SlVrdiiJ8EaCdR/uEXr0PhIpAJhYtuyju+P+wiW
	Yr3Is909HygcnYbh5pzMrr39OS0dFgDjNle8wQ0/dtcgT/wJnFWt
X-Google-Smtp-Source: AGHT+IHMLcEFsGXrsEV8hHzEvoTbVKOBW7WQxQCgzKXVcKSwflcW1ovfYW7ITo/cNU3FL6G3nAUZZw==
X-Received: by 2002:aca:1e14:0:b0:3c1:d5f8:7495 with SMTP id m20-20020aca1e14000000b003c1d5f87495mr2100068oic.8.1709328247910;
        Fri, 01 Mar 2024 13:24:07 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m1-20020a635801000000b005dc120fa3b2sm3082951pgb.18.2024.03.01.13.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:24:07 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709328246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fp0fkz4lNEmpnn/7oL43O7kf2DDQQSr2VJ+P1LkrmLA=;
	b=ddf9XgjTRm0aI6jiBSBCB7DQ1tvQYIj/CW8X4HaPXm68mq0GeD8D4Se30Gs24cgQb6T8g2
	C3VdtYt9yfC+k82dvCQw2EJf1TJTOYrHATkgld8q/zXfif5f8045PahCgT40zYfcLqHsc4
	Ex0wfmmD1/ob1QGn9mNbV5rg4Ke/9f5hWgRi8qnpvSDfIED5FIuwi5sCfCOnl6RHkvDufC
	ofsym8qG3FHlEZNCLyzuqPT+MeR29WWwc1URq8wUVyAIf+mcczh3Yo4F5zWHZzUeHTglXQ
	nsXATwkvj9IoEhm2eC2MiG6nDBKJEnVtfJkUDLYlxXOpN2ifU9K7QyvPY6hCug==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 01 Mar 2024 18:24:05 -0300
Subject: [PATCH] staging: fieldbus: make fieldbus_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-class_cleanup-staging-v1-1-34db2a5b0eb0@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHRH4mUC/x3MQQqAIBBA0avErBPMAqGrRMRoow2EhVMRRHdPW
 r7F/w8IZSaBvnog08XCWypo6gr8gimS4rkYjDadbnWj/Ioik18J07krOTByiso650KwBq13UNo
 9U+D7/w7j+35E6EBEZwAAAA==
To: Sven Van Asbroeck <TheSven73@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=HPEx7q9YeqPD8Fs26Mm2XVZAJVX8dLxSFoyKT+0rhQs=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl4kd1M2/TUzwwsygSCeViq+l9scKnwpgWEsF4z
 CLO6jB1xWCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeJHdQAKCRDJC4p8Y4ZY
 poXdD/4rXO99mzM+kxKDpe/b20gB2llrr3wMpzcIR3wySpVddytK4PuA4CvAVNET6GFB9RU3kRu
 9YN4YCixluImgDKzAqWTSjTYOMwkxUPT9v8ZyT9WH+FUBpduJ6OhOlsJKShNYtNa/kQ+xOcp4y0
 0awTVmq2kM4EsWTh0Uol0XfMHKwR4xYvvy77KmKDayfEkn1a6eEX9x4Y5UF+u0RhO9nARLVh1EH
 so+qm8Axxq4YepWI/UXUKVFvfWbQMMInmuros2tF50llu+K9nypdxfyL+zEM34hPof5eBKbGx08
 klfBlAqUJE6G/lGA+/6jVoVfV28TlDIlwwyjHT+MXplQcT71L0dHKzXy4qF4UX83s49VVNKTwcC
 A0FL640sjro7fNgLWdehKGF9dXkLmUGaRI+V9VzkZ1Yd/Vhv5ChqGoefeE6lQT8Brrqlv4nfh89
 0DTetcEnDpSZQeFEmzIagB6in/TavHuIqxOu1hAphwYy1H1ak+186vQCKNI6+Bp2mmPmhtlH9wE
 n+7ujZKkpRIkZPBcfVE5f56N88p4wwcr72EfTVmLMVYD6z7ss7MWc2C8w9cO7Yw3VtNOuNx7DkU
 mv5eGR8QqlOjJBYKiOh0mO3V06RLm5+wr3ioOAX/95f5j1a6qSiSf9OyJXSSl0PzylcbP9xXAPb
 ZDBvPcbOviATQxQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the fieldbus_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/staging/fieldbus/dev_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 370a229443a1..0053ebd91442 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -152,7 +152,7 @@ static const struct attribute_group fieldbus_group = {
 };
 __ATTRIBUTE_GROUPS(fieldbus);
 
-static struct class fieldbus_class = {
+static const struct class fieldbus_class = {
 	.name =		"fieldbus_dev",
 	.dev_groups =	fieldbus_groups,
 };

---
base-commit: 455c5e12a3b7d08c2ab47b7dd54944901c69cdcd
change-id: 20240301-class_cleanup-staging-7bbbff72a7cb

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


