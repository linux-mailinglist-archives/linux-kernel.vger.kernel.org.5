Return-Path: <linux-kernel+bounces-58644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FA84E956
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3767B2C405
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1C381D9;
	Thu,  8 Feb 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ZeeV1jkT"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E1381DE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422707; cv=none; b=KMFoZh88b15fMpH6dyNgJzUleaQNn4VsmWvDLQUC3wTa05MEFoadjeYbVZfzIwR+8GNu6CQndIFKXvCA41pglB/amsKivUHXuZDVMiye0RVqQ4tu/U18tVOwjbWl/9eb0BKf08/yNCMoOQdxbAW3c15wBuPdHnZl3KJNDk9N7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422707; c=relaxed/simple;
	bh=egz+RD4aL/7tHzmuiLKqdq4xKbO6pgSZJDSU0EHXaZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=itA4rl/Qj/OowQvUcXxCPbDyVnu5rHePUusFG1AKgq1+xotwPcyV/ao+gJy0nDAdXCO4HGX04qjstEXCH5mvkpTqQoOOJLBkex6vm5ZiKxDkXx5p8NFjxQq9Ley2PPCQxx0aj4DsQn+ehGyTwrnRVxXKy/ojB6FAiJtI8BXJVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ZeeV1jkT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d73066880eso1564555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422705; x=1708027505;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1d7lvHBP4zZDVCKKcPWDJC9hVpbD2k1vtblJKsazU4=;
        b=iZm0SAeYGZLR1/GoKHyF90j/mMMdNTmDw16PzI0oxgfPwrSz76ZLiV65SyX15XE01t
         XKGYvhOc/z/zUdCsT6xPLXpiY2GDnJKgJ+RJRYRr8dtaIdzvLyBh1f1yHWOQX9PD6ZHg
         5wKiVEgJ3s4qe7C+yT7JsFsUgtkP2HnLyWvmfa/f+Ux59809HCpkB/MhXdoK1ltO3AGA
         /Jer4XEXtWQIoFGcqaAlnCYay6RBK8Rrqy6ITyRWRIVb2ToaW4hNj9PGuG8ZuFhWuufb
         hemchQG+rT5XspJDEFISQKbVxtM7KKHKpwxCSTSDaYpNm5WFXvZkqajfPaThQ9X1ddUd
         mMVg==
X-Gm-Message-State: AOJu0Yy/TMmnZYtKfwN1tvVTZxmtWGPITyQ6ZeJrgf2usKpggYq0AXf3
	C/8VdsB+JY3AGlX4D18rd/zSbqP9/DQoYys+M6ohTDMQqs2pcIEC9LLiYCzWXsNbTA==
X-Google-Smtp-Source: AGHT+IE/KjPq8TYoHx5dUJYU8GzmOkVLoNlc9Oe4gOUOHbeuXV433FmNIrQQBoB94Grfi2Do5ur6EA==
X-Received: by 2002:a17:903:1105:b0:1d9:87b6:e09e with SMTP id n5-20020a170903110500b001d987b6e09emr285834plh.21.1707422705372;
        Thu, 08 Feb 2024 12:05:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWP2JZsuxdougESzMncr/z6NalAfbalwkpwIkbWpCERy3FkEUGi7MoGmG2Rk6a0XyUpJ1mZ6OJFyzyM0s8LClw0Bw34a9wesh60ablk119lKW7x81QrzKj2T/Oh6ShbxWM7tnj/OnyfH+qPNpgWS6Fn0yBXb2EaZmUjoIYvSHUib2EuniO/Hak2LmQg6aKCyfgYwLBMwvqgNra/Hda82xEquJngIib
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709028f8800b001d911dd145esm140421plo.219.2024.02.08.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:05:04 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707422702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G1d7lvHBP4zZDVCKKcPWDJC9hVpbD2k1vtblJKsazU4=;
	b=ZeeV1jkTdvJ269TqLbK4P3nRJSyr8iXI980xEbC5v4yE3v8IRoQvwAEtvIMB9PJRjhi5wp
	gFNmAy7kQ/TNYFaRjdy5umC/GSi8lJoIvY8cyxaN18myj6EGpNMkyBl6eq5OP1Qty3WiWZ
	+r6wwHKTJsaIGc4gRzRCBzd5eDJZqo8O137EfydBxG470JQBEoJ1Ixp25MBci2MIO3BR9a
	4uub/JgXwGP4iv+B4XUBnvsinHnAoD9UdRZXNXIqdQk35FLeM0rCBTFROmnGfgR0xjiBgg
	l02gs5trj4pB9lF7Dzr8C6AR0wUpCW+7HxRPMbwLIYjmoHkHykMSwabJE6QjGQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 08 Feb 2024 17:05:29 -0300
