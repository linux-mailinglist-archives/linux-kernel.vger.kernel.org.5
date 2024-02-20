Return-Path: <linux-kernel+bounces-73679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89985C5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7371282ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1214C5A6;
	Tue, 20 Feb 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dzQNd86z"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425514A4E4;
	Tue, 20 Feb 2024 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461003; cv=fail; b=Jy4gyAqnAe4jUYaN/oiihqUHXZypLSpdUXyhzW+HxD2gs1wGnuCeKHaUurvym7PsN3CApSU+oHsEM3l7su3JUd8FVXwGlJ5yY3UZ3nntuuYDE89mYR2GzCZTwqhZVcP4Lc6AqicLN7koePTjZjR/vBEu/xrlx+csvZYo+vbtoOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461003; c=relaxed/simple;
	bh=7NXxyjhpzdF5kD46hFaXaQ7ocothOqZjvD45hQGV7cI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=FQ7+ns40ZBNDHKVMJ5rZyXlqQemPKvuediD+CwR9qz2Iilb2tw8F2FH5dvoIpx6Yjnva7Uc/A8JvtfvS+ZJrbHT49r1mS6bxVusrT3PicuTLwMm5AlvC9n1/rFWKNkTFqRJ5IC++gbrKvGwMw/O7A2EdccEAyIXZe21eJiPIpdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dzQNd86z; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVFJ5SgisfuVsRyp/EJixJJ2Ho4P3p3x1ZMeDB8/R0Q99ec09qR/lI1ltdtaP8QwHLp5Z4Jzs1FiYpRN4HYZw2q/U4SiYkl1V04EW8EFoNwnlHJVWHoH8mKZplHLFgHl1t63GHvxMnu8DU6KSeEkh+yfU420pH/1M+kUBBYYJDdJ+OwzADaaFiDSovhcSs0KkFLxe0Wylv8GU71Bs/KL6bHuR7LeRaUzqc6MIsLmKM7NhXeYEle4so07514NweI+ESjqcvKm5Ul9cSuPCLDLMBG069pqX6zs0hpMiCYFitJRHKH7FuBP0SPTh/sa89ZAS5+mOos4wdSYjl/P3wxe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUCd6k+0G9SvEF4gIlNosCqVOEGAcbN+yNGQNGZ1ze8=;
 b=XmGcVeDHXOiGbZEvZKqU9Q7o3lJhVCP7ayLbW1WAJfkLQOY+Jou0JHyqNF2fMlQQDJUi9Q+LFUqiZqk0HY9goY7sz7Fm3Qd4XA00Z6gL2kNiFMoP/svzP3xCHxBiz2kY2Ie4VP+q9K03GDVKHp1Bpra1T3bSGLy5s2jerAwRpgBumPgTUEqX8MoosXXAUp6bDEzYGlGgM+wHevSNUJxjY243QAPRPyFu9c2m13+k7RiX1l5UiFCdGAXzLqGvNLlV2ZDsWRwSzsvaiCgPVcNjpkLyChL2axZET2yQv3RIJ3HgFTCnoZ3YHB46C0I1/HaBhfseaWfUOohNHeiLHFDIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUCd6k+0G9SvEF4gIlNosCqVOEGAcbN+yNGQNGZ1ze8=;
 b=dzQNd86ziFGiXB+Jzh6CBzF5HI70WhtV52IlYMipkCGYnCJLWMwXW2G1NNEWq1Akl80WzS04z5SiX2G+64V75Gst+qXtKrlEJkO7Yis5UmX8vLjF0b2BKtqVeCRUH32Vs97sYPPjMAApwt0fLNbTw70TksUZZi+EC0k5g2ouTqidSDarf5FRGPcIIJMrSdCBbMZCcowktJFuSUPirowg0xJ/I1EN1pOjcrAkrcF0B/rQ1HwKL2ghmFZ5x/LAM8aRai3Uk6J0+dggyJZZXmVUvqoNtZ7jxNhOR8+fHsGWpE6baWnDhn5N2ekgjkptg6yXQ4YgovHsUbFbKM0j6Vmu5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 20:29:54 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::e127:7911:8149:184c]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::e127:7911:8149:184c%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 20:29:54 +0000
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
 <87jzn4gtlv.fsf@nvidia.com> <b8926fe5-81ef-40ea-9e87-5e84b368b745@lunn.ch>
 <87o7cebx9z.fsf@nvidia.com> <9e2ce7a0-e938-4f5f-aae9-cfee3a066628@lunn.ch>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>,
 Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY
 default timestamp to MAC
