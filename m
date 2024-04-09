Return-Path: <linux-kernel+bounces-137286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9789DFF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E202816D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564A13D63F;
	Tue,  9 Apr 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q08IBV1E"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2094.outbound.protection.outlook.com [40.107.104.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC71D6A8;
	Tue,  9 Apr 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678562; cv=fail; b=asIz81I9N7RCTEpORixyr7hKWcUZyYha8kJGFZwM5HL710/loNpcxFlyv7Qq7jXXOO2Pg5SVwszs0CF/zp25CK8QL9922LuMz3YIUa9tEjo1CRN9WlC8KMPuWtPKcF1Euz6vf9e6UgYgM3mKmZ7Ey2xUU2jkIeR5oHkWsOCtc0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678562; c=relaxed/simple;
	bh=+968bWGmhO0NAy9cEKFuaIqOPD0C7SADtxSAg5x60g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=joyaw26ioVG3ttVXWY0QrB7Q5/lcQynnR2wUPhsB7Sky1wkPQuB5c1QM4ASFjleeKtHm3Znp4DEVfYBv5/oQadIFyyYVspSl4jvBw9K76zvIZE9sUW+kmchSEG9ieu+o3vxuo+9uikbxmPLFY/NAsortaGyFBKdFMxZVt8mQcYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q08IBV1E; arc=fail smtp.client-ip=40.107.104.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob7TA7kfIGpKVvlh+npmwhvM6gn4fdNGbGCW1eS8fleEVidckV0tQB5SIo8sgM7MpcREH3BTnCj8TeIi6LidbXQCwMDmxAjaUs/+4K9PdbigqGlu2XVxkyswG4/uITl/MB6MrYbn5IxpAVmkxMSRaenxuObdJfnpW7C9fcnzioIb9WcgafyFz6eobbh4NBj9L4DImFJNFAsLCT2jIO3vmdg7BC6SinKSPGMHXnCfmKbnWum6CJd3vBTAidLsGVB29DBnYvMagPiPMgq64224A84uOv688hkUK6yR7OyOo35YYxcyEmHm/sIq6A5hZ3LT6WfT5o4MX2jwO37ogboMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaqmPIH7buyzIqRFdBz7O7KPbDEiuqE0TSJzwH301Rc=;
 b=ffMoy7COYyGVYC7L3QfLwz9Kbm8NlA1Y6lo45ixUeD6GEprpiDS66IUeEidgx5lxbiyLEKNYzjWeN3zPp1Y3soDd6M5+mf8m5Q5Zaj9jsOnDVEd/vnABNCoAueg+6QWbElUAfkApWQIX/61FdepiterT3RaAq5EAUH4DhH2VMumFO53oVEd+qqkMmFWWsOB7u+eWMkkpyJNBirbaR9bX1TsZOHAcFNpD6lRlN0dW4VGmCj9QhyG2j3RNVMWDoHb/26gjmRhtupFYuF8x5uGkiQnaMZXAYVQsAYJ0XWabLQoJikBG6CKLSvzo7F5OcnwjCxSr17y4JU/BVIe2nSkbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaqmPIH7buyzIqRFdBz7O7KPbDEiuqE0TSJzwH301Rc=;
 b=Q08IBV1E/lBWhRVeFszp7F9SWC0O47dsTD1PsmLh2mfq2Mx98X1BcQ4RRTE+hZnaaEuacQglMhuSXOidVV8KL0x+V/N5Znhg24nk/0jUZnBKttMBdxLO/1jOea/Q5ukHZpaw6P1okvPfD5ADAeRsiE6+gAre5kg9i1V0Rrqz0DM=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 16:02:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 16:02:37 +0000
Date: Tue, 9 Apr 2024 12:02:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962
 and sai[0,1,4,5]
