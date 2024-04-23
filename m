Return-Path: <linux-kernel+bounces-155351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC6B8AE93B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A271D1C225AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21FA13C3E3;
	Tue, 23 Apr 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S0Fu8vR3"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA213BAD7;
	Tue, 23 Apr 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881494; cv=fail; b=GjVmJymtMgmjWrnarUz+XyBkHe69XWxoM8yfcdH1Oi4eaz1BPrC+ZQCjhK7NZ519LFONxnuiRjfQYk6Nr9ybxCy475GU0URJeoR7AdmUm8Sj6AXgQjnEQHDDs/VN5jwO83rPuYIATVXpq4g6pz7cURXEfuLDOyEWo3vNYG14bvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881494; c=relaxed/simple;
	bh=qrQLaMF/gRED4r83So9+2LZetjs5jchCu1eByvUzGlU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BexaXQKqoKuWojvabfkHo9QahmhKBxjW/3ZsdiBDam2LFSxkQbqCY3wJHrEeYqu37I3oTaLGsl4RtQJLirNIfhkydslA2WTPuctqpjprDMrL1uJOMtGT8/E3gHtX0yGb1zvLMMgTZcDUPSSHeOHGfDf0rKEdVeK6OJedza1pAUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S0Fu8vR3; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTkleusIGtUmasaLC1OCyUp4sKGK/kBmmaXoC+UJHvrmFGyJ7bFTzkLyevJwRqa3LnmXd8QxgWUEkLWWoANcQh4aoMZ4moUBNSnJW0jCTvEL7oXo3Wf7gQQeIYciWsl6p7PGQ4DFOMrpImYQtbO7sPhr88+c4Gp422ETwaguCnPKMjLW0zEE+jF1lWFGoqLBk0NWkkgfo62shYM7D9BKELKHAdylKq6Pc4bEf4Try/+3QvehWjiue7rSvOy/Xhj6sFIWfv8mzh3EfgY5UgVTtHsCSkkWkAYFXN6KcJ/UbS5KifgPTsm7qeQ+WWQmekMGClq2ye7zQjL9UhhspZDPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3Yy3JMXVqldoA8/f5RBTF8QfUPuwIP+06CmUzmT8Tg=;
 b=n1GxMy+z5LDcLmK6YmYsQy/QjtjbKscY9oIDuVI+nxFa9Qrj+LvTr37o/UTyZkupeaUD9Q+LHNIh7+6gAJThXTf2RzU4fWIr8DDCl5WCnZy/u0ytXqT3woZ1KvXrQaHBthUwmShXIUAgEUBWaNIjC0wfUFxFKgIAyX7+pKy8zkbAu9j1GkgfGw63nl5hIYt71O/wqnd+p6eqji5ZKq4jQb3D+TDatVtqfN9U9S1Pn8wWA8vOVqz6QMEA8ypX1XSVgxrLTuMCeV7uVjzQhqH1OZ+1FiuXdmil+3qLRORN/ggJRAMrwecPZkg3wOgKGse+XZrkI5L9UbUwVUC8XwtceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3Yy3JMXVqldoA8/f5RBTF8QfUPuwIP+06CmUzmT8Tg=;
 b=S0Fu8vR3T2qrtnhuJrVesGsW1QO6hbZq9X9GjPTBKPm8S1FXoieW+zXYmCQ8AGkGxiKLlZJRpwXy4DBYCGIfenIawbRepi+/uaOKz1ygBOKM4j32dOZFL1vXmUKOitwlVViemcG8DSzUV4EH6i4e47qupVUL/VAchgCiDitKIYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 14:11:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:11:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Apr 2024 10:11:15 -0400
