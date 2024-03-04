Return-Path: <linux-kernel+bounces-90381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438186FE7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804D0B224D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9858225AA;
	Mon,  4 Mar 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlyBhynW"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63389208DD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547116; cv=none; b=Hs2eEV5NS6r8y1dPvk9jfd8HpAZpiJWK8yy1zM5j4fCdGMawUwGqiar4dX7IJcEqujEJBAUJAf01mvtP5tv6cpHw9EXb5qbEWGEjN+2+7s2QeIyvR+YZ9jMj9Qt7fiCTecrVrz2mEkAmNFwkJvNlbcv5PrtiorpMKxzH0G8LYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547116; c=relaxed/simple;
	bh=OH7NMQUj9xup9rOtpZMXbczseEaMEMJgnLbgyXngbZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z1FYAI9btGO/nQx/GGmafNgyF3ghlYrJaBAjPMEKXI374E+TSUvOSGh2oU97By7Pt75nh3IUao5V9NhzcxrqNM7s0wuSa6eGHMq7LIl8KfAbqMKGJVWQps8s4EL4DF9zSzTr2fT/GQQrBSpCNIFLxfAGROI3jXCd/LCdq4NZGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hlyBhynW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so8855596a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547113; x=1710151913; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJK/ZZpOUq8+bFA/FBthzsUU3+Ts6yS8JiIZkaVwCyU=;
        b=hlyBhynW729WFxDQjyzZsDDcaree00/gxK60+775ICMvcymNJO1Qvd78odEq5fm/ew
         m8nCNKv3xNh3ym8HbYPRA09/zgm/QENu1HpxhgXLHrRzeIPsKWZnXJnUjqpOohl3Y1+s
         /EyvcRFDR8YiK9vqX+r5jxcAjGwmhpMYUYhTjWIxVFp5J0X7/IottpFBpuLD/t2pROpc
         RFG+2f5r7/gFWF6rIkfeXax6z6q8XrdxxpIFVlcBiHX9kOi1tpPwroYoHsytfghuqobS
         UGocS172vg7S+UzzfmH+4DLx+fYnNSBvuUoqt4+rwYCIMFmLDxYybuMhx2xq5+hXC+3J
         ZSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547113; x=1710151913;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJK/ZZpOUq8+bFA/FBthzsUU3+Ts6yS8JiIZkaVwCyU=;
        b=smbug4+GLkAM7ZGDv5mLnO28CwawHJqLReGGXh1UZFjdbKlFeG6Cfdf2M+6M7KqfTJ
         SmKfIklj+MEkpUgjTCGAioXjr8egS11156pLqdqJyDZeDiwCxGZgp0LM2mKuSz+n8LSS
         ZyjOfrZOESq5wwYNtOvsQUOU1KEpyqbbxFAsCXibp/+/Ei+wO2Ut8oYMuwqEktwNarRT
         Qnlq1u5YyE6GJMmHE8eu9EiAdWLjCNprmvSgkRxN/mdklcil1UyinRk2e/e1Wa7XAnQv
         Cza48bVw2TC5VTh/cCsyPCfYQUdz7hpJOq7Xdhgek6OAOKzMQbgq9zJfYr+/9n4yi5ow
         vg/g==
X-Forwarded-Encrypted: i=1; AJvYcCXNQhbLECPrhcjXW2SOnNV5UCBJBdE8H8KyGm09JHpd1WegacnyDnWX+SEahCUT3WKKC5vtVflWwLVYUSnMVvmWWHHjj5/ttKofEwyu
X-Gm-Message-State: AOJu0YwjB7+iK8TvJ4kn1vLTLWTbHE6TFQl6rrZPuMnpmnqMF8TbekbO
	X+rQlqXhFZ3fNcMXR00O3pmD/OqEGkJXGMqepc4YB22LgPsRuKAAo3rww5xyjbM=
