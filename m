Return-Path: <linux-kernel+bounces-159162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473F8B2A18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782E21C221FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D485153814;
	Thu, 25 Apr 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eoYqLYQ1"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5B152E0F;
	Thu, 25 Apr 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078197; cv=fail; b=RyJi/yIyHMrg8sTmDfXZnR2Mfxq8nJSLy57NwV+DIQbo+01VDOIFSxa/Jf0EDKQdXsfMB3MgmaYogSIOWftEzk+/wxFJiBWjYtBgialw1n2WlSTafsOS4+8Z5D+HZjMCbC49tc2gxkpDYkgdEQcm1pb1r9oQRS9DO51LrsxIKP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078197; c=relaxed/simple;
	bh=IfHLvgo7W2oLFtAJ2awdlAMA2dPp2o4vzZWQhW9MP3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/scuhuvqT/IrxEOLrQb8BPhMKwTQoncibnz7jhyADrPyuH0fT+uFEYZoCdSnQrhx93y4uPL+3+FwqqrDyGN0wwyan5cFKs8kkDdD40NmaI2nIcfS+MET4pVxgDKotT05zv2JOMkUEabgayFpLVzyvrQGn+jx0oBYqLvFZgMEyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eoYqLYQ1; arc=fail smtp.client-ip=40.107.14.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwbI2oci21/BrB+3JLJbpMGeRavq676poGGgSOdYCE6SQrY73stAUucVq+zGQoJIG6jGCxymRm7o+CMMg0Qm8Y8Qc/VJvIR4wbDBTA3vpm2YmwMI7BW2aZFZGwVmfEyCkvwx9ws/SulM+NDgvQd6Uts+xHtSCz4XtGxmB7D+S4jeRezbp+9DGxlQH4IyGfXNnfAFuD3D5zqoQ60Az9NPcokjPJCXz3rc7OgwyqGLwagGVZ+QV07pjNqONjotrKgnZ5PDLraSaISW+gPGEHkuNKEnAlxgJUD/FBwRTxt8IGiPNKeTPip8d6/Dln10IjqtSdeR0iQIASmZWs9boGKtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPD76Jf3AOP8fBwbD30oBJP23cp8Q22qafm2eZgWNn8=;
 b=QqkIspELT8/rBzIT8BiyJlFaBMnGoQgpAQWqOmdCgmD1Lkuh+zPMXj4X1SJUGaPnXOoS7Ja8LxGfXEmeJQyhnEZ8AM0BZ5pMyEqZtN6gqChAysrQD+mRAHmPFlJeUGdlc47rrPaV3puKsMhOl4VNq/+M3hreRzPjGXPihwlBwpJBvZvvQwUSCN3ejibq1HdVZEL1NPfcz0702b9quCTzdzveCVNSRIp57tYTXmFbEy89CtOOFafoiCe3Th7pMJmN5BqnmsjTATR8QUmEBl1Q1RxXKl2u8orKXUUvuKPvYIBRT31X66HQn46cZbkmkdW8JseHR9rqSl0oaieMFDoBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPD76Jf3AOP8fBwbD30oBJP23cp8Q22qafm2eZgWNn8=;
 b=eoYqLYQ1o8ADPF7BA0uTOo/PrOHGzwxs2rKSiIqXeDUvjqa4vrEKFvvJWS7/yy+fLlA48ilPlgr6OSJjoqDZO5RRY7kyY095WIfGtdODlzdjQDzx3FLmJok+lKOD8wF8VXcJdjDcPGXT7GMBENLg0FeXK0xwgCPIRmx9RVgWabM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:49:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:49:51 +0000