Date: Tue, 20 Feb 2024 12:17:52 -0800
In-reply-to: <9e2ce7a0-e938-4f5f-aae9-cfee3a066628@lunn.ch>
Message-ID: <87zfvuange.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 2884f26e-99e5-438c-e3bd-08dc3252b278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	51kUlMgy21Z+YEfc1lmwcrFizJVR8OwJZxevDw1OHk3HuEtSOjuUjLhEtth+w4Z9jokBo2qkkTMuA0+b/uQFHyqXX0hL/Wd1yDUPfQvPpCu0JmOwWtZCLFlrG/OnYv366TXItaGavbAlm6GRPRhoXHWPoXCe8/4HBiijrgPJP63iJ92hq0lkD7leCEZDVAwW5Ux67wAASjaP6zcjQS7qktzWeklqzwOKbaZLZFI3rq9pl/0UV1zT5/D83odIhU/s9bU9EYOLVERKUoXSYyjTO2fO/QK+zB9xmlXthzaEiG5JaYhyRCtrlx8/PlNf6z6mBxdYlQRKmBCpAhDDrFWUlfrnMwU0e4ZEuIoip+txDepjCO1IhuR34tCr1Qk3qDi98tKUQ8qX43ZNuek4J8LzEq6roqoP6CoMgmkkzsdKrR5wB7wTtWBA67y2amsroa9XtqhQaNpmSFM/l+3Dlh9Z2jaEbQr9YoGsXLzpzO+pi2ZusNuIW/9QfeFgqK/xqGehy90uUVVg6Wvp8ltoMvvbktFb/cCkD4IE4UFKY9xXBdmhXSJbfjWp53Oz2f9u9cJYx+1uFfxJt3pQXAYLlkEr/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUZBAdh5soer+JkXvNQP8lSDB1sVBqd3mpOkcVniVdNEoq4YFAxWFu1VRgyd?=
 =?us-ascii?Q?Xmy/aPT4sY1LGhhDyweJiHfJ9EYRsdUltLl0U3t1lcZZhqNg6hdrAUGaIu4C?=
 =?us-ascii?Q?+EzdxuM3EWf86K2dtTuIrRveEvmiRGZJjM050jUY1NNvCheAwDr5sf+N0G0z?=
 =?us-ascii?Q?Brwl83RMMjsYueqGIV2tkV8mLmHd0H5qzP3r9bf3CRZa3GDjV1XzFCq2J2GO?=
 =?us-ascii?Q?2Qo2M041PiotPUhgV/+KQ2r0dn9dTVXloucVdp95fMC6c8+/VAyi6JspRRno?=
 =?us-ascii?Q?TK+0E11d1ebP6xJCSr1ovkqo2iYQAsRC4Rs8seB0Arf+3+BZL8pBSBGQosQu?=
 =?us-ascii?Q?zqiTXnMWsmgElvdeO9scvyDAFNokap5/E056ySasWOiBvqQuPwBbynLMEHYy?=
 =?us-ascii?Q?CF3cTTSCNAyb2CRfH5p1ejs4oC8x4Qtbuiq2M6O3aG+lDGMEO7gG2dbd5Edb?=
 =?us-ascii?Q?D5UOi3dcEpHYArbtH+O5m5/XupjkGMyVpt4F3VYRvw7PAxgVPCDulwKCkO7v?=
 =?us-ascii?Q?6qQqRJ1dN1hBoaHqBQ1ImnMxw8JLsXCMSrnpnqlLNon+Tg/RoSok4H1Wj8ev?=
 =?us-ascii?Q?4XRIJb9I9RxNNA/FrmVVm31LB+xyuiqv8o2JtJqYEitbWtse8j3Pi+gdlIlt?=
 =?us-ascii?Q?UHZ6D4Cii0L/N7AtSGbAwZtSS0VeIeZY23GJh8sQPz+IByQkgEXEzkgt4q/P?=
 =?us-ascii?Q?QYkYKgZ++d3I1oyP7Z4CQ4Adogp5z9l5FTq+dLgV5m2hbfnc8i4ejWhrKI3L?=
 =?us-ascii?Q?GHa+I27pXT1JOMcUgMDYpHoDmKAKq2K5kCveT/EfLHPpAIcFKbN6scHI9C2y?=
 =?us-ascii?Q?clww9odRTzdOqIVyn+vANL1RpOitqu1VIrAiDrCV+3ZGBmRai3hJ0MLIhUi2?=
 =?us-ascii?Q?VSF8ZK8lv7IiB2FSIx3Ro+Sg5jaJCJTebYiAphhAIZV/d4GsQKyEKJtfDHwi?=
 =?us-ascii?Q?UZzqfBow/Qx6/LOMirPYlDPd/zUoicdEC10bW4Spd8FCR+HnUq/QjqlXy9wg?=
 =?us-ascii?Q?A3NGFViBzDUfJ3RBavytFVArKtTRzmAV4FI9QSqn+gsR3aHagSJ0Mlwx0fCw?=
 =?us-ascii?Q?mMfqjzERFimi9bNUbwPaaPpOs4YhWJ/KN/P2HRwJE1SI0blbDAgAdA0RXbin?=
 =?us-ascii?Q?f6d2RxDealwzvOZLx8vYwJYk2r8lpkbYqLiuVjA8Hd4hh3b5UDZEj8BRe0Cj?=
 =?us-ascii?Q?GmXOTu+PeLBOxAAlqOZwu8q8HTSBqx/ysfPwoDx+xnBy/cTixmSCeAFQlcg5?=
 =?us-ascii?Q?KnSIiPOUU0J90+GpWZW84J9whaYNSGTIRc7L7dS8BDuiOexcWOkJ6A/lm/kq?=
 =?us-ascii?Q?SGD/4LMVRZG1MA+b2Hn//etPNKipJq+ckOLCRAbTYeAKzZGreUM0wlSMh91S?=
 =?us-ascii?Q?qwjbcRx43yF8KXWZwkbvjiz8LgZ+HqHBATyqgLZWT2bfqJ0Set9N85jMJrqZ?=
 =?us-ascii?Q?xAxVWNCDd+n/H0HYH8Kz6ZeJDtKCU8n3uW+GiPT5EGFTHfjM5MY7FzjsLuN8?=
 =?us-ascii?Q?yvihNFyWkcUopl31cEldVBmQXRZgAPgZQTEYj7PlGfswKHANU7Bf/azPen5K?=
 =?us-ascii?Q?1L85CywRjJfPCclJ2qxzvl5ovAywDymJMudDhO11cy3vxP4tF6TOn8ZN38fg?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2884f26e-99e5-438c-e3bd-08dc3252b278
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:29:54.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiM2trBtu7XG6UTlrzlrw6g39fJTtt+T0iz/1DgWNrXJhEcHPiPsTfPh7tUNS4Kfbq08uimHUVEO4AAHQXOY+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418


