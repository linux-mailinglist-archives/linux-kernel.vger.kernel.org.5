Return-Path: <linux-kernel+bounces-96188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0607875849
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FF4283AA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABD13956D;
	Thu,  7 Mar 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyMALVcN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D313699B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843199; cv=none; b=urMLEuJULS0CEyYPJwqMtp2JfROAzq2b024lCbJGyKhfBcUeQXRoAOl0oFeDYQXcsSuKBEpFQjpL5FJ6JqQkJy25OaIEwxkF0JdyoE5haDoHkjFk27AnWJLYAAdu2B+ZrOtWuHog5bznykQTDvNHfBoHaSJx/wyJrxXy1qM4kC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843199; c=relaxed/simple;
	bh=/msiUkwhaZ45uUjVsSWjIXACu1QdRDeVRBFB5dmaNcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FdJrxUJezrftAmEc3gH8NgtQ6DnZ6CgcmWSJpW5WLl1/UGxA7s6iqpZ0+/KspqwLGsOTdfYcYbNCgm5N59Dsd5QcaEmF6EyNVex07Tcy6ws4rQuB15ohq+Jw+3Gqz0YV3UXrlXwUsom/gvdg8oj+4yuN8gMNnES5a5kNXVpfx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyMALVcN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d27184197cso17622481fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709843195; x=1710447995; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQeUiAl8X7TtDxUZ4LhmusC+umdOl8g3ml7+2KOerAY=;
        b=cyMALVcNhsFIoPSAU1CV9ClsxlqO2EDFhupv3f4vBnkwneblYV3IH0h24bFiN2fDrc
         IfKeefxyseM9NSLraMRJ91u/etDc2lMqMr3E46GnBBGILFKnGvG+7F2Ca/HZ0e99rX11
         wvSXwoKU40Gn1kmO4t9b5XOk4rss0U4Fyso0VxQ75C8GlWt295rM6HW9qZxPG3WX2yXk
         /ykfo10jidFJYjlgEoSW+YKMPxtDowYA4Y6PlEuZkzFnTOnkuCnJhYGqiT4+Bj2JlOZ7
         cmoH4vmQx/yUFhlbeXOkywt0/WXSHZJ6vdYAhbhl8HDvo03eiMwu+rbuGuPA2FHdWkyr
         aHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843195; x=1710447995;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQeUiAl8X7TtDxUZ4LhmusC+umdOl8g3ml7+2KOerAY=;
        b=JzU604rnDekbPO2U2660AhBo1dMZiGG+m4WH2mD0o3yoy3mBxVVJQtcnYlXjXjs4EO
         SqVatO6HVlpRrWVsAquq0lTP1Lf0PhQD4SNAzYtnGTTg4floZaUlkTQYOqQ5ItvlX6/9
         AoFRZpF7xIg6+uq934E1IQFnlwFGLf1mYqgT86DbbzrNyz/XYQYjjZJTppxhVcBr635Q
         7HZGk5P/3WmP8nquM9t2GKY5Syov+Ws2pnOIudPrzRS8dLdM1uHVtjJF4KKm53XOs4zF
         THqiwtn6yCPfLiYZ6zkoI+rzSqrS3YPmrTA7KjiNeFaQ8eul42oJxM1Qf29+ItboHkHV
         mN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSv1wnolbmWFmwJEzgXSFWRC7U3Xayzyrl0pppU9zd4zGD3bEHXsh21b9Bi5c5FsVXpAoXi3B0KgOMr6qX4lcdrAd/KcdW3OkDroFL
X-Gm-Message-State: AOJu0YylxBS3sZ68nS/tk/u5SEqVBazx2pCglRyCFzXD+uhq27wo5VaQ
	QczVQTcgGBGdwoin9GtKdAvZb3zAw3KKg4yWQVUrYfB10dAPeFg0W9RNKv5+tTA9K6XlzWGmDo+
	bnEM=
X-Google-Smtp-Source: AGHT+IFJji1QVpF9dm3D2mc8z4/3he1QM8bKZARuVQxybXlGiWtt92qOOil6n1N7vxkHEajK7bVkDA==
X-Received: by 2002:a05:6512:ac8:b0:513:8266:f5d7 with SMTP id n8-20020a0565120ac800b005138266f5d7mr1940301lfu.3.1709843194810;
        Thu, 07 Mar 2024 12:26:34 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id dw20-20020a0565122c9400b005132bf9f8dcsm2957606lfb.303.2024.03.07.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:26:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] Random 8280 bits
Date: Thu, 07 Mar 2024 21:25:53 +0100
Message-Id: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANIi6mUC/x3MQQqAIBBA0avErBMmK7WuEhGRU81GRSOC8O5Jy
 7f4/4VEkSnBWL0Q6ebE3hU0dQXbubqDBNtikCg7bFGLywfehJEGF+ctJWFXjURGqaHtoWQh0s7
 Pv5zmnD+SDl9OYgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

As the series title and patch titles say

p1 for Srini/nvmem, rest for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      dt-bindings: nvmem: Add compatible for SC8280XP
      arm64: dts: qcom: sc8280xp: Add QFPROM node
      arm64: dts: qcom: sc8280xp: Add PS_HOLD restart
      arm64: dts: qcom: sc8280xp: Describe TCSR download mode register

 .../devicetree/bindings/nvmem/qcom,qfprom.yaml         |  1 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                 | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
---
base-commit: 1843e16d2df9d98427ef8045589571749d627cf7
change-id: 20240307-topic-8280_nodes-da70ee866935

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


