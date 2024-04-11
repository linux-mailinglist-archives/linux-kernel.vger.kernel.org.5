Return-Path: <linux-kernel+bounces-140258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2448A106F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414091C221E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5514D2B2;
	Thu, 11 Apr 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="nAOP2DQa"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916C146D75
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831601; cv=none; b=n7j3MgkgVLhc1jFEqrjzxMVkqUrqi5bkh4CabURC8YZjVLRzvOqs51QtdUkFK4fkdw2TErftHreNvtnSt/vrJHupDWv7PUr/zQE08WdgEOVPuNQikL9Dum6rL5aMfebkY/t23QzK2qzCrYArNy46mQ0OFdTgALbWWCGWNo1LfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831601; c=relaxed/simple;
	bh=v3UI5RIQH7te7LWmFRWP4LgzcL8cQKLtThZe3AOeO0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7RXs9QtWgJ4V7iR7SbdV6sl2NIaZMNUT0rtmeK0LP5GbkXjdZJnpdk/1R0A4rQ/hGPT35/EsjOBjVWOWQTz0akcN1FrGQhS/N4y+9qj77f1lo/9xRnIhMGKjCXZNem547lT6OhTXF3O89XGbuEktVpH5aiNbCUxI5B2seRwJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=nAOP2DQa; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6098a20ab22so71405117b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712831599; x=1713436399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIzn5JxfDVqeHPR8BBB6h2bxYLXCwdl4F5nMpLuCxqE=;
        b=nAOP2DQaNI9g4amwHVbo28P91cGmlMQQ37SqWiQrR21M4SRLeoMtV6wvprUncM6eAY
         F0sfaemgtW5EpBR77rAKMS8sDZiEBmYC35lzSuXhBIxg1tblTEYTaKy/CPas2hpE9feC
         2jaAiZUv3Ntc0aTQ8fmaL+l/JE0JFZ5pC2/7pvNQjBmdZjUzmbjMmvJArW47D5DbtuVl
         qhiIAKYrVj6hZPkR6Uz86muk007xI6ElkfNM5r+oE1m8xpdVXDzz1nireJIVPdE+C7tn
         QXViWX9K0xPNq564dwpSDWgatUus3ferQkKLEuJqQwzNZAvUqu/Yfruv/Mxo2BqDRyt7
         nPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712831599; x=1713436399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIzn5JxfDVqeHPR8BBB6h2bxYLXCwdl4F5nMpLuCxqE=;
        b=bTVL2CzHwjFnc/Rv5iILqEZ4g8RyYKSCJZEkZt4uUPtrG/+KKBMb7UUWQHPK0Ah9S8
         wMGUYU9brP3RSPiV0Ffl+ukpeJ5u6fJrGZv8Lic9UGYzsjMBctf1OcGXiBoIur+d+zrX
         EjILpoipg7sbEm8Uz6ig4WsBuZToJu2cJVIauxlPQodQcS9avjvGj2DkYcX/mNj5mbUk
         Q9VfRszi5jQO+5lzKlHX6xG6cfWKDxIGLdGxOQ9nQ7LlTkZDs6Ob4/SZPV21drwfEDlm
         Fr6UV0Cd3RXovaQHpUiYR8Jt6v47p4Wvusq3+JxxbVAeKOjJ+ti9FbDdRgVJATTTRQHU
         yxng==
X-Forwarded-Encrypted: i=1; AJvYcCV3wJtKxCjiMOMAUmobaJSTRrQ2UE7GIE4o0Z0L+IAQoupOoy6cey6mcVnaumXtoZnAleXJZLkts2nmtdeEQZXo+sWSe9RaF23Brgyq
X-Gm-Message-State: AOJu0YwhKCft06cBAsyP7FMux5/ifrKL6Yhr4ws5/K7gK9Vo49VT6kw4
	W+BUliqI8+2w7dvm3ugDN9nU/pJEEvDzNTTUtz7zR78Uw8QshPqZ/iC9dOA9T3JzG9M7fce0Aen
	SMNwU7L5C99C4um6dEKBag64blHasZTqqJRk+gA==
X-Google-Smtp-Source: AGHT+IHjYblqeN/83EZv0nceP91YlUEmxfdXzxyjeGJ3vXN9tOSNGqZr+qgrXFxAWFWULr/A5HFAyUbdbME3tgB3PGY=
X-Received: by 2002:a0d:dd14:0:b0:614:c76:26f1 with SMTP id
 g20-20020a0ddd14000000b006140c7626f1mr6198370ywe.21.1712831597884; Thu, 11
 Apr 2024 03:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410042245.2044516-1-lei.chen@smartx.com> <9e0884e2a101215d3376f2ef9a7a68ca86599f0f.camel@redhat.com>
 <CACGkMEsjTD7Q26BqLuRMh7QmRZYeWZuTbQSDrb7O=uny5oknTg@mail.gmail.com>
In-Reply-To: <CACGkMEsjTD7Q26BqLuRMh7QmRZYeWZuTbQSDrb7O=uny5oknTg@mail.gmail.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Thu, 11 Apr 2024 18:33:06 +0800
Message-ID: <CAKcXpBwr9v-z0zVQ-KiucAfPLbE7AB4JMM+Ems5iW0nijuPKug@mail.gmail.com>
Subject: Re: [PATCH v2] net:tun: limit printing rate when illegal packet
 received by tun dev
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:47=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Apr 11, 2024 at 4:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On Wed, 2024-04-10 at 00:22 -0400, Lei Chen wrote:
> > > vhost_worker will call tun call backs to receive packets. If too many
> > > illegal packets arrives, tun_do_read will keep dumping packet content=
s.
> > > When console is enabled, it will costs much more cpu time to dump
> > > packet and soft lockup will be detected.
> > >
> > > net_ratelimit mechanism can be used to limit the dumping rate.
> > >
> > > PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980=
"
> > >  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
> > >  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
> > >  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
> > >  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
> > >  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
> > >     [exception RIP: io_serial_in+20]
> > >     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
> > >     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 00000000000000=
00
> > >     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428=
a0
> > >     RBP: 0000000000002710   R8: 0000000000000004   R9: 00000000000000=
0f
> > >     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 00000000000000=
20
> > >     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 00000000000000=
00
> > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > >  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
> > >  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
> > >  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
> > >  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
> > >  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
> > >  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
> > >  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
> > >  #12 [ffffa65531497b68] printk at ffffffff89318306
> > >  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
> > >  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
> > >  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
> > >  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
> > >  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
> > >  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
> > >  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> > >
> > > Signed-off-by: Lei Chen <lei.chen@smartx.com>
> >
> > This change is IMHO best suited for 'net': the possible soft sookup
> > looks nasty.
> >
> > @Willem, @Jason, any strong opinion against the above?
> >
> > Otherwise, @Lei Chen, please repost with a suitable fixes tag and
> > adding the target tree into the subj prefix.
>
> I think the fix should be
>
> ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
>
> The target should be net.
>
> And it needs to address Williem's concern about patch format.
>
> With those fixed.
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Thanks for your help.
I will remake the patch with subject-prefix "PATCH net-next v3"  and
fix tag ef3db4a59542"

