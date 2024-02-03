Return-Path: <linux-kernel+bounces-51135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFACB8486ED
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22811C218D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C95EE9A;
	Sat,  3 Feb 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="C3eu6XJy"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F95EE86;
	Sat,  3 Feb 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972656; cv=none; b=U1jGYaMk1xpYOrtVnGQpbccdcLxkyEHx+bYnLoMc/857t0KJ2IkIdXHUblRE0X1myTwULXfPRvqgSUPr6RPj4tWjGpOk/iG2WEKacwSeePofCuAhG8DxoOPTMeQFPQ6rjQKb9dJYsqlholcSBIB+cE5JuUz6QRXkxht76HPZExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972656; c=relaxed/simple;
	bh=2GLWDPQIEiSm6KySEb3j7J+GjSJV+EXcOoENDX6iZHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3qxAu4zhj8IN4ohUJ5X9sU8Y6D00wM7H9FZfp8fb/9c2p9/Tgb5wPrrFua3sLWwNAJ1qUttS726t9CBDCGb1z2BZUMpsalwR5lkqKMnEkLE26RukwONrbPTzG0G3KqU564tb8GbMQs84xMRrkbQRXqOlGXkHnPpReti2QxcHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=C3eu6XJy; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [85.89.126.105])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1D2E440F1DC6;
	Sat,  3 Feb 2024 15:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1D2E440F1DC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1706972644;
	bh=LWaLolZLVHoMja/NNNmsmRp6PTzwtZ8CVFd3EvB8tPA=;
	h=From:To:Cc:Subject:Date:From;
	b=C3eu6XJyaDUjR+G0C86mQ6ZfmK67QE9aFBH75t4eJo3MG0wzROpenuGRldhsUG4ya
	 bJDGjp7dsn6YzyhElq58earXsrx1xa1OQfmp3tZa4EUTtBonJaKLW5gkzcCyWyzWIl
	 +ryFZYP87zIgqKq665ykwGQdkm19rjtYVL7cCh9w=
From: Pavel Sakharov <p.sakharov@ispras.ru>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Pavel Sakharov <p.sakharov@ispras.ru>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] stmmac: Fix incorrect dereference in stmmac_*_interrupt()
Date: Sat,  3 Feb 2024 18:03:21 +0300
Message-ID: <20240203150323.1041736-1-p.sakharov@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'dev' is NULL, the 'priv' variable has an incorrect address when
dereferencing calling netdev_err().

Pass 'dev' instead of 'priv->dev" to the function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4727f7be4f86..5ab5148013cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5848,7 +5848,7 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	struct stmmac_priv *priv = netdev_priv(dev);

 	if (unlikely(!dev)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
+		netdev_err(dev, "%s: invalid dev pointer\n", __func__);
 		return IRQ_NONE;
 	}

@@ -5868,7 +5868,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	struct stmmac_priv *priv = netdev_priv(dev);

 	if (unlikely(!dev)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
+		netdev_err(dev, "%s: invalid dev pointer\n", __func__);
 		return IRQ_NONE;
 	}


