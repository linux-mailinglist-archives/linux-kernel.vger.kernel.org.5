Return-Path: <linux-kernel+bounces-166715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3788B9E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6ECB24893
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506315E5C8;
	Thu,  2 May 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m9D34r2X"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2068.outbound.protection.outlook.com [40.92.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A060BB6;
	Thu,  2 May 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667069; cv=fail; b=CD9Clqd4iwQ+ft9oVcBfVx8ZF8f5KyKxABFflZak5WSO3RswfVz4x9Hmk5vUkMJ+sER7BssTH06V8+xpard/L2Q8Bdsl12d6mNEyWsT49wLMakjlFnJ7zHOSSmtxyKCouXtk3iIsLdtIG6vqzzSttV5ZJu2iOwfJguM8SSFsilM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667069; c=relaxed/simple;
	bh=bVNKLyA6n0dWmlZyKGOFybLIefho5xgh752hVHf01cA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJzIjXYB79s7tjBT8U51bXxjZcHXoege1FEmHOpj7UxWHHd3f14R7CWTaMp9S//1s5pXGjn28XtpfAcdLUwl1aJLeI0hJc/md299E1waukaQT6CCQxvpCOUp6q8aTDMHZSNBXCclHpeFHhN9UWwRNG1GKLck84Be35OtbRlmkxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m9D34r2X; arc=fail smtp.client-ip=40.92.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1ENYxuzQ/qeqJxQREM4o6AqMnADSKCkMuymyTCdfUt1rvjgjZsZWgsy5YWXZZs/zS90VUG8eXimhPqnDup+dul2XyHCyjMma+qQ6mN8K+tlWq+sN25K5/R2MJcACkq+qIJbEIJyf3iDFOSnQLJvvJCc/+h1EQBzBuuXvghOzDq1D+sLs51dWsLLT3FOQKBCLrsth/vTbbbJ/m/AfOioliIlSTeJMX9xQjxXczvr+L6TfkC7lhjT/RgQC27cW7U7fGljKeac0P8QNt529yBm54zBjjJkn5ScA62JT2iyRsjcXBkA4dW7tsX5bN3d11BnzYM9RhheQf033h3/cos8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQeIbtwU5IEeAQaly68ijqv5g/DPqOnRw1t6sFw1ah8=;
 b=Uyn+t8s+EqBeMKHGrtz8EqkLDzhIsY7mPHYvEo3yyPbRa6U0Q/w6AAYyKP68hDjM8vSMjPLR78BKb9dFNTLUbd/8ovgN6NF0XYamQ2PGP80jItQXkN+PRdTm1AUnE2U7a2fIYQMue5oDr4hL2dpb4NjAr9tte+sCGS1bGlQ0A7Jyu8zj2DQG4Ptq0MIJkYsL/nn6S0JDo34mKSCWMn5WM8ZZY6ixT1sIk/nzUB7ZaGrwV6UwZ3TyMUkLo7PYAaLNMAjYbE56gdd6FCBUqB8jBDjCjBBjjvggWO0F+EvIPxpqmtPCaCBmPEUX7wIuaBXbSr9nDpTKORIwqXWwQZxaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQeIbtwU5IEeAQaly68ijqv5g/DPqOnRw1t6sFw1ah8=;
 b=m9D34r2XOZnsub0GTGTbTy9VQRG3vGjXNSpxxWPYpa7wrUvOHG3WNiv2i0Fv1ei30LvHo7jHOftLLzXVaZKz6Udq2asCSa+R7oXv9nbUgn/KULzVPulxD/xQNnJMacrOYpb0Jp0oMS3igPc0duzvziRkzOl1lkmcIIhg1HXcRoPDddCBMOWI1P8f1uT/cqQ3/y5C6wxQqkkxTuU5GI4ma4Vr4qDX2qfEIF/pTEiLPmP5mJYcH2RgxVaH5U+1cpqKWJGHQUNv55g2Kp9mh7R2iQofdG71ALJ1twxPPev8ooVOuBGjdDE2pKS5aYvuGHB/ZuZUHl8UMj3Epa9fZUqVoQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYSPR01MB6131.apcprd01.prod.exchangelabs.com
 (2603:1096:405:5b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 16:24:23 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 16:24:23 +0000
Message-ID:
 <TYZPR01MB555633BF44D21481AE70FB95C9182@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Fri, 3 May 2024 00:24:13 +0800
User-Agent: Mozilla Thunderbird
From: Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH] wifi: ath11k: fix remapped ce accessing issue on 64bit OS
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: kvalo@kernel.org, jjohnson@kernel.org, Larry.Finger@lwfinger.net,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <6336ffc7-d8ae-4cfd-8b66-d6d91cb0d15e@quicinc.com>
In-Reply-To: <6336ffc7-d8ae-4cfd-8b66-d6d91cb0d15e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [7nbR8KXp8eK7g1IoBFYcl6irf7+9vg2gtUzSXYQ1aFEhIVUVGlpH36UmVZIlHzspXHeKGDp6uJo=]
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To TYZPR01MB5556.apcprd01.prod.exchangelabs.com (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <659cc117-8943-43cb-877e-b01357ac0925@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYSPR01MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fab257-7b0c-49ff-b8d4-08dc6ac45372
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	RxdtUZah0gMJK6wHpv0mTXJUrMMXScfTt+ctCkxBHEqo3ZKB+JRrJK3hvgrAQTVyX+xSSGjgnj76+YU3Zj7Z5x5pVSvwLFOP7jbcG+XKtwJ2xET9u3GGDQI0HhM1eyacDRx7RBuMHbYH0+PvWuCeDQ+Z1SAVnUBerDnkXXo2q+65OkKXkchDrK881OUD3F2Nvd70z1zsq0JzT2AV3GXDt4EBJlzvOAaPG1oNbOzRZrG/7CZloFP5FGT0f8IkJgowJcBm7vkzfm79ciLpuZdC1D6bjqI8dvuvS/2L44jNIPoaBe44SvhHSFcNdeaf2wrs6Gg4ddYDCgJ/3eAYFhg84ULam1gGR11ZsW+U9rYLxdCTY6flmYHuYwa38CXGZOIqIwNQ888RlsnHuFFRki3rpdiCqX/gJaK5DhLWEUlrpxkMYjtMSJCmlMvfi6OyECGjo0d/QZHOf6SthIm73WtZ44xggfTrlsQ+rC0Xx7SpPpal27mrTeHj4hL+E3TtSK+RQ6/xrhPSWLBnrfV56Q7tXo/TGeN9iFBLht+IPBK6l2mJ6CtbFJ9TQxy/wUt5+pFo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDg2UFAvMlNwV1BWSWF6R2R3UFU3WWVuT3BrR21FazVVc3VVSGFrTGhrRzlP?=
 =?utf-8?B?TXptcEJUR0dZV2xoeTJCMk9OdWw3UVNNTlJGT2dxdlBxbGVsVTFheXF4VWRU?=
 =?utf-8?B?dHZ0T1hsREtnRnJBc3BFU1d5cmdlS2R2Z2ZVYkYxS2dUYVAwWERrUGx4bTVT?=
 =?utf-8?B?VWhOM0x5bkVWV0ppUWNqTW5TTUVsK3NBV0w4aUJic3lpWGNsMHZRVUxzeTlZ?=
 =?utf-8?B?VDNtb0dwYzlrclFqQm8xR1NQKzcrMGlCckdFaHJyMW9MaGZZQUJ2VlUyaExh?=
 =?utf-8?B?bXZsMWtuamc0R05kaUlmRHFyQ01oK28zOTZCT3hNY2VvaWhFbzYwWkZEbm9U?=
 =?utf-8?B?TmtnYW1tS1ZjWmtlTW5qaUlveWJSWFdEd0M2eWxyUGJZbWdlYklCeGxpZWU4?=
 =?utf-8?B?dCs0N0xTUkR0bmxhcVVvYjJqQmlWb0thK3RnMmJGd0ExZ2Mxei9paEZxNXIv?=
 =?utf-8?B?aWlYYk51K0pLMXZnNkpJQXRRcTlkQXJJMnVyZkFoWUtpWE5XWEpZQ3Z2bkxV?=
 =?utf-8?B?YjBPZk5UcUI1VjRaWjFxa1Z0WGw2eS9iUjVjdFVoRG1vZU1qRGpBZVZUSVdx?=
 =?utf-8?B?bXZYb2xSYlk3Yzd1aGEvbmdkcDlRTzFCSCtBNDBEWEZCNEFJcng5dW9uNTdG?=
 =?utf-8?B?NENFSWZyNWdzcW95R2FPNVZFeCtNeGxLeG0wcy9tbGl3ZjNvTmlLVndsQ2tJ?=
 =?utf-8?B?RGRiS25SajFWN1dxRXA0OHI5cEFjMnFudnQrTGNtZ2dneWI0Vm1uRTZWOEUx?=
 =?utf-8?B?akFuN2I0N0FWYi9JbVdvR01pdEd2aW5VSEVnaXRGWklhK1pSVzZVdVN5Y0VR?=
 =?utf-8?B?M1ZpTzByMkQ3SUZMUVhlclNBMGdoL1F4RzhFMWgwTE0wR1BiT1FBY0FlSXN0?=
 =?utf-8?B?YXpCNE53TkZsaVZRc0UzOHRDaGxJcDhlZ2dscTNnSmYrNjF1SDlUK3RrcUJq?=
 =?utf-8?B?bHdaM2RJMGdLVmF2TTM5QkhiK1dUTjNaRERZZzNUU1RLWnl0ODRLRkc1TTlU?=
 =?utf-8?B?dlVTcklvdTlyS0t0L2swYisxbGtQbElGL25oSnVXODVlUHlrd0QwNkNXeGh6?=
 =?utf-8?B?UG1uajlQbms0NzcyUTZneWY4dGV4cHRBTHZJd2lQbzlGUURPQWQyTjdPdTM2?=
 =?utf-8?B?NWNJQmI5d3FIQUVLT2ZNbkZzUDcvMkhzckRueHhHQmxtRnRubjNjM1MvK292?=
 =?utf-8?B?MTYxZUdZNDRGaW1BcGtyNmxhYXVUczdHaGdqSmpYbFpEN242elBvcm1wTk5j?=
 =?utf-8?B?c25MUjlGOVFkc2JJSUYrVUZ1a0RHODZzWUhyQXI5RHM4U0NycnlFUHJtQlMy?=
 =?utf-8?B?K0VoNFBJdHJhM0htQXAxUllnSDYrVHpSTWE5eHU0YUhCMTZCMHNXbXFFWE5X?=
 =?utf-8?B?VUZKSHQ4eVJIUWF0d1UvQWNack1naHlqdjZ3YlMzOEdob0lrQ1YrSkFQRERB?=
 =?utf-8?B?bG9Uc2R1QkQ1K1BnM21YZkhLNDlZOWNqTHRrb1BHLzQrUHNnVE1aQy9JdklZ?=
 =?utf-8?B?eGZ0VnAyYktJQll1MWJpM1c2TDd6QXh4UGtmZEFLNUl1SGZwdmNSQjNGOUxW?=
 =?utf-8?B?Ymc1em1sdXZmd2Fsd2FxL25jYTJPckRoQURqMTNzeXJkM0VBWHAvSEUvaUF4?=
 =?utf-8?B?ejZTeTV0a0dXeXJzUWdFcWpaZHJlNnlNQUx5ZXd4blhUTkVaTDd3c3pVQ25G?=
 =?utf-8?B?alB6Z29nMjBzNDFRZHllQTZZTjE5bnE1Um5mY0dUN0x5TkpQWWxMTlczL3c5?=
 =?utf-8?Q?z2c4LHOOFsS2vbNPRE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fab257-7b0c-49ff-b8d4-08dc6ac45372
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:24:22.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB6131

> On 5/1/2024 9:14 AM, Ziyang Huang wrote:
>> On 64bit OS, when ab->mem_ce is lower than or 4G far away from ab->mem,
>> u32 is not enough to store the offsets, which makes ath11k_ahb_read32()
>> and ath11k_ahb_write32() access incorrect address and causes Data Abort
>> Exception.
>
> Are you actually observing this issue?
> Or is this a hypothetical situation?
Yes, here is the log:

     [   14.896160] ath11k c000000.wifi: ipq5018 hw1.0
     [   14.896210] ath11k c000000.wifi: FW memory mode: 2
     [   14.899576] ath11k c000000.wifi: ath11k_hal_srng_create_config: 
ab->mem=0xffffffc088000000
     [   14.904290] ath11k c000000.wifi: ath11k_hal_srng_create_config: 
ab->mem_ce=0xffffffc082800000
     [   14.912593] ath11k c000000.wifi: ath11k_hal_srng_create_config: 
HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)=0x00000000
     [   14.921247] ath11k c000000.wifi: ath11k_hal_srng_create_config: 
