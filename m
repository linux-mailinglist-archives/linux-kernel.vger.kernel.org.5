Return-Path: <linux-kernel+bounces-35837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0B839729
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D7628A10D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48C81218;
	Tue, 23 Jan 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nU2J9bci"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21D8005D;
	Tue, 23 Jan 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032954; cv=fail; b=J8nZ3Iyb5e23BT2v91o+Ds52Ic0fvNem0aIUCmjc/uq+b0d/7u5KAQN0T11sEtdoxfzLdgipoVPIbV1cT332v9WXyjVNDseeSCWiu+brEIjLo+F9maO4U9Mis7Cv0P0owMZUXKYqMJxYm1YJ7ReGi/KkuRLJSk70Cqjs7i87meQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032954; c=relaxed/simple;
	bh=1a+V63fK1zNBZqPNAGxFtJyTpy3lTgm4nX4vlG4pZVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qUvA1jBN31ro9+37vgoZvjbkJ/oHPI1kjqpB+YYRI24lZP9WC/vJeLy3oprt9Dixg8IOaSM+YO0agLi2wYegNfQX8A7yuimTBYh+NDgC0JdlHwQUoCGOYd2s9k2DTr9IkPu+xWATHKMIfli6eVlNlNo7FllI0S1xx056HQdBH/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nU2J9bci; arc=fail smtp.client-ip=40.107.6.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhad5VX5btBkQrm8OgJLtWiJs9qFFf7KGTjvTRcGJomaY4eXg9zbe1gL3puP376+IB3k0PuGfu50xWmtXmatMXXy0eeBD+7chQy0F+fpJreuRLTgd+LNwPlQZLuKSFnLVFZH7Iq58MOIi+B5sntWHYwk/DpiO2v1ztP9ZWzHpg+o67Zt99HfOzz/fXO/3RsKgA26b2hpC7xLpPm6Bil/Zkdb0eJYjI/HNXLDWqPBFW+W8dsh6kbBSTmhuNQyk5jPaidTZ2EpUM+U0clbhX06kYpU3BkOoe6updwFGjawNZenCUHjjdHdK2LDtt/qvNpfJcJ7+/c/qH2ogMer0GE4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWCYQ7XEmR5BfqSRl3k9fvFNTLY78ddYgKl+n1RXsd4=;
 b=isFl6UMOk0ChHPYBd6sU3QORPammvk1bhq/JgPllKw6vsRA9YwLqQhMVnMZKt/1L2IdfG2+0tvAzNlTmvR0YT8ZxpZ0cHq60MYMZcI18n1M6bEewanRTPMHCSl5syMlaIBF3aORUL2H72kd2Sz7YMuQINmjLycfJQhs6SECTC4EZAJqQKZws3b0fs6awC4um3cV6nZkLe3YCIbcu0/sxoYyJsuZf+DHC23p0fY12ERhBADoFm9Ch6UF8bwJkWCKPLQBYx/rEMAqJl/2WG9KrDKUvVjHupAQiDjdLbRFzio7snYjc6A/Yup5b+VTF/OcPzNWYA4+lHCrRnISSiBNt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWCYQ7XEmR5BfqSRl3k9fvFNTLY78ddYgKl+n1RXsd4=;
 b=nU2J9bcidXodH3Xnaits6xCNp0/dF7RRWXVXXf/brhes+wHTrYD5D5X4rO/OlQ5xAbJdgcMe3DvxjhqK4PwadpzvQXZQ21I/UM2EwXVWDp0An2XxjHomRrFHyQNCdyFhw5qhQKXgJMlIQ91jt/98z68dNCmw8ndKZKJ1M2jU9LI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 18:02:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 18:02:29 +0000
