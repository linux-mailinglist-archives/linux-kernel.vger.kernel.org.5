Return-Path: <linux-kernel+bounces-134718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DBA89B5F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABD41C20F27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC51878;
	Mon,  8 Apr 2024 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKg4m9/b"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98E4C63
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543648; cv=none; b=fHVFErOSgKJYTBfibzf7RBVr55GSI8HtVI+LFEaSJ7WG5p1X1MRn6uZVGusz1JkaRcCpTwe7706Ie1gnGMQ8dupJX7M1cjAAJsDMNOo1ILjwzrmE4U1xln/V66YnVZN0pBYKv4IiYyZGIuaNAJjbCst6x4zr3sIck5MjkKISmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543648; c=relaxed/simple;
	bh=8EsNeEk62CSpcmgK4bvkVppKTO4BBx9jgl17Ja5V0i8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uQLbpgSTZe42fhFyXPdwQyHulTyFFyvii5v1p2C/Pv19rEmca97GsFvHGyo5dxYaCwizf2xAN9DfmkND+WCuZBSpECJGHXJcKFeWAdtNDALamUdF3e5Ipkn0TSwUte9wQGctdJIJridRJq9iKE5Axb/+2ChXeMGQmPr8cM1e9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKg4m9/b; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516a01c8490so4234514e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 19:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712543645; x=1713148445; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ok44gEzycQxh0yhKV5quQwXwYzTEudgwlcs7LIN/iN8=;
        b=XKg4m9/b+iSWYxce8OrJf+G9VfJw4YpwWz1W14cz+Hv4uF8fJP+hRF5soiSfvHpK7g
         M7cgOo81Oki/We8MUwMhWcUKVTj6sayUnJMgjTXqAtdvR8zAV7GqIlS8NxWujcLmA3vn
         ILUBkyzz8GVkTEpU+rMd1XXXVqJBGqj2aY4wUGzDBtmbjlb7jdXvNDXqGclGbBk7Dr1Q
         98qHNHClkl4ILu7wiAi2/g+MGZIsizQ8Ey2dW/Yr+Qu0UyvkngHE07eokKwEPVr9pe7K
         CHqrgxZbsnYoSdgq/oPj1vKg+BsMs73Llw5QQKB6OPjzocCeyIi+YjQ9LcHyuc5R22/O
         pOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712543645; x=1713148445;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ok44gEzycQxh0yhKV5quQwXwYzTEudgwlcs7LIN/iN8=;
        b=PfHO9Pppequ3N3cjcPEGEd6QLZUdLkRP4bXLNJ99SXRiR96YnNk6V3lHhhYy/R47fe
         rtm+Nh0gH8P2o/QcBCEkBVDVPftCCY9lFmXhtjpqw8TSkbfitdlq21+JKCLX3agHR3Fh
         KHmQICCDifUYc7l8L5AeadE1POsbYPTqYirn4PC5kw5DX95tGIPY59q3wutgijx/3uhs
         314VWcs5w+cbyail7ZmyAvsK9kaEmuEirYtBTR/QLJRgzWhrzOUffICaoBFSTgI3sfoP
         4AmRTvLguysyzmwnBEa6CgmT6abuEJ3GoMs1eH3b6I2nMJ9zWy6aNzq7ufsCKh63C17G
         kyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjBVIABH+tznbfWVs4fV9DFtHh/r2t9HCh4k3dE2ZSnqVhaBWlzf1BTRDaD7WiTPUZskAgr+lO6isW5Qjbooq8ZLlGZjsfHFqkSeaG
X-Gm-Message-State: AOJu0Yw/oXF7/WHH4VkKwyCe/ffT+HGFMzyiTD2lLzBtgGA1u4S0OmhN
	/qUrI5hNAXJPX5sRc+eQMzAsuA3jzuEIp+Asx5/9EiWY8qYH0ThO9ZGL5Ahf7nE=
X-Google-Smtp-Source: AGHT+IFMNNSGVca/okQD9EApK1fiHLCTAisk+0SGzTI4DGbUvtnHJB1OaKGyjCW1XdvzkZbn/FsdNA==
X-Received: by 2002:a05:6512:2393:b0:516:d713:382e with SMTP id c19-20020a056512239300b00516d713382emr2757359lfv.12.1712543644554;
        Sun, 07 Apr 2024 19:34:04 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h5-20020a0565123c8500b00516d58590e1sm943673lfv.250.2024.04.07.19.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 19:34:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/4] arm64: dts: qcom: add USB-C orientation GPIOs
Date: Mon, 08 Apr 2024 05:33:58 +0300
Message-Id: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJdXE2YC/x2MQQqAIBAAvxJ7bkFFMPpKdKhcdQk0NCKI/t7Sc
 WBmHmhUmRqM3QOVLm5csoDuO9jSkiMhe2Ewylhl1YDJ71gkyedyiovx4NJQW71uLnhjnQdpj0q
 B7/87ze/7AQvDqExnAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=8EsNeEk62CSpcmgK4bvkVppKTO4BBx9jgl17Ja5V0i8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE1ea6GAklbDaEutdUi8pdQFlyQvtp18Ao8fVc
 xixsjS9ePiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNXmgAKCRCLPIo+Aiko
 1cDsB/9J+wZ2Du8JS4PhKoMWrrknKk8bMlVvLhZDhpWRTBTcr+3Rkt1kYvF1tzjnJS39jYAUxrB
 k124Rf+eb3hZ1qGrs/H4L+P/jdO3Q9a9B0BIAhdo1HQ6ZQuPdVWOpY1+SJUPUeyySyguE0s2u2o
 q/6Tba5gCf47nNU029B3FeM5tMAi1XA6KVzdOlRcrScyzpbeefo3uUsoBJcqwhrLKbLlHeM0S3U
 lDaGtFXXEoxLKb1sDE0mQcP7W+587UpSgTbPHXbVhfCmNtYkOai9i8W6WTQ7iQWiUuKq1UQqLrQ
 gOogxHf7T706lzV+yONgcYWJa92v/C1Kdx+Owrii1wTZ6lhM
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Populate orientation GPIOs for some of the PMIC-GLINK-based devices.
This leaves only FairPhone5, RB3Gen2, SC8180X Primus and SC8280XP CRD
without the orientation GPIOs declared.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
      arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orientation GPIOs
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GPIOs

 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts        | 2 ++
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    | 1 +
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    | 1 +
 4 files changed, 6 insertions(+)
---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240408-hdk-orientation-gpios-141bc7fd247d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


