Return-Path: <linux-kernel+bounces-76685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA685FB06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1620D287F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37E14900B;
	Thu, 22 Feb 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="goxiNw8E"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA741474B6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611600; cv=none; b=cLFAYoYPdppve2ofngUSp8T9ZXsgjH5guAXchX0V7VuZ2NaQftg+bmFmYt7aipAVRbDcPt0PZiZrapkd+p+4e8QF5OGoNsgoq5/Xq2e43kyk6F/nByqnTnHca5gohIsgMVBdGY1amDkQV5KkIrQxaHvnIzGf4amXIUYOO0mwP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611600; c=relaxed/simple;
	bh=shWmSwxysRHMldcm/3j7cRjYXlqO7/Fxt7i8pBMEAT4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K/MAqs4FxOJfVrxNYKJ0NMs57MED/lcKA9ESaBsSAAqQxkjAoWp/bMTleC4jcJlPvuioJGKH9IHHleinwwrsGYCfzySZ/24uRxaDP3/t1YWvtQWULxM7lR9353agL+TnV1weEp/Wbh91nWJ48qChCFqYrZLf5sucAtRaB/9/Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=goxiNw8E; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3fa7f38110so21468966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708611579; x=1709216379; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzkix+sBN9jjqgN8fk2PR3v17qLWU+ZLNv8n4sZPGp0=;
        b=goxiNw8Ed9Ydxw4FOiz1Cfow8moYQJKThw3ryf91rOMHoRzaxxr+cTIsYW5TxYtLVN
         LM+upVPcZPT/6PnBuOXp/X7YUQpvCiSUN/bMUOADtcK2RjshvWChw5O/ybuhW+nXv5fP
         9sjc+EXfHMLE4IxKZNRyGXKkHckx97Rolb2u7ZmQPH584DueDDM7QQdMzhreO9KUpEi+
         Y/wtDVA156CsopgioEryjwSjGtKmsaolkYV8GZ1bLli40RA/ZyfFvALmfWLYuJ9tJ3VV
         kHKnwaU79/3k8OA0Uy1RDZS0D8ufSgSw4qxyQQvLllYkqUvlQqU2JFCJxmeGE45Hycz8
         2Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708611579; x=1709216379;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzkix+sBN9jjqgN8fk2PR3v17qLWU+ZLNv8n4sZPGp0=;
        b=ZNKdkWK5PQPPwkXyjcKx6bdbkU/+HKkq2uq0vgPbo8QR/BVgMRmqzO2pQUOGOVGCob
         jHK01UJUfaJrnw08WqxMp48R1HfycColtf9/XPqyTVeW7wCJt1CxXkvmbI5MKEqbVWyv
         q8DM/aCQROX/7B5bxYaDypWIJXed/oFcKbtOxWe+Gg6PEb8cz1v44uu2JpzztzT+8wW1
         GuPAPb58je9qR+Vdq7/zPJgsPAeUwsAfRwY109AuuU0MvA1+Oav/yvJr9W0rqG3Xr5To
         SJenfOhzhvqifmUhDHL/52venIMGlSbqzw5+Iwdu8xWxmhjZMSXsa2k9ogXnsIFvKa97
         cCCw==
X-Forwarded-Encrypted: i=1; AJvYcCUMey2WdAuPxPgbUWlhg7LgFAFmkkmZEIvfr+w+sTAbGK8pNitC4Q/QiFyKLOOdzddJRSz6Mc2HL9Rd4ynTviZEXyEHLs/Mi9YgVJWx
X-Gm-Message-State: AOJu0Yw4HSytsffAR2mPK3fMEIprsSk/Fxso9m1Pi5pTUt/mtR0rgoWJ
	p+0HbPuIV+W5a8N5GggU1j6zGfqNIMxxG/q8mJIw8O9uKPexLktAMsSGSWZ8iDz+6QectzYSRlw
	Z
X-Google-Smtp-Source: AGHT+IEaXRFfWnl8zQhNc716/OrigOqr4FJnoSeVja0d09fzo/EIqo771ApC6K4VocuOWQHnwIFcww==
X-Received: by 2002:a17:906:2ac4:b0:a3f:2ef9:598a with SMTP id m4-20020a1709062ac400b00a3f2ef9598amr3668461eje.36.1708611579108;
        Thu, 22 Feb 2024 06:19:39 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id lj7-20020a170907188700b00a3daf530fd8sm5992588ejc.210.2024.02.22.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:19:38 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/4] arm64: dts: qcom: x1e80100: Add support for eUSB2
 repeaters
