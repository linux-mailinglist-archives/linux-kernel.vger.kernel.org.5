Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB27D3C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjJWQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjJWQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B77610EA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRLI6FkfM/TdaI18u///YcnF0M0g1tIz0GvzM0xejITvTwaYIhkh/+mwTEOBeU0gvTiWJQSTt0jnelZEaLCcaZ9Q2VPV4oGKoyhvE4KqVyuh498Jl19lut+7cQyRawOyUR8Wx9Iu+DT50gXy2eIPKOM9kZQfAKWVH0JgrS1hwkBIzNAxQGDY37y/Omc7DnqDf46DyUgEpWXJTKC5dEmjduMBvtc4LaUTk4ILjtJfSge7u/bmUwYN10pb/9dK5/f+mGs/xap3KyIbwitgojhygMpVG+NOOBf+uJZfuAm5E9B5WMKA+aJdchc9L5IHzCC7TaChicD0G2twYbOVEVo3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxBwTfviefvCF4FZJghiatpkh63SM3ZApfysbHSxGKY=;
 b=SNnX29DqPMWWJ9x1Ds5XY/6Y5ps95vOjaahe6vSPe0wGM7Zlmbcql3s5IW8TEgkXJu42Ry+7iAl2uZtUbuVbxF6RAuuYVmmHr6AHZsDEwrPgKsAxQ4rBff0z6i59qZQf0TfhlE8t53ua+RiWURRKEPNY259vuGItGsJrW4/SwfYNX8CwbI3F33hkZfkyXbDTG9IRG5aCXGFK3FY6saxSCkeIecVyrFZHSSk/0JqP2a2meOrANJ2z4anAe2h3Xsnc7OdiEPhLv4B642QxppnLnjT4xOYjbo3v+2XUZ5yjyQojNA6DcyDyJbS2JWmzAGYcc9zhvENs7omtW5s5ZfV7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxBwTfviefvCF4FZJghiatpkh63SM3ZApfysbHSxGKY=;
 b=pbOcV8Av0KqKjZ5l+K+zgQjOsDMsYc4Vq1aB2o3MjVX2avT3yaZCu/SBJiXZIGGWNl/zF8JDHQFr8wHpctq69Yaz7vPQ5ww9INCPjHnMMv/spEugLKLdDpcOLw32T2Rw5VfnFTVCE1ogd2buW5liSZTdMYJ1GucalyYlSvl0w4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Mon, 23 Oct
 2023 16:17:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:17:26 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] i3c: master: svc: fix random hot join failure since timeout error
