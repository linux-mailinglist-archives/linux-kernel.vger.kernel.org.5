Return-Path: <linux-kernel+bounces-123616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F408890BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26291F28770
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AF13A405;
	Thu, 28 Mar 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJnGDtUs"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23127446
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658758; cv=none; b=QuiYdpiZc16PDDUxGlv+lWDK6SJlYteL2kaGV99e7ZvDrcBP/BqEMKfJqCv1lm1c4luDSK19gCGO+U/i+68hkvZDwQOnXyWEHPC/c3GkjTzzD216M9Z4trhkOTzpz3ExKupTz3bhw1gnJlw2QY1Jy+chgDLDHT6oXTVpO5u8jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658758; c=relaxed/simple;
	bh=fft4OrHAz+FhYU/1OtFhOBCY8wS5s8+GRl/vDm+Mp+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FRT1JgrmidycgEJAuCuI7wTDMZ1tKVAFqQMmcPV45LxiVjWtOn6cXRrodrrP1PZV2Kv2jGLg5hxJaJVmmkkTVsnzZ2Z6w86bU7ZiN/92vpaQgaYAqkHArYlrrHjfXBETWVBIUEvCNGKsOw7tuCepWILrZAj/pbB6FGQcGST0a7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJnGDtUs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-415447b16aaso7575045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658754; x=1712263554; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHCAelpDeOyTspvDhIg4gg/+myzVVV+bdN1gr4pqQRs=;
        b=QJnGDtUsI5HYWzbHOqFhtYF/x0eGYc7ZBn3XKt8w3dAc/Djf/KrfF+0EjFaNosOFmj
         yJNrKatVBZHibBOh6NPe/cvleJFEN92TTOtCwBTJrKfeEvo++hoMft7HX8sNy75NGIBW
         1PIPXG7XXL2IJa/dS9Au8HRWu8ut35DfTGnpZg2UT7IaqMMhdbPufWcuduRVZD+d8r/n
         ZHJYh1tSVp6z9VLhUDg7G6IvhvlwwK2R/FZDjcUfnkfvxqjxWjKkopqTA5Q4KrrzWYAj
         kQROMlEx3JTGV9Rj7kyhqxrYAaSBzhxntcxUi7m1JttIqVlEu5nuWwDNQJGs5asmoO66
         n1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658754; x=1712263554;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHCAelpDeOyTspvDhIg4gg/+myzVVV+bdN1gr4pqQRs=;
        b=GsB8ePQ0set0dvlKilBb2jx2yzcvpCvUNw13YxnarCHWev2V77U60eV0+BZBAKiAos
         I6EnAI93vnXTr0xR0vHWK2XYFxdD4xNqxoNaWhbVwb/+WdmJY9yG9SUJ5GlD+nN+JjCd
         2J2Oh7sbW4ObQmK1P9ro2HN4SMSVjGXGW2XZogz8eUTSVk0ROGC5SnR/7M4RIUzkwqib
         ZOa8liJLYAM9w9K4WZXxlNijGwyF6s839K+wUV3XQStYQ+GxCinowtlR5AzJZSwgl2q5
         BcGfFTUzOvUVmEy4L7HoR/TPAJYqsgLmmSS4wAjZiAoRpTGl7QzUauAbB1kCNpDzLTvu
         hMKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjvYpfBQXdqK6y+pxZl4fB8ib10MiuSS+Fj1QSUc/6XhiZx7d6Uy8TAiCju1MJUseAq4FE3gI1dyZu/yqUysisvkl3SsidqDrY3oob
X-Gm-Message-State: AOJu0YyF6zeWwicZRilorr9u30FAWHL+ajbFn+4pmrw/QelsLS3faapR
	fZ6LZkDhmx+Pu6Uz7YCYR6y6uogW/Yc1HB9X//96D7MrfrcUp4DpYb1LbVEBPR2zQPzfFMIfUMn
	s
X-Google-Smtp-Source: AGHT+IGx1i0glEArl3yYP+MeF600L4ZFfhwyYRmYb/OzKbGsp9z3rF9xSa5fs69ktTjLjash1eKRvw==
X-Received: by 2002:a05:600c:45c7:b0:415:4b56:362f with SMTP id s7-20020a05600c45c700b004154b56362fmr324635wmo.15.1711658753935;
        Thu, 28 Mar 2024 13:45:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:45:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] scsi: store owner from modules with
 scsi_register_driver()
Date: Thu, 28 Mar 2024 21:45:44 +0100
Message-Id: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjWBWYC/x3MSQqAMAxA0atI1gZqtThcRVxojRrQVhocQLy7x
 eVb/P+AUGASaJIHAp0s7F1EliZgl97NhDxGg1a6ULmucChw8+OxEvrLUUCxwlhnNtclGTPYEmK
 6B5r4/rdt974fGaQk7GYAAAA=
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fft4OrHAz+FhYU/1OtFhOBCY8wS5s8+GRl/vDm+Mp+A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb6jMDSW5dTJ22j6xYqakqZzsHwKgnbk9uwj
 PSYItD1XvuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW+gAKCRDBN2bmhouD
 11k9D/sGG3YkxmAJvcaSAMR5xVP3k/lGaPgRxbgGQCg7Bh0/7txnl+h9FQRmhLGh0zfBt+KqEgP
 +CD7p8izNocjR9sh/likMTI/JHNgOpllcdw4DuSzICBeO24GJWokHJO2OmjEHqPc9/VnJKYsIju
 y4t10LN//glAlwPFn5zIFpUDVLin4WEFy1vzH4VcCUTt8vkdAhFVgvIjh5vXMwUXJf+tEiz1/Gn
 QUtyyGIxHeYfXqxqrGi39Gfxy+BVbyJKmT2TcLKocWBB8K/XnIgRyj5oyQ0+7eHuHPtW3ITzo2U
 ssVmmcgDhelq70EVyIyNFXoYfik6Z0I/52Er5lobA8jVLbkhQv4eTjD+NR9Z/cVQ07pX/EYVyjN
 ngI9nf13TgAopWw1BkNFQeI7BJH42YuHCW1VOJvKSMfljIVq7YEaS5qBj+H1Kd1Dl01aCux5JBT
 CyPhTJxRe7PCqJFQ7ZvA7aw8sVf+eTmMwARbJMON9kG/d5pNEMEW+aHQHa+ux+xvTqG68+aC++0
 TxQfIvSs3Yb3nNKgUWivnpIUxb3ItuBeM2j3J1xHgxTS3tQJFZfru7JSaXP09iDgoL/uX7yc1rX
 WzU8GYF7rBERjjc1Yqe5Cd1OCi/6E8cieqFRI0vF3hnh1jssVZkEResWRuPOirBGb6Yj99KIW3X
 rpnEzTqdDLKrSCQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first patch, therefore please ack
and this should go via one tree.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      scsi: store owner from modules with scsi_register_driver()
      scsi: sd: drop driver owner initialization
      scsi: ses: drop driver owner initialization
      scsi: sr: drop driver owner initialization
      scsi: st: drop driver owner initialization
      ufs: core: drop driver owner initialization

 drivers/scsi/scsi_sysfs.c  | 5 +++--
 drivers/scsi/sd.c          | 1 -
 drivers/scsi/ses.c         | 1 -
 drivers/scsi/sr.c          | 1 -
 drivers/scsi/st.c          | 1 -
 drivers/ufs/core/ufshcd.c  | 1 -
 include/scsi/scsi_driver.h | 4 +++-
 7 files changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240328-b4-module-owner-scsi-91c327e55bc7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


