Return-Path: <linux-kernel+bounces-168418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6F8BB855
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A282830AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA984D3F;
	Fri,  3 May 2024 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="hMU0J4/R"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9059B71;
	Fri,  3 May 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779433; cv=fail; b=HRD7uK7WL1JN4vGJtXcwMlqj2b/ZQB8AgcNLm1vd1zlIhMFjMEdi7mZROEvkrKVvOyp9FqcRVznuC7+0SF24qB4gTln5aO9K7EOTYkp2Luwbs4tfkwcTbLKjcVzvdlxd004DopwiDkIbPj3ZdbQ7/RofUfIldnC6O2EkcaXXI7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779433; c=relaxed/simple;
	bh=FDyz9tXwgVGPoMTWdlf0AVt4ULJabZ+pHF8YgJxe+KI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uNnbInbVa0IIcOBAoZ3jyz4ApVCwW8lffXCg6usbtQ4G3ZNo7DIEB3deWu+/aWB0Vh5tf3XSmg0GnE2OsKNTsvUo+KYrjZm4jWBx9dnnieT6JQULQppSGQwwNiMBGjqLv00o3ClaWoB1xew7ZFTPBNoasgoKC2tcFfkH4PqixJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=hMU0J4/R; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443N0MFQ015062;
	Fri, 3 May 2024 16:18:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=er3ZWF0LrZFZugNAp0
	EugHNAKGvUCvdlcEjeKnyNTAY=; b=hMU0J4/RZAL0vnq4Bya4Bp30G/oZgBPvW9
	g3a7PPxQwMw0IC+qaSdEEzRBE/NP5QoVjJSvV9J5Qy520BM6SdXHnId2Hj4HwnH/
	ji+qYDyb8Ybg+dkBDaYcL6yDwiWo8Q+swDX7fujTHfRB3t94GepTefl+i1qce9br
	43N30elxQK50xtK59puT2lUXyZvJ8fYo3yEbcYImCV/Mq8ALk7S3vl5FCl0Tbqs6
	tPxtciLFX64k18lFRvzfM7bDiM2irrFU+9Z9mTXUCv+EvncOsZu/qeYw9jk5mFML
	56qYUp9pVJsFr7S6kUfwveHSbGNhXz0iqYfoRidDiD6+14v26yyQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xs0vfxmbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 16:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1QOgJn+zkL+ZSPQ5TPLds2BX3IeBVyp5IBiqXNtL7CnVTwtYWR5f/KQ3OedL3C5eOx7AIOMBaxUgqjqoOfLJvmaUiALKCdR2ABt4yxL/uDkMf1/o9RWzQ4zI1U1EIk38N4j2q0hbTLtrVzdUQ4dh75Mbo34gWOpAL9M8B4yU80XZINEK84MQS5JFa8120xOKlQ6TpSkkysZur18ftX673s+3HfDSi/Xb6pV7VFZd4T/4pJROpxkFThf5mbWOnOolLlYxs6UR2RWbixzmR5LcZWQuFAId6kKK9ut0Yc1//f1iNN8QpFiO5MFx6Gghc/a0jdaqnABDua3L6ySaWmefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er3ZWF0LrZFZugNAp0EugHNAKGvUCvdlcEjeKnyNTAY=;
 b=Vyi5GdtFsjwyM/iVf0KZVIQeLfuhCyTKZ1TeCdXUiiSPS/0FUAv1J28JT2FcSA06SGqbiZbkXCbdt/X+aEhuZayCZd2ltDvGOPSk6kBVUYZXXZhw7DmWIjkf1icYUJ4E9yNv8MjK8CWqQR6smWLwd8hJaRV57OW1fM48eoptaobx5zPef2o5biJGP+somdamWoV1eKpPMag9APTN6fNev84OTz3LyJoMaivDxRJnRv81v3nsVw05m0jJrzpmXdiMw2XsHaU/FRbpcP4mh27jIFbHnDnICjdQkqrUfmIuTwanaqcppBc8wS0LDkRBgTODkMWBthEfyYMjrcEFuItw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.34; Fri, 3 May 2024 23:18:19 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 23:18:19 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Initialize the other members except the est->lock
