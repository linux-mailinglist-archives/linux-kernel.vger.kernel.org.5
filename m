Return-Path: <linux-kernel+bounces-69350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111168587C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E091C21BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF7145B21;
	Fri, 16 Feb 2024 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YEX+IVx0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zRE5wfUm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4651420A8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118026; cv=fail; b=MjEcxP0R2lsWmX5RDZJjM/BdD/KMC6PeOeA2jNK1NDr2N4ChZtVjWwi6PBn3y8l8uyTa8hCtr+r9i4YNPUm+IgM88rapWZpSTMm53O+40ZXQ0LuarG9F411v7guIS9Gstlq4uo89ldj9x2agLj4uPNyrdP6KLtC4mYa9f3K8KBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118026; c=relaxed/simple;
	bh=gqcZPWdeNoJUlXxETU7NgIy6TtQSYqYv0DWC02GcgQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7ifQ6QUWxuWi1od43hWCIx2b7fSu944Z7smDGG1839d+b7n9FECSu2QBtG282jsDma7EerMjc2RY3u4Bc/sTQB1fXY1NGeKfPnKuBlhF9u9VYCTKCq2GwGRvwaacpoifJpEbpYBtOc+/WUo1KbtG2Ynw3EKjgOPH8eopKCv/zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YEX+IVx0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zRE5wfUm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKEgsQ014845;
	Fri, 16 Feb 2024 21:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=6cEEqxrWSmhx+Ys7t65MJe6QuqR9ifBsjb7IcYbYUQY=;
 b=YEX+IVx0JKa3JLrU/q26C4pR/4CipUNT1IYt3MdAUY0n7CEry55RwydS5zHjE3BNta45
 Wi9/NLNnaaMNgLFTlbXWn42ktO/w9yS7sQUmtdkMjxig8BIwd50ZubFz2367BzC2us7S
 jxVp3bTeWT8C5tGG3ZnCaBsn2aUAcrNPLvb9Cd4xHT+K8M9RkQdvOYit8mfx3hmlYZCK
 gfZw1edJZzyOKYqgiqGubwRweZLiqpy9lu2TglbKHz1zxrsk3uJ9OAa4jjO9k/+JY0eT
 zLLi0Mk0LWkGffBwimGcRAIOSi+bIkZfuoIuYkvbfQWdbDpoIGafr6O6HBZB19KopCKP 7w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6xake-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GJjfZw014975;
	Fri, 16 Feb 2024 21:13:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykce4hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBjP1zo0tBBCizdL1tzZ8Kf74YIrxBHHNUsGzW3y0ZqTyNFKAF6CKAAKVPWWzwan0WAZdQrT3wz2joam1PfjTLc/WYoNwZ6lbAl1KqpbSJ09LJWoaU3oqEpiuT58w3a8JYreq4p7SSI4VKp9IylHPFybSrGEA5iRq6M5Dx79jOGhT+CSizCmukQYH23KqiCXMuh+JR0QX7A7WxNvVUtuKIxOuD4FXBPLJ2GYJz6xD16GTNu+JjdQyUlf6NJAsOSaHbFBz65B/S/uGqHNUpDCCpnquhdbjCW8p3BI8ISX0r3efUvPzN/ZagwXH0G7GJgWN71CAmc5raDT/5D7ExvizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cEEqxrWSmhx+Ys7t65MJe6QuqR9ifBsjb7IcYbYUQY=;
 b=U8muZ8gCzs9FjFm4gkOKweuw8Ig+In7Ts7YNrBIAzGwdRIy9fNr65K2Nj6tuSYYxXI1vovys3CR8vh6rBlATiPEHXpa0dS2S6emiLA3BV3yVGvIUtVu63vw0yIyE6j3a5vu13DCP8b6t6XxsdgShDzHGHNwvE6z7nL/bMgiczFvXIeg5rbrYvk+iVwlbEx0wg4IdxVGZ6NfqD8FMfGkGirImcqsUt0pUGf22jHwZVrPWPNtHLMFeLizVUesDeF0L1L634FQrtkq/SQ24wWa4FOrhkPbwuVOZFEPIAiQ0+jEfvHwDmNg2IwcAT5xQpolc7NVswXgeCO71JqzhdCKsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cEEqxrWSmhx+Ys7t65MJe6QuqR9ifBsjb7IcYbYUQY=;
 b=zRE5wfUmzgvXJ7Ud9Qnztxgz6+4TPRJ5Uluku5g7A3IXUWsuIpH6yKDOW3dBLGuDUrcp69Yce88NMLBAgGrSTDJNAbNxq9YFDxySzlN53HwkoDaD+NRcJxibq2jdAiIFQrhHv4a7yHlOwmTUAPumgL0+wQv7t+bhtzIjwXOH9vw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 21:13:28 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:13:28 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, apopple@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/6] mm/migrate_device: further convert migrate_device_unmap()  to folios
