Return-Path: <linux-kernel+bounces-139601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1348A0525
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94248284B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145BC132;
	Thu, 11 Apr 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="peabpPHl"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2129.outbound.protection.outlook.com [40.107.102.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48D8BF6;
	Thu, 11 Apr 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797222; cv=fail; b=p/peYtDjj7OGINL9+h5g5sTjYA29V0cKB9RlBzym3NignXC6Fac4++xMq583YB7pecaRr2Ly8/dbLU3Rf4rC64B0UEzeIvjwFeGFX2kEg3+TViw0ZXzP8S14kzYh6xzdPiQOsWlBOPv3cmJSpRy9ea5JeUkbLmrh5hNb1ZyNvxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797222; c=relaxed/simple;
	bh=Emx64ixwGCiRuuwJ04gBQaBIj+GHjV60TxZ70JfPSIs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=H6vCa3U9xVcRQaRKzcptLZkmIVxokQyWyGsbPFhF7QzzmkCWXUS0wdE7BVBPv/OifAPj9/UFWIHnc+2gpXsEwvE3fapHMstMdAgJ0ct7LpwOFsOWAxUtrDMizlXXy8EMeLmVAH9cR/UepvZNZNBmsvsco/xkjaVx9eGxBvP/hr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=peabpPHl; arc=fail smtp.client-ip=40.107.102.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNKJI9aChawXk+ykBg8cpdLAAgwijG3kocAtJwDK+0pRMK/aJkCjHYLKnq25p/Whl0g7beZWIk+D+UCE8HbvrRJ47uWz+g4o2SEizhDMIBYkrBkndjv79tKUMEAhIYufTsfLjUmHGzj9N2ukwtkBN5Mau4V5lOep7JLNAZxAVCqauBAuUiQhk5grM0XFR3i2TnUjyY58c0UeVQcR0bYHeHCIK41r6pvu3y2s1g48up6ZT+z0B2CC+Batxva7oSeVP9r+Jj0a0ksxOXzvG5ttHUhfHaIu/G9RQA7yQLW6JKsfq4EHNOgcPNSvmyOGCcGd/4VMHS+OYyjKixVd0YkAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm5g7Wm0ecvor+ttug2L2l1+D/P+B59Es6JrXNeYxdY=;
 b=Jch//PJvU65vFsKivp2Uih5XmAqqHbbDORLY1Xb8XygsbRcU2JW9HjgrA0wGv1UP66cBck6qua3kOyHpGOP1dWgcbyD3YcDETyR238ja31Wa/fyeoHFz0mpOHsl3VWu0VUPT1hlbcWoTW66bu1hR/n45CJp27hTYj2Y5DgHpaPf2UoPdC+AtdoQoxb3IUl483oX9hQ3TdfOvNh/8S55GDp/pNIfNqYistr0kMBOKeXGuqlGmrpRCGUG2hXfcVSBelZfV/sME2Djq8knfbs3iiT4WC6JFmYL5xaJornl7AdSkCybWo+7nmgjuW4IJfWhtQ8pKKjX97OJtrz0eiX7M2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm5g7Wm0ecvor+ttug2L2l1+D/P+B59Es6JrXNeYxdY=;
 b=peabpPHloekI7vJQum+g1umqywsTCKfA1J6yr6Ywq05tbk4eF5xXsT91CzjYB+8yZt+qrvGyGHrOKGi3dxuVfFG79suJsWAaDNIRXflqAfsNP7wQTiS0s5+URUgd99zUls7YrCWFS9qWRMtd7BpZcPUTb3zizhNk2/ltnMcuv4WJn5CYnugf5saDXiUiXZSI4WfLVtqb+sXtjoFaY+z+WpcDn2goJunj1yML6ryo1By1FGbKAgvQy9SQquqAx7CgE8HItbtfUElcJOaBkdwMAIcERTu8gGVWWtp+Ru7fHPWtg2Hju6KPLFWB/vZPiTfjJlCwJBNg6E1EpLaLV/pmwQ==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 01:00:16 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 01:00:16 +0000
References: <20240408180918.2773238-1-jfraker@google.com>
 <661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
 <20240409172838.247738f3@kernel.org> <87jzl5akh5.fsf@nvidia.com>
 <20240410061928.712ff9a3@kernel.org>
 <6616e92cbcca_2bfabf294c5@willemb.c.googlers.com.notmuch>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fraker <jfraker@google.com>,
 netdev@vger.kernel.org, Praveen  Kaligineedi <pkaligineedi@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Shailend Chand
 <shailend@google.com>, Willem de  Bruijn <willemb@google.com>, "David S.
 Miller" <davem@davemloft.net>, Junfeng Guo <junfeng.guo@intel.com>, Ziwei
 Xiao <ziweixiao@google.com>, Jeroen de Borst <jeroendb@google.com>,
 linux-kernel@vger.kernel.org, kory.maincent@bootlin.com, andrew@lunn.ch,
 richardcochran@gmail.com
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Date: Wed, 10 Apr 2024 17:40:53 -0700
In-reply-to: <6616e92cbcca_2bfabf294c5@willemb.c.googlers.com.notmuch>
Message-ID: <874jc8ww68.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BL3PR12MB9050:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	92R+NhYy0v/OpgxOpb0mG04zpEvrVY8jVxslGC8+g116vnnbjfRv/d2DbnahC8ZTSnlM5Ic9MBvtZfv8ZB2krw/1KRoyQiMVri08TnJvgY/1jgZYv6DcWJ2bd0bdTHl4w4VlCmPCf9iW95sFqr/moEIqYRjaYknw6PpsTRyKLNXAz4HdQa3gHo/j5rprc6OLd5fhjNslvQa4ZUwf3dcVSOOT99rrXyj0DjRAoSqq2wfjZZS8ElcOYilIkiw5ePxmOlAY8eXwjHc9BfALJzF3SZfRVkTRGdYsS6WNEW5NNhtyh5jKRS8m8KsRFC0YIVXfW+at/KkXN1CmdiRwxaw2Y72c0ffReCvv2OgA/yjrwHL55YHt/xKPrOUtvfMO6ffVBQ024meq2r4RxFAEs1rFic0q/TEKOFlPcdcIa1FS6qfF+9kvLWZsDrlam0i1ltnxln28W51CbtnkFfjLEeOmaKh8tpmUyU/ABq5bB160klP/y+YotO4tObm1IbMDxS/mzc7aYaPNQo3s6Lr0pVtVqgjPA4jLKj2hunwpOK1wAFTWRJuZG6ODeKuznADxbewAhS8fv4u1bdqXYs2wJscD+Ub1SHIKLI2iFfnbI/pcQVGm9LIDJ8+C+9Xb9rM8qta9+36KfZf8mJNBfXoriAUo73A8Dza5+BRvHMQtaMp33x4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86OAbILx2asy8Dphc0hNp9MjsLF3R+j6OWW5XZB4Gke7H7zhwSh6KD5F3hdR?=
 =?us-ascii?Q?Juikn/Lqv+xHjIz+/5BPoc9OaB9oUt4z4ttTxsRB3ACCF4BFhFVZGSf8d79U?=
 =?us-ascii?Q?v6Wr2qRJsCAD3jPYNliHE0gxnW8frZzzK+V1XUhPi6ePHgsSy2v1STiUNBJh?=
 =?us-ascii?Q?hBDs/TFw2P7x0ztGfGfhraC0VZGU7A3nWMuNCEWqvcksulLayjB6S6rabQC2?=
 =?us-ascii?Q?LEkik9gLl5ohDmVFDBllA+Y6YZ4UvfHHhlFzlyvUdkMG9P4UoihVvFR6fm5a?=
 =?us-ascii?Q?gL9AHJSpf4cywSaEoQ/XFt2CYHf8TXe4dLcxm5MVpk9pOP17zqYA4NdigVEh?=
 =?us-ascii?Q?TSvx9/ldDu5C3VLnEgkTqaUDprVt6GAh5WHFRLcphuqg5n0OcAvgtgLbs/IF?=
 =?us-ascii?Q?cmUFZlz67i6rc+5wSnh0BBtNp1xRnQVd5uKi+Us4CZ3fugI9/IAN+6m4Ay9A?=
 =?us-ascii?Q?ITZx4mCUm+jBsi3RA8Bytd+emB57WvoZXN5R+pm9hyqpyQVPR2V6g6LCPRv/?=
 =?us-ascii?Q?3Sc00BbmuqFrNQRYGtnj4t3giMKkUYCx0zqZaiqUlopIfOUnHd0ghL9IO/49?=
 =?us-ascii?Q?bCrciOCdb9q6shH4bBSWJGCpMDJuy07vp6DDyaPtz7IGslAZEOV51Z2gfnAh?=
 =?us-ascii?Q?HHGS6ZSLw6bRBJitaMk7KGbuVEKo6Zkdl9k2REDNcwt0lOxYLZeI5TArHHB3?=
 =?us-ascii?Q?Nu3rtRreI9X8ioAmGUgpivo3gRP2NyfG8idFGYML7GhEnEiWfMv8IdvGjto6?=
 =?us-ascii?Q?cgcPcqw4YxL7Qv1wyIMl6OgBm4nPOf9eXWbxPuzDyjRKRx5wyT3ydFBDTfge?=
 =?us-ascii?Q?ajQYSg3VX3gAMCHCR4OXPHyONreSoebeBSc6ELa2zg9v3bvjyRcR40lBKHaw?=
 =?us-ascii?Q?xF0lvwQs9UuMhmGftXnlNPx6Y3YFIbIvTn8aT1iK+KsCqM8O6Ta9xxTtjimT?=
 =?us-ascii?Q?KigfkzQAZMixBtfYCBewFhBAaFrsBjwKouDbb+jrlU7kicJHDGUVEbGrD1Y+?=
 =?us-ascii?Q?9vi3s3b1HidkFFzN2/P3fmnIVMdLl6R+N8DUH/uhBKsoSaepu2VDjbifjjfw?=
 =?us-ascii?Q?16yz+6BwxOV1zToKqkCMDOMg+kPiZb5w3CTaq8Uf1vMsD3ofv9YKe8ceo8EC?=
 =?us-ascii?Q?DuvOJMlh9Cy5x4k6EhVydLuqhWoxKBpS099g0mOz7SBnLkgmOUmAuu+X31Z7?=
 =?us-ascii?Q?ZFEChqk5NZOyCGUgiwyHtpWVv66bsJvPrXG5pNc8axvmxLNUkW2L3/r46iWC?=
 =?us-ascii?Q?DzkMG1aB7dzRxt1dJQzc4EUUlUG0HXk9P8+to+FtHIBYTQUikLaAOShGfb0S?=
 =?us-ascii?Q?2TG8TVmEm/T2JIbH3rkjjHljsiHqET3sjRSQ9vnHXk+wQ/9C/AlLh3hVXW5u?=
 =?us-ascii?Q?9QyBAD9oOwzljrjjRCh1Sfq6eOQwK7SUSNFTzSztpqjmEvi7tZNrNfIITHre?=
 =?us-ascii?Q?BOWTlja8ieZ8AVUdOVDiWMidKLPe4Di7YrvT0epvYq8V3l3tJqMsVJuSjhrN?=
 =?us-ascii?Q?mVZU2EYwA4NLT0z6DKgqdvkmrm952fxQEUgxtZ5PpHUkdAZvnvQk2fCsPnME?=
 =?us-ascii?Q?uWtOBZHij9VuudffK6//xZHobqyw9yNSFz6bGK74fGAS+d1rJfE2idwMp6GD?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ef9641-a051-49a9-8a6c-08dc59c2c023
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 01:00:16.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXOHOaytbE/4qKgMlVRQABUe/xD6P7hXtDh59g1TfeX0llPhkHDQVzrHjLNeRYSsrgUcxa1DoyObHBX61p+usA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050


On Wed, 10 Apr, 2024 15:31:56 -0400 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> Jakub Kicinski wrote:
>> On Tue, 09 Apr 2024 21:40:46 -0700 Rahul Rameshbabu wrote:
>> > > My gut tells me we force drivers to set the ethtool op because
>> > > while at it they will probably also implement tx stamping.  
>> > 
>> > I think the logic should be the other way (in terms of the
>> > relationship). A call to skb_tx_timestamp should throw a warning if the
>> > driver does not advertise its timestamping capabilities. This way, a
>> > naive netdev driver for some lightweight device does not need to worry
>> > about this. I agree that anyone implementing tx timestamping should have
>> > this operation defined. An skb does not contain any mechanism to
>> > reference the driver's ethtool callback. Maybe the right choice is to
>> > have a ts capability function registered for each netdev that can be
>> > used by the core stack and that powers the ethtool operation as well
>> > instead of the existing callback for ethtool?
>> 
>> Adding a check which only need to runs once in the lifetime of
>> the driver to the fastpath may be a little awkward. Another option
>> would be a sufficiently intelligent grep, which would understand
>> which files constitute a driver. At which point grepping for 
>> the ethtool op and skb_tx_timestamp would be trivial?
>
> Many may not define the flags themselves, but defer this to
> ethtool_op_get_ts_info.
>
> A not so much intelligent, but sufficiently ugly, grep indicates
> not a a massive amount of many missing entries among ethernet
> drivers. But this first attempt is definitely lossy.
>
> $ for symbol in skb_tx_timestamp get_ts_info SOF_TIMESTAMPING_TX_SOFTWARE ethtool_op_get_ts_info "(SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info)"; do
>     echo -n "$symbol: ";
>     for i in `grep -nrIE "$symbol" drivers/net/ethernet/ | awk '{print $1}' | xargs dirname | uniq`; do echo $i; done | wc -l;
>   done
>
> skb_tx_timestamp: 69
> get_ts_info: 66
> SOF_TIMESTAMPING_TX_SOFTWARE: 33
> ethtool_op_get_ts_info: 40
> (SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info): 59
>
> This does not add up, but that's because some drivers share prefixes,
> and some drivers have different paths where one open codes and the
> other calls ethtool_op_get_ts_info. Marvell is a good example of both:
>
> $ grep -nrIE '(SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info)' drivers/net/ethernet
> /marvell
> drivers/net/ethernet/marvell/pxa168_eth.c:1367: .get_ts_info    = ethtool_op_get_ts_info,
> drivers/net/ethernet/marvell/mv643xx_eth.c:1756:        .get_ts_info            = ethtool_op_get_ts_info,
> drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:5266:   info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:962:          return ethtool_op_get_ts_info(netdev, info);
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:964:  info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |

If there is a desire to enforce all drivers need to implement
get_is_info, would the following make sense? My biggest objection to
this idea was mainly my concern that the drivers would miss setting
info->so_timestamping with SOF_TIMESTAMPING_RX_SOFTWARE |
SOF_TIMESTAMPING_SOFTWARE, which I do not think should be a
responsibility of the driver author since this is happening in the core
stack.

So maybe something like this (taking Willem's proposal for
__ethtool_get_ts_info and modifying it a bit)?

        int err = 0;

        ...

        info->phc_index = -1;

        if (phy_has_tsinfo(phydev))
                err = phy_ts_info(phydev, info);
        else
                err = ops->get_ts_info(dev, info);

        info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
                                 SOF_TIMESTAMPING_SOFTWARE;

        return err;

>
> One more aside, no driver should have to advertise
> SOF_TIMESTAMPING_SOFTWARE or SOF_TIMESTAMPING_RAW_HARDWARE. Per
> Documentation/networking/timestamping.rst these are reporting flags,
> not recording flags. Devices only optionall record a timestamp.

I think this view aligns with my opinion above (though good point about
timestamping reporting bits in general should be deduced based on the
timestamp generation bits set rather than needing to be set as well).

--
Thanks,

Rahul Rameshbabu

