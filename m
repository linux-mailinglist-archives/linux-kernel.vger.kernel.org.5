Return-Path: <linux-kernel+bounces-106620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D472087F10F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015BC1C21476
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33557874;
	Mon, 18 Mar 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ibmcmI6O"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2125.outbound.protection.outlook.com [40.107.104.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189F4AEF5;
	Mon, 18 Mar 2024 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793118; cv=fail; b=GE6XoupdIvXU8ua/z89/WFzUAPlS6EO0RgjXXIt/8HH8rufQYFzpUO0qOPHnKE1MeoxQ0FV0aSeNHS89XEIgoF/FFKwSJZpUyxCYGBEnC8AL6/AbwGjpMSoEMe1fb0nNkyVAQrkg+4rvbikVPdktcn9gveUBuRJIlRIqDKwFClk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793118; c=relaxed/simple;
	bh=PDhxN0+8D7Hn5hzd8/k6AxuS7oil9i6KAnuwRQn2tRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gThCU88VooZLvja70gRnUvxzF21h/S17SwpgKb5/9MESGGlB+jpVvfbAevUn1VJdRD/nyT/7SnpuAth0tIPB1kstvL2UhZhjKIfWyGPQGer7sGcv9hDWBJg5LJz9mXpPp9c5wT1ykuIXshFuNoI8lfib+29eVezqyIK3JZZxelw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ibmcmI6O; arc=fail smtp.client-ip=40.107.104.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcH9RozfjBdyN7LOzzreewR/R59TMl7eCFqKdKyrsaGRgh+4NrKbCfdkCEh47sRYubF4iSz8BKP1Ubd9zYXy2qlBdyT5IbymAAU33lGC6SN03WcQxejZMi7CgdM+kk6FiiIoVXQJ1I/rDj9UxQOD4zXntbDqOCN2X6ajdB45NqmPZ8FBF6UoVI3ZvURSYH2EqCRZ+f7jfvlYRIv646GGH55Jrtc5OufJ3ih+hIUtRp+5m6/f6EQLZ/byBOcR9I+VipCny5b+7gjZ6kNIHltVk4dzeO2bzdm2FUiy4ONsdKmZnywaDWrWwuaysPGMr8pF3vWZ2iz6eDjBXvFJegIjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EKcPSAEr4V2B56eLdLK8dEVeSv1I/A8zNt5q7In9CI=;
 b=luGN99giCUcekw3OlA/OWlEVuQslbyps+MVn4rXNBRXsMPRSJI5QLGQrAkgxM66j6rNp+oMHqhVDPO8OO357LHFP96lZ2mxm5Ogr5P+cgctgsNumpAosi9FQWmzEEVKyFhl3wihJTTkj9Nu3dcjGs/V3FGTCx07qeSKLu0P29m3UNbhximfKfAkWsomgWo5eacOWg5jtHO0JCgzNpoJWvue3V+TcczTCinhFTMT0OC5+Uw1mTJAv+7ROauwJDm6kfnhbpZxJKFngYb/yABc0GHqsdne5txU+mxrzQ8dfjI6cjAgQg97oquGpNFFkTsN4qM9+Iiqyvw3HfxGVljFtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EKcPSAEr4V2B56eLdLK8dEVeSv1I/A8zNt5q7In9CI=;
 b=ibmcmI6OomRsZ+S1xxk4XaYPfe1D4ML556gd1qz47r/8YScrBz27+uba86FO3fh3v6g2enK4PCgep3pYH8w6tKHOYB8uQ002VmT7tEn5m2t4RJDC3flbVPCQth/qRsCksL/ALHBHTVmQ71YO0MvpJBMWC9n8TDl7+rm6T5/np+Y=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:18:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:18:34 +0000
