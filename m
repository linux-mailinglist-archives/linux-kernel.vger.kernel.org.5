Return-Path: <linux-kernel+bounces-31789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305C8333FC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999572834DC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882DEDF68;
	Sat, 20 Jan 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="BrOEHDwk"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB6320F;
	Sat, 20 Jan 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705752363; cv=none; b=MM9RkNVASByNOxx5Xh9gktDWxPpVre7x5JkVVyn4hNZ2d+AF2HaAz/DWyj+6rVaChvxi8PwhjfNAw+GztEO7gACPUDfGA/HnGgsq4QVFWh84dJrRLDYWXeGs4sJeXXNxinCUSxPC+XILeIvAKU6kTFthNEPJ9WpD9darWh4TqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705752363; c=relaxed/simple;
	bh=6WljTQzsAyyeU2bPKrlfnVK55eNKnNBym7B97HV0Oq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tTw6U5eMFM6Q4cIiU6dEnlDDqTHnxy1fFHGwyzbkWiKjVRpYKvjVTRhFZFLVzyuJjVK/C0hhajdYmkNnlQo7c7lSdu14yfAIxmvrrhNqOjYZvvQ8DeBVvrXAd3nkbyfrBalbHLLz+93hT7PrpqBsQ/5i5fG+hBPQSSzsV54Xp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=BrOEHDwk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705752347; x=1706357147; i=erick.archer@gmx.com;
	bh=6WljTQzsAyyeU2bPKrlfnVK55eNKnNBym7B97HV0Oq8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=BrOEHDwkuzbLg79L4PnWJ5cxHqwsUPGnDQlzwnCN23SVhzi6ijC0Tv1jrg6O68I6
	 bgKDWf2hDN1oiap2qVwhQbk08J9RJwuiYICzpZq/tC5toKmrV1c2BH3O5R/AndJ6w
	 6lnMvuQTKXfM6ieXplXycc5ZQxDSY3j6ujnz8S7kfNEP2Zmmm+04z5/NZ967Z+oGl
	 VBiwji4G0+8IAOO/41O3jtSCoav6fDkwyfgnVEC9YzagVt0Cgx5ip1WI0fAmkl0bU
	 Ew9BnFALOWwVR6zbNCs2k3xAiXlVjuTtSqhEydplE8j9QbDFzXfokZf/KTg0JHYeO
	 CO8E59t+xuXfoG+jPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M42jK-1rRA6d0MNM-0007t9; Sat, 20 Jan 2024 13:05:47 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Documentation: power: Use kcalloc() instead of kzalloc()
Date: Sat, 20 Jan 2024 13:05:27 +0100
Message-Id: <20240120120527.3866-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MIB9rwFGn8LGmiHnZumtukOyb3RsmEdtPJtv639NvUDu4wkg9uM
 le8LXDqp2lj65dhD4DGvmd/RgkaUGRutEb5zp+iAzNeRObT2S888ysTeqpbHoA4FjZ42pLk
 9YGTRAU8XT/RGai5CDlb93x6J5MGbpvFQt4PfhYsyWqBX84cBPsN1h1hcWmIbxJaY/vLSuE
 sGL8nyiOVW2uOmvnoWfnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PsIHd0DBSB0=;22SfptT7jfkPKbSIQF/aARbTyJB
 7CsB1+3GKQZPBMDm6m6A1cLTA+wqnNwt3jQQ+MRxgI/hDEwgHzunaygKkU2IcM0b6RQimNthH
 KP4j7g7yokE/ezd45sO2wVY4/ruxS4HHDPOx0BnYWet8oESRM/Z5yLGEeJPzKjq8/hHIrDSGv
 Fl+2Xn5f5NrsWN8loLa5I9yvgXxWmnheBtPcsGmglHtS6KpcYxjAqktBxd/WG/Jkw9KJPl+xm
 f5HFcurAHxJGCc2q0xPWU51EOtf+s3IpS4yH4JghXX9X7pzh9xdXDoD8hNgIG2NFcDDUygkDl
 UFHtBcyKKEO/FIq6rby3SrTGyOofBc3XQSsGOJXrJBZpGD0/CyDb+BoVNDBVyoGkyDjFXc1x9
 1i8dIc7wUqoM5gfSudJKYTHVh9zRXN2IlHwhfmoteIO7xvCJd8K5Gy4tTK1Mj4J2o3mQ3B/AO
 06eTiozOauzv4Ji8eoT5w/5hgZhtNYQPbm0J/zTNa2GSHluJcvoiCaZZiXYhEPBut+rI6vKg8
 KyhHnWCRWeymlBT7AWVACMYh21g7F+CJd5MKEgL9wMb8bzgpV6qNmk0bJGlox50UGXSg+kww2
 4kNyLOs4k48NTPfklUjgwwSRa8fO2MOIuDmljihXo5Oe/f4WQS40f77+a8RfuCPIxTg8oPtOQ
 ktEQzdDFhlUoqoHuPe7hCzdQnzZB/+U6yprJKu/fwbH4W+J/0zlSM4w5503IR7yEJHyEeA+Oh
 Q8pLJSkXjjDzBPm8Uenw3WkViByynOwibtRixMNAOoWHgpYbYF1vymVYgBMm99v7hbO0AHg0m
 6Gf14DocWNBTnZZo8fc4rtrLCmvXZPTdaggV/F1UAvrKC75hFvy8LL5HpsQa42hG5XUpRfUod
 Qow3M81VdaPFkn/gkXwrT+993mpPCJmTDpEowFBI5IwP8PsLywlgEY/xc8/FAykVeJlPfv4o/
 dPoRx0KepLuBZYyfTtzcSIcy11g=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, in the example code use the purpose specific kcalloc() function
instead of the argument size * count in the kzalloc() function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 Documentation/power/opp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
index a7c03c470980..1b7f1d854f14 100644
=2D-- a/Documentation/power/opp.rst
+++ b/Documentation/power/opp.rst
@@ -305,7 +305,7 @@ dev_pm_opp_get_opp_count
 	 {
 		/* Do things */
 		num_available =3D dev_pm_opp_get_opp_count(dev);
-		speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
+		speeds =3D kcalloc(num_available, sizeof(u32), GFP_KERNEL);
 		/* populate the table in increasing order */
 		freq =3D 0;
 		while (!IS_ERR(opp =3D dev_pm_opp_find_freq_ceil(dev, &freq))) {
=2D-
2.25.1


