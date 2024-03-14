Return-Path: <linux-kernel+bounces-102873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1187B7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1CD1F23EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA445DF78;
	Thu, 14 Mar 2024 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iuhg8SSn"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115DCC8F3;
	Thu, 14 Mar 2024 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397538; cv=fail; b=J4nSpEeESv9NIYll3jEEO5ezm3QK5j0I7qzzbTrju/DGlHJRTELtcxGCfJVzv6vzjsnzL0qrTq9lI4vsUGXVMxa60gzSMkZIURbnnfwxrM910uBnwBxgHKAQCBwDwbN/00lmx1UK8ehxts9BsX5cxYyxA+sw6fpj11QCT7LPuvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397538; c=relaxed/simple;
	bh=GM2APZvYheRKRInFIeoh9WcznM8xFkmOlhZHE/7AM24=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=dLHvgNcnUxwu7hbkIGXSDahY0hmczSNFxeHgb88k6RtE4REozdgPgyYd/0AUoawqfQYr7eF78hYmcOPycOqUoT7kmDcjfV3ktzWMik0uVhvWbyOEx74bhwN9S7/U2sn9oiFXPgTFZIFTDBWosnpnv//KQSvHnR4pGlsjn6Wrjuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iuhg8SSn; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXaPrcGt4Yihe0NJFeV6bdxi0B3mudTOi0+VCz6yzzzvbJTiO5dOB/e7XCMdoLBqu0D6enmO86j2MCLjzER/dVONZEX34p6eILuFUjZWPHLwwgI9Aqf9A8SmJ9qH505zgv6uXyd8BcbuVSG9KmBQNAWDMyimi0Btj3LjEH7VQyf6xzb81bzNeWp/Ap2TApjxOBkuOfS8p3bIK6RIxLGhvh/kKNIKlnMyFWgO1PTPUjQ8gJbe8qnpiGJU/4iS3eg3zDeVulXtvSxSYtrWwD49bA43h3oiGfuz2Bq8Mf8ceUf5tK2gakPBfk6q9m+rscS2HuWXrDfMQi02VfyztYoo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRjJ1alIFUENpX3pMk01BUQmdSzcYW1LLOKJoS3D6Cc=;
 b=iYcPeQZE4pqbCdS9BpKldMJnjFtGNBBT5E8COfGiK+BQHH0BZk4nBj4AEAsheN+z6hR7IIYYzlTBBsmDAe8l3hv5wlA8aBNKCuLVE5C+XsZ1o2kwwWjflBw0WlY0dAsZ6MlfZ42vFHXVC9pFXmj/Wprd62uXgnWVgYrhONjibXe9kysz9/N1ysFKTUVjkZww/EVUIGHXJe+2MuzM+TkAlNpMCrb95PqbqVIbG/ykq4iMVUh46vuOvgYtXbUrN03K2Zo0ST4cOfR2z8V1gryqG5FJ6drTvsw4jwbld5LWYVxXCwEnapb+mn/iFTxa5w1yMzlijoe1SJ3W1wGbKN98rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRjJ1alIFUENpX3pMk01BUQmdSzcYW1LLOKJoS3D6Cc=;
 b=Iuhg8SSnLxDcRuyi9/ppOPzks4glENy8dqLkt3TqnWXIUZsnF6L4FoU5NkMQuvtk0EtO2rWwUPP5l5HGSkf6czW5q9QZ5KHH2nbML94J8y16ZbDQ9mOyVKCWqy72yWFqMjBmnKesjTjKKEBV/AmpYOL7qJJVVTD1n5fDd7jeS/DMIg9i/V+tdDyTy5b+ezMaelmCA3xkNQJ9rvFm3aazS9OMPMsmQ9TgFR0umJ9MeWTaL8LRivc0oyGaH7Gh7yNAcv015tkom0QiU6FvfeUCDbxD66pXA7VswDXN5Ug7GSneebmjfeT6OkD7Afcfz/GeseoIljpYnZFLW6MkpFPBNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 06:25:33 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 06:25:33 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-7-rrameshbabu@nvidia.com>
 <20240312165544.75ced7e1@kernel.org> <87plvxbqwy.fsf@nvidia.com>
 <20240313174707.38a71c84@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping
 statistics from tsinfo-get operation