Date: Mon, 18 Mar 2024 16:18:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH] serial: mxs-auart: add spinlock around changing cts state
Message-ID: <ZfihlNj1qMm1aJvI@lizhi-Precision-Tower-5810>
References: <20240315154150.28391-1-emil.kronborg@protonmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315154150.28391-1-emil.kronborg@protonmail.com>
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7031:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TzMDSM+8fxXx6dhOVCce2+rI6jGz/mf+SOcQoqo2s+OcBgvCD6xBpH81/kk4DzG/4fv/405FvWaptDfX/10Dlf+B4RKsv5nwaTmwZCIBFSs1CM9b4yhdd0kEEEGEcZvofoR9X62R/LRkaV+cq/sOnmzwUAP8Z9qsEW8FuwdLUHM0n9vKqPVw/Af+GS5W+0QGaO4rm6lBt0/7vAwUTUyH7hTeWkx8AACV6eAlp6PhhwdVZ6qvH1ykRy+AcYubehQ43g3hudeUDx2tx1o7YysCWiYv7ZiJQUpFr5UNf6HRsjIgStLfRg2DxwutY98bLKbKTIBUDj9bGeWL6D2drOrHR61xloV6t1Lorlr6mgtDiviDgFjJP55YVmrYA7xHlzgTLx9WS4Sz6WfYtK36cTrE9qkfM14TwwU55n01dpuNCtM/+cYTS+m52j/Xy1rA4jfc0tcFlER/D5+8D3QcpNhXzuHhroUmjDlFIhdxvZWUV2wQeJM7Csgz+0zdqD1K4KYLxaLmM+08LuJ3sPmAuVPkAEQ3325VE2Y4w4ZbJLXmY7in4wckR1/eC/Fc9E56PWzHiSfweeVv3DYCC5woGyqIgkSN/9z1OSBiqD6dXDgesjqCUyDuv6cT6vrpta6CDl2l/ExKloi/Lej1dWc7zFV5vrb6udEHt9FgvAAQ3fW9fc694Ce6znF0vOpgzRPvK249U7DGAgbt8UyLrcV9ZmtyzRRwk26QdM0PqVcOPCE3iNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0t+l++Vsl1u04/CXJuOo6STgbfgsc/lQ0m3IGXv/hTW1HzsuH9G0N9ln4RI1?=
 =?us-ascii?Q?pwKXLhxPIevhNaBy5VrjkTye1EYxeXyFQGMYtjtkNNBojGCa1zVFTt0VHL6Y?=
 =?us-ascii?Q?ytFRbbszo7Nz7mtext9/OGyFNLSKFGH1L/o5jAqGkNuVtQjhrO3aPwXlq8Gz?=
 =?us-ascii?Q?oBr5Q8MY5CYQVW9gR48AbQ9N/Timv9dGb17ckSB1HmxUe07YDLM4Mw3DWcH1?=
 =?us-ascii?Q?Q5qAjCxDasRjFZxnveJCzzWT2xdk8RUyecIkCXTd9NII3MjLAj7aGrUtAr9m?=
 =?us-ascii?Q?PJUF4IHROM0RHnpHrwO3AFygXQ0if+Zx6TMsD+shuhG/8ZfOWpefwfIIc84H?=
 =?us-ascii?Q?j5v4OuhwUg+2p5uxrm2WSfEmY8VM/U4j4Wj45ImVznY94GASDeWzpE3VcxD9?=
 =?us-ascii?Q?I3PiRwFFwKMtaZmDkFAXGxeYOJAInhUA0dwJ9kQ35eDr5y/cVRZF/1FIQcGf?=
 =?us-ascii?Q?4pP0PXIbrIqXe1bSbGvxnqDoOZAOeYWOCIh1iIO/XX2ngQJQu8pTa5P0e9T6?=
 =?us-ascii?Q?jkiycOF8FXuTnZfwk2Ff1LG2z7a39EIRkBqMmzyqXkjtRvef2FDpjp5rWRZB?=
 =?us-ascii?Q?tJEvBGI26OrmPt7PgNZCOpj2v/o0nP62idof1DJjxjdfWjGXW9o+f7eUgoU/?=
 =?us-ascii?Q?qdlrP2xFda+HxpgFtQ5EsPsW7DhQ4rBr0Aw+drykzOU1f90BCIHw6Uf51dUS?=
 =?us-ascii?Q?6r59WanK1ZJlblfbH4n8dBCSMrSkqXc2KqRMFULF1iM3QkACJwkSuFPMP2Vn?=
 =?us-ascii?Q?7gm8XrQf4nCp+OSsb5KUc+AlDgKcey/VP7p+LjdgUaC8sm7XeqFGsO8KJB2M?=
 =?us-ascii?Q?fi7nMYlh77DW97rdxoYtu9OYn/bNxEzo5KDX4t63w6Ps+rJQUBNIEBER9M9H?=
 =?us-ascii?Q?A3d0CzmDFl2O6nqx6IU4IiTnbnKtoykyg0DkhKPRYIZFhO5NDS2QA/oSeIhc?=
 =?us-ascii?Q?gLUBh+ZdS7RsN2nM1up/0V8HSgAER3oIz2DtPPKSUrgOxQAR9sFIaaunArY8?=
 =?us-ascii?Q?InHyq+SJFM16MN2GBOs+yJvJ9WP14zVPANHuV8AiZMk9p97+92cZXnQvStDl?=
 =?us-ascii?Q?NhAp6MuNsTrOSH6Zlh4nT6h5K7aUTTeAvYVP4EHwawhTkt+VvY1XC5SbnvLO?=
 =?us-ascii?Q?wN3zjYXhw0RSEIaQ7gg36Slypgvp86PZzHlg2T8iXknmDRRfciPPMDzgdI68?=
 =?us-ascii?Q?2sasB/mwOz2xJBoP534Xo2OdTWmSPER/bhpr4vsP4cDR55qkjRy+DtvOXfgu?=
 =?us-ascii?Q?pFGxnWukgU03IhRLERbKnPZnEiUpCq4PUQOxAWaIyTEjx4zVE7atVI+KvU/s?=
 =?us-ascii?Q?0bjLSmkjiV4j1Q3FppdmrV7onyqacwTLLimgLGJtet5Xz9oyp1eeWsO3/c4s?=
 =?us-ascii?Q?/vxE9umeT9/Z03gFSvXbdn+1+qDg3QykbTyBQ5w3EHX0K+E19I2venWBVPht?=
 =?us-ascii?Q?xfoQcHzNZapJ8jzhQ2ZG1O7qtavMfrVfjqtWAguwxmSmCzPs45fzogYvtPVJ?=
 =?us-ascii?Q?zg7YPCI5ytPeLu7YUu2K70pIWRJdIkeTyW0pmhpa2ER2fG3EM3zf8redPEiz?=
 =?us-ascii?Q?Pii0f6JnYviDPNsxb8uQxN/s7cLpLsynZHYadXZG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565eaac0-a4df-4aeb-189c-08dc47889615
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:18:33.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /T/D4wqt+3z/CZnI2Vz7wAkw7lOwl+NCAuE9sh081MXhU2b1XaULQ2HVy2e4/wOp4fYSIvYsQpvnTlIW+N1HIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031

