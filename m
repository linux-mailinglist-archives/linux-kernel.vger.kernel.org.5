Return-Path: <linux-kernel+bounces-7486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CAE81A8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88F11C21F52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001194A9A9;
	Wed, 20 Dec 2023 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i1NWPcgg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vpdHZrv7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB334A99C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKHP9ea017512;
	Wed, 20 Dec 2023 22:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XFworigQfL204plWHJnnXWFhZZyWCPt2DHuDGD7P0hM=;
 b=i1NWPcggA7OMeN+td9S1Warj7vY8XwM3qnElO+TM59zpXE80/RzhyIaWxozrrnhs10UA
 BNlLCQmcIywWicm7Z1Ugh70wsOrJUAfBuA8rlHXngLm2xab2zG6hXnMb4/PrHSR8ypix
 2R3fj5zgltFw41+v+TKyN3HWBQ5eVZv7LdiXfd9+q2jkEvU1k8pLs28xwMVrO6T6JTU8
 vK0kaUSyCjWmcejiVtyoogtXytdsQe8O+M+fd+l6bsJB/DyNUCrLr5m/4lSj49SDio/R
 TxvtTtQl9O5S6O7VBOySZztpHgp++KggREYZ9JWNfXfUbLazvoQ1DPbrt9xMXECULot2 YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12aehfgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 22:08:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKLVbj3020778;
	Wed, 20 Dec 2023 22:08:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b9kyw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 22:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwd+T/InzsPZGgZ1vd3AUxteSiD5ksInoWLADs/5dIfSqbr6XKzo7p3jsFo3P+LzmXZmnVfJIOaqQ13bt7THbRoyJsTigO+YXXn47L+IV0JcdZw5bpzILvcFUWajmjOxHZ54S9jPzDb4MFldU+KEiNUMpAF14lo/JDZGKpE15TvYOPnhCI7SeERsGni25H+lDd1mpQImr3+gbc8djQQss8PGy2MtW1lGdRT0xk/6usDF7h7wAMQqvybiyqdNYWUIVo8Lem2uC5roENO/y/dRY0xLf9ie4gDMFbVEkYi7237BTW8ZeytBMv0q06QUS/ZsYU688vO0csMqRmASMxqEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFworigQfL204plWHJnnXWFhZZyWCPt2DHuDGD7P0hM=;
 b=fmCKu9Ln6+mZzdILVkiHg2p5XBQwc35I+bmPD8c56ceShRqC0Ef4CYSq+l48ZJeS+SGqwuice1VKqR6VT58ETtZGlJfuXtykkSsqsqhaBORROg1Iv7E1ZqNZuqloYC8d7KxqlBWAIgr2JRHcLGFr30MhbSWDj+i4lwM1OEzxXsfsIlnuM7J+9wCucfuVfBgxadxM1hrlSMUX5e8pfiPI3s+U7kTVt6zFNXSgtVUcIkl9i0cqLpx68T31mJuaNqmoGtKnBAa4zM7tJAxQT7s3pB9SIGau2OXV8pbY0mOHY6Zc9Qn98+24NTV7eoljhFDAB/TRruUtwmlMZru7a4eIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFworigQfL204plWHJnnXWFhZZyWCPt2DHuDGD7P0hM=;
 b=vpdHZrv7ESJaDaiOvZw57WPH/65SEYMJDkr6FMe/c8P+LdwM7nCHJwl2RCKptdKZVbyVeUao6h9KzOHPnmI9qM72RxuV5wtm7KyaQlNbV7jJ39wh9esYHJIihYnfuY6LpcikDSoTLRq+ZbfMhwmO1E+UGFxxbL5+nK+5BU0XxD8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5255.namprd10.prod.outlook.com (2603:10b6:408:123::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Wed, 20 Dec
 2023 22:08:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:08:47 +0000
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] MAINTAINERS: remove hugetlb maintainer Mike Kravetz
Date: Wed, 20 Dec 2023 14:08:43 -0800
Message-ID: <20231220220843.73586-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: fea91bae-805a-4756-7965-08dc01a83d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	00XquxZ67Db1Oa9oE1vC0bUsCNyuEFWJP2GI7N1xBeKpNxMaYCGsWzaQxWdpMpcKoPdUwh5fRZSbFo179kzsagTuJGtq1MPXQwHwXhmLpj2/mvCIrT/cMsttil6UdLmC9e8G0FaUPNxTlTu50hv+raK1WMXDmrimXffIg2f2KbXza13aFbAxEF/IYW+BqeOPwQSfsYDiqkrSrll3Wuf59gv6SHZ6i7oSwFErL5lb8MWL+AsAqqoKwHcEht/94M2eWgP5QKR37PzvuxYy6KtWAeeb41+yvCdQg/ZXM/1Sjnvty347ze2yymhutjj6DWjxCGuJwMqhnEn9Rbna5jzCj0WqAtMKTzySA7m3bnZsXN57AB+JSpjedq0AcTatcFZ1P1NruPpFaZkk62tMevssLjckXUr1WwtBEisdCxb98JXW7oUAojt+cX7rryYvE3RlkrIryiLQYNaUzt0yeE5Z+pB+SHfuP8Oe5eLuS75wvvIrwxkT/DPiyeGqW7TPSauHjg8Su+Us6TcbHZnRTjAAvPPm7/o+soA4jdd5rurcp9bxpwz/yc+xsrkB9OeWFYVVbMO4ILncA2qDlQlj5ACFI4YC6ZMGoBDOurTTBlOJRkO8h3MsgjOr35ZEK7VYOf4l
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6506007)(4326008)(6512007)(6486002)(54906003)(66476007)(66556008)(478600001)(66946007)(6666004)(316002)(4744005)(38100700002)(44832011)(2906002)(83380400001)(8936002)(5660300002)(8676002)(36756003)(107886003)(26005)(86362001)(2616005)(1076003)(41300700001)(585764001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?shepdKMBywOdKi/j3dGMdxjwo3tlDpfBA8HgWZzihsQULwWcK5yaGOCdKHAM?=
 =?us-ascii?Q?G3NlYAOg0CK98NJPaj+JrqwWVc5NqkplXmoCTiY2v3+kUYg7uelx7SQkruRV?=
 =?us-ascii?Q?Jgu0fFfsKSYGUACGV225n/WWegSrqNZH8Uf5Hp6bVJIGfTeyRBXUCllHWL3+?=
 =?us-ascii?Q?YDG8ZQV0FzvtX91MRUprWUySDJtKPtDtjVHsYqfNzHFDGUy+eqUk88nIcz3q?=
 =?us-ascii?Q?7Hyd/iRSpGR4OREeuiB96yEDXJGvzj5OutKdNAKLI83e6YkA6df4B1qtw4/n?=
 =?us-ascii?Q?nbc3gx7wxCCbK6tBeO22gXOHRRYm1l0j15u3GIIbtThkKjNQlz0y2xRSwXK5?=
 =?us-ascii?Q?VSUi4EawlV9UNDJHAgSB5G1e2s3PmyZcwWcs95nlv2jC7Xh9NZBZMJecT9Az?=
 =?us-ascii?Q?L+VBxDd5QLBrH1EIybdzgfDC2iaUEkJwsBcJMC9hb0+IgLsL2dq/gq6UN4Y0?=
 =?us-ascii?Q?cDKFJTyMyLKM/ZbavHiK405ucKvF7sxcR5ZMFMUH34yLcn8iW/rXkXgRMFfS?=
 =?us-ascii?Q?zs6OyVFPxZh/+zxZNqzhGge14YRQZAETVzQPe/6bWM8jo9AALI704KT7k969?=
 =?us-ascii?Q?jM6aBZdF2kIYnZBwtnGIVoVQkdUwtcOk0Vmrqmdhau5lDMvRgxr8/PwlqknV?=
 =?us-ascii?Q?AfYKJCYKkbyIFsDycU+9DETJRtrpmz+qsKzxJZR7lnkTes7MjzigGMIrIY0W?=
 =?us-ascii?Q?6owy/GbxuL7Nu6I1dR4IQT2InqQ7lF+DVXfO6wwWqSv9xVYNoddh/8aJxHod?=
 =?us-ascii?Q?1TB9ryYOxjYtsijmufKgR3MO3X2ykOD5B/vs3RA72XF99HNbLmDVeQGotuEf?=
 =?us-ascii?Q?3GxfhiWoxfHQ8qDYtIon7xOIy4B8X0qbi8bYNnPmKPPQ5vF/C4euo8rvL+GN?=
 =?us-ascii?Q?NXVaqD3aqRZ4/z6004/UW9CynUlHb+7IBmLbka9O/Pie/32qVwZMDqeJSxJs?=
 =?us-ascii?Q?mSm05pbTUknkoeG9/dsxxIgWNfwnbWoKNEgfcHOpStFxHXtanhGw9j6ze7wz?=
 =?us-ascii?Q?jF1+MY3so4R6zSwf4zYBlNkzIvNNNyq5Fi3JHo1uh+odAkfU6CtqGIyT/jx/?=
 =?us-ascii?Q?+HXzlp0j81tUNSCdh5aoF09YFBth3AR421HMrmXhEexjsBIJaaV0Q6i31c5/?=
 =?us-ascii?Q?/ILAzcRVyNf3B9CwTFdYKM+un+HaLdYSucWN2mW8qNYLf5aKnvO778bysPMJ?=
 =?us-ascii?Q?2UuM5fReCkJCSrZVNjxGi+j15eSpRHkDqyibk0369aIwcjUvIMyy0fs1UlqU?=
 =?us-ascii?Q?qlahhzNV/IWkyeF8vDoepGPoHPQObMBYPpMBTeam1HM3OUSxYQ+D8naclitx?=
 =?us-ascii?Q?Wi5a9XqJTm+DaF9irlN6Xm26r1/Pk4bbKzWQtpKtSUYQlgsXwJHXsb6Oq2d3?=
 =?us-ascii?Q?f2bB4naORczxfsJU63gNPXVUqIFxPTVzwcxiJY8BR7kHtdLq7rGgyuxdehIk?=
 =?us-ascii?Q?qndtrykA8rZdLZS8C/L48LQ1YrHMfJOVJMaf581aDtKfMkryZHj0y+xcpF7p?=
 =?us-ascii?Q?gzk4blDYX8jadE1jpqx0et29gePD0ofWbv2dqDxWgWUU6QlIOb4+NNb+/3/B?=
 =?us-ascii?Q?Rpk0KDh7eec8u9HVZYSrA5XY2RD4jQt5aBFkMeea?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hD2oRm+yjqi6uBCLblWiOy7wwhsGXLIEKnlA4IBLG4DO6D0GWjl4lfHhRmLv2I1aIBAddlF6sU1wVijdxENMwQoNEgfDWsABm6tWccw5S3yYD72pQX7cySv10JC/415hf63kitmj+/y0gvvro+GhJSJ4nKuROWa4GB/mq/CO6IhJ4JSjVhu6vjDR1rRgzfwHhPs6EVuiOwsJ5GyEpb5pXovcLR649MFSOc7Nq37kR07MZQ4NKotEJ5g88OOzmN7QT+diwmQyoxCYKSRF1XMp17TS+Dz33iDR14TLPVzDM9ke3Yi/H1+AT2Wrbw4583LRfl4sd+2ZuRp9/qLJf/wuEbdQXOICrNohK6pHqwjsMBPe2COuOeQQ7c+5sN8M9YcPRXoj0yMXMvlj2ix8EP2Sfc+MGpj/+9E/je3W6i4MlNrgAhF2gVgrIyfyev9Lj9Tc8Qs3FOhpXRprySIc7sXNkG21+wHexafHAxdi1Ia6vXQXg+DI+SQhw4hEiCk06JpwRCJaAkw6WjrLLCx9APO3c6fX7LkanPfekglOH7Q7+a/3CEWdjF2n3MWCCc3rBkUfudJRBHO7882zBENM2ogyem3QkZ91GJMKbiIoIhlSxrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea91bae-805a-4756-7965-08dc01a83d0a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:08:47.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKuZizOjmItdNbgCZqUp2XLP8ZONYsw4Ylbzu6fCopawOGqRoChae2HCDbTQOqmva39uDLk1MXo+mSot8KdlXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312200157
X-Proofpoint-ORIG-GUID: 0nwzRymOhX9KP8ErkZo745L6q4g7oQDo
X-Proofpoint-GUID: 0nwzRymOhX9KP8ErkZo745L6q4g7oQDo

I am stepping away from my role as hugetlb maintainer.  There should be
no gap in coverage as Muchun Song is also a hugetlb maintainer.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9104430e148e..b487aaa206e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9762,7 +9762,6 @@ F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
 F:	drivers/net/ethernet/huawei/hinic/
 
 HUGETLB SUBSYSTEM
-M:	Mike Kravetz <mike.kravetz@oracle.com>
 M:	Muchun Song <muchun.song@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.43.0