Date: Tue, 23 Jan 2024 13:02:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: thinh.nguyen@synopsys.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-anew-lilly-0d645bdbfb30@spud>
X-ClientProxiedBy: BY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 808cf2a6-6780-4081-1c8b-08dc1c3d76f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nm5Av+yF/x++DCfiWhvPcMbtcdybsd00RsLO/9mPlH502ofuXDZjIVFeJ6Ge41ohcl7M8cNz9RhBRVYa810tKJ0iJLgD0v90wIhEwpUpNT81kg37nm2+cmSmBgICmiCHDI1SoaEuRIWWwEVjNFFrdG5xMsp2O+zA5KPdyQSxL9irhHYluWdDvRdHTY/pNaJ4eDIfJ9slMsgOtC/+gr9WFVF+rHo0NOmiodACd7e+iaEBokyMpc1gzvKoKTPdqjlhAJm6dleeKEhC9RHXJGZ8OI98SGuMNqYV0IC0O/H0ae4morM56bpg3LYN2XWy0Nnphnb9/ws5pwAJ9rMAgAEH/v6QJ1U2fey1S+J+ICB4SWh/AM3p2XgUF1FsxlN/2oh+EKIF/JikuoS6wcbQ6VWfIn4l4l0cfLSfO5Qtsuk3fkEx5+QiLEe+PH9JTD9o0yzDQw5MDfbs5hhw6ev/adwKSoW70mW0+2SuAs93I2vdN0i1S//4zARf8Yp/X/YVqa4hr/c/oLJK9PPTFedZF/fmAILDn/XufWOnYa3BeHie6Cr92GRi5qXEvqoGtd9jJEGajRsSF6czXRdh8i27mpeLIEzjpedNvwNk7dOPdQQ9qZSF2yq3v/mGlBhYI2pH3LY9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6486002)(52116002)(5660300002)(6666004)(6506007)(478600001)(316002)(6916009)(86362001)(4326008)(8676002)(8936002)(66476007)(66946007)(66556008)(41300700001)(38350700005)(38100700002)(7416002)(9686003)(6512007)(33716001)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eij8En5Zbn+eCyNy+TccPMoM6f0s3LLdBQteoNoTGdVZ4ry+GrzyiLmc1kug?=
 =?us-ascii?Q?+mQkJfofe/eyBlVSVp7L7e7MP00JlTY88Vg2pJ7I2Jzc9INqUKAwi/Kh0pYo?=
 =?us-ascii?Q?3h36lyXTpD2clFAamVEqff5DaAW2Sn2Dn6/o1EMt6gjsWswUpznUoL/ilDbQ?=
 =?us-ascii?Q?u0yiMrcw9Rt13oDDeOSsurGCX7M73mrsA+P/4JDk9ROksFcjpdjkKwx22hJ8?=
 =?us-ascii?Q?MQxX1H4Y6GtReG4pY1Eu+yDUeIMYxb1BCGLzZPY8h2DzR+LepVD88dEmBph9?=
 =?us-ascii?Q?pFE/GWfigZ/fHyv4PI9MFCLOMySVdNdfWcl+Fd5lqhVPrNWbljxcw+FoPWyi?=
 =?us-ascii?Q?r8oVQ9I+/O46zZofYkGk8yi5xLaJpllZV4OsL2EUK21xVACmNkrRPuD3NRar?=
 =?us-ascii?Q?W63LAoNMlydkmBorfH6G0eZ7Dns+FLCY7C6v6vGJI119Wi9495jl/8g8QcGL?=
 =?us-ascii?Q?C1towUtVeAyyGrw4A2jWkuAdC5ahsmGfz2gJ+NdhN9JJFDsufrJb97xDRwDO?=
 =?us-ascii?Q?/+72MwPKYeNQmnR7uyEeeeyfA+EXKhlRVSB0XP2TYEywhO+cl0zsjiMnVwi9?=
 =?us-ascii?Q?/kpfXqCbBlWNX/d+yMICvee4BvK6ZMKzfnsBLbKfMzlWef9u+wRuc9twm18n?=
 =?us-ascii?Q?C9K/onTsmGnwLTyF0kCfAB9HFsAog4QpgwJBtPs/JyurC+qyRM4LqBZxDk1j?=
 =?us-ascii?Q?QMbXjMmtjcPR/aNR+IDY89VuYHFYEsk9hBusYcda4vpS9JPrBkVj5u4cSWaR?=
 =?us-ascii?Q?UDmzGm6uZJcWqL3JPxiXXoQvYCZ7t7tFWF2zoTT1PIjea1X8xx3LgTd6f7gs?=
 =?us-ascii?Q?u9Pcpo8kv9/MfUiP/Rg6zh5JMsdEk2egm7P9cq/spRsYnhJKVMs53tA89kz8?=
 =?us-ascii?Q?G/TX17SQOWU+esxO5s8FmTmjJrI8CyxOnhuK/LlHTMja1z07KqxkztMoIViK?=
 =?us-ascii?Q?2JpV+V6zf57fqlu1XWN5vkjxQYVmVEsCKvaqbk+ADblifYiHZRnsVfvT8xHJ?=
 =?us-ascii?Q?Bsh6QMoMcwbIqakW9e3cr7NDIEzQ7C53UPkenlpq0esiBM72h0RXtngDWHk+?=
 =?us-ascii?Q?ilnETLbIw5v1pna/CPOc66PjGkVCge/1mjYMNl1mouxolMfltu4Oy9eeQKq7?=
 =?us-ascii?Q?zY1ZCN91ZwBao01eBZrNxEoLD95Ji0ga2hlQf18eHlLTAkzR9CPSaA+Qloh3?=
 =?us-ascii?Q?Tz5SM/zUVZWxSoB3xZx52a3M7x8IH2CedoS4oUEdciQXXECsXCmsvmaVnk1K?=
 =?us-ascii?Q?k/PBWPlsMOUKCOQ0kj3cHTLEiao8kWU1acp3Mhe2gIEBDJayjz04pHntaLpx?=
 =?us-ascii?Q?EELE/z/DrHYsRI9NG1AckGYjAHUPuOmF6oA3H364pWTFfTt9zMWS+yLY/ouG?=
 =?us-ascii?Q?oiT0K4XhcTrx+wgVMNa84l1tVXavLSti02YV5vC02gEC18dq2d9GduDqmkDc?=
 =?us-ascii?Q?q6NyhkQ62Ppfmm7Mugs2NvVJ5NchSF40eazCR/5J6ogHDb/xU3HeMacBFwxb?=
 =?us-ascii?Q?10Xtts7WQDWB/14oE5O86AYnoq8Y5mQrlNva4RTPL9RXzl4A708jMBDKeQSe?=
 =?us-ascii?Q?Yy+EyP6UCCqolGpkSIA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808cf2a6-6780-4081-1c8b-08dc1c3d76f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:02:29.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZrHU8heghYSv7KmUJLIVNu2X5yNap59RTsEn5nTyq6a+Fe+kXcmf3pWpu+tK2aft4fFvns5ODjJN/EzNnLdWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9750

