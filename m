Return-Path: <linux-kernel+bounces-57245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97F84D59B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0F228C6BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4249535CE;
	Wed,  7 Feb 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J0Zvi6Np"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481E535A9;
	Wed,  7 Feb 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343250; cv=fail; b=Z/OpfRthd4eArzjIUQDUcH0+9Nf6M8UHP1L+1ncv1wSN273vQAE47VBuo/nR22AJ735TgmQXT1pX/C7hul0/fyGpUwIi/SFe3dOK7sBLpUdXlXGUyrB4Xu0w3h/ytfQBBoDAEHC/3hcqzUYfH6VkewjhPEDqozcr5UDOYF9jZGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343250; c=relaxed/simple;
	bh=l8XVtkj5V9+tIRv4w/ImrBT6vu1jn5/O6HMnIrhqD1I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ERuBOnK+76aymYM7epcs2hejlU6gU0ZIp7RIe18z2dZcAMaN0Vh/m/RCoU0fPBkEQpUEyyiJKAkJHCONE7bg1P8nCGx2xzscUFYT0P9q/V87sv91rO06TyPZ3URqY/CWj+ydCa04MJvZdjmOyMnxBq+PfxAnlEm7GQW6IH8NUp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J0Zvi6Np; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqvjWViKJ/F5pccgF09L7NHnLhK3i6wB/bZFziI3CtqvL56niRPxVFcYeuVk+5ToOSvdGXWq5LkGJGCSdlwqnkkMl9yhTllUNPEwc/BBoNewwV1HgNygK5iVVbHmntR9+cdPSTgqpF8pumpSK6AMPSciVLsQUFQsgW+JV3+FdPzprz0liH8R2d9mlsEQrB9OwY+7BtZ+t6dBBPe4EBVEQqOH1A7n2TMcrj0nWbGrGoAp7DLwBa1P3PlNwSk891mj7stCCF+/+ryF/ckN9fJEFzJ2wv6CSLMlhX29dMC2V5EZqBHqCpdTrWMQz/QfZjFGPsUkUli3AUqeJam2pCpYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpUlKynusu927iapLN/bLVnoIFO5fCR/l8kP+PZwY1E=;
 b=ZBupDu4dJkE1VOx4nocu4ulkDQWjVpHJsjWj1CQRETsKKSVnLnItRDeFrK67tXtEqG/Ag4UDPmh/Bcadx6hRkhMYq85lBrgvQK0pX4HbgMMQD7532/xgHYCwOB/CGWMpy04CwTz5mLutVQDQTcKPb2nw14BFAdPxjU/MZ2g4oxAw95XehzncqB43wMt1ETp6Nbjzt1po+LNsqMaPMx5rL6yQ1/vtpKdmzMBZlkusz9d8QCE7jyU4f09ieSMRVGlXX4XD2Xc7KLk/r5aCueaABp7DBOAFFeBGkD3q7gWDrUvcNUoLjjj6owvtiJNw9M5XpXuQQfitDch9nBvjn9OP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpUlKynusu927iapLN/bLVnoIFO5fCR/l8kP+PZwY1E=;
 b=J0Zvi6NpOwWg91NPPt7WcoxNRzG+QTJ3K0VZn70/U9qnXiSNSAe3sn+gtcd1Ap+mt63PoybN8aCtQmPIMH52odqNLFqqS1IiKaFBdThvIU9WXlRBYpmIfTGYWdTNFTM3k2AMX0YP6MvoH0InfRA+aa+v13vRknVBl9vDLB1SEaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 22:00:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 22:00:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Date: Wed, 07 Feb 2024 17:00:17 -0500
