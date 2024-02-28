Return-Path: <linux-kernel+bounces-84558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BB86A847
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42961C21B06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA222318;
	Wed, 28 Feb 2024 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l6kVPfT/"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0432231F;
	Wed, 28 Feb 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100813; cv=fail; b=p/vbTdj9E8zEtQ/bFTIC3PWpDFlgoY1fB2Q1eLHEkjCcUIiP2f3gdYubJe+zE/krjKQhVYz+Zwkze2CmMKZoap1e9cV2kNJgyz3DBM6UzmiJRyZWuq7KuXyFGrQpxvg+aFYuriI7IHJI9dhpb5QtKZQHHxFPrEuUX0t+b37FgLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100813; c=relaxed/simple;
	bh=G0SeBhj9J/uGRnoGOA8shOErvODLDgSZvinFJ9PvNyY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WcBwzharaV7sA0EG2VhAWWChWreyOl0ppZbof9Wjg4f1A0vTmINyDGDu8VPa7zJ0uhxIqks60xkuMzyjjaJnoOZaxybE9xQPqgoBnPkks6+pvKIMijgXofArbtYw6/ry2a0ZfsCDDut9+Jkc3n/jqInpRmCK0P7DX/Bent1Gols=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=l6kVPfT/; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHiyTOTiozr7O7Ivao8SFcomL6LAjWMV5hHGpQCYjfPGXHdtEJnnXlHHG4ZpLqnj5JUXZgrxF5LyZ9XCUaEqQ1FtTao1MFOJvbETwdj0NlSDqz4io1K42/bY6VEoE2HMCs2TAvX/6nO5siWHHHejEy3QNaVFSqb+sMeagFNDe3T5oG3Yi5FIQZsWgovUGIj9N1Dh9Qz4L4qc6go484RTGD4M7JJpaIWkECvspjQW7sYEKqiitXGdHurfnQD1Wr7vI2fIcB9t9MbJdT2DKxWCRV2LFK4bgCpEPQxUYIwAUTelTNv8QP1hFbyxQjNgqkcST7wcPuNiPF9mnXLmDtJnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYlCFgTuvtNHMibcgf3vcP7TLphCQm3TcjRhEMJbZRI=;
 b=JzLkCq6bCWnF+y48WotmmRR/GMimp6wiqGlnEBl8p4vr/YCHJgrr/ASSdwJqQPueYeZteJQmPR7AOVVL7sriCxCYDa6fDiDO3hu+dlxPFU6J5Dr3uADT9c5pxgeINDx9WHUzT7JB3/wcps+QfAg8GYrNhZzVfBe2C43pZXPBZDyOAH51HrqsBlf7ngR55Mggs7vpsGGzY1Yw3npTVZpBjH02ThZ29/PkyLAJqkb19pDeiTSWGKAe2QdFcNUhBmIvVjdGOvvlDfuaxKw1A0ZtqN3tWoCrHYgt/Qdw0TEdABpPBoFKu7DBXOIC0YmbWldNN0Uu69Yr5N7rZvDSYsRTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYlCFgTuvtNHMibcgf3vcP7TLphCQm3TcjRhEMJbZRI=;
 b=l6kVPfT/a0IhnNhiegjU/K0Z/7p7DgxtYFw+mHZY2Se2tDTnPc+4ZQCIptviCtt16SLrYKvsoS8wgNYABr/OU+OZcuArcFpy5vLZZQi64jnm27ok2/9A61mkOEFFFq3xahQZ7hBZPklT236TdpDKMzksPDdInyToy1Yol5uxTbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6935.eurprd04.prod.outlook.com (2603:10a6:20b:10e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 06:13:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 06:13:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	saravanak@google.com,
	bhelgaas@google.com,
	pali@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] of: dynamic: notify before revert
