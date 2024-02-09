Return-Path: <linux-kernel+bounces-59520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0A84F84A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9627B1C235F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5106F085;
	Fri,  9 Feb 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sa2vrYdZ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1569DE5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491665; cv=none; b=EySTVEWtNCsahsf3po8TIayGpDSEabjfVGwKWYhY4qvwyL5Hw55YUdsx5oAaPlT0tw3Lq7n40xUVfV9sR2hxsBRfZ3L3f+ergUAbQb8hiFiga6F0mNcLDGMBs5l0TbOnEwN0aMYCydP90F4VwJQAaNx/N3kn7xoa7+vYliUjb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491665; c=relaxed/simple;
	bh=JnQWgOa5RsKDLidoGwqHhBQEnjeKf7MhKMdfRKVLKYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JCfx0gFx7aMmYnMqEIKvJ80gEFW1fxEl/2UGOMyXWIlef2zdePV0BhJjzRsyS6JVtfMOedB8YXSx5fc1rDP47aV/lrpmz2uNEhGSVj3L8Ele9WU71b+IKpFrVhlyL5gHPQGdC93xSNxSGEUc69s1g97vG0Adi8s/XVBgNKQH5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sa2vrYdZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so1524037a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707491660; x=1708096460; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssqSDwTHA+Cg2ijKB5pjXoS992iHVcyLNIc1aZBV/UQ=;
        b=Sa2vrYdZk0+AltfAYcoM1y+ILrLWI8DtlALn953YzoZhLvqTzkZaMQh0HBGsYp2k8C
         6lLVJr5v8qdupSDvImDp32HuFjTINoBsYdxIYVvCbPAanQgzGlnSfL2ZzccCKbsnd1vx
         Kq3ej4cPygn5PbqKDviPcbFFubK93WSHzCyYOoRHrP0eD2DZAImM4TGmIkCJVv87wCHz
         DtWyVT/6b50f+ewHv4hG0dlGUYjxz67wJTjw9EnqbZDDrTGoGQ7a4pc9LdN6xPNgpovu
         QczPq1LQgPYuCj/gHMjo+b0vEkjTqkRpVCq4j1M+eSVa2+TAf2g9WfNs5jaY5sf8q+Kn
         ooiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707491660; x=1708096460;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssqSDwTHA+Cg2ijKB5pjXoS992iHVcyLNIc1aZBV/UQ=;
        b=BC3ILEjmTViCSw0KI1sVVIOjlMlTGakfVfupHv80/XghQPDOnEFCRwXu0erbPuZ3Ae
         GPjWSJeuR+ggBFOTEptoHgVhqqNJNZ8F/nPbTGS/G2AWFfGMOQiwJUAXMvp1UEhYOfJG
         1J5vu1BTtAihXaCfdu2JSnbQmecP/NYHKuL8mJrIXKQbq2ngFfvTaTQxLTVuMdogCnhX
         qXzThwHpGfY9DNh8PqZI8Ktv9GEI0LZvEo5QZWwds9mGaPH+PuAi/jSP9VmIMqzDp6oj
         XgBp3Nw3yBaBFZL9d6AZnABYAZ2Bn0hTqqdrWuNX7OcaBrACzw2QrQWuEq8lgCsLyrXS
         7MJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSiMF+i4ifcgKmjpnmFRTJoNWRgh49u9YSVt9LT/O0zcO+LRPzU5W9XrfctQfCsM58LanZ6+IyUl6snHZacUAHRnKEOzG/+OQyfalu
X-Gm-Message-State: AOJu0YzKvm0K154tEZQQY+mOVEoBj6ZHs27FEsX+uSkGyE/AWW39qZlv
	EQr2E1bUZBfKibO+nCEYk5VLI1pw8gwVo0CXQBuV9GxSrBS/4l24b3bQn45IRFQ=
