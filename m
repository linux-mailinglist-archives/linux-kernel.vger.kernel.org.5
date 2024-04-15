Return-Path: <linux-kernel+bounces-145634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E58A58CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D29C1F21B73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A347128832;
	Mon, 15 Apr 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICWAmSFL"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275C128801;
	Mon, 15 Apr 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200878; cv=none; b=qPMWWGrNvKhZk3LUm/wwi8OY61sP01IHwpTppdTRY5v8BpabYM/r8OsZCeXAVHfdPVUodQKSnZfnsWqG7dbju63XsvIbNHwNdlMWiPSAahsM0lyv49c7llx5g+oX5NFHpSeYY1xEEB2gKBc3jBu783TW9vfMNGVmb/9UHCp/CDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200878; c=relaxed/simple;
	bh=RID0/aQYxBv0aP8raF74K1S8qXOAxKprqEOVTYrnyVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HJY1flesLD2Thzrv+ev0r9LlK1lSdfA42uIZfooPBo9MVrfSzOdIty4LAyowZt1VE+PCZ2L2+lF0WjGnc6iK5HRYJyApy0plmReluLpFgb09O+hHAXEKFRiF7bG9wuveIHeEVXC/ag0gr/SoMGZbAzrzE14MrmCdKseVZAnrey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICWAmSFL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so26747085ad.1;
        Mon, 15 Apr 2024 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713200876; x=1713805676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABeytDe9J6dRcflLX7NGphJIPq806ptdx9PirUfiALs=;
        b=ICWAmSFLV3hUATzqtU9008fEDj+994frngNyodYyBr+mI1KKTFndZ38p1xq4cvQ5Uc
         b/ELfoAy4tztSpt2q7zdfx5tImoXlm2Ee9kpmrnH6WJkXPx4NY3a7GX5JE2i09o2L96F
         evBOWyj4xFCh7/d2/nzV5MEWJyviSpSHulBogY3UdVPjCjB4OyqqWcuW0EWSr2nRuKiD
         PP1eABYCLLRXjBEdocdG46NL3GmMLgwiX8llMyG961JbzPsE3nFluP5FWz6ajCAV2M+V
         7pM0VVDm3rH/7KF3FGIe4kdm5xODurufjsSuKUIEJH1Sl/P/U/01v6HUnZUIdyjGbntE
         l55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200876; x=1713805676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABeytDe9J6dRcflLX7NGphJIPq806ptdx9PirUfiALs=;
        b=T+1p2RZIHw9U71lhs7SmIKnKUrgXWAqnwIzG1CTKYANgNAcyr3gDl5kjaLqkjAnaZx
         +l5WYKMScpH5zgLpBDzd5oQLgh6uMLVxChoO5hFDgDuvH7nWSWhBmy4R8e4llnC814md
         Icc+o5up3cUA5DLfs6yNooTo9Dns1nGZro+Dm6S5akWHeqhikKWFHQi7nENOz2QoTJAF
         38moxqw0C10ymwEF+EYpUhBCriPaIKEVh7w4yJYNo4hrfBJWPrYw0ocvFdEW2+Hnpgqf
         NQBpwi2VDwSF/qvqmXYhEDC67XHSo+id80Yibd2ICyW6wXFzAB/YuMEEPSA1ITuxyKEK
         NgNA==
X-Forwarded-Encrypted: i=1; AJvYcCW4F97JLCqVkg5X23Ag7NTgVQZ56Dvk47L8jH2Beoc4hUet0Emf25KPIDrLOATT1N1Qowp1lR2Y/ktVbGCKUXXjFqu/HZnX2qLOYFTB
X-Gm-Message-State: AOJu0YyDtxPmMI6gmilYMB8NSUeULe7fRODihHGyLbMiVtTecGU2M1xi
	UY2LoUSMMFZU9Z0vZ5s/bV+DmIOuCdfHg6E/f0C8SKwfb8iKt2kezlSMJoFKI/M=
X-Google-Smtp-Source: AGHT+IFmY6HG7aEbZWz6ebnGSVKgwSHHukUej7AD0a/vPW8YKUrrgoO1ZxklAg3N5L/vACRKKPeISg==
X-Received: by 2002:a17:902:ecc8:b0:1e5:5be7:be86 with SMTP id a8-20020a170902ecc800b001e55be7be86mr11674236plh.52.1713200875970;
        Mon, 15 Apr 2024 10:07:55 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902c60100b001e0b5eeee41sm8203983plr.38.2024.04.15.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:07:55 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: [PATCH v3 0/3] Add ArmSom Sige7 board
Date: Tue, 16 Apr 2024 01:07:34 +0800
Message-Id: <20240415170737.49350-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Update vendor description in vendor-prefixes
 - Link to v2: https://lore.kernel.org/all/20240413153633.801759-1-liujianfeng1994@gmail.com/

Jianfeng Liu (3):
  dt-bindings: vendor-prefixes: add ArmSoM
  dt-bindings: arm: rockchip: Add ArmSoM Sige7
  arm64: dts: rockchip: Add ArmSom Sige7 board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 725 ++++++++++++++++++
 4 files changed, 733 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts

-- 
2.34.1