Date: Wed, 28 Feb 2024 14:21:38 +0800
Message-Id: <20240228062138.1275542-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 1403f506-f7f0-4cdf-2481-08dc382460db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WlAN5ffbR002cXXBxY1/5PwiYdePf2BZMjDOhYxyKLscgW375dxZ6SpXlZqjS1bagep2IuRHElpyAKDw88/ZvVmqlh1dGD/ZLQFGnxPM7ECPU9PAhi5q+p06cxmnrokYVBGOfKQJhqrx1EgwojfV5pYdy8D87M4dS9KWzLQOJKeFBvrbMb1v/t1CZtdCtbuwYGhJypY/ZN3KQHy/MIDrnkZp7vE7Nbt8HOyibO8rJ/vJZv3VOrjxwoOzGKqjpMtVmnKcFz2Tl7byA1Fpe3AV9MvCP1l2W4bTEUDJoseX0UyatuJUBso4o9ViX3UnkzeEtfQVc5FZZlfiRCM4NYQkzHK0Sn9HXlq6HSzGGdGDTkZCpJI4D9oDiqwtyedbVInlQrXXsZsyQZc7oLyb83eR4G75B1BkcJjp31lCsn37X8EiSVD+qGBtepn/4b419uD0mhMSgPtI60oEkhmMUOFmNu5Fm/0Wv+5abzailmQbzGTbTTUTJJikgrAkY/AIsv13HVWH4DHtTzjvY/+lylyinA7tU5pRXpPEhMkLCcvyfY1MBU0kFzJHRnHT2LvUqy0rIzBNu0gnU+uSnx528IZ0PucWsBo3cHOPgNyCwgqBc+t26M1SJkjkEXCo8TS8CL/+ekMXJX1igAhCOu+0c/W0ePthoSHJR5t5VqIYgJkDCfD4IUP9/9FCYEITeOgVGEWemb5RGM5wn2dAUdlZ05CK1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?60FApJqnun5aABmXhNBCSobqBP5Wy9l/LZJAYq+/f/Vpx0UToy004gsR8ko1?=
 =?us-ascii?Q?nGgF8WK8MzolagWPU+/Cjt8DptjN4JoPCp90Mc8wEjHIBsozycFJWfTBiGhe?=
 =?us-ascii?Q?LLebqOwbx78Fc2vlLpkoEpe5eYEG+B987Eqa2gUbIzzZ8Xd6y1aMQXEUMmhT?=
 =?us-ascii?Q?SdUL6/adW6++PKPLu7ZX5pUKULt9gqhB6BR7zTVs3H/D7K4Zk44jEnk4M3Dp?=
 =?us-ascii?Q?Xfi+COiIAC4npt6hRMOT0bIb/XfZCTCGWUGqCW8KAzAMCnNZtCeOb9JcNEok?=
 =?us-ascii?Q?5ADMRr1Nflpgr4jY4RCLjJfzT82Bbnznjml29UiJeoJ9x5Rbiu3B3hDn2Rkq?=
 =?us-ascii?Q?baGAKdXy3LHLS4hgft+PNkaC3bl3Ncy7HkTibv0XcYoiwmqnZ6D47Cr5OP4Q?=
 =?us-ascii?Q?PjHMi0eQQmWhA0jYClNifXjFerAcFEemZqBUkC4t5Dl5UpwQurQ58wGnSuaH?=
 =?us-ascii?Q?6Ft6lknrJI/psLIbS028pYt56z0TjiNT6vqtqM+0ZW8IDm6JUf5x8y9mamqc?=
 =?us-ascii?Q?PZCtrm6OvvA/59v6/cnfzI1WCsUXThewTlY7td8Uly38sIh47W/x4nak7dmd?=
 =?us-ascii?Q?eKm8sHFUopa7R7Oaf2R9DhtjzNEa95TKRnvCJu2pWwn+PfXB02X9ESxkKuKb?=
 =?us-ascii?Q?8WQyjW3HsRdNbNP9ACHmRD/oOM9SsSO6FfYnPzndGGb/zr5gtmVBZazwvjqr?=
 =?us-ascii?Q?v6ELl9GrctfgtPbyIzkys/vcfBOEj1NU+/zK9aapB9Tqye7rW013VRxTdzMM?=
 =?us-ascii?Q?QqL2qboZEV3utcGUuiwlqve6GkhPtiRrYMVcyVvtBUzpXyW64sK5xH9Bhqeb?=
 =?us-ascii?Q?3a9ViaYJPsMg69XYBvtY5pGfeHvLV5jo9ZUGcvI9OVdAjRYo4dN4S1NLf2u7?=
 =?us-ascii?Q?hfyNMmnmMKN2/oQFECC1XbD0qdoGhXiOZBhGrAPaGcuv7eHTHIXS4mNAHh1Z?=
 =?us-ascii?Q?RrpaQ+f29QDDfEAZbnxVKCsrcvV981k5yl/2LgWINEgGaH8xQZMI14yejAa7?=
 =?us-ascii?Q?hf89lrxGaIARbvphr2uUrHFO78uXQZF9ypDOFtrlRAI3pbWden0yJb4cJRkz?=
 =?us-ascii?Q?VtWXAwbeqQbritz4yYpAePwkkGZSSIcpTHK8kc2Eh0AMih6C2vYgTdv3MsdD?=
 =?us-ascii?Q?kf66M0WlmM75M6IqzaW2Auj00HEeX4p5dyBzfZ1tNRFFlRygRxa5cv7Ip2j6?=
 =?us-ascii?Q?P7ClY2+dEjgodT01t3bPEVUbERNMAT/mg7ZMDgPNQ2Ua/NLGXmssNymaJiqW?=
 =?us-ascii?Q?QX0zI6XcXfTYBwnq1HCnstwgCKlz4FRiH9NcQo4uQgQbt2Yysy4kmugrKSB1?=
 =?us-ascii?Q?2NIDGhpHcw6NiQUcAXFTQ760o4EZAMIhX8Gy+Iug7V4RN2g2vEBJLBS5kv/E?=
 =?us-ascii?Q?xVUylI8OECfqxquDphfWIj5qGYhNJFcqczKDHbuunH4H0fGwMPyo1VVR4tpL?=
 =?us-ascii?Q?LXQIwMetvqocZ6jI4CQiEBjdflgjvAqs89kTNOwS07BmBRpw566tj2U+KOE2?=
 =?us-ascii?Q?+iZ/Un7SkO6ad2F6ccNc80I2wbGf+4LZ3K9Nj2f5Y4xvKjVv8ciWRM+JTkiY?=
 =?us-ascii?Q?KMJuVNAa4oRj4fx0dUREiDSTUzfjTXO3PWMIZTRc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1403f506-f7f0-4cdf-2481-08dc382460db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 06:13:27.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYiNydhIosOquIxOWChzoIO0aKILoHtlDfZSL0ouaZm5P/WRt8rM2sOkLYpLUBmKSrRf6WVikeR6R8xfOHdHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6935

