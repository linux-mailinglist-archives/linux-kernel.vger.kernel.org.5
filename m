Return-Path: <linux-kernel+bounces-75148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2B85E3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FAC283645
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22770839F7;
	Wed, 21 Feb 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6y2XApx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE97FBC4;
	Wed, 21 Feb 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534621; cv=none; b=qXhanSMZXCEG0EzDk9s9wxXDBjfH/uqbOrtL3k3pZFjPEhHKX1NQW+a2z7HdGwlm0Eb52W47eMLFAjatHRpd+JzSalZ2X6fMf8qivlZcmdGwBxi+42idHFXfCY9vZVXKyGpQ8ZkdSUZ1y6IEJb/X4TsRCf8PipT55mjAgX+IuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534621; c=relaxed/simple;
	bh=fKXceB0Gk5Qi2BTh8FnrZ+MT+hE3FOYlCf2QUIU2XXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FCs5+dJlzdF7G83G8MKneF405apamR9cipsdX344vJkUwA9kUmMQTGIKoRh3yJ50X7W3R4pwC8AbdbTSOL+hbarskB7HorbrvqhsLC8WAYEydpS+UDHJpn9RlOE4BL8RYh0AFtZf9G68fguU3znm0P3AIceu1aukiwTxZ1/eXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6y2XApx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2284BC433F1;
	Wed, 21 Feb 2024 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708534620;
	bh=fKXceB0Gk5Qi2BTh8FnrZ+MT+hE3FOYlCf2QUIU2XXQ=;
	h=From:Date:Subject:To:Cc:From;
	b=G6y2XApxOSs9SZl79EQohPRj/X5MpyJELyXCc2UtgTxkX488zdh7HWdDR+lyX0unX
	 CUJ3F7ZZbY3Vx2bdoT0jpYzMKE1H9IUANbSkmtC/wtbJFE8gw5IkjPu/GucJ+ibf6Y
	 88tDFcattShPJ7M6gdeISV3hDqCuzLs2iKAmubTOYAxlgjmAHL/Ure//BNYZT+JXVD
	 ugZUI3LvAbt5KssDhcPEKqu2br9DI5l/QW1EVY8L8rhcEEHlMg48HzlCALNApQfYyt
	 gpH+W9lLfViXuIrXKtO70sqLRd5E8bI/RFu4RbsPzbktT1Gd1Ec0M0V2ZPWQjOfv8F
	 NCve65P6JPhpA==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Feb 2024 16:56:47 +0000
Subject: [PATCH RFC net] ps3/gelic: Fix possible NULL pointer dereference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE4r1mUC/x2MQQqDMBQFrxL+2g9JWkTcCh7ArXRhk6d+CFESW
 wri3RtczsDMSRlJkKlVJyV8JcsWC5hKkVunuIDFFyar7VNba3jPD14QxHH8hMAeCTM32ji42jS
 Tf1NJ9yLld29HGvpORRz0uq4/qOxVpW8AAAA=
To: Geoff Levand <geoff@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Jeff Garzik <jeff@garzik.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3

Fix possible NULL pointer dereference in gelic_card_release_tx_chain()

The cited commit introduced a netdev variable to
gelic_card_release_tx_chain() which is set unconditionally on each
iteration of a for loop.

It is set to the value of tx_chain->tail->skb->dev.  However, in some
cases it is assumed that tx_chain->tail->skb may be NULL. And if that
occurs, setting netdev will cause a NULl pointer dereference.

Given the age of this code I do wonder if this can occur in practice.
But to be on the safe side this patch assumes that it can and aims to
avoid the dereference in the case where tx_chain->tail->skb may be NULL.

Flagged by Smatch.
Compile tested only.

Fixes: 589866f9f1cb ("PS3: gelic: Add support for dual network interface")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index d5b75af163d3..f03489799f5d 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -549,14 +549,13 @@ static void gelic_card_release_tx_chain(struct gelic_card *card, int stop)
 {
 	struct gelic_descr_chain *tx_chain;
 	enum gelic_descr_dma_status status;
-	struct net_device *netdev;
 	int release = 0;
 
 	for (tx_chain = &card->tx_chain;
 	     tx_chain->head != tx_chain->tail && tx_chain->tail;
 	     tx_chain->tail = tx_chain->tail->next) {
 		status = gelic_descr_get_status(tx_chain->tail);
-		netdev = tx_chain->tail->skb->dev;
+
 		switch (status) {
 		case GELIC_DESCR_DMA_RESPONSE_ERROR:
 		case GELIC_DESCR_DMA_PROTECTION_ERROR:
@@ -566,11 +565,14 @@ static void gelic_card_release_tx_chain(struct gelic_card *card, int stop)
 					 "%s: forcing end of tx descriptor " \
 					 "with status %x\n",
 					 __func__, status);
-			netdev->stats.tx_dropped++;
+			tx_chain->tail->skb->dev->stats.tx_dropped++;
 			break;
 
 		case GELIC_DESCR_DMA_COMPLETE:
 			if (tx_chain->tail->skb) {
+				struct net_device *netdev;
+
+				netdev = tx_chain->tail->skb->dev;
 				netdev->stats.tx_packets++;
 				netdev->stats.tx_bytes +=
 					tx_chain->tail->skb->len;


