Return-Path: <linux-kernel+bounces-5054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7578185F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FE31F25720
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4F154AD;
	Tue, 19 Dec 2023 11:02:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3D18E2C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rFXrX-0001qh-Dm; Tue, 19 Dec 2023 12:02:11 +0100
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
 <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
 <20231026070310.GY3359458@pengutronix.de>
 <8404022493c5ceda74807a3407e5a087425678e2.camel@redhat.com>
 <20231027120432.GB3359458@pengutronix.de>
 <20231117-starter-unvisited-d10f0314ae76-mkl@pengutronix.de>
User-agent: mu4e 1.10.8; emacs 29.1
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Jens Axboe <axboe@kernel.dk>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
Date: Tue, 19 Dec 2023 12:00:44 +0100
In-reply-to: <20231117-starter-unvisited-d10f0314ae76-mkl@pengutronix.de>
Message-ID: <87cyv2wj4e.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


On 2023-11-17 at 11:43 +01, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> [[PGP Signed Part:Undecided]]
> On 27.10.2023 14:04:32, Sascha Hauer wrote:
>> On Thu, Oct 26, 2023 at 10:49:18AM +0200, Paolo Abeni wrote:
>> > On Thu, 2023-10-26 at 09:03 +0200, Sascha Hauer wrote:
>> > > On Tue, Oct 24, 2023 at 03:56:17PM +0200, Paolo Abeni wrote:
>> > > > On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
>> > > > > It can happen that a socket sends the remaining data at close() time.
>> > > > > With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
>> > > > > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
>> > > > > current task. This flag has been set in io_req_normal_work_add() by
>> > > > > calling task_work_add().
>> > > > >
>> > > > > It seems signal_pending() is too broad, so this patch replaces it with
>> > > > > task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.
>> > > >
>> > > > This looks dangerous, at best. Other possible legit users setting
>> > > > TIF_NOTIFY_SIGNAL will be broken.
>> > > >
>> > > > Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?
>> > >
>> > > I don't have an idea how io_run_task_work() comes into play here, but it
>> > > seems it already clears TIF_NOTIFY_SIGNAL:
>> > >
>> > > static inline int io_run_task_work(void)
>> > > {
>> > >         /*
>> > >          * Always check-and-clear the task_work notification signal. With how
>> > >          * signaling works for task_work, we can find it set with nothing to
>> > >          * run. We need to clear it for that case, like get_signal() does.
>> > >          */
>> > >         if (test_thread_flag(TIF_NOTIFY_SIGNAL))
>> > >                 clear_notify_signal();
>> > > 	...
>> > > }
>> >
>> > I see, io_run_task_work() is too late, sk_stream_wait_memory() is
>> > already woken up.
>> >
>> > I still think this patch is unsafe. What about explicitly handling the
>> > restart in tls_sw_release_resources_tx() ? The main point is that such
>> > function is called by inet_release() and the latter can't be re-
>> > started.
>>
>> I don't think there's anything I can do in tls_sw_release_resources_tx().
>> When entering this function TIF_NOTIFY_SIGNAL is not (yet) set. It gets
>> set at some point while tls_sw_release_resources_tx() is running. I find
>> it set when tls_tx_records() returns with -ERESTARTSYS. I tried clearing
>> TIF_NOTIFY_SIGNAL then and called tls_tx_records() again, but that doesn't
>> work.
>
> Seems the discussion got stuck, what are the blocking points?

Ping!

Any pointers on how to get this sorted out?


Best regards,
Steffen

--
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

