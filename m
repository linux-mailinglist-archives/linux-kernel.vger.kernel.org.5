Return-Path: <linux-kernel+bounces-108003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984EC8804B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9341C226BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629822DF9F;
	Tue, 19 Mar 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J3Z+THYP"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E15A0E5;
	Tue, 19 Mar 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872556; cv=fail; b=KjwR13Ph3GP0Soomyl6aRs2MN7t7fAcT11iJfuND8bwzR3GTgheITWTHiUE+ORWDwfX5MqYtvPu1j2FL4/tCfU2cw5DIWbuqqmZ9Q5cNFTO4WEmn1huv0n6EKeyxVKswjElUZ/+zpsvvnU+LuQQh+c1CnniQoKETWxlhjQTH4TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872556; c=relaxed/simple;
	bh=9SgVWfl+wFrLqMCsqx8EG0ARYDyFkNeIINdY6SJDmcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JrVD9SG/igu+zvmyW+fWGiQBhtSaNr0V5xxDhpLG4+yh2AT16xzUSIcX8UZzvHbemqRdrNeC8gv71xzkW7wPmd2dBg3cg1H5PnuzC0XUViXznrEfKhEQq3XSdY9UlFAB1Dr9+Q/pmGpBw3YgGvw8X0hqouHoFuA9loVyv/Uj3zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J3Z+THYP; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+ktIztpPSlkONpWLgLrRnVolaiy5vK5mRKmR6o709cJxWGk1eRzXZib3jzfaqf3O7cqpQIunWHO67ruRe+oyP8LVpv5chLeHfG/FFCLqL46EzacU564AHoV8Gq+KtAQzoIk/HMUc6/Veazr/XzX2QWUFOX8I0gXiDBxYCTQS28s7RLwZqAwfMVAUqu33+A00Rn/ogEIbffSAAJV3+ap5duBfYhoPshOdMB/XC6132ggM/odpF+PF47j/k7sFnx4/SkWwxwUEPE+trj9WzmsAQrEBX9zPBQtc6AbC99II75nsMoGW1YFSQjlytq3WRbugKPeAlmgM7pG3KJ2M5YD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1km9rIZtRyASOeH8ftipyFLEchTdPw8wbWnfZtMuccQ=;
 b=FpLGnubxRbptZ7kOPGbe0BtIVsB4l1QB5kmykDHeQUXkKJyifBf1aTYp04cvYiew+FHigSKDtAaAHE/Cyv331H/+d2A/8WN9w0+buTpcyV9lT8swAWzOMfdS5LjYvjheA5a4Ru0SaIITbtjuAUNJEHGb5t9VUYSfqIPkNZQHKd2UUvs2ZwWV1vl3XWnoWJwqlP4qxDCBUJJR+Fjziw14FmuCJkMA8D/IklllnQTE6Q5ErQ7mk9BVfgmQY8z/sc2n+1GFfe0DoyYNYiVyBJdIT2Bsfvo4PhrSsoPl9+yolFAbluqhZg261Zoxp3OVY63azT+ioLp9V35sWpGfgLtZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1km9rIZtRyASOeH8ftipyFLEchTdPw8wbWnfZtMuccQ=;
 b=J3Z+THYPoz/VLEMyXoQVIdTgxvIw+bhtzK3ZqZiKgRfTsM6KB0TNpbAerLz/v70kv/XSArtwGGU3eP+Bnge1fj7Om0BHnaU/CdQfVXDyoCmpYQO+sIp0V+2b3834CLxgMyH4dwYBQHcnlBK41fmJBn1RY1Wh0alejqU4sJS447o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7445.eurprd04.prod.outlook.com (2603:10a6:10:1a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Tue, 19 Mar
 2024 18:22:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:22:31 +0000
Date: Tue, 19 Mar 2024 14:22:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: mxs-auart: add spinlock around changing cts
 state
Message-ID: <ZfnX4IuKBRTuXV/j@lizhi-Precision-Tower-5810>
References: <20240319180239.69765-1-emil.kronborg@protonmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319180239.69765-1-emil.kronborg@protonmail.com>
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: d848d424-242c-4156-df67-08dc48418ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mJFBKOEcnn260vx+LSpbpfBqxzavNuCh0SLvbIggL7w4Z40Cp4yXyPHBhupNfecD3VU+7B/ygITn9Zs+xRilCoadduXI5sgi3gSY70gsMTmMf87qvu07MEZ5c9DTtDdZWBMXoNCHm/oQVk3sISPn6M6Yk0JPNZ760d4j7VzYV0Y4HZhD1vym6W5ZGjeJ/BDKcv6IOuk7EblrYiVFy0hyEm+7eGCk2mkHCLEEFxO9M45HarL1JfKFXj+O30m/ik4ze5j+GLsyI6xzNytvW4H//IoHnnfBL/etG9DkJ40BGI6nuh89W++wMETcaPZvGpp38HX2PPgz+K5X8VSNP2dOips0mn6JjCo1aKe8pIK0Y0aj31zanDuthEWxQ3Ynkz9oiMNLdGezf24oho4XnQtr7azeaPGF/9MipaCIUp30r8/Cq8zE7asM9yt0JOepgneaalZEalDJCyBuOuzSGoSjU3DgPYzxnY31o+uCwCiGeMWl/biCjiSb3Aw/nbmdzHFnWPmjZjFhmmK+r4Dex5Q9wMcwW7bw5qbLDWWf1LHM7+xxfMYYVKaSGInXvwSIwKPEJxD9/tSm7gQi0Q5SVhYA2ujmhuT4OPOHxcph9ujJltSVgrXPkeXrkH2iCV8atnVS7vVitZJYKPNPm9AFG2dO4J5NdCsTinanENHCP+lKxrB9S+IcDbHHIbXu4KmzAr3Bm0GxKRn5zwo0GVteg2/3gh3UYuquaO4CrbXftxMd44M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kw/WvFp60sEooQiANR8S+0tJ6zpTY/6YTxeBwjJmGzWUOqt9djxQHaCbsQ5Q?=
 =?us-ascii?Q?TFv6JHJkvTVjzXseV+UFS0AZ+yynwD8rtCRNIQc/fRBoRh/fcldxzENW0wRY?=
 =?us-ascii?Q?NQTUAe+8GkDYTEpmO4C/TJnb5mGOViSEUz+ZESuawFZGEi487l6CrI26wf0Z?=
 =?us-ascii?Q?r4BMwWu/4IUPi/3oEr9hK3BLIWx3rRZzMd4iuvEwBZv0etFBFUcpweWeLff/?=
 =?us-ascii?Q?vmM0A05cs34TRWtcRlaLZl2n3o2V5MvuWtOZ1NWQc3T59CoXnqtvW7sI85m2?=
 =?us-ascii?Q?VkB3lxzIMC6GfeuaxrCzQChM+cZJVXtZZ/a/YxNa2TufYX5ToGshHK+dHSnK?=
 =?us-ascii?Q?QhYAUSdy5LRrZxJP5LRzeSmTsD7Qc5ZzOwDQN1xY4ACV79w7/MCyqxnDe0wG?=
 =?us-ascii?Q?Jgi2EexphtzzIO3jIvc54R3U06NnABxK/cDtkEu9InaW0qT7/TIZVfDlOFep?=
 =?us-ascii?Q?hJm4pyMHpWcpONM6NOE4RHMGZTG2nTdVVIG4qsbKLxFz+9bfK7kFibx4URpP?=
 =?us-ascii?Q?2kgezn3n5KoCwaF3dCAMarMJivi9VHGGQT3AruWVAPco/h2Sg2tubw9GRqd3?=
 =?us-ascii?Q?Kr/OoerPH5ymffnl/Vn8exsCF6gmj9yDydu5svR4A3uL6RgFCwEpL2SRQJI+?=
 =?us-ascii?Q?lZqyC6nLiaj79Gll+1EdDVBKiNCI/8mio2VmRFZEhW6rX+CC0hE7IV2VP98q?=
 =?us-ascii?Q?7akaxWTwXfGddWqWOHMukVIOo41gVfMN67x5HAPzwWQI1136rJxrnx5hkh6z?=
 =?us-ascii?Q?zzTgf1DQol7gmHeK4wkkc1W8pp+ERRpRpzWCsclFvxqAyJ6V8pssSmPj1Vsy?=
 =?us-ascii?Q?BEFJUtb7pgLwfDrB7Aee41FcshxJvKcD4jT72+0mvHcnX38IMeH+Ba91gcvw?=
 =?us-ascii?Q?/CmJWD1TGxTL5KZN1Nf0b1gq2lot4DbXS2+YjOMe/T/aK1I61hEFJ4qPp3YL?=
 =?us-ascii?Q?LuGupuxJ3Grd/3B7TdpRelax6pevRt93Hfu5FqeF4j+21by0LU2100Re2bPi?=
 =?us-ascii?Q?1mRbLD2oEDp11ZbcyyAqmpq41sp8MC30jjKbwAdVvO6NdcYmS7dmQpivcWLp?=
 =?us-ascii?Q?rdEgVq0hHog+/X3jZJRkSSIvUq5RhmsggTn50QSkU2KIR2Pggih/KPVIz2Z2?=
 =?us-ascii?Q?RN9TCHJVw8K2EHSUWYglgxiJ2Fl1MIQFtx/QKFrLLGi/Qj74xz1VOrsbfDY9?=
 =?us-ascii?Q?NLGxMk2nyUvVu2AGLTKnPRiHCsNPKKr25fxHhP6ol3jZ88OR1yDzzgDdxe/K?=
 =?us-ascii?Q?C/OiySdXyqxeH9u3pH1gNWKsnoP92zXO5JkHIhmFvP49U6Ad62Y/K6uUDwum?=
 =?us-ascii?Q?2GTvnf/Fh6VdQ0pcb8crn8EpgomhjZn48V/fmXtoDwigY9AMsuxG04ylmph7?=
 =?us-ascii?Q?PCX7tyb4jo1Zr1lv5tYSf518OgPOQVBt0QAKp9F3f4Vr1oGdkzg1dM9d6Ni4?=
 =?us-ascii?Q?VMtW7NegE7z26XwazyL7x3qkecgo2UaTFgPF7gRTFKIduH5Ye+nTA7/WlqfH?=
 =?us-ascii?Q?74BORd98Ul1l+WC6EFjCRWsy2MrPloxMnjC5WTaBVUropPzk7mIYg83mrKxK?=
 =?us-ascii?Q?/i/Kf3HZ8zdr+haA3+P/DEFlNCl2zTtjOANLbqVn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d848d424-242c-4156-df67-08dc48418ab1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:22:31.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbC2sIsawjqlPL/EeRzouDl+9Enlyf70dnmiw5cR6cGAWmb6XGI/faXnb+30jPrMhQndlIvkt5ZW/qRkA10d4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7445

On Tue, Mar 19, 2024 at 06:02:47PM +0000, Emil Kronborg wrote:
> The uart_handle_cts_change() function in serial_core expects the caller
> to hold uport->lock. For example, I have seen the below kernel splat,
> when the Bluetooth driver is loaded on an i.MX28 board.
> 
>     [   85.119255] ------------[ cut here ]------------
>     [   85.124413] WARNING: CPU: 0 PID: 27 at /drivers/tty/serial/serial_core.c:3453 uart_handle_cts_change+0xb4/0xec
>     [   85.134694] Modules linked in: hci_uart bluetooth ecdh_generic ecc wlcore_sdio configfs
>     [   85.143314] CPU: 0 PID: 27 Comm: kworker/u3:0 Not tainted 6.6.3-00021-gd62a2f068f92 #1
>     [   85.151396] Hardware name: Freescale MXS (Device Tree)
>     [   85.156679] Workqueue: hci0 hci_power_on [bluetooth]
>     (...)
>     [   85.191765]  uart_handle_cts_change from mxs_auart_irq_handle+0x380/0x3f4
>     [   85.198787]  mxs_auart_irq_handle from __handle_irq_event_percpu+0x88/0x210
>     (...)
> 
> Cc: stable@vger.kernel.org # v6.1+
> Fixes: 4d90bb147ef6 ("serial: core: Document and assert lock requirements for irq helpers")
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes in v2:
> - Add more of the stack trace to show why the lock is necessary. Note
>   that i removed some unrelated noise for unwinding, showing and dumping
>   the stack trace.
> - Add Fixes tag. Note that this commit do not fix 4d90bb147ef6 ("serial:
>   core: Document and assert lock requirements for irq helpers") as such,
>   but it was the closest commit I could find that makes sense.
> - Cc stable. Commit b0af4bcb4946 ("serial: core: Provide port lock
>   wrappers") is a prerequisite. Therefore, v6.1+.
> 
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

