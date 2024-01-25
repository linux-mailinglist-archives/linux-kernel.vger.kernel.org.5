Return-Path: <linux-kernel+bounces-38338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2C83BE07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB011F2E969
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD231CA8B;
	Thu, 25 Jan 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="KRrMtcPM"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614611BF33;
	Thu, 25 Jan 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176415; cv=none; b=IlCjbgNvwEDNyFejH/2rBq6fkF1oZQbNBBPVxcukUgfQj/+lHTBjrrkEH60GX3V+IwRcI2qoxSa/93BzRArX+4qusdB6wCr+jW09clHAxMLXl1WNliD3RRwg0iZPc+C6sIBc6E0iPFa8Y1sok7y3s2CWTI0R93NtIZvc/Aju6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176415; c=relaxed/simple;
	bh=MOQWUs4LfrqyBim3cdZJiOlBAObGGDGpzuE1pIY1Gwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtRk/8T67nRMUOc6HOO8g/F3m/4Nwzkh4xZkpQ/2xOFE01rivhKw5NjxVNjR62wI+fYc1BDYb25IBNE+uKxY2qoUHfxwxQ3zL6t6LKg1khMQdpY2Pc67CFc5XrOK+UB2BHEkKJKL2P5mS09XnM7FaikUVZQUWoZNwiZwMYpIQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=KRrMtcPM; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 755C04076731;
	Thu, 25 Jan 2024 09:53:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 755C04076731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1706176403;
	bh=KQrR+5BkSPmu/kRG4OwqNQfdmbL9yFyULUlnEV6F95k=;
	h=From:To:Cc:Subject:Date:From;
	b=KRrMtcPMC+9jDKT+AIn/r5Lj8MaJLvhTzsrcsyy3xGxnr7uDd+F9aRmE1BdU0jfE2
	 AAfNyzDjwRfyNf9T6Kx+iqsaazo712CpMtE8/9mEp8tKVgNpjuZU0HBhneWS7q+l0E
	 o2bP+OZ8QbLRtOmmzA9sT/4Go1hKPCX2hzTOvaRw=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ilan Elias <ilane@ti.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org,
	syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com
Subject: [PATCH net] nfc: nci: free rx_data_reassembly skb on NCI device cleanup
Date: Thu, 25 Jan 2024 12:53:09 +0300
Message-ID: <20240125095310.15738-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rx_data_reassembly skb is stored during NCI data exchange for processing
fragmented packets. It is dropped only when the last fragment is processed
or when an NTF packet with NCI_OP_RF_DEACTIVATE_NTF opcode is received.
However, the NCI device may be deallocated before that which leads to skb
leak.

As by design the rx_data_reassembly skb is bound to the NCI device and
nothing prevents the device to be freed before the skb is processed in
some way and cleaned, free it on the NCI device cleanup.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Cc: stable@vger.kernel.org
Reported-by: syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000f43987060043da7b@google.com/
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/nfc/nci/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 97348cedb16b..cdad47b140fa 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1208,6 +1208,10 @@ void nci_free_device(struct nci_dev *ndev)
 {
 	nfc_free_device(ndev->nfc_dev);
 	nci_hci_deallocate(ndev);
+
+	/* drop partial rx data packet if present */
+	if (ndev->rx_data_reassembly)
+		kfree_skb(ndev->rx_data_reassembly);
 	kfree(ndev);
 }
 EXPORT_SYMBOL(nci_free_device);
-- 
2.43.0


