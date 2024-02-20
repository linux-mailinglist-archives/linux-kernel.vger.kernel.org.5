Return-Path: <linux-kernel+bounces-73461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B385C2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279B91C2245B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8545477650;
	Tue, 20 Feb 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dkw4TaiB"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18006DCF5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450944; cv=none; b=WeyctJIVT3ieCLBWSTToZDu21qBqgkRxVk9e4arT07QLZDry8CRNRqeftZSQ6nz7Pi3fo4vxInO38q9ssn83W6HqMoq1RX8aXUw82TH0Thj13/M23/vKeRzwSzbURtUgshZjxjCggupagTsLpW8lDe4yowxD4Kw48P+fa8JfKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450944; c=relaxed/simple;
	bh=KsGetTIeNCwPy9T3TXvb79TqSxh6hZ5zwMqXPAhLBo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROPxQbDxxkJ1RMmEJWzWu4WlRXRIjgS500tzxhwPr3VvNRzpJePIMJ344P5mTvLVI1dcuw8reqrRBDvylelei1t33hMfgYKXZrmkm+Zp9ZlVZBImi0FT/zc68V3Ze9A6fbvesYboPyEgiUdlPv5YgVIyx9e8Ot+mH71Sr9oQYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkw4TaiB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so302a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708450940; x=1709055740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/lV2yT0XcPBxNziflgu8BgOBo4JwQg4+0+ip6n/qMc=;
        b=dkw4TaiBt0jTx1sScgE3CXdY0vZNZ66g0Le7xoIkWwNHAMnp+Zk01RzbVdqv0cvAPZ
         Uvi4K+JQ0p2/ZSoN1nvFoHJPkJsycW3rlLFsMCIG8LOEP+Ljl2pgD8ALGryG0PePhudN
         lw8/XD3xUndOsCLXMAE4tg8DNJCez0ao7PLRtG2lRxLMNCq7qaRsEzheq6Uot8jH6793
         6yDwUrbS6Ty38YokU1FHDf9PYjphoQCslaxnhNAhS7Ya1bb23KXKmydYpeN99DGoG6l1
         ACJ74NWBRPk+EEPHXWaXpK8YhEAJIZQK6cuMWHOx63OynvR7OoBaxDWAWs2yDE/JKqE7
         u3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450940; x=1709055740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/lV2yT0XcPBxNziflgu8BgOBo4JwQg4+0+ip6n/qMc=;
        b=qPNCmVlzmMpOl3UUsTdvgGiE40CiTh+TBZ9sP9zLBXNRmYXzR0anFHwsFyYKnik1tr
         OEuinW7vIw3pSqttyPSjANa9g/3pFJ008BKb1DJpTIV+eHbGQYhO9jCy8ry8tG79rjiN
         BbYhTOdd7NFSk0LXwGiQ/DoiHQ8VfXWMV00Ibfk40txxWsExgrd45VSPPLR8rkDCrmyF
         7yeALa/3C+O5mcR8cvbx9m48N6nUDnoQ/SCO9i3puVIUjDbWlmzMD0sg1Pco/5RnmO9/
         GB39KYqk4B3hzbPH8Ohgqu5MdaSALgb+hZoCAH8w9VEFujq9vKqcDkZ/ld6d7toZex9Z
         0T+g==
X-Forwarded-Encrypted: i=1; AJvYcCUZKLusGEcBEEUsk0kM8lTWNFY0hvv35rVhWdVQzefjHtoRFDOI0dEYRGlVXpvsbrGgKYfjsZYIw3zEC8Xlqd5K2CrLYchox3mqKpne
X-Gm-Message-State: AOJu0YwGsz8y77RiREcXrPEnPvlNhNaRi9eb4WsJASLijUSD+KX45aDd
	F2MY4WcY8Ke/ZG0IUpbvcrD1FW4IyjaIFo1vEPDrhAYN/VIAKdd4hlKu3FD31YKBqvW9WD0xg3b
	AlHvjAeBnCzxcW6Hlkr/KXKFfbL68w+8s7wg4
