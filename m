Return-Path: <linux-kernel+bounces-145151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2688A5029
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B4C2891C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152B12F5AC;
	Mon, 15 Apr 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lmXE0cQY"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F812DD99
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185439; cv=none; b=rEKwZp6IgVpfYh1vARlI5v8DNdkEX/MzwH4yrIkeYjSqjUbjh84x3CqvnDWo1a7Rp2iBgWiU6pnARfCGC/MONR7rrz2nnKZ1+bIkwdvGglwCkaLMywFk0x99dWVAdc5UNBD9pu9QGuH9MteeksnjPmzNl/Y/j0SN3vPm9oBgWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185439; c=relaxed/simple;
	bh=znhcYwJUYzGOpFXGP2YmPF3F/RJw3xsB03Ht+bpAY+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VEbfhUyt4Y+dqLhEkQ2kcVMmRmewF+aUL04xXjVdHhwmv8qCZyphRDN1BxSBF4lxO0hvkgvGAmlrFLNbRO08NCGt5TDWfjDmPTjuEJj8AEAgT3P4Bu9rKO5w7TB3jslSE1RrCuM48EmNNDKsK4jYiBWnVfC3518IaggAWDXH5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lmXE0cQY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D3C19411E0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713185435;
	bh=ReRzghlopjwKf7ZFoLym1/k3KhnDB0D5vdDpSWeIHhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=lmXE0cQYn8tcuqpIitJE84XI3rsx1bM+HIoK2PhLjB2384c0CbuETjv0x1o4rVjeq
	 yB9h7C28QJZuD0ao3Wg+V1oXh4P+FXjhqDJj9OzH33T1y/XlyRHA1ocjyQc6Qyo3m5
	 csDTliq5OeeMXU5Y22Hf0XAIJ0Wl3PdJprzUpVwFWDlga1KLVdViBb2MDpSJvDiFX8
	 gty2KMyivq7teGcHuv79w2hodfZvApGXUwHf6cEQD+/Z6jzD5UYV5CBEc0BdJiV+eg
	 Brl8OvHH9Fau0GAxcWrK5LCFyisscAdZaTonYslL5E01p7mqMzkGOy93iMy5Sw9Ufb
	 5Ow+gBlVwvuug==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a46938e24dbso53767666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185435; x=1713790235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReRzghlopjwKf7ZFoLym1/k3KhnDB0D5vdDpSWeIHhM=;
        b=sVWxcOPgVfA02dkg/0aGxAzE07R/oeZavCyXPVjF/Qcc2V/FW8tCJzfqZjFMY87exO
         hwrI7ONjgfy/7lOu6A/r1+wh0SfAQrDiIbQ03XOX8LwfSDKXoZrv1c6IA0MjMfR58Ar8
         n4s1Iu0FnbMiHiV3a0/9Yp5nq2P0lrrJXNWmDLIrTlyQY46UCzDM5V954dEcvDIAYh5j
         LmZ45ymvqsspLwceBxqxmzmlg+TXzLrrUpJEthoTXTeGmI/GKI0Wdl0mJel9nh2QHiXV
         Vy+LkpQpgTBJJzhmpVsAHIHF09QHIvZ52Co2eey5zs6WoR+jjrlm+6IUIBwvrxAPagzO
         UTgg==
X-Forwarded-Encrypted: i=1; AJvYcCVq5PinJIbfCItyKklLLmCFRtQemqIn2WS9LnIHCfEePRqX70mfo5gN00w3KwsIBbKFd8QOBCHSH0PqKBRNn/TRj2zui4hZQg7Jqbhi
X-Gm-Message-State: AOJu0YymJ+KCKaezMMf3BjMtxTMkgNwfrpq0D17yjF4MvEtPN9YGaiCn
	LuMz7GO8KdEWEzrpsmpbF5vRdU7oFEOHFMUflyFpTBDtCGLeAwESP4fGgmP3A4JV1fJPZO0L7uK
	eCtsTyQPnSNxRykyqkfE9DHDxpsdgJELCHBwmKkoPZwrwVjOqgCdgubig64HHNK9YlNnci8Qn6z
	yLy9BbxEME4bR2
X-Received: by 2002:a17:906:6a04:b0:a52:55b2:ac40 with SMTP id qw4-20020a1709066a0400b00a5255b2ac40mr3424824ejc.3.1713185435355;
        Mon, 15 Apr 2024 05:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl2HDhIy+WQcJGTsKSEGLwyKxvTqmVqEld+FSqkIKcpUnlu0ruSuJZgCJL0RGW8urzg1aMlQ==
X-Received: by 2002:a17:906:6a04:b0:a52:55b2:ac40 with SMTP id qw4-20020a1709066a0400b00a5255b2ac40mr3424805ejc.3.1713185434966;
        Mon, 15 Apr 2024 05:50:34 -0700 (PDT)
Received: from bojack.fritz.box (197-53-142-46.pool.kielnet.net. [46.142.53.197])
        by smtp.gmail.com with ESMTPSA id bz2-20020a1709070aa200b00a51a9eccf2asm5455573ejc.125.2024.04.15.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:50:34 -0700 (PDT)
From: Hannah Peuckmann <hannah.peuckmann@canonical.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Walker Chen <walker.chen@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: [PATCH v1 0/2] riscv: dts: starfive: visionfive 2: Remove non-existing hardware
Date: Mon, 15 Apr 2024 14:50:31 +0200
Message-Id: <20240415125033.86909-1-hannah.peuckmann@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the device tree for the VisionFive 2 which has nodes for
non-existing hardware which should have been left to overlays. It also results
in error on boot when both both the TDM and I2S drivers tries to claim GPIO 44.

Hannah Peuckmann (2):
  riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware
  riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware

 .../jh7110-starfive-visionfive-2.dtsi         | 98 -------------------
 1 file changed, 98 deletions(-)

-- 
2.40.1


