Return-Path: <linux-kernel+bounces-35138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF3838CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D4D1F251C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD25D725;
	Tue, 23 Jan 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcmZxsu0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED5E5A116
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007716; cv=none; b=eWwC8Nx2zrOxRSqoJ4qWTo9OEWhNm/70bcT1hvjkZQxCGlhtsRONSZmGjj0sYvmTUHgNgOKKtb6ZalQoGoWzW3QyQoQ+5PFPaA00LbjRGXfGpR43hxL/gnCbvlXyjrngs/57rPkL7fypnBP2qwy4SO3SJW5uRE81uCHqQrnnuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007716; c=relaxed/simple;
	bh=mpfY+BCg0dcdts5GW3yyXu28a14NVn8fS8CS8HwrtEA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBh3/KrJpRHH+OOGnsDuRa0fMcVshG1cmO4rRW72JTHM4Mo1w2joW+SRhW/6SS1QP/9IYORoL/YGHE0NfKh+Ek1ntiHcDIDgYDByeb45t++f9pwACDMR7huph24OPPm+qPnjnbqfDZmQbsqRAIVfdRQ27/LwEoLOMOxhW857a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HcmZxsu0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c932f7fcbso254605a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706007712; x=1706612512; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgWgMqXX/nLyJMe6niIKtw6w9F40cOBRvzu8MWC2fKQ=;
        b=HcmZxsu0q6kHCOtewyMIiT20RNT/8dKHjpfUF14grAea0ENwoqvF+gzT6C2QzC8/0U
         WNMFf5f1ktecFXn/uF5DiR/DkVTPzpa8EKvWyIM64TVRRFAVKDmZgqlFRZDz+nTzJpFQ
         uPnUUwCdSmj6ovQXh7BF6ZeL7fSWvUw9KA3ly63OlUuZlqI3I8Pyx1mUKRfyVeSfB8gV
         0YptmEkCtDjFR2XXKAH821WiHgIB+iT8pdS5r0sCAdjqjf6xTqYuESdwF3YrurqRjLjK
         athC6L3NDCGKnSrjaSTKYyFh5gitHOIId156s9dwrB87u9o7annTkbcSwuw5zPHpiJnI
         lRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007712; x=1706612512;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgWgMqXX/nLyJMe6niIKtw6w9F40cOBRvzu8MWC2fKQ=;
        b=TQUGCF0C3Wch+HOPDLfbhUd++Rq/rHUgUTg6S8ipF/glUsi3safqTwnwv6cLuNUZ13
         GR3Z2JZexWRqqwHU9UNssZ4bSjQsslWDEWUoFrAf1k9dSgzyUHGhbxUx5tZvoePQTvAB
         8H2HKk6kYpA8iLwoLyR3G1B8ADNlWszflenrRzOMKBMggD1/91z9rarGWZYqA0yhi+hp
         vYsygxNb6KZxHzX7QiJ89U0KMz5uSBbViifSX9SRQXZ2zRggwhL5DQTmsakbEPM4EyfL
         5lLFu2l3o0rmVJCjJaOYsEkSl5oX0Y4FhDUBpOHwQ9gCzBQ29xda1hyXmusxs8BrIDUz
         tXlQ==
X-Gm-Message-State: AOJu0Yxv8I2BM+/VbIvuwwJ/9O6k2U9SQnn416R+ArLGZu7ti1FA6+iE
	2QqHf9fFDLN0GU7n6x2ygwpIq8ilfG6ETT8JpnzQ3EleYQ7MGa6h5G4ahn4ZC7c=
X-Google-Smtp-Source: AGHT+IG+zaTU8TxCbFcnuYXxlRDTCoKwH1GT1+AG7ChImV8EqNnoFYWpE5t731S5ytaSWx8Db66dHQ==
X-Received: by 2002:a05:6402:1292:b0:559:fd27:13af with SMTP id w18-20020a056402129200b00559fd2713afmr655840edv.12.1706007712479;
        Tue, 23 Jan 2024 03:01:52 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm11430074edb.45.2024.01.23.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:01:51 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 00/11] arm64: dts: qcom: Add more support to X1E80100
 base dtsi, CRD and QCP boards
