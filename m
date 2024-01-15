Return-Path: <linux-kernel+bounces-25943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D856E82D8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACCD1C2030E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B62C697;
	Mon, 15 Jan 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/DbHv15";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwc9LEaC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F02C68F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705319737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mpn6+obTxRcm8xRz0uPp9tprpfZMtPzWtI1I5gZgAk=;
	b=a/DbHv15S2XyTFzVGLr/VP8O2N6cUEqJAgdMc+8Z8rylFMAR4O2i3lRQKwFWkyBV768GTL
	BLowYbY++tExz2miIDaBkGdant3Prph45FO0dEUped6OA+keg67G1/uvPehtCOft+iwWon
	z2bbTcrOY3P5Bir6lA9yJwxIz6qur9LbbRhCbiRUSlHvA2V2HCB7ejQAO+FUuDGI6TNaS1
	+0ccaTqxrfimpgAAqYwrJpzEtpMQctXH3JcZ0Pt0My6JpuYvqevtNGxuYIaDO0oSmV4MT/
	4pdU7RsWVGaMs/DflYyB/jkiwSm7IZ91ZZe1rHu/tncE6R9cQD9j9sOu0o25xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705319737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mpn6+obTxRcm8xRz0uPp9tprpfZMtPzWtI1I5gZgAk=;
	b=bwc9LEaC0EvxGWqfphA1hjxd0sqw12rysbM/BxgS84y5uVBUpX6VN8yQK5B/KMRJGdD07M
	a0KRTYn8JnrdXEBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v3 04/14] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
In-Reply-To: <ZaF_eJ_BCddZl5z1@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-5-john.ogness@linutronix.de>
 <ZaF_eJ_BCddZl5z1@alley>
Date: Mon, 15 Jan 2024 13:01:36 +0106
Message-ID: <874jfeg69z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-12, Petr Mladek <pmladek@suse.com> wrote:
>>  u64 prb_next_seq(struct printk_ringbuffer *rb)
>>  {
>> -	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> -	enum desc_state d_state;
>> -	unsigned long id;
>>  	u64 seq;
>>  
>> -	/* Check if the cached @id still points to a valid @seq. */
>> -	id = atomic_long_read(&desc_ring->last_finalized_id);
>> -	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
>> +	seq = desc_last_finalized_seq(rb);
>
> desc_last_finalized_seq() does internally:
>
> 	ulseq = atomic_long_read_acquire(&desc_ring->last_finalized_seq
> 					); /* LMM(desc_last_finalized_seq:A) */
>
>
> It guarantees that this CPU would see the data which were seen by the
> CPU which updated desc_ring->last_finalized_seq.
>
> So far so good.
>
> The problem is that I somehow miss the counter part. Maybe,
> it is not needed. It just looks strange.

As the comments in desc_last_finalized_seq() state: "This pairs with
desc_update_last_finalized:A."

desc_update_last_finalized() successfully reads a record and then uses a
cmpxchg_release() to set the new @last_finalized_seq value (of the
record it just read). That is the counter part.

>> -	if (d_state == desc_finalized || d_state == desc_reusable) {
>> -		/*
>> -		 * Begin searching after the last finalized record.
>> -		 *
>> -		 * On 0, the search must begin at 0 because of hack#2
>> -		 * of the bootstrapping phase it is not known if a
>> -		 * record at index 0 exists.
>> -		 */
>> -		if (seq != 0)
>> -			seq++;
>> -	} else {
>> -		/*
>> -		 * The information about the last finalized sequence number
>> -		 * has gone. It should happen only when there is a flood of
>> -		 * new messages and the ringbuffer is rapidly recycled.
>> -		 * Give up and start from the beginning.
>> -		 */
>> -		seq = 0;
>> -	}
>> +	/*
>> +	 * Begin searching after the last finalized record.
>> +	 *
>> +	 * On 0, the search must begin at 0 because of hack#2
>> +	 * of the bootstrapping phase it is not known if a
>> +	 * record at index 0 exists.
>> +	 */
>> +	if (seq != 0)
>> +		seq++;
>>  
>>  	/*
>>  	 * The information about the last finalized @seq might be inaccurate.
>
> Below is the code:
>
> 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> 		seq++;
>
> Maybe, the release() should be here to make sure that the CPU which
> would see this "seq" would also the data.

The acquire is with @last_finalized_seq. So the release must also be
with @last_finalized_seq. The important thing is that the CPU that
updates @last_finalized_seq has actually read the corresponding record
beforehand. That is exactly what desc_update_last_finalized() does.

John

