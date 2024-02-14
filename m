Return-Path: <linux-kernel+bounces-65125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79340854856
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EB71F2812D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73FF1A28C;
	Wed, 14 Feb 2024 11:29:42 +0000 (UTC)
Received: from gepdcl09.sg.gdce.sony.com.sg (unknown [121.100.38.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D70171A3;
	Wed, 14 Feb 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.100.38.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910182; cv=none; b=N9KURrlt9xo+kDgJditJbIeBtE8qKV3EtEVDDlfIpw4h5c3U5dTkOYxIVzan4lb63opmaOXCCwePCY04XErp63Q8067BuxlPwc0phEXptYfL6kGlsnawIntXLCb0+G8N3l182fWqTjxR2XTmbjCtKcH+8NIN9RQCaDuFhejOW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910182; c=relaxed/simple;
	bh=3t2GII+GFBiCVO0yfeqLOOLESh/DgusqChhhZZZl7tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3lq81YZeNR2jWn28OxDcXUBoftpmrZzRYP9Iq483kclCtqp84c2/Qz4cKURMTdsSm/1KeXrKT5QZEqSIkMC+xPYxyoHgONmbRVAa7UDBZEgTjsNf+kTjcx0jl3UbXZ/GNaKbRVPQgiMBoPvh5/qtYh2TFBh2EiNnR9CbnKk3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=121.100.38.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EAgcpk007668;
	Wed, 14 Feb 2024 18:44:09 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EAg5SS002885;
	Wed, 14 Feb 2024 18:42:05 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 367FD20C089D; Wed, 14 Feb 2024 16:10:39 +0530 (IST)
Date: Wed, 14 Feb 2024 16:10:39 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
Message-ID: <ZcyYp4eZsrrrunFj@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOdLrOPiPJmCec5@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOdLrOPiPJmCec5@alley>

On Wed, Feb 07, 2024 at 04:09:34PM +0100, Petr Mladek wrote:
> On Thu 2024-02-01 13:12:41, Sreenath Vijayan wrote:
> > When terminal is unresponsive, one cannot use dmesg to view printk
> > ring buffer messages. Also, syslog services may be disabled,
> > to check the messages after a reboot, especially on embedded systems.
> > In this scenario, dump the printk ring buffer messages via sysrq
> > by pressing sysrq+D.
> 
> I would use sysrq-R and say that it replays the kernel log on
> consoles.
> 
> The word "dump" is ambiguous. People might thing that it calls
> dmesg dumpers.
>

Ok noted. We proposed sysrq-D as it is an alternative to dmesg
command and might be easier to remember.
 
> Also the messages would be shown on the terminal only when
> console_loglevel is set to show all messages. This is done
> in __handle_sysrq(). But it is not done in the workqueue
> context.
> 

Yes, the initial implementation was using write() of consoles
so the messages would be shown irrespective of the console log
level. The current implementation depends on the console log
level but many other sysrq keys dump the messages at KERN_INFO
level. In my understanding, __handle_sysrq() dumps only the
sysrq header at the manipulated loglevel. It restores original
loglevel before calling callback function for the key.
If console_loglevel is set to show KERN_INFO messages, it would
dump most of the important printk messages in our case. Also the
loglevel can be modified using sysrq itself now.

> Finally, the commit message should explain why workqueues are used
> and what are the limitations. Something like:
> 
> <add>
> The log is replayed using workqueues. The reason is that it has to
> be done a safe way (in compare with panic context).
> 
> This also means that the sysrq won't have the desired effect
> when the system is in so bad state that workqueues do not
> make any progress.
> </add>
> 
> Another reason might be that we do not want to do it in
> an interrupt context. But this reason is questionable.
> Many other sysrq commands do a complicate work and
> print many messages as well.
>

Noted. Will add this if we proceed with workqueue implementation.
 
> Another reason is that the function need to use console_lock()
> which can't be called in IRQ context. Maybe, we should use
> console_trylock() instead.
> 
> The function would replay the messages only when console_trylock()
> succeeds. Users could repeat the sysrq when it fails.
> 
> Idea:
> 
> Using console_trylock() actually might be more reliable than
> workqueues. console_trylock() might fail repeatably when:
> 
>     + the console_lock() owner is stuck. But workqueues would fail
>       in this case as well.
> 
>     + there is a flood of messages. In this case, replaying
>       the log would not help much.
> 
> Another advantage is that the consoles would be flushed
> in sysrq context with the manipulated console_loglevel.
> 
> Best Regards,
> Petr

Yes, this seems to work well from interrupt context when the
console lock owner is not stuck. We can also manipulate
the console_loglevel. Something like this:

//in printk.c
void console_replay_all(void)
{
       if (console_trylock()) {
               __console_rewind_all();
               console_unlock();
       }
}

//in sysrq.c
static void sysrq_handle_dmesg_dump(u8 key)
{
       int orig_log_level = console_loglevel;
       console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
       console_replay_all();
       console_loglevel = orig_log_level;
}


The downside I see is that the user may have to hit the
key multiple times or give up trying if the console lock
owner is busy at the time of key press. This information
should probably be updated in the documentation.

Please let me know your opinion.

Regards,
Sreenath

