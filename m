Return-Path: <linux-kernel+bounces-98026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E148773CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AD1B20D1D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298E524D3;
	Sat,  9 Mar 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qJTw/elu"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7B4EB47;
	Sat,  9 Mar 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015214; cv=none; b=fdAVaSOgs9p56Tb4p+x8drxa8m97YN18/ygneUQ7KiH+hfoyjzMvGW30OLvtMD5995yNWqEZN8E/HtrAY5wvO6FPQ4XP3/e+zgS5UZcHcC03JWscOh2Rgp99U3N5dSA6yOWt4C4NWe5ANjqw7xusEmNoxGkY5240N0PHA/TUeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015214; c=relaxed/simple;
	bh=XWLZ2rgpQpSaO4G+ifVKeg4eQCMQ6Yp+R6eWcIJepGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbxMrGud0vFqWdv+qgvbr/DJB7mbszgIHh9IV21tXiUaB4iH4E8mEkNc7qQwDhttwKQHLP/yoWcppZXp57hj+QI3unoGFmkEcxL9+0EQ3WAqOS/HKfCaNXBce3uNpTSBxZCIGI6aRJ7Tcv+2UhRTh4biEodTBoqQyHw8HL1wn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qJTw/elu; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710015206; x=1710620006; i=w_armin@gmx.de;
	bh=XWLZ2rgpQpSaO4G+ifVKeg4eQCMQ6Yp+R6eWcIJepGE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=qJTw/eluzR1HyXjWlOHnvPVAKmmU8mYeayVGCIeh/xKnyg1AG98epeCCiKuU554x
	 2oRmIeNQ7L7lLolBMUk0ZRwOxbd3zDCQsSORoFgxyaSN8u0scpvYtHQZobhwtiZfW
	 aDut94vT2iz0bcnjSUO9ibC4pmKnIRX/qB0RtItuKdPhpUL+JISpkVD7uPWM6NmsL
	 9A0IhveTmIQB1+LTPrzy3dn2qOBM9vAbb2AN/wfDVd6XhiHCT27PsIjDsc/EZrqS4
	 AuUnWDvjP4S8V5JTfL/xB90QeCZkLB6PgfmB6tqi4tjC4f//mvnHc4Q3oY0GfDcfi
	 PD7rvuYrctkP8sHKuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M1Hdq-1rhPB61nsw-002lw8; Sat, 09 Mar 2024 21:13:26 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ACPI: bus: Indicate support for more than 16 p-states thru _OSC
Date: Sat,  9 Mar 2024 21:13:07 +0100
Message-Id: <20240309201310.7548-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:0qO7cBk4t1+ClaeNpEJmIBUVYnAjaZTPk0gclbEcnPiP9mQ/SRv
 DlAsPnxwpipGYvU+bj6aAStZTWZroWS9xEqVhsdrQmIAyYzVRmOd+FEpxJ2cIHXualF12bu
 k60PGTe0JqzIwwhHjAMh/t0VXBN9ACwNrxwGKyOUzhom53r5Wa0VhWtXCzfCfv4MOQl5Z6H
 +S/JX6wLMQwYGDJBKW5Jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zQRWBD0d07Q=;SxaHJllzkx3QVfBVoRrhRAOXbXD
 /iWRV3Dg35t3OZ+FW3TgdIlz3fLqTO72miGOnW0D+XWgJbEPl6OOXjkUH/i1ZY/Vq6GCfTTpK
 1KL+LC3A3do8N/K7Eb5QCLYZk/QJL6AK0jYOepmH5ZEqHPl1EqXbOok/uC+fSthKS5ixCiim/
 4wsusKEDPv/QGc0CLj7v1UpUp3/5tnJ+p9rfO4UnXYj9LjPMLENKzeUCrJMLL/EHoDeUP+XTY
 91EPlEui6NL7mopkCk/7N+aQSczp/W3RHrTavZRUkK9w95KAo8I+lZrcFJTYkWG0WtEbMyjud
 qdaVLQV+lfPaiwcITMsVHNJYYDhrh0x0yyVC3pn5qyiKvldiQuNk2aiQsN6dmMPK1rTHqzi2k
 LZkWyx/bs2nu+M4/LIu909EIeUfuIZhTfODlnuFdoBXgbJ/YctmTHXlgULIlD2BL4LJulYvrG
 KmnmMGwRjZciPCK+cNFSSKaHpfeAP8CmE6muUh1Un9eA6Yx3IhPMO0Z1UKLsW2ZJjIJ4UsaT1
 3I+lNrHhbqsUYJTt4FtQIClG/19d0vT1kwdaBuuS24C8S8hGeKNkBSyo5gxWHiJkYFnPCswEX
 y8CJOlHk8C4R457TkFpEJM0Ioy0Yl/eYV36TqvhkccPV5nm1mmG83tq6HGS0G/kCJzzKwY8jE
 jsXU4U6NTVN2qN9DrzFoEizB/UXw7mHJfySAm1s7A0jRbnwZx931IWqCO77yPPoHWvQFS8oJX
 SAgu+6mtvSu1XGaf83k69bMZWN1lSrhJ799Dz122b8IjKhf8Yf8rCoonQ3qs2jL6rbiJBzR9D
 1jjFkgcAi51RDdtYPq+X2cdyxWY+jTPIhF0cqY11Bmc/8=

The code responsible for parsing the available p-states should
have no problems handling more than 16 p-states.

Indicate this by setting bit 10 ("Greater Than 16 p-state support")
when evaluating _OSC.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/bus.c   | 1 +
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9c13a4e43fa8..d5b0e80dc48e 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -321,6 +321,7 @@ static void acpi_bus_osc_negotiate_platform_control(vo=
id)

 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PCLPI_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_OVER_16_PSTATES_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PRMT))
 		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PRM_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_FFH))
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7727ebbc4219..baa07b5a717f 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -574,6 +574,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct ac=
pi_osc_context *context);
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT	0x00000200
+#define OSC_SB_OVER_16_PSTATES_SUPPORT		0x00000400
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
=2D-
2.39.2


