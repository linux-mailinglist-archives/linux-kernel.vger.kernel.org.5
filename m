Return-Path: <linux-kernel+bounces-159132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12EB8B29C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440F11F21A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1254915746D;
	Thu, 25 Apr 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="odNTGlF1"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B9153821;
	Thu, 25 Apr 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076735; cv=fail; b=JIiy9Y9RodcPNmnQez5aQxouHndXkMt/DkJ5ICGpwazeFrw0DGdyiNMnQ+mYwHM5hZLCeHHz7GZqgQjcDs9ZcYL5TmQpdLXb8xFSzkRMYoDDrfda5+gfDR/PmKqLDxFOKF08peJbqEhIkWwpIZLAn+6iJiyXbWAgeNg4n162UDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076735; c=relaxed/simple;
	bh=bpHf2PIHbiGpZGSQKar1LrDw/OTVWqe+dAjENJs3/E4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b0js+A/ga2LaqbAKaOSfHR4ibP4AkZ3qjNHxrGH536sT3uJdGDBbOHG5DJ6pN9f0jQfBxVEyKWefcvE+yU7ASJN5hY+iJGT3J8w3DY+z+Ow94h/t2m57s/uWAPO5xktbLrPgVYhK+0DFa8l+q1MnU/mEdL42AFyhGy72i3jF8h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=odNTGlF1; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQxWu/mzDiqdV3rCRbM/veNFZt6cCPkffBXE/QMHBB/nBIwbtQQ1yYuF6RQpACqNJ+OTZKmWdZBMzlyMkAlaTUl5huQnDZ2U2AsIUEuQbl6yRl31UKy8TzZS20ZshLYVYobUWfmt5uBP49YIxcMgW1LbPM4CysApva0nUDMhvg+ZsWSkaTbA6rurmLY3cBbTar9+2KkM0kBcMyekD4q/Co6OUPzZLktPgr33+qohYjRpv8NjPBjdmbl17zk96PP4QM3ayXgPRL7+vuViLKK7lnA55akOUsvfxp4wst8oTf+37fy5EEYz/lbthyFhulEF32XWZhTDaLfpyARIxX+kDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyWjNgSjS+K+ww1SAEgZJtTZlCdElVEcZHiMH8mSt28=;
 b=XQf/sXZWflAOMsC+7QQ8Ptt5hRX+yZJKKdlTlouFLDqTYdOFhe0++pO1ISTEak82Vc+N7UmUHcKSg6wwGkFdGOi9jMjkcVWtXYfZJMyBdGFZTpBzNqFElKCjNy+DMqngvYwmX8S5/ShNWE0SNXXPWNwODtLS4T63CEA20HJiO5Zdcy3djRYrHHGI1TXEiXseg1rG4cqTSDNTKtd8rsu8dm7sB8YEPEXec4E4ldL+HeRCHfilLe9LyuaGTPUxIW5H7d4QlT9Wp+Trzfmvfei98SVH5otGAfsbCqICGc31AS5ZPltAbQiwYaDGspqOZkZilyJMPcEkU2gvjv2pvRfXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyWjNgSjS+K+ww1SAEgZJtTZlCdElVEcZHiMH8mSt28=;
 b=odNTGlF1h0lc4kUBa/BsTBStJrdSLcz4z5I6JVlO9LQEBLIAw+JfBMlNxbAWFCtdAfgv1Qj/y/N2p6swb8J/BbDaD8V7UNYRrxFJ1XSIxYiWbPb2nnTJ2HDrpN6gar1trWISoLXdyW0EOZT33yMGiNcyIF13XE1tf0QZfH0oETM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:25:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:25:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:44 -0400