Message-ID: <ZhVmlFIq/Ed+HbT9@lizhi-Precision-Tower-5810>
References: <20240404161914.1655305-1-Frank.Li@nxp.com>
 <efc9c624-6a31-4299-a604-8aad1d0cd878@linaro.org>
 <ZhAO4YWuB8r8k+m8@lizhi-Precision-Tower-5810>
 <938489b1-eb94-4f8a-8881-230951299f6a@linaro.org>
 <ZhQO979YpKA24pML@lizhi-Precision-Tower-5810>
 <76714850-0e02-4333-acce-02c7657666b0@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76714850-0e02-4333-acce-02c7657666b0@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8405:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MoDSmzKOMG8QCuoreNo7bHwSu/2FYWFeSHHOdUf7fO4rNkQeIOHhpK47dZ/d0mIL/7bzq0fueGNvAPBShwhl7ifEFO52qLcHjOm1fKp1WbEXvPLI6My50991/DieT3JNTJ7yCAyhq0ysgb7PRvvIainC++7OaeusGaWtpadLm6suB/snN9wl9Kt3pjqkdG0RVUJbkuYJtM9jK42OeGGCbqfKvzUBEjf3uvINXOmLQABui5g5nsyuo3GI/oeR3KzI4ezkr4e4W4xspUEajGASYWYCFz77syMH7w9fWNUCqYLeCqfFxs7q3dr7Q9Nfxo1a9RqTZ5oFCB7IQ1xJOjC3aQoYja9+zc5vlodZV5+7e7V4FvNRr8+MWV2wEAtvHi6hktwyE/Rqc+ZJNe4WwR+75O2IkeuxAB9ra1hcNp8IW7y0V42Q4uGDdgPr9FfqVQxBi3Q8VfC0xTCzbCq/1QRDZy+0o5Z064KBCf24FUF93we1f1/LZ6jsSaxVgvykbUwc2+GTH9ioesPy9BNdOs9UDpvRACKD+Af31nQu/ovBZI22c8lTr0WCZkHqjZGIg1tlvg3olmtjXkZyRqski+MFaIqh0wOcwWLd3WH3smoR/Sh/LR2oaAON9FsIdUjoAmGZFTZf0HkN8irsJKtFF/K9RVEfSgx8qdWJaDkaycOAb7SXqntcuxjfc/Wsoov0YUc07510H7GP3R8h40P6q4SUhBSy9InhzaINVLyh9/0EzOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmbvlek6cOf8MMBuRZajeU3fk2+Q7/crRXXIRe6/Kbo042yQbx8kO/2tZc75?=
 =?us-ascii?Q?xVG+IJh2VeFlqXifC5pKQJxYcutyJgJ0RY4DUuY59NuyNo7zAgPQH1ZM+D0D?=
 =?us-ascii?Q?hoV0KHg82woo1YkIQKd2+umkb5s2QrOP2Utmth4k866UeGCeK3yysmRLNUUN?=
 =?us-ascii?Q?NZim8n8U85OG9JpjNSJSsQIVcD60sMHRR8VqkNWtAK2cAcJsqRVNyXAuDQbB?=
 =?us-ascii?Q?BDBvhEPe6hUlBgwZOq0a7gCNnwoeYY0L64pY3RFNrd/KltgvqxGqaYuM6sx8?=
 =?us-ascii?Q?70IpZJ8720zlh5L18+y50AVypKArOQjQq3DgGEbFsRzvG2fzKBYppr7woD/k?=
 =?us-ascii?Q?6w9H9mRHwEi8hFCRCc0m3kQWMSbO3buor1zWoawUUUTa5+DzXxoEZd0l2XFn?=
 =?us-ascii?Q?xo4OzJ7pTli2mNa5witDOXfofxDwJ5AAc5M/r7Gz90DPBu2ucgbTPDfmDp4b?=
 =?us-ascii?Q?+A1vM2TIO+iuimm0HjJG321BDUc2AjyPi/npMvRCkTJ57M65u+c31pkrCLjT?=
 =?us-ascii?Q?sUqgk1M5UFOJXNe31Rqu2b3nivgPXutFOYAwv35PS4XMriRY5adUXIFCZX/l?=
 =?us-ascii?Q?bVGQa/MutRO7HQLytj37gz2XrCnzD3djP+MrMhUhY6aoslpSCfGzCV/evcgA?=
 =?us-ascii?Q?3EIj1raJy6fR1xl20TCrPLBjZGvR81xe+MOjRppkMVbhPHn4x07h2341Xm9s?=
 =?us-ascii?Q?GaKJYpEYCfCJhkw2wSi16Rp/l088o+xs19ws/AK/wa+moFjlNLmDOHioxGAZ?=
 =?us-ascii?Q?QDCdI2TZgYxYlHRzhUcdBz19BUsOPvDu7Zm5YqMmO2qrkq5DHCmBsuB4rGzK?=
 =?us-ascii?Q?sADzCS5vRbAM8pE1Y0CTEO5Xlnhlgx7Zjzlyo4MYKLPF1/dunas9/8f7c08w?=
 =?us-ascii?Q?JvYT+P98T2GbAmMczmnXUz9xLy/w369F7N36iZbLn0k3eiHuwK1WL7qwR5GI?=
 =?us-ascii?Q?EwoY0ac2y0Njm3AY/hGkjZvsMyQ1VdePsTTUNfNeHxcXPIJoeHHebHlKgNeU?=
 =?us-ascii?Q?NW8McNT2FDTlObRpdw3k/T+g4YKh8jAfx+DfnndJXlhV7VEobDhQsGb3Hd4W?=
 =?us-ascii?Q?42MQPFbyM7lnJd5kU9PWdL3ToDyRoMvf3Xn5qpdrQTz8s4O0ngdpZAK+ncfs?=
 =?us-ascii?Q?vF9FhCNAqdxvYbxuOsFoVWP3aaA945SLd1STXloCuyq3Jz6MiPJR1ne7sqnw?=
 =?us-ascii?Q?FP+T5yowDMd+vdoLM0zuPsx9s+vXuel/7kYeUkLyWbUEbNJseqjV6IhOfbvE?=
 =?us-ascii?Q?RJ2Vm1hCZZFqHh2SgvpOq6iuaTjzbJq1Nx0BOJdrSNn7xrNr/RLjLSb/QbBZ?=
 =?us-ascii?Q?VdqSf2WACAynu+4NbJ2wUPrr9rk3W94RKqU2YWZzp+LlNlNBggm5c+mBVAOv?=
 =?us-ascii?Q?5EsBK0svCGc9PvXUVjaBxtCDP/jgxY2bfg3xPmrle4Nimx+NuLxhyf11eo1J?=
 =?us-ascii?Q?OZ+Ye1Lol1bjKUVq8V2hNo/jtv5Bh5FJwt3P3MTI5rlZaxa5BEb00tL/QDZR?=
 =?us-ascii?Q?njzcXs0YCrSanL2YUGxrT69sRIOvyUsxzBAxfeEQ6a2ukvPFbkqQuz2WXAWD?=
 =?us-ascii?Q?+KvlbtR1X3HPhtBQ4JU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee8f0cb-2db7-41d0-4f13-08dc58ae7a05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 16:02:37.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIrCHSI9y7u85GgqtUhovgw1G+Jjz7brhtxQGdEhdFNgA0WvjN+MC/66bYT0+tdmZi8Ht+8iWDeM1f7eqLzaKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405

