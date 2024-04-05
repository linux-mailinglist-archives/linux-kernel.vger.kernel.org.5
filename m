Return-Path: <linux-kernel+bounces-133264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B089A16E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB81C236CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C416F909;
	Fri,  5 Apr 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OjfMrZ/e"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384D13B595
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331465; cv=none; b=EFPsoUUY27FC3q2vf2lW57ngJjQBc3/dwh/j4MKg4TL+/UKYD8ulTnD09QZ7ucdWXRxwVr7P6FupCJ2C2YKdNUJHxoI1Q4wdY2qAFA+d6LFS5OPoUXZMiEuAs/cf4ufWN1m5o/BuHOQtVxmsb/m41vTyhMEon6EzqTrzMbylNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331465; c=relaxed/simple;
	bh=BKghZSP20UphOGfHK3Pv+uv58XfUbuZxCFdPgypod+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ07ZD2YAn8Pln57p3/GowRMAC85/mkV4aDNgVe8gnJs4oVOvFMfsu2jYIFV8Stw7klp6oBDHZVTbRSt0FF7GIzA1GqCMhPMUmA1vIYdZPDZeiSu9+qBgKx3bub7jqIBWafuIB2wUKqGedLhjPrTa9i8GV3NmpcPWAzQS9TIAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OjfMrZ/e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4162ffb97a2so5511765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712331460; x=1712936260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsHE+3ZfyGu6UN+DQsyScV3TK1siN58LwM/FbCawdI8=;
        b=OjfMrZ/euFupsRLije7/DQaBjrAvf4NIrQOc2Av05+11xzFx+wW6DYjPGamPwYmMKB
         QD6Rr4LbX+jNRtHj1G+aTdqn9FFAyaBediVETIfKYuNJNI8r758ikCFvC8ciVHvMErfH
         owj7pMOmCdujv792AsiyPtRTAd0q4u/WlrTHypFYo0v94EZutWBNd1BpnA0URwjAJAdM
         +QlUnnII/1Bsk+vW7IhjipLhllXBR+jt2qq1mw0rjcuK6ir+MOtctTHszSZ0n1RGolle
         XvAeRr0wcd5Soq0jjEBD6fIUTHqHHj8KnckKtG1SM1l50SwQQr93jKV6rzb7Yd3JjK5K
         8kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331460; x=1712936260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsHE+3ZfyGu6UN+DQsyScV3TK1siN58LwM/FbCawdI8=;
        b=HYhSozJqwMV/0kTjDqB+QW/0C+1YG80jOxtqpVewZIa3esb1OworPFvWirHWTJ+XmR
         c6u9Af6OrcbaYqsOGfO6103V281Ec0KyuBUqRXouqDmRl0A2jkZnKSJv4kNAa4uynNc0
         N7AXfSb1qV4pU5rk2mlGIibNypuaDLq10ME873fPK/uiy70J6URx4kd8h/8W4PEzg4Oe
         afxAWR51ilpgEwNxd7bnNMRQjT5i/whU4+zFa8OLspzlfJ1jRNSWdHXtjUh4X0LbhAVM
         9po5Jlfiv7SAC1LtZr8NWHHtJxLehFTJv6k9W3X/dB236Juew2WEG4G8CzX96Ajm70s/
         gmXw==
X-Forwarded-Encrypted: i=1; AJvYcCXe4SQ1i7PG7ALD0/M5zd8bAiRcBAgE9nPPcPhFJWMRA9hugmanJGUyrkcJCSKfevFlZ1CqSe43hihPOXwrCEAFkuYo2H2s9ApvGWnh
X-Gm-Message-State: AOJu0Ywfbdw2OX+sTOts2TvEDS2JTyeqFKIfY4c+y+crX9VLFe9/Jr+D
	1AAn7cUdG/1JJGFfvFqsPWwhhPm0bDXfZJrdyq702sKKoc0lRTlRxbQTH9sn6q4=
X-Google-Smtp-Source: AGHT+IFUx51vn8sEuhp7zEFJnELg0e9B2Iy0V18qb4qqPR8M5AfhHkGmoqjqbl81WyoxZqvWcrLt3A==
X-Received: by 2002:a05:600c:5490:b0:414:9676:4573 with SMTP id iv16-20020a05600c549000b0041496764573mr1478802wmb.36.1712331460179;
        Fri, 05 Apr 2024 08:37:40 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05600c3ca300b004162020cee2sm7087807wmb.4.2024.04.05.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:37:39 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:37:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 02/27] printk: Properly deal with nbcon
 consoles on seq init
