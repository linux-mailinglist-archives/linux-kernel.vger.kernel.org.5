Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192E575D7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGUXWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGUXWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:22:11 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A21BDC;
        Fri, 21 Jul 2023 16:22:10 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36LNDw3E001147;
        Fri, 21 Jul 2023 16:21:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=X76p5LlmKrH+gishWS
        gu5JMnD92skF34UHFT4WWhCrs=; b=ZMy5RFpdk/r0wS6PjkFW9E6rRqLWIBc/tg
        u04SrGGBJfjfyL1XtL3lNkA6eJv1WJZws3aaQDTn2f2uDQYx3FmsHIGU+spHYHVm
        3ErR/ilTGE//ii6wxG6G3hanINxpVoVcL2Eu6v8+/+x4uqVRxNLkF1wyCO3yVghv
        GwlsHvEOfpzyz0hZZNobrZuNPXnshLK3TeJAwTLyWnU77RId/0yNBp28tPs27MBl
        MGNPASZFAukmr2um2TKJQjWZml5gcIqh4seextMow0w5WSNJYVYGErVUGKAGIziW
        VNrpAhAGm5gQMrUYSS4Nop3OsizE5hoT0f1NvnspbO3Mc1INLnVA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rutyex0y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 16:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAs2b5CWA3tOG68xnfSa2/APVS80vPPhY0ThSxpbkHFZI/6H+zjMoWz6R9cvDyPOpGmf5fbyrumYN03XHZhFLJrPXNYKCChotAcPNaQEBL5yOMZkxSsxOw3jdu0+1npukgOyGITZBc89BMqP61IKJr7dwIYPJClajbeDGCnIIKqHRFEpYAekTbJ/4lSb405LFpNDLrHeGQMkULiXn8bwsB2MBb/IwXu5TYiaJyd+nv2zxZSbIuQPhbc3jl7TGJdLvkPyYKwEOB5wqq/Z3GCpReXh2WxNeNSYpVIo0y/OJEwcZasgWWi2opD04TiQNbMmTVY5KBTA/Dbd+j/eO3t1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X76p5LlmKrH+gishWSgu5JMnD92skF34UHFT4WWhCrs=;
 b=gon4YlzXBLsWAiglHd922Q3MQe8koS1DQxy47+VtMk3eo/RCNCRx+x6PcbLpu3yQNHnG8mB6pIQHEGgjs+b83AZRQKosSBO85H+rBwn9N6tq6purifRDRqg6Hel9VsNIGeW2oHZZcM1pKSCeSXpbSL2hPYjvzT9xT/5KZ+D2x/2uhmT4pfKN7srHdo5E4iHA43uW973k1Ra32Y+Yj/2xQkAwilq/0HQnUDhhrYu9OoEuTd0ejsl4nNyjtBqCW9VXgGiRjuIirFrhPiLOzcCi556LmK+/PyC063zu09cR/k1aqFZUM+nHNzbwnRrw4LPLKBCshNWKeYJFXiBWc8LYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 23:21:44 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 23:21:44 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx: Set default tuning step for imx7d usdhc0