Date: Thu, 25 Apr 2024 16:49:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	shengjiu.wang@gmail.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: imx8mp: Add delay after power up
Message-ID: <ZirB5sWBsOXucVsY@lizhi-Precision-Tower-5810>
References: <1714040364-17127-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714040364-17127-1-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d51271-f6d9-4650-f696-08dc65694098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tSEiG8E85uPgi6GZOpUyKMPcBVyobTrmul/GnWDPUGRa8HziYPtf/pmlYpOo?=
 =?us-ascii?Q?Zb/eGnRFeNHS6poz8MdgRiODsr8jZjvc+NF+yvts9lzuRmkepfOBuGtZaQQK?=
 =?us-ascii?Q?I06zi+HwmCVGjECojhqKoP1NGEBDU9KjxgnugNh7QcNeTqgKTqASdrcIZ5gF?=
 =?us-ascii?Q?iZgaDffMRPCclr4TIZp6XtbHPr72KGa7UHMPIl02laebG+TZqjQ9MO2jkxcs?=
 =?us-ascii?Q?TusrPpaYRb0OTBGPjHHqg5PkOvz5ZgjawN0hCGs1MGJN/IkDc6u822MRzkYY?=
 =?us-ascii?Q?t+WV+TAvUPCsXDRIIS+Osh9HX/76MHGyg2v7/sQCfP+15311ba1Ta6CvlP40?=
 =?us-ascii?Q?Z+tw5nV8BQGIWfDm11VSnnIbc2bMSqeJuBBGCp3zAs/OyednDxFPNKHu/UYe?=
 =?us-ascii?Q?m76ZEbWZx/1pI41l8g6NBQ6OvKJ8A5eeJ8fewhmhOKks2NlAjXofwQdmUjqy?=
 =?us-ascii?Q?OWvapWe8Re07PLQdQmeUu+uMSdFiq/mXtDylDMEQ9SpE0BbbSTybyGLWjn5C?=
 =?us-ascii?Q?jSkEMJCcgVf4i2HXpcZGpN7h4AhRYqP+FyAjP6GNS9SA/8c5eDMkoP9mEDbG?=
 =?us-ascii?Q?EvracvDZAKOyp0TLYlGaPrpjSHSl5jrGWWO3gTfvjvK75burcFj3TZx+BsF4?=
 =?us-ascii?Q?F+FgxupWQEFD0F9Kz07574iJ+k+mHSZTnC98Yx0KGkbuyT9IzsO7K2aYo3JR?=
 =?us-ascii?Q?LgnPwVxWeja9xTRAfjkvGeV3f5SKK8GdKoOARCuvlixN4t+wer4YSTBL1ZpX?=
 =?us-ascii?Q?WB2uLEEpK8NItov+GOAylSI7Ji48yND65GdFnlWEoX/jIfCNTJwqenvIFlT5?=
 =?us-ascii?Q?tpY0SI1JPSCltczfcu3GjThtX1ONktZmQrukitZRLIub+nieLvi9+JPW74Xl?=
 =?us-ascii?Q?r9VM/JFOU7NMRwsMbEPaMP6BEAfjQFK1F/ZdVGbQk5t7D3HBqwrKzgmkNATs?=
 =?us-ascii?Q?uxBbL8L0I6kptZxAB+PO82dAaWG4uWA3k+qmTNxjxY89UUPBWNb3f6JL4Jqw?=
 =?us-ascii?Q?TRdVoXgvdfQlMg7uvlaTSIH9H8DpO1OrbeERYjxnUhMPSNLM9iBKOhY0sMas?=
 =?us-ascii?Q?5iYEDjmMK/a5e4mN0qQGVnM+HXuyUd425xeUU6/WgD9l6C1Gv2TsTAVHCJMl?=
 =?us-ascii?Q?ov51zhlDZDwIJwZEtW/ngRow8nNNzsbJvhvz5d1IgneKGiGyBfrEPTaQTkKY?=
 =?us-ascii?Q?PT3eLCL4x/uZZNpvqK1jWUFohxfvtlUUgXBftN7Ti7x6RK1ONrs+Q9jxXIjq?=
 =?us-ascii?Q?n4L+jDh2VRsBazed1gsbVhWloaAITfoYFQGCuyPDQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8eMCIDyQi2sJ5Bqw+HMZF6MYiSzImg9hdPdlFNCCHWoJt9K0szTRomOekuP?=
 =?us-ascii?Q?4wWlb5k3kwxc7DOr61X5ryfR+0641AQrPgk251l9ykWgH51vB3G2wBI0XThK?=
 =?us-ascii?Q?ZgR3cuz9g+nexkbL1ZP/3EdoxRHgPpCWykPAQzKL7d9Sh+A9YE1VD9DwMnDL?=
 =?us-ascii?Q?Mm68cOTpKof7W1EBff5FwD2q+LHPNzz0JvSVBZQKcn6JkVYOVNRwuq4QBCjG?=
 =?us-ascii?Q?MPQ68nmnfAir18LfYDjtZ8BhH1hdTD40CxaFHT7cEjlfkLqzM+BG6/2D1n8U?=
 =?us-ascii?Q?Ch//jeJP4xJjeBWQusXcVFz5tniA1twm7DuarxNj0iECpEQDrCSAak4KQRnJ?=
 =?us-ascii?Q?IYDOFBlsomRzwQ7I3kVH6aTc7N3b2r1SE3a+roir2GqCQgluDeHxypeygiWV?=
 =?us-ascii?Q?ZcuJCOg2M+W8CQipwJPRICO96Hs2LrGcS4irfp8HT6a8YdGDzeuKN+kYpNf2?=
 =?us-ascii?Q?FzqmNuZn6FX95Dcd/m2NNHKPk8uKGlIpIgqNlzJOqdGxcsFRLyYBgx9SBlzb?=
 =?us-ascii?Q?yM4aDREcW0+NzdOZyzuitSOQSBkKsoQnjtb+0q0rh+VwyGrM1zYM8GtU6URb?=
 =?us-ascii?Q?ccJ4kKUMX25XBSwQtSoNa/5jxjeOJowIvGvPu9L0IqFzu0U3zc75vWjZBJ5x?=
 =?us-ascii?Q?itX1oD9RrMU0q/GvTrkZ3V4FolNBHSfh07aR/rh+wAadSxbgNpLjsrl64hee?=
 =?us-ascii?Q?gqLwuGKQGi6dY223gsWQhBCdGf6JUvRo51OmUCICrRXJEDHKPvEyvwGag+A1?=
 =?us-ascii?Q?UCrCIHsLMnLSo/MEhMvZaNlJjGSHB4dDN2r3V+ZIxmxq1yBZdoBn7UrqPhKa?=
 =?us-ascii?Q?IwwviAPHzalnpPS0AEc8C+xFE6LTtA49oNerL7BZlZFE5F2o6hHUknfxa0xZ?=
 =?us-ascii?Q?zdannEDr68GHatGyoXb7VVOOTc6N8Z4XZvBxkGPHy8qPysHYr3vDKKyhgSi7?=
 =?us-ascii?Q?DMw6HalzTVze9XrHy2JMa2pY/r2q1pfG5eX2+B33i7Y6fv2rAolhzD4ShY3a?=
 =?us-ascii?Q?osRy1rAZuZsgAklyBlkDx+J71fK8QDclis8VJYtZUz9kTQ5zP+CDMsLs+khQ?=
 =?us-ascii?Q?x/8LSTVUjQ9lDdduMWs3O/wLwTvMhaZ6eTl+kYIV2AIseYnPJmHkKl6dZhqu?=
 =?us-ascii?Q?Ny4feStS4DxXVexgSPcxhLuF2R3ZczcqKlFLMog0W7jt8HIih0/Ocu2fQTS2?=
 =?us-ascii?Q?uyCGc+5iPH2JHUlfIp+8srEN/OvRJXp48iYMf9X4Vp6kK9aHAZiYVryqllUA?=
 =?us-ascii?Q?liZCrNvcQERIFwlMzELMmJbbqeKBf13rO2uMc2KCQUoaf2bOTznPvjn4u5+i?=
 =?us-ascii?Q?Eazc0UrXdklCx+ZqgWyq+aHuQViP9eGuEn/BxJ4DuR9o9BIirL43JgC+J7nT?=
 =?us-ascii?Q?xoI2wxSHlcMaNmhEl1zjhpUe1i0V9+ypE5uVdgFPocYw0kgqIuYSJPKT+WBY?=
 =?us-ascii?Q?Om0KpaChWkCNfKd9cozdkpjfT8x3yTtWW8VxTG+VuYqxudnoyRn9dtNGUk4J?=
 =?us-ascii?Q?D1L5t4A4QdUSH54tCoP7oXuHbpCFf2E+yLAoR8YMS/MC0j4E76tWFnBW7nx+?=
 =?us-ascii?Q?IRlidDRXsHpxXO2PYlOxk6Wss89D/q115CNt191L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d51271-f6d9-4650-f696-08dc65694098
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:49:51.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTyzMcRZY1acBIhq9CW/RQlYGkiUHrzvDMJcvx5Nz18B2xJ473mQiYSQWzUl1BWb4eAl4LUvM/oQSS0/+jrcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

