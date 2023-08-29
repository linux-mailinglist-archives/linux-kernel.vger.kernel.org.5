Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31C78C3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjH2Lvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjH2LvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:51:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82E184
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:51:14 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693309872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ln6j+7E5qvfzntUrc3aP5Pkll5gDVCt+6KX1RNnA7s=;
        b=K+OFjNV1Is8yyVxlI9404iSk1GIkiQzfBBy2rPu1DI4tRwtBZvtvfW+gQu0AAU7iYTbyiH
        R9S39CgrocXutymCirEY5LO2drIwDyMdfC5ts3/WOL/QBuP5NaznAsgmCKg6ymMb15vOkg
        Pep3C5l21QcpA8vDTk4PrODeqBBw8MXgRVAdN5HFIM1myKiWQ34RdlDI0DG46ZNOVagcIU
        pV01yfVb1vA//H1/JX3+Fa6nwxBU86f9hpQGJOTCm3wDt5Xg/PRNYHh/xRdAvih1mZ4v8b
        to0MQdOUtITBnvciP2OZBME6acl1p7DdwaIwJ6b9JtbGAkIThcEfz71sumztwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693309872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ln6j+7E5qvfzntUrc3aP5Pkll5gDVCt+6KX1RNnA7s=;
        b=Iy24z0Evqr1wUrS1aYRC9sn5PF1rGbRn/QfqVpVPEojmJAeNEW+Wd+Kp+tDQQc/xu2eN5r
        DpUMwccVoHg7FRCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 5/8] printk: nbcon: Add sequence handling
In-Reply-To: <ZNSt1J5TiRdz9ZPx@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-6-john.ogness@linutronix.de>
 <ZNSt1J5TiRdz9ZPx@alley>
Date:   Tue, 29 Aug 2023 13:57:11 +0206
Message-ID: <87jzterrrk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10, Petr Mladek <pmladek@suse.com> wrote:
>>  void console_flush_on_panic(enum con_flush_mode mode)
>>  {
>> +	struct console *c;
>>  	bool handover;
>> -	u64 next_seq;
>> +	short flags;
>> +	int cookie;
>> +	u64 seq;
>> +
>> +	seq = prb_first_valid_seq(prb);
>> +
>> +	/*
>> +	 * Safely handle the atomic consoles before trying to flush any
>> +	 * legacy consoles.
>> +	 */
>
> This is a bit weird because the loop below just sets sequence
> number for NBCON consoles. But they are not really flushed.
>
> I think that you already agreed with it for v3. But let me mention
> it here for completeness.
>
> I would prefer to just add the API and use it later when some
> particular action get supported. And the flush could not do
> anything until nbcon_write() callback is added.

Actually I agreed with this for v2, but didn't take it far enough. I now
also agree that console_flush_on_panic() should not be modified at all
until the actual flushing functions are available.

>> @@ -3829,7 +3846,9 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>>  			if (!console_is_usable(c))
>>  				continue;
>>  
>> -			if (locked)
>> +			if (flags & CON_NBCON)
>> +				printk_seq = nbcon_seq_read(c);
>> +			else if (locked)
>>  				printk_seq = c->seq;
>>  			else
>>  				continue;
>
> I think that I mentioned this already in a previous patch. The "else
> continue" path is bad. It allows quietly skip messages for classic
> consoles when "locked" is false. I know that it should not happen
> but...
>
> A solution would be to add WARN_ON_ONCE() before the continue.

I like the WARN_ON_ONCE() suggestion. For v3 I will do:

        if (flags & CON_NBCON) {
                printk_seq = nbcon_seq_read(c);
        } else {
                WARN_ON_ONCE(!locked);
                printk_seq = c->seq;
        }

>> +static bool nbcon_seq_try_update(struct nbcon_context *ctxt)
>> +{
>> +	struct console *con = ctxt->console;
>> +	u64 con_seq = nbcon_seq_read(con);
>> +
>> +	while (con_seq < ctxt->seq) {
>
> What if anyone called nbcon_seq_force() to reply the entire log
> in the meantime?
>
> IMHO, we should remember the original nbcon_seq before
> the context handle a line. And this function should update
> nbcon_seq only when it has not been changed by other context
> in the meantime.

Makes sense. I will do that for v3.

John