Date:   Mon, 23 Oct 2023 12:16:58 -0400
Message-Id: <20231023161658.3890811-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023161658.3890811-1-Frank.Li@nxp.com>
References: <20231023161658.3890811-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: b6aa3968-6fb1-4441-0e8e-08dbd3e38bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zCVGeih/1XImRLE1hl3BcOTxLhQr7KRepfcuRX6ha/BJfmXPe6bw94yaVdNh/u58eVxmV4gO2G7rKDVqAMvxFpUKBj3eSgcoLeiEfUb9PHpDPX/IRpktinvigrtFPYRTtV2pNLnJ4DpIJm8jT/75kSVYyNg+G0uBU8SDYSx9pjaufZB3NDDimrQl0UE4sz5bahXtmzhUssUsK2KUuNqV+lgP4qb4EQJikJYuOqWf09CMo4tyEv9/eEZXX9KAlGi9faKO6je22yyUbMUCfQF9huuuliR/C+bvuUqc1xTgJa6t5nr1pGEyn0Qh1/uuNHFl5TnaXVjM5OGgadqH46Z5pxDHB6py35jhv+4QfTiowwJOGp9NCNhZXHWOKlnJO6Vsoyc0mXOH31DtIZeTH+IigJB0UlYdirJuPu+wXcMP6axN5DzHA8CvWfOfqo2X1cCGhCro5XfuQbbckm61zZf/WecHG8cGPPyZAP4CGhnxTOBZYQ5Yhh8xPCGKd7AWBg0ohTxfYUCOS7rD54Rm5yyAwOcxJMu0v0JRjWX5mDNBdRPVj56v1zy2dQWHQFJ6C68dRHx5jQ9tnDAy84qlCJgseWS1pP3jm6bz9/+16q6BoED0Y2vxAD3uBd6YyyuEMJW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(6506007)(6512007)(6666004)(86362001)(316002)(41300700001)(6916009)(2906002)(6486002)(5660300002)(52116002)(36756003)(8676002)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(66946007)(38350700005)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFQxYnJHS1Y0T0c4Z3FyNklJeVptTUkrdU5QVVZIdmh5MEowbE4xdG9ZZGlR?=
 =?utf-8?B?Q2JOYmxLRkdIckZBbC9IWlJMQzVVaXFacUdsSjU0dTZzaHVzdGhmTlZoRFZ6?=
 =?utf-8?B?RkkwOS90Y01MRVk5ZjRHUHJyVUxyMnUwaEJ0NXhIRUlrUUNmR1IwQjBJdjZG?=
 =?utf-8?B?eC91M2xHd2JNT203eCtDUlFHQTgyUEFLM3ArcnhYd0JGWlY1Wk03Y3lpZnVB?=
 =?utf-8?B?a2VtWk5MdVkybVBsakJyN0E2Ykg1c25TWTFZeUwxRUJGa2ZOSTJZUExzWGw1?=
 =?utf-8?B?UTB1S2lGVkhGR0ZjNTZpR0creEpXTGFXbThubWVZZmRHb2Z4WFlXY3RobUhY?=
 =?utf-8?B?bEVKV09pSXpxbWNXQXVCWStldmFPZmVYSUNOQjRWY2F4TXFRNzMvSDVDbEdI?=
 =?utf-8?B?WWVTZGQzc3ViM0hiaDRCV25Ra25kSXFKc0hndGFTUHErRy93ZGNxa2ZYY3oz?=
 =?utf-8?B?VmM2ZDVsMWJCU0VLOEFMTWhnekh6UEVlTzBQVVl2MU5HNy9xWHVWYkxod3ND?=
 =?utf-8?B?dEpvQVhmSThsd0N6T0tPbXNWRGhUK21lZEVjOUlEQUErc3ZreU5ZWU1SZllX?=
 =?utf-8?B?STV4SXg0MGJiTE8rb01QYmM4Q1c1aTNMMlNZdzBRbFo4dDFHWUVSMDdab1ZC?=
 =?utf-8?B?bkRZYWUxMkkrbjlGSXBMN2lTMTZZdzY3dTJQTzlHYTk0eWQ3b0ZiVTVNd2ha?=
 =?utf-8?B?R0t1b1UwTHovWlVnSjlMQVdVVmJzOHlaVElyMHNLWEozQzlqSHdsREJnOGty?=
 =?utf-8?B?TmJCQkNKRGgvcTBkTVJ2SG85L3Q5bHRkaVF2emZvMmpLQjZVQnlxdnlmVFNN?=
 =?utf-8?B?QWZ1Z05TZTVmcHE2d3FvejIzSHpBQ0VKbjROT01rNmtSbzNOSSt1dmpDMUZX?=
 =?utf-8?B?SkZMUndaWksrTnFVbFUvUjBBQkpvendUV2RxbTRVMGVvNlVmQWtOa3E2T1l3?=
 =?utf-8?B?MDZxZncwQXk3dHNsOFJCUzBab1ZmRG9Od3M1NjdEVCtZQlJBODlhbGNFaHdG?=
 =?utf-8?B?ZC9adWJ2ZXFKYjhCZWl5TlFiUC9rQVJGQnJkM2tzZ1BwOXdhdmluUEwvTDZw?=
 =?utf-8?B?cWhpb2pOcUNwZGdGWkpOVEMwbmJiMmJTUmFFUllOQ0JmSTdKeGRmMHY5SG83?=
 =?utf-8?B?MC84eThLSERBeE03OGM3OUd4V1ovRzJUMDIvMTladExsVm1QTkRPZU8zY2ta?=
 =?utf-8?B?L1hpcmUxa3N0bTBKU1lDTjlvVE5KN0kxWEJBVjVlOW9JRHBadGNBQ2NRL1hk?=
 =?utf-8?B?MENaTzk2WHBzanU1VUFQQlZYeHRmUzFqVzIzM3d5TXpOY2hCZlVuRk84bWdp?=
 =?utf-8?B?VWxMRXlCZVk0YlhnZ1FVbjRhczNmZFpiNDNzMWFTR1Qrc1c3T2ltM0JlZ0JD?=
 =?utf-8?B?MFQ4aER3YVBUZlFFejlaZFdrOTlSaGE5cHM5STh0K2NnRGtxR3MyM0FCZGl1?=
 =?utf-8?B?VUlKbXhRczFzTnU0K01mOTNhN205QnRSV0VhZjE3WVZNU2tFSU96TWh4NGpm?=
 =?utf-8?B?elFGOWlFRUJCaDZ2Rjk4cWlKU1Y5WUFFd3FiRCtpaEF0QlZybm94OTRzaGdN?=
 =?utf-8?B?R3JYTkorRExRWnhmTUFsenNKTnBXK2xtVjRweDhPeGVyNGgvaXlSS1BXN1Fo?=
 =?utf-8?B?NDN0VkdIbG5MTlZQK0ZHOEhkWnVQL2l1d3graU1DR3Y0dlpwMDkxcHdobVNR?=
 =?utf-8?B?TSs3eXFkZ3NYN0Z3aG5CN281ME1GWjBJVXVxanRRRTY4elZwU3o2dHgwMXBV?=
 =?utf-8?B?QnF5WE1HU3JINkhwUXFsc3ByT2ZLQ3VhV0t5MnJpeVZIQmVMbTNIazYyWW02?=
 =?utf-8?B?RFNrOTFKWE0yNVVWcmhLZnp6dW1HWllFaVZHTGU3SUwyNndnWnBiYXpERjVt?=
 =?utf-8?B?K0UzMHVrVGV1bFdrTnVTejRwVXR4MTNOOHB2YnFHVjcwOG5yY0QrZ0NSV29O?=
 =?utf-8?B?M1g3eWtsUkJyYTl0bFZJMTNtcHhDNmZsYy9GUUw1Z3VuTzBIL1pMS2hyNy9L?=
 =?utf-8?B?Z3F4WVVaVVc5WUs1NTliK091NDBNZG1FUndOMllibGllcW1kOEY0dHlHbTZH?=
 =?utf-8?B?eHhObGtvV2graW1xcGxGM1BqMTh4N1ZRZitiUkNyMmFjNTAwdzJualdhTExh?=
 =?utf-8?Q?q5F6x5hc2oylmxOXC/lq8NzQ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aa3968-6fb1-4441-0e8e-08dbd3e38bc9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:26.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fv2aAifx1F2hnB4a9mY7Ky225TgNnfdoQNvWE8DzyfWWSXdNQy2obMMT08ujlHnYmFcBAsyMQlKzPObKwtOM2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