HAL_CE_DST_RING_BASE_LSB=0x00000000
     [   14.931115] ath11k c000000.wifi: ath11k_hal_srng_create_config: 
ATH11K_CE_OFFSET(ab)=0xfffffffffa800000
     [   14.939863] ath11k c000000.wifi: ath11k_hal_srng_create_config: 
s->reg_start[0]=0xfa800000
     ...
     [   15.155895] ath11k c000000.wifi: chip_id 0x0 chip_family 0x4 
board_id 0x10 soc_id 0xffffffff
     [   15.155954] ath11k c000000.wifi: fw_version 0x270206d0 
fw_build_timestamp 2022-08-04 13:28 fw_build_id 
WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
     [   15.292858] ath11k c000000.wifi: ath11k_hal_srng_src_hw_init: 
reg_base=0xfa800000
     [   15.292938] ath11k c000000.wifi: ath11k_ahb_write32: 
ab->mem=0xffffffc088000000
     [   15.299549] ath11k c000000.wifi: ath11k_ahb_write32: 
offset=0xfa800000
     [   15.306525] ath11k c000000.wifi: ath11k_ahb_write32: 
addr=0xffffffc182800000
     [   15.313088] Unable to handle kernel paging request at virtual 
address ffffffc182800000
     [   15.320309] Mem abort info:
     [   15.328023]   ESR = 0x0000000096000045
     [   15.330691]   EC = 0x25: DABT (current EL), IL = 32 bits
     [   15.334512]   SET = 0, FnV = 0
     [   15.340030]   EA = 0, S1PTW = 0
     [   15.342843]   FSC = 0x05: level 1 translation fault
     [   15.345900] Data abort info:
     [   15.350741]   ISV = 0, ISS = 0x00000045, ISS2 = 0x00000000
     [   15.353868]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
     [   15.359187]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
     [   15.364286] swapper pgtable: 4k pages, 39-bit VAs, 
