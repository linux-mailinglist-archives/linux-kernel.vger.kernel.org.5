Return-Path: <linux-kernel+bounces-103292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652DC87BD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B39B21B88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADE5C902;
	Thu, 14 Mar 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZZpt6qO8"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E095A0F2;
	Thu, 14 Mar 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422837; cv=fail; b=eyM4GabdAGU0FCq9Xh/AN2wjiBSwFUM6ipyzkbF8PWzmM91Np8I7VxnktUYXGqnjTAQ3HniDvA5XUlxuWuQz5+XUStVXpsXkUUC6AgfObW662w+UruEA5r7c2H64Zp0Wccynbaj8lef0v+IsycOGw1/JNiZiqRVbkVFl9YHljJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422837; c=relaxed/simple;
	bh=A/vV9XB2JUtLJqTLJNhaiSjKVkO0rmenzpna115ouNs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ZI5IDPOf/v1KqT9+WT43elRzdCcFgi2DdaTerY/cSrD52a+sxoKIG6jMf31SQup88GkXR0z/AFTJZOxybuvQf4WBys3p2QF2W5G7VcfHK5UKqr935XaasOlZ+cw444iW+C2WUT8UKOLqYHxVg0wiKf7LQmiMp4QKkybNcFKPeZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZZpt6qO8; arc=fail smtp.client-ip=40.107.8.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBQ2lmNsDwbvumpImy+Fl0fKQhx0NXfym1xmagTlRAoWl3+L+tzEzX8SNYwmF6BXBISIKYT2DFrC0nwQfnqMQ4hWW7bw3BQM6JzXYAaa4Cj7lmovpKtO4UDOt454ePmARG/D0JiMVTtBfZz17jDuPeRF41fFHiu8xqSB3gzqDfzVfUQBqfqKp+DTtJluepGnPWs2uZbFpAf0gzG7dKWat3fevXdrcDnwczuJ+dHsjvBwNhzApnDmu6TLjf2MXl/E5Qzwfv0lz51BKL5tY9A6WDZQOVT8whpjPn2FEEMIEEgo/k5eHSxtxC8hj90Jo1WT0sPIl7r8pLh44xSVdBT/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FX2MibGCRF/71H/VBtycPluwCT1okXhXi1YQAn6iAg=;
 b=WK7plaZITwN7lgP7oJOE2G8dd+2fJH8PThlHoFTOL2GvbtQZj4G7H+NNJ7vBFu3nzgK1MmHPw+QkJCAFCu2oeM9MNPT761DT7CKeNBPbjml6/Cs7odwbdSdHxmNXondCxIWWo+r+qvRMN3c0McV/rWePO63S7PPmSjszfNS2DUCR9w/3z/xX2RdHg82TMyo1cKZKIdmU6f+/9zLJOzPgzPR8NAWoblVg0/sZmUuKjcDOGK9E+UyfsLcNnZMrSCis4NfnTdno2zWBQ+HpG7fa0xSkjTxHG+WY8HoD1yZIBvEkRhJCVUcpsEILr1/cz/kWEvGUxtPeffI8ZLzQV1OmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FX2MibGCRF/71H/VBtycPluwCT1okXhXi1YQAn6iAg=;
 b=ZZpt6qO8zaRCslL6/B3W15g8KAh5isEQ/nb+niwcRSrLEyO0SKF+h/p7gji6Trhs6WHRCqt6zr+b0PbniUngWKBCLLrb8dBxDWXyeLY2uu+swzlF4U+HV5ZL5N5NQw3RdMNPkLY8tR71vQxsrffTrmZPaTktg/MGTcbh6MeB/ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 13:27:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:27:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Thu, 14 Mar 2024 21:35:17 +0800
