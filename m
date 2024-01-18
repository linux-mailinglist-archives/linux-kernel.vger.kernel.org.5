Return-Path: <linux-kernel+bounces-30550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B883205B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F608281880
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5772E63B;
	Thu, 18 Jan 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NH6eKYLY"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACE2E413
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608868; cv=fail; b=pCA/th4u8dwdUxDA0YorP6RHjvj7aaHd51Fg9S+fCM1nCOW5a02+5TqGcrLrIaoqLLs6Hh+CikKwpWQ2yMan8QFofHwh/Hk+2A/9XZTi3pI+Te3X+VYlB40IK/X4XBh9wJVpTseUIBbVvCRMsE1TtyDqkIpjr0NeDzub7PSD7v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608868; c=relaxed/simple;
	bh=abdnJ0kFPeSaoEs1eC3wd5y1yhbqK5qSnpTDwRVpV/w=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FX0p6TLAwiyfpWLuKckmV/snq7nRch8RweerYOPT40yJ4NFBq0GH2N5WC1oPHh4ofE6ofGuWGtFTKB0e6tlLXjSTiti6V12HAIQprfs5QeXg8/GCfbuCEPII153X/8PDzH/AGFpqsD3CK4GFGnXZ5s3RkbbbAdl//hrXkF0cNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NH6eKYLY; arc=fail smtp.client-ip=40.107.8.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4a0yNDzIcv2a/rCZNi119VZ1QmEmiaJQ69oHFlY2bHT6e2WC0m5GHaCMvw6LzI6SFYOuIqJJ0R6CcvQq//UefPWP07f6Lc8hBH1youpub0MSaJij9soMoC7x8DbKSHqynzXL1L5Dm31UjMrUuCJw/Nkku3KVLyjxH3Tr9iNYvwDG/PdcBA7c07htQ7bEOW31YQB7MGkiRyU7tJ+y4uGxE0BPiYvtGB+oEzZigNea0/nw3nE1zQh703JyMm8pItocg2gkOTc+kyLViXNcDBPZnkVWsQxgeFdBw6JnPCMxrSD/JfQT3FG799KixLXelmG18Ll7ZPhXUmM//rrCGb2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5sBQ3bIW518NjHmlQ39W/vxBk3FihyBIMCtZNqieu0=;
 b=hzyhoBRW61jKkLgNdak5d4Eaqfw8PYr7IOSbMgYRGEOBrBrVpePBCM6bgELO5q5UO3fdeq4qWqX0WEnWpcr6p+LsOpnOwgRgD2kc7W5l/KuzCY6ZACNqQsBNRyrVLfN0ahdJBKG/n7LyEUi3+8r0ILhwO+VQOdvZP/DgjiSvgthmB5/PmYRzm+SMf0c3tpXiyavtvKrbEyl5s7W3srXeR2UJ71P2OJqlelzPdWWWv3i/b/nHScH13rOzROSbd8XWWRjd/Jy8Qsx2RZWMv3y4jolbmmZyFZIi0RqsYQPPNYLwv7rFamGWVowmTXBWGig8m55MCrUhX39fEAhoaVhwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5sBQ3bIW518NjHmlQ39W/vxBk3FihyBIMCtZNqieu0=;
 b=NH6eKYLYuXa2hmvg2rc8lw8n+ZOV1ujQvEsm/vm3U1MBIF57vgbBpwP3lVhGj1F2MFb4o0vhQFMpOwvsWRbXD2AyrvaLnrUcnAG409Ge+2X/bAzHj8d75KimVN2aOpugbMIkl9WvLeg4dzuT52WHLf/foMdDQYGZ/5e+3uI+b0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6936.eurprd04.prod.outlook.com (2603:10a6:20b:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 20:14:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 20:14:23 +0000
Date: Thu, 18 Jan 2024 15:14:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: imx@lists.linux.dev, Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"moderated list:SILVACO I3C DUAL-ROLE MASTER" <linux-i3c@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] i3c: master: svc: add support for read len bigger
 than 255
