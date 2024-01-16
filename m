Return-Path: <linux-kernel+bounces-27025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA482E951
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273F41C22CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4DDDB9;
	Tue, 16 Jan 2024 05:59:17 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF310A1B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp77t1705384656ta8ojspq
X-QQ-Originating-IP: dCfPoz+NSqimA65RWWV4q1DctiRVVZ4q8U95yyblAnM=
Received: from john-PC ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Jan 2024 13:57:34 +0800 (CST)
X-QQ-SSF: 01400000000000E0L000000A0000000
X-QQ-FEAT: 3M0okmaRx3j7W7m5C8pOaDhyRfianz0cNV0VP0mJMrrKw+sqV3/rsqT7w4As7
	h+Tp8uFtrWUAqMxvo4Xq8EEmoVF1f+3tcaX76nKeCdQ4sLMJcg+mVMrxJilbvuHjYNB/F1A
	hjKZETWxFYJRs7CAMsiCk5onDsuds9R4wWzg8TvI6AS2TPAkWnf5/FbYA3mOthGEjjy25lF
	e+sZTCnhEjg3O9fAnmU0pUFE0QPnDz1vlSjb7Z3jMsdXNkE6IBPbDnnS9NFnP0szVzjBgT5
	akL2zci4TIzTGzoOisJ5uMDKAIsvFXAExSy8ZE5i+qoipLQAAhOUr5D6OhbHulIyqk0WsTG
	1/5WkhZk0COL0t8iBencxZYplQ6zhPvpXUZ/83G9fTDQ+Y5tKSqvA9HQmIW7Qc0LV+S0MKB
	6zkf27FiAt8=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6997579152918324563
Date: Tue, 16 Jan 2024 13:57:34 +0800
From: Qiang Ma <maqianga@uniontech.com>
To: Simon Horman <horms@kernel.org>, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, Florian
 Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: ethtool: Fixed calltrace caused by
 unbalanced disable_irq_wake calls
Message-ID: <8553142D466DD03F+20240116135734.53fb4c6e@john-PC>
In-Reply-To: <20240115134238.GA430968@kernel.org>
References: <20240112021249.24598-1-maqianga@uniontech.com>
	<20240115134238.GA430968@kernel.org>
Organization: UOS
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

On Mon, 15 Jan 2024 13:42:38 +0000
Simon Horman <horms@kernel.org> wrote:

