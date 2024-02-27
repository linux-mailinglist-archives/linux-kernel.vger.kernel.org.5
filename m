Return-Path: <linux-kernel+bounces-83587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823B869BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7B7B2BE3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28561487D1;
	Tue, 27 Feb 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcwiwShZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E914533F;
	Tue, 27 Feb 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050838; cv=none; b=rUwyKSw6lI7b4uZGlsvjOppix0jBWg9HH8vhKKCf4fGVMcWHahFU7yvpVg/pME6l0kAUg8Rw79pPraUnNh7gaLgp0t4+VG7JDljXH+lLOCQ4oNgTWLFNIvZUQJ+83apfGR0NWW05Z2NtW8qkfjYnkCABmMpNUBx/VVUMIRbsf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050838; c=relaxed/simple;
	bh=f1dOGf4oEPKD8SDOcyy+wTaJKf/1u0rJC5LBazG+6CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIFGiZ8amoUUkIin6QD6ovDGQVHIWyqdnoIWW5rYcEFAAfqe7s8b+qJNRevOQCKg1o3PhhzJ97nBpYifp0QIohcmHRYH0OiogGnV0mHFclZQzg/fXZ32eMNY8n8s3n0r3DIGJHobZ4ZlzSx0bAlFzRuXVbGjOeChWCDN112rprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcwiwShZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a43dba50bb7so34243966b.0;
        Tue, 27 Feb 2024 08:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709050835; x=1709655635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rblIe8C24BLIjd2N9icjdrJeQDfsXfyKi1YUnvpRTLs=;
        b=KcwiwShZvyNhiMeeGoSNeE9t2y7WcgIAU36p/KQAiadnHspm4ARUTqm+XlXkeaZs4g
         uVrUs41B2huL72rIh2cM2x2w0z55gRzeb4lwyKaOVjsNBRjLOfpLIEHznmggHv4FqpAC
         U8YpG9daJLGIQuHQ1a9AwRm1PtPp0onT24eFax46MtkMNO+yFIAfE208K3+ThBp7JRri
         C5u155s0fF3QXg8C/NPDB4XalTsp9P0Bz36AyEStbcCEOJLvR0TNN3Zd17EKkoH+gDeV
         3gNm6KePjB8Stxu3HP5AjRgL+z9y5xcF1xLlG754U9RfUTc5UJ0f+WUr17SlUCW4X9oz
         QyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050835; x=1709655635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rblIe8C24BLIjd2N9icjdrJeQDfsXfyKi1YUnvpRTLs=;
        b=ofB4AyR0NM995jifJ9tBVkpUB0gK1A36ZeK+ITGvXXkJAfRtQ0Da2oh3mR1K4AtEOU
         NA79xVyA/vG9HnahCXDf9orjkl9KnxNwhTr4YhDS9ZNVqFPtR1JzUg4odGvEenz5SFBj
         9/o2O2a35IJFXhi5y2HDAmvpZmXw7fOh0C1K39Kb9LpZvxynBRlT+pSBQHGpYW9W6OEd
         e9xxIncm1T9qKkECwTybkx0ajTfUvrmU44u8mBLmL3HMQpHx0HIZZdnEDqBOhpd8PG6k
         UNDRfW0Q4fdSCWD7EUqFsJ+I5Ie5hEd2gJx3apBHoM1VCkbHT4Bd2RvN59uglkbTut07
         h/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9QAEjIwjrk8Cm6szXlJj776TdTPG2xcCYT5+C2PLZs8NRvO25bEHbBv+Wk+b8FCAC2ED2tbtrG4fzwGho25oRn89wNizwGDE1oF9vyoniYN4FS32xgFG7IeNDG3XxAiB1ul+9bQlk7Xkg9klC8IGlIFKrrky9SItVTuVGHhXLL5ZKBw==
X-Gm-Message-State: AOJu0Yw/AChfpnobR5CvnD3etglpVO4YqhQi7fCHbszyw5UpZ9B8dnOI
	hXW0lSjA2PpA6J2IRZ9f4GwWiHUwbduZs0VZPv9bT8BtsLxXmQQy
X-Google-Smtp-Source: AGHT+IH+LjH+gYJqBnAEdGV0u4Iaeahr4c8BeTSrWbkUN6zVwet877/ScQPIz8d7m0e2hWI7W0Ui7Q==
X-Received: by 2002:a17:906:8ca:b0:a43:dd85:e171 with SMTP id o10-20020a17090608ca00b00a43dd85e171mr331448eje.69.1709050834631;
        Tue, 27 Feb 2024 08:20:34 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id tb25-20020a1709078b9900b00a43df459013sm107570ejc.131.2024.02.27.08.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:20:33 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ansuelsmth@gmail.com
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: qcom: qca808x: fill in possible_interfaces
Date: Tue, 27 Feb 2024 17:19:27 +0100
Message-ID: <20240227162030.2728618-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QCA808x does not currently fill in the possible_interfaces.

This leads to Phylink not being aware that it supports 2500Base-X as well
so in cases where it is connected to a DSA switch like MV88E6393 it will
limit that port to phy-mode set in the DTS.

That means that if SGMII is used you are limited to 1G only while if
2500Base-X was set you are limited to 2.5G only.

Populating the possible_interfaces fixes this.

Robert Marko (2):
  net: phy: qcom: qca808x: add helper for checking for 1G only model
  net: phy: qcom: qca808x: fill in possible_interfaces

 drivers/net/phy/qcom/qca808x.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

-- 
2.43.2


