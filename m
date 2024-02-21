Return-Path: <linux-kernel+bounces-74674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD8685D78D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51151F221CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32934D5A1;
	Wed, 21 Feb 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VFzsh2Zq"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C184D584
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516903; cv=fail; b=YHloGD4obsqZcvd3CbkZUJWsgbzFnpGI9tL2XQNMU0QKO0Es0rpqudPPGr4HbE90dbnyGWsvtC8XRKDyktZ1CDaq3cXgiXXal9SdZZxmMMsn+FhqeZ9aRaGC2+HiObr/xmS3pBTDdrGsCUtqCVLh/ohBiCtqs8bjZpkfYolDr2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516903; c=relaxed/simple;
	bh=GH2QC/yVstH3azlM0UxA1ZNE3TRf/UzPAF129l1Q/bI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a1ZQWOerct/auaJ9agM2vDdEzB4oNYWLUyFksIm29DxlFDRraz4AzQyg+Mq1737qPQDKCp2kkDl0angrdU0me/bI+ABeagFYp1u+O8ExuEEPjkplDZh+G1Wl+xPOB8ry59UsRRYhLy79oYHYaUcuCaup0K93VRlbXUePQpU2P70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VFzsh2Zq; arc=fail smtp.client-ip=40.107.14.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJV4HnxLGQLh5f6BIbqzFlDSN2MX9axX9apnG0zsWAi3rmknmhBhLhXoK2qfOLA1hvr0f+a/HWwlRdmz3j87bojM7mUkAqGky4wnhiSMdTPTUGZDxyReRc2p+1F+VvEH1/uEwgWWPP4yd68d0SP0DVzy5nYq71Uk9nJIGBxF7oKKUHgULF6Gyw+I0AHugREfrvQPq4m9CZ5gXJml6fEmU604VpKnab8fBUqwZNqbkGmcmDEPELivSmL5V+d4TgOQ4FbfRw4YigUtlrqYhYaphkk6V3dEi+ecfnj1O8pEWsxhf7t5GjEpATRJK2FLC9oFc6FDlqym8ZirbP6rBEnf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YguBz4Hf876gUChm4lAXaP3JhfZAhuBev++IF6YNf68=;
 b=imz4cDtRvP9etGiBEOYd+oROaPsNZCALoSwmgrzTGR4YY/fVRYu+3cxgsLyss0wCPdqhMUDf/QpmnYWEwpWOXhYRp6u7aC4cWws16+ZM6hUNxJK7RXw7FQXYCErfcmcUYm9kOqS2nKsppg0NrQQ28y5vUiQX1CjU8npA7/ehQOJZZjZfUiFeX5+t+nw7ZrpLDw53FLzJM78d7xe5lSLr6TQs9hnNmjGPzTis5V43Ai4LQL12+CVwbnbAVwPX/7c9fzv0EOM0YBOmNXLaLbK/pHePiKPyu86GnW24k1t9Q0pdpNEb+oZ5aWU6DsymHSJDLvZEQzhgmJxyGIkkiO/j3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YguBz4Hf876gUChm4lAXaP3JhfZAhuBev++IF6YNf68=;
 b=VFzsh2ZqFLSnSXTRfE/Ar224Zkf9B1ym5PMlnEcaVq+Ev3KXmjSWMKquRXbEFRoTm9991K8Ji+yLVool0Gz67Gm8wUxnUpqnq3l56Tod71IUV7WPtrtulYwiH9nAYdMNjmK6SKsmCIlt6V3E6UQjz/o98f3wMJliOoHQTuHBq3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DB9PR04MB8395.eurprd04.prod.outlook.com (2603:10a6:10:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 12:01:37 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 12:01:37 +0000
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Chester Lin <chester62515@gmail.com>,
	krzysztof.kozlowski+dt@linaro.org,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	soc@kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Subject: [PATCH 0/1] MAINTAINERS: Add S32G SoC maintainer
Date: Wed, 21 Feb 2024 14:01:21 +0200
Message-ID: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0016.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::28) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DB9PR04MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 1821f7db-704f-4192-0425-08dc32d4db4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OAVkVsb3kymS3cdwdaYGI3CT8o3yqNxO2GuCNvtCZbBE87ji9WIOuFZIqYJKFpyrytxWyA7jJ9l3ugdxbzXICod0fpIGZeLusbYEPUC6n26jEX/h9PQyKVaFB44+QRIm7gPHq6VTSDXbW84iCtKKcG25wWff0Y3PEwRxA7qgXoipgACA5s5QP9lyQ0ijVwvlq1nMMTLCDPWLkAOlNWLhsOsqt394g9FsxO1Cx7vPHZlyroIcPQA3o6AmptTGbFxudaD+Dosn9nyxgzahrxVtyA65JQjstCGRJOYcQ52t7WjrUhTJSwKa6TLTvpfjwVFCQfV0R8Y/FDpBYwY+/b49TL4NIody0+/CeHIxY/FMnqs0t9xVvw6CqsJ1JgV5NPMEzrmfZxDYs//SaI4gTFQTrVyLgq5RcpepMOewciP+GPIK2nKsH32DvyCWSAtmtqvnwwKUeOcEk0rtxKHieUlLrtEiR6I0fN6W/lDolYNODfv/lXYsLmMIp6+RgIx8HJua/22usSDBXm1Rr4+wSxIiDEyz6F9Q2jN80coORreKKIIi+TnoteoFDXsMoDm41PT7LPbEc7Flwfp/OO4x5fo+pbdsN/69dezeTVl5Zf7g1UstmvbDUGMHGdfoxJiJ6a6e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?evrOlVuM6EpvPhGDvucYXUiokNSJwwsBvvVcmNe38U2IOcCLeNjfreGJdKwq?=
 =?us-ascii?Q?yDaH64hNCuTVjMwZ+/QVMGR+HsJTfDPNKC7f9EfREakcjp2jfz1MKgqZkNb7?=
 =?us-ascii?Q?A3hlBUZfpqid4DfuZ6mTC8aggIXRJ6+I3eb+IDOzxc5Yd1tounEF1l8vln/C?=
 =?us-ascii?Q?n+U8eP5RP81bXkIJSLGZVdBK2DEHs4U5EoiXQSwPIcSmGN09H+roWblhlS5w?=
 =?us-ascii?Q?wngGs8GlzFMgnHROhvSnfoqxOZfV1TALnI1bkPm+vDwBdRpKRl8sCmwWlvcW?=
 =?us-ascii?Q?Mq0GqHsLW5qQpoIsNeAeQ8rJfpCIPoKAV0I+w/6wrWnxND2IIquwz7DHYM4F?=
 =?us-ascii?Q?qMb+BL0mOXTRjw/ekF+fJ8sxKuiTtIjYK/4R2vvujh3UgdRn8Nux62bg+FVb?=
 =?us-ascii?Q?AcbDjtG5qEmU9FwCGGY6jmRS2OhMlDh0ZseWv/Vj+EqytCr4t+gRftL+f396?=
 =?us-ascii?Q?Fp5ESkY1rYtzRndzk5iPKXSFbXd+ra0r2lXGJwfNYGPrCa4CqzRpXkfKcyGZ?=
 =?us-ascii?Q?NoYldBSzCyu5ANvZP5h9QvzWzq+DQJNuSHYykoqNY1aOn2qDIQltFotaVDAA?=
 =?us-ascii?Q?BuBT18w0mH4nl8dw1w8G+X4YSVQiTzgKFN1e5KhwaaoFcq5smSxyGbRFvrE9?=
 =?us-ascii?Q?lsrX5IjbiXtErRaZfxFRzRrDKPKR+Tn4eqmFDOredIJ1jwjTCIbLF2D8UVKI?=
 =?us-ascii?Q?cNT4d2ZuHMIdfnur54HY02IDV3+DnW6pOACr9tSYcRpcmTKyBlmAU6SMb73R?=
 =?us-ascii?Q?9O5nKVvrlOPbx6grAOwdyWOoiHxWgtt87yjaFdCp8jmIGkJK3DFA7X7xsdjc?=
 =?us-ascii?Q?7MG/DhoM207DOnVrRbYBfFNS7Mh40SC2mQk53pijXhLzdyOryRsTlT4uhgAZ?=
 =?us-ascii?Q?ujWdWdWZgWi3mEW3frcM6VR/HOxL01nIZFJpowxsIlTMFbyU6xlnd3r96QHh?=
 =?us-ascii?Q?G+gFpAQxNdZWB3SkGF6573j7A4RnMsd8eEz2JlYKn4B7TSgWVemC1FssZdg9?=
 =?us-ascii?Q?BCHQVb9vAYF05Gqmk+rPGcGaTQOfrcKnP/9bb1DBVIV0REcOWF9tKZXi4kR3?=
 =?us-ascii?Q?Y0ScuicMZmwQzmj6qyYkijSbHEw7q08x5AFEkLJTKiSO2xgGdr1qjDCXEpbK?=
 =?us-ascii?Q?Tseeckwtt3Cq4/S3HGWHhZ/lWgsapPBvB5uDDKOHWnjB/edZ258DsspAB55l?=
 =?us-ascii?Q?pCl8s4YihTCLF5w3yRjDf7LXFKf5pUFuZ48zFC0XWCulZXgY77H/C39hWdox?=
 =?us-ascii?Q?GHd7VFRwwb4n/BamYrbno1q2xr1LMA1dCitTeyqiZ3L5zlH3lRLFGIp0tjX/?=
 =?us-ascii?Q?mT7/TMR1yexOdZvXgBq909wTBfr/H/4lKMCno8HmG2SXEI16LVamSJdce/gk?=
 =?us-ascii?Q?deo2Bju8wJ6CiqiM+pGhEnF1zdo3ZxYl7Yfb+votTYaBmb3hfob5NA2ZNWiM?=
 =?us-ascii?Q?p5JqgUwJTiWuCpWLAncWOawpEPq4YdXjlRCH9IbJoFNsPc91fieq97+XSFb9?=
 =?us-ascii?Q?SJBy1Gnx3/aC970lfRaG5fH+i4XUgex+R3vS9h37sbLeFJUfJB4/BGQdy5Qi?=
 =?us-ascii?Q?6HbBqR9BEWLYCsLlABUxXIxmdZtr2F87hfyGh8Ew1P5TaGtkmnYYiS8TIGC6?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1821f7db-704f-4192-0425-08dc32d4db4e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:01:37.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWd95QbOGohgEABws+aKVDzWClp/A1CZGnZ8XKx2Ok0N5BShnsiks262/tOwMimio5lGB1Q0ST72W78TLSfpFh1euO41R2XWBDzRLev+M14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8395

Add myself as co-maintainer for the S32G platform alongside Chester Lin, as I am
directly involved in developing and maintaining the downstream version of the
kernel and Linux BSP for this platform.

Ghennadi Procopciuc (1):
  MAINTAINERS: Add maintainer for NXP S32G boards

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.2