On Sat, 17 Feb, 2024 23:10:07 +0100 Andrew Lunn <andrew@lunn.ch> wrote:
>> > Could you give some examples? It seems odd to me, the application
>> > wants a less accurate timestamp?
>> >
>> > Is it more about overheads? A MAC timestamp might be less costly than
>> > a PHY timestamp?
>> 
>> It's a combination of both though I think primarily about line rate.
>> This point is somewhat carried over from the previous discussions on
>> this patch series in the last revision.
>
> Sorry, i've not been keeping up with the discussion. That could also
> mean whatever i say below is total nonsense!
>

No worries. I could also be off here. I am mostly using mlx5 for my
perspective here and I think Kory and Russell sent some feedback that
likely confirms that this patch makes sense. Will reply to that in a
bit.

>> I assume the device in question
>> here cannot timestamp at the PHY at a high rate.
>> 
>>   https://lore.kernel.org/netdev/20231120093723.4d88fb2a@kernel.org/
>> 
>> >
>> > Or is the application not actually doing PTP, it does not care about
>> > the time of the packet on the wire, but it is more about media access
>> > control? Maybe the applications you are talking about are misusing the
>> > PTP API for something its not intended?
>> 
>> So hardware timestamping is not a PTP specific API or application right?
>
> Well, we have drivers/ptp. The IOCTL numbers are all PTP_XXXX. It
> seems like the subsystem started life in order to support PTP. It is
> not unusual for a subsystem to gain extra capabilities, and maybe PTP
> timestamps can be used in a more general way than the PTP
> protocol.
>