Date: Fri, 16 Feb 2024 13:13:16 -0800
Message-ID: <20240216211320.222431-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:208:32e::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e8a00f-bf88-41e7-8484-08dc2f341ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YW0I6y+sJio5y+Uf+9yZDUd/GMmIvrn6gwSErceaCgvKN0HPLINp8I5vBsr75+VF1Kb1xXTpjerdd4vl40qDvXGoB3YFgQ/zi3RmhVTLxK8sX6nI2+HTM2K6Q6ceG5hhtQbaW1ppdy//k734Xy6iHY1ZJYvoJWR3P8pB8fmm6S9ioZ4U3UxRgv5tU4EXFUskuKaB1XNl0jLye0WIjhzzDckoZHtuqYl5ShMtkDmOZwzplHuSuVx7GqwnQjNIMTYuHCr0gIBuGGV0AuysNwOaQ4mvILaPZkgt1x7PWyqj7gOLoo9Q8Oho1rQ8cepDug7FnXNmgp/PupMYCjmfH5Y9Wo06+kXyX7BeEittvE3IBorkNUS0P/p0GF5MXnZDgKhwXjlqXao9XyPQrDY4vLmtOPc8LAMSOkm4EynDq1wuQ9+TotUHReh2yskxDo289XP+pq8l024iw7IEEVV+fANQjk+HJRGd1I6e5YbWdg6oXHAaSYFZODnsIvHRet3hO4xVqcT8MWyB9otp7kHT9nbN9J7CrAFR6eRx36PQIzYjKl0tFqksR02IHh8b51ckU9K+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(36756003)(38100700002)(6486002)(41300700001)(6506007)(316002)(6666004)(478600001)(6512007)(83380400001)(2616005)(107886003)(1076003)(4326008)(5660300002)(8676002)(8936002)(2906002)(66476007)(66946007)(44832011)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uZb3ErOosHeyKaoA1fnoy96K0nGBVWBVN/QDKNvz1XTTS+P8u8urcut8j3l1?=
 =?us-ascii?Q?Ul8gIGVFiqcO+Vloww9iFyP4qm4G/ZWM+lNsNMZbK+vATPW3pgcn9EaM7V0+?=
 =?us-ascii?Q?TQhlOtEo1LhMdn9qkPLYLCToq+DLlXX26jH4pDffIflLYkDwSvfrM1hJvCE4?=
 =?us-ascii?Q?XOz7pMy4M/+S+gb7yYRIYg/7BPZOeUK4ikWu/qQ3cF8McLMPptAX2RGX7bEe?=
 =?us-ascii?Q?RulBGk2dXn/ZeTvTV149vyDS7XUtzeqcfwNPQ7Wf/OZBShvPCeAo7E0KMP9u?=
 =?us-ascii?Q?rForvFtWYceRexh1ExgcoF9nuLvONPnm+94mSqRLvPVgzc9THKHzEHTMCjqR?=
 =?us-ascii?Q?tr2cBEwZ2FUcs3SS9ej4W5VZA45nSEojiOEggBgf82Bm7u1HF5HVTuluGxBR?=
 =?us-ascii?Q?+ytOvxBNuIz/efjZCy2nEtE0uLQ0yVCFZ/aLJM944t5Bnh8rV5KcpYFXmtTZ?=
 =?us-ascii?Q?YBuIe+qOj0ek7kTHnjbcVue1FQXrJcenVpB1qAu4ZMsOh7qJlQH9SHFqISzy?=
 =?us-ascii?Q?tklbtZJSEYDWghu65ar+tuBJiXZUO8ZthAaWcUb+vE2cSEMCLWFefflg84N9?=
 =?us-ascii?Q?xasE+YwsGMm9zecyu12tqM1OPbZl7uAMTmwhwbWStSlVQVP9edBouhjnkTnZ?=
 =?us-ascii?Q?YXg3Wo5SccizKf6nxXc6EJX9rg9tRI7k5rKVj7MEIgE5MNR6xscjlbl0noMQ?=
 =?us-ascii?Q?K/+k7Vpb5EBmX1SbaobFcvB5jL/25++Z+iwSJtgH/tjNyPr53UJv5jkGwib1?=
 =?us-ascii?Q?LKbaCfIhCExwLKnDInKDJiSIQR6c2gOfj4jVbYLWLWjNw4aqW+D1ME89frs9?=
 =?us-ascii?Q?gm/Iq40PQrdTzRJTBs0DI00VGHSNukG/IMofwUAA6bjO7pjLgYuhfabNltOg?=
 =?us-ascii?Q?8IG9xdv4teNiaVOc1kufnd6EFGFN8DnK5XtVEck254TpIvO2VcRHYjbTrdog?=
 =?us-ascii?Q?iBA3FCWFNd1jJcTJBo/PfA5AH8ESCXl4QPGzl2A43ynZtk0M8bX0k5KAuLyb?=
 =?us-ascii?Q?DNM9Kia3H0UgVG1Os8WlTT7xWl9eIWRGuxxRt5EC5q38rsNCuJAaAFNtxENj?=
 =?us-ascii?Q?3248QKnZzojV4OxdpobVye/yNdVs/JHm+fDoqDzUTSXw4YXFk0RDO/Y+zaa2?=
 =?us-ascii?Q?siOdWFjANxBi4Tpgnl+VvfBKJR1/UzVE9r/YD0RfjDtXHdm9YVtSppJ8s0ai?=
 =?us-ascii?Q?s+p7wwkr6iBN6mhIkkgvXmTo6AMTNrHOAwLd3iZOIHbB5mqb4/gH9DhKTbQ/?=
 =?us-ascii?Q?yOP0Sfo+PfHZzy34aUXuwuo7Ie6Ge/COBiA95Tpsr2JrVE9ldqxIy+PCmQzi?=
 =?us-ascii?Q?GOFoy3GFL/z2QF+HIB7gppg8R9VUaHDQMEhXixRxPrDjizjDtv7JoBzAmBBy?=
 =?us-ascii?Q?zMdaNVrl5ZJUDGgMKc7Gu3U9Is6CFzV07cseYVqKkXsRD171TcOB08zH0NgZ?=
 =?us-ascii?Q?UlBb2LpuylZffZv3QF4sner+MwZkWq/6wXZ1Pxkjen/E0ekt6vUeSKP0qHS0?=
 =?us-ascii?Q?hpja7jDKB7xGkYGRadTlErd7gP4jViQpffslUXJ2JiHrlvv0eMxUDrMslMgV?=
 =?us-ascii?Q?haY37hionrpxsaBY/26WsmComfeki5f7ZaKL+2R9rcRCm+lPVbkrxrWwRohZ?=
 =?us-ascii?Q?YZF6gJn3WxWTc8fU9gfxsCU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pDqU/c5lVdn2I+xdaMHbgYw8WsunWlD6o5Z1GGlcFXLpv3UUpuB0bupESKmFrbdlpJYac5or+gLmknb3nahZkgK3ocLy+XzZHSNf68oKQ9MYh34PZklDYaMtSmjCyYYI2cFwHIEuDTYnQ7zlt8gg8naU0/2uN1ARQux3F9g/Gv/PR4MPDH/jyKdQUW0KWaUdhi+Q4FCH39DOWbF0h3GZ71UcCK4o80eDRkt3IiKLt9/D87Gke75g3wU/F2XVfJlN7mFqkZDSqzc6itLyY7mp5PK1zFq5rflsytjUVK6EpYYOHWO/v2H45rC8tkCaFQyXAuVIJCmarg7LqYyTav4ZZCgFuxRhIDs9CkDMotVd9S6WzPRH+rdvCJ//nDYSwzWJct72oOt1ybsWT5BINxzAi3P4mdW/VVO8PCl8cWFmpVkfIGesEG/0kmDByP8nmOj/W/CmVYDLHcCVALKdQrhTG+ZZedw2/Zx4AlHIoDxcrRz25L3K7lPPr+/7n8oUvTveJeMfV54JyG0Mj851xhJCf0G+eq4K8FEuUy7E29486h7yTbBh0oOuD3zbFxM4RKxQscfHhwniQkmbgsArS25TuHsZhej0BfqPB1eu4rtKD9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e8a00f-bf88-41e7-8484-08dc2f341ee0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:13:28.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4JTuKgdo+O5tC4KKQtCNUZB3THPEtrnxr6jjqR4UmI46Xk3j290PD/BycXlOCFwN+063NA9NF596qnyXzprHEyo7G0ELg2K2+erEUP+m2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160167
