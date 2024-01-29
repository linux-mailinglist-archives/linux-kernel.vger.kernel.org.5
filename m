Return-Path: <linux-kernel+bounces-42985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9348409AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E5C28BC00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243CA153BDB;
	Mon, 29 Jan 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GUHQyq9m"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768A153BC4;
	Mon, 29 Jan 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541578; cv=fail; b=sRHuGT+5ECNC3yjshS2iBVGeKOG/rnHnNGnUN5mAZkdOL4wrpwwFePhTA9kE/I/CtaLhJvNwkvnw9C1JRXGTfEIbp2dXZP7f1r8YjgfA5tbiWPvHbDB+yDwmVBGAxcYO1Fzi7z6grwjejSpBqh+YpeO70UgszdTxjq9QMUKvJK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541578; c=relaxed/simple;
	bh=zOYB8AU0JM6SD/hKjAKdhCChxDwjTPuKVPxfZJWbnHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ixr+TgqZ2WmOFdvcmkhGkXrIuT2MUuZG/SUHt0zg9nVwBgIPXW94hZdfing26KoyDTZBq6oMmjgMx72jpQwEnrhPm3OnzxZb19fIqyWfvBWztFlPzng7C4gUbC8eBLki26lFU2+zkiKyyTvNOicoXAJOdgR+cNINmwZFXWB9yms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GUHQyq9m; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnfqyuhpXR0WbwOTN3onphVCcdMqNy2/rV/nUQCRh4ZB/Y2CJxjwOPlZGuZNfNiTw+2NJx3S32RGWrNJ5PKFXWyrhMph/opIMVtHULYGiMVbMYDmzjISBiiXlK2DOMPL79mtvyak+rTsOx4rvYzg4BCsYephoe381ZVDvdX/kkBhnmnB0aodjPxL4BG6XyUb5eBHwUuXTbFR+RkUYXLGKLcdzvOiNn0q52Yvn/A1kF2D3phi4MPM8zAyAuaBahCd3O39O9mMb/De53NTfdWbjSxG2tOU0Wu/EA9YCGyP99gb5UDFQHRWrLigiOP1QW8KKobEDvixiiPltQRWDDX3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwqMHeB5ZgtIk91nH8YXqey9JNJknLuPeem3hhIYquk=;
 b=XomDoVpeVvHYbgo0Kt4u71woXliXm8XpULGCLZ8lgJb7/57+FMsCdO1xNZQZ6R1sQfwJMsWy49EJc0WLLyDtsVybXfXydego0It6DdCdNgM6p482rwlnxBmSlD5YTCUCselDQfvyIFE9ynsJTn8obcFww4mSNcP2gMbD2faf/HSizi4N+w8gOwrPdHdtpbaIbXX4UX/IummUCzs+LU4Q0hh9x0nSjnVwf7G02ABkGjSPMSHUFcMsc70EDMd02HmPYRyjBLwpCDZ+eJcKe7iknepD5XdlGE7GeM8gkla/ubHB0LLGcOyGLlVGDhi9tlJEdk6KzRMBmUm9a39akOHrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwqMHeB5ZgtIk91nH8YXqey9JNJknLuPeem3hhIYquk=;
 b=GUHQyq9mjQwmHRVuHD+Dxy5GcxYZnyp6bpgsF4fO767qLgDxkAwzew/dXgvKJNuoJ7cu1gleycz6d5b2mPbuKJTpst7pJ1XhNIQqWukGLuoL0NUlS9GKlSK/2smZtAI8fFPAT5cA7gpjhmChpuL8IN8/UTvmmB2vpIAOg9Ztzxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9966.eurprd04.prod.outlook.com (2603:10a6:10:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:19:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:19:33 +0000
Date: Mon, 29 Jan 2024 10:19:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, thinh.nguyen@synopsys.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9966:EE_
X-MS-Office365-Filtering-Correlation-Id: aabc90f4-e57f-42e4-296b-08dc20ddb217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	31vt7xfyriK4TBSWzPyCiYCIzgkKD7jH922ovsEnEqrhCA/H9Ld1MwuYyJAkn/TKQX/udkYf3OacXoHzA42vrIZd/RgrV4+p0gqA+xLcCisjRY2wlzcSEf4sJsBgGSVmddwnwOv7F1kGV0kjNufREMzfM2RJhcb5dX8s0ZajWp1REBnYObfV7LBQ1xUFvt2PkYsBndKFoDBD8wWtAZRTeSj/mvJi2OGRdHjm/XVcyr36Vczu4qxmAhRbjuDPyIuEO2kJU3Srd5VKWqMYwSUyk7ktY2YugbZwccAcsosf4cvclvQgaz9o25Tj3okzVMAQMHynf+zKCQC8NZP28SIxzM79wWq5cPNp9GIoCU6NlGAcwXJjy+vWn0j/rdsEgSvZ+cnEqSHyYIs1XVo148nHDJDMi0N1/zVO+P6yceenlg1Hy6xGWwfo/PGw5UXaYgHf+Dm5Xq0ISvbIOr9jTa9kKTCiR/PrJu3ACfhOOajxNozT/shDRNkF5q9ygOTzU8SOV8/n+JZk3RtHVrMYYWXB8PKCWWkdCIPdW6PFCJQbjsqijqePJSUxIl70nRkeWfF1YlwnuimcCHfBrQVt2yzaBsgiNkQMZSEn7CcgSTQs0iow1Q7j+dGPM1seEqZwdAXO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(52116002)(26005)(83380400001)(6512007)(6666004)(6506007)(53546011)(38100700002)(9686003)(66556008)(5660300002)(4326008)(7416002)(8676002)(8936002)(33716001)(41300700001)(478600001)(2906002)(6486002)(316002)(66476007)(66946007)(6916009)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GGrgZUdWrc2Y4saG64mheCwHWWv/wueQBM7kNkw2TAS3chJHi6uE9czFzH+k?=
 =?us-ascii?Q?bsXgIeAfaUsEZxiktaFhKc1fhf5T9/xyp8hrV0tUweTv/N8dIL9gsgH4PQ45?=
 =?us-ascii?Q?YfN3ZN19IL37SKuuTrwdTSBFWyTOAzreoaG6Qh/mAqA/UnXwNkOzBzBPklZA?=
 =?us-ascii?Q?eK51+6E8qZCmXukjLPi9XV5qiopUd7bJGjHLVaItO7zUXSUxdeUz4NNmyxDU?=
 =?us-ascii?Q?yCfI13M7bmRU0nxjsRFum7Hn8zCIfFXOWYCjuzkK4i3IEHZ6DJXiiTLJY+sW?=
 =?us-ascii?Q?SUxxnYpAittvABKYMbSRnI4E6xhYOzicbKEKiZ4k+a3PPBhLC0PBx0uhQnY9?=
 =?us-ascii?Q?I2Bwv+Ixw9hltDYDzEK5uC3eKGAOJhuKUTtI489TTwHYg4+jcessHVC43jYs?=
 =?us-ascii?Q?hwvmeCqIpwupeBeHOU489xVLD2r3/JyYsbYebx3GL2WUIKBegTCFbY9E08Hd?=
 =?us-ascii?Q?oNa1oHm6Fexun4SpoBSF3eLzKhc+rXf11+uPZLMRQtMh6xPi5jbcZk0uaqgz?=
 =?us-ascii?Q?/0g8XuVZaHyUE5MPiGXbJM+2ycZTNLjievK3/DBRX4qMcBQ4U3nWEoReXrX9?=
 =?us-ascii?Q?6Tlcoc5SjyGCH+OQUTXrpvbgUZf18dubpM2+rgLzXqsVZQl0obx1lzjvYBUA?=
 =?us-ascii?Q?D5/uZXngWOWvij4KOPrfQnFk7sZvrEN/tGon9uIZ0IZSDz7yiR3MvglAQ7UD?=
 =?us-ascii?Q?WL19fT9J0YuDao3GckxY+/Lfpsq6pIf9vohqx2TEyjjv2a8R2ozNlSprONWn?=
 =?us-ascii?Q?/YHYy5d/lp977kEBH3oEipW3774D4jeWuubU19RC6DTPDChlLhw6tpgVsIpj?=
 =?us-ascii?Q?Rlm236cQ9+5mSi1N4X8BEvxKOTRjr3hRlYxEoTinatKfDrhYTZTH2hUNGmWF?=
 =?us-ascii?Q?k09qhtUWNMuvHjXBGaR5149Zp8RdYa1WbhOnKMuyHXNqOMnygi/0s0SQGi6o?=
 =?us-ascii?Q?IPzeSdRBb1NIozRH1LsUDeqESXa+Vb2+W9rSF8R/jr7/xKd96Z4fSYTs94KI?=
 =?us-ascii?Q?YtIe6wgXCZXkmnmY/MN9MPIV+nIJ+s7DrlyO5c5PQMZM/zSgv2gBpeyvolll?=
 =?us-ascii?Q?zKOdptWL/cSJDOYQCU46rcFHxODmhiK4M14NZ0PkpTQYHhEvDyqspikfctYJ?=
 =?us-ascii?Q?hjZE3Mzw7S7aarO69vCv2b/RZLNLMQ444fTcawG8CctAgUSiYdNgGnRpduJQ?=
 =?us-ascii?Q?K0Pi0t6d2WkkM3Lcf3WTdHsb4esz8DPACiiTrYJvjv7hjfjCPr+qgxKgv5XI?=
 =?us-ascii?Q?lonwOvyvh3M0RN7DIgeGE0Q7S2RuhN2mCL/7/NdicFdNqXIUfXgiZURsYZvS?=
 =?us-ascii?Q?t1PJ2WBcIhEC/uh2rs3frLAKyFYYXtwxGyr+PT2hiA6bmDQzeBRl9N6LdBYH?=
 =?us-ascii?Q?PdD9Lm0A7sFqRP8rOprpKypX1ukaxQ0h1TPJALQbOziVlGhJ0eetrEW8RK1e?=
 =?us-ascii?Q?WWy/JY9XzURwutv3658GxT60uvsCK6PBmLHka5jS0im+/SQI5xv5UNbBZY84?=
 =?us-ascii?Q?SBotIhuhHCKvH3LKBxcHdwYr0KNQbGqjAQcXECFplwVLPdSyJBKVDBAAZxZO?=
 =?us-ascii?Q?Q0wRmiAa7u89PB2HGtY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabc90f4-e57f-42e4-296b-08dc20ddb217
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:19:33.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUxxEMeUkIQ3KiGH0s8gxJBV2rkLpe6OAmqP3EL/dlJMxVqxwNzIV55U9rhZJQHUomEynrSNakpI/xQZtjwJyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9966

On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
> On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
> > On 23/01/2024 20:22, Frank Li wrote:
> > > On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
> > >> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> > >>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> > >>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> > >>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> > >>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > >>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
> > >>>>>>> GSBUSCFG0.
> > >>>>>>
> > >>>>>> Why might a platform actually want to do this? Why does this need to be
> > >>>>>> set at the board level and being aware of which SoC is in use is not
> > >>>>>> sufficient for the driver to set the correct values?
> > >>>>>
> > >>>>> In snps,dwc3.yaml, there are already similary proptery, such as
> > >>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> > >>>>> driver keep consistent. And not all platform try enable hardware
> > >>>>> dma_cohenrence. It is configable for difference platform.
> > >>>>
> > >>>> When you say "platform", what do you mean? I understand that term to
> > >>>> mean a combination of board, soc and firmware.
> > >>>
> > >>> In my company's environment, "platform" is "board". I will use "board" in
> > >>> future. Is it big difference here?
> > >>
> > >> Nah, that's close enough that it makes no difference here.
> > >>
> > >> I'd still like an explanation for why a platform would need to actually
> > >> set these properties though, and why information about coherency cannot
> > >> be determined from whether or not the boss the usb controller is on is
> > >> communicated to be dma coherent via the existing devicetree properties
> > >> for that purpose.
> > > 
> > > Actually, I am not very clear about reason. I guest maybe treat off power
> > > consumption and performance.
> > > 
> > > What's your judgement about proptery, which should be in dts. Such as
> > > reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
> > > value for every SOC. The board dts never change these.
> > 
> > Then it can be deduced from the compatible and there is no need for new
> > properties.
> 
> Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
> controller) appear regardless dma-cohorence or not, connect by AXI3 or
> AXI4, needn't add new propterties. 

Anyone have objection? I will prepare v2 to fix rob's bot error.

Frank

> 
> Frank
> 
> > 
> > Best regards,
> > Krzysztof
> > 