Subject: [PATCH v4 08/10] arm64: dts: imx8qm-mek: add lsio mu5 and mu6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-8-7fa6ab2fd64e@nxp.com>
References: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
In-Reply-To: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=655;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bpHf2PIHbiGpZGSQKar1LrDw/OTVWqe+dAjENJs3/E4=;
 b=iKNKPn7WjDeXZvrehlRxgfT1JXioUXrIg1QhMRcR72E7ILDHRCdtni0dfbMIVBNbHk512jz4j
 JrCcC6MddZ5DnY8aYX2BMWHGNA0jAcwywzaHNzV7nSA5Tp+2mxW8ZGe
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: e940f6a5-48d3-4648-dadf-08dc6565d0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDFoL0tpT2RJRFVlVDl6L1NvelQ1U3R5ZzBUajJTZEwvSUFmRDVKU202VStn?=
 =?utf-8?B?eHJVNzIySXNTRHgrNllERVRsWmZ6aXJiS20zaVdDbGRVOUdLK1pkOEhYd1k0?=
 =?utf-8?B?Qk85QmROemxHUFUvc3NZdUtuUDhDdHdxR2pxTFJONjNLd3V6N1dRcXA1Vit1?=
 =?utf-8?B?SzdQaXNMQlFYQ2tYS2ZaVndVRThFS3BtMzlCK3o1Z3poQ2puTzYzL08raVJY?=
 =?utf-8?B?eTVFeHFLQXdzaE1EeTV6R3BpM0FtT3JQMnlSQWJiVTA2TTJBZk5qNFJGRWZB?=
 =?utf-8?B?ZlpRQmNsVGJ1RmtMa2FWbmhGak5mMmdxOG9SUWlJWWw0NGZ5Zy9MQVZpQjhk?=
 =?utf-8?B?YVpXNEJONHB0UTl0S1JGaHJ6REhnenM1dnF4T2N6QmF6S3lMd1VaR2xTZXJT?=
 =?utf-8?B?RTV1bzRqelZES0w1cmJCVGxjeHY1QWw4L20yV1JNUHlnL3BGZmlCVUF3dUpN?=
 =?utf-8?B?bUtqNytZY0VmSUNvNWlHNDJuTitLdnJPMnY4MTdrQmFZekgrS3Q5MW0va3Nx?=
 =?utf-8?B?YVNKbjNBNnRLdFgrajI3RFBEQVFsMm13bFZ1RlpUSXVZWHFrNFNzYU4rWFZZ?=
 =?utf-8?B?QWZ4UnRra1FVNmw4bEV1cHJMQUhEM29Dajc2YXZpaXFkaCtFWTZsMWJRUzhB?=
 =?utf-8?B?TTFPS1d0ZmpIWEU1a2pERXF2TllQWnJkNStrRHpmNU9na3JkZUFZaU04YTF1?=
 =?utf-8?B?UkdPU1V0ZnJvdi9FbENsVGR6Nkh5VE1ka0JlODRJQlhYWWRxRG8wVGpVMUcz?=
 =?utf-8?B?T2ZqV3FVSTFWcDZVZ3BiUW5CNkRQUkRDQnFVT0drQnZXZjFUSEtpeVYxaHJ4?=
 =?utf-8?B?cGw3c3BMNStLaTNramRYbTQ0a2F0MTcvRzh2NENET0F4K0VYdmNKaDN1T1hF?=
 =?utf-8?B?WExaamxhMDAyQXpOWGlvVFBlMlpwWk0xT2kzaGxnVTRKNFlMQUVjeXU1aVBR?=
 =?utf-8?B?SWVFcUtNQU5MUTZVREt4RnVKdTBxZ1ZiNTJhc1NQTmI4eE5XRFpzaGZjSHFq?=
 =?utf-8?B?L3dxZ0xPVTI3WjdhdEhDNEVEc2tzdmpVZFZReENSTmVmMzV4bmREWTZoMmwz?=
 =?utf-8?B?a1BCRlpwcTUzdURRN29ZY0ZDRnpia3ZEZTZYL29KU0FBMmlQUjA0K0o3UUsw?=
 =?utf-8?B?bmVFcUhqWTQrKy9KREhNU2xsdnk3WDU3amdLdVdEUkpVZTFEa00xS2pJbElK?=
 =?utf-8?B?TmFLY1E3TWJnMnZZUk1pelBwVVE2eUtYNVlkQzZqZXQvSzFmUjRIYkZuaFZj?=
 =?utf-8?B?RWREdHc1Sm1qMnZHSnIxT1I5OEJBaHZ1N25uSnpDNnJCM3pBNTFBVkp2S2p1?=
 =?utf-8?B?YlYxSm4xcHdJLzh6aHh2S0FrYW1rSHF4d3VvUEdhYmp3MnZ2OGszdzY3Qzdq?=
 =?utf-8?B?R3pXb0p1QnBzd2ZTZjlIQzA3NEtVcXZ1SHIyaVYvTmRaVlpXOTlZYWE0YVIv?=
 =?utf-8?B?dFRabmNrbHAzVTgrZ1p4THhVOXROR3JTcXdsU3BHVUtQRHVubmNOSWVTK2Y1?=
 =?utf-8?B?VlBQek95SlMwaXZGbVg3MHVyL21yVVNuUnBDbnBDbWo4UCt0ZVduODNzanU2?=
 =?utf-8?B?bldDRzRzdzRaSVdKRTdmNGRmOXc2Nm9EOU40K2J5QjExSkF2U2gzWEM2d3Ix?=
 =?utf-8?B?VFdkVklVZTBTWm9NMVo5anZVOTFnaFFJL05aTDl6eHpncFZManNrZ2pOT0dV?=
 =?utf-8?B?L2ptZ0plUnBseVNJeU1QTHRNOFM1Mkk5OVlLS2xiY0J0OG5zdm9zakdLQ2Fp?=
 =?utf-8?B?UFVWMklBT1VNMWVhaHp1c0F1ZDBDVHdtclhUcXVOZnNKSzQzb04ySU0wOTRV?=
 =?utf-8?B?SHZ6dy9ERHVBbkVwa3Jkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmhXdzlSQ0Q0Q0RlbXZZckhKQ2ZZT0lPc21KTkREZFZPY0wrWlFGVklGbnBR?=
 =?utf-8?B?ejhobEhnek9RQjdxSG1JMjlVdEwxY2xlcjFXNTVzdUZuRXJMTld2c1A2bnJW?=
 =?utf-8?B?REFkMTdlSGZMRjRTLzdva05Ec0pjTG9NUTIyejRObDlQc2dyckcrRUFnR213?=
 =?utf-8?B?RHFFWEtKcHVaZlFuaVNwakN4U3pMZ1F3NjdBRHNHazhJNkJFYjhWaURIUjl5?=
 =?utf-8?B?bDdFNVVud29SMG5hWStUWS8zK3Z5Mms1M2grRjZqbVFoQ3RpYVU4TE55Qmww?=
 =?utf-8?B?bDQxTDl5ZTNBZVhnNjBhV1RpSmx2QkJhK2ZYSkFIL1dMOS9qdkVOQ2ZQUDIr?=
 =?utf-8?B?SHZjeHBvTnFjeDVJVmhnRWlIZ1NIVGlPTlVBUEZiRFQrTDRDbzU0ZWlmRjdD?=
 =?utf-8?B?dTFWZnpsU1VIckZTVFFGS2VSemFzNlZpMjJxL2RBaUE2ZE1MZTVqQmEwSGtB?=
 =?utf-8?B?dEpaUEUxZExlTmFsckxXNWJYRURNaGNrU01XRlJ5ckxnTnVrUGxGMTg3LzdY?=
 =?utf-8?B?cHlxNHZib3VqTWFXSTAyazFuUk0wRnA3Q0cvUTZVUzM5K0svaW5VNnZqUER6?=
 =?utf-8?B?QXZ6MENhUXVFa2U5dHVmMWZNa05PeU56SFhFZVhMZVIvMm9NcGVSS3V5L3V1?=
 =?utf-8?B?dUsxa2g4dXVRRFNxT25WQ213dVB6RE03VVh4MjZQSzVwb05rSURQc29saU9C?=
 =?utf-8?B?SFZQV05LTWY4R2N3cWlONmdPOFNVQ0pyeTdWM3dGdE10Zmg2TklpdmMydXgv?=
 =?utf-8?B?WTZRbzFQRlM1dklIUkNONHQ0TDN0MVB4YTFtZ2ZWS2pqTW4rcmhBTFhwemgr?=
 =?utf-8?B?OVpMVkwxaUZFZmZQZE93YWk5QjZsbitpUXlqNWtJcys3dkVoNnN4dUx0QjRi?=
 =?utf-8?B?dTJ2UkYvQ3VZNlpYamVibTFleEdscnJHdjFZRlNpcjhBUVBId3dqY0poQUZ6?=
 =?utf-8?B?NVVveW02bDM4RU1aUjEwRjlMcmhjWEhzcTV4ZENjSldvNlJaV1ZhZUVpUTEv?=
 =?utf-8?B?MnNNMDdGUXRpRWdSbFBMZWRrRElVRzNDUE1zNTRMQ0YzbmQ2YVhUbExsODBi?=
 =?utf-8?B?Y2xXSmFWczN4Uk5ib3lBVkZPYU9OVm5kNythUGhwNUpIM3h0TXVKVFIvejB2?=
 =?utf-8?B?OHByM3cwRTZCUmlNbkozcVJQN3lMZmJuUm43Q0FUcjhlQ2RITlE1WEJuTWxx?=
 =?utf-8?B?RGIwNEExVGhoNDhnNWVXMk54RlJvbUdYWndJd0pwem9rVXNvd3o4eFk1Vko5?=
 =?utf-8?B?dEdGbTIvbExLMnN5Q0s5OVB6MHI5QWF4a211RC9hNkRXeUpRcXZhVkYvYVM3?=
 =?utf-8?B?cUhaRVlMLzlBRDBOKzJiaThUQjJia3crdkI3Q2Zkd1ljK1QwN0ZVeW5NY3ZY?=
 =?utf-8?B?S25yUFU0OTRWTFVyOU42bVB2dDBYZ3RRRjVudXBoQ2NJUFNtaUJhYmhlZHZ1?=
 =?utf-8?B?QUJxVmYxMVBPQ0V1K25KV2d1M3JoZ29uWDEzOENETnBLYlFKSVF6ZGxzS3Rl?=
 =?utf-8?B?OWxWMWlKZyszMGtVUlNickYzLzFQRUlLNHBBdk4rQnJOcGMxa1RTMDluWm5w?=
 =?utf-8?B?ajNpSGlJNmFoMTFINmhiY1RTQU9sREF0M1Z4VllRNFpHN0NpZkpLa09DbTIw?=
 =?utf-8?B?NUszb1B3T3cxbXB2alQxKzFKbDU5NHA1aUlQWkdHR0NrK0MzRzkrcHRDTEFm?=
 =?utf-8?B?d2RaTldTWGEwRGVhL2MwRGJIUG1oN3REd2RKbjU0aHlsVFp4MFN0QUx3ZnJu?=
 =?utf-8?B?RGdQbzVXa2R2anBRYnVZcUIxTE9WWEoxUnB3MlBxS2g5Q3FDWVFtdklkNjFE?=
 =?utf-8?B?aU9RMWJPczlWRVJ1L3hJOFRRVXJWeVhpL01NQURMaTZRcUxZcEgvZnB3V1pT?=
 =?utf-8?B?TmwrL0ZnRXNsUVlPUHpyZVB5bmhtbmFhb3dpcVZsUzhjSWJhZGIzTTFaL1pm?=
 =?utf-8?B?NEhvZlNQL05JWGEvcmpPWmgvbGFjWGRlcnhTSk5ndm91d0t5ZmJ2MHR5MDI5?=
 =?utf-8?B?V0I5R0xmcTVFK3oxZlZVdUZPQjZxUEQ1Q0wxRU16V2kwcDRpQmxQeGRMMTFL?=
 =?utf-8?B?WloyTEk0WEdYVVg1RmJUekdiR1lZNVlPcHlMcGxra1Vnd2wwdnVtUG9EaXdY?=
 =?utf-8?Q?4Ov6FUJXNn8jJCHKtjJOv6i3c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e940f6a5-48d3-4648-dadf-08dc6565d0c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:25:14.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCRqujYxti+cy0msuRlNx6nmpT86pIhc/K0pjiOU71afi6SxFsncTye6pcr0Vms7Kkk1X8hIyXSaHtodUW3iYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add lsio mu5 and mu6.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index cb5cfd04b1690..3e57c760e40a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -286,6 +286,14 @@ spidev0: spi@0 {
 	};
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
+&lsio_mu6 {
+	status = "okay";
+};
+
 &flexspi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexspi0>;

-- 
2.34.1


