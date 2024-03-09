Return-Path: <linux-kernel+bounces-98028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650AF8773D1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A4A1C20A7B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049A75466E;
	Sat,  9 Mar 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QWpZZNQ3"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67510535D0;
	Sat,  9 Mar 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015219; cv=none; b=HwXQbv5G2YlrxHhfrfutQ6UMiFPUllSL5plx9Q2EF4OyrOVPlfa/XJrbB7EA4EJpEtep3GQL+4JSwtrD+wcKnaUbcyH8jwFLCIc6O+NBI5R8dPWphhMrPK2nqmZi4P3CpR97C6EcKVJxOdIBtFK3bLLIY0wRFdufSt/7n1x/nVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015219; c=relaxed/simple;
	bh=MpfZeJ7zuV5JXnUgnnz7R8bvCTHFOUpWMvKtpgsYw5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMDm52i4B8JhiwtezN0cx77Wp2DPcmQUNIoFUNjITVu8j6HZIFwgRq0NycrqWgNVY4lbtVzotvOYsflWMVfFj1vow6o7uNKCVjwwlU+JTVjIND4cgsERDYS+QTuUn/Y6Z7JMrAh8D8SnqUoYT5bThxvA8SMVbUo+F8OubbTDjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QWpZZNQ3; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710015211; x=1710620011; i=w_armin@gmx.de;
	bh=MpfZeJ7zuV5JXnUgnnz7R8bvCTHFOUpWMvKtpgsYw5I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=QWpZZNQ3hk1qi3jEA4zD58ruez08RwD6yZtWVzV3HAMkNLdS0oFMj/2NP7461IKF
	 0KowCnA3gvH4EPzC74NVG4pCHdhHqhz2BDcAlWyl2qJ52iyrlBmBrLDUhy1HE9ieY
	 7tpH6BUarun+bBf5vyN+OunlX70xkADk0Xxv4pxvWL3TtdROH8urGvoQXXredCYkw
	 D83C2iEyzKSnBehbky+toRTpYnKVHuACawFVuvzIbFOBxs8aGeBLt7XUV58fpWM98
	 /W3FQ80EXAGbJmMGGGEgpYUEekGA3eBYc7aO1ZNMiMZq6BLX3+9FHkVklf6GnxtLQ
	 VF+cZhH7ZcZt4MkvEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MEFvj-1rZSoh3tUT-00AEKj; Sat, 09 Mar 2024 21:13:30 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ACPI: Fix Generic Initiator Affinity _OSC bit
Date: Sat,  9 Mar 2024 21:13:09 +0100
Message-Id: <20240309201310.7548-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309201310.7548-1-W_Armin@gmx.de>
References: <20240309201310.7548-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s99o/eP5YArAw/9FdlxQ5CUdxOk/3Pr4sobKxN0NSx/0WnzJqDn
 k6VjZ22EI9FSWmrLxqrg2eBAzER/SaKJqTvn4lpfJJf0Ox+eEEfi/4gmu3RDJuw2M+9m23O
 mpxP2MY+WgX/w7Bvx1hmwnPZJMWZD/jMax+pl8xyatMs/NQGOz0f4F5U1Fz2vVeLkmQZCaj
 2Wbek0lfgDd/V0A2UhGHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qb/aEQnxtgw=;HKCqubTyv2xSVrEJTrPsEdbQK6b
 ZKVJsZs/HWBjfKcT2eFFiz5Og+Z7GZ2huK8LKWj7z1270lO4L4L7TvJGZrXKChPhvfNRmcgGf
 ahAvRECxTRRyASiVI4XYqNOQNrDzIAW4pECxVFJMjzaP9q1YDIKrPCe+Yl1vfqLHWKAcNKisZ
 3Z0fLZI48wOyWf1CfWK40k7GB1lrqAqGUn3d3s2AiIrEA5wJfgh1zdcK+xjEoYgaWUYZILzsP
 +LTy2xydfz7eAguCbeE++uwqiLqIaj//BvdIeBBPEcPjoy1n2Qm1vt3iq3n6SYTyqLLMOgYF6
 qUrefsmtYL4BAkF25Kactic2C1J8wbNGqFPM8KzoMSoE//J6tPsDNUPv265/UkuO+AmNXEHs9
 vGYnghvRpRHL4kHJVXxBOnsPrFl4AJslZRP8/yvIRsA2tE+4qViq44tzDCExjyF5mLLe9XAW/
 sOPHQRs62OW1oPw+HQHxDS+tPPuL3L2LgU/cfy9GByhg/WE6Ib8/CpkGYeRPBDy22tkQmfQNS
 +K3J4LbLsAyA5Ecte162g1rjiozb+9tY9KS2LwdiJkr8hCIzAsCsp85+t9bRVwSZgXnOLoSNG
 Q0FqdXDFXLDVQyB5mdB0K/CT8M/p5MCOsHZ4bpd0G8wegEs3EMpmKl+0hnv1atiSKXv3jORLG
 p2qgvCCt7UjPzqKWrESUvXYC78p9O2Ot40F2bkW8YUnToI4wnLLwqKVarclGrRx1pXDDZPq32
 uuKCddr624vL0EfckL0ZcrJJUd4rITeR6aeKOn+abWafgFQUJBuKBDI10VNyGipXQ6t3ZtxD9
 kPeicakPL3sQjmB9EUp099sDhT18TuRrM36B9NOCR0fjU=

The ACPI spec says bit 17 should be used to indicate support
for Generic Initiator Affinity Structure in SRAT, but we currently
set bit 13 ("Interrupt ResourceSource support").

Fix this by actually setting bit 17 when evaluating _OSC.

Fixes: 01aabca2fd54 ("ACPI: Let ACPI know we support Generic Initiator Aff=
inity Structures")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index aa26259a28b8..b99c83968a9d 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -577,8 +577,8 @@ acpi_status acpi_run_osc(acpi_handle handle, struct ac=
pi_osc_context *context);
 #define OSC_SB_OVER_16_PSTATES_SUPPORT		0x00000400
 #define OSC_SB_GED_SUPPORT			0x00000800
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
-#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
+#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 #define OSC_SB_PRM_SUPPORT			0x00200000
 #define OSC_SB_FFH_OPR_SUPPORT			0x00400000
=2D-
2.39.2


