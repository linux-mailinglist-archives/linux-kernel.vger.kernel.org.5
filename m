Return-Path: <linux-kernel+bounces-14108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AB8217EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C219A1C21523
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF8A2108;
	Tue,  2 Jan 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Y8f7sCRQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2120F5;
	Tue,  2 Jan 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704179508; x=1704784308; i=markus.elfring@web.de;
	bh=V53RxSn45Of6qQKpHmIQL7d5i6Uj4RYbOSBA1Ek79pU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Y8f7sCRQHnrSUdosDFxS7ot/bgBH4fRzW+edTj2Ya0s4eJKETS06OuQFjf7aYoY5
	 RwVHcX4dIh7xJRUb9cGo3OgGqV46IPVQfixd2PYq/N52LTPytLbyeewmy/tmEBBfs
	 Hy0PYVJm+9jKzkOy2cKbLgrpBiWRsOgcNLJDGNi5YYqpS3l7coJRx8M91eoWp8CmY
	 1Nt69XT7zF147mUKcgzg0qSotRbO7shjJ3R2NNwUk155W1DNDQvshJ4ftuxtlpQLJ
	 t65y1QjpiaNln8eIwa5dOVWA1v142PPfzzPOf/q1NVq9UBsM5ptZWMU2P5knZ1dBk
	 FP1FGDaxcMdSTmirzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8gP-1r4pPG3DJJ-00t5Ck; Tue, 02
 Jan 2024 08:11:47 +0100
Message-ID: <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
Date: Tue, 2 Jan 2024 08:11:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner
 <mareklindner@neomailbox.ch>, Paolo Abeni <pabeni@redhat.com>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
In-Reply-To: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aa/rztWe/OKkxjpDmxNoqQjPyzaHKv8xKPJ8QBGSYir2aUs9wDc
 hAx5dt+2EqvulF6HrKiKtryVzbaltQ3ZrIogjp1ELjbso1QJMUZ6EjRpYtjHBUYbATrGe5e
 E0y8IJ0zU9v56pDAb3zvFfiJp0gmJ6B5ZU4w+4iWUez1RO9OaHOKoNcLjA8i0HBzqJfYE2T
 sJX/sMP4LrFkGxdZpK6Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7mrs2rexnTs=;nQXkY8Kc5fVXWDIu+nDG+pagpaJ
 1wDztkHmrGcwFFlSV2v0MG24Bi9GNBh9mlg91AOZ59UEeM+AlMF0mKHG2cjNwX3Tt/U/OeQb8
 vHHTFSLrVMh1DerU3CnmJ/3pQqcZkKJEaZyhnK5nRzRhJrfw37HP9PUJ8jprDAxWZb2bny1ZF
 B6L8LkmXGIEaOE2JO9xwNnubZq9xFVNyqeKDybT3gNaUJZNpiQqCwf53fuGXnUoXlxmHb9ipP
 ONwVWKMccpIi0Ug/PlUSiSVRsOM/pnKEbTqiZOQtVsLou0PySCkC1RMqLpXb2zXNkO0u13X0P
 wYrYWffNGr31GDYUxxsSzkfHywWy1aYrf4oXbnF5OuS6Z1wC0zvXbEoB0YGsyuCTtiYVZxxqW
 U7Owm6MYRYUrgQkfrDGLvDtbU31sLM7F+qMnUDN7o4DQbonULYDiFjQ/qlyKueAfHdcC9nkFV
 XbgmgC5YpDcyFGGm9sjBnc2oKrZAyf/DCqJ5Img6bWZxdXusdD3iRrYfO7oCbcAIJBEZ9CdJK
 ecyjERhAIeVwcrd4l8wzgqm1aq9qiRUz16/KKWAm060P1eBh0DEQ7D8DnXp+6iqyPHKKF2ISA
 esNU4/gjIG/FrfmGqLeikkr995V2mxavAYZrwoROp8NurE/YinQUjQuj1vdcTs62unLREa5uf
 xIlvn2prnccrwkyolxXi0bJEx7NBPir6BLrihcjr1RoWypNb73HXBen3uQOgw8nDDXJ0tX6Xa
 NfIIUQyIGncHXDzjEElrDRa3OAtvJtb8j8Da69Fe+EpatZUzVZijfOE+4RsUNJi4Bt/q5SthS
 fFxd9pQDze4uq1MJ7hTR8hMttH4XNzMbB4mCMJHJcwLH2cSBWVEa2eeQw8y4/03IUGo8hSKGB
 jasLYy632feg672vjfXxU1WuFKmLW3b2HftvYP1OpmtlOvf5sE9argmp9L7W1shC137gYaGK2
 8XvEww==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jan 2024 07:27:45 +0100

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with thi=
s refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distr=
ibuted-arp-table.c
index 28a939d56090..4c7e85534324 100644
=2D-- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_priv=
 *bat_priv,

 	cand =3D batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;

 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);

@@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_priv=
 *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}

-out:
 	kfree(cand);
 	return ret;
 }
=2D-
2.43.0