Date: Sat,  4 May 2024 07:18:04 +0800
Message-Id: <20240503231804.2323666-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:404:56::13) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM4PR11MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf16bec-851f-47c5-af2c-08dc6bc75195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wcOuHKT7lrs6cZfPAf38m6mYHb7kcTZQRy6G6tY2aoIFiWMptDtAwQHaoNh7?=
 =?us-ascii?Q?ls/rii3KECfEJKDZeNqOa3gP5uGecU/1x1CcrsGEeRD7SKy2dWmvoefAi+MA?=
 =?us-ascii?Q?WWvnl07uzxP5uX9zdM5jgcVMUypAjZYPsx7Pfyjq60xU+IJg+2EEn/A7vGhJ?=
 =?us-ascii?Q?zAksxXX746TmuyS7HFsC9RuJ4jYOCqgjXc7+zXSyCn9kPwJHcSerSvPX7Ohz?=
 =?us-ascii?Q?UVlDf9EfCJ1I1wmAkBReJtJbK8uB+NxL8xZS6Pv5eEPj4FlUiIO4HSlSlEyP?=
 =?us-ascii?Q?ak0UfnWomSCKje5MnkICJZ+2pGYZvW3uu8FRqUMuW0kU3v5a5xcPf49wTls6?=
 =?us-ascii?Q?ByDOHbtjHa3kPrRhF5JjXgQQqWiEv/uF/shpbqIzjWV8+VFL0AMlheA0aBoM?=
 =?us-ascii?Q?Y81BnkwDaMpQjqaByZ2HkPTQxux1+kR4svit8Zz0Bx+gWKUwmlRtxGENNa5l?=
 =?us-ascii?Q?d/2pgDmvGBXv3i+CJnHNep8LABLzFd3jXrRfczlE2b79LhB1Di0WGY/T3Twf?=
 =?us-ascii?Q?v3dFcp7yjUj3gvmhgK2tmGAG6xEpe8T0rvMbO+HMeyCAunAlRH096tMc3X4n?=
 =?us-ascii?Q?6Z0sjUykEJhug1MFpZ8FjFfS7YjGFh+pcPLtCnrfhNte7NSD4r0Zm6ZBe4+B?=
 =?us-ascii?Q?anlOkixEz8VPtscB12wYcqcrtrQmPz6j+TkqPnkfhNvE8ax64+M8w2j9xBs0?=
 =?us-ascii?Q?7WMqWCLIRHCp3amlTs7h6BCh4NVk6WvIm3c1z95VTwaekb7Zk5MXtqC6wcnN?=
 =?us-ascii?Q?RYhzYRcWBASttM3NlF3wAdFcKigFF/aKhnTK9fnDf4FrOdk1g9eqy1bX4Bgk?=
 =?us-ascii?Q?Dj8Sqbm36MAIovpoXUVmo+MNZeFMkc7jYilYMOZMaKHrKSxF/PP8kotBtU/+?=
 =?us-ascii?Q?cIKksDWckdjzCDvxxwM7ejHFTS5ebN3y0oLYIOzE+K+Lv5zYKE1Rhateruwv?=
 =?us-ascii?Q?iaVdQETNmDfSgnd+rORnBX1+yEj7cQYOPrJJ/kEv56nTTk6nww36jW7iMMnA?=
 =?us-ascii?Q?XnwbSdXJk6a0J7Jg4hmQ/x6tGJWriEnD6pyQdVXHjbrRVBm2Q3RayidXVucJ?=
 =?us-ascii?Q?9ybit6kRArti2GOv+1WrFDBpSOfxA/qM+QdKKBno9sYvlKalPoPwDVQUMAkw?=
 =?us-ascii?Q?y0/f4SI3GFKV9TnAhpB8TQ+whTa3b7In4qdSOHbaOlKAPl7Ilyg7F/7hhhoY?=
 =?us-ascii?Q?kza/yINRkmhUWffMpmMYuBAbDJJHY4LE0BFyce6zZgJx0lhgu9izX+uNlXDx?=
 =?us-ascii?Q?T34CEB0ZB8Mjay0aCbSYUFvT6FcNXGqjsZI0fkaIU5hSmKbUYMCPZXYkNqWY?=
 =?us-ascii?Q?JC3S7KOjgKHezas607jaSgz5xhAxdLocwZ74/5UANn6o0rl1/jUWFnymniRT?=
 =?us-ascii?Q?v2euH1A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5844V2ZzRsahZpKPvspfPKaBbuXJwsCl4b/imr+IkBbNNWVH8ifniqZOipmi?=
 =?us-ascii?Q?VUpFWHy352B/5HAMSiZYru93eLHN/0QMiBk47ZAnoKcTlFnuRVStazaDR4FX?=
 =?us-ascii?Q?tjf9HXRL+tSOpeHaBsWT1yHuCCG5ZwO8HHCsQpd13dmWOlWl6Q1wb0mtMKNH?=
 =?us-ascii?Q?D59/dz67twa0jYhMXI4WtM9mF7DlftExdEpquWF6u6f5fRNpeBgNpGNKSoMC?=
 =?us-ascii?Q?uzNGm38CV+URuLzHfFlQ+iVDlOT02Vxn7r1DpdhO6XyNr19n/HAo6fmnZ00W?=
 =?us-ascii?Q?aiSDi26blk6L4XqCVSWGARlIDu2Hqrb8EHMp66R+j0hNA2sQGK1MfeN8lY10?=
 =?us-ascii?Q?H2k+v0vSdXZjgWj3lltmjIPlNec5FwzanK07SU9QoeWo5vtaf9UlJoCjYyq1?=
 =?us-ascii?Q?8rgwN+pQm+kuxk61hLgXjaiYokiu4d+BKHcR/gP1WOKJLRXps55zlwtZNfP6?=
 =?us-ascii?Q?Lli06/tiRXM8mXySPf5Qn2CMkriK9lI9t4hpUjSg+XAYGIZqpWsfTPD12a8V?=
 =?us-ascii?Q?zXZNRtW4DknDb6gHwukw0u6tY72n/i+yacdXAVynrITLdAhm4zjRDpnEmfz9?=
 =?us-ascii?Q?vozSRH4elwU3/crJyigSnw41QAh25r/tdorjoGmXbZg4sTLWQF/IXZKU4CsH?=
 =?us-ascii?Q?joKymPs8zu7/Yos3ijlDuwp2Bu6hMUMo4Vuy/pUNM3AneLZnxVW2t37gLVPl?=
 =?us-ascii?Q?St4/RNIhfLK83NH/dH4qKm14uNs1dI5FxGijMltoChu/HJG85pxHpVaaa4kf?=
 =?us-ascii?Q?r2bwZWqIUV2CUIOgAT+n2lVbgCdYprrz12Hf+etxhXxZe2uEc4eRwfZTocTC?=
 =?us-ascii?Q?eX7Gl3Z40s20KHW/MBr/xlPB4rKx7QyWKe6GadmfXaonmY0/qUtb61SoUhlo?=
 =?us-ascii?Q?TagTN+b7jEwF1pJ91Cc5VpTxrWrfRN/N4hATlJLkeSmfWsEuw1BkR5OKqpbP?=
 =?us-ascii?Q?4Omiil8037GDFFQ1aVdFG8QBuRcez6JU1V52IMf7+mW6tv95E/9QG2bFiDmu?=
 =?us-ascii?Q?QVf3sQkVr77+atkBFMJTPzFkLJ2J6x6RrbSntH538+6a4MW58C9UwYz9tuDY?=
 =?us-ascii?Q?tSnjaiFzVXatnpXjLLz4yW6I0Drax24TG0miqw9qibPg+OiI3HNiZ/WB2QHl?=
 =?us-ascii?Q?3iEinOp2xC7gmab2yeTK4fWe3Slgckfmg++CK6BhFXBqxlo/Aj4MW7OKtMC2?=
 =?us-ascii?Q?cMZXHhgv2DfjkRdGCn6jRcNNXyYz/P9HSaRKwkx+mAeR+W0Ka15hiOyDDpRl?=
 =?us-ascii?Q?rbRD1pwdl14sJyynBqU7XcQ6rTPOwboIWmqUgDM7GabQ65x0PJzbwAknOpYk?=
 =?us-ascii?Q?kFm+3kepLZLeo2TzuVJ4rtjDPl/AZxQl9Y/ntbeoIG9aYuXrQAKrGZlwtnPf?=
 =?us-ascii?Q?kdAZ86d0zBH3foVmyvu4A9EBJJpxa4UUq6Y44iLw9H+Betx6kENLPJNcvfjJ?=
 =?us-ascii?Q?ZywV/2U2GtseSO8nh2n6FvLWUUKXz9ocIUwg1+FxNZ52oYcTfkcvLduO93sp?=
 =?us-ascii?Q?WGhnUoA2auAdETF8W9d7sBGaFY0FW1vZXy06WU5JKls8tNne6pPOjhehnzOb?=
 =?us-ascii?Q?eiW73f9MDVWGZmlxiOSR9dUgeTAptiC4iQ15bNBcB+s/SwWSZjpW/BKks6FV?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf16bec-851f-47c5-af2c-08dc6bc75195
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:18:19.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuIuQfid0cmYBWsHe7evjB4LxwkQ0Bv7wThfYHeU2PjRcXW8JDnIxy2LZCfw4efkhzp/4bdTSYghZzQ/bIt3QL1VI63FWD5YkcgsSCtGbUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-Proofpoint-ORIG-GUID: 6p1x6_DXG6UB7qbIJjyFJVL27JcAQSYX
X-Proofpoint-GUID: 6p1x6_DXG6UB7qbIJjyFJVL27JcAQSYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_16,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030166

