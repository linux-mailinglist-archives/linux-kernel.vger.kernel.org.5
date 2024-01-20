Return-Path: <linux-kernel+bounces-31821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A4833528
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3473C1F2197B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B4FC1F;
	Sat, 20 Jan 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="eOC1AoXn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967EDF69;
	Sat, 20 Jan 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705763459; cv=none; b=r6e1Rv6Ocj7by8dZPxy5kx/JDmsjfcisJQC3VDDbmdft7EMICxoKSDYuGSkoMzQK6sJ4wKbw86X1rUFzRpJTL1gYT0wa4uUfbXBkD1+9Li7xi0Es3qI6YrQg3xE/I9/ygRi3ozs+63LTD/RXMR6NugkC1+157aCAThpV/tssGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705763459; c=relaxed/simple;
	bh=+uHVK/g0PLW+WPegroJn+bUpobfrkjR1dw/0UibCi00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i/mA4Fa7LCv1NCdzS0ejqISvNP/pr4oapYiJ2NZB9ydI6LYP6iyDG2FVhaJJNu02VEGNH27C68E5FyHjfNOVrnzW1sYb17zwYuJLs91eLMYCd0vILCbOdBxiNRiXRC8nIKc2+iq36Zcskd6MCkqqnJNKqBKPYfSnsqinPgnty6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=eOC1AoXn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705763439; x=1706368239; i=erick.archer@gmx.com;
	bh=+uHVK/g0PLW+WPegroJn+bUpobfrkjR1dw/0UibCi00=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=eOC1AoXndex6m0cp89Vg1Nqsnd3hOIYkqwOZw6RuzS49UVQ7Ej+6r/tn86FQgspI
	 wnf+XiZXdniwtC4WO8rBIM1orvKCOOVT2O/Yb7AgU3jA3stQmqiR6YagL2iZ6Y5zW
	 wm8+0FOXFWARezAcvH81VapSHvuqU4NuxazyIA036NY7+3vPc7j/ZmkcjFQDu750/
	 o313gI8UR22E8iqDIxWAMPQiAYFcbHKu64Tg7pfvNzGQ6UgRpvWaNliDsyoY09OFM
	 crOJrd/myZcfpy8fm4R53oV4xDfJvNArRoCUwheRcr2dF+TgrCTvU2UYXSEy4ng+U
	 CiNLfxsY0Hg3qXu0Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MbRfl-1qpPOg202T-00bqSF; Sat, 20 Jan 2024 16:10:39 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Oded Gabbay <ogabbay@kernel.org>,
	Marco Pagani <marpagan@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] accel/habanalabs: use kcalloc() instead of kzalloc()
Date: Sat, 20 Jan 2024 16:10:28 +0100
Message-Id: <20240120151028.11092-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LTMJoGso7WL0bY6lGh/U0pZex8Eyp3xSFlhDAImF5EnyynE3/Sf
 YoELrMft1Tj+WIC7i+n1sKFFACYDWfx4jxqdYkxKAprcoJsmJut0q6vKhYtefzcHURAS1/I
 d1K9Z7bqkmVG0IEWI9hD5YhSgqXQgS+vPJ/FiVudDj6+TDfazkBUOwOf5pYjz5487TX5aei
 uFD87FttWgS1Uj0LcAxUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5162j+Gh7BE=;7MwV3GYQV4AF6w3g4fXl1qNIOgg
 klgJqKVusUiEanMLlbfQQShbn+gCqtIMdoGadz9LUHz//eQ01P4ou0oyfmWm2RIZx9xo+qdf6
 iFk/BhVZeQT9zKKd8ZAZT3KGWMfzjKILLLHKgdkzAQ8oPBiyrcJDTDpsnDB1NUkdbdSYRdX9S
 3q/8h1bjjXJAV4lql9Jl6Jk1zN93f3htBaRN6g4c5oe+7yJItNwvBVH9esgsjBA0xiYRfJWm+
 Okpb7vOSMl45/y+aMUc2kwr4S6dzX/a9H32AOU9oCnTtQI7WGHD6Av5wblmbF2VbxP4oRp/S8
 ZBS4T+zjks4InudF+AYjNE9Wt9O/Clxx4Hrd8cRLD+kQUCFq9w/pdI96RXRXZQByXliTNMs3I
 F2W4S8U2XDHn1od38zaVukTNjQ6G4QCgblXwi8P3311yK2YpYGXSRmF9TLz9bZDJ8hA92g/ZP
 RNNqDrTUUskXd9BE7m2Hx30l5ums7U4KjdEdx/VRnOQIHbQQFwYOC38qkZDAf/r7KE6QnfTJu
 jjTu0McZpz/za1RZdft/RamG7bU19QbEPIrJ1G4dMTxKyKf99UkpTF/THgv3gEtAv4H9O7snD
 SMiWLFik9l+ZLKDaWX0+eETjdtQvw7ILPcdk2pX9tjSYjPNBkj1KA3a/lN6nZmv+ctYSs8twR
 Fcl81hnurU4HFXsn/XWOve8qDyP2EvKmPBtzc6q/U/Q0XVg2xTHcYOe+3QQIXlyI3JTQ9xNUd
 n8NXfk7PiDP/GD82ZRhKwbgNdMOS6c5iQxYRWG+gMMBgEfQ41MId8RSnuE/6CxknDie41iRFj
 /WAPhit2ZwOLneFP1+nQOsKY/WbgYIsza1pAshlDCSlqvZ2GDDO7o7CQhT75dmd+k1mNm0FY2
 eaPTOaRN9VMJgUey/xfRaG7YvWYCsXDBA9UKgaQWy3AqHSk2Z9S2Yet4D4ZeKk0mvbytJnXNj
 GE/K9IaYaFIXj1mhDc+GCMeLzHE=

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
 drivers/accel/habanalabs/common/mmu/mmu_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/mmu/mmu_v1.c b/drivers/accel/=
habanalabs/common/mmu/mmu_v1.c
index d925dc4dd097..e3d42cfead27 100644
=2D-- a/drivers/accel/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu_v1.c
@@ -232,7 +232,7 @@ static int dram_default_mapping_init(struct hl_ctx *ct=
x)
 	/* add hop1 and hop2 */
 	total_hops =3D num_of_hop3 + 2;

-	ctx->dram_default_hops =3D kzalloc(HL_PTE_SIZE * total_hops,  GFP_KERNEL=
);
+	ctx->dram_default_hops =3D kcalloc(total_hops, HL_PTE_SIZE,  GFP_KERNEL)=
;
 	if (!ctx->dram_default_hops)
 		return -ENOMEM;

=2D-
2.25.1


