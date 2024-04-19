Return-Path: <linux-kernel+bounces-151210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A28AAB27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5231F21E24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E37641B;
	Fri, 19 Apr 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7uc1pKF"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2565194;
	Fri, 19 Apr 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517448; cv=none; b=sbO+29Y9n8VMecoUUSdUQd2pEvnfrHPXMa7Jfk4UJwnv7SgHt8gdq013z4gR/i99fTx4onykH5Eel3Hyq6/tqOfyGG09gcu3LJPqVFqgeSz11i0PCIuPj7M4+ahLrosfDhwIX+H7+8sTlipHqmQhvvVe+ekJgz3HAEwgwxb5d+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517448; c=relaxed/simple;
	bh=nyEbjzkCc7+KWWvrhINgBitJsBsfmKTLRX81KrOL4UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RukL6C28wHp8wBLayz6g55k1okdoTKdwHykPh+qbn9Q09yvLMkURcEjuNsL4r9i57Y8zFC9A4G5UupX3o5KT8E0W52zcQWr1Hb3YTeTd4dQk/nmrY3RhCuZ4kFSYwEBN48EG7BMsF8ZfNtTo6jNqNPgHisBzIV6vDtZtRqrYvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7uc1pKF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso23167541fa.2;
        Fri, 19 Apr 2024 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713517445; x=1714122245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZYagrKgL3oRgietAYozGj1whRQiP+RdxmQVuv0PkQ4=;
        b=D7uc1pKFonaMVXKp5YNvXV3/0saeDj987UTchGspZhVVWCzaIH1XcpLfJzsFXgyGb4
         keh8MziVO2J+B1dKS6WiCbKSnKep27OgcniIxtep9Sg5oi5D4Tt84ug/e1FgSlRDC0si
         mEVzkzBepoiWesxLIWDPJTGhuDIJKtmz5u10QsIVCmvZz8wbqJk3MWdVvoAJfq8VUubJ
         4w3uR9BZJpv0G7Zv/7CABsfF+XZHnYSWWMXT0sLEWHEyyf192n8GIfIFOUF8Mtkjb8fD
         V2RBRmoauPPWpNCXRV2OeTwc/akkhF/6JxB0I16UImmqv5YLZQAY9Fc2H9wgg2xotJH/
         Mpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713517445; x=1714122245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZYagrKgL3oRgietAYozGj1whRQiP+RdxmQVuv0PkQ4=;
        b=G3cIlbeOo+dM/hf21xXfruutsqhaMmte45qi+geXC9oLo0EfctPi1yt9eW1M6DvQ7Y
         c+ieo5k12Bt632M0REtXp71kJ9qx9VcoiafFC1Hfg2yHdJeO+/5B+iK8Dblv3DCRM20J
         YwCyjGV2gyEMdaoz3fUxXEgh/jSdKGD0N1VVR7u1i4kX6bHvPba1wiTNbTs9VuJFA4+j
         B7f/dfpWPQUuMnTmXoO5gBJLx0N0BHBmf01HL1hoVVegaXznYbwaWsS9ZX7KP3131VcN
         4ruwegu5bK4LDBJfxw/gay8UVGkxqLeV8eqqEAX8MmOOEsSszE7Q75wVB9XDIbDOa12X
         riUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx3IEk64fhDwevjVORTvCD5WfdNwjkmubQNwihNN0dZuuglSdgtjb57VRRUS968jc7VncdOqZroWpvF+PqOtmlIl2c/YqZWu6pkaNzg0JjgqfXEnNaGzXeqTIwlBeywMvRGGZK
X-Gm-Message-State: AOJu0YzC5JIE2C/38nLg/lQhin84zJNEBjXtaw8dNFPBbPpYDjVcoz7w
	I9TsadvRFcB3ZKMlJZA6DuZQ8ah9gcebu+yIOh7MhZQFeAD+DPa5
X-Google-Smtp-Source: AGHT+IGg1RrYLe0BtHyA885HiTeG8lWReO6DWGy/i3pNp212dINrX0hNxqF4nt96xYKpLfOiYPULBQ==
X-Received: by 2002:a2e:b90d:0:b0:2d8:a921:dfbf with SMTP id b13-20020a2eb90d000000b002d8a921dfbfmr863882ljb.19.1713517444592;
        Fri, 19 Apr 2024 02:04:04 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id b10-20020a05651c032a00b002dcafaa0993sm355004ljp.14.2024.04.19.02.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:04:04 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v3 0/2] net: stmmac: Fix MAC-capabilities procedure
Date: Fri, 19 Apr 2024 12:03:04 +0300
Message-ID: <20240419090357.5547-1-fancer.lancer@gmail.com>
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

Link: https://lore.kernel.org/netdev/20240417140013.12575-1-fancer.lancer@gmail.com/
Changelog v3:
- Just resubmit (Jakub).

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


