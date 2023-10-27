Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EB7D9726
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjJ0MEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:04:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C70FC9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:04:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qwLZp-0001Rd-Fa; Fri, 27 Oct 2023 14:04:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qwLZo-004d6Z-Dy; Fri, 27 Oct 2023 14:04:32 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qwLZo-00Gbnc-Ai; Fri, 27 Oct 2023 14:04:32 +0200
Date:   Fri, 27 Oct 2023 14:04:32 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        kernel@pengutronix.de
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
Message-ID: <20231027120432.GB3359458@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
 <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
 <20231026070310.GY3359458@pengutronix.de>
 <8404022493c5ceda74807a3407e5a087425678e2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8404022493c5ceda74807a3407e5a087425678e2.camel@redhat.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:49:18AM +0200, Paolo Abeni wrote:
> On Thu, 2023-10-26 at 09:03 +0200, Sascha Hauer wrote:
> > On Tue, Oct 24, 2023 at 03:56:17PM +0200, Paolo Abeni wrote:
> > > On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> > > > It can happen that a socket sends the remaining data at close() time.
> > > > With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
> > > > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> > > > current task. This flag has been set in io_req_normal_work_add() by
> > > > calling task_work_add().
> > > > 
> > > > It seems signal_pending() is too broad, so this patch replaces it with
> > > > task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.
> > > 
> > > This looks dangerous, at best. Other possible legit users setting
> > > TIF_NOTIFY_SIGNAL will be broken.
> > > 
> > > Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?
> > 
> > I don't have an idea how io_run_task_work() comes into play here, but it
> > seems it already clears TIF_NOTIFY_SIGNAL:
> > 
> > static inline int io_run_task_work(void)
> > {
> >         /*
> >          * Always check-and-clear the task_work notification signal. With how
> >          * signaling works for task_work, we can find it set with nothing to
> >          * run. We need to clear it for that case, like get_signal() does.
> >          */
> >         if (test_thread_flag(TIF_NOTIFY_SIGNAL))
> >                 clear_notify_signal();
> > 	...
> > }
> 
> I see, io_run_task_work() is too late, sk_stream_wait_memory() is
> already woken up.
> 
> I still think this patch is unsafe. What about explicitly handling the
> restart in tls_sw_release_resources_tx() ? The main point is that such
> function is called by inet_release() and the latter can't be re-
> started.

I don't think there's anything I can do in tls_sw_release_resources_tx().
When entering this function TIF_NOTIFY_SIGNAL is not (yet) set. It gets
set at some point while tls_sw_release_resources_tx() is running. I find
it set when tls_tx_records() returns with -ERESTARTSYS. I tried clearing
TIF_NOTIFY_SIGNAL then and called tls_tx_records() again, but that doesn't
work.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
