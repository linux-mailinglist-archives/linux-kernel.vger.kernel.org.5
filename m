Return-Path: <linux-kernel+bounces-40729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092ED83E4E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882451F2141B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80325564;
	Fri, 26 Jan 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bhHnP1fw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2091.outbound.protection.outlook.com [40.107.93.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECF225A5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307183; cv=fail; b=usMsYtxHocbT/IgaB1fgNgPAG5lY6C4FwLWGnwPumGhhexJZ2twu/+ibG+tPG+DVLaynTBBlirWXmFYveDXqNJx/ghXaSMZKY6sE/00I1tMBO62Gzz45euOOnYacdgOvUBIUnHMcTAs289H9zg8AOnUdtqX+tAAi6FyE9R5nP/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307183; c=relaxed/simple;
	bh=Jxsf2ZA6ZIVfyPQZaedV6wbPrDvsE/3BMh2yCFTZNt4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nJF0qWbIQ/HbjQ8Pgxh2Olxdl7sv0GtVunB2T1MbizT/oREqD4sSMhmeyoqJSB3kCK0pZGzoj5FTtWvm8MNbYnL0md9QRfEC9Y/oGnW7uWPbRYLAKRVKvq8W8KGdGkEBbWQuoAez8hOGoxEChyb+FT5SypkOpe9d1bBuT0ftrak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bhHnP1fw; arc=fail smtp.client-ip=40.107.93.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T99B6BvsrW7LVUJVlN52XTTfm0jpFxEbhDfqR0GFNWLMKXP5G+u79CZF2+SbzIHFzMvo7hkE4OF4iAVnulMPUUQRBqGs58gO/Zqo7XYCBhJQPOX7Q4WpihYxhhBZQfkgWb/ncPmBkUewbOj5hqp6jalHRQ66PHy0IM098yntNaLZVdsOBBI18Ndc2QMTfM/iRHngBaURg3Be2ZxLz313UUQ20wW9gqGNH7FcldCKBxtcwCTK+2H/TSEZozL/Pt/v7fBlLMEHDhFsMOxDg2O2KL0euY+JTI7iBBj5Cm3ykY5ObcQeN/2+sicg70RQzalyPCISdP2+uv+OJ8fTbJULmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HckM0fbTP73H1uWNe2kOQ9AzAH0jZg4sNAuF1mBzrSo=;
 b=VEQasmG+2Bsscp26y9pmebGSO0lRw71EJxDotGRgnv7ZGq+DZsAQMO/klq4rKFSj5cxIK3dLUiQZE3DNd1wk78Lb3gKDXnmOQtwHi6/yP4FLpth+XMK6NHvUjB+h6uUPbJbb4zsIjZDz81Z0G64eGiuYYtQrRfQbTqvYU/s0GGVnjifm/a52xUWoBAQDcMtrXqivYD1WQHr3vtrfJzqfHpGF/QvKYF2jztAbW6QyWtEQCjs3kGbmEmT9tUlei5+NrZQWSHA/Gw0OjUpMv3ZghqMaBs1E22o0Ar0eRrbdV0J1aFIFXJs2W5ebCNCfRaHXm982Zw7c1JO8Kv892xisgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HckM0fbTP73H1uWNe2kOQ9AzAH0jZg4sNAuF1mBzrSo=;
 b=bhHnP1fwqTv17IOmh3QvlB51rHhOC7ZhfaovkMEDAuaXBuJaqOl5RnV74IrF/tkNr1PSLgHAH2aDAoNnPh+78i0cOU/uGEomc+badlZYT38QYml7MApvMDown7pYfLvincKervUNropSdrpnRMYGxrq8kKF2Uog+4QDtzqE2h48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 PH0PR01MB7491.prod.exchangelabs.com (2603:10b6:510:f2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Fri, 26 Jan 2024 22:12:56 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 22:12:56 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf/arm-cmn: Add support for tertiary match group
Date: Fri, 26 Jan 2024 14:12:12 -0800
Message-Id: <20240126221215.1537377-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::27) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|PH0PR01MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: facf96b0-6199-4234-f1b0-08dc1ebbf2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dv/n2n1id4jGOPpmsqzYbaouyRi7+e1VAI53PbKsRH5axh8ENGXOb0HmR+Q0ErfHt7MZBHNcVFq93tos0OupDcWLnAEqoKw5PBL1haQldX0hhxqqEvuwOxEKTeHM9Itv5bkahOfkNe385FgLt8TffhTWq6c5TozM3GdkMpHx+Vlw9PN5QY4EJdytjABw7uF8G+Y5MsRd3MX/fUzcDHnZLaSY+TFFXkn9zCkYtAcc/aLLB91WgVUv1yeGbAUd9V02Q2WBgsKB/8JpJhfWSWsBmpd/eOBqRi3+PFun9ODzZU8/GEqRGcr0UXav3fdj46lytnSyM3oDs/nmDVyw3nos8NWPQyvjY/8Q4A+PgUX3VuD22MqQFrh85ajHqrDWAPbRL0iav/e+Dgs6Z+sb4MmON0v09UQsgjZ2miFOgUZ2IQM5cAEa4r3gpbAOxJGvgINVbVTpXJ7HyIfQUA9kGlkfuxpBsonjcqj0Nh+a5sByHxujHX52J6XJvu9Hwreqy5Ft8vJYPcJ1U54lpt7er+am/h+OHEbmYBNXlckWFwVEBMBj9wUZORj3LPjPxQqQG7I8KVzYIwqSarn7BuIlXNxIonJMFA+g+dautSDS6HUaiR2zs7Licr9JkNDsfn0uVbOL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(66476007)(4744005)(8936002)(2906002)(66946007)(8676002)(316002)(4326008)(66556008)(86362001)(110136005)(41300700001)(478600001)(6486002)(1076003)(83380400001)(6512007)(52116002)(38100700002)(38350700005)(6666004)(2616005)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Een5PoLojZE5Ief4GI5i3M3tkRiFB5RbZMx7ZBqh8L9D1CpV+P7lxo2fKyH/?=
 =?us-ascii?Q?sILmBdRs/6gz6bUlXAcRZaonJuVKpcUYnFquviHpSCxvchmczLXprknxh67z?=
 =?us-ascii?Q?ILVq/XNgoPles/JjeBBo17RHCk8xVUWlIVb09TdT1qqlp8I/8L3DN24rzOL8?=
 =?us-ascii?Q?HR0SKlb8wZOn0nH3MaYuabZUYFJAi1sovuTs9Vdst4ejDlqdqu1IxVsU2GK7?=
 =?us-ascii?Q?NDDpVrYVCoIT1AWqYQT5s2uNO/kGHqzF99UtuGPVQ0e+i9mkQyY3qCB1Tw/P?=
 =?us-ascii?Q?SJ5EVQkloRekUP4AVABBfmx3UDrLQdses023283nIv1P8cQRJYsCuGj/ckQ2?=
 =?us-ascii?Q?NzkIT+zutzi9hqqpJWrlrm5Yfl4xaThO30oEiV7RhckDrvP69hCLRnYvOK2M?=
 =?us-ascii?Q?3kgHYDIIx7mHZkMj1eNLx+a0weLNxv8FbYVIz4PeIFpMdcP3oeBY9MNn8SOn?=
 =?us-ascii?Q?eSHZCXlxgf2OC9oUA5ClmDYSIfwKIEz1V0RorlmtZ7S8Yll7fufykeBNRvb1?=
 =?us-ascii?Q?jx9jw3qs/fnKYYAgczHv4Giq1uPYZ01djakpQ2CMXNGQybkUrce+WkvEDrin?=
 =?us-ascii?Q?Oix61KJ9B8TQMtYXn6pFNXhu84L0SG/U5FjsZPRGPRNC62g5g/u2T/wH7VKM?=
 =?us-ascii?Q?/xKUENQ3hbfz5910Td++LD/AFEg187noYJGGdh/gWS6v9N1MrgereCDAYu/d?=
 =?us-ascii?Q?/RdM5ihqEWjvyM3WE62+MzqHa+lYknqE9A9YiMDjmu9IOUsve6PqbKQK6Gwb?=
 =?us-ascii?Q?L75ZFeAk2w6I0SDI0YrQdwUpYxXUqKyqLpZwh3XSzWmoKaz5bkeuXtSv+YSL?=
 =?us-ascii?Q?4x7zTEuvun7hk7uRs/G24x6/BslUeUMmEIFrBR6zYfVhoTp5wh/+UJgSqvcx?=
 =?us-ascii?Q?//5msC354JKKYScVG3O4kfJUJTPWdBoKYyyvQGe74vWf2NwDY9nAr7J7YxQV?=
 =?us-ascii?Q?+RxBdNymf3kE5JeixANODNkQnsuOHpY438ru94eK+vNtiOXCQll+faYcNrRj?=
 =?us-ascii?Q?oO+KJf0IuGp/JMe2ANJHQjtvxn8oumutn3X8Qp8gm6SaYJQpI+VqQJZRcCe/?=
 =?us-ascii?Q?qaQmCd2nEg5QjhXrjIYmCls9SfWdRRw2yXNHMO2OGalrWuqUG+3+rdpBk8kG?=
 =?us-ascii?Q?DFsrIltccLgK/IDYjNKYsjpzg8fPaXvf7i/gcU+wwzw5DEgtUWrNAJT+C7ln?=
 =?us-ascii?Q?wIF8g9V779O6JX4umIRoso6THbevX5jZwNT+n+F4+XNFYCXErcdJ3rGlc9yh?=
 =?us-ascii?Q?OeSFxBXD4JtXb55OyIeiYMMF6PQ/ADUL7wdBJewRh6RhM621df2hLt7AIcNZ?=
 =?us-ascii?Q?yXyI7hnPYy3K57xDyEwsE0iBmd5vE0fnndl9fe2gvxQbQ+rmasJ5nLmzgRoB?=
 =?us-ascii?Q?rli0yvtkBakRi8/aK3NahLBRgGqASLreEbM483zm8IaWMSeYCZRw4vemYjL4?=
 =?us-ascii?Q?9PYTpFpVRKkeNAxeRwrCBK1E8/ef572K09tM1gkthHPPTVgV2EkdGBrD6Sw4?=
 =?us-ascii?Q?6hZo3Eg9BYvTVJHG8/0pVrznr9J2wYCskSu4f8pc2cdNX0CBOdrLzrp1v/Hz?=
 =?us-ascii?Q?Dhsj6WpwaKMfGcDO7bIz4jUPTlP6Gbd8aBCGck/YKffAL8GpdAgJEvs4opfP?=
 =?us-ascii?Q?f+aKq7zOt+Sp9gZ1/EwKIx4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facf96b0-6199-4234-f1b0-08dc1ebbf2d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:12:56.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McmEZaiFgCXiWZVrYNaTsxB+WhzXJkPCU9hYFv6G0S3BfQ9QRjs6luWkMefs6jgu2pbHDNmmsGO9hRJJc6awOyXw+U0hoTqPr++023hLrxoXnwUuAq4DIdh+QVshWQw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7491

Tertiary match group was added to CMN-650 and newer implementations.
This patchset makes the parameters model specific to support properly
various models. Also, wp_config registers and filter groups numbers are
decoupled to enable the new match group.

Ilkka Koskinen (3):
  perf/arm-cmn: Decouple wp_config registers from filter group number
  perf/arm-cmn: Add support for model specific parameters
  perf/arm-cmn: Enable support for tertiary match group

 drivers/perf/arm-cmn.c | 118 ++++++++++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 26 deletions(-)

-- 
2.40.1


