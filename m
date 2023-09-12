Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B167779C7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjILHJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjILHJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB013E7E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694502532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceEKPZHU8Cl0Spbw7Rp8+odJmQZXEW9dmEM5hqEQEuI=;
        b=fHVKiyzoCfGLi3DCNcRWug15Ie5GAN1Qwl+0pZvaz+OFWuq9+HXrg9Vs4+lbd4tgX+JfaT
        i6+TgaIww/4H7r+vBZ6RvLDrZgJepJtn+LuZELVfhEkHPAj/fDw818r5HbHD+a+DZ7xeeM
        tEoCpgkIV1bPKJNkDiT/j557UJ9idI4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214--SR6lrSnPPidpb-PooFe-A-1; Tue, 12 Sep 2023 03:08:51 -0400
X-MC-Unique: -SR6lrSnPPidpb-PooFe-A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9aa25791fc7so45385866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502530; x=1695107330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ceEKPZHU8Cl0Spbw7Rp8+odJmQZXEW9dmEM5hqEQEuI=;
        b=vVfydrumBVdCjH9Wzggn5tBEYkwIio61SrirXFpcY5T9BRsHEJp4QfkC9uIRXVt3tO
         Z00x6I8GbCj1I3Xun8jwMXyNl/vtwghFXscddTz9WUJ3zXhCOyaVK9G+2WNtM4v2CPyK
         0sd2cq382owLILMuxLDw3GIV9arolsf+mQBn40IUyJUhLHtNMFP0YkgMrakyi/nDxaRy
         Xdxdpxj+Hbjw09HMOYqVSM6AKxfvvTRSeNcSj8MN/WUn1LaF5ZWADeXyZtDwJtnX+K9s
         PzNN8Nm84RI0SpLb++RzCg3gYm5F61ngsAJOst3jb63k37yvjf6loT6GGyFIMmRcTs40
         5NKQ==
X-Gm-Message-State: AOJu0Yxs7nRSh4ptwo1IZ/wbrDdPRGiaStF/iIKjTXHvTQPGn8K34Iw1
        zBKoPlMiqR7e3U3g6oYMFA9dN4en0oYEqilRe3WWOYb5WB5cAD5HpYf2NBy/5yZMGW1gRrSdEZc
        Mooz/ii0GFqF1Gyn7unD7TRXs
X-Received: by 2002:a05:6402:40c9:b0:51e:5dd8:fc59 with SMTP id z9-20020a05640240c900b0051e5dd8fc59mr9696582edb.1.1694502530211;
        Tue, 12 Sep 2023 00:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXmmPwrBP85lb0mqRQMgxRqm9aedy6lUT/73mVz+NJtU3W1/8aoG/bsXbiilv5h4T+pEbFVA==
X-Received: by 2002:a05:6402:40c9:b0:51e:5dd8:fc59 with SMTP id z9-20020a05640240c900b0051e5dd8fc59mr9696551edb.1.1694502529838;
        Tue, 12 Sep 2023 00:08:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c0c8000000b00525503fac84sm5508977edp.25.2023.09.12.00.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:08:49 -0700 (PDT)
Message-ID: <69fa08b43d69b8cad41ffd3448fd8b95e4bdc120.camel@redhat.com>
Subject: Re: [PATCH] net: macb: fix sleep inside spinlock
From:   Paolo Abeni <pabeni@redhat.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>, netdev@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        kernel@pengutronix.de
Date:   Tue, 12 Sep 2023 09:08:48 +0200
In-Reply-To: <20230908112913.1701766-1-s.hauer@pengutronix.de>
References: <20230908112913.1701766-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-08 at 13:29 +0200, Sascha Hauer wrote:
> macb_set_tx_clk() is called under a spinlock but itself calls clk_set_rat=
e()
> which can sleep. This results in:
>=20
> > BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:580
> > pps pps1: new PPS source ptp1
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 40, name: kworke=
r/u4:3
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 4 locks held by kworker/u4:3/40:
> >  #0: ffff000003409148
> > macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
> >  ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_w=
ork+0x14c/0x51c
> >  #1: ffff8000833cbdd8 ((work_completion)(&pl->resolve)){+.+.}-{0:0}, at=
: process_one_work+0x14c/0x51c
> >  #2: ffff000004f01578 (&pl->state_mutex){+.+.}-{4:4}, at: phylink_resol=
ve+0x44/0x4e8
> >  #3: ffff000004f06f50 (&bp->lock){....}-{3:3}, at: macb_mac_link_up+0x4=
0/0x2ac
> > irq event stamp: 113998
> > hardirqs last  enabled at (113997): [<ffff800080e8503c>] _raw_spin_unlo=
ck_irq+0x30/0x64
> > hardirqs last disabled at (113998): [<ffff800080e84478>] _raw_spin_lock=
_irqsave+0xac/0xc8
> > softirqs last  enabled at (113608): [<ffff800080010630>] __do_softirq+0=
x430/0x4e4
> > softirqs last disabled at (113597): [<ffff80008001614c>] ____do_softirq=
+0x10/0x1c
> > CPU: 0 PID: 40 Comm: kworker/u4:3 Not tainted 6.5.0-11717-g9355ce8b2f50=
-dirty #368
> > Hardware name: ... ZynqMP ... (DT)
> > Workqueue: events_power_efficient phylink_resolve
> > Call trace:
> >  dump_backtrace+0x98/0xf0
> >  show_stack+0x18/0x24
> >  dump_stack_lvl+0x60/0xac
> >  dump_stack+0x18/0x24
> >  __might_resched+0x144/0x24c
> >  __might_sleep+0x48/0x98
> >  __mutex_lock+0x58/0x7b0
> >  mutex_lock_nested+0x24/0x30
> >  clk_prepare_lock+0x4c/0xa8
> >  clk_set_rate+0x24/0x8c
> >  macb_mac_link_up+0x25c/0x2ac
> >  phylink_resolve+0x178/0x4e8
> >  process_one_work+0x1ec/0x51c
> >  worker_thread+0x1ec/0x3e4
> >  kthread+0x120/0x124
> >  ret_from_fork+0x10/0x20
>=20
> The obvious fix is to move the call to macb_set_tx_clk() out of the
> protected area. This seems safe as rx and tx are both disabled anyway at
> this point.
> It is however not entirely clear what the spinlock shall protect. It
> could be the read-modify-write access to the NCFGR register, but this
> is accessed in macb_set_rx_mode() and macb_set_rxcsum_feature() as well
> without holding the spinlock. It could also be the register accesses
> done in mog_init_rings() or macb_init_buffers(), but again these
> functions are called without holding the spinlock in macb_hresp_error_tas=
k().
> The locking seems fishy in this driver and it might deserve another look
> before this patch is applied.

macb_set_tx_clk() moved under the bp->lock scope as a consequence of
the blamed commit. Such commit moved a bunch of code originally in
macb_mac_config() and under the bp->lock lock into macb_mac_link_up().=20

I guess that the lock was added to the latter function to be on the
"safe side", but it looks like macb_set_tx_clk() does not need it.

The patch LGTM, thanks!

Paolo

