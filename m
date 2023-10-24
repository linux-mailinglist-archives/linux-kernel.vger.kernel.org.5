Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4503C7D46E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjJXF2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXF2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:28:00 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09078E5;
        Mon, 23 Oct 2023 22:27:57 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O56CdN016449;
        Mon, 23 Oct 2023 22:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=GgdTh2oB2emLCoArAw
        kVenO7JEyih2rjUDHhGJFe9Eg=; b=euXwo59N5AhEVcyC4Hzef2tn8TcVZ10mXm
        WJAqO6z1E/U11ef3lpystnfyl9ff3gQ8zUYw8bLkvIQUclW2wGGCjm8h19ACsDkm
        Kwi8iI3iJdsPOs7NkNTfWrCu3LYqoL55rB2MAjkLcBq2JHiW3uZ23xqa9Yv26S5X
        gqngy+3sxwGs+WuaWcFhPpggZUdWablvjD1Kz1NV+dXsLpCHIM6GZY7IYKOwmxeU
        SN2nxbsyQrDcy25ypOy8jSH9vjaSw3EakZ59hx0A15JZUX4XAvLz4l5PB4Yihw2N
        wzwOHaERGFgbgdrHnz+T1NwcSvrE1RYOxgq26Pi1qH5udlylRmGQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv9x02q61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 22:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiiXw3WeEtMkFo2IL1gvj5Mkjf6T+1QCt4tlMQuC+VOHbRaJ4ugm9lLWYvRBk+z9KjamS+H93TbmDGLLxMx5JEd0hDb7upGLAC1bt6yszAChM6PmN1n8/sS9CfMyU7cDBEDFxJ+6lvK18Ha0sJpQQAMmk0jIcFx/jGGjRFB53lgVgxu0FmO5ODpbkZ8IqvVutgMXI2ZbTW92OoiYA4wbCSp249GbZQbvxc0Cn+Q/X1SNoTevwykamM5oUsIhxuaKvueJC7qy1vWSasMDfBSCTzM3ibEHATrO/usNohUYbrWg5fQYTOmpOUPK5mZ6hsbvpwITeszRdG6a+k8ZOen7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgdTh2oB2emLCoArAwkVenO7JEyih2rjUDHhGJFe9Eg=;
 b=J27dYTPKvuwdQHc0EXAsFtrDq1xMPwZgiPsToEo9n7ezigF03bzlAGrK1PNMIcUVTUPEp4vVF2Drypssjq95/nTw54Uj8JgyXlmAhOtIfvFZ/S9A705rgAlCOT4qjr0z1sH3APTztp9UV0eFmIU1yKq119oz/uSXU+DXxPBLDB3C6c3Fzadp5V85HvZ8mvv7V4wy+e1iru1ub0tzgr/DEp/O/t0jD2JrPKg7STYBc2FA6njj36Ncxidvef18gA6oP43s9PMcZ+ioElCShrXJOpCVFKNt3d+gya7xMIK0llflJorxSjOSSPAmLJlYge0K1OWJ4laFN+KCWdwKF0AIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 24 Oct
 2023 05:27:34 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::45f0:7e91:2172:3179]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::45f0:7e91:2172:3179%2]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 05:27:34 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     ming.qian@nxp.com, eagle.zhou@nxp.com, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: amphion: Move the blocking check_is_responsed() out of wait event loop