Subject: [PATCH v4 3/3] arm64: dts: imx8dxl-evk: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-b4-dts_dxl_audio-v4-3-0c57eb7399a7@nxp.com>
References: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com>
In-Reply-To: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713881481; l=7899;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qrQLaMF/gRED4r83So9+2LZetjs5jchCu1eByvUzGlU=;
 b=tgew2C6gS90qDU/v0a7sUjgT9kE8oTBIr4M1rYHMuQn9hu5IioyfGQkWwdN0PLN1xLbWLjuwS
 v4L89/PogkCDHnkenmS6MC3cR0albxR+CmL8X/v/S/umUfkaaKIXfx/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: f4901cf2-2b84-40e6-46ff-08dc639f4536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFVqeDRwT2NNUEwrSnV5K1d0VzVXRFVISWlyemJmQmU4MjRYOVVhWHVuTnJV?=
 =?utf-8?B?aEpBdVNyd3BvTytndDJWYm9mUkJrUmMzTUEzbFhlS0NJUnVVMitPMUdjSldw?=
 =?utf-8?B?OTdadUVzejk3ZUdnK1EwRG5yMzNjdFZKU2lqbUlHaHJZUkplUjdEUGRYekI3?=
 =?utf-8?B?VDZnVDRUZXA3dDBvaDhLeWNrbU9zSGNTdkhrT0dKZ3RvRURINVF2ZzZkbFRP?=
 =?utf-8?B?Nm5LZDNiZmJobTFCK2JhMjhyWkJoelNmaWNsbkU4QXUwMHhDa2YwYWNOL2h0?=
 =?utf-8?B?cXlCVjJzUVJLU3lGd0o2Ynpub01KL1dLTlp2L3lvWWI0eWtIaWZPbGlMcXN6?=
 =?utf-8?B?bDdoWVVhVk9Zd25kWU5pbC9ER1plR2pJTThpb3cvMzMxSHJKbHBzSVcwczhq?=
 =?utf-8?B?WEF6U2FYTlk1Nk9zNEsyS0kzL2ZsODI0ZTN2bldrM1RxOE13RzNuUkNWWXhE?=
 =?utf-8?B?aDA3V2dQTjRqak5ORHExekRyUDI3ZEVVTUkrZEVuV3NQRjFJTFRHUlppSVAy?=
 =?utf-8?B?WUkwa3Y4dzloMmdSSFg0azROcjBHVWQ3dHJYanA0eitsM08xUTJrWG1STHJr?=
 =?utf-8?B?WmJpeVppVXppUERpNmVmTG03M01QdU9VNTlYNFBKVldnc1ZzZFhmaWhmcG1S?=
 =?utf-8?B?ckRaWEt4SkJ6MGl1QlNKT3NoZHcwVEd6SCswYWJmMEF4MzdEQU1Yam03M01p?=
 =?utf-8?B?dEZ2OVg2aE80M241SXVLdHhobFlEMmVoelN4SmF0WEVhdUNBajBTMDJqRmpY?=
 =?utf-8?B?VTVadStYdXZPSjFDeE9LU2tFZDU1NnpMTEtFRTR0VVRQVlZlYWpDNm9MS1Bv?=
 =?utf-8?B?aWRYWDdvWnNNSjhVeXJOQTB4WGFJSittRVQ1bHM1ZTd1cFNIWFhkQll6K2Nx?=
 =?utf-8?B?eC9yWEFwUUh2cXJENUlJRHcwUklqbnBlbEk5NkdyWFVpbFluc0M0Rjlkc043?=
 =?utf-8?B?OGRvcFc0NFZRTkJyOEhrYVFYNTEvb3pPVHJFVC9TOWNRdE1GYzZuSVA5enFo?=
 =?utf-8?B?VkpwOEdBS1lMSitlWVNtenRwbENHUlVoam9WaTJRRjJTQ2V0RHdRV1hwdTds?=
 =?utf-8?B?ejlxVDAyRmQwZUdhaktpYXpoMlVOdURUTEJnTWZWN1pud0hmYmxuUzhnTmVp?=
 =?utf-8?B?SE9qZ2NzMnh4dWpPazRBb0NNK3BPZ1RPSlBZcWx0ZmhjVWtxRUZHS09zSTlH?=
 =?utf-8?B?bGc1a1NORDNJMnZudXBabkFLY3A3S3FlQW5DU3l6ZmgvL0d0RmJBWUhtbjJp?=
 =?utf-8?B?UXpxNFZmTWx4Q2hTSC8wSVZDZ0g2YkYxZE41b3ZycUdVMTVsSWw0ZGhmSmFK?=
 =?utf-8?B?aHZxWmJUNW5Gc2FWVW5zVktXRmlWdlhiR0VQejJWUFlIdmR6aXl0WDl1bmhL?=
 =?utf-8?B?bVlDUnJ1RzhXZWpYcldVbUloRW9GZ2NzM2t3Y3ZzNkhsTytDc3hGNno5UG4w?=
 =?utf-8?B?Q2E4eEhwS25zY2lDdDd3dEtZVXJYZ0RGOVhkVmNwcGZ0TzJtWE4rWnBLTmZD?=
 =?utf-8?B?UVF2d3QvU1RVNkdGY2lBR1hORnpiNDRTdGc1RnJGVElNVHRyVmtTazNuc3Iz?=
 =?utf-8?B?VmtYRGs3MkN4dGhrL20zSFVjVHFiUTg1NmtYMi9SbmhsS3hRNVQybkpERkhL?=
 =?utf-8?B?ckhHWHpwbmlPMWwveTh2MjF0WnFsRlJGQnVsMlQvVTRDWmFoak1vdGVQazBv?=
 =?utf-8?B?REU4WEpYcllkVWFkczJoNTR5YU5FZWdNbEtURnhXZjVNZXAydFkxZFhqVnh1?=
 =?utf-8?B?anU4Y0RZZGo5RHVJQzlFZWFGT2NEdDlXOE1Rd3IyZWR6OFZRWm9PeW0zT3cv?=
 =?utf-8?B?Q0t0RGdHTTl0SDd0KzdWdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2w2RWkxT3Bma3ZZcUkzSk9UUHE3RUtEdjZxeFVvcjhGUHJOS3ErUmJRL0dX?=
 =?utf-8?B?SkFNYXJzUjNZNW5rWnF1cG9EL25tYnFxeXh1STBmYTZQZHhZODNpcWVxM29Y?=
 =?utf-8?B?R3FabUxRN01MdHh3K2pTQWdBYjFncFpabi8yZEkrd25LTmRZMlJDL1ZPQWYv?=
 =?utf-8?B?bjBNRXdzU01YWVNwQmV3cUl3ZGdheXlnY3ltb3E2eWwxajEvcUxTdktCeERB?=
 =?utf-8?B?dnhmR3hpamhXNG1BSEg5eXEvYkpkNzNsbGdoenNHeFJIdWNFTnlQUFZDU2dR?=
 =?utf-8?B?UE45MWpKbHpRMGFEb1lmcEgvYzZ0RXlLcHVrSlF0emxJUERSczl1RXVqRktp?=
 =?utf-8?B?OUJqcUhDMTZWZWowaExVN2gweEVyNmxqOWFUbXRjNVFPU0NYTTNUWkV2OWla?=
 =?utf-8?B?SVhTcEQ0OXoxSkRDRXVRc2kvR2VKM0tFNFRYdGMxcE5DUEVJZW5zeUh6bFFD?=
 =?utf-8?B?Nkd5a0s0UXRmZFV5UjYvclJEMVZwZWhwRXkvcTB2OXBVdDc5a25Vdm5qWXM2?=
 =?utf-8?B?cnUwaERtZGxtcklWSmRjSHpkUENmdm1RL2FLSW8xNE1ka3JtUExKR25qajA5?=
 =?utf-8?B?d045WGUzaUNCRUcrMWMveDJCcGhXd2F1ai83Q1RNSTdxd0hwMk5QVFh1M1ZU?=
 =?utf-8?B?YXhjQXhhOTVFeUF4KzRoR2lNb21XNy9hUHY1R2phcW1MMFdqSHRUVktyZ3hB?=
 =?utf-8?B?Y3VEbU9QMHJETjdmWTNQanpnRWVKMjJ6Sm8wYzRKbTJQSlp5SDBQcHZ5V0dh?=
 =?utf-8?B?dGVrK3JGNzIzZFp5Lzc1ZDdLWjY1bExISEtsVnBGdmMzMG1wVFpGdXN3a3JI?=
 =?utf-8?B?dEZuVjdCWkpSQkpNSEwwUjNrZS9GQS9YYlNDR1VLdU82SVVsRm13ekRYZlB0?=
 =?utf-8?B?eXNNVUdlbjZqOGJMdFFjbTlCbjhrTHE3MUZXTkgvN1pOKzIxaHRYcW8zanNu?=
 =?utf-8?B?eGVCRGhoelhuMW5Hd0I5MUZkYnB6OFY3OTA2S24wSkc4U2dyUGorcjhOWlM2?=
 =?utf-8?B?TnFSUE9tZmZUQmZHM1JxYWh4cHp6QXRBcjgwbE0wdHVSY3ZzemJvK1ZWcFor?=
 =?utf-8?B?MXJxRmY2SmtxZnRZeUVrUkI0WUppbUowcUcveitKOGdkNEFRM0xUdmtJNFpU?=
 =?utf-8?B?SHBjZzlMSWY2V3kybUw1QVN4NUMzZGt0eGlLTFQrQ0x4OVBNaHRWVDZTTzdE?=
 =?utf-8?B?VDl2WWE2U01QcVNjblQ2M1d3QVg2YVBBSzdxblI5dWJGN1J1eUFkbmx3VkIx?=
 =?utf-8?B?dWp3VDFYT3NRTE1jeEdxWWkybGR2eHhXRjhHN25oZFkrbWVVMklsOHpsUU8y?=
 =?utf-8?B?MGxwb0FmbEpoM0JDb2dwRTl6YWpqa0Z3TXlXbmZFL1hKWE9zYTdEZ1pIMlNl?=
 =?utf-8?B?SG0yamZtc0JzRUYxU25RUExqVWZDcUkxZWFHd0w4Q20xVEFldlUrUnB5dWR4?=
 =?utf-8?B?OWIxRFkzMFV5bnIvQzdNK1VCYnovZWN6VDgxd1FaQTd6WDVEeWJBNjAvb1E4?=
 =?utf-8?B?SnczWEQ1VjhtSmNmTGdKMmp6QXBPTWFoQkhtNGRycUxXRm9hL2tXbjJacU1m?=
 =?utf-8?B?N3NCbWdFVmZVaDA5cFJ2Q0FEdVNGRmkwKzdOSkJ5MDFOQjV4UGgreTB1dzFU?=
 =?utf-8?B?SE1vZ1c0VUtBMC96OWVJYUd6VTFNc3VlVFBiWVRORmZDSlFUc0M1WktueGVl?=
 =?utf-8?B?dEZsYmFtU3hiRjZFWHJ1aENwRzZPSmE1MzVjOFlFNGxPSlRGckNnSiswRVBq?=
 =?utf-8?B?QVRoUnd5Y2JsSkxkSlZHcWtmZFFzYXRhckFMZ29iNG0yYm1NdjhseEJ3RnRk?=
 =?utf-8?B?SWxMZkR3T1gvakozM0taYWFWTC9zVDFKVzJGMFVVejJwNmxCUFZyeXVJMWth?=
 =?utf-8?B?VjhqUXJGaWdJeVhvWlBxa3hHN3hYbzVSa204M29rMkNkdGJ3SjIwaXNpYTc1?=
 =?utf-8?B?bHl2ejJIYmxZOS9sUENHb0dzUmFhRG0ya0pOM05VMlA0Q1hadVd6ZURPSkl5?=
 =?utf-8?B?UHZPWFczVTFNM3ZOZzBFaldKeFlJc0svSy82Nlh2VmR1bzcrV0N6Uitub1oz?=
 =?utf-8?B?VG5FdGZvTjhuQklvOGdqQ0h5R3ZtVkRjaDEvL3JpOWhjRkU2bFh2MEpUbmxl?=
 =?utf-8?Q?6c4JyLDxdMtZd++6u8+XTvHIM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4901cf2-2b84-40e6-46ff-08dc639f4536
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:11:29.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIJ83LzVHxnsxlej3LXAsR8qoD4H6vMExz7hPeDPneX9XLQ8BcKq5sN09D20Urr7LxNHsIDGoZ6qyv4jAurrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

