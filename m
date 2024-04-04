Return-Path: <linux-kernel+bounces-131554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC2898986
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C32228196F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5166129A73;
	Thu,  4 Apr 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rL2Ii499"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2092.outbound.protection.outlook.com [40.107.6.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E531292EB;
	Thu,  4 Apr 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239629; cv=fail; b=BlPV8F0ZeAe/CXbm0b1GOVaobo3bLdVCmkDLUFmMFbwLIodCnJcku9qG1C7d2fH3Lxya2Prh8g+dIDip7izJrEQjLREco66QZCs5WHe9cc69Ic2jvq+zfPgg6ZZQpoKhlEP0qxiIs8Nof7P2MLIicnjG5JFDoc5ae7/qzlfZaNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239629; c=relaxed/simple;
	bh=/MZbIZ+f99LzOdujWXdRmCEoGgs7mS4k+F+54kWUKmc=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=YUQWqvtSpYtDll8EuNYDLTLMpxxmu8Lt7gnpeZQGK+mzOxw/1fkRYeOhzGrb/JwsnRp57kxhPZcag1b04P3mvi47nJGKnKeHYhAwHso/N4RN5UJdbKjBUgnwD1z//M9Gyo7uT88P8JXjWTdqU309D/TQk2B6XHA3AFUZ15gc0uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rL2Ii499; arc=fail smtp.client-ip=40.107.6.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnGIGs/ssYfEccPtZjlBB1ZhIUMjlkAN1By6upVjHVBh72sAC/tT2I4hgRuWfshMwVFN67I9QqBCJSh/gebEpe2iH2EuvKDwXlD9aN8xhtuN5ZuY+D2wTFnGhWs5IcmEpxKESeV71DM+0Th8grmIrlxwZ/BOBHK7TpO7i8ZA+gDMlEW+/GrACGojuR3HWtYRIntTQRJyE2tlWeUPx5VCteiGGL6FHHqE4kPievn5lzalLPGOfFsmD/QzQSk5nAAurvGUDI/ZAkwGnd4r6yzO7SRYCptQ46eW56N48MyUv9bh1+UDMwo93q0lsaPbSbLr5QmyMgMydIbhnbMqw2ppAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Oa+fpWPCsBDv3n9a3q9DWB0O6FFa8Aieq+w/c5z18s=;
 b=eJxNRCzW5iBAdHGHXfg/ojx3RiVb/ylo29xfh1HwhJfVfChgzPP/Gub7XxtzdB4tyYXwBwhVWuj8xpacQHZzJk1WmvKLTWtQBLlYxu5tP8IznAbpTv8VXM5VLyR6iutiIdNsSyxAZIeBLGxpk+JFMObHNsKpUWjdbeFPzctxPWksF5Y05RDaR18FsfR/jZeGj6VQJQ5k5nFvTsSh05S+4bpv4VC6mXRYGViIV9eVf9o9SBXXqv/1Wz6axw3JT24TCi6J4N0HQxjsyetl7xrVLjJx4vn4965Vyt+ugjmIoi+5j39IdwXcW1V6r/aVqE2OPom8gJDit2F66fp9byRnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oa+fpWPCsBDv3n9a3q9DWB0O6FFa8Aieq+w/c5z18s=;
 b=rL2Ii499ji/ZSUAOyjD65GUQR/3gcZQU6X4oaDcYVdRrrEtHzJBVTZ4WN+f6ZTnrxY2Xc47ZV5bBEPTBT4FudgFXjNJIWc+aclxUOrlj9QoEkydE+A/jwC8TH3WZO7LUBFuT/pgM5o+BUpp3GcJb7/JuuUYG5ccbC8LTJYCc8IA=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8541.eurprd04.prod.outlook.com (2603:10a6:102:214::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27; Thu, 4 Apr
 2024 14:07:03 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 14:07:03 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Apr 2024 16:06:39 +0200
Subject: [PATCH net-next v2] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-mv88e6xxx-truncate-busid-v2-1-69683f67008b@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAO6zDmYC/4WNTQ7CIBCFr9LM2jFAa62uvIfpAuhgSSwYoATT9
 O6SXsDl+/veBpGCpQj3ZoNA2UbrXRXi1ICepXsR2qlqEEx0rBUMlzwM1JdSMIXVaZkI1RrthG0
 n+SSu/U0pA3X+CWRsOdBPcJTQUUkw1mS2MfnwPT4zP/L/+MyRozZS04UpQUY9on9Xv7bO2i8w7
 vv+A4GILiLOAAAA
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, Mor Nagli <mor.nagli@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PAXPR04MB8541:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J9dUQr2EkOSowXSkTJlVaC4P3rFlVDPbY+2Kmy6P4DZPFDkDOw0Lh+KrHu69ITVxX7/6M/Uv9UjLufjgQA7oBPGceoSbqZMSvr38qCl+glHV/ufUuDVp7csiNJ4i3wqH8E38F7LK9cU40FJPtbORy6wJCnZBoBm5ospFY/DvEKravYKD1TgotVUnOslXD/rOVjzyBy1CXvGpPR+QMYevD6t2wFGTeI2cPV0pMne1hfF372lPaUU9o+9hjJ75wzdVZ3prjRTF26pt+oZ/Glmbxgo/y0hB2cTyrQNCLwoYRmeFWJxoSymfwGS9J7KKdjQ2n+CRd9+UIjqxb0h5W6GWkFIlhKelyvBoA1cjRBIaX86olPSS6E4UGe0I9exiKtlVF3/LJAzYvXWUdKKJAWuUJnIlAkTZhshLf6p/nbVaNmgakZ4zsPN+s1RqSjEJrY7W8ODD1M+VOqqcKFpdNSRakysxNlGoG5feI1UUII2BP2BDAXxo6UnJ1WSFYHRxEqO2LW/xPobxwqrzWAlPwy0NSJpmvZ/1t5fIKMMTwwK2RUfWGOMe1gXHtAurkm5jOW0Y7sv/6XkpsZyX/ydHp0P9C3fNKwJ8BRJylgYVWI5BpKkQ+1TlUSmU91j1inTLU92iLj1kNx3yJBtCjuE0C9LiDdSjOtSNiHCaVd9E+GKQWF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE4yOGdRdXV0dU5tVTR1TGZaekhUWDllaitNYVRXdm96cUtDWisrSTRMV2Ro?=
 =?utf-8?B?VGZOL1BWNnJlZzhTVFlHMmVLclVKeDBQS1lRT3JiMTltR0tlTUVORDJFSUV1?=
 =?utf-8?B?N2FFN0NqYmJ6S2xIQU5CSGJ1R3NtUDM5enJ4dndSRHVPL0tPU3NqaXBoOVps?=
 =?utf-8?B?V1dJN0l4ME5obG9zamhTNEZzNUZHZjlFYjUvbFhJRWdGSzFBVXI0aGpjZExS?=
 =?utf-8?B?OWdKaThtMGt4UmRodzlPNG1pcVNNbFdDQ2lUQTc3aHRkZk9MQS9jOFRCeDE0?=
 =?utf-8?B?RVJKaURPcy9nR0Z3UDI0Zk5rR2VSb0hORllUS0hyYzgxTGtNL3Zvc3RHOElt?=
 =?utf-8?B?c2dFT0E0SGJVVHcva3VucGlHQ1ZUTDVCWXpTZ1laYUNaRkg5WVpaOFE2MHdv?=
 =?utf-8?B?bjhlMEVMYkFYK0libEFiSFM1K2hZczdob1o0cTZWRFNwTHc3L0ZSdm1Uczhu?=
 =?utf-8?B?d0xVbDQzOFd3VW1SdWRpVFZjN3lXbXF3RTRsTnIxZXpsOVFHYXhrYW93cmpC?=
 =?utf-8?B?ZnFLczRQODgrQXBxUGdlN1BuZXBmZmtHK2JXbnRvM2hqNm5UUUUwZUhXc1B3?=
 =?utf-8?B?TENTN2MrN3Z5LzlNTWtsL202S015N1o3aEVPenh2R0M4SXA5UEs3WWhhVHlJ?=
 =?utf-8?B?WTN0RlBCSTQ5Rm1CdHhzZXpZTDJLaEU0WUw2a2ljMjNOUlB5N3U3UTgvam9C?=
 =?utf-8?B?NjFSa2JkL1V1c09JS0lSaE1HOERyeHZXcWhzZzJUdGdGWGV2VWU0dzBZK2xU?=
 =?utf-8?B?Z3hXRmlTb1FNY2FKdTFEeHgwVm1uazBHY1NNTVpzWlhiUFI1QjhuRE9aSWlp?=
 =?utf-8?B?a1o1YkZkUDFSc2dtM0wxWGs0bzFQNGdjVTcveVF0emhoQTBLbEp1SFNvYmNO?=
 =?utf-8?B?UVlQWnJCUVd1V3VRNEhrZEl2TFQ5WUExbkYySmE2ZjRlTHUzRVZLWmZ2WFBC?=
 =?utf-8?B?WVpTdDB3QTJUVWM0QjhRWExvQlRKMSt5ZVRIYzhqeW5JMU9CVEx1ZjFyRDh1?=
 =?utf-8?B?MkIxQWZFQ3gxeUJXVDZzNDVmUGxqbit1emFWL2pjUEF6RVRmdFdBYklaRlJY?=
 =?utf-8?B?VmJFa2VtQXlGNDlHTWdVNGhrTVFydlJ4aXlVbjJQQm9haUxsak5RUkV4TUVS?=
 =?utf-8?B?NXUwb3VrTmxPQVJUcFY0ZEl3WlNsVkNCUnpIT2V3NjZZWEhaZHEycDFXUVZQ?=
 =?utf-8?B?TzlmR2hBOHM1TGwvVVFxaGg3Y29hcmRLV3BJUDUvWVB2KzRJYmRHWVhyb1By?=
 =?utf-8?B?azJINERpOVVoaUtjS3RpaDNTTUY4bVloZytDYndieGc0Rmpqdjd3Mk14dTVY?=
 =?utf-8?B?YlF1dmxqU040NkJ2cGlDSERGV3BMcEhIYWlpZzJ3SkE1eGhCRDZ5ODlhamlC?=
 =?utf-8?B?cEcycUhZTUVmR1VUdE9Ud0JWY0hxSjVWc01TTHMvU1VJMlpQQUNYc3BXdTFy?=
 =?utf-8?B?aFdGZEF1ejFCbzBiSk4yVHNkblM3SndaSUI5TVUxUnRERFNlMTNFbmdzdnpE?=
 =?utf-8?B?WjRrN1phTjRJYzBiZTcveWdZUnNmSlM3SEVoZ2ZRMXhoSzkwN0xla29USE1E?=
 =?utf-8?B?TDZpamd4VlpTOXdBVWtPTUZ5TndNNDEveWc3VmNBeFZkNHZZOVFXOHZWb3Vv?=
 =?utf-8?B?MlZ6ck5VSVpsTUJvb3ZmdEkxakU3NXlpOTJ2bm9DVlBpUnEreXdoWm5WaUxw?=
 =?utf-8?B?emFXZHphb3BoTmhGTC9xSGd2a28vWHM5c2ZaZjFNVDd0clBxNHF1L3k5aG0y?=
 =?utf-8?B?c2hGMEs2TXFVR09KK2t4bjNxT0o2bmoxMjJ4YXM1UDd4QjRpbkdrZEFQeWlL?=
 =?utf-8?B?NXNCQzN1QWxWaG51dUJaS3c3Tng0VFN5QkpyaFpkYVhtNWtZRWFVQkcyQTZO?=
 =?utf-8?B?M0ROMEhRN2tOVldocmk0TCtVb2p3MFgvYkJITE1TK0s3MmFwREZhV0NacDha?=
 =?utf-8?B?WHJVRnZWdUtiSnFBUXRvYWRlQ0tDU3dCQVFZVVg1d1hqOEd4S1BDVmtWTkd0?=
 =?utf-8?B?NHAxbDgzTVhoNVhqUVBVSkI3RUphQVNKRHdJcHhybnozZzZMT3pRWWRVaW1E?=
 =?utf-8?B?TnVWQXpaQWw2eEV4bEhHUWN2RFVGSTg4dmRoZFBZL1ZoZklwcnNaOU12MUFB?=
 =?utf-8?Q?Lp0AD1/4wa2/bIp+Xx4UEmJpT?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199d00c1-35f8-4da2-b626-08dc54b0809d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 14:07:03.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TgymX24TRPEAvIxGXYmSpLDjKil2DSVcGKin28Y/8eOKhrKq9dtFVhpRDMCapYbO4nrgvD1wFOOCobm9Ik4NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8541

mv88e6xxx supports multiple mdio buses as children, e.g. to model both
internal and external phys. If the child buses mdio ids are truncated,
they might collide with each other leading to an obscure error from
kobject_add.

The maximum length of bus id is currently defined as 61
(MII_BUS_ID_SIZE). Truncation can occur on platforms with long node
names and multiple levels before the parent bus on which the dsa switch
itself sits, e.g. CN9130 [1].

Compare the return value of snprintf against maximum bus-id length to
detect truncation. In that case write an incrementing marker to the end
to avoid name collisions.
This changes the problematic bus-ids mdio and mdio-external from [1]
to [2].

Truncation at the beginning was considered as a workaround, however that
is still subject to name collisions in sysfs where only the first
characters differ.

[1]
[    8.324631] mv88e6085 f212a200.mdio-mii:04: switch 0x1760 detected: Marvell 88E6176, revision 1
[    8.389516] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
[    8.592367] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
[    8.623593] sysfs: cannot create duplicate filename '/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi'
[    8.785480] kobject: kobject_add_internal failed for !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to register things with the same name in the same directory.
[    8.936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/ethernet-switch@4/mdi failed to register
[    8.946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi: __mdiobus_register: -22
[    8.956003] mv88e6085 f212a200.mdio-mii:04: Cannot register MDIO bus (-22)
[    8.965329] mv88e6085: probe of f212a200.mdio-mii:04 failed with error -22

[2]
/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch...!-0
/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch...!-1

Signed-off-by: Josua Mayer <josua@solid-run.com>
---


Bcc: Mor Nagli <mor.nagli@solid-run.com>
---
Changes in v2:
- fixed typo in commit message
  (Reportby: Jiri Pirko <jiri@resnulli.us>)
- replaced warning message with controlled truncation
- Link to v1: https://lore.kernel.org/r/20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com
---
 drivers/net/dsa/mv88e6xxx/chip.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9ed1821184ec..2b181b432bbc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3705,7 +3705,7 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 				   struct device_node *np,
 				   bool external)
 {
-	static int index;
+	static int index, trunc;
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 	struct mii_bus *bus;
 	int err;
@@ -3734,10 +3734,26 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 
 	if (np) {
 		bus->name = np->full_name;
-		snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
+		err = snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
 	} else {
 		bus->name = "mv88e6xxx SMI";
-		snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
+		err = snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
+	}
+	if (err < 0) {
+		return err;
+	} else if (err >= MII_BUS_ID_SIZE) {
+		/* If generated bus id is truncated, names in sysfs
+		 * may collide. Insert a special numeric suffix to mark
+		 * truncation and avoid name collisions.
+		 */
+		err = snprintf(NULL, 0, "...!-%d", trunc);
+		if (err < 0)
+			return err;
+		else if (err >= MII_BUS_ID_SIZE)
+			return -ENOBUFS;
+
+		snprintf(bus->id + MII_BUS_ID_SIZE - err - 1,
+			 MII_BUS_ID_SIZE - err, "...!-%d", trunc++);
 	}
 
 	bus->read = mv88e6xxx_mdio_read;

---
base-commit: d72b735712e65cccb85f81e6b26a14ea53cc6438
change-id: 20240320-mv88e6xxx-truncate-busid-34a1d2769bbf

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


