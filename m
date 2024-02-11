Return-Path: <linux-kernel+bounces-60900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D0850ABE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3344283C0B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2B5D467;
	Sun, 11 Feb 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="mOkaH3mA"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6715B685;
	Sun, 11 Feb 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673940; cv=none; b=KvYByoXriYz5KfVFjLezr5FStxxshCc1qxbrx1suBhq/iCwPEgpsd+YoOofbz7JjMMmaKFTbafdOXX7/LuiqpWbDk1bhb1M+U6FLlcL7PskRfb9itXC7Rspc6xYpqN4b1W59v3EY/dRr0KEfaKzIpcPK/jag8y2IHISnw36OmvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673940; c=relaxed/simple;
	bh=f2eO+FYHFwTKrMLX02BEOBpAa90tEHpnB9dG/oL3+XA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqQzZ4ti4KYi7HyBAKxxi969n14QjTb9rSaHY96c0az5A0XcJeOmELA0Alm9bDrN/laVCHiH0Qfj1YjODTYwMhuFtWUsSpZNPj4/PhMDTAry4qRsx6jyTuoPAx0yIwjzv5t2LuVePQJ9D222QQJbXNnE7ZArue+cHfUs/87WySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=mOkaH3mA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707673917; x=1708278717; i=erick.archer@gmx.com;
	bh=f2eO+FYHFwTKrMLX02BEOBpAa90tEHpnB9dG/oL3+XA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=mOkaH3mAEJGrziOsOi4RRqM+m5yie11GF8/ywPfvdYiLDH4ANKlu6ab6K5yRi32+
	 zt56lXHlEp4SBeAuCSv9K60dhmuepmNVLeo3+xAT7nQJsEqR8g8mcoECD9/QDiyER
	 dg9CnlTeAYKZGhqtc3XnhHVH+7q8HGNVoB+vqF/+P4VOSFtNF03aKXantsbTdxIO2
	 RjOPWXi1Vp2YZ9lVhxpltPG9cTNfAwJXhFARcF1nPPLJRszWvh5+h4cbgyY7hXavm
	 tF+YZ2YlWTq78sRCnAoJeOUjAv23vtszTGM+mdm2Z83aWSUwZTJTOcqsX+RWvN9dP
	 O8UAWWs1bcb/MjDpMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N2V4J-1qqdmM2Yd5-013vIV; Sun, 11 Feb 2024 18:51:57 +0100
From: Erick Archer <erick.archer@gmx.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Use kcalloc() instead of kzalloc()
Date: Sun, 11 Feb 2024 18:51:43 +0100
Message-Id: <20240211175143.9229-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fRNt/jnU+EgR445uI1FodxKwopT7+a/mrfXW9mIP0JCRBnynv8J
 CqQm+x7fJyJXcPNr3eUv/TQY/vFvLiOqKuoYBepSxBIFvumB67rV1UZhqkR3CkMTF+dcNPI
 Yl21yBArAfKTKhhwT9PP0TNpjtCJk0fb5aWbmZ09eHpjHSt2iYvkRyAJQaIngPXJTyWTBT9
 f45FaliNraYjGZ2kM3m5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wI4IgzOPPy0=;TDkhQ6yQenORkRkTgJLiNmfm6Gi
 5iW80IJ/ey3QnC1veoGSCMBdQbMHXSGaWqyEyg0wEIeiJke8XUPZGcuoFemWgbf8YOwJSmWOY
 F5WLHfRBGpROAxcxX7i5AK3bb/oDGrZFl6tQP7K1ZciNJk9Deom6B4U9Y7QDNOpH74JRJZ/0Q
 g1aaV2LnMscM8uHovQ6YF443hcmzZsAwIGe0wtMB1a4ECoX8h5gVszW+8SwZkajYnZow8TJkQ
 lMqf5ytzcbUN7IDBck3E+A1QubFlpYNYfQiilPG+NDJtYJhoY53u/fvUGOEeSJI5AIOJ57Sfu
 MuwG8zh+zOkBWv0p+rmGsmnW1vc7AiGBhByxJmNTr3ZgbnEuBja1u0kKgItQMecs1knwBJxDb
 32i7iM8Ra91F1N5UW8gHRL3cAy9y3LbDksnP5J3bPqcL7SnvPuwFB/kyzjAfEyZCpBe4okbdM
 r/yMFgBWhQucTTmivdwGWnP3zx+jSve0ndgQWZ/wvAs4Nb4giAd8ZVYcecd+GxlY6NGELRQPt
 uhV0KoiSV5FlPphrNUhAOAPEWyuvRT8hsnIQzJnD0RfWBeGwEQvoUQnHS226QxXREyu9Tc7Nf
 qytb8yVAA42UVzM133l+eX0uvQJUxaTJ1lA8CC/6+h59q5zV64+zM3G9/UezNwW3t5i74Jrb6
 FXxCgm8ZpOSohQJ9tpb7qjwukxVX8eGexTsYA2qAFg0knoqgktimtMLdFF9KLO3vpFUZlVL5J
 0xbiUEQdQzPX5h9BZBL4J575YFZJWOrC0g5OG0lDd/61KYkpzo0aG5/MsKeilGuPMR567zEeH
 ztmsDBEbq8AU0Z7RHD18T4AKAQq0Ig0xBirZYLAvtpjqs=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe because DMAR_LATENCY_NUM
is the number of latency types defined in the "latency_type" enum.

enum latency_type {
	DMAR_LATENCY_INV_IOTLB =3D 0,
	DMAR_LATENCY_INV_DEVTLB,
	DMAR_LATENCY_INV_IEC,
	DMAR_LATENCY_PRQ,
	DMAR_LATENCY_NUM
};

However, using kcalloc() is more appropriate [2] and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/iommu/intel/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 94ee70ac38e3..adc4de6bbd88 100644
=2D-- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -33,7 +33,7 @@ int dmar_latency_enable(struct intel_iommu *iommu, enum =
latency_type type)

 	spin_lock_irqsave(&latency_lock, flags);
 	if (!iommu->perf_statistic) {
-		iommu->perf_statistic =3D kzalloc(sizeof(*lstat) * DMAR_LATENCY_NUM,
+		iommu->perf_statistic =3D kcalloc(DMAR_LATENCY_NUM, sizeof(*lstat),
 						GFP_ATOMIC);
 		if (!iommu->perf_statistic) {
 			ret =3D -ENOMEM;
=2D-
2.25.1


