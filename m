Return-Path: <linux-kernel+bounces-139852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2618A086E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F53C1C23785
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D613CABC;
	Thu, 11 Apr 2024 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="YrjH2+hq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2130.outbound.protection.outlook.com [40.107.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7B62144;
	Thu, 11 Apr 2024 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816772; cv=fail; b=gzZhzL8E+Dx+JzVdlo6sWf7xw7UVpwgyeS23lD9QHG0mEvsQlslFFaRLd5naP0trkHmu45Nh7lkcpBPtVOHYm2IY75+Zf1vfPLXCYmRFfYW4HLsPTwoCbwxeNLQX3KFsuMkWRHoIyyEHMHaSHYmHaSTxUPNXl/95oXiQEwBMxNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816772; c=relaxed/simple;
	bh=Zf1XqDfwUbsjDJeL3x8Z7509qynbTuEiY21rHnhnI1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lUFHWpDcp96ajDIsD8c5Ym6rtv369ulVtJSIoQVoqBCYIva/AoNtbPooKTPsaTxC4Hn+KgpIsfSvRJWA3A55F3aDMb/QORmNe8sX0MqGdxFyetyINXJyzb/BGFix77xi+SiKFsxu0JI+uRZ/Zv8oErf8Gv9f9GDelKnlqzzcFP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=fail (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=YrjH2+hq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOxe13L1eglTem5Jc2+NmbOBJ5lwktaDhnnVm/XwjG/iqB2YuGtmfYDprZRRjA2K3lSu/p02B/n5ghLCy+/JBctYX7FpdL/nlAokeooUXiOPz3Gc9KubKRf9VmQL2gqLRSe0Gecp2XumBG+MvfRjQ/pZQ18k97YsPEmvHgFH77gugK8rNNA2oqvWdCHPw100hP2wmhjhfqWD2E4P2RLzWkgnBGBObNNGQ/W1qEX9uSGtU4mSZ1o1zcAsx/KVq0htyiUqYbKqgCGzVlDW4WYIPHOO1iW1CbavPMc/03rRPfuEAGn7gm1AaSx4PMZInzMT0DEqFlxtTOcJ3g+ubqzhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdicPNHSfrTJWVpdhxAPbKzsUDKo0XvRxEfNKlteK20=;
 b=mXJ8SDvPgBr+bH+C6l+L22f8pXKsxKSFJwK9Pkq8kQgdtJNabrIbODiCmMjP/RwhLEmEtCPmnkgxOWjmiO+UjS8xZrt0RGTk9x0de5YDK/pSnUGbHP2kgJzOSRQoRDn2PxSrl15QgtlMHJ2fJHdixXxklPiihHL/LKMYbWJ+q4Zqb1kulzaV6/y/9yP7mRKi3s7Co1cM5eC2zKkn1W5kbf4/ai0JaUYmKbKWoBBBs6WNpEsrgUF7R5zuvoB+LPplQxt7Iq3cNRniJ2b/lV3fvYxAZb1mg8cczQ+L6i0zxw5Gj0JX+HDPXyM91a6PMxnncG8VCydCkaJWBjTdsaBoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdicPNHSfrTJWVpdhxAPbKzsUDKo0XvRxEfNKlteK20=;
 b=YrjH2+hqKRnELt3FkU6nvyYyfMcMVxYPLBaIiBn4WxmIjvzLU57Bu4vXX1cGQDiZYHRsKwQtGfRQCMUEgZC7zcJ7mevdtdD447n+1+GVfHSTi3DAX3L4TbrZ9QC9iw3+k3EKMUnRsU+vtI6NMowGDM67hg3/Bt2kporFk5WXMRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CO1PR13MB5014.namprd13.prod.outlook.com (2603:10b6:303:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 06:26:07 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 06:26:07 +0000
Date: Thu, 11 Apr 2024 08:24:55 +0200
From: Louis Peens <louis.peens@corigine.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com, Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v2 1/4] flow_offload: add control flag checking
 helpers
Message-ID: <ZheCN40U2R7ruypI@LouisNoVo>
References: <20240410093235.5334-1-ast@fiberby.net>
 <20240410093235.5334-2-ast@fiberby.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410093235.5334-2-ast@fiberby.net>
X-ClientProxiedBy: JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CO1PR13MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 425a4b15-0e3c-4c25-8852-08dc59f045a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApGPiLY2mBT4OEQCtLjkie93d8wGzkgXKnZchIjquTIChANT9HCBxKCy4uKD8EgrqwbG5nw1hYpLw9pYTzxP+g7o4GOoGQL30r5qNhb3BEL70cKVrO1krt2d2cgudsXvCjjDE0YX03Zz8JXJXSM27kDKeaMFyKf1hEozmfQV8QkvXR/3vLk2Lc3QIp26fuNouzSl0pG6CCAlYpZyHvb7sqP4W9kteNto2VlCui++0T3yaP5MF5yyZp+VLiYAh8XdBC2/661UAOk6x18tt66jOb/IoDwJJJ9i/IrfIC4x2xxROKYMTy5rBoH/eQRkuAdEA1mE7CiKnNQJ46aA+X8ZIVFDcpPGSnzzA1Wx4b91eoZscgQ+ELjcAfuM2I+FSOpMgSg98yrwpEXz7xtaV+9AL9N5qKJLb6Zh/ljuTG9b7NjWOd4zud/EcSJrP0RAhGRiJHK8dDKQx5Lm01vWlRoAw055TPDp6+ZfZtScL38UTRHncdh4H6n2u7FH60ibuY30+zMVlfz7YvZDd4Y5RTsO+ANOUGiJcdGhizM8AWYBVUZ8dgS628QWM8RfMckNTN6T8Xw76NStYkWgVEztv0LQQCmd4LYwo4mQWjsAv1SLDJU+0nphM4u8Ju5Xd5z1U6dk3MevOakHKBjohi7vMgAHFpnoVDoNz84WIvB4AGk5ekM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wG3xzqpDjdgvvtdRIqCNnRKuBWei4cPA62KRnQyXPHaraMP+U4Lge6cF4H?=
 =?iso-8859-1?Q?ilP85g76djbVahzUvkJciTnhaZqDs27/zybkEbY1SwB7zRKM1c7YEgRAHR?=
 =?iso-8859-1?Q?Xkhmv8qtnQhJmxwEpjhtQ9jlzLRr7MLjmgCocJqVwYlWcc1ZJ9Lo9/hr0Z?=
 =?iso-8859-1?Q?8fT3HJe+IGbrva/QLYMG3BBa2VFoqAxjBjHs6TJ9ROjxVnRaEldxvF3UUp?=
 =?iso-8859-1?Q?ffAT5DJipU4BjP3701PueYGWwlOjydrwYcQTP4B6kuwBiSMI05c3Da+GXh?=
 =?iso-8859-1?Q?6PDX+Ey7w5/RHg2vHlJ+RQJ+XpkjbCnUzLzToTjm+ePgo8PhuRqY9awN8M?=
 =?iso-8859-1?Q?S6pae265YSQDP9IZkYBt7sOLZrmnvT3UeHQr2keWGSd4M59BNcKwm6NSuE?=
 =?iso-8859-1?Q?nzrAIi8ACi5+3JvZSQaLYbffP9rqdtHOkk94UHPzESTFCDs5fbOcHnQ8Qk?=
 =?iso-8859-1?Q?8jTm8VogqwX1/rOFSpO5pCMUvnANSsnNM+/By+tOY4TohKe8emX636o3K3?=
 =?iso-8859-1?Q?/9OUVZWvMlajlTmJAABH/PKHGvGwNZ2JzOcBKUNnQmkHzIWp2kx+lHAiCZ?=
 =?iso-8859-1?Q?xJZiCvZN7SAgH9FUGhDHEKBvLrc6SKDS59ESYYcDHnjxuC8bw754bRTcB7?=
 =?iso-8859-1?Q?/tWv02RiruOc7x2KcxjNNbPMshmfhr8sv6JpxFsz2h8J5UiI/F73PxMBxg?=
 =?iso-8859-1?Q?oeEtOIaVbFYSjmQnhdhIJmUU1z7iVeuCDZkYsF8r+/LzB/5jxR2rgAAA9N?=
 =?iso-8859-1?Q?PhhLZwVmLNAvHysg1qCIu7pwliDy8OPFCYzKeH8axPhWDaZLQ2cUP7+F+p?=
 =?iso-8859-1?Q?CoB1tdNnpD6eWElp74bl4jjnD6OSSWY0t0vCRc8UOaUVCcw/7CxxsCylyL?=
 =?iso-8859-1?Q?N7oWS1q3xpjOejcIUjejmnylpYFzHUFm+QomW+Ak/mVu5rLzALfhPwqrU/?=
 =?iso-8859-1?Q?ZiX78w/JqAiyHsvA0bY6feY6mx+dYFNQW+38kCAznrlsui7mMjtYv2oqPP?=
 =?iso-8859-1?Q?zmDhTBVLGSzL4qoAFG7tarcT7SAWxeUc6NBmDSnXYHQA7IwTnXulmLK6mb?=
 =?iso-8859-1?Q?K03pbmXCWnIV/+UhFWRzBK8yPHkzdIOJbKNkygR03B9vT8qVm+Er6mnWIJ?=
 =?iso-8859-1?Q?muDxV+Sq/UpaJg08eoybMkO7iIKHCxQAjPzJhAhglqS9ywhQtOufg+VPXw?=
 =?iso-8859-1?Q?+g3Zgd/Z1J/Cw3ixd/vr6MGX7UYT51aYHOqX3Pfi8edAhYBpamL8oD9a8J?=
 =?iso-8859-1?Q?q+q/Uos4FsAoIwRpEeIRDV+g0JOj+DKfvieREYGHTAfdMgROgmMjfvzioL?=
 =?iso-8859-1?Q?GOEFrnvq41JNBNHwTMTj8MvXmKEvbdoPLBrLFbw3xx/Z2S4kJ3QFkUyUrO?=
 =?iso-8859-1?Q?XfOBaj4FVQEF5DiHW8M5dNNl0L6lk2pGNArbdhYclUkRojj2l9Fri0lf3N?=
 =?iso-8859-1?Q?/06EXeVvVdz/qxoI/89rJLtfWuHwlfFEltOyDnE3XizWLQCJJYP4iwTE3k?=
 =?iso-8859-1?Q?j7BZf662c0QgXV3BJyo/mdLj84o6AHdxkx0RldlzEA5U5JRi6hWChH3oKd?=
 =?iso-8859-1?Q?PGJ4dfwVzznnAsLLdf42lzdDi4c7OijlEUQOloNLzGUFXXLZRyZpuBs7lp?=
 =?iso-8859-1?Q?+V7/u6ZcIycm1MXI8dM20VQaqV1Z8bMszPMQYqNLxEKcHmYl7/WTmQmQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425a4b15-0e3c-4c25-8852-08dc59f045a3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 06:26:07.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjQBxdM/1zF2Jv/M29wYHm4FylVorSUlUQA5zvDXQqmXdlKpotjoTfs7YlG/GIB+HjH9o3bcephLbfe4LQSYgCw4qAHZpisXp/VwPclX/Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5014

On Wed, Apr 10, 2024 at 09:32:22AM +0000, Asbjørn Sloth Tønnesen wrote:
> These helpers aim to help drivers, with checking
> for the presence of unsupported control flags.
> 
> For drivers supporting at least one control flag:
>   flow_rule_is_supp_control_flags()
> 
> For drivers using flow_rule_match_control(), but not using flags:
>   flow_rule_has_control_flags()
> 
> For drivers not using flow_rule_match_control():
>   flow_rule_match_has_control_flags()
> 
> While primarily aimed at FLOW_DISSECTOR_KEY_CONTROL
> and flow_rule_match_control(), then the first two
> can also be used with FLOW_DISSECTOR_KEY_ENC_CONTROL
> and flow_rule_match_enc_control().
> 
> These helpers mirrors the existing check done in sfc:
>   drivers/net/ethernet/sfc/tc.c +276
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---

Looks good from my perspective, thanks for the naming updates:
Reviewed-by: Louis Peens <louis.peens@corigine.com>