Date:   Tue, 24 Oct 2023 13:27:09 +0800
Message-Id: <20231024052709.2897714-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|SJ2PR11MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 85393b05-9065-4582-af0e-08dbd451ed47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utqJYwOvUBzqp0HGQl7WsLPXI5WWkQ0iJgqbD4pUJXEQeylBVgdpEsnplX/521wkN90GJyEV/mbZe2L1YeMhE1RxGLn5NZTQtQYKXNHJ32JXkpBFBAqIlPiHzMIbs0CBycioIK9vQNVyrdursICRcZH8DaV+460yxRAQAeuV8cJU0xuCgGAg2+8d9nrzcbz1nMjLQMN2WQy3vuxkZ71xf1UW9+IJcJeErlUHiHr3TtgZKa9QlflciKyvtqyUD+NiRhyBEF6c97w+nOHEaaE4dl+xKrNa9ez9vJRg/kgiqWFDI/dSRrteW95sJCnftHH/f1QigycnoWgzDcekPENvH2GaYIEMAh24wHIwlD8el/dDsozfnnJ1c2J6B+iVI/eolA5QjPaUHxVXpsc7M3etAAme5nRToTStWfWJ5BNTFeg7XmzUUlKECKTUnUlTqsUA8hMPZdT0ID1SCfFdhu5KFfICaFCmkEhxLDZjs/Hkq2eGoV5B9IB4GADC8U3FhpsrjfhNKvaIsWEL1iUt7fOhIkTKPQvZfnDVSwWepUKAJB6j9F549QOPoI/zFVeC+vs/FMVcI/o1Bne67Y5Rg9VAhE6Pj0QlBuoB0TnCadlDrU62IKfwNf/0SdYTUaXzr1t0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39850400004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(38350700005)(36756003)(26005)(86362001)(478600001)(41300700001)(2906002)(6486002)(44832011)(6666004)(38100700002)(1076003)(2616005)(52116002)(83380400001)(8936002)(316002)(66476007)(66556008)(5660300002)(4326008)(66946007)(8676002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zU8sDkW1/SZzEbBfo6AjmGhHxWB7LdJZt4e9FhqSwbyowoEbDqQUl3pyOA40?=
 =?us-ascii?Q?4Chh4xvSBRqrTm1TNm3p0U1OwtmvS4FyEKNolokslvhj3FDRQdKzm4tiGu3t?=
 =?us-ascii?Q?LOu38DDsyGLXXh1Q8DkYtqXdbV4TSy42eEeFkseFwANvjTHYktmfh1uLjiuU?=
 =?us-ascii?Q?zDYHRsbAyLKiV/ojF2jo9vfQkXPya0Q0g/AR50rXxQuSAbbGoWeafXxJTF5R?=
 =?us-ascii?Q?i35bg8rQdh04bWQHuu8XSXe2/Di8wTx2otC/zmfd7gDHmdanJB2CIWST+Jtm?=
 =?us-ascii?Q?kf5yJkli1uKDsFWEWaQ3AIhe+OFLyXClhupb2hX5D8GlXr3ZTUKiRZLjPz3G?=
 =?us-ascii?Q?qM1dQ8klv/1TIsti8dJvgzbYFefhc+AD/R3AHTFrX6U51FXVNl6C1RVrlhdI?=
 =?us-ascii?Q?prCBB7QgKAGGSa92yzUEy2qTUTHbvdcOWJ1NRpayP3MPePxAA824FoF68b1n?=
 =?us-ascii?Q?7z7yi97B49CKkpSdHtZK8jlSTVci96Qd7VlqmeqzkN2x/t10KHnzcVEEvsIW?=
 =?us-ascii?Q?JWSnKsCNFI9sJl/2/kpAz3wlMCYYOlZvksig94ShJijMVwfvvGbLEpAmFx0/?=
 =?us-ascii?Q?jzr67615uF74OS3vq+/6GHnGqYPibT1Qx8jVxtOVbEV5liEpUzIqHXqd4RzC?=
 =?us-ascii?Q?9JYc9PhQytAkVLHJ9YsHoyKoWQFnjaHfSU/loa567S4MnGO17WW3462B4T2Z?=
 =?us-ascii?Q?MEMKq2o7nDwkYTSH5j6EMq6fX3JXPihqWhHntgj4kKNEotXqtnZ3xmbFQawn?=
 =?us-ascii?Q?qoMcb8hQJx7rqfH8eD6xWqwIT8Hk4GrTB+5+EJJgRAObNFs3BbXQZz4AWS93?=
 =?us-ascii?Q?bH0O1LOMwFwdnYxUp76qk9el8tBsUiXGSGMHuGVniJkTMdy4v+kQeHvda7+b?=
 =?us-ascii?Q?5bj5WYo0cUv9JNnIuXyiXEFV1OGv74a1uUKxBJ498sVN68emop3n7N0sIcDA?=
 =?us-ascii?Q?Zkbk+igZWSLElugcZqSaLzb4XlzggMIG5fpuJK9txc9uXklPh6sL6MnZBKjs?=
 =?us-ascii?Q?xoNDXgHJScoKxNibFqoLE72caWYqLhfjicUsAPT3k8Q+jdwQxg/7ma6HosGf?=
 =?us-ascii?Q?F3C89KChrGYWx4GgFLiqXNz1DsbILO+1lXPV1xJlbpBE3QetdaK/+1sszM0t?=
 =?us-ascii?Q?CIwRCOK0978/ONd6BtpmBKCYrCpsxfNcjxR/KZG3eipxyDSewvNiQ13ghjyf?=
 =?us-ascii?Q?rJohcOPp25NnAqpcEzkzRb2NpmMLa/6djP7y7gnz6TmKHfhw9kE6JQ8hbVKI?=
 =?us-ascii?Q?SV6eH6juNyVKgCs7rsuls9dBKlWVyVdwKRPkWlr/HyMiJVMlfzAFv/c/DaDb?=
 =?us-ascii?Q?Smctqh/137zHLRvJq55h4vwOW4QWDD2xcbWciXA+j1t4Pl+DWSWiXCgelJkz?=
 =?us-ascii?Q?FFd1fryEvJ7UwTufO/Jn5cCg/2iXJ/0i3ZLXBZh6isGXRzKp9TwJ6zLqhoNf?=
 =?us-ascii?Q?9WOZtc54bSadwye17ViMQ66Hh/3XtrKEDIekapKSSDU1I0QHb7bo+vupo9rl?=
 =?us-ascii?Q?MJzlM8xo6UB3qgnoiMFDbpZ177WG1lKd2znqIBHuC5se/DPmZ7tjtrALUCye?=
 =?us-ascii?Q?Z8Vr8WXt7+XOcJU1FKF2KCTn2s0fI+kwDj0oU19a5airgjh6O3gUXxoXOiaD?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85393b05-9065-4582-af0e-08dbd451ed47
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 05:27:34.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUn18fKumkLVuil83VLc7GMv6zx5ypHk902gwpA7WJvw2i7guAQqUz+wi8Dl94jg82Au3PqzOJ/7QvgL33EFcf9tW/uoDbs49a1sT3U8gWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-Proofpoint-ORIG-GUID: iFbGE4I9Ha3GghAuaTG-slN8gMnLpkyP
X-Proofpoint-GUID: iFbGE4I9Ha3GghAuaTG-slN8gMnLpkyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310240045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blocking ops can't be used as a condition parameter of
wait_event_timeout(), otherwise we would get a warning like below:

 do not call blocking ops when !TASK_RUNNING; state=2
 WARNING: CPU: 5 PID: 741 at kernel/sched/core.c:9859 __might_sleep+0x80/0xa4
 CPU: 5 PID: 741 Comm: mxc_v4l2_vpu_te Tainted: G         C         6.1.55-yocto-standard #1
 Hardware name: Freescale i.MX8QM MEK (DT)
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __might_sleep+0x80/0xa4
 lr : __might_sleep+0x80/0xa4
 sp : ffffffc0123738a0
 x29: ffffffc0123738a0 x28: ffffffc009194c48 x27: ffffffc00bbc1050
 x26: ffffff8814b282f0 x25: ffffff8814b280d0 x24: ffffff8814b28080
 x23: 0000000000000001 x22: 0000000000000032 x21: ffffffc00bbc1000
 x20: 000000000000011b x19: ffffffc009324670 x18: 00000000fffffffd
 x17: 30303c5b20746120 x16: 74657320323d6574 x15: 617473203b474e49
 x14: 00058b5b8b9aa1f1 x13: ffffffc00903cda0 x12: 00000000d744fcc9
 x11: 000000000000001c x10: 00000000000009a0 x9 : ffffffc0090201f4
 x8 : ffffff8828245000 x7 : 0000000000000001 x6 : 0000000000000001
 x5 : 00000000410fd080 x4 : 0000000000000002 x3 : ffffff8815aab4c8
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8828244600
  Call trace:
  __might_sleep+0x80/0xa4
  mutex_lock+0x2c/0x80
  sync_session_response+0x110/0x310
  vpu_session_send_cmd+0x18c/0x244
  vpu_session_start+0x38/0x70
  vdec_start_session+0x1b4/0x3e0
  vpu_vb2_start_streaming+0xa0/0x1c4
  vb2_start_streaming+0x74/0x160
  vb2_core_qbuf+0x488/0x650
  vb2_qbuf+0x9c/0x100
  v4l2_m2m_qbuf+0x7c/0x224
  v4l2_m2m_ioctl_qbuf+0x20/0x2c
  v4l_qbuf+0x50/0x6c
  __video_do_ioctl+0x174/0x3f0
  video_usercopy+0x210/0x7cc
  video_ioctl2+0x20/0x30
  v4l2_ioctl+0x48/0x6c

It is not easy to convert the check_is_responsed() to a non-block
function. In order to fix this issue, use a unwinding implementation
of wait_event_timeout().

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

squash! media: amphion: Move the blocking check_is_responsed() out of wait event loop
---
 drivers/media/platform/amphion/vpu_cmds.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index c2337812573e..1abec8d9dad5 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -271,6 +271,7 @@ static bool check_is_responsed(struct vpu_inst *inst, unsigned long key)
 static int sync_session_response(struct vpu_inst *inst, unsigned long key, long timeout, int try)
 {
 	struct vpu_core *core;
+	struct wait_queue_entry wq_entry;
 
 	if (!inst || !inst->core)
 		return -EINVAL;
@@ -278,7 +279,19 @@ static int sync_session_response(struct vpu_inst *inst, unsigned long key, long
 	core = inst->core;
 
 	call_void_vop(inst, wait_prepare);
-	wait_event_timeout(core->ack_wq, check_is_responsed(inst, key), timeout);
+	init_wait_entry(&wq_entry, 0);
+	for (;;) {
+		if (check_is_responsed(inst, key))
+			break;
+
+		prepare_to_wait_event(&core->ack_wq, &wq_entry, TASK_UNINTERRUPTIBLE);
+
+		timeout = schedule_timeout(timeout);
+		if (!timeout)
+			break;
+	}
+
+	finish_wait(&core->ack_wq, &wq_entry);
 	call_void_vop(inst, wait_finish);
 
 	if (!check_is_responsed(inst, key)) {
-- 
2.25.1

