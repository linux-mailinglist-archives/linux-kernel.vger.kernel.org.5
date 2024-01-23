Return-Path: <linux-kernel+bounces-35183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4EA838D44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8431C21B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DE95D745;
	Tue, 23 Jan 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOlUs8aG"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221C5D727
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008772; cv=none; b=fubsGwuE5UaSlFzTxhRr3a8jhfASX9R6cOhGbZ6119IgSOCkRHIANynfVr0wIblyT89eQg2ebJkpbI4KHOjMo4b2+6+a6VHEin9JszbUZ1B8NwU41C3bKhHRrwp9EWbRYBrc51ApXkvYcRuOSlQ8pqZmYoSRyerZm91QcxXN0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008772; c=relaxed/simple;
	bh=C6BsBKcktkP97lGptVkgfZZi4GPR1FFiDYW4JzJCj9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I/QgmQhQy0O6rloI2LzyMjmmtXMuT2VYadnl8hv+h8pd04sXI8o68XN2z6OD6EJQKe2XHKQUpAO+gHQ0zmhMq4raZs+aiJAzwkOu2/pulRyRRDEfId9ou2l0D/Iqs3SwwahoYCLYVGQ0n8CQ/tsgyJcZdvoTuNGWC9n6JOpTQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOlUs8aG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so4713351a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706008768; x=1706613568; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/Xcl0onVjE7Leo9ysBcPjIxgXGjF6Jy/8Rf+APk+/A=;
        b=eOlUs8aGYFW/B/f4QXfFWPgfq3QuS8kYiqRXd3cXpSqJCsAYIwWxi7R/zUqeBpTedV
         7Al4CmeYn+eSvZpm6VH1sIkGYgHxHpEkSonInJ9ph2kmlUVAMC9W4qbbWqQAOCHk7/T1
         G6haJebLX2pL8ct5XdQ7ttUcUrjSwZwIbAyMGUgsDI4KXp04mWM1TDLWjvW9QtjMzzT4
         3axpfGHPSzByQbnyGLYLViSged/OVhOcvZBODJ5wVIwZELTFJEm1d+Tp0n04y13LCLEI
         4/XEcNuomovWCtCsbfhskqGCIz9iK4m/tdEePVLx25T2qaVAs0ZipTIzn0tFVG9zumAQ
         ejVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008768; x=1706613568;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/Xcl0onVjE7Leo9ysBcPjIxgXGjF6Jy/8Rf+APk+/A=;
        b=NVKGLxFKWgpVq3rYVWqNyx8Swqr7wEPNb8+hoehH83+MZMCK3W+1V9nQMGvJCh/pZL
         osg1/NZJ6XmVG0e2GaAxUrqmnNVOy0FGsAa11ItIiuLQsTCZ8LqC+cCk3B0EG2Sxl4Wx
         l4yGjxbW0Au8ONXjuF2Nvc2M73ZdWvXa+0BZZ0xdbUq1JPMEaQtKva6hpWC7IgUGmN7R
         o76Sqg1c3R70gai0d51GiiVHKdf3if9s1zfLxBt8PoH3ORJyczgaDs/a/fmNFvigLdji
         jrJdp0KffNmxOYLUg/vx5rhC4v8Ak++LBVzf1+xmQdeh9kcXGJVbttk/UNSr85dV9UF6
         yQ8A==
X-Gm-Message-State: AOJu0YyRdIQ4vgQPsjb7oagvVe+7KDbZ29+BJZWFWaCtMq6b+ApL4b/j
	tfqm1YrXWkjdSHWPRIVTqBFnG0dwAO1gp9pwvCP2gH6HW5Zsl8fpHuGOLJZ3z1arXQ==
X-Google-Smtp-Source: AGHT+IFk7AASUlgymkD/G88lgvQsTAkBAYnM+YVX+xHj/hQ3x0n0nkYgMDyEVMonARKTlnNwZyS96A==
X-Received: by 2002:aa7:ce03:0:b0:55c:8358:73c3 with SMTP id d3-20020aa7ce03000000b0055c835873c3mr897723edv.11.1706008768450;
        Tue, 23 Jan 2024 03:19:28 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e5e9-d5c9-698d-8bd1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e5e9:d5c9:698d:8bd1])
        by smtp.gmail.com with ESMTPSA id fk4-20020a056402398400b005576a384b46sm15230791edb.10.2024.01.23.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:19:28 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 23 Jan 2024 12:19:26 +0100
Subject: [PATCH] iio: move LIGHT_UVA and LIGHT_UVB to the end of
 iio_modifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-uva_uvb_fix-v1-1-5b9c25d50d90@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL2gr2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNj3dKyxPjSsqT4tMwKXfNECwMzUwtTE0tLIyWgjoKiVKAw2LTo2Np
 aAK8Mi0NdAAAA
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706008767; l=1301;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=C6BsBKcktkP97lGptVkgfZZi4GPR1FFiDYW4JzJCj9s=;
 b=Yc72VEqJM5zrpEqQmsV8U9t1eA71cJlvBYw0KeffmBNNAyCCQ7SGD+QWRUv9k0hhKwR+A/ico
 ce1zmXYwZtFAhamVfUBwzkEag8EZoQcKAMtSJhtpTzPsIZbG5gPMgIY
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The new modifiers should have added to the end of the enum, so they do
not affect the existing entries.

No modifiers were added since then, so they can be moved safely to the
end of the list.

Move IIO_MOD_LIGHT_UVA and IIO_MOD_LIGHT_UVB to the end of iio_modifier.

Fixes: b89710bd215e ("iio: add modifiers for A and B ultraviolet light")
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 include/uapi/linux/iio/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 5060963707b1..f2e0b2d50e6b 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -91,8 +91,6 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
-	IIO_MOD_LIGHT_UVA,
-	IIO_MOD_LIGHT_UVB,
 	IIO_MOD_LIGHT_DUV,
 	IIO_MOD_PM1,
 	IIO_MOD_PM2P5,
@@ -107,6 +105,8 @@ enum iio_modifier {
 	IIO_MOD_PITCH,
 	IIO_MOD_YAW,
 	IIO_MOD_ROLL,
+	IIO_MOD_LIGHT_UVA,
+	IIO_MOD_LIGHT_UVB,
 };
 
 enum iio_event_type {

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-uva_uvb_fix-7a8065854992

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