This is a great point to bring up. I think the PTP related ioctls can be
confusing. Rather than calling them PTP ioctls, I think it would be best
to call them PHC ioctls, where PHC stands for PTP hardware clock. These
ioctls are more about controlling the local PTP clock devices rather
than handling timestamps sent/received via the PTP protocol.

https://docs.kernel.org/driver-api/ptp.html

We can look at the ptp4l source code and see that PTP does indeed depend
on the more generic PTP hardware timestamping socket options.

  https://github.com/richardcochran/linuxptp/blob/f271257b799d390d9ec09d5c7dafb7f10a3bd99b/sk.c#L559

Again, I do know the ioctls can be confusing. The ioctls tend to be more
about adjusting the PHCs rather than controlling the timestamping flow
if that makes sense.

>> It's purely a socket option that is not tied to PTP (unless I am missing
>> something here).
>> 
>>   https://docs.kernel.org/networking/timestamping.html#timestamp-generation
>> 
>> So you could use this information for other applications like congestion
>> control where you do not want to limit the line rate using the PHY
>> timestamping mechanism.
>
> I think the key API point here is, you need to separate PTP stamping
> from other sorts of stamping. PTP stamping generally works better at
> the lowest point. So PTP stamping could be PHY stamping. If the PHY
> does not support PTP, or its implementation is poor, PTP stamping can
> be performed at the MAC. There are plenty of MACs which support that.
> So we need an API to configure where PTP stamping is performed.
>

I actually agree with this to a degree. However, I do think it is
sensible for applications that understand their properties to explicitly
select the timestamping layer in the application initialization as well.
I think because of the impact on line rate, the MAC/DMA layer makes
sense as the default.

> I expect the socket option is more generic. It is more about, give me
> a time stamp at a specific point in the stack. It is probably not
> being used by PTP, it could be used for flow control, etc. We probably
> need an API to configure that SOF_TIMESTAMPING_RX_HARDWARE actually
> means. It could be the PHY time stamp, maybe the MAC timestamp. Same
> for SOF_TIMESTAMPING_TX_HARDWARE, it could be the MAC, could be the
> PHY. But whatever they mean, i expect they are separate PTP.
>

As I linked above, the socket options are being utilized by the linuxptp
userspace stack.

>> In mlx5, we only steering PTP traffic to our PHY timestamping mechanism
>> through a traffic matching logic.
>> 
>>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h?id=a6e0cb150c514efba4aaba4069927de43d80bb59#n71
>> 
>> This is because we do not want to PHY/port timestamp timing related
>> applications such as congestion control. I think it makes sense for
>> specialized timestamping applications to instead use the ethtool ioctl
>> to reconfigure using the PHY timestamps if the device is capable of PHY
>> timestamping. (So have the change be in userspace application tools like
>> linuxptp where precise but low <relative> rate timestamp information is
>> ideal).
>
> I would expect linuxptp is only interested in the PTP timestamp. It
> might be interested where the stamp is coming from, PHY or MAC, but it
> probably does not care too much, it just assumes the time stamp is
> good for PTP. But i would expect linuxptp has no interest in what the
> generic socket options are doing.

For timestamping events and being able to generate and receive them for
the userspace perspective, there is no special interface just for ptp.
That said, maybe it makes sense versus having the userspace stack just
make use of the generic timestamping options. I am slightly against
doing something special for the ptp implementation since I do think it
is a typically timestamping application with different configuration
parameters (like which timestamping layer to select).

--
Thanks,

Rahul Rameshbabu


