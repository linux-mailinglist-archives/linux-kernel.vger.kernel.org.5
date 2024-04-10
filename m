Return-Path: <linux-kernel+bounces-137900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A9889E935
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D67284523
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D416B10A2C;
	Wed, 10 Apr 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NXT98Bi6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BC8C1E;
	Wed, 10 Apr 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724703; cv=fail; b=bIzauLDRBxFqmxgmboQlPZyfMgSwshhdOtpKM7h+cQBsp1fE8AeeM9aGwkDXfwKzfHQLOOcpbNhOBcJgExJwWMYciWNzjb5vcFJDpFUOJcjR9Kni2ztK3D2KFVq4/lXNixXBRFdXG8MnmDRuHaBiGSIh2/BNlahUsdmOq60jV6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724703; c=relaxed/simple;
	bh=KOfdkg7pmTTZnbAQHjhfkGFTBjevo2U+6UPNLtziTM4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=iOVIh3/F45/jsIpbJO43IJvhvGmh67cD6pNCtGPC1lrsv7gZ4jxAo79L8l7i9cpPEPzcn+xZjOHto/GXaNaGygFFWh+WQVXFxSYy34pDg5CLWA7S6I3gW9sfou9e+KcnB6Tebsi3p6xGtv0n9BkJF/er3owd5uBojt2lOJ4zl7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NXT98Bi6; arc=fail smtp.client-ip=40.107.94.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQp6L0KzHuqOW9wf17TTU8xy7b0KOpaOCQ6L8cRiZNarI2c+K++ODJfokZe2qQhRsRfCYWbemLHZDdUDO54R/zMt+M4b78MsQ70Fv5o9BhvyvAmKkhyf0Hz9A1A9cPDL0tJX39NBn1pdlKTw0wjhCK4LXglbCoq/MDxOp0OSMhHMQS9o9DFTHU3z8QAhAVJiNyKpzLeoE67so46/ANTgWnCSl5jW807qGxli6PXdxqLosSsVIjPGrZQDOvuWnwzSxsKim+xTnCI0BftjVULIzidEoXTaQT6Oms89Oxb5EviKO9i4gHIw2CxGs197V7N11gqT/HuAdXL3Ctthz5+Esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqYWPZlAKbhbzazxuFefZuuw6dzZIc1zWybZx7ccs4s=;
 b=l7U4dEx7u3q3QSfEu52sE+bryTyiN7ik9vAw80QcquZw6GUr8Yioh2NQQ7KswN56RZLMKv58Av6Qv0Znj61SUMEu4AkYMJWsoaIyfhm2ccnkszr1CjSV8goVLYbPrjk4nFTNzp37QpNQWQnH1coIggEerlY3nJzlTpGrTBdwfslHJrTemtJPi0W+FgClVgd7D+WwOTKgMeS28SBT8QScwKLl3QnyLD8nAKAWpzWnubW43mne8NeBdBU3UgqfYezs+6cLQ1d4neRiSH3KLKnM4tK/tNZm2bw5JC0sJMxe13TjW2iex9SOd0UtK9DYnBBT8vpQU9m7we5vIzCD/p35gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqYWPZlAKbhbzazxuFefZuuw6dzZIc1zWybZx7ccs4s=;
 b=NXT98Bi6CO7ao37n0flSsUgW7xIhn/kcH68hu/aCEqOlJNzkoTd5bA5WydeQnr9mH0w+AcZO3+Pfx8yvLMub2XCn4ksaILeHPAu41hom9aLG3/pc7W2wvHM6zFmAsMzGmVB0XdCiGZzs69549QvkvCcIxH8dv8+jAMGHLQxpUHkUAcAu6Msiyw7hUByDFJuShru99JV0TPiUi5tg9Besc/I+KTGDiJueO+SafJWK7M7JAFa+XEe5S1FC1F+RyiSbTbj/d4EMYkFnKzitTXALzDD/BYgJCfRulUdJIqsKo3jEqfZjPJ8Wo4ovpur527oe+iXO7vt/66L8iGvwMyEPGw==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 04:51:38 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 04:51:36 +0000