X-Google-Smtp-Source: AGHT+IHGXwWT64hjLb9fg/atQAcjLhox7pc5R0CyDbDgdqq6PJR3HMNvD9Qc9cnsWlbpK/SaFamI+pKapmqHaukDwaA=
X-Received: by 2002:a50:cd57:0:b0:55f:8851:d03b with SMTP id
 d23-20020a50cd57000000b0055f8851d03bmr487118edj.5.1708450940072; Tue, 20 Feb
 2024 09:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219095729.2339914-1-vschneid@redhat.com> <20240219095729.2339914-2-vschneid@redhat.com>
 <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com> <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 18:42:06 +0100
Message-ID: <CANn89iJpwUpAROOq7+ttwTMCZu0=XhS4dgwcs44t-gb7-_ejRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mleitner@redhat.com, 
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:38=E2=80=AFPM Valentin Schneider <vschneid@redhat=
com> wrote:
>
> On 19/02/24 15:42, Eric Dumazet wrote:
> > On Mon, Feb 19, 2024 at 10:57=E2=80=AFAM Valentin Schneider <vschneid@r=
edhat.com> wrote:
> >>
> >> The TCP timewait timer is proving to be problematic for setups where s=
cheduler
> >> CPU isolation is achieved at runtime via cpusets (as opposed to static=
ally via
> >> isolcpus=3Ddomains).
> >>
> >
> > ...
> >
> >>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> >>  {
> >> +       /* This can race with tcp_time_wait() and dccp_time_wait(), as=
 the timer
> >> +        * is armed /after/ adding it to the hashtables.
> >> +        *
> >> +        * If this is interleaved between inet_twsk_hashdance() and in=
et_twsk_put(),
> >> +        * then this is a no-op: the timer will still end up armed.
> >> +        *
> >> +        * Conversely, if this successfully deletes the timer, then we=
 know we
> >> +        * have already gone through {tcp,dcpp}_time_wait(), and we ca=
n safely
> >> +        * call inet_twsk_kill().
> >> +        */
> >>         if (del_timer_sync(&tw->tw_timer))
> >>                 inet_twsk_kill(tw);
> >
> > I really do not think adding a comment will prevent races at netns dism=
antle.
> >
> > We need to make sure the timer is not rearmed, we want to be absolutely
> > sure that after inet_twsk_purge() we have no pending timewait sockets,
> > otherwise UAF will happen on the netns structures.
> >
> > I _think_ that you need timer_shutdown_sync() here, instead of del_time=
r_sync()
>
> Hm so that would indeed prevent a concurrent inet_twsk_schedule() from
> re-arming the timer, but in case the calls are interleaved like so:
>
>                              tcp_time_wait()
>                                inet_twsk_hashdance()
>   inet_twsk_deschedule_put()
>     timer_shutdown_sync()
>                                inet_twsk_schedule()
>
> inet_twsk_hashdance() will have left the refcounts including a count for
> the timer, and we won't arm the timer to clear it via the timer callback
> (via inet_twsk_kill()) - the patch in its current form relies on the time=
r
> being re-armed for that.
>
> I don't know if there's a cleaner way to do this, but we could catch that
> in inet_twsk_schedule() and issue the inet_twsk_kill() directly if we can
> tell the timer has been shutdown:
> ---
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 61a053fbd329c..c272da5046bb4 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -227,7 +227,7 @@ void inet_twsk_deschedule_put(struct inet_timewait_so=
ck *tw)
>          * have already gone through {tcp,dcpp}_time_wait(), and we can s=
afely
>          * call inet_twsk_kill().
>          */
> -       if (del_timer_sync(&tw->tw_timer))
> +       if (timer_shutdown_sync(&tw->tw_timer))
>                 inet_twsk_kill(tw);
>         inet_twsk_put(tw);
>  }
> @@ -267,6 +267,10 @@ void __inet_twsk_schedule(struct inet_timewait_sock =
*tw, int timeo, bool rearm)
>                                                      LINUX_MIB_TIMEWAITED=
);
>                 BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));

Would not a shutdown timer return a wrong mod_timer() value here ?

Instead of BUG_ON(), simply release the refcount ?


>                 refcount_inc(&tw->tw_dr->tw_refcount);
> +
> +               /* XXX timer got shutdown */
> +               if (!tw->tw_timer.function)
> +                       inet_twsk_kill(tw);
>         } else {
>                 mod_timer_pending(&tw->tw_timer, jiffies + timeo);
>         }
>