Message-ID: <ZhAaiuR8fu6CQ_Sn@alley>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-3-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:04, John Ogness wrote:
> If a non-boot console is registering and boot consoles exist, the
> consoles are flushed before being unregistered. This allows the
> non-boot console to continue where the boot console left off.
> 
> If for whatever reason flushing fails, the lowest seq found from
> any of the enabled boot consoles is used. Until now con->seq was
> checked. However, if it is an nbcon boot console, the function
> nbcon_seq_read() must be used to read seq because con->seq is
> not updated for nbcon consoles.
> 
> Check if it is an nbcon boot console and if so call
> nbcon_seq_read() to read seq.
> 
> Also setup the nbcon sequence number and reset the legacy
> sequence number from register_console() (rather than in
> nbcon_init() and nbcon_seq_force()). This removes all legacy
> sequence handling from nbcon.c so the code is easier to follow
> and maintain.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sigh, I wanted to wave this over. But then I ended in some
doubts, see below.


> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -974,7 +969,7 @@ void nbcon_init(struct console *con)
>  	/* nbcon_alloc() must have been called and successful! */
>  	BUG_ON(!con->pbufs);
>  
> -	nbcon_seq_force(con, con->seq);
> +	nbcon_seq_force(con, 0);
>  	nbcon_state_set(con, &state);
>  }
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c7c0ee2b47eb..b7e52b3f3e96 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3348,6 +3348,7 @@ static void try_enable_default_console(struct console *newcon)
>  		newcon->flags |= CON_CONSDEV;
>  }
>  
> +/* Set @newcon->seq to the first record this console should print. */
>  static void console_init_seq(struct console *newcon, bool bootcon_registered)
>  {
>  	struct console *con;
> @@ -3396,11 +3397,20 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
>  
>  				newcon->seq = prb_next_seq(prb);
>  				for_each_console(con) {
> -					if ((con->flags & CON_BOOT) &&
> -					    (con->flags & CON_ENABLED) &&
> -					    con->seq < newcon->seq) {
> -						newcon->seq = con->seq;
> +					u64 seq;
> +
> +					if (!((con->flags & CON_BOOT) &&
> +					      (con->flags & CON_ENABLED))) {
> +						continue;
>  					}
> +
> +					if (con->flags & CON_NBCON)
> +						seq = nbcon_seq_read(con);
> +					else
> +						seq = con->seq;
> +
> +					if (seq < newcon->seq)
> +						newcon->seq = seq;
>  				}
>  			}
>  
> @@ -3517,9 +3527,18 @@ void register_console(struct console *newcon)
>  	newcon->dropped = 0;
>  	console_init_seq(newcon, bootcon_registered);
>  
> -	if (newcon->flags & CON_NBCON)
> +	if (newcon->flags & CON_NBCON) {
>  		nbcon_init(newcon);
>  
> +		/*
> +		 * nbcon consoles have their own sequence counter. The legacy
> +		 * sequence counter is reset so that it is clear it is not
> +		 * being used.
> +		 */
> +		nbcon_seq_force(newcon, newcon->seq);
> +		newcon->seq = 0;

I have tried whether we could get rid of this hack by assigning the
value correctly already in console_init_seq().

But I ended with a checken-and-egg problem whether to call
nbcon_init() before console_init_seq() or vice versa.
No solution was ideal.

Then I realized that the full solution in RT tree starts the kthread
in nbcon_init() => con->nbcon_seq must be initialized earlier
=> the current code is buggy.

BTW: I wonder if it is sane to start the kthread in the middle of
     struct console initialization. Especially when the full
     initialization is needed for a correct serialization against
     uart_port_lock().

     It might be better to create the kthread in a separate function
     called later. But this will be another patchset...


For now, I suggest to make the seq initialization cleaner. Here is
my proposal. The patch can be applied on top of this patchset.
It is only compile tested.


From 2fcb73c98dde2c099fd5d5e4de9c0ffb449c7cc6 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 5 Apr 2024 15:44:45 +0200
Subject: [PATCH] printk: Clean up code initializing the per-console sequence
 number

console_init_seq() reads either con->seq or con->nbcon_seq
depending on the value of CON_NBCON flag. But it always sets
newcon->seq even for nbcon consoles. The value is later
moved in register_console().

Rename console_init_seq() to get_init_console_seq() and just
return the value. Pass the value to nbcon_init() so that
it might be initialized there.

The cleaned design should make sure that the value stays
and is set before the kthread is created.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 +-
 kernel/printk/nbcon.c    |  5 +++--
 kernel/printk/printk.c   | 37 +++++++++++++++++--------------------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index bcf2105a5c5c..2366303f31ae 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,7 +84,7 @@ int console_lock_spinning_disable_and_check(int cookie);
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con);
+void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 4c852c2e8d89..c57ad34a8d56 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1262,18 +1262,19 @@ bool nbcon_alloc(struct console *con)
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
+ * @init_seq	Sequence number of the first to-be-emitted record
  *
  * nbcon_alloc() *must* be called and succeed before this function
  * is called.
  */
-void nbcon_init(struct console *con)
+void nbcon_init(struct console *con, u64 init_seq)
 {
 	struct nbcon_state state = { };
 
 	/* nbcon_alloc() must have been called and successful! */
 	BUG_ON(!con->pbufs);
 
-	nbcon_seq_force(con, 0);
+	nbcon_seq_force(con, init_seq);
 	nbcon_state_set(con, &state);
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9da70d7dda3d..9164b7f72e17 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3427,20 +3427,21 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-/* Set @newcon->seq to the first record this console should print. */
-static void console_init_seq(struct console *newcon, bool bootcon_registered)
+/* Return starting sequence number to be used by a newly registered console. */
+static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
+	u64 init_seq;
 	bool handover;
 
 	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
-		newcon->seq = syslog_seq;
+		init_seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
 	} else {
 		/* Begin with next message added to ringbuffer. */
-		newcon->seq = prb_next_seq(prb);
+		init_seq = prb_next_seq(prb);
 
 		/*
 		 * If any enabled boot consoles are due to be unregistered
@@ -3461,7 +3462,7 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
 			 */
-			if (!console_flush_all(true, &newcon->seq, &handover)) {
+			if (!console_flush_all(true, &init_seq, &handover)) {
 				/*
 				 * Flushing failed. Just choose the lowest
 				 * sequence of the enabled boot consoles.
@@ -3474,12 +3475,12 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 				if (handover)
 					console_lock();
 
-				newcon->seq = prb_next_seq(prb);
+				init_seq = prb_next_seq(prb);
 				for_each_console(con) {
 					u64 seq;
 
-					if (!((con->flags & CON_BOOT) &&
-					      (con->flags & CON_ENABLED))) {
+					if (!(con->flags & CON_BOOT) ||
+					    !(con->flags & CON_ENABLED)) {
 						continue;
 					}
 
@@ -3488,14 +3489,16 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 					else
 						seq = con->seq;
 
-					if (seq < newcon->seq)
-						newcon->seq = seq;
+					if (seq < init_seq)
+						init_seq = seq;
 				}
 			}
 
 			console_unlock();
 		}
 	}
+
+	return init_seq;
 }
 
 #define console_first()				\
@@ -3528,6 +3531,7 @@ void register_console(struct console *newcon)
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
 	unsigned long flags;
+	u64 init_seq;
 	int err;
 
 	console_list_lock();
@@ -3605,21 +3609,14 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_init_seq(newcon, bootcon_registered);
+	init_seq = get_init_console_seq(newcon, have_boot_console);
 
 	if (newcon->flags & CON_NBCON) {
 		have_nbcon_console = true;
-		nbcon_init(newcon);
-
-		/*
-		 * nbcon consoles have their own sequence counter. The legacy
-		 * sequence counter is reset so that it is clear it is not
-		 * being used.
-		 */
-		nbcon_seq_force(newcon, newcon->seq);
-		newcon->seq = 0;
+		nbcon_init(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
+		newcon->seq = init_seq;
 	}
 
 	if (newcon->flags & CON_BOOT)
-- 
2.44.0