References: <20240408180918.2773238-1-jfraker@google.com>
 <661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
 <20240409172838.247738f3@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, John Fraker
 <jfraker@google.com>, netdev@vger.kernel.org, Praveen  Kaligineedi
 <pkaligineedi@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shailend Chand <shailend@google.com>, Willem de  Bruijn
 <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Junfeng Guo
 <junfeng.guo@intel.com>, Ziwei Xiao <ziweixiao@google.com>, Jeroen de
 Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org,
 kory.maincent@bootlin.com, andrew@lunn.ch, richardcochran@gmail.com
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Date: Tue, 09 Apr 2024 21:40:46 -0700
In-reply-to: <20240409172838.247738f3@kernel.org>
Message-ID: <87jzl5akh5.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|LV8PR12MB9181:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JGEVK9Ok1A5CWUj3RYNQF5aa1YkpBm2N92sir7FUpLXiu+rBAqzsOfQeruOWdAICm9ukWHi1/pBm+bPMG+ghmxmsTJPiJtwhHl8GV6pc7W9EHBHbjznd4Xn/L1868tbwHAUBs4jazfACKGJLjoP7pKOD4cG8Q5UXfAvYkNWnly2Opy9JHwtjoBpGFD486PQCUeli2aCw1MwKN+OinAhJgZABflVSofVMfRlOUV+uWn6ZW8+etm2lVENlomLZLunB04aMRT9Ui6WJlGSukDY+qxNfnVa5CaaIfQNLxU4cvFo7sxhPiTo4N+jTbZIq/GK4Q9b2p4eX2COUm9HDrI4BciBjLxWbyYDq7bWPUifw4ih/Z+3x2iZB6vWgOiRYCsl4saydDRm7MytV4RFXwTkIjvJoNaxTtIDixK5HnNDrod3J0/30atQWz7Vu05ggGNOO6le8m+Ev4/YjWcC8mYaHZzDlYjnye8aCZnMnXqvR4Yd6H24Raxr8a55GMQFZiA4rrjsDObvumz9AnTfjC5iqX3HtxYRRk/4CvcryAwp0Nf3PQLJ5ZZQ9esSZS0svK+AbbCKWuVuFFPL/zZUyJaM6VDRVkqZ/qQ2ZsMYLbbYTxeoFmCZ5mshkrkJMIOyUnq2tsE8fyCRC1mEs5T9Sy3lz4k5xED/oEv1Ies3k+ess504=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXqNgJ7JlZwCsjkpgSWFjpF6FwqPPFd7WFSG/M+D4CBHNfL18wAJVkZ5q7TK?=
 =?us-ascii?Q?eH4LHiLupM/XyeevwJX+G4wUqPbUsVRVS2Jib/Tn3BiafYTAJhfWI0Dya2oU?=
 =?us-ascii?Q?RrTU/yMh0q2wba4JuiBI86haT+qbDgoUeSV7MbnmUOum6O+MiZM1ZO9CHnfP?=
 =?us-ascii?Q?KoH1Rc1i4avuhvhueIEa7sPkFe8fPBpRzhF9/RL8OOt2N9e9+3g5ZA/AW9Q4?=
 =?us-ascii?Q?JKxNm+W291sN8SY30r4CZUouwgwwQVf5DMYn8xDKKoiPgw2GOgziuyDLubwo?=
 =?us-ascii?Q?0uLbH5P4jk2xnHkq7aIxGdN+eH8yFbB5Gef+BsIPGm/1loHiItBvpd0cjP6A?=
 =?us-ascii?Q?vdAJdInLY5cf8kQcXUMRZLI8r/F/EapZUR9x1woDllobZSUaonsS6KsXmVLW?=
 =?us-ascii?Q?tu22aLLE9qrgNmCRlSuBpOllNm/huVh7X4dfSUaHz3TKQqFN/8C7JtSzcL2h?=
 =?us-ascii?Q?wdEEEvKZ1mHP7JyhSvpGImcUSji+mto5XtbTXjOwhnGLmxSfJPgTqYs/uDML?=
 =?us-ascii?Q?D35lyijjnuJsNhmLr1Ec9LA6UFj8ojPqCt/YqJBdnNZgSyXVaYmo1SRwDHz5?=
 =?us-ascii?Q?YTGoK2gnC8UKe2oVX7WAe8ZPqM5Nf/b7f2MgI5oNI7a91kc9qIRuoVhSKFD+?=
 =?us-ascii?Q?zAsdTI0gIax80Gc9yZX69tpsS3h5piBjg2XfRCgHlTrOTqCef25/tGlQZL4z?=
 =?us-ascii?Q?I/4f2YuN/lm9kh8Y3rxkTscFyoKdtRNiO7jCdKybP/2r2ZARzFZnPOazZwIY?=
 =?us-ascii?Q?t8bXkE49c7vOzG0gQ1HvpOV5pVubE5YAWi9lELwvC0mA1//cng2PFehGqZJo?=
 =?us-ascii?Q?XhichhSjgY55r7UzmFdDFV3NCREBuG1y7TVfoSuzcHadN6kd91C2j9HijM6G?=
 =?us-ascii?Q?32++YTJVDqO11FVbnKMU8u/JAF4EPsE3Z1NzxbJqOe4SyoGIpDlS8L8UJVxQ?=
 =?us-ascii?Q?x+2nQTN9KvnoqG9s5giQr08rOvlS5c89G+LMag4BChS8Ru+QwvKOPAO38p2r?=
 =?us-ascii?Q?uNunWnc6VIZel+Yt68rSs56yXmz8pNz6o+3MIIONuHf1cE/K4i4RJwSgh8O8?=
 =?us-ascii?Q?zFjR58DxzhUvq/9d2//9ykyM6G1Dyb0f7mIBG2IxCH5opTZjMYMF13kCDavL?=
 =?us-ascii?Q?XG1mS5/3qsA9L2PZ0tb+c9JL+t8bNVJqhX3weWIE7KsBNolcP705xPdZB2lR?=
 =?us-ascii?Q?rObuoZn7gGbUErffben51A8L64trRSVMsrxkLRvBQmNYgTEmXyuaUYiBNd+/?=
 =?us-ascii?Q?c7LJIRuGGH5tf4k8JZN74W3P5TdmuEmrmUf1UMFKFd+gIMVskEFiehuEOx3+?=
 =?us-ascii?Q?/0oTrUxY5bVKrfajBbHC6oCE5r2BfEdxLKOL+KWUoPxOLO+kuk3is1YnwQhe?=
 =?us-ascii?Q?mz1PfAwPMwdIrxq8pcTYOiqFIibUJZomzX7BAJzu9aFR1agS0VBeRN80ezfe?=
 =?us-ascii?Q?BrNQEMHQFby9Ow9AD2lrIgRDhkfFm9LmwJLLzdZCNe8KxVjh3AenwY1AoZbj?=
 =?us-ascii?Q?Tw9X2CmMuHXSJ/9TGntLj2getUAY/gRyT5cf2dVVdorL8AxKD+V/AZv7ugQK?=
 =?us-ascii?Q?Pt1Y8zPg/WFgjAmtxvPbVLY8kOGV6PW0tHuwkioxKjaDZCGFyVtcj/ZMCH5F?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917bbe88-d6d8-4b57-ce7d-08dc5919e6d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 04:51:36.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81PxZcunekDPbpZlHGUuV4lvqw0cG95cZ7apAT7KiqMDLy3kfLKBpJjY76dttGoR46EPMYRB5KDEJVqzeZ0GeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181


