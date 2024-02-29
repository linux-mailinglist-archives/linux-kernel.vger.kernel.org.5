Return-Path: <linux-kernel+bounces-87232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF086D171
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B7E1F25E20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F077827C;
	Thu, 29 Feb 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXevVB3Q"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC36757F1;
	Thu, 29 Feb 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230104; cv=none; b=FwtO8WVTBKJX/J0tXqusiU/ZF7eF0/kPU+jZN1IfruYFvYXDDxS3sGUv14xJk1En52/kMvJGqYU3sMSvBiJmk2mMyKKmZCtOMZliLggE0I/ibDvxqA9IzegEqDCZxd4xriLfJ530fDP/0Zgeu5JrCBvAwQ5qsqywPf78p8Nm5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230104; c=relaxed/simple;
	bh=LKMqn9SElFgPu+r38CPN3LBzssOiaUnIZhvwNjwFq6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=atpK5Pbr3eTGZgS1yP5ThpnQTTyY+OBw7gjZ8JXiSApNYicvapAEqCMtCvEfY2he8YHKMAVgw58koa//rBll9parvkZVc06RXqbO+ufl3fnMQuWWt7KwuW3st07cQ3G3dT+T5p7z2td9/2s3Ijhkl7DiDIg75opwFfCztQVzCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXevVB3Q; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so15279471fa.0;
        Thu, 29 Feb 2024 10:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230101; x=1709834901; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q37MG069R1VCZUDWL9GxLkHnkMWluo9SRdj8E+y677M=;
        b=IXevVB3QlTDY+6vI64sXJUk9e+GUZWq6f2A5GwxSWrHPkdT1mNb+nbnWqIQYEzIOxF
         5Twf4Mb0TomtHLvvJtHGBruCJvhP+pUX7Yy5XAXdkG6zkoA5RycxzMkZFcTWx5vATCtx
         1suJYfQXElE4v3Sx08VqlBkiOq/Vt+yoKmlG2YmeSBAjHgdTFJ4wyJV5wKLMbhqrOEj4
         +QYBRp/DtqPf5mJAh4dwYSgwa6Mu4ddSM3A2acWS6IZomgEFkW+CPSgF1xtMFFs31WTb
         zCWQ4BnDBuclo9JPro8n3sfHRbv6BchZJjSKh8TNWOUx8WpMrDmTnDWYWQv6kflwlm8x
         /t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230101; x=1709834901;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q37MG069R1VCZUDWL9GxLkHnkMWluo9SRdj8E+y677M=;
        b=pTKXqYr8NfOaJ5Iupx6FjeOTkYVG813GMcJyqpzZBO+sAgPOIDp9rmRWv6GhmIoGAz
         0Gr0W5P5ZmUl0AhqRHqxC/L6AE6bd2tCBE1I+LQLHo6WgKtYSEwjkI4DgnLI2U9o5iGf
         4rxTBdaI7r0oUbToMSNvGnhBiQN5hB1ShL6ieRR80e586cvmLQAq8vo590JSwubEvcb1
         FK6gBNUHlqL+cphYOM3JIci1g4Gl1xG8W11hNcCIvRzw3od0qzOaaEO/1tNgIMAKVFqR
         VXeHvL5Jad0ihQHnO2s12p/Xc4Nfl/UrjKVPkSdS9YkLnbh/3tPzVBN0HKE2Yrb0blFk
         AOVw==
X-Forwarded-Encrypted: i=1; AJvYcCV+u5EYSlMdrVPlZjsCgeGnjmmYg0wMPK88KwoEC6gUvV3NcMMXa9n868nVyJ9i2nP0dO/FbNZyabsh0Ot97mZkpCcIOk6KYNQIDtxaus4JF5RgFD3JOUcatl1nNLRWnDFAFnyGi7v2
X-Gm-Message-State: AOJu0Yz8rdp8wzevd8GJxljJuI1TF6pXpKSNuiup6Z9HxEUsdZmAEJ2B
	Jf7xwjOlJrJ6b2ZKWuM9im2+m5p0NYUYRlmu0fm7ifntlP2QTexq
X-Google-Smtp-Source: AGHT+IG2pXvD68HwNp2RNlzcZ37vQ3NGNduX+dCd/iIMYrTf9O5lWhcoIgUPQTpd1MG4TSK/8PVVDQ==
X-Received: by 2002:a2e:b5ce:0:b0:2d2:b146:d42b with SMTP id g14-20020a2eb5ce000000b002d2b146d42bmr1743349ljn.52.1709230100780;
        Thu, 29 Feb 2024 10:08:20 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:20 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/7] clk: qcom: fix frequency table termination in several
 drivers
Date: Thu, 29 Feb 2024 19:07:45 +0100
Message-Id: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHH4GUC/x3MQQqDMBBG4avIrDsQozXSq0gXsf6pAxrrJBRBv
 HtDl9/ivZMSVJDoUZ2k+EqSLRbUt4pes49vsEzFZI1tjbUNB8XO2Y8LOENXiT5vysH1rjNw4x2
 GSvtRBDn+3+F5XT8eq7FeZwAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Add missing terminating entry to frequency table arrays in
several drivers. There are separate independent patches for
each affected driver.

The series is based on v6.8-rc6.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (7):
      clk: qcom: gcc-ipq5018: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq9574: fix terminating of frequency table arrays
      clk: qcom: camcc-sc8280xp: fix terminating of frequency table arrays
      clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
      clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays

 drivers/clk/qcom/camcc-sc8280xp.c | 21 +++++++++++++++++++++
 drivers/clk/qcom/gcc-ipq5018.c    |  3 +++
 drivers/clk/qcom/gcc-ipq6018.c    |  2 ++
 drivers/clk/qcom/gcc-ipq8074.c    |  2 ++
 drivers/clk/qcom/gcc-ipq9574.c    |  1 +
 drivers/clk/qcom/mmcc-apq8084.c   |  2 ++
 drivers/clk/qcom/mmcc-msm8974.c   |  2 ++
 7 files changed, 33 insertions(+)
---
base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
change-id: 20240223-freq-table-terminator-f78760e7b5e0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


