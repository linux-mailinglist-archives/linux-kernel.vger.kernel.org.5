Return-Path: <linux-kernel+bounces-86496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2879486C641
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35561F22DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B763502;
	Thu, 29 Feb 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHTpnWtR"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C507634F4;
	Thu, 29 Feb 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200970; cv=none; b=beHzVVnimhnmgUz0FcYk3s3hLD9AYdvzU1Zz9Dn9XVhjTG8nPoTSABqYbOEFs5c6eRkjtB67/J+vPbdsOERsRWhbZnQIVN8TV1TEgaGm2GjlRx+2pMAJjN+8BO+0q0R27SZhiSz4rTNXvmdKnfohILXQBDS7VEJVf27e1k1PVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200970; c=relaxed/simple;
	bh=JFtlQtX08v24Ylx3dxXE35IPy+/hi1g6yJZ61zeJeQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ez4yPgOJyrovEAP+yhwad6vPSS3vGmlaNqz8SdTlIpXCgbg1HQI15whzhA3F0gwoNkCNMRzs8pU9D/Nb4jiNVApNGGX6XkYymKhGF9qjFjLCSZTkwK+Axhi21t9bn+8q0f9MA5iBKuU+HwFbXI5lVlmxwCWWVOBtOorbWLFzaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHTpnWtR; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso559214276.1;
        Thu, 29 Feb 2024 02:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709200968; x=1709805768; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5jta4vjvJ7/12MtOocaS6dVP2qRC6nZvFeLA6WW4lo=;
        b=cHTpnWtRMCsFXVQEoH9nGFY5DFctFL9rkjidH9qqHKh9TvFD4FnUmh1JVr+FLaDLCj
         +NL+XlR91hQIjc79OnleT3V7hw7CTlhacY6RvYoRrg+4kPCMuQcQVOlTtqIF/M/Yj5/L
         2Sddq9ERMRCiRoiyRDlw8MHsNfP2eHu2CmH8ve5w7ls1YNhorIFmYjww+kZr9boXkH4H
         +oXsL+9t3L1PXtkqfpi60RZVGGiicwXK6HznQjI/VWNHRFLj12Bgq5bsSUfQI5Z18Dz4
         xwb8mL0X6tQS5+2SFpc3ZGEnYRTzyL3iIaADjIqp3Ea8edtovsfmFGebMpE29Z5E810O
         /z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200968; x=1709805768;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5jta4vjvJ7/12MtOocaS6dVP2qRC6nZvFeLA6WW4lo=;
        b=IJtntGEcgCSAfzOpGu3lBARO6Qalm6/6NpV+G9BRHA+xfbMe+p9RxkIBcMm5iAxv5F
         KBTTxtH7veiW7baFcuqPESXR0Aq2YgpPeTiQcjy394pF0PObHLhBl17HOuwt+YDmKRCT
         CZ2PbdJsUevN0v3DDrwoe9c5QpRagtorhn1CvXbITgUQsjKHMca2R/xF+Pt9795jpZbm
         dpl6+OlKegwPCdEFlAJnfwlU4fqgRAtAfc59ZHxarFbtkslMsxfk6h2kK3zpUFlsj9Nt
         k/XjarXmNqMIDdwd/2Udqfa5/6hf9GpVPNk4D/nDlUHtRQpWu/EhVfvBIVtpPH8RpgeL
         jsTw==
X-Forwarded-Encrypted: i=1; AJvYcCVIVEKzdjnABZjzeJdjOZ0rBUegX9V/g1RJnifFLymwWhGzs6rfXObe2KiXF2gZwnuEPC2qPAsqLRfKUJCGOZhGt+gH18F3B9hJJT8SpvyUwIoZ
X-Gm-Message-State: AOJu0Yz/4/P4gyOo88g0e9DUU7n/mi2hzP4h1BYlTMShzHtshnKIQJCs
	PZYO0NLBSQ1RdtyxpvmG/LIY+DMtSn0jkUm17yJkLFKch8eOSgRHMNthS2CawbKbRuzKc+mr1N7
	F2EYMhMyoBMeQTkN2Wo0YdJDgl6s05aGkTf4LGbo=