Subject: [PATCH] fsi: core: make fsi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-bus_cleanup-fsi-v1-1-0f13d4a4f920@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAg0xWUC/x3MSQqAMBAF0atIrw3EOOJVRMThRxskShpFCN7d4
 PItqgIJPEOoTQJ53Cx8uIgsTWjeRrdC8RJNRptCG92o6ZJh3jG661RWWKFEXZqq1jkWitXpYfn
 5j13/vh+2a9+CYQAAAA==
To: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>, 
 Alistar Popple <alistair@popple.id.au>, Eddie James <eajames@linux.ibm.com>
Cc: linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=egz+RD4aL/7tHzmuiLKqdq4xKbO6pgSZJDSU0EHXaZo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxTQO3CxDlT/G5Xy6E0h96clc6CinrHJIB4keR
 pr8YfkSe/mJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcU0DgAKCRDJC4p8Y4ZY
 pp+tD/9sWBuU5COiLhK+niahDTdn1Uf21jaqsEz6+8QNOS/gB491X+RnBA2fkLfwJnrYVwmjvsu
 PuTo0Jl6r98CjrOzRjq3qQSnA54IDe/o0O3E+9S03VmF5/TqGbvj7Bv14ODcWYfwWnGMKKd6Lbj
 wsQRZwbgUjUamON4LdaIVIYIuVLsi7lROfLmi0F7dlEikNcRHwoS40S8pMnfXIYcQfAr97ewwS1
 lyI4E2Bwexx6mc7N+3F9uvnpmrLIjxmK6OdjjtL0IeKgSGFmQT/kh2WeEEVgHNSiiFXK/DhJfLb
 xTYd7jZFSGG/43zWFP9fGEfT0I76PScUswcxu7OxKuXC/8OpJnHdCU6/7bK7bJLURmGwtNefKVU
 GOF14jr0OpAU8bXio0rxUDuvQcpBkKtQ7aNfpCQk/xoCd5+GXN7W1TSK7alZbSNdTnbI8Us7xLs
 HDdHoWFcVJZsVhsdGiSL88vkdUYWYOfVjyXQjW/paMN5SNegpTdSoUq/TB76a41wzhPYQtF6Qkp
 QEdk+aFjZCh6xjmEQRp4SioJUCRY2b6wBC7BhCrwEuAk8Irca7UB7ZzlzNdP7vV8R/uUgRNGa37
 Db+djUv8SwXLEyFlebu/EnGNRNRLLSCNxai8irss4m1/+HgNEJkaHy1VfxrZqesPNf3bBmeZW4B
 d4vMIj9qi/PsRQA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the fsi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/fsi/fsi-core.c | 2 +-
 include/linux/fsi.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 097d5a780264..f0ffc2cbcbdf 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1404,7 +1404,7 @@ void fsi_driver_unregister(struct fsi_driver *fsi_drv)
 }
 EXPORT_SYMBOL_GPL(fsi_driver_unregister);
 
-struct bus_type fsi_bus_type = {
+const struct bus_type fsi_bus_type = {
 	.name		= "fsi",
 	.match		= fsi_bus_match,
 };
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 3df8c54868df..e4b1ae7a2234 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -68,7 +68,7 @@ extern int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 extern int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 		const void *val, size_t size);
 
-extern struct bus_type fsi_bus_type;
+extern const struct bus_type fsi_bus_type;
 extern const struct device_type fsi_cdev_type;
 
 enum fsi_dev_type {

---
base-commit: c5eeb63edac9497f9a0d46d3b75cf8b293771ecf
change-id: 20240208-bus_cleanup-fsi-e5e7526703ed

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


