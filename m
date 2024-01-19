Return-Path: <linux-kernel+bounces-31417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861D832DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59F5282A85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FFC5788D;
	Fri, 19 Jan 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="UKfaXVK0"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FF55781;
	Fri, 19 Jan 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684640; cv=none; b=kQRkUqadi88NCywnP0yDuBG6GxuSja9kYyEWJdd4c7kGdp6BG+/8eCyyVE2kwROyx7tQ8scwqwlY5qjkfD1ezDUPzp6rJtKLqEFwqQaVhlfQ5PjnGpYHgWOci5/2lscYAmbh254Jf1jvG3dt0gto1WaLXV8UrzORYbcJ2h1hNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684640; c=relaxed/simple;
	bh=8hiSUreshi5d9psrrh8W9DNsM46O1ShucEmMReRAuG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d9qoOuiBKrNnLtJ0EiZV2ff5hpUh8p/vYlUar2a/qzTQO3YSvCOKWbV2zSl+ub7lzcAINJCnPU9OWGPYF3XFjwSvWtLwfpWrGZ8vvnnHO7j8Tlky5Jyz/+WThMG+XsANi0BH0Ew4w/bLJEbq30Xxu0rueNsRcTjogWSNfkwfFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=UKfaXVK0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705684631; x=1706289431; i=erick.archer@gmx.com;
	bh=8hiSUreshi5d9psrrh8W9DNsM46O1ShucEmMReRAuG4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=UKfaXVK0thOteFjJZQls4pBPGHzgD5OFqcdD7o23K1kpt/+aFLsxMAC6Chel4CZf
	 3UJawWop6sT2QcBPqQ9PYsd/UeZy2tM0Qqb9o/8bglktnxre+/dp2ogCGuOjlnzKo
	 K4sPOyoFzqkSO/oghuvQOySFTcuFaD75+Ml3W4fxE8eYqdWQA881ChLqIX15sxtZ5
	 Ri+82psijb2WdxYmhiIkG1YUarem07F2Xc9Ex85vN4OMJZL+FlIaFaUo5X+XjO9l2
	 mV1DoEzhDKWyu1xyxTTL4RJdlm0dDtbtdJnyYDB0wiLrifedy6MZMrl0qmyJDIijC
	 JR6cMm4XAk/1IFugFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N7iCW-1r4F0P09S6-014msM; Fri, 19 Jan 2024 18:17:11 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: iwlegacy: Use kcalloc() instead of kzalloc()
Date: Fri, 19 Jan 2024 18:16:55 +0100
Message-Id: <20240119171655.7740-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8yvcfA5it6REFYntjlNTl0iEzf/Y/4OhBvXBhpuP//rBvluFqQ5
 NSaWiDFtGrxYpLtNk/SOpEwcpXpRH0aYZ81GxgpwlgioaJ8HRaH2ER0SUuSi0HUSq5hAwSL
 l3IV2DBZqiwDJl5VMpvFsB2dXCbPOA0/clOAmUH8sUciXNWpodeghc7IvIzFZMWjhXwFIOj
 UiyhJI68X+SNWaLmV3vhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2tEhQomloAs=;xFOFmVFKajcsN2YfYY0lIFqFpPa
 wDTwfVxs5uMCUUud5TFtNaaU6YMdrsLCveR5n5MmroN2Lj/0p65wSQf8OlZ5yo2AdBGs2eNk1
 4CiPTEcq0eI19pjkNfTU4YNWZGXOtfS4APx7LJF1eBHs0Fbu+1tuQLBCRe/El0AW25a10jxWX
 LexCal7YaNjHm3gqXgDJlkYbA4hsXgbqTHY+OUysasI7VmDzGJ482vgsWveDPcAXUSBf0KeN/
 QmHNicMjqBAO+7sNIb2PIpOAtAyeXAEaRT//VqZElZCyFLdHUlM3ngLe5H0/JnTrrYrSXPm9d
 5wmkJJpyn1LdmJyhexHKERqN3G1jTp6CdGcsAPxFvi0PWzWmiVOs8W3EhTlBHwvHMTxFxiNDu
 MCXbyWne/tm3b2NjyNa40Ef1T1k+kEegjsvVhPz+3nxef9x3/R7Pn/VmGQiocFwpS2wx6QhqB
 w/waCgdHlRDuCWgjpOWouJsw8+/xILY68ep/C3qp9XcWXo7wB/7hMnHHCRz2S9flXMkldGoUs
 PauYL8Vay/v4ApxOybf/UKyR773TgIpFLi3K3FYTT0v1bp2qNuypmMTRGeO2yZKjjKbHVVUVP
 MmdyDxTqqNKuv5eQuMi9Gkc8fjndanEGoq//QCLNLHOiQPVcLnMHQWgBhbxL4plciuMXd6TxN
 yrENgozk/F/m9yjZ2scW36F2jflNCn/JWtHK5iqofHn/ZL6s6u0wCN3iIBNuLP3Sr14YdP1BY
 SjVs/fTMXaVh4kUkXTYoiCGz5Ix+oNoUS0cOvsULveWnmlRwjzx/lsMvAx64Ej0R/Z/46QtdV
 CbX+vpbppurHhVslgHcFNckbCd5o3B0y5fRs54mcj6OG88ol+QogNgLunzC7LwTUnhZwbeVNM
 bOr9rlAXLoJupv7+mJaEeOEWPBhM83ZKfoFo8/aqtAVkJph7rZe3l5TYpFzKMOpR5eWRYtzUh
 sl9Ts8RzSC9GDrRcQ37QmZ6iZ3A=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not change the
former (unlike the latter).

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/net/wireless/intel/iwlegacy/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wi=
reless/intel/iwlegacy/common.c
index 17570d62c896..9d33a66a49b5 100644
=2D-- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3438,9 +3438,7 @@ il_init_geos(struct il_priv *il)
 	if (!channels)
 		return -ENOMEM;

-	rates =3D
-	    kzalloc((sizeof(struct ieee80211_rate) * RATE_COUNT_LEGACY),
-		    GFP_KERNEL);
+	rates =3D kcalloc(RATE_COUNT_LEGACY, sizeof(*rates), GFP_KERNEL);
 	if (!rates) {
 		kfree(channels);
 		return -ENOMEM;
=2D-
2.25.1