Date: Wed, 13 Mar 2024 23:07:22 -0700
In-reply-to: <20240313174707.38a71c84@kernel.org>
Message-ID: <87ttl9fhyd.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4dfd92-9633-4377-af68-08dc43ef8db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5sdMCJidp8D9OzEVtgq4ehI0gr3VbofOTU6nB33vg+xQ54RyZg8sA3PlZ9dSeNCgewPien4hxQU+26ux/azisNjV7ViT3IVAL2L2ZiOEdzTSvf+8soTMuMsUqB1fs68BbunNlwbHxYUSINBwMjqK9zGufKLPTPwhOeGkXk4MJ0lFgKegYmz2k+gOr/4CFMDHxmwYP3NNlFrHtk9wZc7rX0mO7Lsdut6V4XW58UOtvLHG9I57smK0Je4P9vMx7zSsBie7pBkhL+LDJOy0MDWyebviv52l5apxvsLsqUNaNmkvI/U/unNzTnDc4z8NOek9PVkUdC2/TP46R8Pjp/0njX52mcXURBpAhd9P7aDYYaYSiFcOUfPcL0CWYZiAuSwi1dnBsHA49JAZv9Fsrpto403Cqfq8gaNnBcfUMVzSw9QzbX2l9IDU7fyZb2kgclk1coNlnZGONWLKJvzn+19JUAwMFmnL+xRUCPTIF55S48mDk8lg+UDp6+JV7ffDcmZNXFsvzh2QieCKzJaZD8GCYrYwR0HfwBod1Uj6/cUpB32CR2emZL/7ZQxA+Q4Yj1Cl/aGHuGoUzt8wp/wQBmJ8ulmHgT+sa/2stog1kgAmGrm6xb0Hs7BVTsaWc4vNu0HXt0tzwETwukIchm4Wx1hg6fxf9lncaRFQscK1F6lGYcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XsPikQk1+d02kuwlVy0tZz3mqiPWRQaP8xOVmz5SUHQHE3P8XGzt5MgWwNA+?=
 =?us-ascii?Q?yFxIXWbQ6/9mNNZrBL+fXndJcRBq1FAdgeZuouubUWCPxIFgIYkYFE/Y6isd?=
 =?us-ascii?Q?6PhHx5rMnhx2LGUqD3KlRt3JeP+HkB5bJJpAdyQso5/nenrjmQic7JXwtqy6?=
 =?us-ascii?Q?ReRMuCQHdom5F/GzeuA3pJFzuW3+dobG/Bs24B2/NMcu5Hiy02zFUlcvsDAA?=
 =?us-ascii?Q?IuAB1Zb7hPjhm3zJ77CJx+16n8Bt4bFQMTCzmJa0BxcOh0D3A75GhL04k4b2?=
 =?us-ascii?Q?ZkmkDm90XapTH4NkOiAZ33HZhDSNYM07xcggjY005Rb3DtmwkDxhrNE5+XMm?=
 =?us-ascii?Q?/IDwvhWsDU+psQJ/ycfbvNcvsMA4rq3kwrZiTDdl/r7rgQX4qhFcqw0L/u9J?=
 =?us-ascii?Q?Vm8nj7l+tMmYh4H1PGSiUEXESflQTvVG9lnazUc0QrpmIcqM5ZJ9zLxGxF9k?=
 =?us-ascii?Q?QEb4jXRrHvszmIvXH4q/ABHZeqe6evr7yWmJZyabOufk77wjn38VGfy2xLjH?=
 =?us-ascii?Q?Zqqy92xPaPPrvA51C6CDJ1KT7SkgmRp8FCVefQ3H+TQ/i/4oGYIDLWrjvAmU?=
 =?us-ascii?Q?KN4Pa66LuxnnA+DR0j4mk7NubWAl8GPS83rvDbBtOt5TqN0SeJlrEUlLabCL?=
 =?us-ascii?Q?hvGsefIPF/fE175Qfnh+5bHFPECwripEUD7Za8XAMkjKn3EdJ92eOGFFEvrQ?=
 =?us-ascii?Q?GhKPZBH0nTeEJg1dCfg+Cu18gdKbsntpNY1mQMu3SSTsgVCKuK8nujRBvnQM?=
 =?us-ascii?Q?RVIULGbOjIohgll1nGtxeqJ93tq2ChbpN8iiD0wn/F+saFfj3TCxWKmtjfzm?=
 =?us-ascii?Q?5vxoWb+UXIisIa2sM1uX7WObd5RAG7uGthU6YCDFe29eeaPsBkZWF7vmvmOd?=
 =?us-ascii?Q?kbWoDLhe6vtueFE4ogDoNcThpThoYgPRQTTDzpDT1bIRZRqChzFdl6d0DKZs?=
 =?us-ascii?Q?DuHNBG24EF3rRZguKFzPL+qc9Z6AwQ78pFowwTXG3jKs2B3ntu0P05HFVkiD?=
 =?us-ascii?Q?t/557MQbfY6AiSk2/FZChZ8JU8tvhkOs2sCcZacT1sAOp5eg+Z73E02aWXWa?=
 =?us-ascii?Q?4aarLOU/L9pADQpJXRozyrjy4BCwqSXldXCRtA70TtN5g9yxnL9zdDunEeyW?=
 =?us-ascii?Q?h8+SfTZ+oEgtzuGowedINhV7Vdz/1OAGM9J+6F7axU7zzzTiiU1W7IgLf9ik?=
 =?us-ascii?Q?eTc9hhDwSm2AwshyYrRuBhB5E8iQErWJNmQH92YMvn5AftsVDfeb3iK9WqJg?=
 =?us-ascii?Q?zz/74O+ESVSamQXRuNd2lgF56tbxmtV+Fu+dvfBGf0ITuiM4UGm1SFLgWc+l?=
 =?us-ascii?Q?cbC2yewshXLj3N+tUAzfWPX963wGhjqafkIcnFm7LbaEyHDc30NX38h2QZk8?=
 =?us-ascii?Q?Nw1UGClwq1K5uW2fOEj+2Yyeq7Wg5tyd+GZgER4XEIDNzFqj7CYDWq51geZq?=
 =?us-ascii?Q?l1QvOBbfrPuv4z71R33GCATlh0748zknlptNMGy0gXA3aL98qqzAMfqvwuAK?=
 =?us-ascii?Q?Jk9OuoTH944bUXn+r3Cd+0/Jpyc04Zot1vqbU0aPmQOg6pU117LHJOZ54JY5?=
 =?us-ascii?Q?Ejxrf5Y+is6l5N9S3YkcA4MgyblxlUef6pV+0NwXouxd3cDtWlSn2Ai7dHFV?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4dfd92-9633-4377-af68-08dc43ef8db2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:25:33.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w05cClPe4/Q3tPoG/WjUUwZQ7OYjitUnHPMTEe8dKEWoaNafNBBaChzci6UhrEap67tAYl5Hbw26NAiAKXEUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122