X-Proofpoint-ORIG-GUID: sdGNAVO7ACbEAUPePqT7F2PxhQhAOW7t
X-Proofpoint-GUID: sdGNAVO7ACbEAUPePqT7F2PxhQhAOW7t

migrate_device_unmap() already has a folio, we can use the folio
versions of is_zone_device_page() and putback_lru_page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

	v1 -> v2:
		use migrate_pfn_to_folio() to directly work with a folio
		per Alistair Popple.

 mm/migrate_device.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index b6c27c76e1a0b..3d3c2593b5b64 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -368,42 +368,40 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 	lru_add_drain();
 
 	for (i = 0; i < npages; i++) {
-		struct page *page = migrate_pfn_to_page(src_pfns[i]);
-		struct folio *folio;
+		struct folio *folio = migrate_pfn_to_folio(src_pfns[i]);
 
-		if (!page) {
+		if (!folio) {
 			if (src_pfns[i] & MIGRATE_PFN_MIGRATE)
 				unmapped++;
 			continue;
 		}
 
 		/* ZONE_DEVICE pages are not on LRU */
-		if (!is_zone_device_page(page)) {
-			if (!PageLRU(page) && allow_drain) {
+		if (!folio_is_zone_device(folio)) {
+			if (!folio_test_lru(folio) && allow_drain) {
 				/* Drain CPU's lru cache */
 				lru_add_drain_all();
 				allow_drain = false;
 			}
 
-			if (!isolate_lru_page(page)) {
+			if (!folio_isolate_lru(folio)) {
 				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 				restore++;
 				continue;
 			}
 
 			/* Drop the reference we took in collect */
-			put_page(page);
+			folio_put(folio);
 		}
 
-		folio = page_folio(page);
 		if (folio_mapped(folio))
 			try_to_migrate(folio, 0);
 
-		if (page_mapped(page) ||
-		    !migrate_vma_check_page(page, fault_page)) {
-			if (!is_zone_device_page(page)) {
-				get_page(page);
-				putback_lru_page(page);
+		if (folio_mapped(folio) ||
+		    !migrate_vma_check_page(&folio->page, fault_page)) {
+			if (!folio_is_zone_device(folio)) {
+				folio_get(folio);
+				folio_putback_lru(folio);
 			}
 
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
@@ -415,13 +413,11 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 	}
 
 	for (i = 0; i < npages && restore; i++) {
-		struct page *page = migrate_pfn_to_page(src_pfns[i]);
-		struct folio *folio;
+		struct folio *folio = migrate_pfn_to_folio(src_pfns[i]);
 
-		if (!page || (src_pfns[i] & MIGRATE_PFN_MIGRATE))
+		if (!folio || (src_pfns[i] & MIGRATE_PFN_MIGRATE))
 			continue;
 
-		folio = page_folio(page);
 		remove_migration_ptes(folio, folio, false);
 
 		src_pfns[i] = 0;
-- 
2.42.0


