Return-Path: <linux-kernel+bounces-109001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C0881337
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B97287105
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780645BEA;
	Wed, 20 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b="RgM6z9Zw"
Received: from smtp-out6.electric.net (smtp-out6.electric.net [192.162.217.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B13FE48;
	Wed, 20 Mar 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.162.217.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944405; cv=none; b=gbFbZM8Bm4zsR0bhGJFTB3aJQIIn0PW9ts/CVYqjOQ2Nsalpeby/U+bZbTFuZ0Q8wKao7pxRKHqHN65iyFNniFIfGKFTn5mTiU56EKbEkwRM2szbPJ0NRTOjNPu1Yak6DXNJGmaR/q7JGDBMiPranG80cnIIbTJNKDC8CwuVZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944405; c=relaxed/simple;
	bh=AYCj9L452RECc5zbYdcDVE8dBmojGYWNPpDLbiPVRpc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sUifSI2s7hHVwgJcC/rd6TISLwmxG1p3m75/K9ej/Qhma80QRqMjpwet6n9UMZew4aFcUz5GPid3voXXfsLSkhkqpv2zSqSySI695vYJAJwFWKdlmw75uOzGtw7xYKfGRq+3rTxv8btvD4Tt2hNaOcETIPTAJRPwgh5X1d0qjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com; spf=pass smtp.mailfrom=terma.com; dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b=RgM6z9Zw; arc=none smtp.client-ip=192.162.217.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=terma.com
Received: from 1rmwmk-0008Zs-VN by out6f.electric.net with emc1-ok (Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rmwmn-0008pI-Vx;
	Wed, 20 Mar 2024 07:19:21 -0700
Received: by emcmailer; Wed, 20 Mar 2024 07:19:21 -0700
Received: from [193.163.1.101] (helo=Exch06.terma.com)
	by out6f.electric.net with esmtpsa  (TLS1.2) tls TLS_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rmwmk-0008Zs-VN;
	Wed, 20 Mar 2024 07:19:18 -0700
Received: from EXCH09.terma.com (10.12.2.69) by Exch06.terma.com (10.12.2.66)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Mar
 2024 15:19:15 +0100
Received: from EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da]) by
 EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da%17]) with mapi id
 15.01.2507.034; Wed, 20 Mar 2024 15:19:15 +0100
From: Claus Hansen Ries <chr@terma.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "michal.simek@amd.com"
	<michal.simek@amd.com>, "wei.fang@nxp.com" <wei.fang@nxp.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>, "robh@kernel.org"
	<robh@kernel.org>, "harini.katakam@amd.com" <harini.katakam@amd.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"wanghai38@huawei.com" <wanghai38@huawei.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: ll_temac: platform_get_resource replaced by wrong
 function
Thread-Topic: [PATCH net v2] net: ll_temac: platform_get_resource replaced by
 wrong function
Thread-Index: Adp6z2UIQyAdxhAwQjqZ9B4o1njNZw==
Date: Wed, 20 Mar 2024 14:19:15 +0000
Message-ID: <f512ff25a2cd484791757c18facb526c@terma.com>
Accept-Language: en-150, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authenticated: smtp.out@terma.com
X-Outbound-IP: 193.163.1.101
X-Env-From: chr@terma.com
X-Proto: esmtpsa
X-Revdns: r2d2.lystrup.terma.com
X-HELO: Exch06.terma.com
X-TLS: TLS1.2:AES256-GCM-SHA384:256
X-Authenticated_ID: smtp.out@terma.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=terma.com; s=mailanyone20180424;h=MIME-Version:Message-ID:Date:To:From; bh=axJONggkune0GLy0Xa7qw6QXAfBuSv4UIuRZXQYeZTY=;b=RgM6z9ZwHL6EoyJmXYUhqzVIZoQrE/Ylrr13BNreeRvDMh5LQYjMJRKiujljEqZisTmeJu1ManDsp7uC6Ywc+lARERjo8ssgQKt3YEbspA+7EXXU6/q4UozyEsrH5Sw2DDjBC9icfx6t2tMuicPkBmobVkTV4wVkdiCZXWrMNXOiKWBUgcczXSr2LCS45rfGog//P8iDhG37t8f4vHKjbg9NIGmjp8ZYgtEjVTVihYysRZpvzdWQcMVBgBjVCuAtEKV2rg5PauLi50hHZTjUnO0NMFNI0wldoqhwCt/yArLSwlzYei+xdkQ2IFFuywEUTVzbOL7MiP1j2fJLkdP2mQ==;
X-PolicySMART: 6001202, 19049467
X-VIPRE-Scanners:virus_bd;virus_clamav;

From: Claus Hansen Ries <chr@terma.com>

Hope I am resubmitting this correctly, I've fixed the issues in=20
the original submission.

platform_get_resource was replaced with devm_platform_ioremap_resource_byna=
me=20
and is called using 0 as name. This eventually ends up in platform_get_reso=
urce_byname
in the call stack, where it causes a null pointer in strcmp.

	if (type =3D=3D resource_type(r) && !strcmp(r->name, name))

It should have been replaced with devm_platform_ioremap_resource.

Fixes: bd69058f50d5 ("net: ll_temac: Use devm_platform_ioremap_resource_byn=
ame()")
Signed-off-by: Claus Hansen Ries <chr@terma.com>
Cc: stable@vger.kernel.org
---
v2:
  - fix accidently converting tabs to spaces and wording in commit message
v1: https://marc.info/?l=3Dlinux-netdev&m=3D171087828129633&w=3D2

 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethe=
rnet/xilinx/ll_temac_main.c
index 9df39cf8b097..1072e2210aed 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1443,7 +1443,7 @@ static int temac_probe(struct platform_device *pdev)
 	}
=20
 	/* map device registers */
-	lp->regs =3D devm_platform_ioremap_resource_byname(pdev, 0);
+	lp->regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lp->regs)) {
 		dev_err(&pdev->dev, "could not map TEMAC registers\n");
 		return -ENOMEM;

base-commit: d95fcdf4961d27a3d17e5c7728367197adc89b8d
--=20
2.39.3 (Apple Git-146)