Message-Id: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABX98mUC/3XNTQrCMBCG4atI1kYyk0nTuvIe4iJNUxuwPySlV
 ErvbhRELbj8Bp53FhZd8C6y425hwU0++r5LQ+13zDamuzruq7QZCpSAoPjgOzuGG4+29ZysKoX
 UVJPNWCJDcLWfX7nzJe3Gx7EP91d9guf1T2gCLrionVSOMoBan7p5ONi+Zc/MhG9KAgRtKCZqi
 rLKM1Mqk9MvlV8UYUNlonlVUGl0UVmT/1L6UES5oZQoCJc+Sl2g/vq6rusDKg1Jr1cBAAA=
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710423327; l=5319;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=A/vV9XB2JUtLJqTLJNhaiSjKVkO0rmenzpna115ouNs=;
 b=did1Aysv5mv8ymob3Kf9qljnIFZWCcWnaE3V8F9+8fG//s5jFmCjf24WNsGeLiE7b7G6cRRKp
 xESVhpPkEj5BFO5Edc+4VMbzPwQzlX5eYIXG/F9fdDwiCxfkys3/qSu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b86dd8-7f61-4eee-a708-08dc442a72b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mG8fnu9FADS9j3ZecxdEXgTThH5v0SXrEDT3kGGPKoJoJr1fDbI0Yha+MgQAW94a28nhrgYTcfngv/z2lm4s6A1xSz0cP+DtkGpIXzRGTFbFCyWaN0gB0YxklJbKQtLojNi0XgdabB5CoM7O/m93zVPXN5Dno23ElR8P3NhCZLYaq2B5RLxeWsMnyyPXJtVkueohN630ArVUjGWx3y4iFivfxZtfEgbCLEC9wgfQcNO61/0FWfU2Rgiz4vM4mC13/Pgp1XaUDIlg2hDUW7LR6JuHWw6qbUPFmzz9ZzKip5hNuKqMSnbZYc76WJTQl7ZaGjSW0Ow9LHAjsY6PyXayu6aQK4NcPgaRKSUiUDDLnhrp3x4FZTZa2cGdt4G2MFi7RKuOy2Juw1I/RE4e7Tn/ayPQQCRp07Meit9EN/LiiOVmrJAqzHKWUAYNOO1+FFSb1+qRnnwoDvfzkj5NaOH2fqju8269QCmHumPbvo9WUJPg6c56489haNgxiMf8r2CZQov7wPqlRcrNXUjwTZVQP+hMK0SLnLcBR6PYx4QJNNhFrrIFhnRtpgLG4vGlUTLkcxHWveBlQee/8q4BjnQGfr1AevkGcLdYzW65TmzSEwIGZkcoyjYGl+NrXy//uF1ayTQsGB2c0Rao5EbKl8Ukc1snqp81jKabwvlkNzbvCr+Bt4xfgL0CMI6eeOeYCjpf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUZNVkNNM0dpaG01WnJTWHRlSVVLenkxMndLVW1zRFI4WVhEK1J5aEtMZmpq?=
 =?utf-8?B?WHhUVVBpZk53cXRYWE1lZFJiZ2RSNWhUNmkyUlNEVHlvU1hJVzZxZ0NyNXo4?=
 =?utf-8?B?V3dCNWFCZ1dXRUFVS1B4K0FaaGVPK0dqQTlwcVdCNkplMmozKzkxMTNRbmN6?=
 =?utf-8?B?UUtzTm5XQWs3WHFGNXJ0QmtZNGFMWXBRM1RCNlI2SXh3M3lHdmVubTdTQmxL?=
 =?utf-8?B?SzRwemNvOHMvYldqelBuQ0JWVDdPZFJiOG5PYkhRaGV2UzBmZnErOVMrWlVG?=
 =?utf-8?B?RFNqcTVYZHVwdHJHc3YvR25iejZMajNRSW02bjd1WWFrYVJnbkhzdTVhQTdy?=
 =?utf-8?B?OTNzdGVCVEZET1ppZE1KNlVYWVNaS1lpSjRzd0R2NlBYTW5QK1NEZXpONk10?=
 =?utf-8?B?eUpMSGN1Sk16bjF4S1FiYmhlbCtTOWVjOXpyWS93MFU5QWRtV2xLbVdMa05T?=
 =?utf-8?B?N05xSXAwaDZkSUREcWhWSnhnN2w0d0NuMXBwZkZjUHEwWVV0NUZOSUk5Y3cr?=
 =?utf-8?B?QUZQNnlHMWpWS0pVMnNYWnRYVE5xcjBMZW9lU0dLOEZQd1ZVU1NOMWxLTnNS?=
 =?utf-8?B?eU5wK3g1Q3dJbVI0VG96WkxTbjdmcjRRZVlJRmlXM0xsclJDYUhKWGhnbVFF?=
 =?utf-8?B?Sm5aeldRWnJMNS85eXhJTkd0RE9rVU96WjJOaVZDQSt1L3hudTIzb05Tall1?=
 =?utf-8?B?MUY3UThCSTRKZWlrWC80enJJdGlpeUFTVy90T2h0SGhUanAzVm9ZeWhNUWJ1?=
 =?utf-8?B?RTNrcm5vcWxvN3k3NHlrNVIrTDUvWTZhaGRqQUJndzB6Q1JLUzk5dmdHMXhL?=
 =?utf-8?B?d1BjbGtUYk9GYlFJQWV6Qk9Vb3k1UEU4YzVuLzhubk1kMXU2NXQzOE1pOEJj?=
 =?utf-8?B?N3h0YUtacXYzdkdMSmtidlVtemtQcjZaN1c1cVBzb1MxcHFSbGdlVTZ4SGow?=
 =?utf-8?B?RUY3dnN6TFZOVzcxd1hwQWE4M3pjdEs3TVVzR0tiWEpuS2hna1psekFiRUta?=
 =?utf-8?B?OFFjV0k4V01aSTJ3eGtCRElXaWlFM2JRMWJRdnhrNE1yTnA2WW0ySkg3VUNy?=
 =?utf-8?B?NTJlMlhFYWU5OEJyUFRCVjBTVDNXYTJqdWNXNUlvUnZNQkZCc25vY0dEYUht?=
 =?utf-8?B?aG16UnF0Y1BMQjNnWmZkUGlQQkhibnh1M2twd3lvaGdURFQ2RTBTTWM2cjdD?=
 =?utf-8?B?ZEtJUDh5YkU2UUdySjJpRjVzaXZEK01zT21Xb3o5YlpyVkNvT3RsRjNVM2Zm?=
 =?utf-8?B?ZFJVbnp3YnYwTWtSNjRCU3NSTUxKVjh3S2h5TVZDcWJQNWdVanZVN0ZsdlJE?=
 =?utf-8?B?ejYxcjMwY0FwRjVTNHBlNHl3aDE0RHBaS0Y4cHFuQlBCQnRIT2R2S0ZnRG13?=
 =?utf-8?B?WGVJTnBVUmhFbmVnYlVkeWY3M1VmalJ2MURlZkJlYWdNSER2Y1YzellKMTJi?=
 =?utf-8?B?MW9vV2lsQkg2WC9VZUJyYVpDQU9QVVFwZzRSdTNjMjZXRXVoLzh3cTQ0b3Nz?=
 =?utf-8?B?ZElDTFZjYXQxelBFeURkN3VQMWc0bmJybHBxWkdrdzZEcE44bzZwU1o0NjhK?=
 =?utf-8?B?b2lYeWVKVDRBQVhaWEViN3RXZDNHUHlod0ZVaUtQbW1qWU9ZZDZVTGtVTFVu?=
 =?utf-8?B?TlBIQ0hMVUloOWowMGFHV0piMFB6RWJ0ckNmVXYvU1d3UjBNdERWWDFLc2Nk?=
 =?utf-8?B?RnE1MGU2MCtYeXBOK3BwZWtha3FBSzhUQUtPRU9SMlBvdWlpOWJNWFBIRjJ5?=
 =?utf-8?B?a2JGc0xWcTdxSmdSMXJTajhndmp0L2lDUFpiMG9OaGFLSUl5UURlb0JHcjFE?=
 =?utf-8?B?REVJUnFBaVd4S1RLU29qK09DRnN3dnJhM0g2S2U4VUExaUJDbVlXWVpucjg2?=
 =?utf-8?B?bGtrVFEzOHcvWGlXSnNkazBxaUp5QTZ6UXJ0WEVjcVFNOG00VTVZZzNjWE1z?=
 =?utf-8?B?Rk5naXhubkhZU0dQbHJYM0Vvb0g5cnFJY3E4TDNyVzJXd3BFR1JqUXNneTRh?=
 =?utf-8?B?aUhaeDNtSVV0TnpHaS92Sk9HVDE0ekJDR1M4SFlWUFB2NVg3UjNnODgycmkw?=
 =?utf-8?B?YzVWTVRGYTFNbnF0c1B0QUZaZGZYclk4anZ1cDc5UmRERVUwSmpYeHVTUWhz?=
 =?utf-8?Q?iRmNy11zu94GDWKhPYjIxNYP7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b86dd8-7f61-4eee-a708-08dc442a72b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:27:08.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF254hLfFGGokHz92sVtQ+1LJFxpIVuE7y9Q5IBtRNqeNmil/Y8mk9lLDA+fQrNOzDHtLtaUdqbbYkothqnmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861

