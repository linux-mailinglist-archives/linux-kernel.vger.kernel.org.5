Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D490C7CCF44
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjJQV1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjJQV1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:27:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72861994
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:25:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ux7pYulQchabpUjS3GwjVXVcDY3/A3bkxvVMQ62wKA=;
        b=1SgiWYFKp1kinsbdX4+nQ3hUpUbaGrwxCtNg8XNrbRUIiMisz/9PzNP3vg6FcdRBT+J3On
        ZV2iEUeSQp1+by5t1lQJ7gzpY3jqZbxCPqlwOcsHpSGDxMHebwHuvqQ3uOnN+eds53qosX
        AtYP79glk5HZhzwmAJ4K/UUQg2bM9q7Y5dY3npdo4DYLnjcRs45/R0QzEfZCX3liZ/Ej6l
        L1Ygx684ClGzVsTMtkPQgEIVZskJ0tNm7d35n3DONX2VJ9vBUV5LaQahyMYdK0+ey8X1K0
        nJjLCFdmlogLahcmGbj+1O6EYpb35ZbKXIoXghf5XUCVOKW8Aq8b71Za/mCWMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ux7pYulQchabpUjS3GwjVXVcDY3/A3bkxvVMQ62wKA=;
        b=ZFOj4skZHROQC5jA/8l9cvpDeuGkM89gJVGRi1XeR/8ztfgwBVGcOeEyuJj2J5gfUdkH0/
        nRrKineOkenTchBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
In-Reply-To: <ZS5vrte2OZXcIc9L@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley>
Date:   Tue, 17 Oct 2023 23:31:25 +0206
Message-ID: <87mswh6iwq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-17, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2813,8 +2813,19 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>>  	else
>>  		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
>>  
>> -	if (!prb_read_valid(prb, seq, &r))
>> -		return false;
>> +	while (!prb_read_valid(prb, seq, &r)) {
>> +		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
>> +			/*
>> +			 * The record @seq is not finalized and there may be
>
> "may be" is a bit misleading. If I count it correctly then there
> "are" more records when seq < prb_next_seq().

Ack.

> But wait. Are the messages printed in panic context always finalized?
> What about messages without the trailing newline printed?
>
> Aha, they actually are finalized because prb_next_seq() would return sequence
> number of the record in "desc_committed" state when there is
> a message without newline and we skip only seq < prb_next_seq().
> So I would update the comment, something like:
>
> 			/*
> 			 * Skip non-finalized records when emitting messages
> 			 * from panic CPU. They might never get	finalized.
> 			 *
> 			 * Note that new messages printed on panic CPU are
> 			 * finalized when we are here. The only exception
> 			 * might be the last message without trailing newline.
> 			 * But it would have the sequence number returned
> 			 * by prb_next_seq().
> 			 */
>
> Sigh, it is long. But this is a quite tricky situation.

OK.

>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 2dc4d5a1f1ff..1bbc008109ef 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1876,8 +1876,9 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
>>  }
>>  
>>  /*
>> - * Non-blocking read of a record. Updates @seq to the last finalized record
>> - * (which may have no data available).
>> + * Non-blocking read of a record. Updates @seq to the record that was read
>> + * (which may have no data available) or was attempted to be read (in case
>> + * it was unfinalized or non-existent).
>
> I am confused. Well, even the original message was confusing.
> I think about describing it the following way.
>
>   * On input, @seq defines the record which should be read. It might
>   * be updated to a higher value when the requested record has already
>   * been overwritten or when the record had empty data.
>   *
>   * On return, @seq value depends on the situation. It is:
>   *
>   *	- sequence number of the read record on success.
>   *     - sequence number of the first found to-be-finalized record
>   *	  when the input seq number was lower or equal to prb_next_seq().
>   *	- the original value when @seq was invalid, bigger then prb_next_seq().
>
> Sigh, the comment is hairy. Maybe you would find a more elegant way
> to describe the variants.

Be careful. prb_next_seq() is only loosely related to
_prb_read_valid(). I would not mention prb_next_seq() when describing
_prb_read_valid(). There are situations where _prb_read_valid() could
successfully read a record with a higher sequence number than
prb_next_seq() would return. This is because prb_next_seq() is only best
effort.

For panic it is sufficient because panic() will commit finalized records
after having stopped all other CPUs, so it will definitely update
@prb->desc_ring.last_finalized_id and allow prb_next_seq() to point to
the end of the panic messages. But for non-panic that is not the case.

I do not have a problem understanding my version of the comments. Note
that it is just a brief internal comment. It also says:

 * See the description of prb_read_valid() and prb_read_valid_info()
 * for details.

And if you look at the kerneldoc of either of those functions you see:

 * On success, the reader must check r->info.seq to see which record was
 * actually read. This allows the reader to detect dropped records.
 *
 * Failure means @seq refers to a not yet finalized or non-existing record.

Also note that @seq is never passed by reference from the external
caller. It is only passed by reference to the helper function
_prb_read_valid().

> BTW: The support for data-less records were added by the commit
>      ("printk: ringbuffer: support dataless records"). It was
>      needed to handle empty lines: printk("\n"). It is strange
>      that we skip them instead of printing the empty line.

We do not skip them. That was the whole point of adding support for
data-less records. ;-)

get_data() returns "" and @data_size=0

copy_data() returns true (but does not copy any data)

prb_read() returns true (we are assuming it is finalized)

_prb_read_valid() returns true

prb_read_valid() return true

record_print_text() creates a string with prefix and adds "\n"

printk_get_next_message() returns something to print

> Also I would update the above prb_next_seq():
>
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -2012,8 +2012,8 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
>   * available records should be skipped.
>   *
>   * Context: Any context.
> - * Return: The sequence number of the next newest (not yet available) record
> - *         for readers.
> + * Return: The sequence number of the next newest (not yet finalized or
> + *	   non-existing) record for readers.

Ack.

John Ogness
