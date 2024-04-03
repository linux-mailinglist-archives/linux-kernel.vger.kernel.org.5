Return-Path: <linux-kernel+bounces-128981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9218C8962A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA291C22F60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E61B946;
	Wed,  3 Apr 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jmR6SjFu"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6A4C8F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112167; cv=none; b=VFdTM46teC0k+XJI/8Mk5rV4sAlyOv7Edla3NljhXVEMFdlyhiKs/LBp0HU7/G3XoynsMzNRUEvABSh9/5VVUSeFGMpqguSMWCPgmlh6RxD2oA71XqQXpFBidUmSd3f5EV4HChmQKMNffFiObKEPKanHTtaisFfGHTwfAM2cuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112167; c=relaxed/simple;
	bh=srGhf/WBH1QSMtmgb72EWuku1J74qEaPJtdpCmsUJ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=R2JwXZbqPzsJSN7drV49C1ptScLkcCYUKwgRCCnoIgWoNJbhGxlatTa3IzOuzv4cZRIxq9OtwQsHsCTGrXU/BDRJk9I0J6q2Z6alng2DT2esASPfJrkXRjef/Cnqt3WDv9InVAtDqXmVMXmLigCIXfdV8QsKmgxJdGfIO9MT4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jmR6SjFu; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240403024241epoutp023bd8a9d51a051a2d515b844856c940f4~CpPCahuP82151421514epoutp02I
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 02:42:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240403024241epoutp023bd8a9d51a051a2d515b844856c940f4~CpPCahuP82151421514epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712112161;
	bh=crooDftSP4UKnhd+TS08G4idDNDIrt+QwV7TnYgr68w=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jmR6SjFupMSeyqGCrKPlIqMyFTsPU9nvfhYXxEtkxzGMBG4EqFV1IIb717JzQj7Vx
	 JCok0o6A52ZXf/OTT2H+qxDfkL45OjWNIK44J35I1PN0uFm1Yu7SKUly2sx8NxMObx
	 A4fhkLzOHhf1Q7T3TNhR2rR86hLq9wV5lntX+Ii0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240403024241epcas1p4db3b2a12212f5e6c7a54ec4d111eafba~CpPB2AiJI2527325273epcas1p4U;
	Wed,  3 Apr 2024 02:42:41 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.247]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V8TYr6cKfz4x9Px; Wed,  3 Apr
	2024 02:42:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.76.08627.022CC066; Wed,  3 Apr 2024 11:42:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240403024240epcas1p155cd55ca8c1dae6114b970cf3f57084e~CpPBZ20CN1047010470epcas1p1Y;
	Wed,  3 Apr 2024 02:42:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240403024240epsmtrp142863ad5c0cce3251334d3725b83a605~CpPBZG_3D0976809768epsmtrp1d;
	Wed,  3 Apr 2024 02:42:40 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-9a-660cc220f985
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.0C.19234.022CC066; Wed,  3 Apr 2024 11:42:40 +0900 (KST)
Received: from parkseongsu-desktop.. (unknown [10.252.69.73]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240403024240epsmtip19cb057068cd3e71f4860396bd34d82d1~CpPBO8iGd2042120421epsmtip1d;
	Wed,  3 Apr 2024 02:42:40 +0000 (GMT)
From: Seongsu Park <sgsu.park@samsung.com>
To: will@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgsu.park@samsung.com, Leem ChaeHoon <infinite.run@gmail.com>, Gyeonggeon
	Choi <gychoi@student.42seoul.kr>, Soomin Cho <to.soomin@gmail.com>, DaeRo
	Lee <skseofh@gmail.com>, kmasta <kmasta.study@gmail.com>
Subject: [PATCH v2] arm64: Fix double TCR_T0SZ_OFFSET shift
Date: Wed,  3 Apr 2024 11:42:36 +0900
Message-Id: <20240403024236.193428-1-sgsu.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmga7CIZ40g1nPDCx+fnnPaPF+WQ+j
	xaa2+4wWfzbuZrL48ncps8Wmx9dYLS7vmsNmsfT6RSaL9w1drBaTfmxhtGj//ILVouWOqQOP
	x5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXocOruA1ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8
	dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygO5UUyhJzSoFCAYnFxUr6djZF+aUl
	qQoZ+cUltkqpBSk5BWYFesWJucWleel6eaklVoYGBkamQIUJ2Rmbnm5lL9jGXbHh8132BsYH
	nF2MHBwSAiYS/5eYdTFycQgJ7GCUuPX5FguE84lR4tGsZkY45/7UZUAZTrCOeXePMoPYQgI7
	GSUOv/KGK1rcdwusiE1AS2L1v152EFtEIFTi2c77YGOZBWYxSSw4uhesSFjAWqL93Dwwm0VA
	VeLo9jVMIDfxAsWfnDOGWCYvsf/gWbBlvAKCEidnPgErZwaKN2+dzQwyU0LgL7tE375LUNe5
	SKx8sJ8ZwhaWeHV8CzuELSXxsr8Nyi6W2PdlDVRNjcSDeXugbHuJjmdtLCA3MAtoSqzfpQ+x
	i0/i3dceVkhw8Up0tAlBmMoS57Y6QpiSEn8W6EHM8JBYcWsLIyR0YiU+n/nGMoFRbhaS+2ch
	uX8WwqoFjMyrGMVSC4pz01OTDQsM4bGYnJ+7iRGcNrWMdzBenv9P7xAjEwfjIUYJDmYlEd6f
	3pxpQrwpiZVVqUX58UWlOanFhxhNgQE6kVlKNDkfmLjzSuINTSwNTMyMTCyMLY3NlMR5z1wp
	SxUSSE8sSc1OTS1ILYLpY+LglGpg4mXh2JtcoRhbMlWK/8mlK7ckd+9eLsyXpeHzmmG9+/WS
	E+EbK0WW1cb1rn8pV2gy+7DW95QKMc3K1ex3r214wy7PYDD77DlHH9u2vp3TFV+Hf+03Y05s
	7z9tlfrejvmz4ZwljYcel5nl6e3Vq17wia3FKETD+fyLPyl9s8qqtAXPmevvmXd9yqOlPxv3
	7pE54SzcWBH2W9Tyb3raqj6XpI2vi8XusduEShu93Nf/kWtK6MLmkP5m0aUTTux3+yBb2RH2
	pkP+/IJ3gSXfgvaV3/60o9HEp+CklM/U46c/alx3iDPYt8w9wrPAmmfF72iZxZbFa/ZNDD26
	fwOPX3ip41nP3zMOzYqW2uYRN+GtEktxRqKhFnNRcSIA0ddQSCQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnK7CIZ40g89bZC1+fnnPaPF+WQ+j
	xaa2+4wWfzbuZrL48ncps8Wmx9dYLS7vmsNmsfT6RSaL9w1drBaTfmxhtGj//ILVouWOqQOP
	x5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXocOruA1ePzJrkA9igum5TUnMyy1CJ9uwSujE1P
	t7IXbOOu2PD5LnsD4wPOLkZODgkBE4l5d48ydzFycQgJbGeUePPyCzNEQlKi/d1lli5GDiBb
	WOLw4WKQsJDAB0aJ37sSQGw2AS2J1f962UFsEYFIibeXb7GCzGEWWMQk8WVtI9gcYQFrifZz
	81hAbBYBVYmj29cwgczkBYo/OWcMsUpeYv/Bs2DlvAKCEidnPgErZwaKN2+dzTyBkW8WktQs
	JKkFjEyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYKDWytoB+Oy9X/1DjEycTAeYpTgYFYS
	4f3pzZkmxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwBSg
	Pvddp5OOy/fJH9yKavwrum7UZXALqhc8kNMre1If90c874X4X5GpBiyd1RPuTtbsqDq7ejNP
	4MWOJda/GM7mxiy9fSp/KpN1Sq91+4d0/ofP0kI8T25+GNCcrO51WNSp1W3n5d8pMY22ok8i
	jLp3K70K6V/Oc2BfwvW7yxzPrnj04ufSwozrc76tVT5zZOvcPEVOU9nKIsO4E/8Lrd80L/JI
	/abJvCl083rnwvSsPzGq3/8UxFlvNwu7I7nN/siZ35Wds+0WLmGr8pztIC5rrBSp5L72J2Pj
	jZAL/2U/lNRu0s4+ullgl7nIfaeElBM/furPWaGaLSpwk+nlGceLOpKz/58o6j/2qGbvVyWW
	4oxEQy3mouJEAFs8awrdAgAA
X-CMS-MailID: 20240403024240epcas1p155cd55ca8c1dae6114b970cf3f57084e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403024240epcas1p155cd55ca8c1dae6114b970cf3f57084e
References: <CGME20240403024240epcas1p155cd55ca8c1dae6114b970cf3f57084e@epcas1p1.samsung.com>

We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
So, the TCR_T0SZ_OFFSET shift here should be removed.

Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Co-developed-by: Soomin Cho <to.soomin@gmail.com>
Signed-off-by: Soomin Cho <to.soomin@gmail.com>
Co-developed-by: DaeRo Lee <skseofh@gmail.com>
Signed-off-by: DaeRo Lee <skseofh@gmail.com>
Co-developed-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
---

Changes in v2:
- Condition is updated

---
 arch/arm64/include/asm/mmu_context.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c768d16b81a4..bd19f4c758b7 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -72,11 +72,11 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 {
 	unsigned long tcr = read_sysreg(tcr_el1);
 
-	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
+	if ((tcr & TCR_T0SZ_MASK) == t0sz)
 		return;
 
 	tcr &= ~TCR_T0SZ_MASK;
-	tcr |= t0sz << TCR_T0SZ_OFFSET;
+	tcr |= t0sz;
 	write_sysreg(tcr, tcr_el1);
 	isb();
 }
-- 
2.34.1


