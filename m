Return-Path: <linux-kernel+bounces-78502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463486143A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B083D2858F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7384FA6;
	Fri, 23 Feb 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9nFt6sd"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E208F44
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699090; cv=none; b=b8hnxu4p74eBC0xXAyVia05EntAfgpzzgeBzFc+VUcvW5CpoYRtF4qWdXsAr7DjHZhplN5Ajndmlp5NnLyIcTMaZTv+G+ZtKQKyMNgCW0aSjfL/o2svUxA7I/nO+NqOLMZemFKoqgSBEyMTIjm/ckzzb8b6Q0PkJLVinsNxLNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699090; c=relaxed/simple;
	bh=Vru7Abk2Quxk5CLTZUtZy/YG6VNsSxUg229AHrVS6ek=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t8unQpyJ23vfzYfTyghMZPWTFB/g6OOE/SC0ACFlx60kD71nwtVbswUZFrduNS1ArnjSt/UIQGBPMPPnr88DYegBN4gYpLSNEkUS/TenZu/azpbjoa6UQXWP6rrVevS5REu2K31An/xbUOvbOqblYkEs5MH+XvfV5mMgv9DzWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9nFt6sd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso1362859a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708699087; x=1709303887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vU2SpBrEstlNseIoIBGcYhAQw5N3Vp4LBcc0YegFqk=;
        b=H9nFt6sdHBE6krc6RWLG11mJVXfVxroP+/a4QABc9SklynjaR4Cv2woT+MFrrHb/He
         l5YNvksB45H3rdhplSroflNAoCkcv44aVz0D5hcigFg5TonHPOjX8DH/TT7HJfyD4VO2
         kyqwOW5up54NGaK2Vd4mQiGN94p/o37GqipXMbwsce3g91Ga30G2FNtmNXAqeV1UhEkp
         nhBdyl/YS3wxlCIp3KTF9d0AokSdjZLdBco447FucVESriYKv53VN8NPGDmaZFH3fWl9
         ethNalA3MR/uEOVeT5XM4WAVItWtqkCvDbbhQ/MAioQGlEjwSzOohXLwOHVQYOg37QbQ
         YAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699087; x=1709303887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vU2SpBrEstlNseIoIBGcYhAQw5N3Vp4LBcc0YegFqk=;
        b=kg/Beg8+C4pM3tVvv0EH6DjuTIEUZWTPkPBJa528iw7FYRvoz+aTkbst2P912HVjz5
         K917AmtvFsWdNgrAsUedVb4zn9RoK/GuojLwFKZVK7oPD4vGXHf8pVNodYc1/fAGxgyt
         WQ6EVMRT/NfqKZGZIl4lGkZ5TyM0z+H1nE5pun8/2ElDDWwoK/Tsfy469pOc/COANMDV
         6Ne+gAc9t4Yzd1ajW4D+rrmixOTtQpPCuhbZ9IDk7CcZp5EDCnVYPlZx5fUG0qrY74R/
         ucpIOr3hp7xUzgqZOqHdOChpUlvjAYgLs6DPEst2m4R8/YqPfcBlP/AxNhHyPpKot4bc
         R+qg==
X-Forwarded-Encrypted: i=1; AJvYcCV6mEnVsg2ZhTtg6ZZFtxumQJHhagwp6L9AQfh6oeWBJ7RLi5hejthOZ8w+paHE7ZpMNf3bqi8B6hxB/YsKpcpwLAeMiVZezNc2vcoS
X-Gm-Message-State: AOJu0Yw3vErxg4E5SHCI6iSgD21UVY8k4oPAS61E29VB0kz6ZaYesvq7
	wAJYP/9knjOkHQ6CydfS2kz+VZ/94w2guGzWJz8TwVnDJWdCc9slafsg09sHEWg41idfkpXiOFo
	Y
X-Google-Smtp-Source: AGHT+IFnpznVQpvUYFFMdw+27KJQjQ/vWqkdjsmfve63Dq0te1knoCvcTW74cSudlFStansZE3VTjw==
X-Received: by 2002:a05:6402:5151:b0:565:7b61:4c82 with SMTP id n17-20020a056402515100b005657b614c82mr18592edd.5.1708699086719;
        Fri, 23 Feb 2024 06:38:06 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id p27-20020a056402501b00b00562d908daf4sm6637536eda.84.2024.02.23.06.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:38:06 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/3] soc: qcom: Add X1E80100 platform and SMB2360 PMIC
Date: Fri, 23 Feb 2024 16:37:54 +0200
Message-Id: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKt2GUC/x3MQQqAIBBA0avIrBNGjdSuEi3CppqNhkII0t2Tl
 m/xf4NCmanALBpkerhwih1qEBCuLZ4kee8GjXpErY2sihwqRFlS4HgkiZOxLkwe/WihZ3emg+u
 /XNb3/QBjRBnCYgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=661; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Vru7Abk2Quxk5CLTZUtZy/YG6VNsSxUg229AHrVS6ek=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl2K3FG5wQvJwdlDoXFtrkc5oX6uuyIvwpqxiuR
 DR6sb0zbWuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZditxQAKCRAbX0TJAJUV
 VvxLEACWHiPJDlO/QaowYXUyUQTW76l+u5BPo9yBKxOmcNJKp7y6t2cwj6sBqohMEKETgbcNwSU
 fJi15Nsrnb8ZN/23pNzUICFRz+k3e1HkmEOeF65xF9nPcyHONq9EeSpG4EQOhT15nKHQEOWpzgX
 GxYS+LBTBZSE9Mj+e6ZmaxnnQ9cGnx4fAvpid5zdN8dCtGU//s5+U1Q+b5PaQeboAUHYV3j3hsa
 Gl7uzXJz0hhEj0yeIn1U9VQVxc7CMD3zVCvyHm446Jmu4d2/xAVSx3CvRqydcbWzZzx3y0Qcf7N
 LWcIkBvlg3ARwTwJAFn6CXMp0mPcCCJ4+CvmilzPHlWwR4sk2Eqk5HQzeSz7ZUu649p3gZEslgG
 ghu9gSIkhP6jD0Zmkw3J9UTGUOAOxDgB5/ViDxgz5U1CZFB66UakU34AXx9PgtHAnfOHbgcwUXL
 ZwE/9Fby0O+YafUdiYYtjiWhKrkycZZWckhuqJZobn5ZMw4xNWHItyXhaMc84LtDRIPgxR5m70e
 TDfhZpPLuonYfoPPOteBDcYHp4l1AXHmmO8uWduAvZhoZttje+oVjeD/lHZKP35ti44mnRT5v2Z
 CFi0RxLOW3I9amDGkBHI+pRo6NU5ngoei/QEVdxhpq1A/dTDjfoA3id2GZKbwTl7rNqFBFump40
 JdY/lsb0C+HK5Vw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds the entry for the new X1E80100 SoC and one of the
PMICs it uses, the SMB2360. Rest of the PMICs are already added.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      dt-bindings: arm: qcom,ids: Add SoC ID for X1E80100
      soc: qcom: socinfo: Add X1E80100 SoC ID table entry
      soc: qcom: socinfo: Add SMB2360 PMIC

 drivers/soc/qcom/socinfo.c         | 2 ++
 include/dt-bindings/arm/qcom,ids.h | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
change-id: 20240223-x1e80100-socinfo-06378c690947

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


