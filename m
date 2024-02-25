Return-Path: <linux-kernel+bounces-80225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70C862C48
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322DCB20EEE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978AC18B1A;
	Sun, 25 Feb 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8E7mzWI"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2813FE7;
	Sun, 25 Feb 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882397; cv=none; b=HeizG91QWpy67F9s5tCLcWb7Xb/UQpPGf7zcIg+LQ+SrCsreZDJ18q9rPNVd5LKy5GGuOhriT0B7dT/NpKx2Eec9bkiMvJykbBVApQaxNGr0axT8IqOn+bG80/G2IXII2tJsgGlc3HIM+VmiAl3geuegUaTHW0+x3OaxzyVCL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882397; c=relaxed/simple;
	bh=6G1QXHrfF3PrUu8EJMiV6E2rCJyUs76wIVXZXtRfU10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G6nMoc2m8VXcSOeDFpcVdZWsdk2JfxXGAh95K4FexBVDy++514oRdEqVRTPkDEZDNvF2T/tc7qtHRuxUlKhRc/wxilEvEWTYLgjk39KkR13av02njygv5qzgmChBKC9ive973S2wbf7TEZ/s9m0kbZ4lSd/b9hxn1WPn3YwXaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8E7mzWI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512ed314881so1941398e87.2;
        Sun, 25 Feb 2024 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882394; x=1709487194; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=guZl2SPxCQZuSLI8sxbmLDgy6Gf8KaBzLtPq3zTulKk=;
        b=U8E7mzWI+Lj4L7uASItdPRj5y67+x4eBNy23KMX+lf0ufBdbJyyGmNl8oBROKICtNq
         pDWHUvC9ohYZB1j/avYeGFDQbXWFbUdqY7akaB3fIt7IvGW2OaxarpW4e41aJttvbGlG
         fp2jfiYDuk0mzdnQKHoWPycoZubBtnk/I7OcGew45KKbFY3q8CHGD2xqKKOf4zLjJfjR
         /4RLXpl7czexxptMZNK/yQL8owjcWahaY61IGUKnUozZtmvVSsr2EksUbutkLDfguwBr
         pfrgPnHBHFitUmGDm1n8PMIuJemKPm5Pby6GKrO5btANrxj8Ez/Rz9Yy+Hjyo2VmZ1Ww
         fSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882394; x=1709487194;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guZl2SPxCQZuSLI8sxbmLDgy6Gf8KaBzLtPq3zTulKk=;
        b=R3w5/VIXnYDdaIrllCSkqNcF2+UNtd8D77Tf4d+m2QMXN5B/APICIkH0Z7YrSH1vTN
         eDuWlt8Itys8NnDxoaIanw9WiDh3bC9JNtD7cGG2zP7Er1Fv/6ksLGS8pusppV4HFb/E
         wKf3wpo4XQcKCI6J3p2bQKrbgozDP1vE2fQYe/9bw76dkByWPq9sSDqbi9rtv5+xW0wA
         4jquzJiJEKjUC8Luq3s/MwqplyLdUXxEoifWMWwbedbTzJ4VLhIjuR5bD8vE7CDlq914
         lzMpvllPV+LXa5WiPRWMbSiXVkXVsMx/qSDxwSh+fky65pj5l7/y6NRnuPprIe1YUaDM
         iyLw==
X-Forwarded-Encrypted: i=1; AJvYcCWg66XkVddM1e81kwb9OpVqAcvF0eCdrNfQQ5vuGYNCmmmloPH0ts0uJaGMd3Dv0wVS1V3Splbwv3uj5g7QdfHk5b6tCV+PWMINihrWSSL3RzsEtrU18HylPkGY1AFsMwnw+09nL7Nr
X-Gm-Message-State: AOJu0Yy7lpVhUeLmKL6iMCferCSLuxNQMpWin6N6Ofu6fgMl2YN4F51e
	LHhxDkTMgX9XaCMfw9+ReGDUsCY8OxBNiWrcCURKVl6JdWJRKeqh
X-Google-Smtp-Source: AGHT+IEOB/A4CBDtTq4B7V56JsdIwuBT64zm0RXlGsqaRZc7kyEeglcGgSWT4OVjYzg44bllC9ofTg==
X-Received: by 2002:a19:9103:0:b0:512:caa2:18db with SMTP id t3-20020a199103000000b00512caa218dbmr2787232lfd.35.1708882394136;
        Sun, 25 Feb 2024 09:33:14 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cw16-20020a170907161000b00a4306ac853fsm1182007ejd.206.2024.02.25.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:13 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/3] clk: qcom: gcc-ipq5018: fix some register offsets
Date: Sun, 25 Feb 2024 18:32:53 +0100
Message-Id: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMV522UC/x2MQQqDQAwAvyI5G4jpLrj9SvEga1xz2dqkFEH8u
 0uPwzBzgoupODy7E0x+6vquDYa+g7zNtQjq0hiYOBBzwJIz6v6JNIxoUtS/YrjqIY6PFBLFyLQ
 uM7TBbvIXrX9N13UDakE50mwAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The purpose of this small series is to fix some, presumably wrong
register offsets in the 'gcc-ipq5018' driver.

The patches are based on v6.8-rc5.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (3):
      clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of 'gcc_gmac0_sys_clk'
      clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of 'gcc_pcie1_pipe_clk'
      clk: qcom: gcc-ipq5018: fix register offset for GCC_UBI0_AXI_ARES reset

 drivers/clk/qcom/gcc-ipq5018.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240224-gcc-ipq5018-register-fixes-394905520fda

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


