Return-Path: <linux-kernel+bounces-130396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CAC897781
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3FC1C22143
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC3152DE8;
	Wed,  3 Apr 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKUDUQv2"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF5152E18
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166895; cv=none; b=a46EjBIaZaDE72Rifb2WwObxxaZbGTKeDg5xNHgu32++oSkv7wdsR3UDWG0OuuqUuaxlN6n/p4tFWwdnJE743Gfkr+QatcetV/oSfMyKpWbeVkTTnCaiVuHGgDyjejTtw6JjtvMP7OxvaYq4LkHgoQSV3HPzL+q6F/1PqRAiMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166895; c=relaxed/simple;
	bh=/0XZpuV90cVbdOdKNn9mw9B3D5Yw88DCt0+hoxD1w8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p6atJujqEU9H8U1s37Pe/0o7vqH42t3pgkbr3Q0taU9863Un8Hqw6tAj3m9ea5hhg83C+vguiDX25OGq6utqNRxZ9tuW5/51bb1RCXIW60gY60HC59WKSMfJoc29YdO/LedBo4gfe6llgy1GOQtvl+9s1rUtaDOwSiYmXpvv8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AKUDUQv2; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a7c3dd2556so84495eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712166893; x=1712771693; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xznWw54FxaWloYVwfy+4qqRxy8SOPUqZEYo49dH5RKo=;
        b=AKUDUQv2DEOSQIOLriVgSDwFKf0jsor5tQ//ylMHF6LDTWX2CIwYOvCOFGfgtDUa7i
         D+NJ8wASjGDR25jGsd6+nYHPBvzXTS0dLTL55a+sGsNMhipymEGqXiGljltYLKsqfIdP
         jr/khxZAYxnTjU3hi44FaxyXoKpDn9QYT6ivQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166893; x=1712771693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xznWw54FxaWloYVwfy+4qqRxy8SOPUqZEYo49dH5RKo=;
        b=Yhy2NkTORdzxvUUVJZXEKjCsjsYh9BdOwABbt8nKd4LLV6RcO/I+1GSvziZi3LMrxs
         SeGHAihsXE1ANFswsEtrQaWq3ajYgCJn1OARamBhhSUffvBm2mOpg+yTBrrfbA63OGw3
         UHU8WhFg9eujMrpankF/Z8OpCkMdyxDoVx6IMY/AbWaTvWHVhKYGa37ydDeWa6LN4Y0w
         h36Yjnq9R/SIM2Qqo2Fe8skAaPvoyJxthTEFfMaSNx/Hn8tcbFSkRlwxEmOpvs2bXg6J
         ARhdl2OolCN02nYZOGWIwxkGNY1GrZ1eYaJYDzAi/cKxKeS/S9iwN1zV4u0yjkz5AkZe
         MvQg==
X-Forwarded-Encrypted: i=1; AJvYcCW5ifZW5AAWeWJBtlFYpSmGzdUcESCzxtcmkssFUl9AFbpw80D9++ocV1IRE+7MSNkaRoBk6ta+GiAx3fZ72fE6cN7ibT3jYXnlpWtn
X-Gm-Message-State: AOJu0Yx0+MUZFG1sXNjvzN7bP03wrcYoo/iAgiC7RLbNL8NKEZHsQpAi
	qBFVzkw68oblcjEzeeJWNh/XM1lr0sCQsNgsPXazOTgUja7HxjOJV+9znX1j9A==
X-Google-Smtp-Source: AGHT+IEkOvzpB3sS1GOMdYoTNTPrcUJQAqysOJCExlqcM5uAzvObmKgFti8V3JJ6lg7+vtgEa+c+AQ==
X-Received: by 2002:a05:6359:4c15:b0:183:8bc6:82b with SMTP id kj21-20020a0563594c1500b001838bc6082bmr3498716rwc.28.1712166893093;
        Wed, 03 Apr 2024 10:54:53 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id o13-20020a65520d000000b005d7994a08dcsm10509577pgp.36.2024.04.03.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 10:54:52 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Date: Wed, 03 Apr 2024 17:54:51 +0000
Subject: [PATCH v2] usb: typec: ucsi: Wait 20ms before reading CCI after a
 reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-ucsi-reset-delay-v2-1-244c175825a4@chromium.org>
X-B4-Tracking: v=1; b=H4sIAOqXDWYC/32NSw6DMAwFr4K8rqskfPpZ9R4VC0ocYqkQ5AAqQ
 ty9KQfockZ68zaIJEwR7tkGQgtHDkMCc8qg9c3QEbJNDEaZQuWmxLmNjEKRJrT0blZ8WVddtCn
 K0llIs1HI8edIPuvEnuMUZD0eFv2zf2KLRo32Rvqak3KaqkfrJfQ89+cgHdT7vn8Bm2r+m7MAA
 AA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

The PPM might take time to process a reset. Allow 20ms for the reset to
be processed before reading the CCI.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
The PPM might take time to process a reset and set the CCI. Give the PPM
20ms to update it's CCI.

Based on the discussion in v1, this should not slow down existing
implementations because they would not set any bits in the CCI after a reset,
and would take a 20ms delay to read the CCI anyway. This change just makes the
delay explicit, and reduces a CCI read. Based on the spec, the PPM has
10ms to set busy, so, 20ms seems like a reasonable delay before we read
the CCI.
---
Changes in v2:
- Commit message updated.
- Link to v1: https://lore.kernel.org/r/20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org
---
 drivers/usb/typec/ucsi/ucsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cf52cb34d285..c0706c40fa64 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1280,6 +1280,9 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 			goto out;
 		}
 
+		/* Give the PPM time to process a reset before reading CCI */
+		msleep(20);
+
 		ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
 		if (ret)
 			goto out;
@@ -1293,7 +1296,6 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 				goto out;
 		}
 
-		msleep(20);
 	} while (!(cci & UCSI_CCI_RESET_COMPLETE));
 
 out:

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-ucsi-reset-delay-bdf6712455fd

Best regards,
-- 
Pavan Holla <pholla@chromium.org>


