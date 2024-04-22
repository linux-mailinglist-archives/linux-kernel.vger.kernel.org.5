Return-Path: <linux-kernel+bounces-154201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41028AD931
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C5AB21B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9373945BE6;
	Mon, 22 Apr 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QfqEHIHD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2099.outbound.protection.outlook.com [40.92.21.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC8446D9;
	Mon, 22 Apr 2024 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828733; cv=fail; b=E2tEo344fmwTmKL3HO48Y8unC3UFSymJPhc3LPWP0WFUdXr8eHfGGNLqNVTcwnP8CwJmKVNOlgX4w9yOzfnsxoJ3KDOwDD4MmcqdLzJxmVpEACHGHddjohvVQCQoLLya2PFg7+XCxO6zPRaw3jj//9hKxoofNnE4aXGJMDHvRf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828733; c=relaxed/simple;
	bh=kWWXTwDBtwfdQl0y1HDXqq1Mm7ARKs89SleoNKIwLqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dTpIj1dOlPfEqj5d0SkTxNmoHzEVkh4Yb97nsRofG7NJrFrkSKDOUOavyvHDzLnH+Go0OnCmZyIGL+HPcABLz+ERH3Z8j5cWVJRfrUjNVoeTA2j0O/k3ZKbP1iGqCCdGecRLptc1SQouAHDjisuHM7gVhASbR9TNkFtEmbOjZO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QfqEHIHD; arc=fail smtp.client-ip=40.92.21.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzXGSWFYCAdhjXkyTTwbgyVK0NFMUH6pgajEw1lBhV2pn+UiYv7CgOapRXq9AKboeGJru9zVOXSkV6Wp8eH+gFy8wnacZ2VwaCb1ula/WZUbRFeLbOcWJzmtAlMF1jNE2vJ07Fbj8mTG7uDdBEVUdhhxt1KDP2Vk0A4049m8pqn3fMVbp/qnfNqxTmgfsXrvRk/F13L6++pSQtf2GeH8hnddrl6tIdPQa2JA42tt90jHARUeSusGOtdrRtJGq6nlxmytSThAN07PfLoBNo3Fm9eMhFKb6iU+hydkFfX9JqvWg1PLmZ8qWpfbL3ftNd9+UCDPz9WRTg565qqjaAlM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82UXYRBJDADzScQeIMMkR0iF2rWnNkbkNOLSq5sKjaE=;
 b=KvSbhGHBIGHu6x9B+nPpu1vcIErwzu+EIA13oFB4DQLyhG9hr5ViCqw/R77hCHdevtYnb6L4qqUGqbiPisddCTR0nJ8IOS6ascV+SGPjyXi7F/1KLpwq8kkk3wDyoPtLjXtp9BMNkuwojF9aq+77FTjystmiJ9tTXWcGSRB8VTnb7rdIyXDcau2o5pMSlFFgSukUepEthCiTkW3JI7SwOWYkpY136pPLD/g035CEuDLTbmSjczG/RMfSs1c3mdmAI4tRjw8PgfA+Wyz1WheSMfLwoC4LJbVpGhkL1kdbnD0nBgREHlxWEB3qnZTOYI9K34/zXOh/F+t4SXrTB2xQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82UXYRBJDADzScQeIMMkR0iF2rWnNkbkNOLSq5sKjaE=;
 b=QfqEHIHDlPmZ/uLd6wuyaCce6a0mNzmNdiUOTP+OuEMGlBWfiDrvGBlWEvUYKetMcxkmiNsD+rHUZWjYKA8OcwoAktD+GQxe0jeG1euYO8yflOyqFPUW4bAk9HLDa+pOS8TKB2ll46d5Wr4FlYnNjp5UQMf4J8ptG5XKcJcyYcH+r8USNrvXqtpQhtTlFAdoIJ19k31xL6OAyzF9NVlBNisn0xA/iIWl2ycuokNLxlPHOX5KXuyGOcwx+XfSNH+FkSE1uwhY/MSWPvpLqe9fv1GqwtRumKCrZNI88/PQButXQQF9W/eK0DXu41DtfVEoRMlNICaRsZTa0HfuYBzIXQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB4855.namprd20.prod.outlook.com (2603:10b6:8:95::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 23:32:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 23:32:08 +0000
Date: Tue, 23 Apr 2024 07:32:32 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID:
 <IA1PR20MB49531FB44161BC81C3DDACF6BB122@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953040232A4D41E41F2D2A9BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240419-harmful-neutron-d0db367cf659@spud>
 <IA1PR20MB49536E7548B65B41F4F33FDEBB0C2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240422-folic-obtuse-570b1747e7b9@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-folic-obtuse-570b1747e7b9@spud>
X-TMN: [USkaPTQM2OGeHLPe01f1aTF4obzqORpZXlEulVPe05c=]
X-ClientProxiedBy: PU1PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <mr3mve2s4psiifoeze6qdhaoefi3ipjwjf37nybmue2qhbvndh@kldl6pcczl7v>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fa9f86-2939-4242-232f-08dc63246ce2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1M21yHF5YVoVgm354X8USyx5OKgqS1FIviy0xIhZkSxuCeI0qfyb6s5G6XqWfeuqb5B4+JxZImjIg4t50L6sG1p8I0A8Uh+ZI1ZSHmgEnS2zU5/TB0n5Boi2DYdChI9S+wqR76Qnw7l/gYIudCstNUqMaqFOJuetSrz/WN+TT3lc8TAecRSKzWb2bW25fzbQQweR9BVbjHHlREj+JnQZzFTniB16moRBtsmNjBpmbAldSQluT3unOf1L+y+FZ0H1vYrsSnjvnuHw5/BEFp4uZaTHeysCBtTXx0dCgmEnQdDLgiiMBBFEKv1xKnTVRKtO+euOdZo9n6eUsdRWM335y+o3ji5nhm/rbrzOdPXaHI8cm3624jQzyKOUvcjV8HxARn8+RQ3iMeHHgA4FvvHO+sfNx44Yqqqpe/aOtATETvkIy/KHltvUd0sU96jgIDLp3yiWfW29m5QzmWaLOEFa3vBHihf5/C1KvaTBhvTtduC9Z058//B0kGv7mclWItZmzk1g0FBpl/e6jK+kRxLCd34qLphhvWI3mRPOG8IBNl90bjtZ0QZprWWZa8xyp1254b2OYNYVdbsbG78llqeKeJ6/br4kH0BbTCd0b4NX/LFknfGNt84fAlAGFqQ5K7CDinhJkvbMr838nt+yfK+hPQuHSwuEXUOPFMyiYRdByoujnSPDTFdgoi/NTwaUyzlmo4RyKZxctvx2EgAlAgPbZg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSsUv9I6Li2WEFmZAzYVm3aH1ZC5hkkMMwrm6x+df8UWaS3wSA/JU/O5u+Lk?=
 =?us-ascii?Q?N+Lhj+jGzPEnllSBj41dTgcnzIHJ2bX7MtTgt+azONM2u5RuO3pdlPSOJu5d?=
 =?us-ascii?Q?a1xMbHZGB4HCXO1omME44WlJNIWTs63yfASCpBI6Hxu/kRNMfLovjWXmviFW?=
 =?us-ascii?Q?7lx7yu/BL90py0TufbICfQH4pOH0GbbjaX2PDcIGUgdf00UvZmfVvcCNZPcp?=
 =?us-ascii?Q?x8stLKS/cXKlccG19DlK2FS+r9a9bH8L7slVJMi7tovtPr9zKYS1d3q+XC+f?=
 =?us-ascii?Q?VyU3/Y+smwCFDVZBX/J/VYKwbUjhHWaJqLASc0yRCUgERrYtWOs3knFucbn9?=
 =?us-ascii?Q?2gJVmt0jOwuFPdtSfMllKRqXyFL3PDydlVllFQhys0E358If/d+FxosmMGkN?=
 =?us-ascii?Q?tOUdGNRYPFxVeA2m3TzE6WYGRi0MK8gCcYc0ujZlh+huF3uqGmSFvXu2j/vm?=
 =?us-ascii?Q?bfqdjaKETO5N73CHfKV/OtSSh5kgnFwOTEawntMvIs+LcqTxY/3SkT4idRwV?=
 =?us-ascii?Q?zgWdpnI5jtWicQinrkRKT6mj3izcL+pAuWpt4/KyiUMdzGKtOCqHZyGtUxmS?=
 =?us-ascii?Q?v7YAruQvEoli3UZzqax91Ak7NEpIbR9CIJVn8/K3BaSEbqFbQjoO6qE94Iw7?=
 =?us-ascii?Q?2R7q+M/HCMWV01sTN7znCpNHhGyQnmHhFU2mkoYV/SxprffyhLUd+TYREHAc?=
 =?us-ascii?Q?F5jU9N0Ud7+dZr75Qd2m569kN/DIuGtrTYvrwqbTITdtVFQIWzuU6PrcktCj?=
 =?us-ascii?Q?9q7O2hB4EwvuTB9g4eRweCOwWehSg+tvuWqN1LoUgZxegBE9EtHpmwcNDWxn?=
 =?us-ascii?Q?iYdiTh7fFMmCkg1HZlRs9TBrMNPVHhZ7B70iO0Rj504fGC7RzHCQZCFqFoTu?=
 =?us-ascii?Q?PPlB8cFyEmm0jdM8kLkVSbs1Jd4Y2R3dIPqnyLfnw0RVte3NTCXxz+KaFVIg?=
 =?us-ascii?Q?z4oZah1SL4KSzdN9i++glXJa+6Ms60clWUYHzeXzrbo+1c8aCA5qpPw4V6iQ?=
 =?us-ascii?Q?vH+wpp/5+kXPQE9SQt05B5O0medY42nB3uE5syh9MEHwMfwpSzBuPakvDSgT?=
 =?us-ascii?Q?LF89jG5DwB2eY637izBdp1RO9KXA1SeII8WkGlPmvaLBYUDjv+0+CSww+vnN?=
 =?us-ascii?Q?2dfpUM5vntKapv20lgLwaQdO8c5eQjfKcmpZD/8SSxYIaSWnKYsL8NhZuJoW?=
 =?us-ascii?Q?JqNobOo2TOWakRzMg2HvVNvJusbGbdHUHNNBZrUs1Or0WvWkEEQKhT8SMXpQ?=
 =?us-ascii?Q?sZ+N7fcGWAuiJBAxYe2b?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa9f86-2939-4242-232f-08dc63246ce2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:32:08.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4855

On Mon, Apr 22, 2024 at 05:21:26PM GMT, Conor Dooley wrote:
> On Sat, Apr 20, 2024 at 09:39:18AM +0800, Inochi Amaoto wrote:
> > On Fri, Apr 19, 2024 at 03:26:53PM GMT, Conor Dooley wrote:
> > > On Fri, Apr 12, 2024 at 03:22:24PM +0800, Inochi Amaoto wrote:
> > > > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > > > "VBUS_DET" to get the right operation mode. If this pin is not
> > > > connected, it only supports setting the mode manually.
> > > > 
> > > > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > ---
> > > >  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 90 +++++++++++++++++++
> > > >  1 file changed, 90 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > > new file mode 100644
> > > > index 000000000000..cb394ac5d8c4
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > > @@ -0,0 +1,90 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Sophgo CV18XX/SG200X USB 2.0 PHY
> > > > +
> > > > +maintainers:
> > > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: sophgo,cv1800-usb-phy
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  "#phy-cells":
> > > > +    const: 0
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: PHY clock
> > > > +      - description: PHY app clock
> > > > +      - description: PHY stb clock
> > > > +      - description: PHY lpm clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: phy
> > > > +      - const: app
> > > > +      - const: stb
> > > > +      - const: lpm
> > > > +
> > > > +  dr_mode:
> > > > +    description: PHY device mode when initing.
> > > 
> > > "initing" isn't a word, "initialising" is the correct word. Or
> > > "initializing" if you speak American. But if it is just the value during
> > > initialisation, why do we need to know - we can just overwrite it in
> > > software, right?
> > > 
> > > Are you sure that this is limited to initialisation? I would have
> > > thought that it describes the configuration that the board is in, and is
> > > a fixed property of the system?
> > > 
> > > > +    enum: [host, peripheral, otg]
> > > 
> > > Rob, I know this is a phy rather than a controller, so referencing
> > > usb-drd.yaml doesn't really make sense, but there are several PHYs using
> > > dr_mode so it feels like there should be something to reference here
> > > rather than defining the property anew.
> > > 
> > 
> > Yes, you are right. Using dr_mode in initialisation is not necessary.
> > We can just let it go and using the default mode. In fact, for most
> > boards with this SoC, host mode is just enough. And it is just easy 
> > to overwrite the mode value in the driver if we want another mode. 
> > For the OTG, it can just check the `vbus_det-gpios`. I will remove 
> > this property, thanks.
> 
> Just to be clear, it's valid to have a dr_mode property in cases that
> you cannot detect what the mode is dynamically. What I was questioning
> was the wording about only valid for init.
> 

OK, for the USB phy of CV1800, it always needs to start at host mode.
Because it needs to switch to both mode when initializing. As a result,
the "dr_mode" property is just added to decide which mode is set after
initializing (mostly for functionality). This is why I say it is for 
initializing.

Now, it is clean that setting dr_mode is just a function hint, and user 
can just overwrite the mode. So I decided to remove this.

> > > > +  vbus_det-gpios:
> > > > +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> > > > +      defined if vbus_det gpio and switch gpio are connected.
> > > 
> > > I don't understand the second sentence here.
> 
> Ah, with your explanation below I now understand what you mean here. I
> think this needs to be re-written - I think it would be easier to
> understand with s/gpio/pin/ in the second line.
> 
> > > > +    maxItems: 1
> > > > +
> > > > +  sophgo,switch-gpios:
> > > > +    description: GPIO for the phy to control connected switch.
> > > > +    maxItems: 2
> > > 
> > > You've got two items here, they should be described. /But/ the property
> > > above says "switch gpio", which is singular. Which is it?
> > > 
> > 
> > `switch-gpios` is gpios to controll USB switch connected to the
> > phy. Sophgo recommends that phy use a switch to separate device
> > port and host port if it supports both. I know this is weird,
> > but many board follows this design, such as Huashan PI and 
> > Milkv Duo S. As for item number, it is just an array of gpios
> > to process one by one, I mark it as two just because Milkv 
> > Duo S use two gpios to controll the USB switch.
> 
> Right, but what I'm looking for is a description for what each GPIO
> does, so that someone can know how the dts should be written.
> 
> > For vbus_det gpio description, There is because the design of 
> > Milk-v Duo S, which connect the switch gpio and VBUS detect 
> > gpio. In this case the OTG function is broken and we can just 
> > change the mode by toggling switch gpios. So I suggest not 
> > defining this property.
> 
> Okay. See my comment on it above.
> 

Thanks, I will add some necessary comments for these two properties.

> Thanks,
> Conor.



