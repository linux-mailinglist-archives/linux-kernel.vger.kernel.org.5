Return-Path: <linux-kernel+bounces-70462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0F85983B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401521C20AB8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1D76F08F;
	Sun, 18 Feb 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FNdkyg1w"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8E6EB7E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278120; cv=none; b=bZ1yzo5KJZEygoRqhxgp3/OmkCAQ7mK+cJjqJdpacvNWtGdbcjT2E4wXITyACDgQUKdyJK/4uW9f+uGGeHFBJeD0zmCViAEgYyokQsg16IRRt4OD9HVbCk9VFXtMa4tIh47rSL/QFyH597DtVfRTfTeZUYfnDzayIg5ShCddn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278120; c=relaxed/simple;
	bh=YoyxAta2MOYuOpk7ECI1JLQRZtkhDMBZ7yhepOk+g0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2ZJUl3QLxMiLa9UR0EjHMY6NfYjNEXJEZWIMPAa+TOVP8Mt+6haDI8pbL9OI1SGTwEhECs8JgrAayiHROkw19KwYbafc7j2uweoCpFTP9JeTBqApxytQLZl+Br11kSnxzFYkWr300OLtBTG8gxHBHDppB1Sw6ClLVmkCaTqwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FNdkyg1w; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e4765c86eso91690266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708278117; x=1708882917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpi6uSrDzTzKIp6zIZ44/XNN4JX5iPXekATyTBKohTk=;
        b=FNdkyg1wVTuqbjFI6MqHygw5ZZl+AB1RBcK5NLWj9psX4swkuDE9Kw2ZVj4PPhPY51
         f1vshPexOmRsthRZa1JauhXfFox2CK244sKW0fXo0i8SJ/QLBUPsAz7gfc7Sxnif6iCZ
         rHATjioVMVMJM6k9o/vmxgz12Or+NIdxtoWsrKEm5RY4A7aIBGtH7uxdiKDWmr1Tk+Bh
         GxRP1sMzStygylr5y+ez7RrPzDwKSfgOzZM1nbmNdBiy6UXgWJkcY9AufHXu4WxxZT6E
         rxnKWJWVqQjbCfyW9IE4yudlo3DWp6sIR/OEabVqfBlFQir+VJZhLzIzGn6ZgiCKWcSJ
         iLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708278117; x=1708882917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpi6uSrDzTzKIp6zIZ44/XNN4JX5iPXekATyTBKohTk=;
        b=oVu42zVETcCjC7L0baFnW6qzGWDwHFIP4EhsL18h1Be9+OydZdHyCpPXzztjY7TkUV
         m9uH4/UGQ0xUIyikHCVwN+b3mI+4jBIVaYSQkS3YYqhcSpYFTNHJrtP+Qwqo13hY+5B4
         GHJnh8IMntXZaoc//pUUhvSOBq1HXVEt5pSqfMbCol/iVEFziE0h1Qg+HpSxyXJbQnUj
         8w8bJF/6P1WdoVdmXB4UIyXTjhrFwU/AOfM/JPMhUp6oYIyIWPBoZi+V4RNbOR5B0uo7
         lPuICQAmOIAR8l8zfXDMLQ4skADcTho3Wlpdk/V0ic4wFGzhA1VqrpXK4ckzO9SJ882g
         xkQw==
X-Gm-Message-State: AOJu0YxHxVNjekWJRfvYfhQmbU5yCHhrcGC48T5CKBKG48gqMAbSWN75
	MthFXzy8BaRtIq2QKa16q1Cyjnnor4Z9qrKl1e1Se9VM5rHdhHg0
X-Google-Smtp-Source: AGHT+IEZJjiygB+673niFbajrVGdnP/raflzAUmK3e598700aY1U+rBSfoed2PYbcGRrMxsete5r+Q==
X-Received: by 2002:a17:907:100b:b0:a3e:876d:1b1 with SMTP id ox11-20020a170907100b00b00a3e876d01b1mr785387ejb.20.1708278117496;
        Sun, 18 Feb 2024 09:41:57 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b37-4900-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b37:4900::e63])
        by smtp.googlemail.com with ESMTPSA id r16-20020a1709067fd000b00a3e88f99cf1sm412710ejs.149.2024.02.18.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 09:41:57 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andrea.merello@gmail.com,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/2] clocksource/drivers/arm_global_timer: Remove stray tab
Date: Sun, 18 Feb 2024 18:41:38 +0100
Message-ID: <20240218174138.1942418-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
References: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a stray tab in global_timer_of_register() which is different from
the coding style in the rest of the driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e1c773bb5535..8dd1e46b7176 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -411,7 +411,7 @@ static int __init global_timer_of_register(struct device_node *np)
 	err = gt_clocksource_init();
 	if (err)
 		goto out_irq;
-	
+
 	err = cpuhp_setup_state(CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 				"clockevents/arm/global_timer:starting",
 				gt_starting_cpu, gt_dying_cpu);
-- 
2.43.2