> + Florian Fainelli <f.fainelli@gmail.com>
> 
> On Fri, Jan 12, 2024 at 10:12:49AM +0800, Qiang Ma wrote:
> > We found the following dmesg calltrace when testing the GMAC NIC
> > notebook:
> > 
> > [9.448656] ------------[ cut here ]------------
> > [9.448658] Unbalanced IRQ 43 wake disable
> > [9.448673] WARNING: CPU: 3 PID: 1083 at kernel/irq/manage.c:688
> > irq_set_irq_wake+0xe0/0x128 [9.448717] CPU: 3 PID: 1083 Comm:
> > ethtool Tainted: G           O      4.19 #1 [9.448773]         ...
> > [9.448774] Call Trace:
> > [9.448781] [<9000000000209b5c>] show_stack+0x34/0x140
> > [9.448788] [<9000000000d52700>] dump_stack+0x98/0xd0
> > [9.448794] [<9000000000228610>] __warn+0xa8/0x120
> > [9.448797] [<9000000000d2fb60>] report_bug+0x98/0x130
> > [9.448800] [<900000000020a418>] do_bp+0x248/0x2f0
> > [9.448805] [<90000000002035f4>] handle_bp_int+0x4c/0x78
> > [9.448808] [<900000000029ea40>] irq_set_irq_wake+0xe0/0x128
> > [9.448813] [<9000000000a96a7c>] stmmac_set_wol+0x134/0x150
> > [9.448819] [<9000000000be6ed0>] dev_ethtool+0x1368/0x2440
> > [9.448824] [<9000000000c08350>] dev_ioctl+0x1f8/0x3e0
> > [9.448827] [<9000000000bb2a34>] sock_ioctl+0x2a4/0x450
> > [9.448832] [<900000000046f044>] do_vfs_ioctl+0xa4/0x738
> > [9.448834] [<900000000046f778>] ksys_ioctl+0xa0/0xe8
> > [9.448837] [<900000000046f7d8>] sys_ioctl+0x18/0x28
> > [9.448840] [<9000000000211ab4>] syscall_common+0x20/0x34
> > [9.448842] ---[ end trace 40c18d9aec863c3e ]---
> > 
> > Multiple disable_irq_wake() calls will keep decreasing the IRQ
> > wake_depth, When wake_depth is 0, calling disable_irq_wake() again,
> > will report the above calltrace.
> > 
> > Due to the need to appear in pairs, we cannot call
> > disable_irq_wake() without calling enable_irq_wake(). Fix this by
> > making sure there are no unbalanced disable_irq_wake() calls.  
> 
> 
> Hi Qiang Ma,
> 
> This seems to be a fix, so I think it should be targeted at net:
> 
> 	Subject: [PATCH net] ...
> 
> And have a fixes tag, perhaps:
> 
> 	Fixes: 3172d3afa998 ("stmmac: support wake up irq from
> external sources (v3)")
> 
> I don't think there is a need to repost this patch because of the
> above, but please keep it in mind for next time.
> 
> > Signed-off-by: Qiang Ma <maqianga@uniontech.com>  
> 
> I see that the approach taken here is the same as that taken
> by bcm_sysport_set_wol() to what seems to be a similar problem [1].
> So the code change itself looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [1] 61b423a8a0bd ("net: systemport: avoid unbalanced enable_irq_wake
> calls") https://git.kernel.org/torvalds/c/61b423a8a0bd
> 
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac.h         |  1 +
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 10
> > ++++++++-- drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |
> > 1 + 3 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac.h index
> > cd7a9768de5f..b8c93b881a65 100644 ---
> > a/drivers/net/ethernet/stmicro/stmmac/stmmac.h +++
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac.h @@ -255,6 +255,7 @@
> > struct stmmac_priv { u32 msg_enable;
> >  	int wolopts;
> >  	int wol_irq;
> > +	bool wol_irq_disabled;
> >  	int clk_csr;
> >  	struct timer_list eee_ctrl_timer;
> >  	int lpi_irq;
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c index
> > f628411ae4ae..9a4d9492a781 100644 ---
> > a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c +++
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c @@ -825,10
> > +825,16 @@ static int stmmac_set_wol(struct net_device *dev, struct
> > ethtool_wolinfo *wol) if (wol->wolopts) { pr_info("stmmac: wakeup
> > enable\n"); device_set_wakeup_enable(priv->device, 1);
> > -		enable_irq_wake(priv->wol_irq);
> > +		/* Avoid unbalanced enable_irq_wake calls */
> > +		if (priv->wol_irq_disabled)
> > +			enable_irq_wake(priv->wol_irq);
> > +		priv->wol_irq_disabled = false;
> >  	} else {
> >  		device_set_wakeup_enable(priv->device, 0);
> > -		disable_irq_wake(priv->wol_irq);
> > +		/* Avoid unbalanced disable_irq_wake calls */
> > +		if (!priv->wol_irq_disabled)
> > +			disable_irq_wake(priv->wol_irq);
> > +		priv->wol_irq_disabled = true;
> >  	}
> >  
> >  	mutex_lock(&priv->lock);
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c index
> > 37e64283f910..baa396621ed8 100644 ---
> > a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c +++
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c @@ -3565,6
> > +3565,7 @@ static int stmmac_request_irq_multi_msi(struct
> > net_device *dev) /* Request the Wake IRQ in case of another line
> >  	 * is used for WoL
> >  	 */
> > +	priv->wol_irq_disabled = true;
> >  	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
> >  		int_name = priv->int_name_wol;
> >  		sprintf(int_name, "%s:%s", dev->name, "wol");
> > -- 
> > 2.20.1
> >   
> 

Hi Simon Horman,

The latest code does not seem to see the stmmac driver to avoid
irq_wake call related fix committed, this fix is mainly for stmmac,
refer to the commit:

commit 61b423a8a0bd9aeaa046f9a24bed42e3a953a936 Author:
Florian Fainelli <f.fainelli@gmail.com> Date:   Fri Oct 10 10:51:54
2014 -0700

    net: systemport: avoid unbalanced enable_irq_wake calls

commit 083731a8fbe71d83fc908adf137dc98ee352f280
Author: Florian Fainelli <f.fainelli@gmail.com>
Date:   Fri Oct 10 10:51:53 2014 -0700

    net: bcmgenet: avoid unbalanced enable_irq_wake calls

Therefore, I think this submission is necessary at this time.