pgdp=0000000041a22000
     [   15.369685] [ffffffc182800000] pgd=0000000000000000, 
p4d=0000000000000000, pud=0000000000000000
     [   15.376369] Internal error: Oops: 0000000096000045 [#1] SMP
     [   15.384771] Modules linked in: pppoe ppp_async nft_fib_inet 
nf_flow_table_inet ath11k_pci(O) ath11k_ahb(O) ath11k(O) pppox 
ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject 
nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit 
nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct 
nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack mac80211(O) 
cfg80211(O) slhc qrtr_smd qrtr_mhi qrtr qmi_helpers(O) nfnetlink 
nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 
nf_defrag_ipv4 mhi mdio_netlink(O) libcrc32c hwmon crc_ccitt compat(O) 
sha512_generic sha512_arm64 seqiv sha3_generic jitterentropy_rng drbg 
michael_mic hmac geniv cmac leds_gpio xhci_plat_hcd xhci_pci xhci_hcd 
dwc3 dwc3_qcom qca_nss_dp(O) qca_ssdk(O) gpio_button_hotplug(O) ext4 
mbcache jbd2 crc32c_generic
     [   15.440670] CPU: 1 PID: 127 Comm: kworker/u4:4 Tainted: 
G           O       6.6.28 #0
     [   15.462900] Hardware name: Redmi AX3000 (DT)
     [   15.470623] Workqueue: ath11k_qmi_driver_event 
ath11k_qmi_deinit_service [ath11k]
     [   15.474965] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT 
-SSBS BTYPE=--)
     [   15.482342] pc : 0xffffffc0796774f8
     [   15.489108] lr : 0xffffffc0796774ec
     [   15.492581] sp : ffffffc08256bb60
     [   15.496052] x29: ffffffc08256bb60 x28: ffffff8003ec3200 x27: 
