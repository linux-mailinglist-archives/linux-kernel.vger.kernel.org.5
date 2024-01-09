Return-Path: <linux-kernel+bounces-21475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE80828FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858551C24F45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F463E470;
	Tue,  9 Jan 2024 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZWDjxHh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9acF/VA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645903E462
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409JBbKr003715;
	Tue, 9 Jan 2024 22:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=iVrVOyhmAVUZOkRb1/xne2trEY3GPqjMSm4ir+rK8Bs=;
 b=YZWDjxHhOH66KjktPm38yU+dgW89eeP9AM3tprcUvQGBKXs5botD4CZKSQ4Dv3BTSAfo
 NoJqGPSitta3GCqs4KypR5pZcnb4pq0FWl4RvHRB+4ykJ2l2HEdlMxSr1+3zUYuAfa3b
 KI6O/P4cg5YjQZuHAZvRafnX9TZ6SWkzaNOdcNXhHlxOVL7zwv3hYcniKRSh2ZRwdLYI
 yXEunXCVFytzbhquh7E80t3ENvk+lvpIRN3dFNxcYxSKDlej3IRJL+eLcubDndbits83
 1AP7jlM41j6EwBvEqfySpE21Qf9iC+O1Wp2DqB2sa2/IrVg7zZNEUyBL20qs7NUCCCV/ vQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhc320dcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 22:31:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409LvpW9035096;
	Tue, 9 Jan 2024 22:31:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu56r4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 22:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUk8THzRHTpjlr0dJdGg1qBCeqE5NEYG45mGrQkuKEbVyJoDRqqXcP7BHNWnYkYj7UX9U8OQ+I+vD/G2A345FOhP8J/DzhSZF1vtjbS5D4fxqPIRv5n+Xp9Z7Kw6uB2MYJ3ajixHakjeUsyipEu5NNOG90caf2fnSlWXpEBQ3UMAAkSQ27M+06xA3OJsbp63er69aUVPJ7hY4seIkWyg6D0H79n8e3blAJMYUtihiueh8sDjyTP0H/U12jfavaBd0BlUMG0NiySVXd8MVZoOaCuaHi5mH81LN3MKhu5/q0pwhj4CBjvbAFge747mRJfTqoczBv/3NdWvFUZVWXAiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVrVOyhmAVUZOkRb1/xne2trEY3GPqjMSm4ir+rK8Bs=;
 b=CAVBgrG9Sjm4RiCYnuGIWrTQyU4qbIAscjQE5tGjyr6Q8V1dl/FxpOj4oK7eAS5JD7hFiYMn8X8jSyg/lXrBE3hpIvLgu646gnYKV/L6c0LUK7y2YkbBFWQVu/KJ8gnNnGwWjhAZZSBqKZRF21Mcxe789mSVq7gggRZ/WxspNHhvHUxAYUMibNAZ/+46c6FDIO3a9JBofoup+5pMfP7kMnka6g3TIXTetOWWIGboELTMJAk3Ug+iRwm9r40izxHcA0Va9W4c87BwJ5B/IsatZ5B4GZIcq842/Lcy1U1zH4BDNO/l/wKkqbwKcjqhF9qy/xAW1klfPnwnMffHDHheSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVrVOyhmAVUZOkRb1/xne2trEY3GPqjMSm4ir+rK8Bs=;
 b=c9acF/VAtjN8nGThKKy0JeDi6z7kfoabS5HBQHw5R+1TLDFxmTeFXuHKFzyWmR7q4IF0vTW8xs9l8VDTUC7s2F3GhKnXN1sfr8lBKWQ7Y5ddx6jdXqwTBjnwwPh4QjUZGLDZjFOeLYijwntWtYCDXjgwaCuDiHDyQ3mvRowOlEs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB5130.namprd10.prod.outlook.com (2603:10b6:610:cb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 22:31:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:31:36 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc: akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] maple_tree: fix comment describing mas_node_count_gfp()