Message-Id: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHH9w2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwNz3bKk0mLd9JzMkuQMXUvztBRjE4MUi0QzMyWgjoKi1LTMCrBp0bG
 1tQCBwjIpXQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707343242; l=921;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l8XVtkj5V9+tIRv4w/ImrBT6vu1jn5/O6HMnIrhqD1I=;
 b=uKbq6JR4s6Hls1G5gv2QQEDTnWSnTYC9q+VArASyyxlNUzZRkslXJzt7r1/YvbzaQ6E0I8bDP
 f0Xvaa6OyBEAaOl//O2ssQT0qh2+lm/moOVUahlZs6hL9LabU0VskSE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c33a95-7fe0-48f2-b67d-08dc28283c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8dz58lpCi1YadaSleqUizT1/Ud0xlm3DP9JwSJjwuy0uV9Z7IDZIA+qiwrYQwjebSp/5KBUqm4A8JC4wOFbPEoIfFArfSby6fLXVpkwRkIj+hOZgDc9FPWXLLbzczerRBbrzw46eY9UM7B81zCQlKao8jzWoRTIWbD9K3I/jqN2kmXI4tGYeDh5E5bAzGz068Wzq3N5rsbiEl6ddkiNaVZIP1Gp+5Q3iTcdtGvx7R1gDm/fLlmSRTtCQyselHlsM2ciwQyddn4VQ7Fo/1MQIjQQnNumSSpAwXDs/wPTtmxV9RRU3GVnzTSQ32jSXI1vCKBhJuUQ/pxtdWDOyoJHtfe0W2VU2fS8XWldciNd0eAsDE6an9KGf0+CyVU/79EgIsqAj2Se8itRivyYd2r2lFL9aBkaFgIbCBElna7dw8ci7obxYTpPzBoU+WwUiwW9AjUeSgO0/RtuoHzbopk5oS4pcQMnT90Q33b9hDW+eDga7IDDlVhM5eUfH/t5sbhrG3Y4aHRN7/twoZPRDTA+qXBQjVkeFhULjhQ7d1TpXhqLfVpKg8KoRWhlLxTLY7asCIYa6OdbTMHuqutfJsCJZDOdMInPr0t3eyz2IDWfP+WQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(52116002)(6506007)(6666004)(38100700002)(83380400001)(86362001)(26005)(41300700001)(2616005)(8936002)(4326008)(8676002)(6512007)(36756003)(966005)(6486002)(2906002)(4744005)(478600001)(7416002)(5660300002)(66556008)(66476007)(66946007)(316002)(38350700005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGZieVE5ZUxBdk9meFdxVFBMY2xReUNWYnlNWWhDQWMzYVNraHlITDd4ZXJZ?=
 =?utf-8?B?Y0N2dndmRXVkRXVpeGw2bjRkWXZkeklqMGpZZjB1ejR5cFhiSVVhekViQlda?=
 =?utf-8?B?VkpSVmhoU3BxcGVYcGVDM2M0eEFDckRMb3A3K0htS2gzdEl4UnFGSDNoWlgz?=
 =?utf-8?B?VHhndEVkaFZmaUZMNEUzSkpOK2ZjZGNRTlpybzhrNkFiSjluT1oxSHd6Z25s?=
 =?utf-8?B?cjc2ZWd3S3oveVJieXhjemVpOTVUT2RHeENTOGlveDFNNGdCa21lenV6Q014?=
 =?utf-8?B?UVVNb1JkU2wwWVVjaHZvUWZPVWd4MGVNcWtYQ3l3bUdyaEJDcFEwTTh1L0Fx?=
 =?utf-8?B?K2RtaEtQd3hOZGdlZVhyaTJ1VDNVTzNNaHVmUG5WN0J4dklQaUJWYXoxaGda?=
 =?utf-8?B?UGg3SzRWdSsvYmJxRllrQ0hDU2VIMTV4RXFvQldrRkdyczZUOGRXS1o1ckN2?=
 =?utf-8?B?Lys5K0IyRzhXZXdmcCsra1pVcElJNVF5UGxFQi9iRHNWUjY0WEtKRmtHVTZ2?=
 =?utf-8?B?alNPNDJ6dUhhWE9KQk56dEwxUUVReW10Z2ZQQWhoS3VvQVpWMlRhRENoeXRz?=
 =?utf-8?B?Y0g4ZFhDZytRUUdWa3R0Y2Q5YmlraFI5enhuYWZlMGNSV2tZQlNiWkc0cVZD?=
 =?utf-8?B?ajlnMjZHZWUxNTg2eTVRdGZ2SEUzZ3hPZ2phbVZoMnExK244SEpzU25DQmlJ?=
 =?utf-8?B?azFmUlg5QmRNSWY1VkwyN3kzaDlVQ3UvYlFmdmxsUVpReHhFclNDUUpLL1hW?=
 =?utf-8?B?eHRIRG5GK1p4eGd6enk0UVRrSU5KNkFKdUlqQjJWeXlpZTU5Z0JzYkp6eHNq?=
 =?utf-8?B?RW9aRUoxTmszQjdVbVpkWGpHN1pIMTR4dzNsVnF1OThOR1dOb2tXdjJqZ2t2?=
 =?utf-8?B?YkQ0Z20xMGI1dWVOZUZ2K1V0blNGU1dncDZSL0xEVG0xTlZXaXBGZlVSb1Uy?=
 =?utf-8?B?bURuRzROMHVDQ2FSQ2JkRXZ3WUszK3FXdWRaemtEZHFlazYweDJvRTlpdlpZ?=
 =?utf-8?B?US9wOTV6WjVQUGNlRVBzdG1kRlpzcmdJMFE1Q2RZZ2YzbEQxdHNxMHoydGNl?=
 =?utf-8?B?VExHYUFCeEZWdUQraFpZNXJzaTlpT0R2eWk1ak9oZ0VLUTlLUDlKdXRwYWpl?=
 =?utf-8?B?RnFkckNPUVhBRmxCcVVITEpEWGVlUkFzeG41SkU1alFPOU43V2lVcG53bmZx?=
 =?utf-8?B?T3NwUzdxUi9tYjFPVUo2SmtEZitadGRVZFJ2WVVMeXZaZ0RYckcxUDZycHZV?=
 =?utf-8?B?U3dJajI0QTJPUTJxbk1NZ0JKdXRjcFBRNDg1MnA4Z21vNXUvV1U0WHFpSDZL?=
 =?utf-8?B?L0YrT2FjVHUySkxINHBldTlPcjlaRk15Mzk0YmhCUmFxcWJTbjdZczZkaHpw?=
 =?utf-8?B?OUhDOVl5UllNblkvQTFJdys3YzEySkFvd2E5T3gyVk1IcWtTOWwzeC9sZWVk?=
 =?utf-8?B?RjNhL1o4Y2x5R01mZDR3cStLaGgxOFhnMlBkdUE2TEwzMHFqWjUxYTRiaEVT?=
 =?utf-8?B?bjh5OURud1c5dGR3MEdIYllhWHhIR2xFUUlpL0kxckExcUZET2FMcmdGTys2?=
 =?utf-8?B?K21yMkpUbk1VOG14ZFIvN2FvVHUvdHhnT1RpWGFoL0xzWlhRNUhUbWFLN2ds?=
 =?utf-8?B?RGhoRVdpRGdSYzZJNVNJekVGbEN4ZENCS0tVeTJycVdnRGJYcE81TitoV1Fs?=
 =?utf-8?B?OVhUczUyUEFUeVdodjV4eTVTb3NhTFIwOGlGTmRXNjY2WjVaeVIzbXJRVHpT?=
 =?utf-8?B?anI1Yis5TmswRUJENGpjY1hOMjlLQkpoM2o0U1E3S0J1WEMzcHIxY1E5bHI3?=
 =?utf-8?B?UHozK3JubmZJdHVHZG00YUR3K25qV25XN09ZcWNONzVtSlF0WGM0S0N2OUVF?=
 =?utf-8?B?NE5lU29acThlNjRCRWtYUFJDL0k1SEdUeGl3VTdFSTN1di9CbWNJZ3hCREhj?=
 =?utf-8?B?UnQvN25KTEUxcnNkNTdLNVlIYnZjRFgydGNoYm83dHFxSWhzR09GUGd1amt3?=
 =?utf-8?B?am1PeGFNR1lneTNLQm9aWGd2angwcHc4Z3Exb2lkZSt0eVEyYjFISzNqdjkv?=
 =?utf-8?B?VnU0akNIZkxMUHZYcjQrRE50aDA2MkszVDhrWTBWbmdSODRVbXVoYVVmRWY0?=
 =?utf-8?Q?PxlU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c33a95-7fe0-48f2-b67d-08dc28283c23
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:00:45.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdqXTOQhZqtTkPt+Ni+EAmqP6r2QOOg8vtkd1I47nT9LEfTurFMFlmHfy90F6xHSZlLkKbysshZtm/too7Ehbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789

Since dt maintainer give comments at old thread
https://lore.kernel.org/linux-usb/20240119213130.3147517-1-Frank.Li@nxp.com/

The patch v4 already merged.
https://lore.kernel.org/linux-usb/20240124152525.3910311-1-Frank.Li@nxp.com/

So submit new patch to rename snps,host-vbus-glitches-quirk to
snps,host-vbus-glitches to align dt maintainer's comments.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      dt-bindings: usb: dwc3: drop 'quirk' suffix at snps,host-vbus-glitches-quirk
      usb: dwc3: drop 'quirk' suffix at snps,host-vbus-glitches-quirk

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++--
 drivers/usb/dwc3/core.c                              | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20240207-vbus-glitch-97fd340d8a66

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