ffffff8003ec2400
     [   15.499530] x26: ffffff8003ed0000 x25: ffffff8003ec1200 x24: 
0000000000000020
     [   15.506647] x23: ffffff8003ec3760 x22: 0000000042c4f000 x21: 
ffffffc0796b0048
     [   15.513766] x20: ffffff8003ec0000 x19: 00000000fa800000 x18: 
00000000000000c7
     [   15.520883] x17: 3030303838306366 x16: 666666666678303d x15: 
ffffffc081356e20
     [   15.528001] x14: 0000000000000255 x13: 00000000000000c7 x12: 
00000000ffffffea
     [   15.535119] x11: 00000000ffffefff x10: ffffffc0813aee20 x9 : 
ffffffc081356dc8
     [   15.542237] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 
0000000000057fa8
     [   15.549356] x5 : 0000000000000fff x4 : 0000000000000000 x3 : 
0000000000000000
     [   15.556474] x2 : 0000000000000000 x1 : ffffff80036b6c00 x0 : 
ffffffc182800000
     [   15.563593] Call trace:
     [   15.570707]  0xffffffc0796774f8
     [   15.572963]  ath11k_hal_srng_setup+0x5a0/0x89c [ath11k]
     [   15.576090]  ath11k_ce_get_attr_flags+0xb4/0x270 [ath11k]
     [   15.581299]  ath11k_ce_init_pipes+0x4c/0x19c [ath11k]
     [   15.586854]  ath11k_core_qmi_firmware_ready+0x3c/0x580 [ath11k]
     [   15.591889]  ath11k_qmi_deinit_service+0x126c/0x1d80 [ath11k]
     [   15.597618]  process_one_work+0x158/0x2a8
     [   15.603519]  worker_thread+0x2ac/0x48c
     [   15.607512]  kthread+0xdc/0xe0
     [   15.611156]  ret_from_fork+0x10/0x20
     [   15.614203] Code: 940a315e f94e2680 8b130000 d50332bf (b9000016)
     [   15.617933] ---[ end trace 0000000000000000 ]---
     [   15.623922] Kernel panic - not syncing: Oops: Fatal exception
     [   15.628610] SMP: stopping secondary CPUs
     [   15.834290] Kernel Offset: disabled
     [   15.834310] CPU features: 0x0,00000000,10000000,0000400b
     [   15.836573] Memory Limit: none
     [   15.842128] Rebooting in 1 seconds..