Date: Tue, 23 Jan 2024 13:01:14 +0200
Message-Id: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHqcr2UC/43OwU7DMAwG4FeZcsZgp9noOPEeiEOaOG2kkkxxV
 Q1NfXeSgRAIacK335Y//RclXCKLetpdVOE1SsypBnO3U26yaWSIvmalUXekkeBM3CMhgl8E3qJ
 ITCOk7FnA4jEQ+2MbVYHBCsNQbHJTIwbz8P38ecp5gSWDTDzP7eFUOMTztc3La81TlCWX92u5l
 dr2qwfpWz1WAgQyj5oDOz1g/zzHZEu+z2VUzV31T2t/09LV2tsDB4fGI7o/Vvd/q6uWM9x76g/
 WB/3L2rbtA2NdMcuOAQAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=mpfY+BCg0dcdts5GW3yyXu28a14NVn8fS8CS8HwrtEA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlr5yLn90B09qjP+Yw2LZTpARY3/7N31dGA1ydT
 1+0zBY4xdaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa+ciwAKCRAbX0TJAJUV
 VjIKEADHOF3OjHdot5pRmYNv27P5WmoVGIfFimfUf0mW38cuEbl1n/TFQD3jgmO7RprJZBAqj2g
 IjiYUuhS8u9syplenul0BWGp7y6bwVhiG4DucfZcleQno1jGOFvUln4JyIU0c1IV9aqFbvIV1II
 AlVo1GySVDSm2u4xBOu4IiKlAk+kMbSo+rR0b5aL4GdMExwijBZjshhnaS4tA1s9kBFnjK0voqK
 vKjU5UfvQ0KhpXl3u/pFdDooPNlP3mjUrPzFjc0YXj2LHF9b/lKnjgZo8Itd9vfRDmQhjTVee0C
 617QyWb/tdpqYAiQ3g1I2vL8uvW9YjKoopEdr1QMet3T/e5cQ+FlsPDnnHITwAWMB8GufhXDJcn
 dnTgcAWq6ZFXoitDk5ZXcUFZ0DsRy0NW1nP47di/+yTyCey62/f7/5ILURgy5zDSwAYe6ZPxIo8
 OyYdt62dEn1pMKe+tV1FwoZmUAOxaEX12SlEoUiSIqMizx6EJ7BhMrYa7DdT/h9CZr3V4BYGlO3
 vymEWW693nJompQkiOykldmjoeiSC+Af+fjuVnmZp960V4IdT+3ayyQrZJKPWbBHSA9/xPZWmEx
 ba/MzJGcQ1tOq+9xnJJPCqc6BTCYXk8epiowSwdBI/sdA2+ZsLIDrQRuK0YBsIMh5IvxQIEqran
 r4QGbHMf0RN0CAg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds every node necessary for both the CRD and QCP to boot
with PCIe, USB and embedded DisplayPort.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- After a discussion off-list, it was suggested by Bjorn to split in separate patches.
- Addressed all of Konrad's comments, except of the clock-names one for the mdss,
  which there is nothing to be done about as all non-v5 do clk_bulk_get_all.
- Added more support to QCP, to be more aligned with CRD (except touchscreen
  and keyboard)
- Added a patch to fix some LDOs supplies on QCP
- Link to v3: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v3-0-c4e8d186adf2@linaro.org

Changes in v3:
- Reword the commit messages
- Link to v2: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v2-0-5a6efc04d00c@linaro.org

Changes in v2:
- Reword both commits to make it more clear nodes that are being added
- Dropped comments from interrupt maps from pcie nodes
- Replace all 0x0 with 0 in all reg properties
- Moved on separate lines reg, reset and clock names
- Dropped the sram and cpucp nodes
- Dropped pmic glink node
- Reordered all new clock controller nodes based on address
- Dropped unnecessary indent from touchpad and keyboard TLMM nodes
- Link to v1: https://lore.kernel.org/r/20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org

---
Abel Vesa (7):
      arm64: dts: qcom: x1e80100: Add TCSR node
      arm64: dts: qcom: x1e80100: Add USB nodes
      arm64: dts: qcom: x1e80100: Add PCIe nodes
      arm64: dts: qcom: x1e80100: Add display nodes
      arm64: dts: qcom: x1e80100-crd: Enable more support
      arm64: dts: qcom: x1e80100-qcp: Enable more support
      arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J

Sibi Sankar (4):
      arm64: dts: qcom: x1e80100: Add IPCC node
      arm64: dts: qcom: x1e80100: Add SMP2P nodes
      arm64: dts: qcom: x1e80100: Add QMP AOSS node
      arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts |  222 +++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts |  175 +++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 1349 ++++++++++++++++++++++++++++-
 3 files changed, 1739 insertions(+), 7 deletions(-)
---
base-commit: 853dab01a34378871b37a5e6a800e97a997fe16c
change-id: 20231201-x1e80100-dts-missing-nodes-a09f1ed99999

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


