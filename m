Return-Path: <linux-kernel+bounces-31413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF28832DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C76B2838AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CE56B67;
	Fri, 19 Jan 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVXfY1tQ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECC55E64;
	Fri, 19 Jan 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684415; cv=fail; b=WihxR18E75o/ivpOiG6LLJ6ARqHc8rE45cU8Kn2bipliNPyD/mgO5xMlzS2oxh8YCAVfbfrMHmgainW5BK0yZWsUup7TtN7sR0AP4Sb9eLY43YDeKhfAQOn2EtGrv9b0Nr2Y9kJtn7PhQZ4/M7xoUANU0Iclt3q1LVG/tSIab+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684415; c=relaxed/simple;
	bh=8C0zSsvzzudnkhwIX0wkWhjf3Wo5QT+hdRvwJrGHBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UBjPU45w6f15eBgZHiWGfU6BR9F4fA2qGfbKucYeV21LlsYIeY486hHlb0Qqhm38FosOJGNDV9b7wZePng+C/4ewwZN8OmXOClrgxAGEZxXVwMerMNmjTs1SfuDU/87PfnYHENf3N+2ZvpqbGXMbBv3MdXhSnmYa1dTNIGMf90g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UVXfY1tQ; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5ofzKkDFpBGD8d/RYHPVrhfGT5a5fQnlrhKPRJMwz4ynjRIA8sRxA3QkPhPq6V8QOHcdbAiFTFAgtLzCrRF6nACJFnxUzR/cE+2PeiJVWJRJceavm+642cs5xcBUqdqQbE83wPAvWYLRpq0Zag5BU4KzeKjH8uO3uey0YvkiY7dSHl4iVfDa6nT7nxQHUDD3xwexYG4XSthW0KHwvfFN2IGZK8zeAkYe9eQK4jDxPgQ9tpokF5taapw1fNM/DPfA+5IHUwl/E2kcpa+D2AaUqpcQEb3MZ8NiBqeelcxLBeEFfCY5tTRlSx0vIJKo8YlrBODRcTIgBL3LlwHoN2VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D94LPJO/IH8fNRFUeo78w7rPs033lY3Dv7DLcx8g/FI=;
 b=QLwOidmt0Ec9RDlHFRqDtZcUXwDR+8XYgiPwQO6Yx3XBaSfMiZVRnqDKjMPttW1fLaljT0rLXttyGmtHzpIwud3UX9AC4GLjWQiswb2ZFjyf9EPmeALtG+5lEQxEvyWIcIWBqaTtU16kgafdgB6fclrRq4zdYdIwuGp7rYMbRasoP0sAWe4bAmZHS9FMfq9Fmv231UICcMbOoggTTb2rFO1smOUqcNAUFwfLW0MyDjJmz8WDKqduHQxlxthR2njciXqLvUDY323j5ZO8YIqRGkshIB/eEfZDjEsGOuQwDJQH8hrsWY/Yzp/9woMQZvW/wUGZBrfaMmC7/AVHGdh0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D94LPJO/IH8fNRFUeo78w7rPs033lY3Dv7DLcx8g/FI=;
 b=UVXfY1tQ+KzUGXD6JihhTa1VpQDovnk/Vx6uZqSjNr+KNnjPDFeGrhzY6cCEwzIxA7Cg4Oky7r14DZyLjXXj4A6znL+1h1tXJLmZl7P8DTjfiAFudU83O8KVDfXPQG/XAPMOvDim2E44LNDOPz7NeZCaayerYGOKsSvWSZl35A8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7758.eurprd04.prod.outlook.com (2603:10a6:102:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:13:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:13:30 +0000
Date: Fri, 19 Jan 2024 12:13:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>, robh@kernel.org,
	alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <ZaqtsjIOsswTqXsv@lizhi-Precision-Tower-5810>
References: <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
 <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
 <ZacCQ1Eysqq5FnA4@lizhi-Precision-Tower-5810>
 <ad44d51a-ba64-4a4b-bba9-205faa760c78@linaro.org>
 <Zaf+Gn6rYstttnrA@lizhi-Precision-Tower-5810>
 <e57d7f34-3abe-4860-8986-0cb7070819a4@linaro.org>
 <ZagXF6vMHVxvZX+6@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZagXF6vMHVxvZX+6@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3e5e46-10e5-4116-0e68-08dc1911f5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cPfD/aeTyzMOD6yd9rSjECv3/0Wx/Ls3Ga3C7QFIK2AK1ZsnqOFVORiEGC+UcMfmHag7sPmk0y1IWiMIi/VElsdjFYNTHVShK12WZpJFTH1QTY7iNsq1YuRwkykrbOgeNCd7a6wWjKiyd+a3l7eg2bMMOeNqkGJncQjsHMUHOiy2KTK8awOkmt82dZVY9JHaRjZKY5jmTb6s6U9baISu/2brc5ZHAPIC9089qTOSDqAKhMo8igRibPNUNfDX0wz0oPjf77g1lKgMADw2WwuhHBq4ficJLow4P1DtuVPmB1WjtaKTfLw3O5Nb0w+F8G8WMrOesYkxCsaajirTd+8uddPExejw+wnKE8Q3zQCDV+u+b8w0R92RuY0tJrv6YWB/gV4mGMyhwlwm05en8oD5jswFNs132K8zHl2yDmtCaSO/VSjlIU/03PreWX2ZddEM0WjGf0FAi+IiV/OmcCFTcHTMToew4aLdchikwYGAF6cIVBIzwwfCGPZNM5pZHB2EnyR1f1wTG4D9uCxY/BXWtClEZDReCmmRwgi7reVMx49moqs6j9Q0VyxqsWJLwBklElE7hoGLPh+k9xyVVYz90J467kJ+3ILOp9iRmOdBBj7nfIr4jTbH6Vo6zVu4MAyk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(52116002)(6512007)(26005)(53546011)(6506007)(6666004)(9686003)(38100700002)(86362001)(38350700005)(33716001)(41300700001)(8936002)(4326008)(8676002)(6486002)(2906002)(5660300002)(7416002)(83380400001)(316002)(478600001)(66556008)(66476007)(6916009)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b0r0YfM9aGHxMdhbCGvJpr5tBS2aFEiAVBCEg3f3KkFsXxK45QnwtOwY/ODt?=
 =?us-ascii?Q?ix5bge9eoICVEOygPzayazObddLjMUI2PZ0Gm/OHk2PrQpRx0aZKX4hRG04A?=
 =?us-ascii?Q?Y05T2PPQpuOODN0nQUM1jcN6d8MzMzyYGRtB7KqAl3GhKwCa8X6Avxh5q4OT?=
 =?us-ascii?Q?ZGwrWjIEe6TAkT0TK9KYj3XExjEeNG3PQU+nw8eMhrYlVNwBPTJB8AIiOlqP?=
 =?us-ascii?Q?6EcFTYr/SuQKHehyzncS6gsbqBq9hicned/TkEpbXgYDp3nXCzZ+RK/K7XF5?=
 =?us-ascii?Q?C2DhDMK6kzGXE5jkWj0KQPeoHJVn1nRHNtkKgtrU7r2++oFEkcibK8oTXwd5?=
 =?us-ascii?Q?Q7O1mnzooAI4EDu9PeDWqmdydpSYbnZxpmNSQH5zH5/fMfOAsag2CLfj37MW?=
 =?us-ascii?Q?tmfzhvnatOerG4RtqN3Th3Z5e9bm1pWu5eZd5EVSHbS96IYVX9nTy5dLYlSm?=
 =?us-ascii?Q?WhMnG//NZDGNDF8+wzneYS23/um+HxXDvW21ltzOqNKpkeLXplq1jrSp2Mpf?=
 =?us-ascii?Q?ccSzN/vX0hga1+IIXalYlvQk6eY60RUU/bPdtglK/e7AeJLizarqYLwBdrq6?=
 =?us-ascii?Q?IxCg0m5Qpxq8KGmK5w7CTanNa/KUWizGouJoKFGHEzs+YsQDBav8nBCbOVfU?=
 =?us-ascii?Q?gof9V6DL481cTQrqcBHPXOBp1TnRWfQNpDfpiL5NVJKNaFw3/CYf05DC4ORn?=
 =?us-ascii?Q?vUNixxU6QKrKGe/uJj/vNudX1/PrstE1KYH3EJeulYhJfw0SAqpqm7gPZalx?=
 =?us-ascii?Q?h3ocFvWE5NyGOdeNFnTg8K9GBs0RScWk6UZWi/NaivAf6JBZ47eCu4qKNhAP?=
 =?us-ascii?Q?cM9OBXokKwXtShyN3EvYEBIRCPR2AMsLG70kX3FeWpkqOm9Bhhb8CbfkWwyM?=
 =?us-ascii?Q?SJ+M2eUSPBLUq0s6Ck1fgAed4eMrsgs/oqxFXz0jwxmcAUo8qYUzEdpMD0b7?=
 =?us-ascii?Q?cLtbgwRTYq6GjZgbRnAcqaci6BTJifGm1YAOiGpFPK5WHD2ldGv9cVBYBKuz?=
 =?us-ascii?Q?fQYUWmNtNlXw1b0PB1XyE8Y/orgaPilgSpRRnTu9h5LQ1SYiQP+BJkIg9G8C?=
 =?us-ascii?Q?0MWhD01vp8uzgcEcAAX6dLOMxVNMKBTyMMBQzicGH1+5Z/t8RuE0YEH4uNnk?=
 =?us-ascii?Q?jFt3OGAVJYJWoUYEVqloaMQnyRQ83znW36n6p1ocBOEouHM7GycnSueP/N/x?=
 =?us-ascii?Q?8S0Go2tWF7kO3u24KwFy5jvJvvlSwEQqFPs7ck7/1LL1W9NlYUFMrYI1RmkL?=
 =?us-ascii?Q?KxUpVOQaosBZb5YTnTQE3m2bT6tHDSaQFczhrXz2kwgmDmQPgDelHRlycaxc?=
 =?us-ascii?Q?LyT6mS3z9/Y4sajNrWeu4jHntOiulDUejLS4C5xU/VefOmV7obwjVUDGHn6t?=
 =?us-ascii?Q?hmAHb6/yP18PWqM/3OU21xq/Xia1+vKwxS8vrrsSBjjncup5uY/mO4YGyLxo?=
 =?us-ascii?Q?aqxC0sIFgEDF3QEmRYYmRyAPO7reRCUp8CMxBqxS2WtxEHKNKKXL6V64nfIx?=
 =?us-ascii?Q?x+ORG/2WUXS/dwO6sDbZO8GW7atV7csMrFUBBxh3cdc6+8iSitXCOkwkKWd2?=
 =?us-ascii?Q?9H4ZdhYxV4jXJP+I2bX49cyrG9ekeNaYZW6S1YUo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3e5e46-10e5-4116-0e68-08dc1911f5b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:13:30.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtwTvfYSjctm2EByC6HBKpomsF7Ok0jqqJR8lfwSIkH3D/8821WIW0kvuDdL2znp3jM0kUGBfW2K9MjVWfM4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7758

On Wed, Jan 17, 2024 at 01:06:15PM -0500, Frank Li wrote:
> On Wed, Jan 17, 2024 at 06:15:51PM +0100, Krzysztof Kozlowski wrote:
> > On 17/01/2024 17:19, Frank Li wrote:
> > >>
> > >> Not really, because compatible describes hardware and it is the same
> > >> hardware here. We do not have two different compatibles for GPIOs being
> > >> input or output.  Or two different compatibles for serial engines (ones
> > >> providing UART, SPI or I2C).
> > > 
> > > GPIO and UART is simple. Actuall SPI and I2C have two mode, slave and
> > 
> > I talked about serial engines which can be multiple: UART, SPI and I2C.
> > 
> > > master. Many SPI/I2C is dual mode controller. Just seldom use slave mode
> > > at linux side. So you just see master mode SPI/I2C controller in dt-binding
> > > and dts file. So few people upstream slave part to linux kernel community.
> > > They have the exact same problems if support slave mode.
> > > 
> > > PCI is typical example: 
> > > EP mode:  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > > RC mode:  Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > 
> > > Which is the same hardware for two difference compatible string.
> > 
> > That's the only case, I recall.
> 
> As my knowledge, yes. 
> 
> > 
> > >>
> > >>>
> > >>> I can write git commit message like:
> > >>>
> > >>> dt-bindings: i3c: svc: add compatible string nxp,imx93-svc-i3c-target
> > >>>
> > >>> silvaco i3c controller is dual mode controller, which can work as master
> > >>> and target mode. All clock, reg, irq are the same for both mode. Add
> > >>> compatible string "nxp,imx93-svc-i3c-target" to let silivaco i3c
> > >>> controller work as target mode.
> > >>>
> > >>> Of course, alternate method to added a property "mode" to distingiush
> > >>> master and target mode. but old "silvaco,i3c-master-v1" will actually work
> > >>> as dual mode support. Driver structure will become complex.
> > >>
> > >> Please send full DTS of user for this, which works for 100%, so we can
> > >> see how it differs from controller mode. If your code snippet from other
> > >> thread is correct, then it would suggest "mode" property or lack of
> > >> children. Maybe lack of children is not enough, if user-space could
> > >> control I3C bus.
> > > 
> > > According to current implment, only need change imx93.dtsi's @i3c1's 
> > > compatible string to "silvaco,i3c-target-v1". I attached imx93 dts node for
> > > your reference.
> > > 
> > > 	i3c1: i3c-master@44330000 {                        
> > >                                 compatible = "silvaco,i3c-master-v1"; 
> > > 					     ^^^^ only need change here!
> > 
> > Nope, don't change compatibles of existing nodes. Unreadable and
> > unmanageable code.
> 
> It is just show minimize difference.
> 
> Normally, it should be.
> 
> 	i3c1: i3c-master@44330000 {
> 		...
> 		compatible = "silvaco,i3c-master-v1";
> 		...
> 		status = disabled;
> 	}
> 	
> 	i3c1-target: i3c-target@44330000 {
> 		...
> 		compatible = "silvaco,i3c-target-v1";
> 		...
> 		status = disabled;
> 	}
> 
> in board dts
> 
> @i3c1{
> 	status = "okay";
> }
> 
> Or
> @i3c1-target{
> 	status = "okay";
> }
> > 
> > >    
> > >                                 reg = <0x44330000 0x10000>;                
> > >                                 interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> > >                                 #address-cells = <3>;                      
> > >                                 #size-cells = <0>;                         
> > >                                 clocks = <&clk IMX93_CLK_BUS_AON>,         
> > >                                          <&clk IMX93_CLK_I3C1_GATE>,       
> > >                                          <&clk IMX93_CLK_I3C1_SLOW>;       
> > >                                 clock-names = "pclk", "fast_clk", "slow_clk";
> > >                                 dmas = <&edma1 6 0 1>, <&edma1 5 0 0>;     
> > >                                 dma-names = "rx", "tx";                    
> > >                                 status = "disabled";                       
> > >                         }; 
> > 
> > That's not a patch for existing file. I did not claim you cannot write
> > such DTS. I claimed you don't have such DTS for upstream...
> 
> Yes, it need finialize this topic before handle dts upstream.
> 
> > 
> > > 
> > > For master mode:
> > > Unlike i2c. Genenally I3C can auto probe children node like USB can auto
> > > detect attached devices. So I3C master can work without children nodes.
> > > Such as auto load i3c sensor driver according to i3c standard vendor id and
> > > production id.
> > 
> > Then presence of children cannot be used.
> > 
> > > 
> > > For target mode: using configfs to controller I3C.
> > > 
> > > mkdir /sys/kernel/config/i3c_target/functions/tty/t
> > > echo 0x011b > /sys/kernel/config/i3c_target/functions/tty/t/vendor_id
> > > echo 0x1000 > /sys/kernel/config/i3c_target/functions/tty/t/part_id
> > > echo 0x6 > /sys/kernel/config/i3c_target/functions/tty/t/bcr
> > > 
> > > ln -s /sys/kernel/config/i3c_target/functions/tty/t /sys/kernel/config/i3c_target/controllers/44330000.i3c-master/
> > > 
> > > Then you echo test >/dev/ttySI3C0.
> > > 
> > > Unlike USB, user can switch host and gadget mode dymatically. Suppose I3C
> > > only work on one of master or slave mode only, which is static.
> > 
> > I don't understand this. So it can switch dynamically or not?
> 
> I3C Protocal allow do that. But no one really do that. 
> 
> > 
> > > 
> > > Although it is one hardware, I think it is exculsive multi function device.
> > 
> > Just like serial engines. Do you see there replacing compatibles? No.
> > 
> > > 
> > > Summary: basice two option to distingiush controller and target mode.
> > > 1. by "compatible" string
> > > 2. by "mode"
> > > 
> > > I think 1 is relatively simple and easy to understand.
> > 
> > Eh, if you only saw my comments on people replacing compatibles...
> > Anyway, I stated my reasons, so to reiterate: NAK.
> 
> I know it.  Needn't emphase it every time.
> 
> Is using "mode" ('controller' and 'target') proptery okay?

@krzyszkof:
	Do you agree using "mode"?

Frank
> 
> Frank
> 
> > 
> > Best regards,
> > Krzysztof
> > 

