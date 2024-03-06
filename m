Return-Path: <linux-kernel+bounces-94307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD88C873CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929602864DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D513A26E;
	Wed,  6 Mar 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rEveHPAU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2128.outbound.protection.outlook.com [40.107.102.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E07137934;
	Wed,  6 Mar 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744490; cv=fail; b=pP9z4O2E5oIGaAhTxouumRVTiINvUrOQMiUBXM01wvpraC5wqQ85/gvurzGPoVkrov/VrqAmr0tEO79JBSMm6wXmlyRZovWMA9pF+/16j+L+X4AeazZBiR2xg0udM6+2n4AG893xOC2wOIz6t7m9WUMgKnGh5WZA5PNjc1QsNP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744490; c=relaxed/simple;
	bh=Ra6N6q4oG6vHpEAKKsox0/acdqN4tHr4xLS2rag4Mas=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=sAF2tpuQVAteNmANYw/54l/CO9W5hFER7YOBbYddqBgrtT3HhsK4uZA5+ISjDoIu7ldbIrJ8ao72dZXsEvOePTCfuGQ90uZ4j1r3gFapw36BkX6CI/MRt3QlBdDVDNz5gPFKLR22lKaYkhybu8J3Ym+FnnCavAwCdQZtuC0kT4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rEveHPAU; arc=fail smtp.client-ip=40.107.102.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieGdzMHMNqg342y5XmcfYtQ3SIvgxu80JigMwy4GSU8FDt3lPgNVmAyMIF1bEE9DMGCiJwbHxwAM+5kfuB7spChxlRLzgLlMdyCr8ZaHDZAZVCSkgDHy8Pax/YioZ2X1pzEbt31Xw04II2XxUOBf5rTMx7Dec6yp3HxJdhlo7WjUSJS8MJbnE0eqFHKDY6Pb/ipD2zx4bkHuRF13YNYCTGvl4vZpG8oT3lf6TyI0s8axDMCZiNRpVn/49r98k51wJGe6AB4zzrrBQqCIftcysPA4t205noIj4HXDgOmffi6EiS1vDHGb7kbhqEz/py5Y15qN0PKH3Crkzk/od9D24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjbuVGNqtXSmQelKlggQSDCcT2qOekAHRrxy8Fb00VA=;
 b=CuxZ9IqsUSgyUSttzIleVqKMOqCiBVO/y8VUWS7cbUsite98LKrW7ViV9asH9YtMkC8HZknVc1m0A/nqUqhdz3SIP82vCGdjkOCvmZwHEwnrVak2OdyXu1+VgQdz2heFL6aW8mSxBHCNBnfVIE3moswSm5lpM8uJKvB63pARItw/LLLzqxiRB7m7KJi94P1yGF0QFSsVKkXkJtncFObBjJB03WzMG3lKj1qSMuRKjlATBAyWNvW5fwi3mgijYmSgySNLi7/Ik0NrsKf1Hj63bZ/wJb10CNgZ6m1dcsCNxvBL+g3lIZA3PzDrmAZ/YnDNsGWnbpxcU3SoEUafVBIvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjbuVGNqtXSmQelKlggQSDCcT2qOekAHRrxy8Fb00VA=;
 b=rEveHPAUTIYzL4fI6sekLIVlznWolVVuPQNLe6QY+9b9nPDCgdpBVd7JgiX6gTR4TJNKuBbO0kfW5xT9U3j2rsmmz84rSvY1HtPwCgvc659VpGaVJh8cok/kd3AgxxHmqTL6OjtRSBwzjyB1gbUUYon3qn9jFg9QeSAl1IF/lng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 BY3PR01MB6529.prod.exchangelabs.com (2603:10b6:a03:357::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.26; Wed, 6 Mar 2024 17:01:22 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:01:22 +0000
Date: Wed, 6 Mar 2024 09:01:15 -0800 (PST)
From: "Lameter, Christopher" <cl@os.amperecomputing.com>
To: Eric Dumazet <edumazet@google.com>
cc: Adam Li <adamli@os.amperecomputing.com>, corbet@lwn.net, 
    davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
    willemb@google.com, yangtiezhu@loongson.cn, atenart@kernel.org, 
    kuniyu@amazon.com, wuyun.abel@bytedance.com, leitao@debian.org, 
    alexander@mihalicyn.com, dhowells@redhat.com, paulmck@kernel.org, 
    joel.granados@gmail.com, urezki@gmail.com, joel@joelfernandes.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    netdev@vger.kernel.org, patches@amperecomputing.com, 
    shijie@os.amperecomputing.com
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
In-Reply-To: <CANn89iJAKEUu_Fdh0OC-+BJ+iVY0D2y0nAakGLxWZ8TywDu=BA@mail.gmail.com>
Message-ID: <11588267-c76d-f0ac-bf98-1875e07b58cb@os.amperecomputing.com>
References: <20240226022452.20558-1-adamli@os.amperecomputing.com> <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com> <a8de785f-8cc3-4075-a5f2-259e20222dcb@os.amperecomputing.com>
 <CANn89iJAKEUu_Fdh0OC-+BJ+iVY0D2y0nAakGLxWZ8TywDu=BA@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::24) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|BY3PR01MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae15b9c-d280-42aa-1d35-08dc3dff0c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tHU2SSD6WrI9VVxrr4cbGlmLXO6d0kOiXH1P0M9FX93Zzq8FlTssKNBmhXcFbr11AGByvH5AgdX/Z0un5yZgXFajRYepY9sn+8UjYD/XwzTlemS04uqI4zbKRPsI0dGUfVAFXSVcxEoh26uJoGwxkrpnBL6ZeGJbcji2Jvv0UT4zxqVUBtvyb2Lzo31xu8hF9M/YbKmzHb6tlmI0zXVG1dxXif9NUf9xeb9xQKeQnF/QpkLSf21J29Uim2aWkU3pES8XtFLZdXC0dv0TGku5nnhGRuKlXtOaElQRfEs5nqtzvN9weprlzXJppdz9hC/Q/oRNGRyhmtZ6pSyS7TlLcQdXB3GEEPePECnXdHD3Czsu6zmzdDqvS69V6kFNxizEPHPMB2sRsTXBrRAPSANDPNlOVxP0Z71kdOyI8P8fMkptp57eJ7sowE4H+bOje3Blb1YR90a3Z1f9wMK3hATLYSCrFw1X4zlbaWu5tbbNzPUUDwX+gawV3ROzx6ARPQHgj2loTj0BFv8nni3cuxJ8v7OSPlFcOWGa7Jb1LDMQR+Ts6Ol60YPbi4149vG7ZkyLAxKalqwjxNjQm3+E68TG/C8Kok1F6eMNY3n1kCI+JZYhFuiaiW2QKlcRQrjezA1QAD7uvo4XpcYOjbX62F5sM9t1Bn0i+UjTLV3qVXdfcl8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQHNgdW/MZnGurdbN9+9dmKnVEseChomZAgpKXQPf8KNxW8eyDUoXRiutDK5?=
 =?us-ascii?Q?UPjgz3eF1rBo0jpndhKnLkk2ziokh27/tBQNOSDWVzHw4YtIucAFQfOhwZfy?=
 =?us-ascii?Q?X6qTYbJM4fwnSErZS0JaWNAug2ybORrhMiW1iWh0YATc6nl0PdEAW6qbG4PY?=
 =?us-ascii?Q?4Tc31iuqtthWWrM0LwKG0mi7huYilu5TlXs+Zj9lAgMe6xItvXpGh1EaRdTH?=
 =?us-ascii?Q?h/kvsRjSdhX4Fex0ryZam+/X/hh7qHKo7W++eyEYlj8/1w2+pCMDfbyzbPAI?=
 =?us-ascii?Q?hR+ohBHNwL36trRBrisbiKKk/X+3u86k3uD/mZLmIV2ipL2/rIDndyxEhqAa?=
 =?us-ascii?Q?GYj0ko8LEwaRyQ4Q1Usdg8Vvp63RuvOgBomoTiftmVwUTO3alefu9lCHcZbd?=
 =?us-ascii?Q?sS9VIO2IHeYy5OKHSKNxNkhtUMjMvsB4Mpl3uu9Fy5u9NVBSgLWb4Q/zLqQq?=
 =?us-ascii?Q?3KYwRZ9Mbf1IZZ0DLIV/CwvFgKcNhjgekNHrk3RUj+ye8co6aTgJ88SsmKmm?=
 =?us-ascii?Q?LXn1+1oviQrhPXyXIgIapQvpI7Z4y0USDs6VxnjSt+xVzYDb+rvfGfA8+VMH?=
 =?us-ascii?Q?g5RR9q24lkOLMlCnaEGrphYR8i4xpp9g2viN8Tdkm7uIgshmDURqFAKlvvfE?=
 =?us-ascii?Q?tOaIJ51hAhqBUiqorbH8w8CO2aw4DQbiqbFVw2P4RY37VBcFvWAYB+Ay6Rgk?=
 =?us-ascii?Q?R4tecu82Ydvxs9TRGZE2DYfUIaQuJvvveaMToJC4NXje1dbI7ZOTKIgvYCQm?=
 =?us-ascii?Q?fB7Zb4/hmSguvIX6PUVT6QnxzbtGHAi7jAv/q7aR3wngPvx7u6YEQCEVjaGj?=
 =?us-ascii?Q?sJS8pq1gES8T19T3FwJReCj+roLbDQJRziJnMoYzUt7UbMQ0Q4FQt0TLkc1w?=
 =?us-ascii?Q?GMtfW5CUNvPyAvd/2HDWHI5VlGWWZBuRdy04qw0DM0mgTqk7JuPBNiJ0ZoRK?=
 =?us-ascii?Q?rCtm7L8LS7SyFF6j21ONKGyodQcw2+6/71IwwkaCq4pyvvVQgmZuh0MvXfuR?=
 =?us-ascii?Q?G39RmQsXTY5Q1xYDe6w7CqeiSBVTN1t7nngfw+tylJYylJDfPOcrUnwE6Vrx?=
 =?us-ascii?Q?JQ3jN9UhonKOJSv4DW37cnaD6amB6YqE14anQpvdx3WMbAjm4em4TTbWD162?=
 =?us-ascii?Q?FuCGLHuMbgpM92Al3v3Sv2jdiNGP9+SI8s5t+Pg4gmRSI3wyg7UDoNXKkRro?=
 =?us-ascii?Q?oPGDuscgNYa1bPr4SUOQz+Px/m5i+5UJVtXJNhGrkdoqiXTE1M4yrk8osRHx?=
 =?us-ascii?Q?9QjCCaUkavPiDPU4/1JGlhZ5W/4lscrS7Cj5uQdjnBXkZqGbhfT8Nlsg9wXJ?=
 =?us-ascii?Q?EA90mtA4E3qv6qLXMFpcZosvhTwl2P/G8/nrrHFhT6rnU+CV9mnYll34FoWP?=
 =?us-ascii?Q?TUzcD2R1apV/0aBml9FZc7U2PzAfs4ekUxlGGwZ8VBgWoYllR4zmXk5hrH5l?=
 =?us-ascii?Q?SBacyBwPtqq0Utsn6tNr+i/fmP9aFJWkVUpkgh/BpRQpba6LfTt028ONpT9O?=
 =?us-ascii?Q?XhTRUoMXPxe8fErnOdoVJWimHT2NqgxJezNxWP+HK3AnRW8majk8FKIoZtA/?=
 =?us-ascii?Q?2uP+FPHCUaVzNDn4ZqJpMBZCX8IFcDMs/jWkfygikiVOIraox08t1rnWUZ0Z?=
 =?us-ascii?Q?In6OoeQdKpMwTAP9OtG3mqs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae15b9c-d280-42aa-1d35-08dc3dff0c80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:01:21.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdujYO1ws6lbP9hiNcveAYuVpJCbE3ilgxtlJqTJsUHXH1BiZsd6Xazpk2Y2Ehztqo5fEPv5rSmUPoReL0Rlb5XaIzN7Y9qNVg5zIlKENqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6529

On Wed, 28 Feb 2024, Eric Dumazet wrote:

>> __sk_mem_raise_allocated() drops to 0.4%.
>
> I suspect some kind of flow/cpu steering issues then.
> Also maybe SO_RESERVE_MEM would be better for this workload.

This is via loopback. So there is a flow steering issue in the IP 
stack?


