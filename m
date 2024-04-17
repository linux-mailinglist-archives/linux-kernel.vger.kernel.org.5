Return-Path: <linux-kernel+bounces-148642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6408A8574
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661A82823B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67AE1411E9;
	Wed, 17 Apr 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqQJwV81"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986EA13F436;
	Wed, 17 Apr 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362419; cv=none; b=svOKEL2XlC2XjklgrRBLIgABjSN6tN+0AaEgKDAq6sSE99eJjW9TgsktygFz9IMw4Y8caAh6OpABgDTYgGZKoz3NlrPi+bnXzdGfhaN1pwkVsx86I26H1HRf03c0OaXs8KPGtsBzVNeJl13oRllPqtpQTFllF/WSWPMb9iHhtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362419; c=relaxed/simple;
	bh=poycfEjd07nE687ukSESANnrC+zUdZahfmNMKFeb8Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAaKWr39orECuqpuweq7JCCEOq1Vuo5o21woKH/w8PHb8DpCVfmVUySRXfKnpSvIwf4ES6OtXxagOBRYuguo1m55wgYrvdqGbPGM7x07d8HUmQXUoUfV1XMjIl8+u2FIPsGPOA3RQVvjdhUGvecRay8F4USFPfy6bLWnii4QcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqQJwV81; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d756eb74so7054612e87.3;
        Wed, 17 Apr 2024 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362416; x=1713967216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8h9sytoh0eNCRrXIWGk2wWof0lykgyqJVSMJYB9Jf0=;
        b=EqQJwV81LqudqxDcA1qS/KlLw1WcryY8LGzKPaSF2JWx9VeTeWSvl142dxjaKh4bu2
         fmmXi8zC5RFeTcZZtFCaJMFfIfbCdhs06cgC57ebY5a+pNAmsZmvDli1Us9I8sIn7gMF
         pdGy5fAWWjEF+SLft+poln7Tj1AdMpRCwd+2VIw4C4c3zjDV5PThqiXfKfvMiaNhJx52
         ozJ5lJONRuk2yqW8aUKAx0jrkanMFioqqr3uwKWsQqNSoAESAXmMw+Y028d75etepUnD
         uOc+S4g8qBbPD9aqSbDS8csTIu18XWjrtp6w7ghTSzuQLsQIO7V75iyM7NpRWrlbUL4Q
         Dg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362416; x=1713967216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8h9sytoh0eNCRrXIWGk2wWof0lykgyqJVSMJYB9Jf0=;
        b=Wmuj6h6FDwuq6LgU1XIIoFyLWOXKf6bblvJqxXtBtibf+EraZ6L6olwcXZmjPhXZ3j
         VgiwHzbWGPWvCUzrNlUxQiieKAsNLaacikVp6+LbIUcugUayznl/sbTcykomlKeYsH98
         ABZ9mdiL4rbxBb9C+hZhcLP+tqeEQEuvWBSoEGPKlpYg/Lb0kWNhHyGWtOZzBzzQasc9
         AIE9EXJjnsS4vc4jD3KqudQYkfeZHSRlWjMGdfaad6hEVJTpEbMwRv+t0x7LVN7D2o1P
         lswsLIJibCtAYH4LFtLDFKOIskaPBCFP6cG3sWITlnFfO2s5s+Kl+LordL/qFc+27RcT
         f1fg==
X-Forwarded-Encrypted: i=1; AJvYcCU+lSy+poLpvqslqruS7ksa7H/wbcd7Pfm825IHQIcimbCbMOEFpPjE3M02YQA8da8hvPTE6qxY0r6rnD74alLYyQOI5mPEOQvs+qvDvcXlpkch+ugGbh4EYk0XGHUhAcBrwvqz
X-Gm-Message-State: AOJu0YxoFB/ElcYOFtJ9m+mL903HnD8HrTVzZKe0rd06iOvI8R6OWWMG
	Yw5ezDYogE0MIR/2RCyHsJqw5QLlyP5bbNqtxcj42/7COio3WmcW
X-Google-Smtp-Source: AGHT+IHYR8jJSuOJPPMs2fzwb2lRhApbksKgiORcX73kn7lgMCayLUhPAG0NkusHwU1eUl3geU6gaA==
X-Received: by 2002:a05:6512:1103:b0:519:3a8d:2ecb with SMTP id l3-20020a056512110300b005193a8d2ecbmr2701316lfg.5.1713362415457;
        Wed, 17 Apr 2024 07:00:15 -0700 (PDT)
Received: from localhost ([94.125.187.42])
        by smtp.gmail.com with ESMTPSA id g10-20020ac24d8a000000b005159fa03501sm1963673lfe.302.2024.04.17.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:00:15 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <siyanteng@loongson.cn>,
	Romain Gantois <romain.gantois@bootlin.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: stmmac: Fix MAC-capabilities procedure
Date: Wed, 17 Apr 2024 17:00:06 +0300
Message-ID: <20240417140013.12575-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series got born as a result of the discussions around the recent
Yanteng' series adding the Loongson LS7A1000, LS2K1000, LS7A2000, LS2K2000
MACs support:
Link: https://lore.kernel.org/netdev/fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p

In particular the Yanteng' patchset needed to implement the Loongson
MAC-specific constraints applied to the link speed and link duplex mode.
As a result of the discussion with Russel the next preliminary patch was
born:
Link: https://lore.kernel.org/netdev/df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn

The patch above was a temporal solution utilized by Yanteng for further
developments and to move on with the on-going review. This patchset is a
refactored version of that single patch with formatting required for the
fixes patches.

The main part of the series has already been merged in on v1 stage. The
leftover is the cleanup patches which rename
stmmac_ops::phylink_get_caps() callback to stmmac_ops::update_caps() and
move the MAC-capabilities init/re-init to the phylink MAC-capabilities
getter.

Link: https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/
Changelog v2:
- Add a new patch (Romain):
  [PATCH net-next v2 1/2] net: stmmac: Rename phylink_get_caps() callback to update_caps()
- Resubmit the leftover patches to net-next tree (Paolo).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Serge Semin (2):
  net: stmmac: Rename phylink_get_caps() callback to update_caps()
  net: stmmac: Move MAC caps init to phylink MAC caps getter

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  8 ++---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  8 ++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 +++++++++----------
 3 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.43.0


