Return-Path: <linux-kernel+bounces-125830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD22892CD6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D56EB21F32
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D342AAE;
	Sat, 30 Mar 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBSNLCcu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036F41C7A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711828198; cv=none; b=c4RzoAk0tAoFh2FjroRxyoFOpHNzja1j0jlUqLaoM0vvZI+f/5t0aWl1vSWeqlbuUk9frSuucmq3mKkz52wh1f3jfwORWwKdZ+exfX7qtJos9mzFl3/O8ETubshaYcezw9HtFey0A3xC+tgKLwWgCv46taqUSXcxv9YggvZR4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711828198; c=relaxed/simple;
	bh=8Hn+EaanEab2JDM3jBg92mm8pL5wCUVEzB3roEcU3XM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a7a1m8QB+rCX1rhaAJe472lGJEs8sytPIs/AeXoiYZtIIR0S42FJ9NL2rOyr1+OVrbe41CNJGvxEev13I8uaBCNPUraGPFufaf+2A0pMV4yepRsR2L3FOMzoknhyrDHCskatM/TFyRlraOkMx/wmxMY+VhYRmeSuNYcUsoCzrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UBSNLCcu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41555c45497so5645885e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711828194; x=1712432994; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3qvF39pRy4R7BnWph070mUCSaM92GVdkELZj9hnNrI=;
        b=UBSNLCcuZzxoZTUVLYUYGUmbEkd7tFd9GQ84gdeUq1FulkjcNxvo5/oSzQP1YO/DbF
         vh30qPiCN+0ImI2bXoAQooMUj0IviAowa1Izvn5Eg7TEAe5qjwJLISZ7S/iIx/Oo2dmt
         1kogqZPBGxi3MsxbcNWs1Yolytouj2tqkbwzvreKFaZC4HR2zo+3YFUHmcYRr3Ad09Rk
         glMBEZ9JP6s51+6sA9Bj+NTlZedl3ihOUuRkDmeyrA1TX/TBq78+O5Bg7euMXa+3JfhE
         N1BGOFnzStJ/jrfFfwzMteiSH+zNN2LxHv6LXR3Aa9g/yDIaNAANebwjqnlllTFxJs1M
         fWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711828194; x=1712432994;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3qvF39pRy4R7BnWph070mUCSaM92GVdkELZj9hnNrI=;
        b=gONCw/8YnaPtsEsZdiLTgIxr5MjUcto1ekj2hgjk/72zPy4fsfpzDDCNJCGbGlzWED
         M2P8RywJP4+l38MNAUCPCk5OeuHEijiqSXRoXZQ5GjBnWDBr+77O5IDOYuKQFHLGsON/
         x6v2etTQRjnOXquCo2Mnqkn6rguN4j6AmeCksHToGRzuHx+IW0L/4UaNSJV2rl7Sokrk
         ZoC2JCcPwxvKwym+00C06aLbG73iY03LxBePIrGbVeWrDLRr6vcloqcLmhafjzkuS//S
         woti9j4pvOOV5m9MMbeSluEvNfob8Y1gxtP2clvU14SuVLZ0Rtb6wtj6RhPn/VOfCZdw
         6Rjg==
X-Forwarded-Encrypted: i=1; AJvYcCVSmQ0vBeBITpRE8JK7F9xKnyp8SPDZcozS2EThGPMeXWNWEhqm2ovjk2QhAVg2Pm18pvElt7SOCLmc+MpQsnXJeReLj/C71j3MSZlZ
X-Gm-Message-State: AOJu0YzZnzXk4U797HqhW1ueOtKaqljxnJbaK+kIZ9LpnWJa87kQWNfQ
	4MNt6PaIZHmkAWrt841UYMzGnDcC1LwS01WlAg+i9Eq7oLIcO3zc+G6br8i+D8rRC39R9S2FsQJ
	6
X-Google-Smtp-Source: AGHT+IE3gSn+oNncAsm/dayJ48d8laE2Qkgr41iVHwDyp6+ittqexJxaB96H/iB25pmLYxCeQPf1lw==
X-Received: by 2002:a05:600c:458b:b0:413:1741:28b5 with SMTP id r11-20020a05600c458b00b00413174128b5mr4216995wmo.9.1711828194038;
        Sat, 30 Mar 2024 12:49:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b004148b9272a7sm9571616wmo.0.2024.03.30.12.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 12:49:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] firmware: coreboot: store owner from modules with
 coreboot_driver_register()
Date: Sat, 30 Mar 2024 20:49:46 +0100
Message-Id: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpsCGYC/x3MTQqEMAxA4atI1gaaKsJ4FXExtdEJaCPp/IF4d
 4vLb/HeAZlNOENfHWD8lSyaCqiuYHo908IosRi8861rGoebxs/KqL/EhpMaB9U3ErX+4UMXiQK
 Udjee5X9/h/E8L7hn9/1nAAAA
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=758;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8Hn+EaanEab2JDM3jBg92mm8pL5wCUVEzB3roEcU3XM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCGzeRXDsRJEM2OslU9yvkcI2tGi9th0cFwYar
 aJd0L12reGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZghs3gAKCRDBN2bmhouD
 13hoD/wMYbrajMMjmQW4hS7pjoIuKEnwY5kmJgRN1cIcYK92El25pUsbdGjwQWhQ73PG4PJwoHt
 KwgIM59LuLWd+tYs64ui99Iyco7+Kyn09Dx236lILomAV36rMdU7GXDtH1PqeLmcYzz4F17rnhU
 az7lu3p5YtKI2j+jUg11dHa7gRezQbwR0007/CGRZuZRbmWL3NCAGVbo5tsnp2BGNL1RzbnrLb3
 5aPwpn56p62G9OK1DmkzVg5KP16je04s2Wg58P3DZE5KU87wjBjlANYH01+3GlBWaTnf4aOvoHB
 T+hJgxNgIVp8hQM5aZnjxJ4D9yPp/vCgTmnriRlngKdw6bsoly/KQkq7fDFTpk3SVMNxzIUK80y
 YxKDxm9Xs/Z1VYOme0GAANoxktPFgD3EUKJi0ay+2WDEfIeZlFeDXjmZD31sxGQTooPRIddrjH4
 76UbkeoBHld2cfAULg7laTuRTLLUTu6bZHu/9kFEVHqegYiJzhLaKBbHEv99XQGfxhCd3xROGQ3
 9GUZU92fRT2fk8lza2cvKw6d0+lF3MvxRFtZspQ/HITQShmhd2oGNFxAfZAk2XG/ETCskEK0fQL
 QlPG6cSQ5Y+GY6eT7FQnY5FwjhlUqLYiVIa1J7zmKYX6Ltjq5ZlWdXXQ7W2yxALGataoKDmd796
 6xJGrZLYlxL7lEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Moving the .owner setting code to the core this effectively fixes
missing .owner in framebuffer-coreboot, memconsole-coreboot and vpd
drivers.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      firmware: coreboot: store owner from modules with coreboot_driver_register()
      firmware: google: cbmem: drop driver owner initialization

 drivers/firmware/google/cbmem.c          | 1 -
 drivers/firmware/google/coreboot_table.c | 6 ++++--
 drivers/firmware/google/coreboot_table.h | 6 +++++-
 3 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240330-module-owner-coreboot-114292b6d11b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


