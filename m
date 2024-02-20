Return-Path: <linux-kernel+bounces-73695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDD85C612
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31701F23B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700514F9E8;
	Tue, 20 Feb 2024 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pl3+2q6V"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41C1FDB;
	Tue, 20 Feb 2024 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462205; cv=fail; b=pNT21Gsfg+gawr1eeIvLeiSi0mVJY74uRSudaj5MILo59AQEXg58lQAUiOx2jkMNApxDFlDNE0/rJxQqB0RD9Aj0I9mu70u4dd3eC6GC6uBWzrhsVoRj2C8aobyBbiGA4b9qAyfDn3rg0i7xNBMaYlLnpWkIc/V0Zcprk7Ss/zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462205; c=relaxed/simple;
	bh=MhG1V7ERqXbOpJSR9Txbscnn9+GxNBAZNSnXCetTt50=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=bp+F7erMcVxnN3N2rPvVpm2mr8ItZCOqap1cVyuygbGZQBGnKh3RwPnPl31GyO6xH+YIPwPXGYhxR5lTmc3kkRGEvXsXLZzOUWRIWYBjgQDCp8q1q7itEXgeS1eP2qUkG/PPNm/2d2c7rl0NY99HNBj9Mf2WI4kTrEjKvjz/3VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pl3+2q6V; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq8otxch7nNpXmaF7JJXz4cQGs38SMik1SOIf9C+drJPuS0yXZ5EJ55cV8ouangDTKO+7kv+W0zZIIqm3i1HnBWbdugb4mywFJoQOWhlRshtcJoye2JcmNif6sD2L7p0/GtNSIs4Z7WJv8K/dnEjVH5vd0t4ZAV0s5etyEAsu/tJzybe+sjX8KOXhgveiZkeY2pDxWpAECn3Ld+yhtslqfeDf1gxf4VfbEcmZG6I55/z7p/sWguaM3cR8npXCUFCDKA9uW1/r0I5sHx4aP2j2QX+KxEV7gdj1JeLiOXrMcSm2M0PbgWvNojWbHkNzbkgSCYkyr0hujAR4AmncKIo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhG1V7ERqXbOpJSR9Txbscnn9+GxNBAZNSnXCetTt50=;
 b=cPBxZddqD2AniTlXDGgmS7P5/6FWiOi/BTl/YFwM3OjmhFnDA/ImOPr4pvRrIWitdByX4hlAQ/Z3llU2B34n8aw/xSnmH/CUnHxz0M6v6crF/PlNAnnSmo3YiZr8LeHJ7ekE2m+cSRoppOdRyGEDfacrHIh3d4yE6WGPRw/2DhcutnVyO8ZiFojimuZ9UROhBYf2g7htpguPpJAnkl1InvkFN4hpIShnQjl58OnV5xsfgnOT0t6MK5HejIlyLZahElbg+CIQ8CjJn1MYSecjNFmVDi7t0ou5EzXzASCIS3IKzXzI4WeWUy2STWbl1LOdsNSVL3Hrf88gm8yLY+qpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhG1V7ERqXbOpJSR9Txbscnn9+GxNBAZNSnXCetTt50=;
 b=pl3+2q6V1zmezyURho9AaaCpu6eXGeztunOEbDMlqZBxM4Nsk2JzEUy7TNclRSVgd+7lgOucKN+HTD/o8kcYtrZpoyTC0Qk6Q5Vils9fjaMHS+yh0lJaEbOi+tb/puPoM5C5tGg+Nbzok39Nrb08wVgxgHkk+Er8BGYnmG9dcaGOyDQpPcLFJ2Xl94X2O6SX+E6Dygg9ogLL0UIavf5PmW7MUQDgFgohZ5eTk23aO1XfdNc9PCcXB+XX11b1YnJdnFrcHW/1fwYYqxGLLgLlkF6WvdyIvnrl6vl/Q4jTw5D7hfBXGo3569zk4foP+un5XBkN3Q9ZdnTWfi+WlBZr8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 20:49:58 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::e127:7911:8149:184c]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::e127:7911:8149:184c%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 20:49:58 +0000
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
 <87jzn4gtlv.fsf@nvidia.com>
 <20240219142936.62112d34@kmaincent-XPS-13-7390>
 <ZdN9pPf3wXwE/9nX@shell.armlinux.org.uk>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?utf-8?Q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>, Florian
 Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY
 default timestamp to MAC
