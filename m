Return-Path: <linux-kernel+bounces-39592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99383D350
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A12B211CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F6B676;
	Fri, 26 Jan 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbj9jiqf"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3BAD24;
	Fri, 26 Jan 2024 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241889; cv=none; b=HQPcHmEiOq08HSzrwgIJjORPxZBePFrtUO3Yj3T/rFSEjygbIveDv/oUTOcF2fAtvWmeVGQjcVa0eo42EFf3bcz363OyIP4r1PyAKQFBkROr2P88V0rcXDtik0VXOZvW4DzjENTy660r1sK0PQMevlEV0t7wNMZ3BGqwreSKzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241889; c=relaxed/simple;
	bh=SCBDTIFp5Oa+p2B70IVbRbYxNcHo6/4gglLXeZTY/lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LopHvfjwjbUGMA6m1DPZQRwE2eJP1Ueb84zC35+/CNwb2ewRK5I1lBrovFRosae/KhVriDfRKsZ4KRIS5/5hEgOpTRdsD8KAMGi98/hpBBuDvlFfipDSYTVud1Pc/MAzQjKsfxvvZG4JvHIJ84J6ftSukH7mYcXyrZbN9NOSCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbj9jiqf; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso3569677a91.3;
        Thu, 25 Jan 2024 20:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241887; x=1706846687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlunNru9PY7fh+ZApVP//S1AWHwdUATQshEp6xsX0fI=;
        b=nbj9jiqftIkQcMymZpfD4bO60+Fx7AkhwxUdKjf11SUqi8RL1aPblmi1MYiu2JoBLX
         ev7CXyTKrASSKOO1Yppa4A0sO/k2vJQzecToNwAvQqEhNdXueT8OS0iyheFV030KWnr0
         Z2wRd4Ip1fDWDldhYplh0lAHKk8XMARZQulgMEH5ZKjA53UNy/MdC6zL5mjrVUZHhK6z
         ZHDV60SZ4HmM0oMri6J/YX3EXvzokhBM1AeGmzksoltlcnrPqlmgQO5M9ZU0GttOCn0/
         qITHT86xSFuiKr4jszXYV6o91FLc0LJRWXM8kTnnT8AsMAd5AGHnrNNI8b/RDd2jnm0B
         BFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241887; x=1706846687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlunNru9PY7fh+ZApVP//S1AWHwdUATQshEp6xsX0fI=;
        b=BKb9H0Y9HGLthm/8UWGcNgHVqFl2KDNJk5s5frZFwU+AYL2Lq3i1D6B/k/2j+8km05
         q6aFbFmg9cgd1ecvLZWP1IXk5XGBCFinsMrRMfl/x4MCoRMoJLhx1Na+3bsgu4Qoi6Ii
         ERwU/1p67MYei0Sm2xu24usta9UVNGn6BzgyeVf2NELVW2O32SLG0zauqkdWyQx+geOf
         hF5/dflhPfDBaJHxitN7C/aBE6wO/VfBtjPbD2Q5TSs2JL5Nih/XT2yOAp8CXdHxF3BH
         Vt04D0wd3JmxunteMoMmuY5GT1Gol0egkbinkX1bJh/YDa5pN6R98QYIQsT0A6HPrZHa
         heAA==
X-Gm-Message-State: AOJu0Yws1KMsC4YtV4BRc9c1pd7beCfCAgvr4iRLXnr20Hg8Eim9t+/2
	jYiYEaAOsyhwnPbpJD4fu5FVN8iTZ0ZwEWbAHInMrB+DXA+v06mE
X-Google-Smtp-Source: AGHT+IH7D/es5blY9nxWG0mvQtnR3H8x2lfp9isLI+GriZA4j1YlKR8Q+ztJcM9d7RiNeR99bjcWKw==
X-Received: by 2002:a17:90a:6583:b0:28f:fa74:c945 with SMTP id k3-20020a17090a658300b0028ffa74c945mr454235pjj.89.1706241886841;
        Thu, 25 Jan 2024 20:04:46 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id sc13-20020a17090b510d00b0028db6cd0ad6sm307523pjb.3.2024.01.25.20.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 20:04:46 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH net-next v3] net: tcp: accept old ack during closing
Date: Fri, 26 Jan 2024 12:05:19 +0800
Message-Id: <20240126040519.1846345-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the packet with an old ack is not accepted if we are in
FIN_WAIT1 state, which can cause retransmission. Taking the following
case as an example:

    Client                               Server
      |                                    |
  FIN_WAIT1(Send FIN, seq=10)          FIN_WAIT1(Send FIN, seq=20, ack=10)
      |                                    |
      |                                Send ACK(seq=21, ack=11)
   Recv ACK(seq=21, ack=11)
      |
   Recv FIN(seq=20, ack=10)

In the case above, simultaneous close is happening, and the FIN and ACK
packet that send from the server is out of order. Then, the FIN will be
dropped by the client, as it has an old ack. Then, the server has to
retransmit the FIN, which can cause delay if the server has set the
SO_LINGER on the socket.

Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
it should be better to keep the same logic.

In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
states. Maybe we should limit it to FIN_WAIT1 for now?

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
v3:
- fix unsigned/signed compare error
v2:
- fix the compiling error
---
 net/ipv4/tcp_input.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index df7b13f0e5e0..2d20edf652e6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6699,17 +6699,21 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		return 0;
 
 	/* step 5: check the ACK field */
-	acceptable = tcp_ack(sk, skb, FLAG_SLOWPATH |
-				      FLAG_UPDATE_TS_RECENT |
-				      FLAG_NO_CHALLENGE_ACK) > 0;
+	reason = tcp_ack(sk, skb, FLAG_SLOWPATH |
+				  FLAG_UPDATE_TS_RECENT |
+				  FLAG_NO_CHALLENGE_ACK);
 
-	if (!acceptable) {
+	if ((int)reason <= 0) {
 		if (sk->sk_state == TCP_SYN_RECV)
 			return 1;	/* send one RST */
-		tcp_send_challenge_ack(sk);
-		SKB_DR_SET(reason, TCP_OLD_ACK);
-		goto discard;
+		/* accept old ack during closing */
+		if ((int)reason < 0) {
+			tcp_send_challenge_ack(sk);
+			reason = -reason;
+			goto discard;
+		}
 	}
+	SKB_DR_SET(reason, NOT_SPECIFIED);
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
 		tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */
-- 
2.39.2


