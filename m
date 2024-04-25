Return-Path: <linux-kernel+bounces-159122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830B8B29B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877011F23E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF1155336;
	Thu, 25 Apr 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fNQeE7OL"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680215350B;
	Thu, 25 Apr 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076696; cv=fail; b=umqQaJ3wGMkzuQhuId+TuH7Bf7hzyXjZdAlRsHRy+FoEB+6cQlm6hdz6ZUpYP2xKghEHeX7EKGTlnSwTCT8JlMNjKit3UHsQhUHZFM6hlNybRO7D/CgLxbwg/vGE/SRKIZPCRMV2KdTpwMu6/p7QsDPgjbew2xvmFQyPszMPMFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076696; c=relaxed/simple;
	bh=4TAQFpNXYHYiZcq115Zn3rKdsoFm7HoC2vAvAW06ESc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uEwy5MnE/domHXPDqxsuiMyEg3CV2V0HIvqFM0eCUcunoykuKvYhUJnn8c4obB/c83nmt1NLdP4hS3314NKGDgSUCt7tnQwuYIup+6cJfCdq2f9wzwuGpTZPQoboJsg7NIFsvNWGgjCKVIjc1tLCdjelxZvJIw0IRkl8Z/2StzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fNQeE7OL; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLKOT95TFkrS8Qp/IbSTIeXH9lyPKur3HFh43nVB+QBgzum4jrZ/+3UMQHQw8MnL5aedw6CsTchUkbY1fjCWp+RySgOrrYUVggYwYdIhKrSoaLkhxi19a+l4JxpEADNuDhPOzU/PrNx5fqaECYkvPxIe+lUvMFfhvUKbu34wG+WyaZFHUah/4/cy+r2TMciI3lOZJRWHOfwnNCFb12Vfwn98dPueJNz+Jgg9vdvVXHEkjWuR2fgomvEIch3937TYsQmHsfyovuLmy2pvlbIHOUkjbxjHHpwYlB/ymGoAFKEvam0um8I17N5pBxk0V+Q/jjSr9XfUfZjCgOTqBWxOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z9/TdHYooVrjxZQyz/vdwcuerdMS8Dq4jH432Xeyl0=;
 b=JbboqxkdFWfLefNSiwny4Ft5MVMJOe8fUo07jHemxEra9ROsF3m1HxU2UsWDMNrKyYvqGOC6NtDNHKr1Moh3zpVkF3BUaGVaKtdgSZKw+AMaYyIRPYqpOBURy6B66ZVxImRW6JqRacNi2sj15C2SileLB27u6ezd8zP+j4bkWgxsccVrfNIG5Xwafg09dHJ//JiTbG3TsC5aO5779o23+Ir4lCAHT4pCP17fKuw2e7gQZgIK+zw0E1xjxmeNO+X9JzHnRSdvMXM63LiaPGmUBIwELJTedWLTA8brXaB255cFiQhfFaKdJT0zJkiNywuLq8Vk+H2fM5yURNVGsAMwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z9/TdHYooVrjxZQyz/vdwcuerdMS8Dq4jH432Xeyl0=;
 b=fNQeE7OLvOM02bdPetyBl4uo1C+lE0r7KToRpeOGZWrs7APJneOmGZZoP0ojDjDOxxQg3vtFYU1dhk9GqMZCKCz8sJP7ZRgc7a9RFUjYD7Li6IdhYYGtDs3RHxYVI8OSJMV2oYuPeIEv+Rgn7QnGx2GTzRzHtwM1iOW8RSirHhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:24:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:24:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 00/10] arm64: dts: imx8qm Add audio\flexcan\i2c\fec1
 nodes for imx8qm-mek board
