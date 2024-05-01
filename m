Return-Path: <linux-kernel+bounces-165680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2058B8F66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A401F21366
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302D1474BE;
	Wed,  1 May 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucjyC0Vr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCE32C85;
	Wed,  1 May 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586974; cv=none; b=FPGuA5upsb7BYqxeQHo/kX0VCAZd0iXYgCBmGA2RRIAocaYIIIXSQvH2mCqR13MJ4nIXZD0PlKd8cFhCIHzUxzDtcl4X8NMim51Bc21FQXZidoGlOzGdot1ubPquNG/8XSGqGuYD8g84CWYNsgrabkCReRY5EZ/mGzC9EFJeIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586974; c=relaxed/simple;
	bh=MULF2BuYchdZjEi0jXH/BGhGQooN6HzY1iqm4UGt4E8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W1qS8Q/YrqiZfTwZ4991rmo6WYlI0RFOLvCTpWIMN2VNVaZiLf053j3SJhhEm84f0Lw2lQ+QxX8WIECOHXP+U7wWFeaaD5/s84XrJ0xaBd0JWQVMXdNi3Tr9YW2bEJsy0FgZsbQH7ydfXnTrbjqe8sNYoTF7l6EzUPXDcOQUiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucjyC0Vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D938BC4AF14;
	Wed,  1 May 2024 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714586973;
	bh=MULF2BuYchdZjEi0jXH/BGhGQooN6HzY1iqm4UGt4E8=;
	h=Date:From:To:Cc:Subject:From;
	b=ucjyC0VrS3uEaIvN2xZjQVRM6b6Zdze7sQgkRbpt0xE1GHnUfeQl8scyMiE+UBCwt
	 2ynCEZ76tDRlF56K8GtZkYmry3K/wzUa4lWIo2te8Je+m3C811IYMSKnlThUq9ohn7
	 UhhgyzkD0IHJUIsw9zxL72A8geZpVkKcRPilx4OXIUrnlcn2FNB2AZsD/0J2Es+V79
	 GcZVKbhbE0Ssd03IDucaXl2rLFd1JqMA0roMXMb/D2HpVL++4PKEEs2U+KCtc+Bve8
	 RD1ygfm0Lr1psTe6lJ7Q8MMe5JRdeM8rumd9L2j6MBzCsebC4cMuusRqyGNau+1qS3
	 L6ClQOGTks/qg==
Date: Wed, 1 May 2024 12:09:30 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] Bluetooth: hci_conn: Use struct_size() in
 hci_le_big_create_sync()
Message-ID: <ZjKFWg0f9uU5jxaI@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use struct_size() instead of the open-coded version. Similarly to
this other patch[1].

Link: https://lore.kernel.org/linux-hardening/ZiwwPmCvU25YzWek@neat/ [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d6daf55f0307..c508609be105 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2135,7 +2135,7 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 	memcpy(pdu->bis, bis, num_bis);
 
 	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    sizeof(*pdu) + num_bis, pdu);
+			    struct_size(pdu, bis, num_bis), pdu);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
-- 
2.34.1