Date: Tue, 20 Feb 2024 12:39:19 -0800
In-reply-to: <ZdN9pPf3wXwE/9nX@shell.armlinux.org.uk>
Message-ID: <87v86iamiy.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a7fb07-b885-4dc6-ccd5-08dc32558011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	07obyS9swFByein7C7bU/sDCEUrWUxDkD4iq2LTSArC4rW39cup4PCtzhQ/vCmHHBn7ZAlNTBbbB1I47Stb0KuGxnVlVEh11YAJHJASQOrq68n4RnyFDDmIQ63H2h2hTOlJu86PHwCwyG+Vy/aVfcn4iCBzFs710dP8jzJhS2bfIhNg930Ae3DUBbPTBcmNsADM+BpQfxNV5+PDvrUc8AzNQt91VabvaQaSj/twESvF7gnMzbQsen6NRohMzNuywTAipl1ja5jpwcg9KRMfXXBuVqdn2L3rItU8MKGe8jOVE1ebLhseoJPYMM3URvJh5QbWSjDuXvzuIe9jY/dmwW3YBZ87BPAu1M/7Q2ySNOPryizIN2RT8wjx0euMF3LaS0mcYkOSh6UcpK+L/9SODMyxQ2+zORRnWiYtujXJikjfw/X1s4DU4li/7OTWefCXCtBPhSeaB9pVhmF80REHhXysniAkQS5MMQxDsB7QYf0tWYzTaBBRwP5F8tJjZgC2T9qNZffhm3xBkCUpN802E++y80b8K9pIeT0XJ1kBUX8PWXBzSIar5RS12csM6w5nYnuiCIjkHe3pUiocB2QCB+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2NlWk51Ti8vRVVPa3kxNjlpbVJBbjJhcjZPYi9SM3BSY2wwWERQblFDUFpS?=
 =?utf-8?B?Y1pPdjBqQzBqMTVpQWF3dmw1TjJKS3F0MFFHajBETnBDZGdzbGR2VFRIaTFa?=
 =?utf-8?B?b3R6QjNJZHRzSVZrb3Jmd29qR3B3TUJEaGV6S0FjYXRFbVJpWThDR0pFUG9l?=
 =?utf-8?B?dktJQmFrQjZ5a0grV2U0Vmc0anB5VjMxM0tLSnBJT0hGQzZzdWxvNWlVc2tw?=
 =?utf-8?B?QlBIZVNLK3dyZ0dLVEFrYlJ1czZoaUtxeU94YldrOWJBQ3pIcXQrOGU3NTlM?=
 =?utf-8?B?Y20vMStDOFlzUGJBQnRFSVN3Qjcxd25zbGkrSlZ5dU80MTJPS1QzYVRzcFFR?=
 =?utf-8?B?THFvMG5lOXJpRTF6MTE2SzBJZUlYalIzd3RIRzY4ejJsUjl0L3JuYURFeDlY?=
 =?utf-8?B?b2YzRE0rNzFMa0F1OXpNYm9KSW9QMW13TDBiU1lVR1hUNERpVGpTL1FRcms0?=
 =?utf-8?B?RUJQYW9XUjUrbEVpbXdMRjRsMllmc0dNN3RyZlVCZVBIY1NWdXA0UEEzdmdu?=
 =?utf-8?B?cXVOOTUxWmtSUFhBWG9Jb2RGWjA3dExacnNBZFpLYitFWWZvVlhKSnRic2l6?=
 =?utf-8?B?TUkvVDcxMWNsRkJlVU01dXVvZWc3bDRSc3c0M1NuYWczWHNyUHJVR3JPMi8z?=
 =?utf-8?B?dGZJcUVib0U2ZWYreFNjeFJyN003OUFwZ1ZTQ2FVdXgybUtRSGZTM3pKNjRn?=
 =?utf-8?B?cFVOT3NpSkFXcmtjdXdhbVhxbTJLbTVTdmVWbWNwTTFKMndVTGw5c3YyWkc5?=
 =?utf-8?B?WDhadDBIbVg3YkN5M2dJMnYyU2RuKzBMUks2RVYwZHcxVHhGalREdjBLVGhT?=
 =?utf-8?B?QzJQYzB0djZ0T0VUSXQ4TUc3bWZaemNrd0swTU9qUStQVlhBQXJhV3RwSFZv?=
 =?utf-8?B?MlFWVWVQdlZhbFNZclI4bk5JcGxGVVRRWlRubFp3U2d1RytjcGxpb2s3YVJi?=
 =?utf-8?B?ZzRXeVA4amZEdGpjelN4elA2UEsyYW5pcnpHSUNoS0lzNWhpWnhua290cXFO?=
 =?utf-8?B?Yk50TGE4ajU5RlFNVnhaZFVMbW5pTWhYRWY5d1NzK1I1blhFZWxvKzBkWUZI?=
 =?utf-8?B?cEx5VTZIYklxUndNYU5JVlkxZWN5elUxUmN6cWhlMVVmZFJxZzVMRzZVYVBC?=
 =?utf-8?B?cWZ6WHVEZWRyUWM1ZEFSRlJ6dGxORWI2QzZRWGdJT3BZY1I1cGx4NTVPWGoy?=
 =?utf-8?B?YXN0eXRJb0p2S1dsd3lyaXZSaUdWcys0OEp3Q0F5YUVMcFRiWC9iOXkvWGJV?=
 =?utf-8?B?RzJybEVkb2lvS0FvdjNxRmY4Ujh2emthUTZOZWpoa2lxbEZVWkgyYyt4dVd2?=
 =?utf-8?B?SGh2S1N5N3pUenpPQkpjZGhDSHZmbzlUWWdJMFpwZ0FRMWozb1pISEh6a0VH?=
 =?utf-8?B?TnRtZUVFWXZpVTVGeUhIandqUmtRWDRSNlNTbE93emMwOWdyYnlzQkgyLzdK?=
 =?utf-8?B?NFNrRkZBVnplcXJWODRQc2tCdmYraC9wY1NNaEx1TmovOXlRV0xPTHRITWZB?=
 =?utf-8?B?TFFpdzVQK1ZLc1ZSbEJHVkxzVEJRSksvckV6cnYwcVpmM0RjQVRuU3Z6dTBy?=
 =?utf-8?B?YWsxcGJac3U5U3FLQll3dVViWEZYekFIVENYWFNBR3ZUQlpHeGg3a2tmN25E?=
 =?utf-8?B?R0VNaW9BTytBK2pvQnZhWTAvcUVGOEc3amU1ZlVINVZRUUNWQnQwclY2WUdW?=
 =?utf-8?B?WDVOSXBsci9MMUlrUmhybkZPS0N3SlFraEpVU2xkNDhrL3RoNlIySkN2MjFJ?=
 =?utf-8?B?V2hxSlhEKy82cFo1VkRkQXc3dVhXSzhwSm5zSjcwUnNiMEFJSEZkbDl2UGk2?=
 =?utf-8?B?ditFY3NCR2tTcFkwRm1yNm1ZYkR4UTg0NjJsQVduL0xDRm9la3UyZjl5SVJH?=
 =?utf-8?B?TThxVFVRZXdQc0RDVjZDenRHWmJtVnVsSG13aVdPZVA4NC9RMk0rMnRFVGxN?=
 =?utf-8?B?cHRZaHdVUUR4SDhIaVdNTnhRbzhWS292R1FBa0VpR2dxT1VVN3V3MDJvWGh2?=
 =?utf-8?B?RDRONXR3MEhQQXhwVGxyRDhTL0ZJdlR4STJRYTdzblZDQTB3c1I5bk5TMTZB?=
 =?utf-8?B?K0ovb21Dc005Wk9yVWg1aHIyd3Rhd1V1UWNQRnpDbEtlTHlSY01LZnBmb1FM?=
 =?utf-8?B?L3lBcGZTV1A5WGVhclBmc1VDaXkrc21RTFJEclVXWkQ2eDB5dGRjQnFFVVpt?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a7fb07-b885-4dc6-ccd5-08dc32558011
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:49:58.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 804Hw024492Frf8X7ljLsu9bAq5pj5zzy9M+uCp5AQlBo7/uPOaNq0AXWquAQccxsNG531qa7q6J0Zsi1uGCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651