On Tue, Apr 09, 2024 at 08:33:22AM +0200, Krzysztof Kozlowski wrote:
> On 08/04/2024 17:36, Frank Li wrote:
> > On Fri, Apr 05, 2024 at 08:21:18PM +0200, Krzysztof Kozlowski wrote:
> >> On 05/04/2024 16:46, Frank Li wrote:
> >>> On Fri, Apr 05, 2024 at 08:41:59AM +0200, Krzysztof Kozlowski wrote:
> >>>> On 04/04/2024 18:19, Frank Li wrote:
> >>>>> imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
> >>>>> i2c bus mux to connect both i2c devices. One will probe failure and other
> >>>>> will probe success when devices driver check whoami. So one dtb can cover
> >>>>> both board configuration.
> >>>>
> >>>> I don't understand it. Either you add real device or not. If one board
> >>>> has two devices, then why do you need to check for failures?
> >>>>
> >>>> Anyway, don't add fake stuff to DTS.
> >>>
> >>> NAK can't resolve the problem. It should be common problem for long time
> >>> cycle boards. Some chipes will be out life cycle. such as some sensor. So
> >>> chips on boards have been replace by some pin to pin compatible sensor. For
> >>> example: 
> >>> 	old boards: use sensor A with address 0x1a
> >>> 	new bench: use sensor B with address 0x1b.
> >>>
> >>> You can treat it as two kind boards, RevA or RevB. But most user want to
> >>> use one dtb to handle such small differences. For this case, it should be
> >>> simple. Just add a super set.
> >>> 	i2c
> >>> 	{
> >>> 		sensorA@1a
> >>> 		{
> >>> 		}
> >>> 		sensorB@1b
> >>> 		{
> >>> 		}	
> >>> 	}
> >>>
> >>> It also depend on whoami check by i2c devices. Only A or B will probe.
> >>>
> >>> wm8960 and wm8962 are more complex example.  wm8960 is out of life. But
> >>> wm8962 and wm8960 have the same i2c address. The current i2c frame can't
> >>> allow the same i2c address in one i2c bus.
> >>>
> >>> You are feel to NAK my method, but I hope you also provide constructive
> >>> solution to help resolve the problem.
> >>
> >> Yes, we resolved it long time ago. Your bootloader can (usually easily)
> >> detect revision of the board and load appropriate DTS or DTS+DTSO.
> > 
> > I knewn it. But the problem is one development boards A have many options,
> > so create many child dts for files, A1, A2, ... An which base on A
> 
> So use DTSO, what's the problem? Other vendors, liek Rpi does not have
> problem with it and it works well. No confusion.
> 
> > 
> > If there are difference happen at A, create new B. then create all child
> > dtb, B1, B2, ... Bn.  DTB number will increase exponent.
> > 
> > If change is quite bit, we have to do that. But if change is quite small,
> > One dtb can cover it by driver auto detect, which will work like some
> > adaptor card have not plug into boards, or some sensor or NOR-flash have
> > not installed because reduce cost.
> 
> You have two boards, not 20 here!

Actually, it is around ~20 derived boards. It is not upstream just because
we have not time to do that yet. After some clean up, I estimate about 7 -
- 10. 

> 
> >   
> > Although boot loader can update dts or choose difference dts, It also cause
> > many confusition, such as layerscape, uboot update many kernel dtb's
> > information, which actually increase dependence between uboot and kernel.
> > Also it confuse people, for example,  when try to debug kernel dtb, why
> > change have not token affect when change dts because not realized uboot
> > over write it.
> > 
> > What's I dide is that trying to reduce unnecessary dts.
> 
> There is no confusion. That's normal process, so if someone is confused
> by having variants of board, this someone will be even more confused by
> seeing non-existing hardware in his DTS.

How about existed dummy_clk and dummy regulator in dts? 

> 
> This problem was solved long time ago and you do not bring any
> reasonable new arguments. All vendors solved it (just look at ongoing
> discussions on board id) but only you have problem with their solution.

I never said solution was not work. Just not friend for user enough for
this case. It likes USB TypeC vs USB A port. Both works, just TypeC can't
care direction.

> 
> NAK
> 
> Best regards,
> Krzysztof
> 