Since SCMI 3.2 Spec is released, and this patchset has got R-b/T-b,
is it ok to land this patchset?

This patchset is a rework from Oleksii's RFC v5 patchset
https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/

This patchset introduces some changes based on RFC v5:
- introduce helper get_max_msg_size
- support compatible string
- iterate the id_table
- Support multiple configs in one command
- Added i.MX support
- Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  is almost same as RFCv5 expect multiple configs support.
- Patch 4 the dt-bindings includes compatible string to support i.MX
- Rebased on 2023-12-15 linux-next/master

If any comments from RFC v5 are missed, I am sorry in advance.

This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.

On ARM-based systems, a separate Cortex-M based System Control Processor
(SCP) provides control on pins, as well as with power, clocks, reset
controllers. So implement the driver to support such cases.

The i.MX95 Example as below:

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	sram0: sram@445b1000 {
		compatible = "mmio-sram";
		reg = <0x0 0x445b1000 0x0 0x400>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x445b1000 0x400>;

		scmi_buf0: scmi-sram-section@0 {
			compatible = "arm,scmi-shmem";
			reg = <0x0 0x80>;
		};

		scmi_buf1: scmi-sram-section@80 {
			compatible = "arm,scmi-shmem";
			reg = <0x80 0x80>;
		};
	};

	firmware {
		scmi {
			compatible = "arm,scmi";
			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
			shmem = <&scmi_buf0>, <&scmi_buf1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_iomuxc: protocol@19 {
				compatible = "fsl,imx95-scmi-pinctrl";
				reg = <0x19>;
			};
		};
	};
};