Date: Thu, 25 Apr 2024 16:24:36 -0400
Message-Id: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAS8KmYC/13PQQqDMBCF4atI1k2ZRE20q96jFNFkrFlorLHBI
 t69UQq1Lt/A98PMxOFg0JFLNJMBvXHGdmEkp4iopuweSI0Om3DgCSTAqR5dkT3bonxpYykyZCK
 XKq9qQYLpB6zNtPVu97Ab40Y7vLe8Z+v1W2LpoeQZBcpzKVSclqBSfu2m/qxsS9aO53ubHS0PF
 hOoUYpKQCn+bbyz/PiBj4MVGShEGTOF+meXZfkAWT3J2SABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076686; l=3492;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4TAQFpNXYHYiZcq115Zn3rKdsoFm7HoC2vAvAW06ESc=;
 b=pqfQOaZYb/is/pP0QBMwaKC2p8xGJziP49C+gAXdljcDZtA9kGlaBrCaSvqga2axuu5Avvu47
 gGXOzXqaZJDBi1LQd+k8BYBMW62DNj2x67oiSg4ACItFfs5Pbro0J61
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
X-MS-Office365-Filtering-Correlation-Id: 0848d461-ba7f-484e-da98-08dc6565c1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3dOanlxbTlRVTNxSHQraG0yNEd5cSsvSFlwVkdCRTk2Tm9DYklMd1RTUlE2?=
 =?utf-8?B?NUhNdmZzWUNqdzVMUnR5eFprbmFnRTJMUXFKQUFQcmxVNE9uSG5iTE5nUDBC?=
 =?utf-8?B?RzJvUnVCU20wODZ2UW1DTEJhZXFJdG9PQU1LRWYyUzRxTjQ1N0NEMHR5bGtS?=
 =?utf-8?B?UitoTFkzVGVCNkhPQlRYdFVubEVYZEJlWkNWbzJBL2VlR0x5VTc3d3I2ZlBo?=
 =?utf-8?B?eXhTTmpZOTFIR2puVkJvSHl0MkYyanB6ellZSTJvcFpoZVMxRCtsenRwOURO?=
 =?utf-8?B?dm0xYWxON1ovREw1bm1mWEpmckxQSGVhK0xvZnNsSU16Q1JXcGRwRWU1VGtB?=
 =?utf-8?B?QnFlVS8xUWxWVHFTb0dmbVNGak42UkRaNWV1QXRhTWljY2ZLbjF2RWEyMHJr?=
 =?utf-8?B?eW0wbUdMSFBlMHBBZGZyNkJlWHROS0FhZ1FwM2RNelNCK1BjalpzQXkzVERz?=
 =?utf-8?B?OUlEZ25iNmVyNFZobHp0bFd4QmtYRHJFTlBuZWF3bUJJdGwyNFd6QXZrU0No?=
 =?utf-8?B?SXVJSTRFaXNoN2dNL2lhNEFPdHo1bS9rTStjWkdPTDJiZzgxN1FtT0ZEL25C?=
 =?utf-8?B?OHBsTHI3RWVMVjdUMkxPSlZmeFNWTlVUdThMNnBkQUsySFRLb2N0MmtHUkJj?=
 =?utf-8?B?R3BHZGJ3alY3aGJKaGs4WG43amJFOXhjMFU2cS9IemdBcXlDK1JFSTBLTUtI?=
 =?utf-8?B?Q1pNQk1JMzN1K1ArM0pjK05MeFI1ajB3dkpaUCtWQUVHOHA0bzhRK2pLNDF5?=
 =?utf-8?B?aHRUSkorMVo3b0Z4VWZmbU8wOGFsbmJkWTQzbnJaM3JIbWZydHQ0SzNoc2NW?=
 =?utf-8?B?MElLU3Blek9kdDBWSlFmWXA1S1l1aDdGR1dnQ1YvanUxRlVOK1BHQTNJR0VY?=
 =?utf-8?B?eW9vcWhENy9oN1FScXRGZEtsQnV4dWE0U2c2TnpPWTBsYWVENzMvbkVUMGV6?=
 =?utf-8?B?QUs3UnA1YXpSbWNITzhnSE9pNGxNMkJPN2hsSjN5WDQwNTlRQjdFb21RTE5l?=
 =?utf-8?B?alAwK3p3WHZKTWcyU2Q1RWc0SnZYRmJCL2dkdnNuczMySHFURWtkUHA3dnlv?=
 =?utf-8?B?dlNFVlRBd21PaDcyRjNSMVpNZHdTcXViMU13bFJuemFrRWZZNUtIWFdrZytN?=
 =?utf-8?B?ckdQSXcwSnVObEFLYVJRS1h6VG9IOW9OZ0lmMkpRbHBvYUE4ckl1c0pINHFj?=
 =?utf-8?B?U05HaGlhMG1vZVAyV1RXa0tTVldtT3NySGFRSG0yM2lpbzdSQnk5MGpieVQr?=
 =?utf-8?B?bWxJbDlGS3lCbitVUG1nMVNLdi9HZm5pTVgvcU41WDFGa3QydUNjU1FaN3l4?=
 =?utf-8?B?azUwVWxoOVdUdENKZWcvU1hKTG5JYXc0WTQyOFdiQ3lmZGpBTXRWbkJrUDJS?=
 =?utf-8?B?dVlkQTJRTGZEbGtZYlcyQWlKNm5zYU02SUs5b2JyN0ZFQXNRMy8zYnl1NHpr?=
 =?utf-8?B?TGp2K0lxU2ZDWkR3ak55MEt2MmpWd3lNVi9FeEVkckRjQS8vbUN1SURwbnU4?=
 =?utf-8?B?ZVlGcTU3UzBtcXpvUFFVUVZtMVhXYWZVYW5ZaXpjTk1vb0RqaEVBNUVudXRN?=
 =?utf-8?B?K1NaZDE0M1pYaGpzZVgxNjY0RzBOa3JLaGRjNlVqWS9abGhLbURBK2pZS3N1?=
 =?utf-8?B?bUpjaVZtaCtWZnQvb1hQa2xWQklMOGxuLzZtYWpwSlRIWE0wbnc2MjBYZ3Qz?=
 =?utf-8?B?ekVtZlNMWTN1dGh5SUtxRVFCcGE2d2NvSDVncEtKSWttT2xtSmhoVUpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkR4ZkhDWUg0SDhzMkU1d2xPaFBPN29tcTNwMmdMM0ZUbk9VanRTU1NjTndy?=
 =?utf-8?B?ZE5YMU1zMlY4clBHVlh4UUI1Yndwc2kyenVHTjhickhkUjBuNllQRkFMdnlj?=
 =?utf-8?B?NS9DbUVPb3lOc2txMVo2Sm5LSjFYSFRReFFwcTJyZjRrd01TOEo5YUJsVDRQ?=
 =?utf-8?B?a2U1TEFzM3NCVXJ4VDFFVjlnZlNRRVBJSDZ1LzJLZkg4YWk3cm15ZS9hdXpm?=
 =?utf-8?B?MDE2RFp2eWVYcU1LbzlSZlhYVTNrY1ZXQXBCMWJMQ28yU2Z4M2JHL3RNdmty?=
 =?utf-8?B?Zm4yYm5mK3gwaEtZU1BQQUJGVit6RUV6ZnB0WEVxNEdLTWl0TkNCQnBZWU52?=
 =?utf-8?B?SDNKcE0xRFhYMEV6YmszUjRUK0VrQnc3UWZHb0I4RUZHaVJyN2NrZzB5cGxI?=
 =?utf-8?B?QmRXU3ZHaUlOKzBpSUs1RUk5dWx5WFpZZzhOWnovK1BDTXNzUTA1V1c1OWlr?=
 =?utf-8?B?SGpmTUZhUVYrK1JNMmxyRjZ0T1hQZG1uV25hTmdzZHNtckpiZzVRMHBnUUVt?=
 =?utf-8?B?S2t4WnU5YkZ6YzJFcG1lWU5abWhiOGVSK1ZwVUpPSmx0Zi9DMHhaVlgrdWtW?=
 =?utf-8?B?eUtwakFVUXRLTGI5RElENk14SWVqNllRWFZBTi9Vd1MzcndpMFBqZWcyUVUr?=
 =?utf-8?B?Y1E2RHRiTmlsWElINUl4aDVFZkhXM1JINUxNaHAxN1hEY0RYK1dacmZiSGdh?=
 =?utf-8?B?VWpNcURpdWZtdVA0QmhEZmhITnNBa0xXalg4bnByOXRWcnFCYmcrVlVER1NF?=
 =?utf-8?B?NHFtdnNTM1RmY1QzVmw0YmkyMzB2SW5TOVpSejJVM3l0THNHRTl0OUovVXlQ?=
 =?utf-8?B?Rk95eUVsRHZpS3pDY0lFeERkbmVPUjhsZ0VCa1JVYVRZNW5jT0xERWN4cVU0?=
 =?utf-8?B?a3VXbW9BRE5oR2EvclRpNEdXMHpZTnBncGJQL3VpdGN0cGRiZVEydFZUcXZo?=
 =?utf-8?B?ZW9yYUFnNGwyeU9BU09yTW5nMHo4aVBMeW4wM2xBcHNjajc1NlQzbE91cS9D?=
 =?utf-8?B?N21IaHd5dStUcnkwNjlRYWNKKzFISkdzZC9uQnc0NlBVbmhJZGJYeld2T0du?=
 =?utf-8?B?R1VETVpiandvc0JEUDFSaU5hR1c0dXZiZU55d3RyNFQrTWNWa1l4TzVzWjhK?=
 =?utf-8?B?Rm5hYkEvN0hzNENTUy8vV3hWN1p3QkRUK2VBRTNiYzBzNk03TDZDcjF1UU5n?=
 =?utf-8?B?S1RZUHU0UHNKU29iTG9wd05DZmE3bmZ2a3d3ZGxYMGUvNGcyS25OMzJ4RU13?=
 =?utf-8?B?OWE2bHNoUHNmWXExVmRYRmkxdlVLSXZpNzBlSXBhRmtrNzlOSmZNNmZpa280?=
 =?utf-8?B?WDdGaEVRQ1BVVEZVZkJtcVpHd2hzRU9Ya1k5TlpSK2ZHRWV1Z0lYQmhMWWlr?=
 =?utf-8?B?aG9TWE1xVE1PVGRKSmtrRXdtWjUzNmo2by9PeWVhR3FiV0tqNjRxRy9nclBM?=
 =?utf-8?B?bUd5U0UxWHNuZnNnU2FMZ2IyZFFxQWwyNVhlQVRoT2p2TS94VjZkV0Q3UG9r?=
 =?utf-8?B?dWt3NUhGK0E4WGxNV1pXbnNLUUJsWjNGVDFkNWJ6Q3daYmFYQ1hzV1BtNjRC?=
 =?utf-8?B?SytvRVBySzBuWkRkLzh4WWEzTGZjNXRnSTRmVE1keXh0RjhZTHc2cERzOGVC?=
 =?utf-8?B?SmlyWkcxM1FrZnlTRWZDMCtVckt6aUdjNjZRZXBwSVNqWlMzMTNDK1dtd2U3?=
 =?utf-8?B?dWNvM25uRVlBL1VkTmtkb3Y1WWpwVXYwVWtjRVQyV1k3WlZSVW0vUDArUW1Z?=
 =?utf-8?B?NHF2QVNVUzdvcWpud2xZci80aTVtenE1aEJPZkN5UzZYSVN1TUFxNWRvd2cr?=
 =?utf-8?B?UHhBKzQ3NVByZmZwZ2JaUW9zcWVGU0pYS0VMN3hkTjBvaWQ4b2ZlSXBLRi9s?=
 =?utf-8?B?OGxYS3J0Zy9UMFhGTTN3SlBYKzJGTE1ManF5R2RjbUhVSTg4M3RrcjdtZSsv?=
 =?utf-8?B?bUlsQWpKTVVZeWJsaGlqdW9mVllHNG5qRkJ1Uk8rRUpZTy91bFBrWFNzSDJh?=
 =?utf-8?B?bzBCSDBJa1loTUFGWmQ3N1ZYSklSWUlsZWxxZG9ZL25GbVpvdi85RzJZek1R?=
 =?utf-8?B?UncvQlBZRTdBQ0RVcDVYditVSWVieVpIQWtzSTFCSk1iNjBJeFlWbjBMcldD?=
 =?utf-8?Q?mYTI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0848d461-ba7f-484e-da98-08dc6565c1f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:24:50.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGSPaZmcSqJvrCuQCC8Q1thXvlSnMeORQLxTGulvGWPz6Sk1Ocn7X01eYN8oBMLnTJAEb1Br4Q3SlcrFMupwcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