On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> > On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> > > On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > > > Add device tree binding allow platform overwrite default value of *REQIN in
> > > > GSBUSCFG0.
> > > 
> > > Why might a platform actually want to do this? Why does this need to be
> > > set at the board level and being aware of which SoC is in use is not
> > > sufficient for the driver to set the correct values?
> > 
> > In snps,dwc3.yaml, there are already similary proptery, such as
> > snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> > driver keep consistent. And not all platform try enable hardware
> > dma_cohenrence. It is configable for difference platform.
> 
> When you say "platform", what do you mean? I understand that term to
> mean a combination of board, soc and firmware.

In my company's environment, "platform" is "board". I will use "board" in
future. Is it big difference here?

Frank 

> 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++++++++
> > > >  1 file changed, 36 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > index 8f5d250070c78..43e7fea3f6798 100644
> > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > @@ -439,6 +439,42 @@ properties:
> > > >      items:
> > > >        enum: [1, 4, 8, 16, 32, 64, 128, 256]
> > > >  
> > > > +  snps,des-wr-reqinfo:
> > > > +    description: Value for DESEWRREQIN of GSBUSCFG0 register.
> > > > +      ----------------------------------------------------------------
> > > > +       MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > > > +      ----------------------------------------------------------------
> > > > +       AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > > > +       AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> > > > +       AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> > > > +       AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> > > > +       Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> > > > +      ----------------------------------------------------------------
> > > > +      The AHB, AXI3, AXI4, and PCIe busses use different names for certain
> > > > +      signals, which have the same meaning:
> > > > +      Bufferable = Posted
> > > > +      Cacheable = Modifiable = Snoop (negation of No Snoop)
> > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > +    maxItem: 15
> > > > +
> > > > +  snps,des-rd-reqinfo:
> > > > +    description: Value for DESRDREQIN of GSBUSCFG0 register. ref
> > > > +      snps,des-wr-reqinfo
> > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > +    maxItem: 15
> > > > +
> > > > +  snps,dat-wr-reqinfo:
> > > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > > +      snps,des-wr-reqinfo
> > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > +    maxItem: 15
> > > > +
> > > > +  snps,des-wr-reqinfo:
> > > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > > +      snps,des-wr-reqinfo
> > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > +    maxItem: 15
> > > > +
> > > >    num-hc-interrupters:
> > > >      maximum: 8
> > > >      default: 1
> > > > -- 
> > > > 2.34.1
> > > > 
> > 
> > 



