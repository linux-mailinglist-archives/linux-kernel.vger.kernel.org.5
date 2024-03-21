Return-Path: <linux-kernel+bounces-110073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D48859A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E0D2833FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4784A20;
	Thu, 21 Mar 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b="fVzMyOFI"
Received: from smtp-out6.electric.net (smtp-out6.electric.net [192.162.217.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8783CD9;
	Thu, 21 Mar 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.162.217.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026560; cv=none; b=IPEWLxcYHs3AP6VLUtHkHEJT8kShcgy14F3epvcni2rvjQ1FHAiS06s0nt2HISmEDjubPVSreuKoTczfogWnMrNDovk4UJKm+ytJLO0z9Vv2hw2yNzebnGTXA4JeDZntVz6le/1+MSYIFIjijWjok+ZZRDlMqz2WSK6HM8m/lKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026560; c=relaxed/simple;
	bh=nvDy37NnImA8JV6W3BgDMDsvWpmT/Ree2g5/I0T58fY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tjyw9j7irLFSx93/Tf6EpmvJ1BqN7L5XuZv9TgCvRMXLQDkynxEiXnt3zV/3HZi4gbUAjmG8EwjTgmI91D/l8WnxTwGcKzxE8/0TyntlzUmWA1JYrYJBdSNHNp48v0v7K1UA8A/HxHwfTPRGOhXqqosjFecwSQLzkHKcRdBA2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com; spf=pass smtp.mailfrom=terma.com; dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b=fVzMyOFI; arc=none smtp.client-ip=192.162.217.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=terma.com
Received: from 1rnIAF-000CK3-W3 by out6b.electric.net with emc1-ok (Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rnIAL-000Cjc-VL;
	Thu, 21 Mar 2024 06:09:05 -0700
Received: by emcmailer; Thu, 21 Mar 2024 06:09:05 -0700
Received: from [193.163.1.101] (helo=EXCH07.terma.com)
	by out6b.electric.net with esmtpsa  (TLS1.2) tls TLS_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rnIAF-000CK3-W3;
	Thu, 21 Mar 2024 06:08:59 -0700
Received: from EXCH09.terma.com (10.12.2.69) by EXCH07.terma.com (10.12.2.67)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Mar
 2024 14:08:59 +0100
Received: from EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da]) by
 EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da%17]) with mapi id
 15.01.2507.034; Thu, 21 Mar 2024 14:08:59 +0100
From: Claus Hansen Ries <chr@terma.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
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
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v3] net: ll_temac: platform_get_resource replaced by wrong
 function
Thread-Topic: [PATCH net v3] net: ll_temac: platform_get_resource replaced by
 wrong function
Thread-Index: AQHae5DvcBQGjutR3k6qenCAG00K5Q==
Date: Thu, 21 Mar 2024 13:08:59 +0000
Message-ID: <cca18f9c630a41c18487729770b492bb@terma.com>
References: <f512ff25a2cd484791757c18facb526c@terma.com>
In-Reply-To: <f512ff25a2cd484791757c18facb526c@terma.com>
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
X-HELO: EXCH07.terma.com
X-TLS: TLS1.2:AES256-GCM-SHA384:256
X-Authenticated_ID: smtp.out@terma.com
X-VIPRE-Scanners:virus_clamav;virus_bd;
X-PolicySMART: 6001202, 19049467
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=terma.com; s=mailanyone20180424;h=MIME-Version:In-Reply-To:References:Message-ID:Date:To:From; bh=IDfZnO7QGbsU29t2V7zzkrAVifHGRoHP+pRJ13Ln7PY=;b=fVzMyOFI8+XHvlRrj+xR0VnXD4btKfoLyjx5VIpYGOxLTZCwK8LWKXKOvt97iSiT0JSSc0Oymy8VJMXSdKD99mB5N0Cg/0yN2XVSgb8UFVHLJUBEkv7i71eTJ6TFOsOYZSTmbaZvA1Z9IPirWs/nQsF2Qfosrjk4BTGq9Jq3Rotv28+AFzMU8pASm5d4xwqVkX5N2ntWiHiRI7J139GRuVIaz3bp/uCsvj6N0UqQ/qnNpas4raxzCz9m9s7vqa/N9D5gKlhiRz6KCRf7Qp3F3y59GcNRfs/bjG0Q/Mws4xgc+sy1s9PHnWE0e3OEz3s8dE/iM8pQ4cZnjoEfjuxNNQ==;
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467
X-PolicySMART: 6001202, 19049467

The function platform_get_resource was replaced with=20
devm_platform_ioremap_resource_byname and is called using 0 as name.=20

This eventually ends up in platform_get_resource_byname in the call=20
stack, where it causes a null pointer in strcmp.

	if (type =3D=3D resource_type(r) && !strcmp(r->name, name))

It should have been replaced with devm_platform_ioremap_resource.

Fixes: bd69058f50d5 ("net: ll_temac: Use devm_platform_ioremap_resource_byn=
ame()")
Signed-off-by: Claus Hansen Ries <chr@terma.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
---
v3:
  - Cleanup of patch message
v2: https://marc.info/?l=3Dlinux-netdev&m=3D171094427802626&w=3D2
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




