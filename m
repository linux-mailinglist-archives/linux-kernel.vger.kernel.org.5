Return-Path: <linux-kernel+bounces-31803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CF8334D6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73701F22B22
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35BF9EA;
	Sat, 20 Jan 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="p6QpFoD3"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC869F4E2;
	Sat, 20 Jan 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705757705; cv=none; b=YUtZAHOGdGEFhuZRRF4Gv+gyhJzwpcH50D+zcJxxNJaCTFVHeomuJ3LbMXFV5Y+Is+H+sLXigpARTzGdeQOrC9OPBfvxnzGbVMT1FW72pqd5wsYrNXSm5NbqXjZU80edSfrC2rkcT6ZZ8CRrH9Oh99QI7U5JnrPBRzEfv96g2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705757705; c=relaxed/simple;
	bh=HSEmP7fhfhYJi7q8y21JZnQX6pvDCIMAR2srytoMCDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oj68e26KD9eSFwSZG2ip5fuZAJmMxr+u1rLoMmUNRcpJ3bot35dUEWeg3NKJyKshgDDCbhehswAx/6ChkIuq/lx1nqBfUJNE9tEpVIdZINJFhdxmwajoRYn0zZKoQLqqyoLr3lqeS7tq0VvmD8ws1p4xEMt6MCwdwEZX/8ylZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=p6QpFoD3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705757695; x=1706362495; i=erick.archer@gmx.com;
	bh=HSEmP7fhfhYJi7q8y21JZnQX6pvDCIMAR2srytoMCDk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=p6QpFoD3XTH9wTkgyZW04NKN4CfYTn1T0impi1JHePIDWbFxOXykMy68D88EKdy0
	 4apZu40PRCbiVUqKib1t93/uMiLXpRev4xP/vVe61X5dx1YJZFQNC9pTOnPuVL6yM
	 j3XAMjw1KneXxsyVtDrYPHxvJzszAaWY12EPx+VuyVoZoO38EvQNf/msY4SIMx9WY
	 RQ1+zFDvl+0/GTAY7QMh18IF3Eff74SqfClv+DY+qsi29+BvETPUumehEvVgqZhEL
	 Csi5GoL85OeOvwRhKLt2m4LlLPtROzFnVV81E+B+B8lpcgosGFnU5F+1s4Z2Orko0
	 6UUFV1CwbGXcD1AUqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M1poA-1rOyZT21jk-002KVY; Sat, 20 Jan 2024 14:34:55 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MIPS: Alchemy: Use kcalloc() instead of kzalloc()
Date: Sat, 20 Jan 2024 14:34:43 +0100
Message-Id: <20240120133443.4237-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tm9Qv2O3XG7Yqd03ObckUezAjDfTzhMZozLxrK9eN9xuO+dt47v
 Dlj/WxcudwlJl1xltGcGwgzN+4aHKobJIz+NvN35PAmtmsnarzho/SbVbyNSdJyqga5rYtx
 CAs4p744xhtZSgMqE++zW1JtrIOWzd4+9cATvJz2QxxqrZkThjvUh4dNNfBMWqhEWJLAjeP
 GbQRfZfUguXx9gO7GPcRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6b44vTJOeLM=;JvN2Rw273bbIRhm2Uk3eIZxdb8n
 kUE7UGfv93bkax0i3bgkE6qDE/m81UtFf4FlMmylIM9+TgUDZmWyi26dfih4qZOAOvIeLQpIf
 z4dguJohy0x/cj7HRS5OUgkUaUmLgzvcUxoorjli+Lk3MPlwgptriFr+BNQSKsYtTX6VSE8F3
 vOsHhHMwFJGeoskm0SZtaOYoap4AyxE56nh8nYbsiM77M5QswEVtZRLf/pbo+ZpZ8bkGYt4UG
 UCY0MOBTVQ4BXB1CdrXKD49BB3kxEVRoEmqqCIg62FHqC9BVFu5xBGl9SqfEHNARW6+v7Ad7D
 pWnK6Lc0Cbwpv4C5e3+PMt3/dOhIVufrbB1JySq1v9ooxPw04HhXYiLtg9GrVcaqhGUVOZqaD
 IHRX3iV3TOgojbtjmjuQuJYMAHp0Ymwga93b+5IvQp48wPr+rOq2LtQjnP48Rmk5bQcjBaOWz
 BMdRSg179ht2ImG/W881Lvbziq+XdyF1JJeo7J3dixuTiPuSMXa08fNBRb34Dp2UxmNcJCqy9
 6S6hg285naBtPKY2o1/8iX6pDKr4NgZbPQQVXCybQwDx0SFGNosQ4Lavbn1ua68UolZgiojVt
 2L+5RCPE64+yEdmWDNwctM72KmcRI/tpDZCC+SspJqvZHldagoRvBcIjRDpZjhYE3TfyYxjge
 DKB03mtq0VOS5BEqPHfBMCvQEfuhqsE9AuNuHAqNSK/fVvZf/yGtQCN5ZqjzO2WlO7GzdS13g
 7yD/eCEjSBw50ExJsuTEZnFERatJLxGNd+oT3HR5Rh8Z3jiq5QILs0EikGZ1A+sZ0ijoduhh/
 He4fSPgBGmrv2fCIjfWKOlBwo1nMMUHr1gOyLaNarYIR/YGapnVNtKpFcigiAw/Lpq4WgfIuc
 4aK3bdsI0UwvzawrodOnLHwBxSRaFF0k3YIK4r4Fn3KbJ0uh675g09Dxc05+0pBaXa2rdvWnf
 1H+hbiwj36cpW7z+ZWwf8DNKuyQ=

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
 arch/mips/alchemy/common/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/c=
lock.c
index c01be8c45271..6c8996e20a7d 100644
=2D-- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -771,7 +771,7 @@ static int __init alchemy_clk_init_fgens(int ctype)
 	}
 	id.flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE;

-	a =3D kzalloc((sizeof(*a)) * 6, GFP_KERNEL);
+	a =3D kcalloc(6, sizeof(*a), GFP_KERNEL);
 	if (!a)
 		return -ENOMEM;

=2D-
2.25.1