&scmi_iomuxc {
	pinctrl_tpm3: tpm3grp {
		fsl,pins = <
			IMX95_PAD_GPIO_IO12__TPM3_CH2		0x51e
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v5:
- Rebased to linux-next next-20240313
- Link to v4: https://lore.kernel.org/r/20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com

Changes in v4:
- Rebased to next-20240222
- Drop pinctrl-scmi-imx and compatible patches in V3
- Add T-b and R-b collected from v3
- Link to v3: https://lore.kernel.org/r/20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com

Changes in v3:
- Add R-b for dt-binding patch
- Use 80 chars per line to align with other scmi drivers
- Add pinctrl_scmi_alloc_configs pinctrl_scmi_free_configs to replace
  driver global config_value and config_type array to avoid in parrell
  access issue. When num_configs is larger than 4, use alloc, else use
  stack.
- Drop the separate MAITAINERS entry for firmware scmi pinctrl
- Use enum type, not u8 when referring the scmi or generic pin conf type
- Drop scmi_pinctrl_config_get_all which is not used at all for now.
- Update copyright year to 2024
- Move the enum scmi_pinctrl_conf_type above pinctrl_proto_ops for consistency
- Link to v2: https://lore.kernel.org/r/20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com

Changes in v2:
 Added comments, and added R-b for Patch 1
 Moved the compatile string and i.MX patch to the end, marked NOT APPLY
 Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
 Addressed the binding doc issue, dropped i.MX content.
 For the firmware pinctrl scmi driver, addressed the comments from Cristian
 For the pinctrl scmi driver, addressed comments from Cristian

 For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
 string. Maybe the firmware public an protocol attribute to indicate it is
 VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
 current pinctrl-scmi.c not able to support OEM config, should we extend
 it with some method? Anyway if patch 1-4 is good enough, they could
 be picked up first.

 Since I am only able to test the patch on i.MX95 which not support
 geneirc pinconf, only OEM configs are tested in my side.

---
Oleksii Moisieiev (1):
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support

Peng Fan (3):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      pinctrl: Implementation of the generic scmi-pinctrl driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/driver.c                 |  17 +
 drivers/firmware/arm_scmi/pinctrl.c                | 908 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 593 ++++++++++++++
 include/linux/scmi_protocol.h                      |  75 ++
 10 files changed, 1660 insertions(+)
---
base-commit: 6bb954de844bc99bf9e90f304a41d9477efe468b
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