On Mon, 19 Feb, 2024 16:11:16 +0000 "Russell King (Oracle)" <linux@armlinux=
org.uk> wrote:
> On Mon, Feb 19, 2024 at 02:29:36PM +0100, K=C3=B6ry Maincent wrote:
>> On Fri, 16 Feb 2024 10:09:36 -0800
>> Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
>>=20
>> > On Fri, 16 Feb, 2024 16:52:22 +0100 Kory Maincent <kory.maincent@bootl=
in.com>
>> > wrote:
>> > > Change the API to select MAC default time stamping instead of the PH=
Y.
>> > > Indeed the PHY is closer to the wire therefore theoretically it has =
less
>> > > delay than the MAC timestamping but the reality is different. Due to=
 lower
>> > > time stamping clock frequency, latency in the MDIO bus and no PHC ha=
rdware
>> > > synchronization between different PHY, the PHY PTP is often less pre=
cise
>> > > than the MAC. The exception is for PHY designed specially for PTP ca=
se but
>> > > these devices are not very widespread. For not breaking the compatib=
ility
>> > > default_timestamp flag has been introduced in phy_device that is set=
 by
>> > > the phy driver to know we are using the old API behavior.
>> > >
>> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>> > > --- =20
>> >=20
>> > Overall, I agree with the motivation and reasoning behind the patch. I=
t
>> > takes dedicated effort to build a good phy timestamping mechanism, so
>> > this approach is good. I do have a question though. In this patch if w=
e
>> > set the phy as the default timestamp mechanism, does that mean for eve=
n
>> > non-PTP applications, the phy will be used for timestamping when
>> > hardware timestamping is enabled? If so, I think this might need some
>> > thought because there are timing applications in general when a
>> > timestamp closest to the MAC layer would be best.
>>=20
>> This patch comes from a request from Russell due to incompatibility betw=
een MAC
>> and PHY timestamping when both were supported.
>> https://lore.kernel.org/netdev/Y%2F4DZIDm1d74MuFJ@shell.armlinux.org.uk/
>>=20
>> His point was adding PTP support to a PHY driver would select timestamp =
from it
>> by default even if we had a better timestamp with the MAC which is often=
 the
