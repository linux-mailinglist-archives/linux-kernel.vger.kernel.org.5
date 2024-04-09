Return-Path: <linux-kernel+bounces-136493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0997689D4BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91055282512
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CD7D40E;
	Tue,  9 Apr 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="VH1mfOfY"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2117.outbound.protection.outlook.com [40.107.236.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3E1EA6E;
	Tue,  9 Apr 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652130; cv=fail; b=RQV8ZaDbyE7I8ysx+CWIlNW6LRy7wq93QFJIDMran3UffOBHdTFW1Oul8ugV1D3FfU9JNrLZhMpwie5yS5vRYyXxmFvF9Memy1cficJPqS0zUaQcxj0bwbjwkP9DEVSQEl2kYIhhHMkouPRjR7hludxRLmXqz70Q+Ox7zrSZDoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652130; c=relaxed/simple;
	bh=L6u5d0+LzGNjrGqNZce9TP+ahYww+UONIPGiytYwP2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skVhIwVIwsgsuFZWHZkdbVIpKJslcp136HrKZshKjYBxC8twYx7smUq/QDLUyOXCBY6tqPIM3nB/I+U4+DKdw70REct1/Q0ScWTXsfTaFURj5dfVYrMDQ55jwL/0YgjRCNfsvfMJ/669tLevMHyu3350XBGHu/RifG4j+w1RGQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=fail (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=VH1mfOfY reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjd+t+J5MadqwVNcoBMHEAc6JT2gJkRxlp2Lu5HKljUf2qzK/5rsjBpMkhx20QZo+tZHO2ShdKeen2QR8iGLGWF/FZWDIIgOIZiEdVlcijz+3+8U2vraJNm4dowf2Oqf+29ZghYMXCLeVgfZF4ajABio3StkerGdcBbsJezvmRAF0k22Krqv5Kkw9SMZT9YQVa2WMjrH0e9yA73V/fQIwhoxwGGNGE7/+C04a244BrAcVhO5I+8vEUnl1Ggsw0mE/CUpJmCJVLohw9/9PR0DNmrV/xGL22oSstkHflNHtBOsbgQBDusw07RuWgVodQUqvFZoqHIPHJA11RcFsVIRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyNt/0saxHwSUt+Ks5qIhs/yvaWrnk07UpVMdGWpPEQ=;
 b=NqsPmnxTxgMoVa8iaBzTpH0T0wWVZz6opqjKE6/6WMNCWqosH9/gjrpcSv6ouwhGvpBnX/WEasnpyJ7ff7Gb52jYeEW5uzDky/5JVtOFPHUCHzgkm3TVn3Wfcxr2oEbhj9EB+4GkP3eki8cbP5dkMi+ZOvysyv69WU389oem2/mcX5B8mDKdctFFmL8H9H3MRCkwgbICsb9hGWMGUioVgj566MVvu3prQ6fxbbtLX8cSeRQ3g3+oqXuGSlt2KllfqFm2Dbqh93REgn51STDEIOrYD5IKoSRKgDv+Z7SqM9uzt6SnDrKipUJfKdAnCd89UjydxkCXyL3Ve0C/wB+4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyNt/0saxHwSUt+Ks5qIhs/yvaWrnk07UpVMdGWpPEQ=;
 b=VH1mfOfYGGPAX91vcZ6uCpTFQQ0qaLP/P5VoQB3n24Ac/b7b/Rn8MIRLxYcs4iMAel9ha6mmNXsyyXFMtn2PqBO1FKcTK4QtAm5dHG2ZKyr4LLvBmmbO6+Yy/sL1BA6XbYyiD4Tz8uq3eZl50Hma4MtmWpVSju2XThCbEZNoyqw=
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by SJ0PR13MB5474.namprd13.prod.outlook.com (2603:10b6:a03:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 08:42:04 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 08:42:04 +0000
Date: Tue, 9 Apr 2024 10:40:51 +0200
From: Louis Peens <louis.peens@corigine.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
Message-ID: <ZhT/E1qDsMmMxGwb@LouisNoVo>
References: <20240408130927.78594-1-ast@fiberby.net>
 <20240408130927.78594-2-ast@fiberby.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408130927.78594-2-ast@fiberby.net>
X-ClientProxiedBy: JNAP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::8)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|SJ0PR13MB5474:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cdyv/JO71f94AzbHsPY18VL/CqjP+Ka6bDDOoBcbDkcvx2nbCRCqUFJc4kR21NAFiPTk8hlo9e8sFZpb05XBDaOs5HV/Ha+FVIqU2Ky4da/kXnq78kXBOgry2VU4Ed/fSbATlfCbufJ58m/c8cbbBFuKcx4PPNYxKYatHHEFNdwDTwPtWtvtJ4b9Si8nB+p/qHwRWVduWpg1VHoGSGy6+PERfhrodtEH0FddecEILJO/aucRYMbkfkkQB6t6g9Out9kEN+a0k7yDwXGlXQ8wEF/bYnyaU6xqQASsMhAb/1mexi+T8u5EquJGNHiU0DYfX5HctjuANP09vSaCtkNs3L6ux1GtLjTyAJygc6fbXh7DLeyG5zvam4499eP89X7Q4O2sZzwu4nrEOfSyzEp/bt4F2aVuByCo2WciNERTSa97lDvX9YIwEEXhC0XhA1791FpcorLvznqCHYc54w/jYbx1pyVOS+08rG1bs+x6U82uyYB15etaLlXMNaaqWkZ0lXrZ3G4l3C8wnPJ9sCNKsVvgCpNIEqcj4NulMqGeli2IxL1qhkajPOLZvxex5WRx22lorMQVEY+E5GKEBU5lSau3QBjftTs6Bd7BpSOiQr7vAnZJv6gLN9BesvkijExm5Q48VDSmV3T5duxZh1EpSMXm9uQqdLoyVqmyBh5DXJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?DzxvpVj+UJmKsxy0bOHNVomFuf7p5PtMqPHl4LzgtKD+sLWhaNgfHrcBi/?=
 =?iso-8859-1?Q?KKhuFPelwz95WVYQ+Aqcgq9KfiF+tqgXJd1P6DdixpaalpOwjgNoAEfai5?=
 =?iso-8859-1?Q?UZqQ4HOlzCpWHgJ3L6Doh/GcTx7ERhf4a/PzjfF39dTS04rY/arl11WYP/?=
 =?iso-8859-1?Q?Z9ZtPT25jshfxh9xGeIsV6FCu00azJBXWHlGZJ5KCyJiFF3Wak/kywv/Oq?=
 =?iso-8859-1?Q?3pCbQw6gnd9jypywaz087fQ1lYWLdGAESjPb1CXlH3um/U8Bb10LHdmvzi?=
 =?iso-8859-1?Q?5Uy0ATxiq1QblYZ7J3Pww6jgzuRbgoVmcW1z6h2jIO9u26QynLbVojk2Iq?=
 =?iso-8859-1?Q?aAE0amRWZdvJ+L5qEs+yUaFSHpkm0WfYraD21IaKBXpdGqBwcRoY4W7zvQ?=
 =?iso-8859-1?Q?KtHgZoVswFSMWlPYHb9Uq+PFzhsePyGyE0vBlM7B0RQffICcB79pgcCTMg?=
 =?iso-8859-1?Q?kJbPHf5e0d7cnJTdWQP2vRX3SL4Db2WJ4HsCX+UfAXwcTyCRyQF9Bhy7zM?=
 =?iso-8859-1?Q?O9UaIMF6o3p82twETFPtPwcWcGZdGKPkIaR5Lp/+wmd6c3HGBS389lL62I?=
 =?iso-8859-1?Q?YAZhZDFalZ8PIwAhX6VxV+hbs848AgHfvu1rmTtM3crwcCr25W5JrBTcr8?=
 =?iso-8859-1?Q?F0NwToz1tveNaecMQwFRK8apaZHdeJBKVIKP9uQTDmGMcOA0DWiW94namV?=
 =?iso-8859-1?Q?W7dLCkMJifdh2uujy2OfsacTxLJHV9oj6DRL7ooCUdqPAxP9tLmjhviio2?=
 =?iso-8859-1?Q?XRRFZMJbkXshRvqnvqOSaF1Zld4XT8GFOJRk3ezZ8grAcxvJ314qCmryot?=
 =?iso-8859-1?Q?lclFGO6K9Dqiglwf83E5bDFIhZdkupqUy7YjMwdEYobO4McXbDcjVrsKFO?=
 =?iso-8859-1?Q?VZ/xwPpVVS7M4jJMgMdMGhQMmiY4KzayLxi7NSm3Ekt5dck57PRz5DWfN2?=
 =?iso-8859-1?Q?DY0RnbTmADXU0Fi1rApKO56ZL5DoxbTFuj6xunrJGMGWlhJfbvq8zL1mck?=
 =?iso-8859-1?Q?/gvJZU/8ThO1Y8dfpOc7lfqB/tvqvtXJ2z/M6xoZlQeX7jTsooLUq60PhB?=
 =?iso-8859-1?Q?aby5TOHk8rCnO+ATSV1oIuD6K0/rExtzdGfdr/W0jRqyvVCt/D/r9ObZ7u?=
 =?iso-8859-1?Q?rk2vCA1OJfIiLhQL/HOTTJSGax4Ng1SrYJBZD1DLB4ilh/j61KsZDdo9kb?=
 =?iso-8859-1?Q?2wXByUZfAjgLOKU3YwZESMIbX8YukaOAvQ/1prthxB9nY7S4yEhxp7vfEN?=
 =?iso-8859-1?Q?79JOVOVwlSnx7K7HPXqcBUmABwj+alitxaZImRRJyJapScDbH8VNAZ2ntH?=
 =?iso-8859-1?Q?85uO/ObwcacAxaoJyWq8thWj6vR4VZKqJYfRqq2MHEerfb9TJ3BDmpWo1L?=
 =?iso-8859-1?Q?e6/a9nPFEF6bvJByuxIldpfgqftksKnEV7B/IdN3Uq/cdbDFnF0zjPGylp?=
 =?iso-8859-1?Q?wwRRhHue7e9y0Q+z773XUQ9CJIbx/n0okkVZiLO0rRBmur3lqtYC3/S78F?=
 =?iso-8859-1?Q?Z0ew5+3RrYKceI3p0zIlfcwikaUZ9jG4xVE8TDcbPZ7b3Np3gtXAc56odA?=
 =?iso-8859-1?Q?ITkzH8l94LXVAZBEwIBQs77yEl4OG/z/S0DaoLOomilIa4ldi5hDPW9jBE?=
 =?iso-8859-1?Q?mycsPXiNA1PDqP64kIYtRXtMvRvSXyUjHpQh3/ZpNoALBfN/oegOoHLQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c95ae35-76a0-4835-6909-08dc5870ee50
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:42:03.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApbcjJJEtWaT7vHVHA0LbgGkNF3FQtbTOZQu7gSGUkFA2L+LkNqQ5XaYYcFZ1/eEtKkmasSgS2tyoCMBI3wQF30ft8eFhGL4JA6NVMybV6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5474

On Mon, Apr 08, 2024 at 01:09:19PM +0000, Asbjørn Sloth Tønnesen wrote:
> [Some people who received this message don't often get email from ast@fiberby.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> This helper can be used by drivers to check for the
> presence of unsupported control flags.
> 
> It mirrors the existing check done in sfc:
>   drivers/net/ethernet/sfc/tc.c +276
> 
> This is aimed at drivers, which implements some control flags.
> 
> This should also be used by drivers that implement all
> current flags, so that future flags will be unsupported
> by default.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  include/net/flow_offload.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 314087a5e1818..c1317b14da08c 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -449,6 +449,28 @@ static inline bool flow_rule_match_key(const struct flow_rule *rule,
>         return dissector_uses_key(rule->match.dissector, key);
>  }
> 
> +/**
> + * flow_rule_no_unsupp_control_flags() - check for unsupported control flags
> + * @supp_flags: flags supported by driver
> + * @flags: flags present in rule
> + * @extack: The netlink extended ACK for reporting errors.
> + *
> + * Returns true if only supported control flags are set, false otherwise.
> + */
> +static inline bool flow_rule_no_unsupp_control_flags(const u32 supp_flags,
> +                                                    const u32 flags,
> +                                                    struct netlink_ext_ack *extack)
Thanks for the change Asbjørn, I like the series in general. I do have
some nitpicking with the naming of this function, the double negative
makes it a bit hard to read. Especially where it gets used, where it
then reads as:
    'if not no unsupported'

I think something like:
    'if not supported'
or
    'if unsupported'

will read much better - personally I think the first option is the best,
otherwise you might end up with 'if not unsupported', which is also
weird.

Some possible suggestions I can think of:
    flow_rule_control_flags_is_supp()
    flow_rule_is_supp_control_flags()
    flow_rule_check_supp_control_flags()

or perhaps some even better variant of this. I hope it's not just me, if
that's the case please feel free to ignore.