No new warning added by 
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8qm-mek.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Fix ">" at flexcan2 and flexcan3's pinctrl
- try best to keep order as label's alphabetically. Exited code have not
not order by label's alphabetically. iomux put to last to keep consistent
with other files
- fixe upercase in address in imx8qm-ss-audio.dtsi
- keep label's alphabetically in imx8qm-ss-audio.dtsi
- use name regulator-fec2-nvcc
- Link to v3: https://lore.kernel.org/r/20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com

Changes in v3:
- sensor use general name
- use tab in pinctrl
- remove extra space for fsl,asrc-rate
- change to bt_sco_codec: audio-codec-bt
-	audio-routing = "Headphone Jack", "HP_L",
    ++                          "Headphone Jack", "HP_R",
    ++                          "Ext Spk", "SPK_LP",
    ++                          "Ext Spk", "SPK_LN",
    ++                          "Ext Spk", "SPK_RP",
    ++                          "Ext Spk", "SPK_RN",
    ++                          "LINPUT1", "Mic Jack",
    ++                          "Mic Jack", "MICB";

- align clock under sai
- remove unused "FIXME: .."
- Link to v2: https://lore.kernel.org/r/20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com

Changes in v2:
- move vendor property to last, just before status
- use audio-codec@1a as node name
- about dual license problem, need relicense whole included tree's dts file
which out scope this patch
- About delete-node

