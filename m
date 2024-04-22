Return-Path: <linux-kernel+bounces-153942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD448AD52E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5510D1F21532
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086D15534E;
	Mon, 22 Apr 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UOqkG/Oc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CA15538F;
	Mon, 22 Apr 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815425; cv=fail; b=Z52e8XYaZq8KWN1Y4wiKdEDZRW7Ck4K6bqa8Qv8LWLRN2urrk8nsSKU/bm5FUXbuTpTzKSAB5FRnr20G1Yaw9i+NOHEjKiLslJQSdUUDxDe8mjdLJel9PJHFySTa7CrlxmPnbLHKoQIA03FJNwxMrIZK/2A+FcKgSG53OJu2seU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815425; c=relaxed/simple;
	bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X1s0SJxcvMwvmVAJD84+pKZbobUbPfj7NVGBTV/pNOIljDMnGI14VY+MvkZwlBUqwGuMNwvLwI+s5lNsaj760PZdK+IKwJnl5+jBAE8BiZKFTuoH0wbEiDmG7OdL+eNizxJoGFZSTwGOJ4fEHe7yXJBdcuX7h6oXgUbKEEIYQX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UOqkG/Oc; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXSMmDdP3gd0Gr50Z55gWgOHgxm34eUN3OLEb0sGqrOiqAcFO0ldDRYKMb8DC7p7BZtK/bAIJP6bN4J65dGzgs+T0D+Khl6U6HmNlLbjflOr1j4dRSwrtPg2IAllzbq+S9QeEHiZukfM+K49gSFX1y/T2sVK6x5QVC1EEO8iex+rKF/QqvxsdKytYlWkx3yUir9QkTZChVYjMsdSEvvjgdik+rhQp1D8yHRJ1VjN9wdW3m7o+po31sYThoDhyMMtjx2LTpGkPax532e1sTL3MBYmgtWYxQDgGn3hZxK6BpphbveZpZzmasEOFStpYCngWxxBICjBjtmD9R7v+WBXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=C1rqm/gPS6R1fz6f8SpmwCj30tDzrEsOArhE8Odjy3cQ53PFuYjPbU9tMCBFhxmhJmt50nduC/6Vd/fvubiuxlhYzQhEAlqiMIWxsL5hOejB7yl2mVYhczj43nBnLlmX0rRpIdJl33CG23PdGT7K/Q0S4i1iwtLet450ka5rbT6LVovUqRzONvGlLsaH6wFIBnExm1ObvMMKOaGTGjmxfSdmoIp/OoiNIxI6198KHlDZG2nOmF6hbQnr2mH2tiwy9kpjW8z58iUTPaXguxSxi3Wvv87F/WVc6PcX59IKI+OFfnWWsIQoPXDrdi3acRrymtpCpTMVd/wbbmacKsDPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=UOqkG/OcsYCkmKJ+u81JZejvxVonnp63Gh0+RPWdZ0sy7t7OgIQ/hv040JtsbBA279i/ilySxadVexNXuctG/e8F44s/4xN8QPZuz9NH3rWGmZ1XV1ogfGJWBz/lH6qGksEvtoGJCJ+LuknyA5IZr8iznGcf1YVfBddBDtuwLp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7195.eurprd04.prod.outlook.com (2603:10a6:10:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:03 -0400
Subject: [PATCH v3 01/10] arm64: dts: imx8-ss-audio: remove memory-region =
 <&dsp_reserved>;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-1-680cee731ced@nxp.com>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
In-Reply-To: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=757;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
 b=F/Kvd5uQ8WbnOTJr7QRnEIEAKYCJxkSoLya9jEo7Kr3dqtFWVe9b7IC3rjXJDxLhMLVOmsrr7
 vnpXCZ3E/YDDFD56Usulz7H1gdttg0xegO0tngwXodcVpQJ8QlfwbJU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: a61ce08b-c69f-4797-98f0-08dc63056f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1J0ejl6QkpVYnVMcGFHb04rV2NyZjhiZWNXVG1xUVlEZ0EzZWsxdzIxdENL?=
 =?utf-8?B?VTJFT00yOU1nQnR1WlhsOEN3bFVoaGVESWJEdFNYTElwVnhHQU55K0pva21v?=
 =?utf-8?B?Q2dGaXdMN0I0THRMOFpiUDV2dDcrUGhhWThickZLWFRzcWExT2lERHd5aTdB?=
 =?utf-8?B?Q0dsYUI0dDJOSmFIQzJUcEdrb0QvRWdoZTRDMXdRb2hBUVZFOWdua013OHFP?=
 =?utf-8?B?YUxQb082bkhQTXhaZURwOEk1WDFYeXNoaWFDS3RJU0VobkNDN1VnbXB2Witt?=
 =?utf-8?B?TGkrZ3VmcnZjeG02TkVNcVNXeUNKOTlWT0JhUU1yeFNqZTV6TGlqOFI4QmVw?=
 =?utf-8?B?di90TzNYRWdmT25pRjBwWitPVWdDMTZrdnZ4aUFLbkNYTmZib2pMWmdONFV0?=
 =?utf-8?B?NXVXRER2T2VsSHYwUzc3MTNyRzA0VkhHa2xNNUczcy9FeFpJNTJaREgzQWZF?=
 =?utf-8?B?WHlqVmh3Tms0WUxCcUNUZm9kQm52Q3JZWGRuSndhSkdHc3p4bUszVVoyUkFE?=
 =?utf-8?B?N2NjcThQeDNwRDF4Ukl5OTNOczZ4djlSbjIydE5oWGl6bFJJOUQ0YTNHazJG?=
 =?utf-8?B?K1VSc2wzcUwyYU1iRHNOOWVsdWlRUVBPc2gwdDBKT2J2Mi9DaEpRTlhSMEFW?=
 =?utf-8?B?S2ZjVFVwSnJiWitva1dUTmYweldTaFJnWnE2d2svYW1lUm9xaXZQYmxPRDhm?=
 =?utf-8?B?VzlQVHVxVXUyNkt5TTZlNnZyWTFiYjJzQVltUEZYY2pGaDJ5VmlJd0hVTXJi?=
 =?utf-8?B?VlV3bzFMa1I2THBiaFo2dVFyQXRSb3g5U0NRVlkzaHVlcXVnT0VLNE4vTlZv?=
 =?utf-8?B?NldPb1FlbTBhenhmZWwxM2J6L2daM0Z3SVBMaWFPL291U2Q5U1h5cFRHbUxv?=
 =?utf-8?B?ODVtTnVnSDdCY0o3RmtWVnd3d2xlZ1M3NzBYRE1COGRyRVlLem14U2h6UzFC?=
 =?utf-8?B?M0VIN1k1WFNlNmJYUnRhYkJud3p0SEhpaGNaRWtsR2l2R0NFMHViK0NheFZH?=
 =?utf-8?B?RUxhWFg4K1BlS1hBOTR3S2FVVjFJOG02RHo0anIxeG9iek9tU2llVHpxVXRW?=
 =?utf-8?B?Q0lBbVlWVEpTbzRjRmJNaFUzUzBrMjRxazl1SVBmekllY056Q29VdTVGWklw?=
 =?utf-8?B?QlhjTzBtNzhsQ3I0dE81MjlINGJXZ2ltNUdHQXY2TlpLalc1TUhwQ01EZGJa?=
 =?utf-8?B?b0haSzdXS0g2b1V5b2xrUEFZRkg2dUdvbGk2U1ZlbTlEZzllN2ZqUmdHWWh6?=
 =?utf-8?B?dnU1bC9SaTNlbVlsM25BZ3R3VGxrcWdseUhBRFVVaE5rQVErbVRZVTlObkVB?=
 =?utf-8?B?Y1FJYk5JKzJjdTFndVJmbDFJRjdxOFNhSEk3azloK2V5N2FkR3BOclJuM21q?=
 =?utf-8?B?ek9QN1p2elUzaDVMQkhJbUoyMHN4Y1hjbEhoNG9KK0VsOERsYlZ3OXJmSjV2?=
 =?utf-8?B?ZDdFOEo0YWNFamVoY2tXazd1Q2JtZzVqcHdWd2s2Q283ZUJqZHp5L1J0cGZS?=
 =?utf-8?B?eG5LOHpmYW1vc29kUlZtTVpGUDFMR0MwRTg2bE5aS2lNZmVwSGM2a05mVFUw?=
 =?utf-8?B?THVSQlBQaFZWamE4SVZ1R21yVnRKNHJLeFhWZlNDY0xYUmd6QWdzblpUK1dx?=
 =?utf-8?B?amtJQmExV0tNZXRwN3FRVzFSS0RLdkRmYlM3b0czQkp3eHJoSzNLTC84Nlha?=
 =?utf-8?B?RzdRNC9RYTBIS3JKOGRkYkJ5cW9OTzFaM2JFVURyeVFNMTcrSVFZakw1ZGtz?=
 =?utf-8?B?MURhWFBXd0F6L25UVlQ5ZTEzYm5QOStzb0RmMjE2MXo3NFFwM0VPZ2N2Wkhj?=
 =?utf-8?B?WERObllUbUR5MVBpR25yQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2VlY3VBUUdSSWZHZnNmWm1QUXRlYUpNSEg0MElST3JoUFdOV3RaT2ZoMjVk?=
 =?utf-8?B?ajJ4bXlBajdzczc5VkhxejgvUUF3dWFlZ3VuV3NRMFQ4NW9RWnN0NVRqbUFk?=
 =?utf-8?B?WHpzWVkrekNTQ2hzaStjeXNrVVhxK2c2dkRBYm1CL2dwYUV2SjU1NTdxTW5w?=
 =?utf-8?B?ZzQ0SU9jNmZhZkF3b2JCeWdmR0ZVVTVyM2dxT2Z5bmhYaTMxbDllZnkyOGd0?=
 =?utf-8?B?YzQ5eTRXNm4xOHhvdkFDWWpJWm0zSEVJVk12SUdEb0lUYnpMdDJoNGlNdUZV?=
 =?utf-8?B?TFE0aEtFbGJaeWdxV1hnWnpIVXlYdkdSM0JENVd5RE0wZVA3bWF0dUJEay9P?=
 =?utf-8?B?QW1XTzgvemFWMzM2YWpqSC8ySzlsdTFOV3R3bk9qZ2RLRGxsaFhuOEQvNEI3?=
 =?utf-8?B?ZTd0TWUwUG9VYVhMYVNPTWlNNW0ybjN2ZGFpcUoxU0tZakpLSzM5c0o2Rm1D?=
 =?utf-8?B?ZGZIeVUvQkNrNSs2ZUJOeVdJTnJ4VGhuZk81dmxZaWpuMWZtckliV1I3cWE5?=
 =?utf-8?B?QVo3ZGQyRy9aNGVMZkY2NXhpanUvV1JTcGdqQVVrd1VDWUc0RnIyZVNzNmtW?=
 =?utf-8?B?d3I5NHZzd2ZOK3hjTk9sbHM2RFpFQVVkYk9ESDE5QjFvZHRUa2tVVTBuWUFy?=
 =?utf-8?B?eXM0WGlmbVpjNy9ZNXdnQU1aMTM5WWJBZ1pqYVZDSWRFWDkrUnFsUVdUMmQ1?=
 =?utf-8?B?ekpZWWl0RmRvaERhVDQxVVpPK2tldTdxalRrOWxWZ0pCODFmT2E5Z0VsUW9H?=
 =?utf-8?B?SVA5YW4rR3FidVVXOVc4MGtNbXFobTk0RkNsWEFVK0k2SGFtM1BuSTZ5SDRl?=
 =?utf-8?B?cnNxa3RHeDZFNVVOY1J0OS81SjhlZ3Uzci9BVy9MamgwL1VIZ09vY2JrTjg0?=
 =?utf-8?B?N2ZjK0pmaFBYcnlianNVWDhzVTlLa3dISlZpQ2w4RVlaRXNDYnY1UEcvMEJq?=
 =?utf-8?B?TnFCVmV1K0N6Rk45TThTV0IwNm1ieXRKazlQRm15dXhNMGI5SERVeFVoWUxn?=
 =?utf-8?B?SUhnN3RYUVFocEdGc0RyUjBhZUhRUVVVaHp2UzFzTjNWME1tanhGMGUyYTFX?=
 =?utf-8?B?ZERxdUI3a1l0Sk5iSmtJWFpyS1hmelJ6TVF5QnVvZGRIMFZBL3ZyczlpRDJM?=
 =?utf-8?B?M1Y5R2xOR21qbHJKNUkyUUROZTNEUG5CeGViYW1yVFowRHN1Yjkzc3h4THJ1?=
 =?utf-8?B?YnpKR0JhTlY3KzZwYTRuVVVxOFFJUFBjMm9UWU9od1hJMTcrUndMaWlaUTNU?=
 =?utf-8?B?QWlFalJ3bWx6UUdKQ3RBa1A1OTNYV3pJZ3p1elRYaXdtUjFBQjhHMm5LcThE?=
 =?utf-8?B?YktObWNPZ1NVcWc5N1lRY0xhdTFDaDNGcmJVcjhaSkp2TWRRWEJoZW5sUi9h?=
 =?utf-8?B?YVlVNXZmTlNWRFNwM0tBSGtMQ3E0M2tET09laTVJSjFNSEQvRFhaTkprTW9j?=
 =?utf-8?B?RTE3VFlCenVxeFdpWjZyeGFkYjVQa0JPWFFkSFdMZllia2FjUko3R0xPODJL?=
 =?utf-8?B?aUFBOElZQ0hpeUlvSmVvQ0lTbi85cFJ1VUM0SkNQbDg4czErWlVhc0JvWG9j?=
 =?utf-8?B?bUI4ZWNuTmV2Z0F1Y01mT3RmZHFVTmdjYU5FNjNtR0ZSUXI3Z3o1M3RBRkF0?=
 =?utf-8?B?OTJaY1BRTHRYdWdINlhQRjMwM2tJM3BvWEl2cDZDRDV4NXZsM0ZKTW1OMlY1?=
 =?utf-8?B?eUtmVUVDaUJySGtvV205bWtFL2g1Uk44blpXQUZqTitlR1ZwV3RMM0lSK0cy?=
 =?utf-8?B?cU96b3JiN2c3SzZ5WGlWUjBNanVMZ0xRUEQzVUpSc2Q5bmVRekZTNDBWa2Vv?=
 =?utf-8?B?bjh5eEdJdWVTa0ZEUzlmcWtqZHNFVC85blExTnU5WDNvbHZURUt3Tk5UR1Bs?=
 =?utf-8?B?WTR6MUo0UHZYUjByZmREaDBveDE4Z3RmRlNqR3hYTC9paUZMekJ5bVpVVU1B?=
 =?utf-8?B?R2IwcWRxbUpuaDBzNUt5YmlyazFkUWxpejh1c0NjajVxeXV0OGJxcDBmY2pv?=
 =?utf-8?B?eUVFdXByTFJ1SExUWEFpK0h0cFZtNW42ZmQ5SDJ0aG1DbkxmNEx4MVBrV0d6?=
 =?utf-8?B?L2tjVFNoNWwyTE9zWG50czhRUXcxQWcwVGNIeVc3emxIeVRnMkxTMGV4RFZQ?=
 =?utf-8?Q?Q+LLjM24dx7ZlOb4Oigpgae3f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61ce08b-c69f-4797-98f0-08dc63056f6a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:17.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CBov/0hZXEcN3rvJkbh0vkBNwxiSdLk2cetm/OkCoMu3cN1LLZqaNRS2JECO/xRmQRQsZ/NTiZ6yZ809w8etQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7195

Different boards have different DDR memory sizes and layouts for reserved
memory. This change reduces future dependencies to add 'imx8qm-ss-audio'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 897cbb7b67422..ff5df0fed9e96 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -447,7 +447,6 @@ dsp: dsp@596e8000 {
 			<&lsio_mu13 2 1>,
 			<&lsio_mu13 3 0>,
 			<&lsio_mu13 3 1>;
-		memory-region = <&dsp_reserved>;
 		status = "disabled";
 	};
 

-- 
2.34.1