On Fri, Mar 15, 2024 at 03:42:29PM +0000, Emil Kronborg wrote:
> The uart_handle_cts_change() function in serial_core expects the caller
> to hold uport->lock. For example, I have seen the below kernel splat,
> when the Bluetooth driver is loaded on an i.MX28 board.
> 
>     [   85.119255] ------------[ cut here ]------------
>     [   85.124413] WARNING: CPU: 0 PID: 27 at /drivers/tty/serial/serial_core.c:3453 uart_handle_cts_change+0xb4/0xec

Add:  mxs_auart_modem_status()
      mxs_auart_irq_handle()

May help understand why need add lock in mxs_auart_irq_handle().
          
>     [   85.134694] Modules linked in: hci_uart bluetooth ecdh_generic ecc wlcore_sdio configfs
>     [   85.143314] CPU: 0 PID: 27 Comm: kworker/u3:0 Not tainted 6.6.3-00021-gd62a2f068f92 #1
>     [   85.151396] Hardware name: Freescale MXS (Device Tree)
>     [   85.156679] Workqueue: hci0 hci_power_on [bluetooth]
>     [   85.164243]  unwind_backtrace from show_stack+0x10/0x14
>     (...)
> 
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>

Cc stable and add fix tag

Frank

> ---
>  drivers/tty/serial/mxs-auart.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 4749331fe618..1e8853eae504 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1086,11 +1086,13 @@ static void mxs_auart_set_ldisc(struct uart_port *port,
>  
>  static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
>  {
> -	u32 istat;
> +	u32 istat, stat;
>  	struct mxs_auart_port *s = context;
>  	u32 mctrl_temp = s->mctrl_prev;
> -	u32 stat = mxs_read(s, REG_STAT);
>  
> +	uart_port_lock(&s->port);
> +
> +	stat = mxs_read(s, REG_STAT);
>  	istat = mxs_read(s, REG_INTR);
>  
>  	/* ack irq */
> @@ -1126,6 +1128,8 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
>  		istat &= ~AUART_INTR_TXIS;
>  	}
>  
> +	uart_port_unlock(&s->port);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.44.0
> 
> 