X-Google-Smtp-Source: AGHT+IHu9PVQg/r3sWuJHx1k2qkljpt+JWg2pF6vB0xvRGdbHye6OBmqU3LXCloNZ8Tem8RH0C6CTA==
X-Received: by 2002:a05:6402:5172:b0:560:1c4:cb31 with SMTP id d18-20020a056402517200b0056001c4cb31mr1769965ede.17.1707491660328;
        Fri, 09 Feb 2024 07:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmZi9YsbyFKpWiZF4EXJr6enGQRn8co107vnc7hb4OYlCmiE4G/sQCGNg3B0WgqNPmQw8MkwSQGzK8cWdouIv5MedArdXKISw9tRbzTsTEnL47/a7m8HQMskWg06/CLDm5qGKJT/hSfzHG0PRDOevZjKwaeDh4s7FUmbTa3a4KWyg6A6uF7I1fRbsDE1anVtXsYiGNu8x8GjqoYbN27J3ZlipLfx1tKxSzqudwO7xonA7Y98S62U6ig6zQundfkGpJKNAQNnxcfr3c0xVov38Vh7r4iHt3UFhcYBvGYC8euYAz0KHx14VK43Z/Wk1t2LJXYe6Pt/arKH3+b7XA6rwNzlUzQmDLhm1mRcTFYGpiuHz80ShKE/lmk1GANu8hRziZP4+a2Q==
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id k6-20020a05640212c600b0055ef56f4575sm860240edx.39.2024.02.09.07.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 07:14:19 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] phy: qcom: eusb2-repeater: Add support for SMB2360
Date: Fri, 09 Feb 2024 17:14:08 +0200
Message-Id: <20240209-phy-qualcomm-eusb2-repeater-smb2360-v1-0-af2ca4d95a67@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEBBxmUC/x2NywrCMBAAf6Xk7EKykSL+injIY2sCSVp3jSil/
 27wOHOY2ZUQZxJ1nXbF9M6S1zbAnCYVkmsPghwHK9RojUGELX3h2V0Ja61AXTwC00buRQxSPdp
 Zg9NLnHW0FwxnNUreCYFn10IardZLGXJjWvLnv77dj+MHSpZdtIoAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=JnQWgOa5RsKDLidoGwqHhBQEnjeKf7MhKMdfRKVLKYE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlxkFCjPFNGqQEAHDMm8un4UpzIPoMi/I8tkss3
 P6g/EWAxs2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZcZBQgAKCRAbX0TJAJUV
 VkwJEAC5puaTIct3iYSEkrfTs/4Q04IUUS2TENsfwEEq39VB0Znx7YbU4aMr68tgNt4eVTLtRy+
 aCqGdYGN1TCAHHn4VutMZLuh2tbzKwTtWUga8XGCDknU9hdZSrmiSI8z69eg8Qda4AW0CVWWhtA
 6RpCH/uRyoaV+M0pZQZOvnRn2O9enAwM52BCryNx+NyyZHUGa8E7+fYPuYe89oPUlE7MB2XRjkE
 w97PvUNwRMJabXmdbTcvBwZblyP1x4Vi+nBWs/4AjEEZ7IAbeoS27AG+C3gp020VCS13hTWuOfP
 d8JkrxTMB73pvnSXcsEMvo9fL6l/98LPLQon/a5XYuNxE0AaYXdB0trdS6WA4PzYwWeTfZbagyI
 JCEtBTIA06tjEYZknf+QyLL9feXyLczCSrZRgnimIp64uWobxZbIeQ7jSMvRY4WGniBXZgAUTBL
 2PtvRlPGUlmbC6aYl1ZzavmmDDtzwOj36q5raxkTPcmrmkMlnUd2Orn33/1hcsIx1ngBS7ftbfh
 BelVrvQUDjj7Y98Zz1UYsF7c9lpsXjP3DHYqOz8Ko2yn8M+zryURDlTQs0T140stp7g+kPq/dAA
 e+AzKiU8zAxa3hGhnOEoVL1m6bpJMbkKabmdJerSmx9j88zxyPOQclHNBmS/MkKNIJj4B6v5RWl
 5nkQ1urMr/baffQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds support for the eUSB2 repeater provided
by the SMB2360 PMICs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for SMB2360
      phy: qualcomm: phy-qcom-eusb2-repeater: Add support for SMB2360

 .../bindings/phy/qcom,snps-eusb2-repeater.yaml          |  1 +
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c          | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20231122-phy-qualcomm-eusb2-repeater-smb2360-a0fd60d382c4

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