From: Peng Fan <peng.fan@nxp.com>

When PCI node was created using an overlay and the overlay is
reverted/destroyed, the "linux,pci-domain" property no longer
exists, so of_get_pci_domain_nr will return failure. Then
of_pci_bus_release_domain_nr will actually use the dynamic IDA,
even if the IDA was allocated in static IDA.

So move the notify before revert to fix the issue.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

The initial thread:
https://lore.kernel.org/all/20230913115737.GA426735@bhelgaas/

 drivers/of/dynamic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 3bf27052832f..0a5ec2bda380 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -834,13 +834,15 @@ int __of_changeset_revert_notify(struct of_changeset *ocs)
 
 static int __of_changeset_revert(struct of_changeset *ocs)
 {
-	int ret, ret_reply;
+	int ret, ret_reply = 0;
 
-	ret_reply = 0;
-	ret = __of_changeset_revert_entries(ocs, &ret_reply);
+	ret = __of_changeset_revert_notify(ocs);
+	if (ret)
+		return ret;
 
-	if (!ret)
-		ret = __of_changeset_revert_notify(ocs);
+	ret = __of_changeset_revert_entries(ocs, &ret_reply);
+	if (ret && !ret_reply)
+		ret = __of_changeset_apply_notify(ocs);
 
 	return ret;
 }
-- 
2.37.1


