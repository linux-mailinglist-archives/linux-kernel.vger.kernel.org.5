Return-Path: <linux-kernel+bounces-2592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE722815F30
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A2B21EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFF44380;
	Sun, 17 Dec 2023 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="jaJKRVZz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981814317A;
	Sun, 17 Dec 2023 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siddh.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1702818675; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=AQdENfINNapZlrC/EctTnMZUARzUjwqbKHHbdEEIS+PA/YJq9Kr7O1NZFI/0CjCG9HNKGuBKx6jj7a9S5baUa/ElWre7+dGz5AiN1iCDebo4hOAojZCx+c4WI458hKsH2utYDcwJXDkSFJR5GguCBcu3srbWSBPiG/tqzspomMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702818675; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=; 
	b=RnMOfZmQGs6b+piHKyDlptYaeFtNUGn/VMBA0li+cpBYo4RoyAjFTb6QaFQ/QE19T2AAarLo69XjQ+A0AXp+8VOOEmZf25rvAYj4qOHEQBT/0N0cLZYhgcZ3YaxP/UGrKhg+q+PsXrZRIq747QSemHYzlChItQpMFHIXewCHScg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702818675;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=;
	b=jaJKRVZzCRbtac7qltv2l3keyMs1H8djk4xukyoEvvldO4gHlQB+2ZaM8m4ybNSg
	IY+MFe+jnwoU0p74HFXy6VvahDRpCQIkXcLOYKKG0j/6XKcWVGbbxOkEU71OM3AgVSI
	OU/VVQH77liZRBQ1Vgt47cjBXciQUwM/8e9nkmLo=
Received: from kampyooter.. (122.170.167.40 [122.170.167.40]) by mx.zoho.in
	with SMTPS id 1702818674595848.1274981870353; Sun, 17 Dec 2023 18:41:14 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Suman Ghosh <sumang@marvell.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date: Sun, 17 Dec 2023 18:41:04 +0530
Message-ID: <c4e2435c57cff7f650c0a82c2ded12c0d1843b80.1702816635.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702816635.git.code@siddh.me>
References: <cover.1702816635.git.code@siddh.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As we know we cannot send the datagram (state can be set to LLCP_CLOSED
by nfc_llcp_socket_release()), there is no need to proceed further.

Thus, bail out early from llcp_sock_sendmsg().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Suman Ghosh <sumang@marvell.com>
---
 net/nfc/llcp_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..819157bbb5a2 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sk->sk_type == SOCK_DGRAM) {
+		if (sk->sk_state != LLCP_BOUND) {
+			release_sock(sk);
+			return -ENOTCONN;
+		}
+
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
 
-- 
2.42.0