X-Google-Smtp-Source: AGHT+IHZE7yeVB2iVKBhJxbVE1pgPHbTCTtzc2QKtPQnk0+uRO6kJqqAwgSPdV91EQzA6wVWbRasbw==
X-Received: by 2002:a17:906:1155:b0:a45:73b0:bcc3 with SMTP id i21-20020a170906115500b00a4573b0bcc3mr705495eja.34.1709547112780;
        Mon, 04 Mar 2024 02:11:52 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/7] backlight: Simplify probe in few drivers
Date: Mon, 04 Mar 2024 11:11:37 +0100
Message-Id: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFme5WUC/x3MQQqAIBRF0a3IHyeoRYO2Eg00X/UpUjQiCPeeN
 DyDe1/KSIxMg3gp4ebM4azQjaB5s+cKyb6ajDKdalUnnZ33g9ftkjEFB9lqD2gs6HtDtYoJCz/
 /cZxK+QD3cVb4YQAAAA==
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=OH7NMQUj9xup9rOtpZMXbczseEaMEMJgnLbgyXngbZ4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5dtncXmblc14GzkUUxjTcJ79A3s5elTn7Qu
 /wxqyXw/CGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeXQAKCRDBN2bmhouD
 135QEACP8yEtprvbd9at0xw0H2t+hJLRhjMI+Ro3IfuXFHyJyqBFmK0784zd1uuuICJCToCMhCk
 I4lE8leqiLL2WM/2dCZLBkPdy9oXnZ4MYAi1jXXmkljBr4tyHFs6ZbaIS4SZxYWG5x/7XGok+r4
 o09ykWvDXg0SjjvwHCKAPl7MlBOQrrN3XblcBBDSvE1KKz5lUrWPTUh6o1Kkw/8Qx5oc3aSxcpq
 Qwn9pxptQ62HWVmlbIISMUUMlC/qzML+MlEx8k5JuD7ECLA6UkJ2d+E0zMOY3hkytKOFENnLiQ2
 U8X5F+gGqIv5kexKKXS/HmWAHS9vKrA3UlPjI11r/ggruvLdkc8VPOo3MfrBE4IN+yDD04d+Wez
 EEHxsWDbcwqvcWdtOY04P7roKxbtSCHBq2MoVbgHoBEbjVpZQN6ngIg44eUPTP5PFYE4sU4zLQI
 fjtkvo2wSlNdFhnHxvPx6rhgtMRgt1xF+GfNT2yJz+zVgqSbhG+i7bnHK70LCZ6Gvuxv6xo9r9/
 GDRkLun9z4dDpm3XOgWAT5vi6+5mE7p4Xm7YtEO1TDnXmk8hArv2O8iFBpNdsnCRGbnIFXlBqP6
 vZLzU5YWBVi7MfziBeYwz/u5lzxzN+HFD6INptjm55Nff+kgSDCA5zmn5nzRWtkn9bzC2xOz5Ur
 aScFZfLhOOHRV8Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Simplify old code in few backlight drivers.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (7):
      backlight: gpio: Simplify with dev_err_probe()
      backlight: l4f00242t03: Simplify with dev_err_probe()
      backlight: bd6107: Handle deferred probe
      backlight: as3711_bl: Handle deferred probe
      backlight: lm3630a_bl: Handle deferred probe
      backlight: lm3630a_bl: Simplify probe return on gpio request error
      backlight: pandora_bl: Drop unneeded ENOMEM error message

 drivers/video/backlight/as3711_bl.c      |  6 ++----
 drivers/video/backlight/bd6107.c         |  9 +++------
 drivers/video/backlight/gpio_backlight.c | 10 +++-------
 drivers/video/backlight/l4f00242t03.c    | 34 +++++++++++++-------------------
 drivers/video/backlight/lm3630a_bl.c     | 13 +++++-------
 drivers/video/backlight/pandora_bl.c     |  4 +---
 6 files changed, 28 insertions(+), 48 deletions(-)
---
base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
change-id: 20240304-backlight-probe-31dee1efe662

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


