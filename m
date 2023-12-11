Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8082E80D071
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbjLKQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjLKQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:03:57 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2076.outbound.protection.outlook.com [40.107.222.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305944496;
        Mon, 11 Dec 2023 08:02:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jdw14UWCwkDMN17hAY4t3ekc2aFwB2u1n9G2BURHmiUOUbY9J/le7QGnkHQeQkimqiTLSgaiIBhqCmfgBDXLg3yP/+unfHXDd3liGPQhCpcLR2vXurrxjoBdAsCv6D4KgPVPs1rrU7ycgjZCQqO0mrUGGXjwiEWJ6s2RUj44P5Lz/qds2sO1e64LqKAlzOlDeZik5UdPjoReMp2EBSCtaTOHllK80aJO1m3EuIEWsUJVJnDFXn1o9NlT9vk96+QatNcxz+PwmcFfedd1DFW8b0F+nhOzS8JHLBz8M+NTlN/1yrp5OBw/jyq+nmjtMXLw0LchsQ4BB60KJ+jyNRn5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXCuKq2aEipcXMxO5N7fW37qXF/k6g8FxLkPkM3ea/M=;
 b=lbjVsmeEFtISrsngrIH7WHWtVg1RIEfLMejlAD32yasmpSReNzYcf+lP/KUbEwGaxqmES3N+qLh/aIydDsaHe9Tf7TuhuTylgBKqz5htHoc+48yvW42AjqYBh86QQNepTLrlUBPj20/Ltbm2P917Qvqku2CIj1ZMj8/hd8lYJfHWGa3W6WTUMyFi6/lJdAKQh+/cR02XKIMP9yedkLoNFPQyAskW60N9Yk0jBL+L+u1tXEMBumHDlf9Gt5y7Wa52maqxBH0iC4XCer/GI4lK98Kw95QvuvzTkzKBgwIo97PbIXAWgQ/w14Ykxb7Gg3Ntw6GJiLW32co3CIW/yGAaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:31::9)
 by PNXPR01MB6786.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:02:45 +0000
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::eb15:266a:cd6a:e0f1]) by MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::eb15:266a:cd6a:e0f1%7]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 16:02:45 +0000
From:   Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To:     agross@kernel.org, andersson@kernel.org
Cc:     hardevsinh.palaniya@siliconsignals.io,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: glink: Fix buffer overflow
Date:   Mon, 11 Dec 2023 21:32:20 +0530
Message-Id: <20231211160221.2843339-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:31::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB7145:EE_|PNXPR01MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e6ed76-8018-4cd6-e85a-08dbfa629d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0KnjL29GRnaJcCUbIr2wiZKt0D9GEeJQKM/z/sPRWgvjlUgVEmzJP/AcR0UyMFrwkm1E+lDAgydF0USLMTCQziNtipaCMlgwrkZLD45wtDi9IYq++VDNG480aO5cbxYz3bL2uyR08ctDkOwWRqCAx3EVm4IGSxmHGUj/F55FL9kKghM1O9v8vLsZR2tG54Z4vMbj5Wb8LxJhZEgc5BHgCs+OXdrVucY1Vz3EM8OR3EO0VOIxHOvIMOItHsrqCWhcjsMy/pxn/gUWwBeI7g2c8VNfWhXfZhJUu3v4z1opAjHDSka9C2w748pZ5bI8wGR80fz2nVHHWDHC82H6W+rRZo9Sf7qUrdAkUmifmNHzi49ReXYOnvO5V7+JXeBK+mt96IO73yO12jzVz9OxTyJDKKxUpcRf+e1v5lwJw7z4+c200c8CGCHCnVEzsp0tNdip1O6zlA8QerNm7Hg+ztSxyeZbFAr93QYzulwPjigLiYa9o9clgQhUIvtObn3AKQTUD2L1+UkWybRXsqrI4barMwxOkkHPrvIYthlbUQ6h1YlDwR6sPLClZ8YGpH4VXSA/urLjuC/wCZnRf9S3ILP/+cKrktl3e+pDZR0a5Ms3gMwM1vTLiCs+sHt2yOgKRWP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39830400003)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(1076003)(6512007)(2616005)(26005)(6486002)(478600001)(52116002)(6666004)(6506007)(41300700001)(4744005)(5660300002)(44832011)(2906002)(54906003)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(38100700002)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oqDLGel4uYTYONAeYXmXVzD9dGmrFiZCj+mdq5GpbpLtx0RQG5VYw2mbySn5?=
 =?us-ascii?Q?neWPg7dxsACorTyFWWaVL/3h4TAPQsnBIwFiALjebcDZHcu0llUb8JCKu3St?=
 =?us-ascii?Q?l9ivv6qoz3sISC2t/gvyGxuraILyv8ejBue4VEYhfXHPkHmaP4a0obUzbNnw?=
 =?us-ascii?Q?xDnnx7OdT/iFGqSPgPSpGXfQLzUIcCIP/c2ETJLwpbemdz421Gy+G3+bzeNr?=
 =?us-ascii?Q?c4iP+ryvKNzvVHbVyyzGy845dhl0sO0h4RPFMK8hQ+doZfnp89lSTjgk02bC?=
 =?us-ascii?Q?Ioq3D7/xiZ2sB36izgqKQ/vaiMJu/GSmuQuJeZ9IgAjgTerPZC8XzXORcGpj?=
 =?us-ascii?Q?w/R1v2as07i5xbMaw4JpFaWO7pQbH2BtMLzT8ZH5H/X8iIJVpyRz5ImY532Y?=
 =?us-ascii?Q?QTeqYrgujBuOt+ufE2hv/6SZ1lTr8T59TNSQhj+FWxqonRUrzxiYgxZ15v8h?=
 =?us-ascii?Q?yIzjhma1y1MSXToRraB2Yejq9mFTP/MMnTo1nVYyDRy+3DPBdQ8/hjxn9JDj?=
 =?us-ascii?Q?KnaYnS5hOlrXeCKhR9WySZNNiZmIBk15l/m1PmAM8NDCCgLxHfSdWaM6duvo?=
 =?us-ascii?Q?bhMo9b1WE/FePkCkwLiUX513LaWR4ZJHkaagNnsZISRzcgbH+E3HKMrduFA9?=
 =?us-ascii?Q?jKmeyOmdyi2gy0rIyEUxSXccga2Hvpm/VGYkVaYpM3no3MquIjgID1vyZ+xH?=
 =?us-ascii?Q?9TYEOgM7hdBHX8P3SWqLYH4Gt5pknRmEXU3eOmdLGb5eMCsHGG1nicWht4kx?=
 =?us-ascii?Q?2k8/A+Aohqtjh2wqjRZxUGg1RYHzyzEjek6/FHZyjsAATKox45nQf3JzKfLn?=
 =?us-ascii?Q?MS+GUeipJqJQoxg+BVC8ibTvh5/uaBg8rbNyvVmXoGIJ3+D4StRTB06MLLOp?=
 =?us-ascii?Q?01koEnp21wHsA3UDSuNZbKe52JPEGEPsylPpBa2BMtMkG4xrIJNyZAQZmkdY?=
 =?us-ascii?Q?EAhXBY6DFXfdObMeeEtpatjXsjZxrbW6p+VfMAuk5+DqY6Ijvsx6cGckCJfd?=
 =?us-ascii?Q?DnEZkBagpZdDVAiZfsbqCpUMaHiu+19Q1qNp7/YTdYT9ddzEtnzbXzXuUoNo?=
 =?us-ascii?Q?+gzd5MlR9pXy7HHui6J291nEdlueqAti0psW1F+N5hrmBiEmsM4A7KJK81IH?=
 =?us-ascii?Q?7aseSdrA+uuNABpRA5Dt0sOUmWGGu0lmEA17xfa45rfK47VTADNJALjIb6rF?=
 =?us-ascii?Q?VlxZgNYKkYq57eKzkj7DwO0x/u38KyTB4t4vNal1IYgWCkEu74eH9R7dbShV?=
 =?us-ascii?Q?YD8y/tRuuuAX+iBR3gp5jXSw0S5EnwuLvxKwKDbMrCegGU5y4aEFSsZNKYlP?=
 =?us-ascii?Q?d8lcSwsaPtj3AY8J2aGw84Sew+KEEmqt8oJmD4dboGkMgGhFoiZwldY7m6LO?=
 =?us-ascii?Q?J+meLl8xmVL4MQjJdmTMNiNTkHdkk2H47mGP9pMxawDD13e3tRupGmTeKYCF?=
 =?us-ascii?Q?pN9hMylV6FgmSqN95nYZ3dGU6T8OXgT0YT0rlmSbcIu4GWTV6C6if/6riN4P?=
 =?us-ascii?Q?al0KDP9z6Q0bHgW+6QqpOmfJpEMebXeSwMJkSCzgizBT9J/pDLmWWhiFL4Kb?=
 =?us-ascii?Q?fY8p6lkY2p8yuK4JCKNRMVw28lZ+NNhlU/snuxi52akPJPdog2wYwoClyQ+J?=
 =?us-ascii?Q?qym3MF00iIZX6gTTV9fvXyA=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e6ed76-8018-4cd6-e85a-08dbfa629d59
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:02:45.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djOIM3mWpYChPj84U+kQG9qQaF5g+z3i6W0uJlM3rYxEbXiIU0Ftk0Rw8ARcR8gkbyPp/TQcM2b8U0WZKZd+y/aSuJn/Ez5Zh4u3LK3uqkBFBXka8NGaxs2yWzvoF3ub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6786
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qcom_glink_send_open_req() remove error: strcpy() 'channel->name'
too large for 'req.name' (1010102 vs 32)

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 82d460ff4777..2d6a592e1c72 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -479,7 +479,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
 	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
 	req.msg.param1 = cpu_to_le16(channel->lcid);
 	req.msg.param2 = cpu_to_le32(name_len);
-	strcpy(req.name, channel->name);
+	strscpy_pad(req.name, channel->name, sizeof(req.name));
 
 	ret = qcom_glink_tx(glink, &req, req_len, NULL, 0, true);
 	if (ret)
-- 
2.25.1

