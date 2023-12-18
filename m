Return-Path: <linux-kernel+bounces-4339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D78817BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F39A1C21815
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAA7207A;
	Mon, 18 Dec 2023 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFNgTsBL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yuJDSrgk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5D72069
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHXkVB018113;
	Mon, 18 Dec 2023 20:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=NPjz8u/RzULheJVPOtpWendK6KGjybQcV5VGcFkLOXw=;
 b=hFNgTsBL6OYogJdt+ThXfwYrnrlM3fZhJau4u/XDm0dUNNxaeh7qih2PpY0h8T9goK8n
 jOV4mQwwUkhf2qFqEPgicuTf1o+ExCV2LNq+NtQSU98Lz09sc1HC46W6pH/aWuOE2i6L
 bbbByokEPMzD4HT1G11A0gpmbzzMuYdoqqagSFVIUcGrqGo4pxNFINQHgfo/dnMDGXCA
 KP5ngu+Xf6xhNtiJcIo905jeNiy9bjkhe5VuNKlDKXChWsnx3uvprJixFfVjGL4tdak6
 bZ2vGiTAhl9jH0hi6JTAG16KCdJbNHUA3/lbOKTdRwuBaIOeQmeWgmEJ5HgKOubOUIXw cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xdc8f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 20:20:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIJg3kD030989;
	Mon, 18 Dec 2023 20:20:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bbtb3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 20:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeVi1o/AtZKrtE1QarGxTGxRg8LnofE68JJgDks8PNUJNg9C9/aSPc91eo7YOqaWB8rjy82xxm2R6Fc0GB0F20hKyMLX+gsT7Gv9qZmF78t3qZ1tf7cWLiW+Fzl8jtakPxK10a9Mui2qRlG08LAq53NaDksHrVhDIrMvWRPt0uSjxxkP2f9FtBm+MnJu6PC5w+Q/ylwPGF/OoTwFhn0v6Fy7JLjcANSqt9gzOzzvl1nEP1WfzERisccJhFaPDpZDfHsFhXDReqmh22BxOt4s996+nOqPaiGgSIiYZsiLNdPlcONv+CJcEVXZo7Dq6UDd0/W/lakz/L2SGnoDfPpAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPjz8u/RzULheJVPOtpWendK6KGjybQcV5VGcFkLOXw=;
 b=Rro0cBETc/J1ANAANozK4Hb2MqnLe7Fdf57oHI6FxCxOD6aos9LUCCKHESYvoeYLQg/u9D3a7Q0tMphlt1W8yabrgez1wNAsiT6RORlhMdCz+DCX5vRkR0ni80Br1TC5pHyAtLnHOo+mPhretSfk8ofQrmd6S5QRZvvoGk1Rinr4mxB6VRnXkrDoxuQ5qpcQOmwHLdw/lkK57yL9hZpDeA+Cd5TsdDjNqJCnzjprGyR6FsNpklAAKp8p2EujXidBtSoDpCPdAtMz6htRCvwiid+L7QxsxNJEbLc8T6/gYMUqEmJlvN53OOusd72qaLQihFNTTNQB60/U55+kmJz7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPjz8u/RzULheJVPOtpWendK6KGjybQcV5VGcFkLOXw=;
 b=yuJDSrgkcrPCmKYnpCMAkjRtsWLJIGZ9tTuW/C7m5JNGkNoN12X/AflO7BwsY2AblQxyIuvKuB1PN+vEzfZCveU49lWBXZUoM1o+5V/KArBN8usA8a07Gw92yhD39wIS8/qgD5hgRqlAozD/k/+hcruhlLbIn6xovIxddxRvgRU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5594.namprd10.prod.outlook.com (2603:10b6:510:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 20:20:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:20:16 +0000
Date: Mon, 18 Dec 2023 15:20:14 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: Avoid checking other gaps after getting the
 largest gap
Message-ID: <20231218202014.mpotsekdkszasn4t@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org
References: <20231215074632.82045-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215074632.82045-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0307.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc52006-f49c-4293-d799-08dc0006bfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+cwx0nP28HRpm4CilON3ddil1cjN+jKUacBpaXZQiPW4UtQop47zhxhXmfb6gKQBKXl/kzBKisf8iOXvXucS/JyAlqhjsNlRcBFQPXu9da3w4MFQyRNUgHDKAyctbkGm9D/EO6ubrQqpG3cQCaVbTit7KEgugevRuO5XL2pz89YKcK2o2iEfEExFy6hh3mIG6fdFAg69J7ot6E33domqcSwIlopP2GzGaxuVyPCYtQbPvW29e8CSoyLis8OSv0cFZF+VSrsVWk3Y22ojmQ6h5yeL+zh/0iI+nWBYlAlN6oRyk3YCMsNDs7zq6h2ndelyiRdW0w1l430j664F/uAk6xMa464PklIlL8RG2MRySR1Yj0XICPgfjBWfuAwk/g60zwsDnVo+spZgVYI1RbtgID7b4peDNcHbkh3nKEXM2w+Jiv3RAAKLZXTiz61VSbzYupuLXEYNns96V4BCmdQBtOSurL3wsf/9Qse2arnAVygoQAdaR7+XewiYKCDyRbXw41xsJd9Z0iOV2qG00wmsi+7wTB/5GaVQhTaGQ8qG+MwPImDgNT2ko9K+QZ+DRfGv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(38100700002)(83380400001)(26005)(33716001)(1076003)(478600001)(6486002)(66556008)(2906002)(316002)(66946007)(6512007)(66476007)(6916009)(6506007)(9686003)(4326008)(5660300002)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gcy4NjaEOjwuQltxCFjhJiERivFXyB3ce8dF9pAnApSGhtpazq14b+lLgK9b?=
 =?us-ascii?Q?iYKogb8dOsQiIU+mG++9FcRKe2wAjKxGeQ1uSy/JjxjLK/3v3QXijG7WEm4J?=
 =?us-ascii?Q?JSk67IVLqmPSPsNl8v3S8Vu8f/xihHLIpAFbBj1+PfLF1ZtU5iTsIh/qiIpT?=
 =?us-ascii?Q?RXF6GlJCUBBB8QMKraedpuIDQ8mxAHsoLU0bvKj+Rl23V5K2RERFNe2I10vd?=
 =?us-ascii?Q?/3EITLFS40Whdx/wvl5ut9nJdP3xO4D1QlmQBOy48mKvarSx+REg4jLZoZQ7?=
 =?us-ascii?Q?ePPAQeJl+qqn2sibzrtW0Nrm/JJHFeOh8SnHBrdeBzwVXmxE+lGx7fPCrjKF?=
 =?us-ascii?Q?SOrLKCmTcHPZDVdQFCJXZdlWWTK64pNWUDKk4MYZ2Eu/6kOmuzZ5wwZ/Cd9T?=
 =?us-ascii?Q?/xBkBzSmAMJUHzHJ3pEBAxdS1xfbO/6gBCEVPXqtx8RLPIJ19BeqYZR7Njqe?=
 =?us-ascii?Q?2JYLYc4UznP804RqGxJyXcq2KiLRMyuFhWFL1PdUZVAm5SDqqZoKBJGLYx6i?=
 =?us-ascii?Q?3Ql2Ie145wAgU7fIco1nDj0pt3BfQ1gldMGHb5dt3R+g3n4HPy5Tm0KltSgv?=
 =?us-ascii?Q?p6yducgfImxdJjUz1ucFU0rlHVweK5iGu8XFKFH+5fl4ZZ3S8bVxKC3Y4cg2?=
 =?us-ascii?Q?1zfoyzrI1j8PXpVugmQbDccrWr+mYSkzvhKpT1gL2QSJ8vy1EYBzFxYaJB69?=
 =?us-ascii?Q?aY7L02p0EZy357YGkk+cY95/QMl0AczNorh8PhZ5aS8o862AJgupW2fAhohP?=
 =?us-ascii?Q?PlsOVFJe31cLl8IQryla0qmfwbOC7lrMATrk5QncpAOETzsCXhf51lF9sAZw?=
 =?us-ascii?Q?52lKVns8dVtdkPaToIGC1VP0SJHpLMxg9LorKy3ij0+wIX37LFkk5dA/mXJf?=
 =?us-ascii?Q?H8X5qsPp5a7gLSdxl8nI+mma6dMjgvPMd8Y/gq4zW3ODZPvtVFgH5r3rO2tL?=
 =?us-ascii?Q?+Y4qfgfGrqPV7aGL3viG6VBW8OB0BbswbdLg4xe2tjnuUa9eMHckggxR1DUP?=
 =?us-ascii?Q?2K16hy12OTMQWaH0JMeFJWcQENL3CkqpNExpLd2w982vnWAp2k04cKGHBTw4?=
 =?us-ascii?Q?y/JrC+Jg9/vqgtbkURkaAV34JMmQTT8nlRBCMZnDcMxPuyrRm54bYHF70BN+?=
 =?us-ascii?Q?ukdjJC/vCN3NOIKxvC3KFAIP7Vxsrj9sUwlml46Z4RC5PMeXGB2BNRW/Cpd+?=
 =?us-ascii?Q?PEUWkG5cz8pyuXove3J4waG5zdYRyXWkiy0mnxluTYxZs/YGD0daG1jc8tUZ?=
 =?us-ascii?Q?MZA106bSOzmgHCzixT0XR3+QvWxB2wvAR6ePMz2PnrwbGzMSD5vbwyYFUEnC?=
 =?us-ascii?Q?g7/pJ/mKgWIIHiFwa5SegQerhOhc+i3FAviSqxO0SR3MVQEiXVx2o3Uz7j9s?=
 =?us-ascii?Q?JjpIO5wNeV2IrztVwWB7W4hHi4NH6fwhvfUs9GKGXZMxNdK28XMaGePgd6o2?=
 =?us-ascii?Q?uyXt3Z32gqKSZa5kPv4kyYItarVKCxhrg272Wo150INNclvU4MF4S4uURs//?=
 =?us-ascii?Q?EdjYO3+iPSm4ySG734iE88yaGynANIFVuN/kkN4w/5ueCnZLTR7qV5l3/GWU?=
 =?us-ascii?Q?0xziv44E9bdqNQIbzbq58vfk7doCGM3K438YHUSu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IjBxJ6BLdh9DSLdye1IW9+gCbi+Ecct5JtFJc9KPgNxgJmdYUnNsylIIbdEPyUTMngP4jtYTomzdrnoEbAu8fbHB7uUZhBzRRYYuQN3468RKzf6J/DQ4UPi/l4QLdtPjhUluFlEptMtGSmMTBuINFACAFR7y+vugOz3LDBWlhvnPD4z10IIWx4xatns7z7P5JXZFR94PZQxcSVt9Dyq0JVXwfj5NC63+lIGNy0TQmPPsLIjbssXcvJSoLp3VLsdEQoD7fJvOvhOJP82yt3BmdZPG/xNhQzN6iolj2XylLsEBjQ1wO6JSNYXxTwkNCUNLDtdv+/C8WY63EpYTGxxR+r1DsyNFtSZ0TW160cxIrCSja1Xuc9S0opot5IPzh9v2zzoe8blyPfQpHnpeto7Kl8Bm7k7yW/CNtEJKEWeygKLw30zahvDZ1Vn+xsDpBC3dCJSky1Qc/KGbONxv/WWrqr75gUPrHRPNCq/BziTr6XqR5jgIFVgZR8U/KcMg2+g3dZMRCj2YO5l+ITU2cXSEaaEcp+mt/JhXDxOkWZalRokbtty/SNw32C0yclruTIqC9XvRkUBAVyvLXLiuTXVAnQk3YyGlyFAxSHCJzrs6NBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc52006-f49c-4293-d799-08dc0006bfa4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:20:16.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaS8y0BHuzrQLf6nvAKCZ55xLp6xbKix6UGimndEvtAlYg2uTXrnil9cQD+U/a7efmxHJSATjqgSQaLItQPQag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180151
X-Proofpoint-GUID: vzG7SOfqFFF9HphZpP8VRzfc7qrruWAh
X-Proofpoint-ORIG-GUID: vzG7SOfqFFF9HphZpP8VRzfc7qrruWAh

* Peng Zhang <zhangpeng.00@bytedance.com> [231215 02:46]:
> The last range stored in maple tree is typically quite large. By
> checking if it exceeds the sum of the remaining ranges in that node, it
> is possible to avoid checking all other gaps.
> 
> Running the maple tree test suite in user mode almost always results in
> a near 100% hit rate for this optimization.

This should only be triggered for right-most nodes and root though,
correct (mas->max  == ULONG_MAX from just before this)?

I wonder if it's worth special case checking the first gap if the node
min is 0 as well.  Might be worth looking at, but this patch is
certainly worth doing.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index c9a970ea20dd..6f241bb38799 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1518,6 +1518,9 @@ static unsigned long mas_leaf_max_gap(struct ma_state *mas)
>  		gap = ULONG_MAX - pivots[max_piv];
>  		if (gap > max_gap)
>  			max_gap = gap;
> +
> +		if (max_gap > pivots[max_piv] - mas->min)
> +			return max_gap;
>  	}
>  
>  	for (; i <= max_piv; i++) {
> -- 
> 2.20.1
> 

