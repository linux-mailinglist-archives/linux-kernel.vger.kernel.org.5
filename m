Return-Path: <linux-kernel+bounces-127776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC08950CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA11F24B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E05FBB1;
	Tue,  2 Apr 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="X1vZcX8D"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2074.outbound.protection.outlook.com [40.92.107.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2715FBB9;
	Tue,  2 Apr 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055007; cv=fail; b=mXXCGHoXCI82MGrnH9xk101MmSIYSP2WRHolNGWOli3fM91G1g4PQQU+xnaX5ONxVrx5CVaKvlwTguJr5ncyLCWto3ahVWChz+OUuY2AinKt1HloCTX37i0baA7KGUdSuhz5KbIAjRsnYWnKHf83FKDRWePRLr0Pn5c7XFr5jFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055007; c=relaxed/simple;
	bh=J+AYVIwY42M2Vo9P2lW3k7LnHY57WhkzK6eXH6+pjN0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s8CgFFTMG0V6l0Zn/11+vmJN2FhQIxNO7pc6Y+gia0fyUHYBJ1ddN7PImFTmnXbL1TK+EtU14+JmiVS/yz//b3kheXubPpBz0mKuFdQdeLk4LxOjH+RNMfrL268cY2FpAz1lcAz6IwhFMP85N5HOlMSDhjxWdj95/LhaP/sk1sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=X1vZcX8D; arc=fail smtp.client-ip=40.92.107.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLzupaAEGHwBZUoA8kT+GmnH92hrDJ2cO30Q1CURmRs5b9Ws9v4pcntL6wzuv1fWVR69rO0PyAoiL86m+F1Pd/w7aPbmBOd8BeGl1PbSlW+e8xt8LkKG0yH54oBfgeuoGLcCQ+ZWEDXymYJd7aQ2eW0g5tmkO3c5BtDqwlEhIo1RlnzqhwVJ7ZDja5SkIujfQHsuFC8NuUYUMxz+zcJYzLk+jICWQALfAMS/rf4oAwcYJLfygIhvCyvEWH6866lpicd6pN4e6Kl0Occ58r1X+e+Aphv++p31ckQacD3D3j8RyVM6RTtEgZsy8LrAHZzU2qb7wWP9OiRTEQWpMVGDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txh47MiY1P34TzbU8Oo5xsmAeXUtMN7kv81T+syKAUI=;
 b=Tq4sKjhxZbCPwfN1lhKgV4k3z1WZPMcJ0zg8jluEXi2XiV5putk3ht/z1B2Vfgzu4ndnhOHEhzWVIzMh8OWmY8rqZBWJj9T5pfq9Ej09pyURuXFgfiMXvwad2ul7YhQnMLGdHBM+0yQ/Jr3du84CpXMLQmeCvp59dg/gbQhMGiHQQdTRRBM7cq5lAAaH159Q36YFetDWGHilUCLlXsjLU5FD+j0iT8W0j5WFcG+/as8dmEfjZVda1syRAPEmN7wxgEf8oRAbJ2dzgVpde6Aykm0BU+pZo264eJoMdicj0misXEcBIYMsI07NyzBc2qo6qE48XiYo6+kIa1YCrkp30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txh47MiY1P34TzbU8Oo5xsmAeXUtMN7kv81T+syKAUI=;
 b=X1vZcX8DqloHIoreZkFQoOGi1wsG4ciO6yK+nKHsytz/VeeHw7Rntq6gYaQdh7VAlpTG5ELS+QsFPSdgS+HeJb44TM8qyhZYrIR6UC76dRn/JofCXvyqcJGYGct7XZ0l1k2iM0fMIYIv3qoUINKYlpWNfrjLYkk/k67rn7t6XD06zyfbV8rGH74nREPnYvzpqNCwFpxI4eRqhQ2wTv8zcpFNZP5A0/AfBVm56qWZmAioAbu9tdzXGv7kqp+b3RSzA7YNlTjIjydwYBTnhmuDTxdlt2Nd3dGa5hzHYb1j6n8rWqSa9ySA/QWrYcEZTA61U+TLkVPEOTsl7lCPkAAZJA==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:50:01 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:50:00 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v2 0/4] HID: Add support for Himax HX83102j touchscreen
Date: Tue,  2 Apr 2024 18:49:26 +0800
Message-ID:
 <TY0PR06MB561132DF147C037093A1B94D9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [m7VimHcaK7YOgmqWG7LXW+tOj7cX0zCZ]