master side report:
  silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000

BIT 20: TIMEOUT error
  The module has stalled too long in a frame. This happens when:
  - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
middle of a message,
  - No STOP was issued and between messages,
  - IBI manual is used and no decision was made.
  The maximum stall period is 100 μs.

This can be considered as being just a warning as the system IRQ latency
can easily be greater than 100us.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - fixed missed update commit message
     Add dev_dbg for TIMEOUT case
     This can be considered as being just a warning as the system IRQ latency
    can easily be greater than 100us.
    
    Change from v2 to v3
    - remove 10k at commit message
    
    Change from v1 to v2
    -none
    
    Change from v1 to v2
    -none
    
    Change from v2 to v3
    - remove 10k at commit message
    
    Change from v1 to v2
    -none
    
    Change from v1 to v2
    -none

 drivers/i3c/master/svc-i3c-master.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1a57fdebaa26d..6b6bdd163af4f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -93,6 +93,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
 #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
@@ -226,6 +227,14 @@ static bool svc_i3c_master_error(struct svc_i3c_master *master)
 	if (SVC_I3C_MSTATUS_ERRWARN(mstatus)) {
 		merrwarn = readl(master->regs + SVC_I3C_MERRWARN);
 		writel(merrwarn, master->regs + SVC_I3C_MERRWARN);
+
+		/* Ignore timeout error */
+		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT) {
+			dev_dbg(master->dev, "Warning condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
+				mstatus, merrwarn);
+			return false;
+		}
+
 		dev_err(master->dev,
 			"Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
 			mstatus, merrwarn);
-- 
2.34.1

