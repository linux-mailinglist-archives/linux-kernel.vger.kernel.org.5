Return-Path: <linux-kernel+bounces-45187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F8842CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B081C247BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1818169D1E;
	Tue, 30 Jan 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MoZ2CrlM"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C287B3C2;
	Tue, 30 Jan 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642758; cv=fail; b=jbx+7FxflkPVF9xTJY6XfZOF0qWgXfypHBepPDyYXAydq3QePMVv+jY+BhfQMbVZPibd7Ns5JREwAK/mG9E6kjk+0Xj23o88AFeZmuwq/gEuPSGk7LeXQc3VlrdGrx5bQU/j4GPRgiawRhTZpSX2twSTRhcSmOV7tAyW/K5sJ2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642758; c=relaxed/simple;
	bh=5y7vwlY9H04RteIv6+UFiuemQPCLYb0lTTJXw/LgHQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N3F92V7HIxNt7er/BTe0n8POWqh8p5/tq4a8OS00Gs1Njh09abOzpwoszk+rHgIRfqo0VbtKTHCYHg48gFrh5wxe7motQoR+fHi78JcWMleAkzr2fcNUb6EVfBTO043dT3/65Lp5MYRGUAJUxHabFTRr24QLUnaUD1/3OHeYPzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MoZ2CrlM; arc=fail smtp.client-ip=40.107.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLWAecHVu+rcMTLyKRJY02T5o3PlDBCQtLRa8E03iddpX8iuWit3KmZJQDva/3pm/KbZRLyKy+NA7Xst9S+lUR0ZS8+G8km/Oef4I0v/UELsbXqUQ59idSE4V7CUXA2c3axynnYhanohYVWVN6uPT9M1jt2hRWgoKt6OD90Btogoh2f7IUDI1jqm2PVJathH4bZ+AdLvMW3G41eQ3uB+2Uht8mGbnPltlVKJqBfx2sUs+7VfGdEVccsLwj4jC5Vhv3+q+JFZ/T8RLftOHbNbOzqDJh/4VY3R6GbKMpf+6zt16RlaMKhjkWKo7D5v0zdw+WO0tRLu+I9BPXWrvMJ3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYjGtEwNFNF9+RrArSaw9HdhaPGquPWsAA7Sv4kngic=;
 b=TK8ZzW+aGqs48aViAAgGpvj9wTtvjZylU+KlSn4vJUaytTo4zQUie5PZRAd4IybNoSE1USl6J8FDaXLaR0oztzAcKmU/NvTjFDv5HQv0lcqqM2jHDLxTGipHejg7L+fE3XOfCnS3PdfdG+DjRy3HON5DR8mjkBqQmvnH6Rl3HYWtgWKq5DSlHQF3gb+Qe4o34slKUGS1i5ktRWwSFLlY/qgMEYHfGlCrgwUOhN5zkmATPfMbok8V47+eWgvpFFebvtG9hJ3702b04K0WIBzHs9LrEtuQ7DRjCd1vsB2ZTS5Z4MzBZMgfhcnIVs8Rrm+YsPMrOm8+uTO/lP/NI100yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYjGtEwNFNF9+RrArSaw9HdhaPGquPWsAA7Sv4kngic=;
 b=MoZ2CrlM4E/fMHAHDZh73K4EUMH5iC22tDWCdoUolcu7KZAA2EGS8sBMzi9xtq8hfwXlGT/5sn7FQbRGcArDzhJGGq4HLQHW8+ukS7b0JLTNcZnnbCUEKJJFKaP25Wk0Wj7XyCEWff9sCn8KagxS597Poug1664NiI3zqVFYSD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7487.eurprd04.prod.outlook.com (2603:10a6:800:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Tue, 30 Jan
 2024 19:25:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:25:52 +0000
Date: Tue, 30 Jan 2024 14:25:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: thinh.nguyen@synopsys.com, balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	ran.wang_1@nxp.com, robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: dwc3: Add
 snps,host-vbus-glitches-quirk avoid vbus glitch
Message-ID: <ZblNN6SyuSKhconu@lizhi-Precision-Tower-5810>
References: <20240124152525.3910311-1-Frank.Li@nxp.com>
 <20240124152525.3910311-3-Frank.Li@nxp.com>
 <20240130-eligible-barrette-5b2258e150f5@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-eligible-barrette-5b2258e150f5@spud>
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: b32bbc3c-eee0-4fe9-a2a0-08dc21c945da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2e9cNboE4sHIZ7v7FLJWmiuJsOBo53KR0jyXI8TAxcCr1bv/PYC804V0l0lTG4APNTzBrYHCw9zS15qoDKsaMSY0bjlX4xGOsUv6olZpWP3EWlPYRsSHeEIRRxgt4xPXqi5rNZR6whGHF/1eFGX8HjkNVPowkn3Qj4FYCsEmQq7kEzoe+WICeZr10I/R2ZOIvyGUbX0/44dktB3utd7Aw5l/fVLBo88jyG7eEmzOFKaPkPrcA22jop3yU+o2+B6Eq5GYRzFQmqnOiXKqgmbhVMo30Go2ICbaXSDyGJT5EqgOwFkB8hebQxc+jl9ukK62niSIhoxb+qRrj37QtWozeg0E36pGrPapWt9Sj0Eq0oVItR01WASU9/dlHVuaTY9EwcKyyRr9FhuOFFvKCBFxnpGChfMpey1i4W0xkJn7HS4jzJS5BunB1UQAvgHoIsAc3OLLruYu+g9hD/PyjEh7wZcqhSGZo/apgzzXSIeEmIazCgMgNtItWHwU8/W+TNpZGjw/r9nOuX3zD0UDK0893Ee1YXAyCvqlMF76CAJ5d3EYdUYhogmLgTSwx4K0Gc5LzWxE3ujeVdep/WvdWPxCX65zDRK+X8FL6Tus9M2ViiC/sLLUoEaVJTztwpWMSmaPnwE6IVB7QpUBgjis0JBqyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(41300700001)(7416002)(6506007)(38100700002)(6666004)(52116002)(9686003)(26005)(6512007)(83380400001)(966005)(6486002)(8936002)(8676002)(4326008)(478600001)(316002)(38350700005)(86362001)(2906002)(66556008)(66476007)(6916009)(66946007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6T1q9lNhmjpYSSfIh+zIeaTc4RQXSsFw/kH09y+xqM2AkghioafhQ2lpi4Bf?=
 =?us-ascii?Q?6RFYaZzqV/VZg6qpVtasMAdCGAH0PGjDyWemiKTkGAM17yawU/OBHjn9jZdD?=
 =?us-ascii?Q?NbHfkeCmT8eOSC/0Ry1UYx2dcCFtGDGJj/MDq/62puFPFcEngzQsxzLGMnvy?=
 =?us-ascii?Q?z781ubyg61zE0t/DBfL9ZalyMGMYilfHDi1YiWNXWCq+VO74x9k+z1RKDRzm?=
 =?us-ascii?Q?jg0vHIfRJzdmEoXzzEnQx4pzrzA8plo1BK1Y9BBIoSNTz7OwFGYP3Bt+zMbY?=
 =?us-ascii?Q?PYVevZVZpomMuyqlWdNZAY4OpfB6i+H1PPt2HHq/1ggaJ5nxidT18JB/7saZ?=
 =?us-ascii?Q?lrJIjlYFAoLMdrSBrgffuHfDlSI+aYuLo6kfblGHrOr5EcIHjflqTy1Ugd4B?=
 =?us-ascii?Q?so1kR4Af9ZoPf5MGyarLUk/dnMabU/jqYOXxDQi6rbmTz7gGfHKUSkSfNMe6?=
 =?us-ascii?Q?ucaKbAlrsiRX4Hp+Vb62yUoRKpXTPxXLm9u+qTghro/0KahzoY7OTy0lnQM9?=
 =?us-ascii?Q?Apmf38r3nJV+ckg2RFAiNsgORiliIeEOquBX+fFRewH9YFrBcJk7x9YHotOP?=
 =?us-ascii?Q?MapezWggpk7Rp32by+5UxYESJi+eCUdax1tBzusb/5ZyHhORsHGlqlQDkTV/?=
 =?us-ascii?Q?JAJw8BdZGr2qGgfzyP8YmdBMozyG/m/6nooBCktLkOtNX/BH9FmOss+9ATc+?=
 =?us-ascii?Q?3q/cj0bWHsYFTknA9pID0r3LBMwpXymUv52mWBWw0JG7L75EnNhcHaxxhHDw?=
 =?us-ascii?Q?6mdwXdYQQrUk/4/C5YpFp0xjqwlmqMSeQ8NqGzRA7SEw291rQl6dOa/WPdn7?=
 =?us-ascii?Q?QP5tRI6ByJQvLZDX2FUKaWARKEjTHhA342y60gce4oqSyJ6QJl7KZHXqtL2j?=
 =?us-ascii?Q?+VBJB/w3K4iqWGKAcNk5uf/rAwm1gFKlZ47tTxg+kviMKf3KgoWE7+q97Msk?=
 =?us-ascii?Q?dGTQDkBi3tQqwiIbq9G5nGywT4xIW7TCwatvpckzVXf7rgbazkPwC5vo/TvO?=
 =?us-ascii?Q?N9SO2toH7wqM+toEsr11okHaokLOtLwlsSS+GxQZ5lMy++4tzwHh/akUzDd0?=
 =?us-ascii?Q?CH1lOfS0VwjOQpMYMoqgifmxvVWzGtrcaZWtx7JR4pg3wrkt1v8c7DTJWYcQ?=
 =?us-ascii?Q?S8O6imUUl5VOxCY71oGPeA5WjCSSa9oI2JECmvMptGyKspB8FDBnGL0IbXQl?=
 =?us-ascii?Q?lSH3bp9umP3fxaI1Zy3j/j42G80dcNBi6obFS9KZ7OsMCjZtlOKaxMDZbd89?=
 =?us-ascii?Q?uYQWvQtLL3vf2dJaUXuvgPLOb4JCpmpHVZcvp6W1T76hlFoNha9n9DBD1SeN?=
 =?us-ascii?Q?HhcU6WD56ZTnGigYQ53wDxaYSKwriu9oeIbpNyn169MKBAlqbAht1cP3RiGZ?=
 =?us-ascii?Q?Act5/9oCvAd6XsvnJR9U5HtfbeTvIIG9MJK0FfkHxnc0itZSLDal/tSlPZo/?=
 =?us-ascii?Q?hkJopEWRG73/pPUh1wYmiOM129ru0c1ztvIrio6AsCvM1hDetw+1xmMBYqzl?=
 =?us-ascii?Q?uv0SZtsCT8YQztWTD59JNgTwJwM02nGANeIWzLO0PkQi3DiIUG2mTDYRxu7L?=
 =?us-ascii?Q?mn5vXYTmqARcNE20jdhEQBx5UaBULanTF85Y8rje?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32bbc3c-eee0-4fe9-a2a0-08dc21c945da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:25:52.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8wzYKLa94XosgJ44eeYS4YBNy18aJEhCSczZaEEbL8JqTAT0Z20p5bADOlIVWp5IYWCP6J1/EhlMRQIojJ5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487

On Tue, Jan 30, 2024 at 06:28:25PM +0000, Conor Dooley wrote:
> Hey,
> 
> This version seems to be the lastest (v4) for this binding, but went out
> prior to discussion actually finishing on the v1!! of this patch, even
> ignoring Rob's comment today.
> Please wait for conversations to resolve before sending new versions.
> I, at least, do not get paid for what I do here, so I often need well
> more than a day before I can get around to clearing my review queue.
> On Wed, Jan 24, 2024 at 10:25:24AM -0500, Frank Li wrote:
> 
> > From: Ran Wang <ran.wang_1@nxp.com>
> > 
> > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > (or its control signal) will turn on immediately on related Root Hub
> > ports. Then the VBUS will be de-asserted for a little while during xhci
> > reset (conducted by xhci driver) for a little while and back to normal.
> > 
> > This VBUS glitch might cause some USB devices emuration fail if kernel
> > boot with them connected. One SW workaround which can fix this is to
> > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > host mode in DWC3 driver(per signal measurement result, it will be too
> > late to do it in xhci-plat.c or xhci.c).
> > 
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Where is your changelog?

Sorry forget add it this patch.

> 
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index 203a1eb66691f..8f5d250070c78 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -273,6 +273,13 @@ properties:
> >        with an external supply.
> >      type: boolean
> >  
> > +  snps,host-vbus-glitches-quirk:
> 
> I specifically recall saying no to adding "-quirk" here, but that
> might've been after this patch was sent.

Your comment is at v0 version. I told you there are v4. 

> 
> > +    description:
> > +      When set, power off all Root Hub ports immediately after
> > +      setting host mode to avoid vbus (negative) glitch happen in later
> > +      xhci reset. And the vbus will back to 5V automatically when reset done.
> > +    type: boolean
> 
> Rob commented today on the v1 conversation:
> https://lore.kernel.org/all/20240130181322.GA2079185-robh@kernel.org/
> 
> Please respond (there) to his comment.

Okay I will reply at v1 thread.

> 
> Thanks,
> Conor.
> 
> >    snps,is-utmi-l1-suspend:
> >      description:
> >        True when DWC3 asserts output signal utmi_l1_suspend_n, false when
> > -- 
> > 2.34.1
> > 