Date:   Sat, 22 Jul 2023 07:21:23 +0800
Message-Id: <20230721232123.2690960-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb3e121-980e-49a2-6bf3-08db8a413f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUtAYKUhzPuzC8DR4bZ9PIQn3g6CcTBIPtfmsmLBBhHZQHNTdcTnT17od0eIVjBOFftQOJpMfbjr1Eo361+sG1GY6+zDtrXQpjylb0mNDARo7i6C+0ife3XL+gw/f622G4l8CgNUlXoogVrBF52n2vH0VCBs8z2ZhYVtf8faGjxnd8xCL0NAtUUffI0IFown7EGveZDJmKl0yZ2Uudi0cjiPeS9yQuH6H3wzIEgizTMYo634lAwcv/ToTYKpmf7vARmxqAjw5QKShLgn4qOURXKGW8OWDLqQzdwsZp6g5xESG7RQCsjmjzN8nkn5P90r2v5/dzCefoQ9JalOsnS+yTJXWtwxigxqCQQ0kIKeLorF/QaDznIo586FPyr70kdU7UFy0Bvo5IvwJ2lKlWWWYtsMMAvQX7tb5KNKUIwi2FH1uWbmLT/c7e0KgS9x0EasnW8XteYgKieytCBU1g6DuCxsc0c8z3lLUE+tNylIkrvLevmCkLHqFRuWvQEDAyOGDViR0hnD4DRekBJb3pQ6d02qW23PIuBx8jJvZBJGWMIA96/gSS7HENUBw+5phfXYG6hf4zUO5ToaBe5CME2Bw3w+gdRlCyTiNIOKrVsadFr/r4Ag531cgHJqvNolcC4h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39850400004)(366004)(136003)(376002)(451199021)(38350700002)(6666004)(66556008)(6486002)(52116002)(5660300002)(66946007)(316002)(8936002)(8676002)(41300700001)(4326008)(66476007)(478600001)(83380400001)(38100700002)(2616005)(186003)(6512007)(1076003)(26005)(6506007)(86362001)(7416002)(36756003)(44832011)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yF91OSjsXzY3vRHWVQpWo2l/ZFbkC4nOnvDM9rjlUX8efkLucP2SdQAsVSHT?=
 =?us-ascii?Q?SpYf+t2V3UWiQ+0yZYJV2MnUlzWG/YWq69pJ6Q3floGh0YvxDooQYOiYY56t?=
 =?us-ascii?Q?tCQB13aPViwLXSOuHk/bQJlnYX09GrRfZG2lurLZ+H8zmH8zkPLS0uSz2KFv?=
 =?us-ascii?Q?I/3aPFjm+IYhupQBAHqK9vbIE5702JkJJSjyYDwn9T8RdSwCuBk+BoUZhP48?=
 =?us-ascii?Q?CwajFN+BMIuJtypQe7vqaFElQIyakH9I3HN+QTqsUZ+TkwsNZXA8dPrAXRKg?=
 =?us-ascii?Q?euqPrJkVNEN/ihnvy8L51GFQVlTzkNpslQnyoJ+QPNL75u67v3jr6Wi3Xa7i?=
 =?us-ascii?Q?TnUFFsEqgjveZ2fKJEkRcRdR/SbySIAk9HyspESXD/EMWtV5FeSFFH+u0jqj?=
 =?us-ascii?Q?WiOqP86A4GUj4g+gViESXsxOPLRfZsLqgrJsRfHbG0l2qxf2dVE+VhnGgmyv?=
 =?us-ascii?Q?4Ocs9tfrKy9iKIQKLd5L6ZrEQhgsKFGGdobvHTH/j1tGE3yqxHSJ4WdDdEWi?=
 =?us-ascii?Q?44fAdrzUooja7tXexmAiR62QqNmr/KHZ+PDbNfS1Gg0qpY+DTQK4kxd5HHO+?=
 =?us-ascii?Q?hoJTrdjnO4c7d5pdMatI1oOTf3nkPFrvfMq7WUYTODBrm9KBs4KLbNshnIFF?=
 =?us-ascii?Q?HKZno108t4J4kY1wG7SA8DyA+KdHeYAeKc7sLnfhecmqTEZRGqpuESNQWyLH?=
 =?us-ascii?Q?wG49gATyX0KHhA9XF59ZRZwsH842qcmfm9Fdu+WfS5mVL8X+welMUCyPTq9W?=
 =?us-ascii?Q?0wSjilcF4t1rmhFDq6PgnzCq7DK6S5a50gWWUdYoeyxGS75H3/w1up2SCadF?=
 =?us-ascii?Q?kJUva6F8BO9EFQokGCUQFqj25v42uAk1gA13VD2Ojc5+K5ar9yB7ipwGG3ZE?=
 =?us-ascii?Q?4VprkD10Ou5QMvroJxjmQHn1uHnPBIr6xGhsXC2OVKr2lkEXEnvwXLY+q5xf?=
 =?us-ascii?Q?5cmfufp6ROVtzOfwOwn7Pe2rDE2FY4C7bKl0VU6i8kKsJbXcsbk+yqBXcv+X?=
 =?us-ascii?Q?l80kiKzuvuUEaSEm6vEY1qWVUO2V8aT3OhDlHJyWj7HG82ErR4C+VJ/T7WdH?=
 =?us-ascii?Q?UJO9rIQb2SnHgk8/eJB6z4OvaFjwFwXkTGa42BEGQ2Pp4fw8kykSPQPGfpTo?=
 =?us-ascii?Q?25rqUvzVR7WFllrFrYfzp0swBhnDBgAX53Cc7rG1lnowZV5qnPoZ0ih8Rpj7?=
 =?us-ascii?Q?Q01C2DvoSmNMNxNLBE+XP4P8AQ2iizJDomhvNyh+W0yPx9X84OMqUFZ7xCIQ?=
 =?us-ascii?Q?hq5GiRHWFffAGzySwH/OcJX4L5ljT3bMr7w4W4tgv2x+5YMTnaUdy8qN9+S+?=
 =?us-ascii?Q?4mtNBUx9SBHN/NDekoYD/5P38z0tAL8KBD3JPIr+6uEYImHyj6Or7LbMCy72?=
 =?us-ascii?Q?0qcAl1ffjOVu56Uox+i9lvfqwHLIp0EUnqx05ihojh8ip60zPGGb/4vn0KYy?=
 =?us-ascii?Q?P/hQ+CAp1U0MhJF+b/isWnm9uze4oCQAuvfyzWCGmZeHuNjqhshHVjHZCO0C?=
 =?us-ascii?Q?QBwkNaiFpMzN/izDL8F6d6YxqxDdeZv9VSotjZxRmMNddyX0qB0gNDTKemqZ?=
 =?us-ascii?Q?YAOKPgTcXLqrCxlGmDk/H1Plm2JRWfdJdO+5sOSBqaY3SB3J2/4n1Qzi9yrf?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb3e121-980e-49a2-6bf3-08db8a413f02
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 23:21:44.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzXEu01m6ritGwQTBXeaIyqyxnXu1oAaD2/oUTp5Fk3K+EJyo0smjy5Xb1mHQmUIA7QUo8gK5qSUBKe+vNYyC61DtxIcpEXoB7VU3gqunNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-Proofpoint-ORIG-GUID: OhyO5j_lShlbouo2QgG82ZrdSmi8ecg-
X-Proofpoint-GUID: OhyO5j_lShlbouo2QgG82ZrdSmi8ecg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=738 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307210207
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tuning step is not set, the tuning step is set to 1.
For some sd cards, the following Tuning timeout will occur,
so set the default tuning step.

Tuning failed, falling back to fixed sampling clock
mmc0: Tuning failed, falling back to fixed sampling clock

Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index 75f1cd14bea1..d7396fbfcaf8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -493,6 +493,7 @@ &usdhc1 {
 	vmmc-supply = <&reg_sd1_vmmc>;
 	wakeup-source;
 	keep-power-in-suspend;
+	fsl,tuning-step = <2>;
 	status = "okay";
 };
 
-- 
2.25.1