On Tue, 09 Apr, 2024 17:28:38 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 09 Apr 2024 10:29:55 -0400 Willem de Bruijn wrote:
>> This device calls skb_tx_timestamp in its ndo_start_xmit: the
>> prerequisite for SOF_TIMESTAMPING_TX_SOFTWARE.
>> 
>> All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
>> net_timestamp_check being called in the device independent code.
>> 
>> To ethtool timestamping maintainers: It's quite unnecessary to have
>> each device advertise SOF_TIMESTAMPING_RX_SOFTWARE |
>> SOF_TIMESTAMPING_SOFTWARE. In __ethtool_get_ts_info we could just
>> always add those flags to the result from the callees.
>> 
>>         if (phy_has_tsinfo(phydev))
>>                 return phy_ts_info(phydev, info);
>>         if (ops->get_ts_info)
>>                 return ops->get_ts_info(dev, info);
>> 
>>         info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
>>                                 SOF_TIMESTAMPING_SOFTWARE;
>
> My gut tells me we force drivers to set the ethtool op because
> while at it they will probably also implement tx stamping.

I think the logic should be the other way (in terms of the
relationship). A call to skb_tx_timestamp should throw a warning if the
driver does not advertise its timestamping capabilities. This way, a
naive netdev driver for some lightweight device does not need to worry
about this. I agree that anyone implementing tx timestamping should have
this operation defined. An skb does not contain any mechanism to
reference the driver's ethtool callback. Maybe the right choice is to
have a ts capability function registered for each netdev that can be
used by the core stack and that powers the ethtool operation as well
instead of the existing callback for ethtool?

>
> Even more unhelpful point I'll risk making is that we could 
> add a test and make people who submit new drivers run it :)

--
Thanks,

Rahul Rameshbabu