Date: Tue,  9 Jan 2024 14:31:19 -0800
Message-ID: <20240109223119.162357-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: edf210a4-76ea-44dc-7966-08dc1162bd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q38wY0+PEC3z0iFblKA3l54xeT56TRKzJWSyo2pP1RKFbRl93WItjAOGNk+s5dw8T/HDttxTuszoIVv3DhWnndj4kjUWevtZ1jcW3W5WfbEQbQtkAz1+HxmGW2h95BVCQx26jIkC1iifQNaKjxPzS07TOIcXil6W1pe++Sr50yOelImf2BywqbsmbxiCtQytu0C4G7d7kvgb37Kzljps0OVa4ATi77qiF7kWM4yu07mevY4Z/022+q/8R2zgAMnY1bZi3R8gExbbl2/MmWMk5cW2XYMurnzgPvG0KGzzuNul+mO7igEevVUWCDAiHTs03FWaFsZdlGTWiXIt4MuFyqRwvyMIo0gKEvWXvT3s6zd4Xfa08OPni2iL3t/ZKkCNP+pGqm8LJ+71EkBWDWCq1/2b1Fzikozv/5kmJKmXdUDK4MF0KW8FfMTu25n3h89rceGh1/0IIZDRasBUT//qcSnTQavr/Omn48Z8Od5qZqxX+K+zMZx7pMEampU7h41n9VrZqoo2xgSHKoTfn3ua19ndqbQvExF3QASCulOPPXLCeor64jjtWe073UC+kphb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(478600001)(6512007)(6506007)(66556008)(66946007)(86362001)(66476007)(6486002)(38100700002)(2616005)(83380400001)(1076003)(107886003)(2906002)(4744005)(316002)(4326008)(5660300002)(6666004)(44832011)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zgW0jUZYvWv45pz4Bc0yNTc7vmvx86qwlU8b+DC7dIfYJVjQGRWs5e3XDeBd?=
 =?us-ascii?Q?N9BN8DuMQt0jVwBePG/8B93OlLoDuSBKh6i41yvD7n6Y6LEKNHwiaghjN+Fc?=
 =?us-ascii?Q?8Caw8dIk3dISVm/Lyoqu8hxZKHf/PpkLnXTWrZAMGtu1u9FTUloKGkZgUhvB?=
 =?us-ascii?Q?aA9c+1ZJYV59oRYgeSQ6WKzYzSLb3v6RvPupXbvOBf/ViBh6qXuQxWh9s6d7?=
 =?us-ascii?Q?N/C1LdgsS3Bzmw9V8ApLvUQ3a1oydiCrfnHXz5g7vPxhJYixqGE/fI7hCezO?=
 =?us-ascii?Q?M5h2IEM+K+HtN0+IfMKrOoznvqwPVCWRjeKqFPA4jLWeRGHhFA5qE8hCg+Ev?=
 =?us-ascii?Q?kolcwYChNOevmQyU2TGSj5K0yQd86YQssA3Fr2RCcxIt2iyU8foSg/LvwHyq?=
 =?us-ascii?Q?ETNYUHgUn0zUWpGp8vSd91plTweD+31new1Te/oguoLPWkMTzEPKOeYbxZJN?=
 =?us-ascii?Q?9Kh050UQl3zf5QGRWt2Dr81zKa+acSeqcBR+7h5CEZ4DAEB+C0kEwXlf68yu?=
 =?us-ascii?Q?VV3rF8/YK8CH2KOcV5oFeiZNZetp/bbrt392958GlS3Sr9tE5qi1AQ8u2Xf1?=
 =?us-ascii?Q?tuPcCLzqTpfRjThuW9AJXioxADl+Fb5qLoEeI+QBsWrBjSONVR2GucVyZbjk?=
 =?us-ascii?Q?HBzOHlSdMODJBEPoNErUdKeCF24Dkoo2RoD8OvQDJ5Mm3+kLMbtpE3YXOxEa?=
 =?us-ascii?Q?pYr/IShoXMLMcIVMg+LHaYChVyPARjTIno3oKLBpHr32L+d43hcNytCfA+oY?=
 =?us-ascii?Q?icQfLv8xm37V23M0xxzkGMlPd0A6yQDCwQxd5m7aYoURuaACl7QYB3uqB0Xl?=
 =?us-ascii?Q?VRUERwdOuAMyV2RNFZ9dF2VMHMU0Tj8qwFIXbnfUicpTSYf5n+KRXLGh11j3?=
 =?us-ascii?Q?XWWDcmi12gB/TkQpddN9cPlIg7uP1wEzoDnUxd++zepEmDeiONIf/pqcKRfD?=
 =?us-ascii?Q?XoEayqzem+oLWGYhxWlt3vedri/phig8LMIr2/99tQy5WZmwTJLi/Ih4gBsn?=
 =?us-ascii?Q?nUXVXaDxVRBKxrQ7bVdiV9r5Y/lD0ojuCS9G4uXcgufSgjkEhZIYZbWowK3k?=
 =?us-ascii?Q?FpXtUrJq/qr8NEhSU81v7lvQZONCQrYoWhrRk7Ht4+HWCgbIpuQihWrtsZ09?=
 =?us-ascii?Q?E8qcN+fIQOqt3qtXIauXjvmVERmobU5C776JTlSth49hSGtj9jGxAZA9wPVB?=
 =?us-ascii?Q?EGEYXU2LDe1tTIgupVDgzISSQMPuKHGRKvZkXziMKdTMZYX/y4L/Gd2diwo7?=
 =?us-ascii?Q?O70ICimCR450NRaFyFzbE7IPq2cBvZwOrzRYtpwEoDSrjNVxlExLZkx8tSlu?=
 =?us-ascii?Q?/SYiFcirNaWqkogtOK+4MzQnBvDGoS3KNSEO74ghtt/5ioTqOQvrFfEEXwnn?=
 =?us-ascii?Q?76lfCo3WVmIUQcAEYu4VstKZnnkr8hIB4RvPsUmM1QcS8L72kGWPuqQCKAcO?=
 =?us-ascii?Q?D0Gt5+a3FOkLgUtHNvcqPTaR4F0LwkvoeU5664RK3IiioWPFQcHcVULrWPaq?=
 =?us-ascii?Q?AowkEv3YrDm8X/H9qhy98BZFaADmWKgsJAvuQAKhuWxGaVVPsIzbhNdaxJ3U?=
 =?us-ascii?Q?ct9Sv0MoQt7v03blqb5DYagxv/YbEt5cel5KNhcdnNzLawTvwTTjCD193A7t?=
 =?us-ascii?Q?BMSnCP8aqVykvewtYZEVysg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KY0Jz5XokpgM/6tw6UOf1ujcLaUYa7wbZ8XYvjiyo0tcreM3Y/YTqJd2VwuN/Fz8cctFFdcQrGcn0JYJuB1Q7hn8Kneu2rrj8wthSmb6xPb9NSqvbsmWOP/zKJIw4+gjbhO1mBuxPpwUv4Lx/Gk/EjPwNcxQGFA1UXFB6up8koGAokA6Ui/nZQTR8jLCb4fpiy2s/BsSx0xyBpqPX47dRnAuu8Y+VLozZ6wl+2535DFXKP9KM7wYphJU6lMWYL1aT4mGqjotQ1WrCz9micONcAbY2TzLsd11WXaIIq8+MlJLmpJNw7jGDlrB3YHji8q235OTKQKo3LvanN69uRDBcX+Rqh8zw0bgjnbUcSgA0sA2fMNni1Ea9MCYzd3LhYsSzLdd8lhLmFwjpiwPQWMNKT5UjVFE8mMwZqV74O+VuXKlSQHt48/t3Mf+wp+h+NZBYT4w9ZDy8jXgE745J4rrRn4ni33cHvwS6xtt1kPxH9IUKcAT+r91cD2pRLatHSErDg0mEMBaBvDf8O7aAcutBus555oU46RIyTXvvQvnbU7JRRleD/nDzkWLWLdu7KHDN/WKqtxEygIYpFEb/U0cw/2h6MZ0ZNPuRqHWecBVCaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf210a4-76ea-44dc-7966-08dc1162bd2e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 22:31:35.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKJKjqSR/MIkTuPoVohqgsIpyYNtU4+eKwgCdbE61u6i9ABXS60CGhvCqmYGUz08ZI/kPqcV8qBbSAITubyctGjEX7Hc3wUQPv6qDuzKZAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090180
X-Proofpoint-ORIG-GUID: S0mm_0Qfs7LWQQE2-Y96Zqk3QK5-7PPh
X-Proofpoint-GUID: S0mm_0Qfs7LWQQE2-Y96Zqk3QK5-7PPh

The function description comment for mas_node_count_gfp() mistakingly
refers to the function as mas_node_count(). Change it to refer to the
correct function.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6f241bb387992..7b161802860bd 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1307,8 +1307,8 @@ static inline void mas_free(struct ma_state *mas, struct maple_enode *used)
 }
 
 /*
- * mas_node_count() - Check if enough nodes are allocated and request more if
- * there is not enough nodes.
+ * mas_node_count_gfp() - Check if enough nodes are allocated and request more
+ * if there is not enough nodes.
  * @mas: The maple state
  * @count: The number of nodes needed
  * @gfp: the gfp flags
-- 
2.42.0


