Return-Path: <linux-kernel+bounces-98025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA38773CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F2C1F21AD6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960E51C4F;
	Sat,  9 Mar 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YAG6bTuv"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAF4E1DD;
	Sat,  9 Mar 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015214; cv=none; b=JWtY8DsqjHHdW5gs5or23NF+Z52upyHrW7xFFYtUQwkdP3VWp8V281PJ+oip8dmphs2OUN8z+ZCHqRdq/nI3hgkKkBFgH8oNp0hnDJ7gbuF0usHzdzMLAmglCduTV6IBVMT52E15trhyFi9ET50WPmDbpaOVtLHSJxjBwJio0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015214; c=relaxed/simple;
	bh=2d/0SU8NbLGWulMjfdPpcnLpf+NbqM1N53gNgqn1xyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YbK1CA9DEAOIr0T71iqMQrUifx5/tvgMnGqqDhbL35obivYNB1kwVn04xC8CxNxsmKd1haW/SThmjR+872/hX3NWjqucfLtIE2aq0aOO/R52N8a+jMZeFoP0pZYpDOMFZQ4tCojMKjYuxUOVeMhhA3SsoWNTCnEGP7uCvjSiJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YAG6bTuv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710015205; x=1710620005; i=w_armin@gmx.de;
	bh=2d/0SU8NbLGWulMjfdPpcnLpf+NbqM1N53gNgqn1xyI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=YAG6bTuvyvWfGisK9mOSO81VmSZhSGnFwEcZ2fYla9gXq3dXaiMkyF1HI2cqq4Ow
	 Qbm8irYUwuCpfKBsz/jHY1Gp00NZK+SvjdME9UoVREPVeALJNVb9NEACPpSf+E7Tx
	 fxjBANoClqzMV0CoDvpc/rSoI1WOqP5jWjSqaEK8ZdfJ3y0d4jbH8RV1iWHNBHe3m
	 XyNvYHqs5Ofkw2ELiER7TBMIKANc4BhANC0TCFXwhyHD2p8akxFj8CKeIpOTPAZGN
	 X4utR9ssqDsZqoW+Gm0Cm071Ru6T21DcD7vAxTOnKKGSKOKjukEqM4ozSThf+8pBG
	 FbC0kELCwLttlSPEzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Msq6M-1qpqzF0Jtg-00tEP8; Sat, 09 Mar 2024 21:13:25 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ACPI: bus: Indicate support for _TFP thru _OSC
Date: Sat,  9 Mar 2024 21:13:06 +0100
Message-Id: <20240309201310.7548-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:oFfJiv3k9Mg6wPpoCWG1sFAJvVfJz247ZHr0ZfWO2Kt2Jt53fab
 etu9BtJi1Yp5TzTfedXRIdF4xJAzDjoZ9hVJMjtxLhiHtY0bIKsVDImTM3Mft4+lJ2THtyv
 1Ke2bogI3KGwtZ6A6aCm2ngS+A9jUPku4zITOVN5cE7v1Hy3EHwmvA2qdHc9q8dhn2kqMKA
 nktLK8y8Zm+MbddXxHEIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SmwexVi6t0I=;VZgFv8W930hm0tTirrBxsXFDHUK
 JGxp6VfmdBD8wHamUr/qG7t8Yv0Fdggh1cdOeBmAziZAV8y33JYi0nnNeuLGReEEQ1tua4OUS
 lcMwL9o6wkkcddXKpKWXZVw1AHiw5Y4Z4+zTBPo8YPfb2aqZz8wLl7x2nmVf6HESC1ID3/LAU
 12Dbi+zcgZhzo01oQ9r9XSEbsMA+Cba6udJZJTOKJByichKdaRhEqi698qQBQYG0SHCb/wOV/
 0UNk13sSvpz4VLyJBaNsGgBLWvd6vJXWP8nxoI8XCxXG28zKQOabGGyufZjC20al2EfD+cmCt
 pmRiSAcdHzQpsYZWYqv+K+R04US4To1KVqS9FOgkeaUr+kAueDJhL9WE5flRSOyRWcOfvZDCe
 p5l9/BYixnjKSHvDtez2pTt+QG79JB8skGjfrOTEx+eu8VYdmCYRlTuEpfbmfy5VsCB/uVMsp
 ykXaYXX4l5wavBVrwQuaJSW0F46T9UcaQE6gZtXqhaaJ7ekazEhLWksVYYhcsIPmgp6d4tKmy
 IugTugyuoeKgVka8SEezt34RDSp/YkDE/EnMvOQcUz4SUiczdFLPBadsFhTGYlANwEP5s68ER
 xVH1Z4NIauV5fB2kEdaE3k/iW5isympRhMOgUU9adFRhuFUBcc+KS6Upp3POi5MwO3XNdlCo3
 qCwpJmUQJb4GMMNW7RnhaHtRUfp83Mhy6z3aBQG2DjjKmnW7HQ3Kc6YmN62465haqdUQ5u5qw
 An9A7AtTWHyM5H3KiSts4ijC35A2iQ70vSKzv7+FqnGQykE5YF/e6FhtlAaBd2iwN+EpUNvH6
 d3QP2oiQGLpSoOVbEOjxeXpbtl4rFXYM+3zix+uvOLA+E=

The ACPI thermal driver already uses the _TPF ACPI method to retrieve
precise sampling time values, but this is not reported thru _OSC.

Fix this by setting bit 9 ("Fast Thermal Sampling support") when
evaluating _OSC.

Fixes: a2ee7581afd5 ("ACPI: thermal: Add Thermal fast Sampling Period (_TF=
P) support")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/bus.c   | 2 ++
 include/linux/acpi.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d9fa730416f1..9c13a4e43fa8 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -316,6 +316,8 @@ static void acpi_bus_osc_negotiate_platform_control(vo=
id)
 		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PAD_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PROCESSOR))
 		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PPC_OST_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_THERMAL))
+		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT;

 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PCLPI_SUPPORT;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a170c389dd74..7727ebbc4219 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -573,6 +573,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct ac=
pi_osc_context *context);
 #define OSC_SB_CPCV2_SUPPORT			0x00000040
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
+#define OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT	0x00000200
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
=2D-
2.39.2


