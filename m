Return-Path: <linux-kernel+bounces-55670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532884BFBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74811C23209
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947B1CAB3;
	Tue,  6 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MxWKY3jK"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7191BDE7;
	Tue,  6 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257114; cv=none; b=lr+QDmsxIg5TRnScmEV4EFNtD7G8eWFK/QTE/V/EFlk55U0veCxMeEfbLSlks5F4g9s4i4C5KQr5D6XdTtLy5+KUXko2/As7XzjS44hM6EOKcpEr//aHDJIc4udHDL9K5B9LFh11gD+7O6jSKLGCi7oAG+n2uG8P95xcgEK0IXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257114; c=relaxed/simple;
	bh=2PZ9F0FDkdVbqGbkUnpibkVEhoyYv+tqjfurNqK2CQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgP8KhEaapXQPWnswqxJQFePmARwLuBjhu5coCuMaEh9wywj89nXylanTsOz20xtCgH3HIbV/GbhCnknL7nvhVENSJK8rww/3QsMJXGNwWklE0nkEWhMNbzJufsqE2s540K+C03UWTfVxLD5OXjEN4w9FI26VSs0n7TOg05rscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MxWKY3jK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707257105; x=1707861905; i=w_armin@gmx.de;
	bh=2PZ9F0FDkdVbqGbkUnpibkVEhoyYv+tqjfurNqK2CQQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=MxWKY3jKu5UyB2iR5D3Qpo5+94ZcqcmJPPAEiQHkfZHInCNnyrL0+WNhMpSfa+SW
	 sRq8sB0JYMJqgYs+usICt/8TpbbMqlB9/+OM4JtTbP99NqJXAwhQ3py9f+JIbpzh1
	 ZJ6YDRuX77jk7IzOdqO1s7TMN+U9Ipa15odjmsa8e23PYBEMO1D9CqmNSfmHJx4v7
	 /R1yeW5F/zQFVmRhRRQ+ov5pVFsU/tbMAZhd8FPImIfcMCGC8Fvy42g5CZyfRmnv3
	 TBBjTRdoS/PDv0rXBuLmv/oRaBqH9f9uxCV7A8k65r0KBeXyEQ3E8ht+WWv9B4M4z
	 d3PKDeVSbfguD053ow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MSKuA-1rQu0v38p6-00SdAN; Tue, 06 Feb 2024 23:05:05 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: wmi: Replace pr_err() with dev_err()
Date: Tue,  6 Feb 2024 23:04:47 +0100
Message-Id: <20240206220447.3102-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206220447.3102-1-W_Armin@gmx.de>
References: <20240206220447.3102-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sjpexojcG9PhmG/lOiKCA5maxHpxMZEgTZaPWlB9tq2zb8HGmDY
 zlAqeQl95KlNkQ1wItLe0qWIbeY9EcaIVIfhV3kgRCJ2VIqdaJhAnnteCsp/5bOIuqI/nNY
 q1OMxCzQmUKzbpaAsvzsDdOKFs30qpCrrXWIwTfDtMfQao/UbS1/tOknnIvPaldV2OIICDX
 t0Qp9kl8iUnzpjL7eZqJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tc5kJptXQpU=;/a1v9N+iZs6Y4ZYwWs/5ujvMmEe
 3jpcwle5lBWYMfHu4D6xaejL0nw3LauiM4qKb+U5yjctQ1BRuEUBByuq8jrerwP4Jd6KAg5QB
 lX2OFKZrT1NmPA0tVuFF1IK5/kEPGbtNvKkg2bJeAjH+9/76WKZ4bPOQcsoQQ8/ckiHdSPq58
 Mskvw8owdjdjOlpBjrNPNXP69zFcTwgz5cRuGitxb9w8Po1C8Fl+Knyr3K6+zk9TPIX0XvFqg
 MWoXbBFGFAwqIgmDa3JuDSh4f5KGX5nu5JUegOEMNuevtzcwsejCd5ngWecWA5HT6uAnYJfa5
 kMnJIV9jhG+kQaDDmurzrGcXrbwXE3STOoFQdult8eBA6rrpedAf/QZVloZ3G9luDU5qlT5Uu
 L7MmfXyhPJjoVBgEq8BVLsuSFJvT67UlitPuf/L3oFwp6vRf7Mjtp+Pv6FSiKSMuMBrhx7fTb
 Bn9LUJozJNBJSyvoNTwTrgoWTM4H89DRY9ig/QLwDQHWcQ5sRw9aJFu2+UZk0QgPuY0X4vUi2
 g9p0YeFGqrHoSgST3EJBLuyCsz6+vCNrEoWSiZRMcydbByc+aPixTnITsDX+y7kjQOQ/AGITI
 teRv84gQBAxE7xa4i8N8lS81oYjyQcbGhm5W0a3kBgGhQ612cbXBjStixbbbyLG6XsdUIYNzD
 XkAsY3a3urVyddjE5sSx4p0ebyyjCFiwleREsDlffP2KN/ISFH0JYUnIGmcu/tK4O3/q/4u6G
 9PbBHRmgGFEOMI1qauQJ1ZiqIaqKnkIyv/kUf85V6qLHfefdUu7oEUR79x/2dJVmHIc+XfRF+
 tFeeXK1VkukHH7U+2hVWMDNtD0gAB+XqEgVrLiGfn3AiQ=

Using dev_err() allows users to find out from which
device the error message came from.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 396344523bce..63906fdd0abf 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1339,7 +1339,7 @@ static int acpi_wmi_probe(struct platform_device *de=
vice)

 	error =3D parse_wdg(wmi_bus_dev, device);
 	if (error) {
-		pr_err("Failed to parse WDG method\n");
+		dev_err(&device->dev, "Failed to parse _WDG method\n");
 		return error;
 	}

=2D-
2.39.2