>> case. This is an unwanted behavior.
>> https://lore.kernel.org/netdev/Y%2F6Cxf6EAAg22GOL@shell.armlinux.org.uk/

Thanks for providing the additional context. This was helpful. Btw, I
absolutely agree that all PHYs should not be defaulted to for
timestamping applications. At best, a driver implementer can select that
the PHY will primarily be used in timestamping applications that benefit
from it doing the timestamp work (which is what this patch does).

>>
>> In fact, with the new support of NDOs hwtstamp and the
>> dev_get/set_hwtstamp_phylib functions, alongside this series which make
>> timestamp selectable, changing the default timestamp may be not necessar=
y
>> anymore.
>>=20
>> Russell any thought about it?=20
>
> My position remains: in the case of Marvell PP2 network driver with a
> Marvell PHY, when we add PTP support for the Marvell PHYs (I have
> patches for it for years) then we must _not_ regress the existing
> setup where the PP2 timestamps are the default.

I agree 100% that the previous default of the PP2 (DMA) timestamps for
the Marvell PP2 network driver should not break from this work. We
similarly would not want the same in mlx5 in general (today the default
is DMA timestamping except for PTP traffic which we have selection rules
based on the packet). This patch is essentially to avoid all PHYs
starting to default to being the timestamping source which I agree with.
I guess Kory explicitly defaulted PHYs that were used primarily for PTP
applications/timestamping applications that primarily benefit from the
PHY timestamp. With this, I think it's safe to say that I agree with
this patch personally.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