>> Let's use the high bits of offsets to decide where to access, which is
>> similar as ath11k_pci_get_window_start() done. In the future, we can 
merge
>> these functions for unified regs accessing.
>
> Performing unnecessary tests and masking for every ioread/write 
operation will
> potentially impact performance.

But this is what __ath11k_pcic_write32(), ath11k_pci_window_write32() and
ath11k_pci_get_window_start() doing. Here are the codes:

         static u32 ath11k_pci_get_window_start(struct ath11k_base *ab, 
u32 offset)
         {
                 if (!ab->hw_params.static_window_map)
                         return ATH11K_PCI_WINDOW_START;

                 if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < 
ATH11K_PCI_WINDOW_RANGE_MASK)
                         /* if offset lies within DP register range, use 
3rd window */
                         return 3 * ATH11K_PCI_WINDOW_START;
                 else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
                         ATH11K_PCI_WINDOW_RANGE_MASK)
                         /* if offset lies within CE register range, use 
2nd window */
                         return 2 * ATH11K_PCI_WINDOW_START;
                 else
                         return ATH11K_PCI_WINDOW_START;
         }


> What other fixes were considered (i.e. did you consider making all the
> register addresses u64?)

I also want to simplify the PCI register accesses. For dynamic window,
ATH11K_PCI_WINDOW_VALUE_MASK is used to decide window. But for
static window, we need to use these separated helper functions:
ath11k_pci_get_window_start() and ath11k_ahb_get_window_start_wcn6750().

What they do are:

   1. decide window index, which can be store in middle bits of offset, 
just as
      ATH11K_PCI_WINDOW_VALUE_MASK doing.

   2. for dynamic window, ath11k_pci_select_window() is need to switch 
window.
      for static window, just directly write/read (index * 
ATH11K_PCI_WINDOW_START).
      This is what commit 867f4eeee862 ("wifi: ath11k: Fix register 
write failure on
      QCN9074") talk about. But ab->hw_params.static_window_map can be used
      to identify them. So it doesn't matter.

With all of these, we don't need any other remap function and be able to 
store all
remap informations in {ipq,qca,qcn}xxx_regs.

> ...
> > +    default:
> > +        BUG();
>
> you can WARN but you can't BUG (and even WARN is being discouraged)

Ok.

> ...
> > +    default:
> > +        BUG();
>
> ditto

Ok.

> ...





