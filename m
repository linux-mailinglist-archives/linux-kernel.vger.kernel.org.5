Return-Path: <linux-kernel+bounces-32088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1467835658
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A5281C98
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB75376F2;
	Sun, 21 Jan 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="KmuHJdlQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D1376E4;
	Sun, 21 Jan 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851334; cv=none; b=TtFIS5ImxPBdaF5IreMasKGDGA5u/L7gJgj8iKcLDEDhBo3AbKV/45RkavuUXFLWGsNomnjISmvcBL1GItN4rRVAZ1bnlzfUCOSJP6N14B6JihHY9Hk3NknyMB9YaWfVRIpeMNz8EmMxksByW3masmbceUZIGhMkjr0JLofU0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851334; c=relaxed/simple;
	bh=brNXGMrVlHQm0RTaVV57rRuousVunDuYR0RflipHqy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1J5kcJlFts0kWHmkpTlvyiXGJUigOuN/zvWyz9RVaTFJLFuj8XDLRrqXBJw3aab+vVOy26MDJSCySKSO+ntVhTPfGwc/TqjHwX/tW9hWgbew77BvLxwxGKD28/8tZa25DkR81eGVtKhgL6kRxeFwKpqNCSYj0hMDrazPaiviHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=KmuHJdlQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705851264; x=1706456064; i=erick.archer@gmx.com;
	bh=brNXGMrVlHQm0RTaVV57rRuousVunDuYR0RflipHqy8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=KmuHJdlQlra8yhaAZyRVaOdPR3Ngby1Ed8ytpQ5Bq8rhobq78LiTS9ylXCMReZ3C
	 VTfK2XjAxxNXCSejEJ4S5ZOIn6BoPueQj982qXij68RaTc1wQLUWVOYeBV1HSofPF
	 iFH+REEXdNBDADA1BHw6JGCCkXCBTJanTTCGTODKBqOUG3h2MmadKr06kldID1gXN
	 11g9g5r4zmKsUB6DgcSbTQC8tfll1Pqd4CJ8sogALz62VqosyFkoUTMbg9nuQ4EGo
	 kJ4gLDi0p5iISesO5zgSq0hZiRCCK5GmdxvLWdkO6qSPm9r2CCMnDS+ExofpE9AAk
	 VRG8eR0YtYCk8J/T6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MPogF-1rnu2e2t6J-00MxT2; Sun, 21 Jan 2024 16:34:23 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: sun8i-ce - Use kcalloc() instead of kzalloc()
Date: Sun, 21 Jan 2024 16:34:07 +0100
Message-Id: <20240121153407.8348-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AxmzJ/LffrzzgeFylniD23yWMgGbXKe9NvmRSO8/IaOF4X9WL+d
 /DWmNgnnIDNPKn+4YvnUGRfa05XZMxDTtrOLTZgJjgupSydDlEqj1LHneFwYJcShATqBTrX
 AivO8CM9036cwP7d1/gHCHZkAka+MjAVDEsABxE9P+/Vti5yfy01GSpBSFmD6HviAWOqLCY
 atPFM8X8JYu1RHSQkLkcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ulWb1d2L0TE=;hYsmrUzpdwDFSW+AMoveAoIAKmi
 hoOwXEc5Iyju+CMavqgtB57Li72O4ujobrkofQU/21lrm+3ecyxP3PAoCsUV9X1isK0whSuk2
 1ZnfQjLB666SFEO8aKfLunD9L139jR+d1Mf/RvvjIrkaBHpvrlgB47r1GrzBv2yN5HntIvWVz
 ArdE3vfwOcNn4cznxYKjm1BtZalPRQ3+5m6l/OGYyogrOc7lf/9iLRfLmcsVSoKtMepyBV/g1
 xeo+wrvKzrc4SGIIExIypk8kYqKBRPO1wLwJ/GnSmHHN+ln+Arev+U29vSVd6fO8MJBXnjlXp
 ztjmBU4XS7Xjhm0Sa1p2FHMRtCu7hRIR1xOOl0mT2VTnpcIg3bP4CAYqPT5XSKuzCirc82Kqn
 V796rmPSpugtqJUHQgIol56B2pxIgECyK8oTfSgHk1IRUtEJIupVGtbt9FWHTbMQcxRYzow85
 qIPBK03qa0Oxkxtcvoy3SG1ZmCsrtSz/bs/mUL6/pE7osNX2SaNKmC9czDCLK3SttRVrHOAha
 r6lCYBTLqsEwabEimIrHud/aqloiazTBwcXYzvtIpZWKObubkJwIy83KCEiuaIqEC4kOuDxHt
 +E3t+JWmPuz4fyUi1gv1jrUCqrq85OKrzwnwdTnNMcsug29YlwhB43+zf2X5XNVglcRBAtrE1
 XpUAgvDnVV4giGynv8zMI8QEKvpllBPbhPBRY83aG/zQ7zcsVdpitd1JXYFVaMbKp4enNJa/S
 dyYzYPa/eWYQmHF7NtDhEylxY9E3kiJkf2Is84qFzvaIwJBB5KzTxopTzgW+0BRHjWTroCSYg
 SQlxXAVIBy9H5PMuyhIOjkGJoYHLeRx4royhzG1wI/EYiTDeoTgcYrTrM5tzSQsJ7BSYphMXV
 PlcKjj7I/2bo/HCTxkOCF5cKbPxC8QBI2OaMoEUn3Sz1/3y7WEJBAkjXuHG5MJeljVpWhmQf6
 6cXOOEgbvK5OW548Mp0d0hwQkCI=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/c=
rypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index d358334e5981..ee2a28c906ed 100644
=2D-- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -362,7 +362,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, vo=
id *breq)
 		digestsize =3D SHA512_DIGEST_SIZE;

 	/* the padding could be up to two block. */
-	buf =3D kzalloc(bs * 2, GFP_KERNEL | GFP_DMA);
+	buf =3D kcalloc(2, bs, GFP_KERNEL | GFP_DMA);
 	if (!buf) {
 		err =3D -ENOMEM;
 		goto theend;
=2D-
2.25.1


