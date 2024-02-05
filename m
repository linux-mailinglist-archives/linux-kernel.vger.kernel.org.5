Return-Path: <linux-kernel+bounces-52196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD36849539
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDDD281954
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F6111BA;
	Mon,  5 Feb 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bb2sXaLd"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D911197;
	Mon,  5 Feb 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121118; cv=fail; b=tFTLxJL9g9UDTmPBzx5d1bPJYBgerAX0Z7FT2SlPPayVXAtEdwHWJuCtt3oGbDgBKcuIhF/A2yhIi4cbLzXVtwY0FCXwhmLcC9w2poYwojwmNQyFUmKms0WqOVq6Eh4g2M3gVALexJqiwjE/yHk7ydT9A3pTUxDPFh3l208QazY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121118; c=relaxed/simple;
	bh=JwozA0fbSbA9PLEoExyCvT4M+DA5wwqpsde2QD7mK70=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XLf4gVYC/3R0lIphVX+NT75WWVd28JgPQ1eMtnCUrgAEB040Lr/F73ZNnREXu8sDx/9GJvNo1vb1TRg8or6H86kOCBgkVn7fJnB5Tkqh+Z/g/39kTKSoVZmenQEDVoiCgtVNYGhgel/fNvs8x3kJmDY5Rm0ZOL2TEcjNd61cJ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bb2sXaLd; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAlfzETNB5EWblH/ltqDhw9U5/vdMR8A2BeJI25mG1whTiPPqldG557H/GOga/oJ8jTmZneGilj+zYKQNHB//37gz4rDrDtM+Eo4lm64CgqbUW2kU+ooYUCKReDrIAsKy4OfX3RGTHCPDIcrNZZsKFKaGceL8jmzX5nqv5dn6JO+VnUeU2DZm0Yoj0Omd3JOJz96RS6D7OVRa1vz33WTCXxTdl/uE6QujfrRtJ5IfOp7fAJOMey4sK4RJQ0tlatUulKP3582lEgAVcMHUytWqxch8v7IkucO5wZoGibdVAFe14wzH5iD5p4NfmYI7/+bvc6Cha9dEdcZTT+Zme7sNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsRBR07gHP4WmhuQdYdz9Nb61+qLx2rPwd4fDCBybDg=;
 b=Qlksl/8EHfEf8onSZV94KlLrCu9xcPhNDSJ0Z4xVFJ/KDXKxRPULbvatukuVk2cOlzXjhvCn7QQmt9cLyC6XYuhT8oBUhea6avfj9jr1cEY5M1pt+m9K/c5dYhMBYdgnLzp6jB0JvMIJHYt1ZBD2/6nzyRdtjzU9Rc1B6K3k2hEAH4y1r+Tvwd//H4R8sqvLtla2SZcqYZ8AnqDSmuc7T4DZJrSG9JAt72a/p7NpwRHj2VzcxeLqEyLQ1dHkmsTsv0JeAPXUWj/QJuoIDc0dME+4eyjNr9pdCUUVda3Lv6gFwZH2XVKdTEinqLtpxrX+ROrJSlvVXx3WBk6kFP9G+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsRBR07gHP4WmhuQdYdz9Nb61+qLx2rPwd4fDCBybDg=;
 b=Bb2sXaLdmSBMkvYTv9y+8YhrTQWZLEtqXjErCN7awCmD7AHfTcEBEXRngSm7AyN/ortZ7dv8B+NyiX/5ZCehmTqUJll51JrsMytkjwZ5EjhxCgFs+8jTzTJ49GCOT9IAwS0UAor8i2wjNlusn2rZTstUmNzeVSzGfBz/kgvqzjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 08:18:34 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::1a48:b74b:ee2c:d2e7]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::1a48:b74b:ee2c:d2e7%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 08:18:34 +0000
From: Ming Qian <ming.qian@nxp.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org,
	robh+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	xiahong.bao@nxp.com,
	eagle.zhou@nxp.com,
	tao.jiang_2@nxp.com,
	ming.qian@oss.nxp.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: Abort vpu parsing directly in seek