On Wed, 13 Mar, 2024 17:47:07 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>
> Ah, we're missing the enum definition and linking :S
>
> I mean:
>
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 197208f419dc..e1626c94d93b 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -16,6 +16,10 @@ doc: Partial family for Ethtool Netlink.
>      name: stringset
>      type: enum
>      entries: []
> +  -
> +    name: header-flags
> +    type: flags
> +    entries: [ compact-bitset, omit-reply, stats ]

I am running into some strange issues with this even after regenerating
ynl generated/ by running make under tools/net/ynl/.

  Traceback (most recent call last):
    File "/root/linux-ethtool-ts/./tools/net/ynl/ethtool.py", line 437, in <module>
      main()
    File "/root/linux-ethtool-ts/./tools/net/ynl/ethtool.py", line 333, in main
      tsinfo = dumpit(ynl, args, 'tsinfo-get', req)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/./tools/net/ynl/ethtool.py", line 91, in dumpit
      reply = ynl.dump(op_name, { 'header': {} } | extra)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 873, in dump
      return self._op(method, vals, [], dump=True)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 824, in _op
      msg += self._add_attr(op.attr_set.name, name, value, search_attrs)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 459, in _add_attr
      attr_payload += self._add_attr(attr['nested-attributes'],
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 481, in _add_attr
      attr_payload = format.pack(int(value))
                                ^^^^^^^^^^
  TypeError: int() argument must be a string, a bytes-like object or a real number, not 'dict'

What's your expectation for how the request structure would look like? I
have tried the following.

  if args.show_time_stamping:
      req = {
        'header': {
          'flags': 'stats',
        },
      }

  if args.show_time_stamping:
      req = {
        'header': {
          'flags': {
             'stats': True,
          },
        },
      }

I tried looking through the lib/ynl.py code, but I did not understand
how the 'flags' type was specifically handled.

>  
>  attribute-sets:
>    -
> @@ -30,6 +34,7 @@ doc: Partial family for Ethtool Netlink.
>        -
>          name: flags
>          type: u32
> +        enum: header-flags
>  
>    -
>      name: bitset-bit
>
> See if that works and feel free to post it with my suggested-by

--
Thanks,

Rahul Rameshbabu