Add audio nodes for imx8dxl-evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 229 ++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..ad1479c91e558 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -125,6 +125,76 @@ mii_select: regulator-4 {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	bt_sco_codec: audio-codec-bt {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-wm8960-1 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960_1>;
+		audio-asrc = <&asrc0>;
+		audio-routing = "Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-2 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-2";
+		audio-cpu = <&sai2>;
+		audio-codec = <&wm8960_2>;
+		audio-routing = "Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-3 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-3";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8960_3>;
+		audio-routing = "Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
 };
 
 &adc0 {
@@ -132,6 +202,11 @@ &adc0 {
 	status = "okay";
 };
 
+&asrc0 {
+	fsl,asrc-rate = <48000>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -259,6 +334,78 @@ max7322: gpio@68 {
 			};
 		};
 
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			wm8960_1: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			wm8960_2: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			wm8960_3: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
 		i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -362,6 +509,53 @@ &lsio_gpio5 {
 	status = "okay";
 };
 
+&sai0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai2 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai2_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai3 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai3_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &thermal_zones {
 	pmic-thermal {
 		polling-delay-passive = <250>;
@@ -595,6 +789,41 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
+			IMX8DXL_SPI0_CS1_ADMA_SAI0_RXC		0x06000040
+			IMX8DXL_SPI0_SCK_ADMA_SAI0_TXC		0x06000060
+			IMX8DXL_SPI0_SDI_ADMA_SAI0_TXD		0x06000060
+			IMX8DXL_SPI0_SDO_ADMA_SAI0_TXFS		0x06000040
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN0_RX_ADMA_SAI1_TXC	0x06000040
+			IMX8DXL_FLEXCAN0_TX_ADMA_SAI1_TXFS	0x06000040
+			IMX8DXL_FLEXCAN1_RX_ADMA_SAI1_TXD	0x06000060
+			IMX8DXL_FLEXCAN1_TX_ADMA_SAI1_RXD	0x06000060
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_OUT3_ADMA_SAI2_RXC	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN0_ADMA_SAI2_RXFS	0x06000040
+			IMX8DXL_SNVS_TAMPER_OUT4_ADMA_SAI2_RXD	0x06000060
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_IN1_ADMA_SAI3_RXC	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN3_ADMA_SAI3_RXFS	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN2_ADMA_SAI3_RXD	0x06000060
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041

-- 
2.34.1