Date: Thu, 22 Feb 2024 16:19:18 +0200
Message-Id: <20240222-x1e80100-dts-smb2360-v3-0-85a691d4f68a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOdX12UC/3WOwQrCMBBEf0VydmV3U23x5H+IhyRdbaCmktSgS
 P/dVPQg6HEG5r15qCTRS1LbxUNFyT75IZSglwvlOhNOAr4tWTGyJkaCG0mDhAjtmCCdLesNArr
 a8frIgqZWZWpNErDRBNeVcbj2fSkvUY7+9nLtDyV3Po1DvL/Umeb2bSH+bckEBI4ba6u2JlzLr
 vfBxGE1xJOaiZk/lAqZ/3zNDOWwrltqtHPI9EWZpukJ2t5xGhQBAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=shWmSwxysRHMldcm/3j7cRjYXlqO7/Fxt7i8pBMEAT4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl11fqgZ5SvtDNCxjsaQDnCG9SIC1IgBsuLuqL8
 KSg0M4vuPmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZddX6gAKCRAbX0TJAJUV
 VhSwD/99xAvcwB0frB9mLCHOcZceGlRRDI/FipZ59YUGsvti/EQd3fgqi9aZ16eo3UkAqB1oUav
 GDFmqNySPjC2ugWi11Suf4imheWd4Y6lVeZDxA2dIXMGZ8yIO2lWSS0AkzfykgoOXJFi20kSUBp
 xChWuHhIg7TvoqCCnfpaXaRjGLMOfAo2bsnqRTWHozGiT4Cix9m6B/a6BP5jp+W+fdEraVb/4+U
 6Ljkh7QcCgkB/mLtyS/y7XKNTBy4Y2oARL7upFjt0Wa4QvtJOYWpE2HMN94sL8R4ZXz32dwLg6j
 HxWj96YM0AMGo1/K2CY7Gcns6qFtUYGdvxN6kSpKEJEqZ3EuqUYJaq0oOeJcj+rmCQgBv0epgnT
 0lhRP7lM7N3JCmdN6RsTKc2Pkp64vTggHjmpuo55MIVDA6eU6AWAwHhti9enB7AeI+nx0TgajkA
 uJqYwKRGgyjdHIxVHDlsYSDfEsWKG3XOwSDRCJZzXii9Rsj696ztPpaIqCjl7QbQRelCapWbBOj
 hhx8Yx51/lcGK7Ev5vfZzHqMRbUitepaVSY0rmLqSNkJul71x+fTC0vsEGLyiH8EYeY+vHErysL
 P3v9qPLd1fetuVPl/wSJBewVr6E8ywvT+bN6VXhDsd/O3W3OnYAw7cfFZ5b5xR2VYRwyom5m5mv
 atCy9tPujYdm1cQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The X1E80100 platform comes with a v7 SPMI arbiter, which means it
implements two separate buses. The boards using this platform come with
3 instances of SMB2360 PMIC which implement a eUSB2 repeater.

This patchset relies on the support added by this patchset:
https://lore.kernel.org/all/20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Changes in v3:
- Replaced the smb2360 dtsi with x1e80100-pmics dtsi, just like the sc8280xp.
- Changed the suffix of the pmics to _[0-2]
- Changed the compatible to platform specific one, per Krzysztof's request.
- Re-indexed the repeaters starting with 0 now.
- Added Konrad's R-b tag to both QCP and CRD specific patches.
- Link to v2: https://lore.kernel.org/r/20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org

Changes in v2:
- Reworked the whole SPMI DT node layout
- Added the SPMI DT node
- Added patches for each board (QCP and CRD) that adds the repeater
  nodes
- Link to v1: https://lore.kernel.org/r/20231212-x1e80100-dts-smb2360-v1-1-c28bb4d7105e@linaro.org

---
Abel Vesa (4):
      arm64: dts: qcom: x1e80100: Add SPMI support
      arm64: dts: qcom: x1e80100: Add dedicated pmic dtsi
      arm64: dts: qcom: x1e80100-crd: Add repeater nodes
      arm64: dts: qcom: x1e80100-qcp: Add repeater nodes

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts    | 22 ++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 51 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts    | 22 ++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi       | 42 +++++++++++++++++++++++
 4 files changed, 137 insertions(+)
---
base-commit: 4893c639cc3659cefaa675bf1e59f4e7571afb5c
change-id: 20231201-x1e80100-dts-smb2360-0c7c25f2e0a7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