On Thu, Apr 25, 2024 at 06:19:24PM +0800, Shengjiu Wang wrote:
> According to comments in drivers/pmdomain/imx/gpcv2.c:
> 
> 	/* request the ADB400 to power up */
> 	if (domain->bits.hskreq) {
> 		regmap_update_bits(domain->regmap, domain->regs->hsk,
> 				   domain->bits.hskreq, domain->bits.hskreq);
> 
> 		/*
> 		 * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
> 		 *				  (reg_val & domain->bits.hskack), 0,
> 		 *				  USEC_PER_MSEC);
> 		 * Technically we need the commented code to wait handshake. But that needs
> 		 * the BLK-CTL module BUS clk-en bit being set.
> 		 *
> 		 * There is a separate BLK-CTL module and we will have such a driver for it,
> 		 * that driver will set the BUS clk-en bit and handshake will be triggered
> 		 * automatically there. Just add a delay and suppose the handshake finish
> 		 * after that.
> 		 */
> 	}
> 
> The BLK-CTL module needs to add delay to wait for a handshake request finished
> before accessing registers, which is just after the enabling of power domain.
> 
> Otherwise there is error:
> 
> [    2.180834] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
> [    2.180849] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> [    2.180856] Hardware name: NXP i.MX8MPlus EVK board (DT)
> [    2.180861] Workqueue: events_unbound deferred_probe_work_func
> [    2.180878] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.180885] pc : clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> [    2.180900] lr : pm_generic_runtime_resume+0x2c/0x44
> [    2.180910] sp : ffff800083423a20
> [    2.180913] x29: ffff800083423a20 x28: 0000000000000000 x27: 0000000000000000
> [    2.180922] x26: ffff0000c0e4e410 x25: 0000000000000000 x24: 0000000000000000
> [    2.180935] x23: 0000000000000000 x22: ffff0000c02afd20 x21: 0000000000000000
> [    2.180945] x20: ffff0000c162a000 x19: ffff0000c0e52810 x18: ffffffffffffffff
> [    2.180959] x17: 0000000000000000 x16: 0000000000000100 x15: ffff8000834239f0
> [    2.180970] x14: ffff0000c03d0a1c x13: ffff0000c0a03440 x12: 00000000000003c7
> [    2.180982] x11: 0000000000000000 x10: ffff8000825010ba x9 : 0000000000000008
> [    2.180993] x8 : 0000000000000008 x7 : 0000000000000000 x6 : 0000000000000000
> [    2.181005] x5 : ffff8000838b0000 x4 : ffff0000c0e66088 x3 : ffff8000813852c0
> [    2.181018] x2 : 0000000000000000 x1 : 0000000000000004 x0 : ffff8000838b0300
> [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> [    2.181064] Call trace:
> [    2.181066]  dump_backtrace+0x90/0xe8
> [    2.181080]  show_stack+0x18/0x24
> [    2.181091]  dump_stack_lvl+0x34/0x8c
> [    2.181104]  dump_stack+0x18/0x24
> [    2.181117]  panic+0x39c/0x3d0
> [    2.181129]  nmi_panic+0x48/0x94
> [    2.181142]  arm64_serror_panic+0x6c/0x78
> [    2.181149]  do_serror+0x3c/0x70
> [    2.181157]  el1h_64_error_handler+0x30/0x48
> [    2.181164]  el1h_64_error+0x64/0x68
> [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> [    2.181183]  __genpd_runtime_resume+0x30/0x80
> [    2.181195]  genpd_runtime_resume+0x110/0x244
> [    2.181205]  __rpm_callback+0x48/0x1d8
> [    2.181213]  rpm_callback+0x68/0x74
> [    2.181224]  rpm_resume+0x468/0x6c0
> [    2.181234]  __pm_runtime_resume+0x50/0x94
> [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> [    2.181258]  __driver_probe_device+0x48/0x12c
> [    2.181268]  driver_probe_device+0xd8/0x15c
> [    2.181278]  __device_attach_driver+0xb8/0x134
> [    2.181290]  bus_for_each_drv+0x84/0xe0
> [    2.181302]  __device_attach+0x9c/0x188
> [    2.181312]  device_initial_probe+0x14/0x20
> [    2.181323]  bus_probe_device+0xac/0xb0
> [    2.181334]  deferred_probe_work_func+0x88/0xc0
> [    2.181344]  process_one_work+0x150/0x290
> [    2.181357]  worker_thread+0x2f8/0x408
> [    2.181370]  kthread+0x110/0x114
> [    2.181381]  ret_from_fork+0x10/0x20
> [    2.181391] SMP: stopping secondary CPUs
> [    2.181400] Kernel Offset: disabled
> [    2.181403] CPU features: 0x0,00000040,00100000,4200421b
> [    2.181407] Memory Limit: none
> [    2.463040] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> 
> Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> index e4231e9c8f05..cb44c460548e 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
> @@ -362,6 +363,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
>  
>  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
>  {
> +	/*
> +	 * According to the drivers/pmdomain/imx/gpcv2.c
> +	 * need to wait for handshake request to propagate
> +	 */
> +	udelay(5);
> +

https://lore.kernel.org/imx/20230727152503.2199550-1-shenwei.wang@nxp.com/T/#m2dc5111e9628235f031c0bad2a137222b0205a61

supposed clk_imx8mp_audiomix_save_restore() is that write save data into
some registers.

See above link for detail, it may not delay 5us before write to register. 
You need 
	readl();
	udelay(5);
	writel();

>  	clk_imx8mp_audiomix_save_restore(dev, false);
>  
>  	return 0;
> -- 
> 2.34.1
> 