X-ClientProxiedBy: PS2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:300:59::19) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240402104930.1053016-1-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|KL1PR06MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e445a04-60df-44a4-f5d2-08dc5302a4f0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Aj96jlBhaK+pGIBKwf/7IioTywRX3+6WnBexVPQ+sql/s0sdLvRWBFpqWkwFQ0tinPbvrhM9wOFgIwyA5P59KT5JijL2Pqr+BYh9vq+EnTBcXLkYoc4FbTxdlSX2seDCcE4N32tOmu3Kakfw9ILyzKJnpOU9JxXyXq9WKy1C5IHgKqdn1JatIRU7xUgh/aFaVs8ET3LhIsdQ6SDyizTEc771K5bnNgw/lWG7h4h8K3oU+gDUv5ripS9cHzvcOfVGlpuYoFijBB2B5Wd+28bW1/3P18Iqk+OJNCJ0+FvJqRyNsGqY25pD7toxFYxvy649r+dq0TjJhTcLMDQiplfKzTLGk2XPR3jZKlT+gdolI/OrD5fUF8hC2O8MCwNgnEY0gwajGc0ghRVT7aAkBoQEb3P873Q0AX+PgayAbdJhdaYMSwrJXzTvdbG1R1MRTQcYN2pPQdHx4TsSoz1hqHRmoc0QYJh6+C+cajD9Qkb6nMxqvEw5y2gtR50Bw9tfJ224l8OQ8NMNQuch6DIdwnZJ/0m+09RaqrhXWbY2Y5QFLb0rsQdqQcitS9HigzGJTy3EKWJK++g5Hc6olTEOl11zy2GADl1rew8SXvAhsLpIn30iZ/8esWzkil6aBXvrjDLM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AF9LwGD4IPnFW/ALjwEG0nz8dt3GP/oC9RD8QxFgd3EMW0dJYJPhqra0FHUO?=
 =?us-ascii?Q?wGxdjoiTDhnnS9jxtxPC9jaF6zT3IjTd0yqiUZNaheY/LsqXB70cal11hPuY?=
 =?us-ascii?Q?z2LhYXOnMRMUBwdLrKdCSwkHtjSL5EfBwUimTidydYFxeECiITmy5TzEIj35?=
 =?us-ascii?Q?6babsUh0qh5bKYWkt0W/KirKUkw1A1W5p2EXlYYMq9ElRxXxArmS4frBbF6W?=
 =?us-ascii?Q?vUis+M39K/8NpxMDXb4Qm5+CwdxgLfYVW6EZ7wLSqRud52q3j7hd/c6Cjdee?=
 =?us-ascii?Q?SqoIzWw6HAcKMtlsksHN88bCUc2G32//VVCjGZek5Ehy/IqjuXayuZeYg+Tq?=
 =?us-ascii?Q?T+BG59Q8DsiXOZoOarSlpN26OQafYDDpYNTI/Iqo0TQu3jUqWFZyreKBMZe5?=
 =?us-ascii?Q?X0APVA3zTr3BeXSamSiUDepbfV1fIG/gHdFvtgROdH7gVoiJu8e9sGctDCks?=
 =?us-ascii?Q?+FWHSqbpfYziuVRvv37avrbvZmMicMq3pf9HW58P0PmLYigcTory32xFCPRw?=
 =?us-ascii?Q?9hR/nzo5p6zzzKonDKA9HqyF1roV+li3GZXG4p17XME+HTdd8UAlVBC/F404?=
 =?us-ascii?Q?fvUnvvxeuhiUbeRnxfh2K4cTohS5b4/C0sm0m37HP3QxwpcTqX/t2FQyfiON?=
 =?us-ascii?Q?BmsOHGRZZVPdHEm9zL5L4uTD6h9d5ePxxBcUPCR2juByGOrfh13Y5RFqYooh?=
 =?us-ascii?Q?CeEZEMz9RPZkJEgo2YX1mLa4jaj4P0MAuPfmkU3fTpB7Lyj03mkv7pra5bdj?=
 =?us-ascii?Q?+GFL8Ur2SSDDBxOsL7L4t0Cl7Djmk2hE5KZ9nMcYBiUzypOHyGiw9kQjXbkp?=
 =?us-ascii?Q?qcTVpJHayWIrtqGjUNc2IeBKBDru5kMPTC0wBLcqi1xpGFbC612u4odVG5sm?=
 =?us-ascii?Q?S+/0A5tdOXKQaf1gIS5UvZprD3AGekvS09PE7qR7Eq5L9tRYtVX5fMQChbDA?=
 =?us-ascii?Q?jPDhrPcnHe/ykfEyJ/1TxK3+A0QQ1h7mSMw4bvvXjbQ791mdoY8O45rIQmSR?=
 =?us-ascii?Q?iMO+Uby4aO11WNwYO4OafG6MygMs8LkoGosvatJ9T4lDzxUmx817y3yr6eJ5?=
 =?us-ascii?Q?NF+QK1DBwDa1I7lLJdbd7hqQsE6BFBMSIlCxS8GNaTZgzdIv7/arD7kWvkxF?=
 =?us-ascii?Q?qPbrnntIPYmbMuwsyFgoh3DsRo9sKyRzmMpZMPX2j7c3KG7W2XcnrNR2IXix?=
 =?us-ascii?Q?CUgPfwEgWW9pGPzWgaq0fqF1ukWpByWBmDjubMIXFLKZQQZ+fncDrQ2wxPQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e445a04-60df-44a4-f5d2-08dc5302a4f0
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:50:00.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6964

Hi,
This driver implements for Himax HID touchscreen HX83102j.

Using SPI interface to receive/send HID packets.

Changes in v2 :
-Added power description in YAML document. 
-Added ddreset-gpios property in YAML document.
-Added firmware-name property in YAML document.
-Modified the description of pid.
-Modified the example.

Allen_Lin (4):
  dt-bindings: input: Add Himax HX83102J touchscreen
  HID: Add Himax HX83102J touchscreen driver
  HID: Add DRM panel follower function
  HID: Load firmware directly from file to IC

 .../input/touchscreen/himax,hx83102j.yaml     |  100 +
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    7 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-himax-83102j.c                | 3071 +++++++++++++++++
 drivers/hid/hid-himax-83102j.h                |  460 +++
 6 files changed, 3647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

-- 
2.34.1