Message-ID: <ZamGmNe0KMbEHu+0@lizhi-Precision-Tower-5810>
References: <20240117225009.2931699-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117225009.2931699-1-Frank.Li@nxp.com>
X-ClientProxiedBy: PH7PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:510:174::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: be3662e0-b435-4d9d-330e-08dc18620fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ihn2xCTv83KZf6Qy1nRybU0D58mJaag7+YdsA7oSZ0GUkz5FGED39YjRZvaB7Hy7bmYCQEnR1iBVC79jY9wFGYrG4yUb9hsFUNbQDU/uGSmy/mRGbMUuZ7kah7xCn/FPIPP1jnE40hSh/vZUihPLE+9th06W2lqGlNPM7O+nPBOPFU4BgGEHajxXQDNImQ67PPC4/Ud+PBHr8AY30+r81JuZuMR4DC4+51KlKc7kWjxwwPSLZIUJTYa5NnBe8yrNWtzJfUrRxc70Il/H18DFNhmI8S3k1X+CNdBmUDIjgRLBbrCkoppsnBR8Erdr7yiPjDZULW+A8kY7vbX/8JTXlNB8kbt4Tg/X4zwMJJX0oo2ZKP/FLKYOL1BZC7Ha73yWfHqgyyZ6sZ9Vr+sSTgqXFc/xYdt19o4hkWbMGUjcZoUQ9VDLiaG1smQwmZz0LIShqRCj3N1Ko/7Y4jvZDVbYGAfBwU7t5DUJlPL7NsAWYdm9rniK6mW7U1J2/GOCUCAKZe1k+IHyXVGMwCqSLxKDVX01A74uSpkGTLdp8llkk2sg1agQ/154wF1w4UM671PJucRzLeK9SXG1+83YyUis1upzs9CODMaf6Euc647r6cYV/0b3gEsSDF9x1HxZPwdO1kw7iNAbRUwRgAZQfj57eL038bSTvmEQfBqCubBz6FsTHN/8ynKHoknFBGOBd0IVqknLMdymKGXLogpg9CMJmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(86362001)(8676002)(8936002)(26005)(38100700002)(2906002)(83380400001)(5660300002)(478600001)(52116002)(66476007)(66556008)(6486002)(66946007)(6506007)(9686003)(6512007)(6666004)(110136005)(316002)(41300700001)(38350700005)(33716001)(135533001)(67856001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDI1bW91NXloRnRjZ1E4SGltcWxIbnpIU2kweU1Zdk1MS1hzNXZWNFVkZklK?=
 =?utf-8?B?bDZlcmtERE1IWjdOWTludXEzOHkxWlA0V3U2clBiZGdrMnRVTENRcS9veE5a?=
 =?utf-8?B?TXRJN3BCLzBTb0l1QTdMU3VXbzUvRFBocGxTTnJ6RDE4K0t5VzRsNmlUQUpz?=
 =?utf-8?B?SlhqVVk1SHV0TzV4aCtoMEhIcjFqVW1ZL01zM2lPV0grUXdYMUJhdG5ac2V6?=
 =?utf-8?B?SmVWNWNOWFlDcjNyQ0dXa0ZiTUtTc0U5aHo4Vy9JZG9nbG1BRVY4Z2I2U1V0?=
 =?utf-8?B?WGoyZWV5VVVTN2xRcUdhcTYzWWhQQnNqSi9FWVhQU285U0lCQTAwWWJvUDR3?=
 =?utf-8?B?R1NLNlpDSEVoMHBkS2tSTXMvdVhILzZqdGczd2xVYi95SmFjbTdDcGdGL2Fq?=
 =?utf-8?B?QTdEanFpL3BOQm9YVFZpamRMd2E3MnhidFJVNWNxUEFid3dlL2NWcllYQzhq?=
 =?utf-8?B?VE5kdmwrUCtYaUhod2ZpblJyRVIyNExxK3hWY0tzRDZ4WkV2MTFTbmIrOU5l?=
 =?utf-8?B?YkZ1cERWcmNFMC8xVkJsdmxoRVFFVThBeEFPb0JxdVpjSmdLOW5OV1hkK01x?=
 =?utf-8?B?bGFyQ3VSMGNDUk5QelBPRS9PamZ3WTZvNXBGSVFFNERXbFlsdDRxa0YycDdW?=
 =?utf-8?B?MkdaQklSUHRLRUNjMlZNRkZRWmZaa09DTjMxUnNCaU5KdUxzaXJIdjducjQy?=
 =?utf-8?B?bjlmcExWTWpqczBoK2daTndrMTNjdGFXdDN0Y3RFQ1I2WmdnSUFaajhLaVV0?=
 =?utf-8?B?TVJnckcxUVNaSlI4MkhxcDhSbzFvdTNiMjhtek40ZzFpQnZjOXNaK1FhZGVp?=
 =?utf-8?B?K0JIdHZiK1I2cGUwdWE1aG84aEt3QTRoTGkwcUk3N3lBZGtod1FvOENQblkw?=
 =?utf-8?B?a3A3SXhlMUxhVC90OFZsc1N0V2dieXhmZFlTclI1ZEpEVWVGbXZPRlJLSGVD?=
 =?utf-8?B?VVhYR2Fseno2bzVERUcxeDUrcXZ1Y3RuSktlVkJYYWhiUU9wblpuVzl5Mzhh?=
 =?utf-8?B?N1FEbUEyZHJUNUhoNzNTaDFORXY0YkhkNUNYOUJWNW1pTVhNU2pYdzVnaDFD?=
 =?utf-8?B?VXNlNlh0ZjYraGhGSWRnRzMvR3ZzSDYwYksxYUlMYXBPOHRLMW9ZNk1lcytm?=
 =?utf-8?B?WWtmS0dHN0VqVk9oTjJXaHBkM2lxUVJFTUwzbHVycUc3aDgxQXhXVFIyQ1Jz?=
 =?utf-8?B?UFV4ZjJINGtWenJ1QzdVQjZpbklPd0JnYXFweFo5STZyWDdDT0ZpTmk1Q1RV?=
 =?utf-8?B?aW9hV3E5dHNOU1llcXpCaUFtakJBWXV1Qko1d094VGJ2aHluZFJXOUlWbEFM?=
 =?utf-8?B?SC9vam5PYzR2aXQ3WC9sZFBWR2NqWU9Pb0hJeTBPcEZzdGRaOTA2WWFKL2ky?=
 =?utf-8?B?TENUVzZiV1NDWkUwZ1pLUFZ1K2RyQ2RBUy9OY0NmY2dUUDkxRmhhTW9JRVJM?=
 =?utf-8?B?eEpjNGxLZTRaSm5BY1c5Y3NBNmhDZFhjT3BQRlVSN3l1MXdKOGRnTU80WmFq?=
 =?utf-8?B?RFNlSldmZEl5cUg2cFVkMDJYOUg4QTh6K2VlUkhhajFDOHRsUVpRZThuYkhi?=
 =?utf-8?B?Z3dmN3l4SXB5NUp0d2h2YzNZK1dzWTY5NVpRc3dnRkM2OVZRTEdsOElDbnNX?=
 =?utf-8?B?ZHVMbHZLL2hIM202UWMwK2tjNFNmd2JmN1l5VllIZDdhd01MSWhaQjdTN2pR?=
 =?utf-8?B?V3F5WmNYRTRGdFBDNjdTbDlEYVA2QTlGR1lsYUxnVzh1VytSak1kdEp5S1N6?=
 =?utf-8?B?QnB6d0dxUlFPZzZqdkVpRU9wcjBsOTlyaTVqMlMzSXhUNUtjb0szQkJ1bUdJ?=
 =?utf-8?B?cnNzcUJvWXJCRGs3VmpOQ2xndU93MDUyY3UwVHI3cHczZnZFTGpzb0Rxb0U4?=
 =?utf-8?B?YTZKeGswWEdwZ2ZjWjExdlFQV3kyOGY1UE4yM1RhTnY5RVZUT2RNWVkxbm1h?=
 =?utf-8?B?SFMvNGwyWm1LS0ErVzJjVGJmdWdVeWxRSEQvRll6eHBuM0lZRmR5WDVPSGxH?=
 =?utf-8?B?SWhVVGdqZGExZzJHbVFMZS9yVWh0ZE1TdFRJblpRTjQ5a0tNRUhYU2owd3Fs?=
 =?utf-8?B?djVEdmxmOFdKSHhHNXZUU3hySktEdDJkU0RKUVJJWDF1eVh0S255TzFkUkpD?=
 =?utf-8?Q?V5sc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3662e0-b435-4d9d-330e-08dc18620fb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 20:14:23.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eMEJbX4v9V3yJlvEkJCgE/JraouShDEU7o3mvjmTin04bZf5S34NQBTmkiGyUgP76rIUJwOxIbQ61sh3Zhlhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6936

On Wed, Jan 17, 2024 at 05:50:09PM -0500, Frank Li wrote:
> RDTERM is 8bit. Only support max 255 read transfer for auto terminate. Use
> manual terminate when read len bigger than 255.
> 
> When left data length is FIFO size + 1, issue terminate
> (RDTERM(1) | REQUEST_NONE). So hardware will stop fetch data after next
> data.
> 	│ ◄──────────  buff length     ────────►│
> 	│                                       │
> 	│                       ┌─┬─────────────┤
> 	│                       │ │  FIFO SIZE  │
> 	│                       └─┴─────────────┘
> 	                        ▲
> 	                        │
> 	                  Wait FIFO Full and Issue read termniate here!!
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sorry, please hold. I found failure at corner case.
will improve and send next version later.

Frank
> ---
>  drivers/i3c/master/svc-i3c-master.c | 76 ++++++++++++++++++++++++-----
>  1 file changed, 64 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 5ee4db68988e2..58047ad357791 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -977,7 +977,7 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
>  }
>  
>  static int svc_i3c_master_read(struct svc_i3c_master *master,
> -			       u8 *in, unsigned int len)
> +			       u8 *in, unsigned int len, bool auto_term)
>  {
>  	int offset = 0, i;
>  	u32 mdctrl, mstatus;
> @@ -995,16 +995,60 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
>  			return -ETIMEDOUT;
>  		}
>  
> -		mdctrl = readl(master->regs + SVC_I3C_MDATACTRL);
> -		count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
> -		if (offset + count > len) {
> -			dev_err(master->dev, "I3C receive length too long!\n");
> -			return -EINVAL;
> -		}
> -		for (i = 0; i < count; i++)
> -			in[offset + i] = readl(master->regs + SVC_I3C_MRDATAB);
> +		if (auto_term || completed) {
> +			/* auto termate or early termate by target */
> +			mdctrl = readl(master->regs + SVC_I3C_MDATACTRL);
> +			count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
> +			if (offset + count > len) {
> +				dev_err(master->dev, "I3C receive length too long!\n");
> +				return -EINVAL;
> +			}
> +			for (i = 0; i < count; i++)
> +				in[offset + i] = readl(master->regs + SVC_I3C_MRDATAB);
> +
> +			offset += count;
>  
> -		offset += count;
> +		} else {
> +			/*
> +			 * Controller will fill whole RX FIFO in manual mode. FIFO full can prevent
> +			 * controller continue fetch data from target.
> +			 *
> +			 * When left data length is FIFO size + 1, issue terminate
> +			 * (RDTERM(1) | REQUEST_NONE). So hardware will stop fetch data after next
> +			 * data.
> +			 *
> +			 * │ ◄──────────  buff length     ────────►│
> +			 * │                                       │
> +			 * │                       ┌─┬─────────────┤
> +			 * │                       │ │  FIFO SIZE  │
> +			 * │                       └─┴─────────────┘
> +			 *                         ▲
> +			 *                         │
> +			 *                         Wait FIFO Full and Issue read termniate here!!
> +			 */
> +			mdctrl = readl_relaxed(master->regs + SVC_I3C_MDATACTRL);
> +			count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
> +
> +			if (offset + count + SVC_I3C_FIFO_SIZE < len) {
> +				for (i = 0; i < count; i++) {
> +					in[offset] = readl_relaxed(master->regs + SVC_I3C_MRDATAB);
> +					offset++;
> +				}
> +			} else {
> +				if (count != SVC_I3C_FIFO_SIZE)
> +					continue;
> +
> +				/* Issue manual read terminate at next data */
> +				if (offset + SVC_I3C_FIFO_SIZE == len - 1)
> +					writel_relaxed(SVC_I3C_MCTRL_REQUEST_NONE |
> +						       SVC_I3C_MCTRL_DIR(1) |
> +						       SVC_I3C_MCTRL_RDTERM(1),
> +						       master->regs + SVC_I3C_MCTRL);
> +
> +				in[offset] = readl_relaxed(master->regs + SVC_I3C_MRDATAB);
> +				offset++;
> +			}
> +		}
>  	}
>  
>  	return offset;
> @@ -1042,9 +1086,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  			       u8 *in, const u8 *out, unsigned int xfer_len,
>  			       unsigned int *actual_len, bool continued)
>  {
> +	int rdterm = 0;
>  	u32 reg;
>  	int ret;
>  
> +	if (rnw)
> +		rdterm = xfer_len;
> +
> +	/* If read length > max RDTERM in MCTRL, using manual terminate */
> +	if (xfer_len > 255)
> +		rdterm = 0;
> +
>  	/* clean SVC_I3C_MINT_IBIWON w1c bits */
>  	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
>  
> @@ -1053,7 +1105,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  	       SVC_I3C_MCTRL_IBIRESP_NACK |
>  	       SVC_I3C_MCTRL_DIR(rnw) |
>  	       SVC_I3C_MCTRL_ADDR(addr) |
> -	       SVC_I3C_MCTRL_RDTERM(*actual_len),
> +	       SVC_I3C_MCTRL_RDTERM(rdterm),
>  	       master->regs + SVC_I3C_MCTRL);
>  
>  	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> @@ -1086,7 +1138,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  	}
>  
>  	if (rnw)
> -		ret = svc_i3c_master_read(master, in, xfer_len);
> +		ret = svc_i3c_master_read(master, in, xfer_len, !!rdterm);
>  	else
>  		ret = svc_i3c_master_write(master, out, xfer_len);
>  	if (ret < 0)
> -- 
> 2.34.1
> 