imx8qm-ss-audio.dtsi are not supposed to be included directly. imx8qm.dtsi
is supposed to be included by other board dts file.

in imx8qm.dtsi

 	/* sorted in register address */
+	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -473,3 +558,4 @@ drc_crit0: trip1 {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-audio.dtsi"

"imx8qm-ss-audio" will overwrite some common audio node in
"imx8-ss-audio.dtsi"

acm, and sai4/5 are defined in imx8-ss-audio.dtsi for common part for all
imx8qm\imx8qxp\imx8dxl.

- Link to v1: https://lore.kernel.org/r/20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com

---
Frank Li (10):
      arm64: dts: imx8-ss-audio: remove memory-region = <&dsp_reserved>;
      arm64: dts: imx8qm-ss-audio: add audio nodes
      arm64: dts: imx8qm-mek: add sai and wm8960 support
      arm64: dts: imx8x: add cm41 subsystem dtsi
      arm64: dts: imx8qm-mek: add i2c0 and children devices
      arm64: dts: imx8qm-mek: add cm41_i2c and children devices
      arm64: dts: imx8qm-mek: add flexcan support
      arm64: dts: imx8qm-mek: add lsio mu5 and mu6
      arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
      arm64: dts: imx8qm-mek: add fec2 support

 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   |   1 -
 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi    |  68 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       | 344 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 102 +++++
 5 files changed, 987 insertions(+), 1 deletion(-)
---
base-commit: eda9714fe6d9e6e5690992ce7dd42b13a5be7803
change-id: 20240402-dts_8qm_audio-e1e1697c9bf6

Best regards,
---
Frank Li <Frank.Li@nxp.com>


