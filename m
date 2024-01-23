Return-Path: <linux-kernel+bounces-35813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E78396E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96102B279A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E896381AAE;
	Tue, 23 Jan 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fk/iO7mr"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7448811E7;
	Tue, 23 Jan 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032182; cv=fail; b=QL+j/t6XZZgadcCL6+R/abTyxX/96ftWMdnCEdddpggl+ee98wPNT3vza9pDlfgGLwzAXTRfp1SCzp+ZPmJdm0Jx8Y7vIoT2ZdBUl7co/6uxZOrGZlZGTZdhzbXCx+8SldAspEYqFeZwn4vzrsO36nWsMszmmBzOLWrUjRYm4os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032182; c=relaxed/simple;
	bh=GCJFcj400J4iKPtObNZ7kEiGkaUxdnIfJxcEX2ERmA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZPg2H/oLSKBWL1Lpx5E+yxxnnOP5c3J05Bh4uyIk22IDo5FfFpJMhiYjy6K8QqurYbDALZtB685L5uz+H+CvFmZ/qRAexSLqVHLYtM7XTMvQ0GL7U7RPwPUMC7Ls/vzd1rYTk1eXrHppcs9kdwC5eAU7htzEHSqkfa0CHbw/x+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fk/iO7mr; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlSpvI/EZmSSghq8hwY7aetJt3RPS/qrJOJh9x0Y2beU/67XMhzcnqclPo94Fr7U29fGcWweRnArzY3UfCF085S7DqZBQHWa6DhlL76BRb/sTwF6Fw9Im1x4U1FdeHSOrPlp+nPS+uKVnN8HtxtqKO/uOgx8bT7mtfoYcR2ZEZ7vRe1P9ZdktJLcaunQCbNKu68MZUhgH+efEeRmITUNNS9Uv/mgEq2JvIDq1uxSSbqRm5dJu72aZKp6YkmVTQXeuER89UzoiceFkxt4uQZIYRwheakvIvQQs/eLu6Xha15iuKZWFrDS9RBkAmaSs1x9i3BDFQkPV9GYOPST1LqDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t6riHAd/Dtv+1DZZZN7b+024mN4Fam6OxU4MPYZMbM=;
 b=ZI0Yqg92VxjjCwHkM62mcUikOEUmUvsmqnqR/q+K3vFk/NN7tT6HEm5adjGB8qJ3/jQTASuuCw0MQ25RiyA0d2XK5905EbAd5+CQoItkf8zAAbynpExCH3TVKF7peAvpugh46IOdQ3C6UEQ/HOaPK8aAPrtVrPJarTA8atd2hTI7W8yTov0jvrujqCUjvV+xy1/rY2KWZqdgp0fFMfeyv2HYPAsEzSwFbXmc2obaCHJFbIsvzCwIF+TnRtctJTQIkiswKJQfvmrYTnl5TggMCGhFcNQTiExTEN15LR4BXORc/8LN/qFEFOFvk+ujNR4ONwE3oTHRsnrsEVfUzrs4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t6riHAd/Dtv+1DZZZN7b+024mN4Fam6OxU4MPYZMbM=;
 b=fk/iO7mr0DCcxHW9JHPNthQglyPJEzUeh49n4MKI4KgVr1LBlZS1Bl23CUnPNMbnSNm9XNIrEs/EonY5QsOVZNyBXKgmFF7A6EpVif/9cjEYqPayGgnGdIJMzOxDn9hoG1KSlEVP8uadzOJ/QXRhEfenM8vhnWgFV+Kij1qGumg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8025.eurprd04.prod.outlook.com (2603:10a6:10:1e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 17:49:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:49:36 +0000
Date: Tue, 23 Jan 2024 12:49:27 -0500
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
Message-ID: <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-poking-geography-33be2b5ae578@spud>
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 01eafd4d-e7c1-4329-a058-08dc1c3ba9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/fHXQSMT310qmU3VHLe9/Wy8PcURamaNduhutmmtTGCFkPcJumWqduDNAwQ8qsd6+oKMHgteS3I9HCJ6oqU8PMKj+4ObsVa5TjjrAJn372JideKexRocCYREX8Ww84t6uaCejclkeHDMk6jmUrduAxQESDwg2nrzSygaHP6IayEfijPGQKZZlb9Fd0oQwt1TFZaelmjg7BZGg4TeT0PTNWrSYpi0KAnTHQexLz1aUQkELlUWzNM+l+Jc1RyIAnbbpfMMNTqTRfdFyF/nu2+ez9ppt8ZDt26boe+pFOV1+9pqU+xoBN7bXGvebvEyiODsylt3Qx//pAOWuTeNNBtlESF8YKhOWXvWREpTOeJqbkiZ9jAP2kwTBQrP70ZqH7RwjsSX2zIrRQDfc6U9vC7mzxH/uV6xoDgm3R6C1QPtcIVylDPpgIgyQ44ycCYvYXLbO8r0SGvxVi5UFghL40l9xRZhhRwcbui2JdPSnbkb3UjADw2cOFfmCMVY7aEKFFrFKTcGvXF7QMzqBqOrG39amaDO3E571eemVQzM7cjTHebS8xjgVPFLX9NhR21RfmrWlT4vQ2nIEXXvniSzgmlVpxI+nRZeIkHRJFskb0gCZ8vuPV8Wqfn0GrKWgOaK2/qP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6486002)(6666004)(38100700002)(5660300002)(6506007)(4326008)(26005)(8676002)(8936002)(7416002)(2906002)(86362001)(66476007)(33716001)(9686003)(52116002)(41300700001)(6512007)(38350700005)(6916009)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gbb3blD7wgG94BD3/4Z+niu9iul6LQmu13B3Xb8+FlhAT4HoztsS2xjF+6C7?=
 =?us-ascii?Q?eR/K5ie2zzzKhXOPNusWJGfywZb89xnBftadTRxbq5n22Viv4f33kisqlnZR?=
 =?us-ascii?Q?G/lhd4FGNoVPObJR/jiCJlqlW7YChHvsmp3StkO8cF3HKN1kCcEwtshym8ts?=
 =?us-ascii?Q?oEnHfbVtNalcZchmVgOyvzAZS70io3bsh+rNhNq+922C6Ig94uPsK8BE1RFE?=
 =?us-ascii?Q?6WyE/WQNRkCR8ygS8awsKip6Veyw3qZcFDJaammPwgZ2VJ6102OmJPCUX92/?=
 =?us-ascii?Q?l+tAyONbywifNxaALMFwHNkKVuUklp75TnzoxsVMUa2iEnbeY1gi8wIhJNEH?=
 =?us-ascii?Q?qRuwyveux/JsIfrqhn20UlMVi6LU7806JSCMrvqdzKpiDKXeEyq7YqFw8w7h?=
 =?us-ascii?Q?gllNysOUgcEtlU24WFeFxiJINoJpQ6ubiC0XKl0JsVQKBQ0PZ94DqgiZBzhK?=
 =?us-ascii?Q?eMARq4vMg41rW79+ubirGLqZWmL7atwxVBGAJccgSeMeSjw4Q9K0cDhmeAjP?=
 =?us-ascii?Q?l7SQ/FfThomH6TNce8F3+krPVpZ4oXxqVGWQOTswynZ398Bq6qBz4MOClzFu?=
 =?us-ascii?Q?P+nCKZBH2FAbM5SlooLh7UH7H5iG8D3sm5UQZktbKyzWyQWP7vwPUTkq2YPi?=
 =?us-ascii?Q?TcJ9UdcyqSB9fre0o8LtB8LtvCDxLjTC9PmKURGmfBlerhb3wR3tT/4znUmF?=
 =?us-ascii?Q?T7JzH9+5Y7wf+KAQ0mVRALporWJiEINCbdQLN/ywDI+5pkhQ9d2m1XZ+1yWK?=
 =?us-ascii?Q?vSAScha1TRcMIZEQbHYPfCgb1EzfrLCPw+lqZcBAqJ5V2lfUiU6EGWXJmvdu?=
 =?us-ascii?Q?sAsK2Fojn7F2HG6gyqWheRs2F2xP+iPlpZ5NHL+rnC5x+uZDljhMa/dSvtW1?=
 =?us-ascii?Q?Uvo7xTFiX4gnYSwIf9iPn5Pq2xTfzARKWmPwaM6t2kM9lOgj/2iP/ifuqYMC?=
 =?us-ascii?Q?s8j8fROlsAvLmy90FNtwa20BUjVF+dJQfd43learSD+qFkWFd/LfvBB4JpGG?=
 =?us-ascii?Q?JOSmY9lAyl/Lx9XhjprO9jKsyPTF6VqdqRu+99tuVXr/1Yx5T/YgQNwcpwl1?=
 =?us-ascii?Q?s5FOVuC1oy+pdYFQqw7dCF1pRsi+vFLODpt23CbGqcVlLdaX7xQB+DeIGARp?=
 =?us-ascii?Q?wXuNyJamQAE0wanYy48qR9Ro2KLjymH6xEgBW8GDvfXzizTeOT8JXisNBqSt?=
 =?us-ascii?Q?erzaqgNzzYPHIuLUll9pGCf6SvCE/ALbG6tegIY0G0NGmQ6+zqpu94mDqLkq?=
 =?us-ascii?Q?PAbQf3xQkGF73QXbVJPCE/4CgoEzfb/LG87/o+CeeM5qqo9xMFgzWEILs7nS?=
 =?us-ascii?Q?vI84YcWBBTR7fMv/eIzCSuvGQhv7EkCmXjL26KuPTaEUhbVH8cuqyE6xwDp1?=
 =?us-ascii?Q?FEOtoFme6ll7Rii5WvWKBfAaSxMKD9urWnHmxoQlv/9gcWxoz1/i0eXLxlWi?=
 =?us-ascii?Q?F3/rYqsGEXee6UMPziPsSU7ZbcbzK/OaM74U4rizCCKzQUr4UUpwdwVC7wLz?=
 =?us-ascii?Q?IfKWHe7OPKQSkp57il/XACMnRUYvzFrct1MsSTrnqwEXn09vKnDoEtBa8dBP?=
 =?us-ascii?Q?qXGD+LbQcH3d1dwXOhqBj6ekT7YB3MMJ7GUuRM1Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eafd4d-e7c1-4329-a058-08dc1c3ba9f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:49:36.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I3nUFE4PwgC1GD8atVqfqkbyM6ssM4oYdhQGUq/+1eaGJfSxPycmc2eUx3prYb+QxqLhcHr9qafjhYzQKUq/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8025

On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > Add device tree binding allow platform overwrite default value of *REQIN in
> > GSBUSCFG0.
> 
> Why might a platform actually want to do this? Why does this need to be
> set at the board level and being aware of which SoC is in use is not
> sufficient for the driver to set the correct values?

In snps,dwc3.yaml, there are already similary proptery, such as
snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
driver keep consistent. And not all platform try enable hardware
dma_cohenrence. It is configable for difference platform.

Frank

> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index 8f5d250070c78..43e7fea3f6798 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -439,6 +439,42 @@ properties:
> >      items:
> >        enum: [1, 4, 8, 16, 32, 64, 128, 256]
> >  
> > +  snps,des-wr-reqinfo:
> > +    description: Value for DESEWRREQIN of GSBUSCFG0 register.
> > +      ----------------------------------------------------------------
> > +       MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > +      ----------------------------------------------------------------
> > +       AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > +       AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> > +       AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> > +       AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> > +       Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> > +      ----------------------------------------------------------------
> > +      The AHB, AXI3, AXI4, and PCIe busses use different names for certain
> > +      signals, which have the same meaning:
> > +      Bufferable = Posted
> > +      Cacheable = Modifiable = Snoop (negation of No Snoop)
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    maxItem: 15
> > +
> > +  snps,des-rd-reqinfo:
> > +    description: Value for DESRDREQIN of GSBUSCFG0 register. ref
> > +      snps,des-wr-reqinfo
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    maxItem: 15
> > +
> > +  snps,dat-wr-reqinfo:
> > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > +      snps,des-wr-reqinfo
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    maxItem: 15
> > +
> > +  snps,des-wr-reqinfo:
> > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > +      snps,des-wr-reqinfo
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    maxItem: 15
> > +
> >    num-hc-interrupters:
> >      maximum: 8
> >      default: 1
> > -- 
> > 2.34.1
> > 



