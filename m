Return-Path: <linux-kernel+bounces-9175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F281C1DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A244B25EED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E81679968;
	Thu, 21 Dec 2023 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="L2gO5BZF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913E7995F;
	Thu, 21 Dec 2023 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=1833; s=dkim-tub; t=1703200787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ti5eomPIZbnykEiRIHFWHoRdnkVM3Lii6pCaOjMdzxI=;
  b=L2gO5BZF/pQ8Nx6bOGFAyVa79pauEyOKNK1HfHIfviPLnJFR80/4eyCD
   b0vaArE4+7GDSuNHxERPVBWOs3UnArBZG1Vqwmc7Dd6BkOsqCkzdOpB2Y
   U451QFFETkJK1rkn1NZnhCQo3PRwkBiX9NakQpdWksjcZDgqK3yJytl1p
   c=;
X-CSE-ConnectionGUID: THVcGfoHSOaMWzOeFXAlZw==
X-CSE-MsgGUID: uvaIDAWJQ+yjFuvgSaLsfw==
X-IronPort-AV: E=Sophos;i="6.04,294,1695679200"; 
   d="scan'208";a="14652823"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 22 Dec 2023 00:19:44 +0100
From: =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
	<willemb@google.com>, Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH net] net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
Date: Fri, 22 Dec 2023 00:19:01 +0100
Message-ID: <20231221231901.67003-1-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
socket option SO_TIMESTAMPING_NEW. Setting the option is handled in
sk_setsockopt(), querying it was not handled in sk_getsockopt(), though.

Following remarks on an earlier submission of this patch, keep the old
behavior of getsockopt(SO_TIMESTAMPING_OLD) which returns the active
flags even if they actually have been set through SO_TIMESTAMPING_NEW.

The new getsockopt(SO_TIMESTAMPING_NEW) is stricter, returning flags
only if they have been set through the same option.

Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Link: https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.tu-berlin.de/
Link: https://lore.kernel.org/netdev/0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com/
Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 net/core/sock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa..51d52859e942 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1711,9 +1711,16 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		lv = sizeof(v.timestamping);
-		v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
-		v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+		/* For the later-added case SO_TIMESTAMPING_NEW: Be strict about only
+		 * returning the flags when they were set through the same option.
+		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
+		 */
+		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
+			v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
+			v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+		}
 		break;
 
 	case SO_RCVTIMEO_OLD:
-- 
2.39.2


