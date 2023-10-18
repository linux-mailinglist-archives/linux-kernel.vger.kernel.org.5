Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B17CDCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJRNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjJRNPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:15:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813C114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:15:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D48241F37E;
        Wed, 18 Oct 2023 13:15:49 +0000 (UTC)
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7093E2C1F2;
        Wed, 18 Oct 2023 13:15:49 +0000 (UTC)
Date:   Wed, 18 Oct 2023 15:15:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
Message-ID: <ZS_ahOpCQGNjDgSm@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley>
 <87mswh6iwq.fsf@jogness.linutronix.de>
 <877cnk72y9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cnk72y9.fsf@jogness.linutronix.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D48241F37E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-18 10:30:46, John Ogness wrote:
> On 2023-10-17, John Ogness <john.ogness@linutronix.de> wrote:
> >>> -	if (!prb_read_valid(prb, seq, &r))
> >>> -		return false;
> >>> +	while (!prb_read_valid(prb, seq, &r)) {
> >>> +		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
> >>> +			/*
> >>> +			 * The record @seq is not finalized and there may be
> 
> I am wondering if we should put the this_cpu_in_panic() check into
> _prb_read_valid() instead. This has the advantage that it could more
> intelligently skip non-finalized records and not need to rely on
> prb_next_seq(). Also, it would allow any other readers (kmsg_dump) to
> skip non-finalized records during panic.

Yeah, this look like a better solution. Anyway, we need to try reading
the messages behind prb_next_seq() up to the head of the ring buffer.
And @head_id is not available outside prb API.

> Looking over the code, it would be easy to extend
> desc_read_finalized_seq() to return a separate error code for exists but
> is non-finalized. This would make it trivial for _prb_read_valid() to
> skip over it when this_cpu_in_panic().

Sounds reasonable.

Best Regards,
Petr
