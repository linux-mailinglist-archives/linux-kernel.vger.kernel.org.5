Return-Path: <linux-kernel+bounces-72207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D329885B0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F932851E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CEB44C73;
	Tue, 20 Feb 2024 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iWcaLm8k"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2129.outbound.protection.outlook.com [40.107.94.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF451E48C;
	Tue, 20 Feb 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395518; cv=fail; b=lyA8QrtAuLXmADeC02ZLQKuIYbUPxMyut3y/GVUgrRY+iS3OJaL099uPopQ/jQ5VzM9RColhVG8ARP6WxFvErjpBafw3mVa8xgEvCJyxr5Z+7iBODwuAt5rxLN2Bm9ctShCxzFE1JNkWzeGkzBxzIcQ6hL/huPLda+1QrIYIPbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395518; c=relaxed/simple;
	bh=Kg3RMhdDRGq8pN7y+dhOJE1l9GRcNIuogslkw450Ia4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b/73+mNLBe6iVmDUhDGhkNJ5Jk+8d6XuE3MguXksvclUx8plzUiCNyZCVZJ5WBzb3LXI6WOAcJfZl09D7/KCUtT4HIqoCcfW069CIN+M8d5cjGyhz+aQZf1eVD5iOmTCvr5ne6QkdAD9SRWwPSxvuMHFOz7ScTEPTgpjE5vhxrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iWcaLm8k; arc=fail smtp.client-ip=40.107.94.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMphhUtuItihhgY9h7/2pTjZ7Y+UtJvtSWf8RNLwgUhXlC81AV8M14FN3ynA0onUaBt0SgiJn2g5lqf9MQ+7mvIHqElexxcBuPvvO2+WoBfYw/wqyyQm9yCdvHrp5cM6Ld4TdSpPwT/4VzfcYluICDAMM7Lo8ICMK6E1+pJhSBIEqmME8ZnseIbF2r/VCsx/R7FTQ8qQlGnNbmzqwYHb7dhTLzxa+c51acpz49RNZ80EAL8wusgnouZBjWXSQzYF1cqRX57H87UfgPp+/LK3cGOE3vNs0nvE3QxyGXCGG9Lthy1X76BJDxfsm9LJAGpyaYO3d4LSPDk5T4Fi99bA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yosa5kH4djbgmmtATx8TVkSw3+PBAF+Fgfyl59vGDpg=;
 b=kxlQ7q3HcHzZkfu/N42KrmpuG6Mzx4QQ9ouFyXd+neY/kmaCiXsOHl4sGFvQ5sGI2jpl/dLi7AzvoD0aKirTbpJI952FC9ceBKoe//+jlXACiJnCLb1b9vxrgL27tE4ywahAFTa5r6QlcdoZVC/l0FWfDhEzXsF3OemP/k79o99KZ5TT4TRpscU8Yjq1BWRNNa4IvIZbS/1cf5fdv+Ujei8U9OLcDQrXjM0Mn4gH0DRm+Mm1HVmXgItht6VCrRKYM84tqkTnzA/F5uFOPQJZZTw500SdRDnk/WfJyey18rl5chln4kNrDH6josHWCsRfYKdQuNNy1nfxLbbxJPw72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yosa5kH4djbgmmtATx8TVkSw3+PBAF+Fgfyl59vGDpg=;
 b=iWcaLm8kDY3f1HdYNcThDzAzTxbCjm2jha+CMChEgFxbQTCdL7f+90JM3dCaLz6ZwEgu+36Ky4zypXiFjg+Z/saoMttSvTnE7rikR7rEe/+ksaCTMXzNG7U9b9zhzpny4u+sGyrLu5dyOfOpWRFuyruTZPHVaYgp1H9DNSwsVZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MW4PR01MB6179.prod.exchangelabs.com (2603:10b6:303:67::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.37; Tue, 20 Feb 2024 02:18:33 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7292.029; Tue, 20 Feb 2024 02:18:32 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: kuba@kernel.org
Cc: patches@amperecomputing.com,
	davem@davemloft.net,
	horms@kernel.org,
	edumazet@google.com,
	ast@kernel.org,
	dhowells@redhat.com,
	linyunsheng@huawei.com,
	aleksander.lobakin@intel.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cl@os.amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
Date: Tue, 20 Feb 2024 10:18:04 +0800
Message-Id: <20240220021804.9541-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:610:e7::32) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MW4PR01MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d04598-3016-4484-11a2-08dc31ba3c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/xPe4sdx4wH1Qep6a83tfwoBMbqoDKrvCR37XJ+N+FNESTOnpZUStTZrHD5y4vVDfbvEYjcz/ZUSP7udtOXH5x7bzeCZxyC9xj+Q2UwMVzZnvcZsXquYX5QUSb1kQg19NWeETs/YbrHmWQLoRTaqgmGhIG3TSKBGKw1sWR2o2ZGuO3aGHN9arQ2YOftPwf2dYzpqHNNE6xTywu3NXtglm2SWeeiv8BMCS8HNU1S3iBt+Ja5JbME3IhIANTvlNCsGAviww1MgnQmVncoxjnHSTZFbF7gxSAx/C7E8+5OHDU/1Zv5FULTo2C93I6pFfmp33PaE1V2+jX+9q2w3lroH99mIWQoWHV5FN8f/W6HXbTDE+/4FhLAtWx0Si3rDQhGTl1qzTF0TQoXLCPvNNMgzgUMiA7vGb3ROy9op+fiUbnpgm7rIj/kzTPFC7xfqSmzohKp8y9CfDRT4kh3kcMc/wafu2K9dV0iQGW8rzKF4TNPq680xdmG+fbS/AwBMQ/lZFJEs+7QNGRSNE6ssXSIuge46LeMnAPL9Qav+SPeiaSBPG68h1IAV51h78TILdetRc/pLzY+wDtG9+69o4rs5TAkgKUna6s0IOAuFf/2j4n3AGcuQI/oPb4JCO2Dhsaa7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zACM/W6grIwbFC/FJaxXUnOzeUifkT4du3h15UZPpxqrjcHIaYqt563ifZTd?=
 =?us-ascii?Q?xyla73MscHns6p9/+CXfefHnj0TV3+oRUqQv72Rg+VHh+Bi/zAXeNRr9peCT?=
 =?us-ascii?Q?Qjl9PoHhkqGs1Nl60ZU4LzzU5kpA5uxp+aiNkSyZaR1UIo9352mpg0enkUVR?=
 =?us-ascii?Q?8UrD1cH8M1XZsbIMv9BsDSQi7ToYBX2xzPI4F2u0+czI09nrWHeuaha1L8sh?=
 =?us-ascii?Q?+MkXLD0NfvBVLnQGdbspitdiwmTOe8mJelx2G94lkhH/GR/TE6jQHR2gfMQI?=
 =?us-ascii?Q?RdZx28XGnFn0Y/INJ/R9yOXz/Jtrt6M5EY4IIhY5nEkXxHlU794dWJLMhinb?=
 =?us-ascii?Q?JDHcP9kIFN54RQLRHQdu9bbym1m7oXbis/ZF1WhErRuanzLLZB7QUHdHTy1D?=
 =?us-ascii?Q?Ef27Y08pGzpc2Hr/kXplQ6y6KMqP7hO69AUzVd6jpXLWl6npok6gmBbzPE4a?=
 =?us-ascii?Q?ajclaPYGsxHbmGTHkyVlUYZ1TY8j76zgPSTdmKY6wDRv/LoVR3HmR0r6lKS+?=
 =?us-ascii?Q?a8QY6+bFAgXf49LsRaslfcR/FVjS9q7PkuV0LHYS/K6zTRzbnWi1ZZg1Ef+0?=
 =?us-ascii?Q?3q7da+jlEmh/bcq+60WX4Q8DEw6ErcS7JtgQi6fWO0QQARo9KUYif3xWjLJ5?=
 =?us-ascii?Q?1oW9quhrPMB8QC55d7b2U1XKMISa8IqeTppYQpdxH0JiOWbxkmD1Od2rv4U3?=
 =?us-ascii?Q?NFPFodW7lrG5/CMa1yyYIIfqyg4uXLBSN6FwkkleIjc+ed5kUs+AnDsCcR/W?=
 =?us-ascii?Q?6FOpsswyt5Rkr5Oi1SYrNY8ss37I5FCF9/ILrrtn9DgMmcsBmI2+cBrebP4E?=
 =?us-ascii?Q?nIV30VOzMzxZGlON1qoNTPjZp8UZ7ijthwejvgQ2dez8cx6JvFd2Gm/6niGM?=
 =?us-ascii?Q?vZz969OSc2t05UfUoKspyqbEWAtKGDm3iJ3I1Ypnc+Dg0oP8tbnd7aRdaGlS?=
 =?us-ascii?Q?ckww4kUN+pm/0wsTMQ3awRw/hqtsnZkyMLzXtm7tLajjF4mSnIXYbJFZctzO?=
 =?us-ascii?Q?nW9+uK/RyLKUskMXbq3a7Zx5KBmKKsYEnxIDwgv4eFQvkO4yTzNAYl0hfZF1?=
 =?us-ascii?Q?rCojpMpYG4OrK/48nHfDCO1uI6wYFUcNxz1+LkrRpEh7hSEbQcLAGLm+88qu?=
 =?us-ascii?Q?90tv95QuvlxW9y+rzJoTpi3lZ/pBnRVy2IbQkXuGk6jqZ9n4aev8Au+2zF06?=
 =?us-ascii?Q?szoSDzIt3v4RtR4YeQFdzkUW0amSl+NW/yjsYNorKKRwfyjnG5FyhZaHUFaw?=
 =?us-ascii?Q?nuJnPzytQM8V6ZdwY1zVUjk+flk1i5HrXOKRiV6hfoK2Bp+yU1u8+sto1ype?=
 =?us-ascii?Q?EgqWWAjXPpN05leBXJ6UbI1yVVTBv7R9azLSAjISzfoHvq2mSjtnLBcJI75P?=
 =?us-ascii?Q?0x+dBLjZKpDun7JBpVW1gP18Lyw93XxeRbK9ed/23y52e6+w73CC7q8S5xTw?=
 =?us-ascii?Q?pz8IuBfoL3fp3kXfy9QIc5qNSpaclTQE9YPb5XF2S7FqUUA5vC/CFrWYB+lX?=
 =?us-ascii?Q?GMlRFP+bfepa/7COGcXyi4mY9qe09FQH/+LS09AdHiShSMujd9Ix/AsqiCVT?=
 =?us-ascii?Q?YuEEZy/LpN47UDpgmZ5KbXjSXNhRnalfmHowtHOxZh5kLZ1CIyK86nxNAXVM?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d04598-3016-4484-11a2-08dc31ba3c5f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 02:18:32.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E69ykqQ7vAnjUe7N06L9pbMofuEdE8gzlwmONBjgEPNI9kH0bzGz0Eo0zqzay5b0lg2WSbxPHIzO/tUyu/NCNz2Y82+WlX/CqCraGz4d9lI2mhhXbxBV4aKpD5efGWna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6179

The current code passes NUMA_NO_NODE to __alloc_skb(), we found
it may creates fclone SKB in remote NUMA node.

So use numa_node_id() to limit the allocation to current NUMA node.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..ebc42b2604ad 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1343,7 +1343,7 @@ static inline bool skb_fclone_busy(const struct sock *sk,
 static inline struct sk_buff *alloc_skb_fclone(unsigned int size,
 					       gfp_t priority)
 {
-	return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, NUMA_NO_NODE);
+	return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, numa_node_id());
 }
 
 struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src);
-- 
2.40.1