X-Google-Smtp-Source: AGHT+IGpg8mHFo0bBKribtTNLgEIrGrGWWfVrwM66a2y/RkuD9oIEMUppJPT/MQ+5yHjy/3mnrfGURr3gl97Ob2UriI=
X-Received: by 2002:a25:7506:0:b0:dcc:f5d4:8b43 with SMTP id
 q6-20020a257506000000b00dccf5d48b43mr1790680ybc.9.1709200967984; Thu, 29 Feb
 2024 02:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229052813.GA23899@didi-ThinkCentre-M920t-N000>
 <CAL+tcoAhvFhXdr1WQU8mv_6ZX5nOoNpbOLAB6=C+DB-qXQ11Ew@mail.gmail.com> <CABbqxmdM+zbn+78rcB_amqfwFKXCTwyj2MPt2GVioQpR0Tj1Tg@mail.gmail.com>
In-Reply-To: <CABbqxmdM+zbn+78rcB_amqfwFKXCTwyj2MPt2GVioQpR0Tj1Tg@mail.gmail.com>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Thu, 29 Feb 2024 18:02:35 +0800
Message-ID: <CABbqxmcG1ZApeKLS5yfE7Bb-tgBwOLEn1-ixp89n3mKVJbmm6g@mail.gmail.com>
Subject: Fwd: [PATCH] tcp: Add skb addr and sock addr to arguments of
 tracepoint tcp_probe.
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A yuanli fu <fuyuanli0722@gmail.com>
Date: 2024=E5=B9=B42=E6=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 16:27
Subject: Re: [PATCH] tcp: Add skb addr and sock addr to arguments of
tracepoint tcp_probe.
To: Jason Xing <kerneljasonxing@gmail.com>


Jason Xing <kerneljasonxing@gmail.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=8829=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 29, 2024 at 1:33=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.com=
> wrote:
> >
> > It is useful to expose skb addr and sock addr to user in tracepoint
> > tcp_probe, so that we can get more information while monitoring
> > receiving of tcp data, by ebpf or other ways.
> >
> > For example, we need to identify a packet by seq and end_seq when
> > calculate transmit latency between lay 2 and lay 4 by ebpf, but which i=
s
> > not available in tcp_probe, so we can only use kprobe hooking
> > tcp_rcv_esatblised to get them. But we can use tcp_probe directly if sk=
b
> > addr and sock addr are available, which is more efficient.
> >
> > Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
>
> Please target 'net-next' in the title of your v2 patch.
Got it, thanks.
>
> > ---
> >  include/trace/events/tcp.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > index 7b1ddffa3dfc..096c15f64b92 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -258,6 +258,8 @@ TRACE_EVENT(tcp_probe,
> >                 __field(__u32, srtt)
> >                 __field(__u32, rcv_wnd)
> >                 __field(__u64, sock_cookie)
> > +               __field(const void *, skbaddr)
> > +               __field(const void *, skaddr)
> >         ),
> >
> >         TP_fast_assign(
> > @@ -285,6 +287,9 @@ TRACE_EVENT(tcp_probe,
> >                 __entry->ssthresh =3D tcp_current_ssthresh(sk);
> >                 __entry->srtt =3D tp->srtt_us >> 3;
> >                 __entry->sock_cookie =3D sock_gen_cookie(sk);
> > +
> > +               __entry->skbaddr =3D skb;
> > +               __entry->skaddr =3D sk;
> >         ),
> >
> >         TP_printk("family=3D%s src=3D%pISpc dest=3D%pISpc mark=3D%#x da=
ta_len=3D%d snd_nxt=3D%#x snd_una=3D%#x snd_cwnd=3D%u ssthresh=3D%u snd_wnd=
=3D%u srtt=3D%u rcv_wnd=3D%u sock_cookie=3D%llx",
>
> If they are useful, at least you should printk those two addresses
> like what trace_kfree_skb() does.
>
Got it, I will add to printk
> May I ask how it could be useful if there is no more function printing
> such information in the receive path?
We can get seq and end_seq by skbaddr in netif_receive_skb, so latency
between l2->l4 can be calculated.
>
> Thanks,
> Jason
> > --
> > 2.17.1
> >
> >
>
thanks
fuyuanli