Reinitialize the whole est structure would also reset the mutex lock
which is embedded in the est structure, and then trigger the following
warning. To address this, define all the other members except mutex lock
as a struct group and use that for the reinitialization. We also need
to require the mutex lock when doing this initialization.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
 Modules linked in:
 CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
 Hardware name: NXP i.MX8MPlus EVK board (DT)
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __mutex_lock+0xd84/0x1068
 lr : __mutex_lock+0xd84/0x1068
 sp : ffffffc0864e3570
 x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
 x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
 x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
 x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
 x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
 x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
 x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
 x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
 x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
 x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  __mutex_lock+0xd84/0x1068
  mutex_lock_nested+0x28/0x34
  tc_setup_taprio+0x118/0x68c
  stmmac_setup_tc+0x50/0xf0
  taprio_change+0x868/0xc9c

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  4 +++-
 include/linux/stmmac.h                        | 22 ++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index cce00719937d..a3663c019a8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1006,7 +1006,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 		mutex_init(&priv->plat->est->lock);
 	} else {
-		memset(plat->est, 0, sizeof(*plat->est));
+		mutex_lock(&priv->plat->est->lock);
+		memset(&plat->est->init, 0, sizeof(plat->est->init));
+		mutex_unlock(&priv->plat->est->lock);
 	}
 
 	size = qopt->num_entries;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..e5204a63c550 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -118,16 +118,18 @@ struct stmmac_axi {
 #define EST_GCL		1024
 struct stmmac_est {
 	struct mutex lock;
-	int enable;
-	u32 btr_reserve[2];
-	u32 btr_offset[2];
-	u32 btr[2];
-	u32 ctr[2];
-	u32 ter;
-	u32 gcl_unaligned[EST_GCL];
-	u32 gcl[EST_GCL];
-	u32 gcl_size;
-	u32 max_sdu[MTL_MAX_TX_QUEUES];
+	struct_group(init,
+		int enable;
+		u32 btr_reserve[2];
+		u32 btr_offset[2];
+		u32 btr[2];
+		u32 ctr[2];
+		u32 ter;
+		u32 gcl_unaligned[EST_GCL];
+		u32 gcl[EST_GCL];
+		u32 gcl_size;
+		u32 max_sdu[MTL_MAX_TX_QUEUES];
+	);
 };
 
 struct stmmac_rxq_cfg {
-- 
2.25.1