Date: Mon,  5 Feb 2024 17:17:58 +0900
Message-ID: <20240205081758.923878-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.43.0-rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f8bae5-fe53-44d3-58db-08dc26230b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rZ7hw/TNcw6PLAXk/RdPcH9SEsXRi7bZkpCghZZhk/YQaDz9HbldMMyyvxBPkvRXUJdUQos/kmHonZEX9ib+WlxFLvSZvmk7+ZH85BbKqME3zsVSaeCPn/2YyZ22nJs9gUO9iXD2drL6qwxkX9wsITtE6eg2T0mceUNY8bF94gbIhFFg6iwMg33Ys/JmiSF+zmk6ATf/zIc0VUqxKa17F4WRidJFX+y1Yd1hPH4VQHORZYGV+tB0bB/8u0aVM4FUqTtR8L3WGBCDF+fkWStPfVky0VaOn12dS6SSvx63IxD0KSyoxBW6zJBnSOyxvWfgud4svg8VQxj7mwv6MBMRbPHlfWOR5mnNMOdc9kpALpSI8XDbizamK21EYXbvQSdug0RU0JzBgrzVqqwxNuUpARRbK1stVyv/2J3KZ8w2EGhSG/rW6BBCqP3pB/YC8qWjg/NuNrQQgdId+SWwaUI/5Vgwg6VTcs5WOkpvDFa+f5UEU9SnjBZoUnExgtX97uONUkbKpnuwvIjMHvjVNeAJD5q7F5xTz2y8AeD4FdVM+oO8MJf9WCbqBgie4NlItiMX/BynIr4gu9tHhaBSQolPE6l3ZO6ud2FqBT8S8p40j4SfVbLNY6c2PuHhWyvmkAvF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52116002)(38350700005)(478600001)(6666004)(6506007)(6486002)(86362001)(44832011)(38100700002)(5660300002)(66556008)(41300700001)(2906002)(7416002)(66476007)(66946007)(2616005)(316002)(36756003)(1076003)(6512007)(8936002)(8676002)(83380400001)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MNjvrkQxpDQ3byx6ohAlu/r3/bKR1Itk/9RptXvRz3x5sZkHSB+unJsSXUa2?=
 =?us-ascii?Q?2TukAQA8oM9BcEgJ+qkFwabzPFll+v/uPUMB+3FDludUDJQhSAQxqA3qZEo+?=
 =?us-ascii?Q?nuTw6WkYm2XkduNfr4p3IUbECOqVWuOWlblAHn4S3rrRAcb9vu0cZXbL/etK?=
 =?us-ascii?Q?JnercB+ZwGj1E8H7ss4cdfATjDfJDcaVo0FgFClcQ/HaHZvEPxghaKhEOwnL?=
 =?us-ascii?Q?kI6HiIya/nsz1GN9eWq4N97e1NaMtUxfoBysfkt0MrrEHGFipp24Wwn4QdbY?=
 =?us-ascii?Q?AhfRdhMEqB5J6kXuK+DmhcKSTkLrrg0ZNtC7eGAJyQ6OH+l34NBo70JDXpqG?=
 =?us-ascii?Q?Ck3whi1z22pLSIvvvGvhCxB6Gi0Uufirjoyd1zF7Hv1S+zpjNY80d+Npnzw1?=
 =?us-ascii?Q?Pf9v5+GZ4zYddSI3mLz1cIPndXuddrtgyvPcaEEC+Dj1oWpVtg+iqIEW6FbZ?=
 =?us-ascii?Q?6QTsvSNn6NLQfibSlb0c7zQ7Dw13aHnotIJ4UUVkNOCTmnbCroJ2kDgajIn4?=
 =?us-ascii?Q?HDbErH/LbQBmUsOnlveEX/kGPRogEupc2MvLO1WhvYPakrOdl4LBzrxrg05R?=
 =?us-ascii?Q?nnSqkmcbV1SfbBCvAfUDpi5cparWvGtDabazIaeVEMdh8B1CUZuA/k+yDPWf?=
 =?us-ascii?Q?W+b3tLUuzuHxi1snJ1lSS4alDk4HOjRXo1q5ECjv0lm7xLUILCDdkHkO4Lxg?=
 =?us-ascii?Q?xxK9YSMzn4lD+qem8wguqjmZ+Utm03ksy8pIggfwGqD8jwG7IEJgKp0f4y//?=
 =?us-ascii?Q?IwsA3kfT+EFTq1vGjFeGvzRDmpGQGToB0JR9Ut3IHwouj3GKEVYUPkF0foY2?=
 =?us-ascii?Q?7nCOTMRNcLX94Ad1ZHI5te3vAwR9RtKF61ycWf9saiARuJ6MtlSg0VB99aHD?=
 =?us-ascii?Q?vgOp5bPOTvGBjPaAeZcTA26nrvSjSWfVviYP23Q6urKIEED5mCIVUJPCIjYC?=
 =?us-ascii?Q?4U3RZu5LML7tKvzOyClPt/l/RAhk9Ex9bFBNZCCc+1PrcV4RXl7H9sgknTdF?=
 =?us-ascii?Q?tIwhhRN+Z6MRUrawsAqGEt6gVtxd6WBTRuN8J1JSFtoCZf5WJwHgbOp+8Ltj?=
 =?us-ascii?Q?E7wf8muRDiFZafXmL2HfQkgjUh99HLBCUgfcgBMOFvNj1xApmv8EQdW21+rT?=
 =?us-ascii?Q?nVysaORW8bSqXuwLooSYN64fswEx37elvV0LuokQ8JD8ko7NHnvNkU3mTTkn?=
 =?us-ascii?Q?M2QmoSuAmmejlrKT29AN2qIJxCdK+HciFEprSo4u8CypRORulzxEz++Equge?=
 =?us-ascii?Q?3/tj1TehyNT0zo3IojWf5up3NQDRduz09Hg+qIaEaCr7KmdWKq5mfoNryPO4?=
 =?us-ascii?Q?0QUY/81+kpilENNAiqxyPc9ipnJfFVgXVERgdbgBjtXptK1Znze5DzACRngr?=
 =?us-ascii?Q?u+LQmBKCEM8GtieK56T4Igz6fyrK/vNkc9Os2rnfBBmuE9xCg+3dwVNC/kk3?=
 =?us-ascii?Q?/RQMNLFgPJ0c3hS4IWUwhtfwXOIkqE7fSOGSPH+ZUTiVwrozaVbebPnQo3ka?=
 =?us-ascii?Q?0JtpbkS/gpXgkcXEPMIkebl5/xf5p+4wRvAYbEFeOqielEXQo1yI7hUFtFHH?=
 =?us-ascii?Q?dxNmahZVrkoXv7HvMr2tAL0C7b0wTRhjO9yMWyCl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f8bae5-fe53-44d3-58db-08dc26230b82
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 08:18:34.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6Bm1VU5B6jlZLCcMzTwa4EHZtwirYNld6dlV2pep/UiC8p+vCOhKCkub1G81ASMTsea813goqbeVXVkq2Lqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803

Driver abort vpu decoding when both output and capture queues are off,
but if seek in parsing the sequence header, driver may miss aborting the
parsing. so just abort the vpu parsing directly in seek.

Meanwhile if capture is off unexpectedly, we still need to abort the
decoding and return capture buffers.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 133d77d1ea0c..a57f9f4f3b87 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -1595,9 +1595,11 @@ static int vdec_stop_session(struct vpu_inst *inst, u32 type)
 	if (V4L2_TYPE_IS_OUTPUT(type)) {
 		vdec_update_state(inst, VPU_CODEC_STATE_SEEK, 0);
 		vdec->drain = 0;
+		vdec_abort(inst);
 	} else {
 		if (inst->state != VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE) {
-			vdec_abort(inst);
+			if (vb2_is_streaming(v4l2_m2m_get_src_vq(inst->fh.m2m_ctx)))
+				vdec_abort(inst);
 			vdec->eos_received = 0;
 		}
 		vdec_clear_slots(inst);
-- 
2.43.0-rc1


