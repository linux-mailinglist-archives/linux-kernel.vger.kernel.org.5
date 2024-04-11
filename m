Return-Path: <linux-kernel+bounces-140116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 896268A0B96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D758EB2569B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E231422DB;
	Thu, 11 Apr 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5Y+iotu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F60140E4D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825268; cv=none; b=M5mIzjb5K830rLUgSW2/RSHQLR2ivXRcCCkE2xe3sHnmHFlhigdiX1kDrwxwsu53nxyPM5R0DdX5iIqtHHYhtC+CuQaFlNS+cQ30QvycAV8N7NslOQr03PZuMEY2bWYnw7hRqhca2ozaaukW1G262aY3m/VVd5As7Rv76Nx06Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825268; c=relaxed/simple;
	bh=XogImJrUwJH3MFfJezd+om3eXHJumAKFWdjjf/eYD3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTW8N9fG6i8p9wg9Guobvvif/ybFSztm3Sm/x9LiweyIfcIUzPyawnXksDpE1Vg7NRSkZs+rz40dlg+KrZ46rMSPH/E7D/xGzdfe2URsGdMsQsUB4Fvz8oJUqVfFdnLi+snVm7VUSQFff3hLDrs7okXHLkzo8znUD6XMfMFIPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5Y+iotu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712825266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHtTFVdGrPf71TfXVy4j7Zndl+6LgKqo0p4DXFjFlkU=;
	b=L5Y+iotuyVwIuAmTWbapg65GPFkrENIYc+09ndVvACr7CRuQyoPVVMNkJgZXMo2YSt/QST
	z3Pa5q7piIK1rL5hsf6YKq0IEgB6Aa16k4k4byuBRjKpFHc6thwncZvnRPCRi0ua+oleR6
	ipFGdKwEqiVYNurfvEvyUxZyeD3PER0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-82nT0tLmNUWNPZvQBRJqrw-1; Thu, 11 Apr 2024 04:47:42 -0400
X-MC-Unique: 82nT0tLmNUWNPZvQBRJqrw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a5d989e820so1403112a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712825261; x=1713430061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHtTFVdGrPf71TfXVy4j7Zndl+6LgKqo0p4DXFjFlkU=;
        b=QEN9zY0ZckLgjRVygMHsHgXmUNmR6lus5jV/bV8GTruvXDHMgGxZGkkJdXtw5c4c+u
         MmC2pB2qFLT0wOlrHeU4AugtvyV5N5d5BX2ajmwvFdbEfMguiJFMMA4o8sjLqzy3X20u
         F5QKpBvyKY1Imff7Qw/LvVld2ldlx+GcvMjAiOWyo0s+C/xxkNen8SrOpD05BkIsOeAG
         jy0oEYel6bXrX1Ip1OakzV75q/R+ybrOB6ANTwRnAI4ER1stNB+DyqeNs59Eump0TSPH
         G8aQPnIDyXoQF7vX6toZJsZ/1iYMKaAf5ha/e0275nOFeCYkEoyGBSnhjPP8Aqq48fH9
         vWNw==
X-Forwarded-Encrypted: i=1; AJvYcCVr16aZz0BzPr8EdmL57DDIAgA4PLNTmjyT+pKYrs9xSSwwPGcVcUFb3o22z2Ik3eoOuSq/P87JTRntJV2QO49sVQeI42o/1G8jhpea
X-Gm-Message-State: AOJu0YwLP1+76R+yaHkRWpm7VqMBI359dGWavwF3YEXYaTMtyfoiZmWx
	lUQsy4tylAGbPCw0otttomtjEhRrqrwgjia5SIlqpWBVCJ5aeIoWTj+tTd3XAZIHt1tOXuP/jgr
	61ISKrmeFA7FVvtJ8E+Atn7NrIrbkHeoGSRqhLc6xHS/Jqx3QLoCSi3CjMpuDYVuZU4V1wNfBXo
	7jHFogmMZtMR7IMq7+w/uk1u5MpNwU/Q+LoDj4
X-Received: by 2002:a17:90b:1105:b0:2a6:db3:1aa5 with SMTP id gi5-20020a17090b110500b002a60db31aa5mr2508893pjb.18.1712825261124;
        Thu, 11 Apr 2024 01:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHULqDkAnmSkiGeO1ktymjHTUooHgAi06FSR4Xw2JS39YqUY1l2CbE924DdxcuAQso++xFTHXCMKloNBQ6guFk=
X-Received: by 2002:a17:90b:1105:b0:2a6:db3:1aa5 with SMTP id
 gi5-20020a17090b110500b002a60db31aa5mr2508880pjb.18.1712825260798; Thu, 11
 Apr 2024 01:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410042245.2044516-1-lei.chen@smartx.com> <9e0884e2a101215d3376f2ef9a7a68ca86599f0f.camel@redhat.com>
In-Reply-To: <9e0884e2a101215d3376f2ef9a7a68ca86599f0f.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Apr 2024 16:47:29 +0800
Message-ID: <CACGkMEsjTD7Q26BqLuRMh7QmRZYeWZuTbQSDrb7O=uny5oknTg@mail.gmail.com>
Subject: Re: [PATCH v2] net:tun: limit printing rate when illegal packet
 received by tun dev
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lei Chen <lei.chen@smartx.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-04-10 at 00:22 -0400, Lei Chen wrote:
> > vhost_worker will call tun call backs to receive packets. If too many
> > illegal packets arrives, tun_do_read will keep dumping packet contents.
> > When console is enabled, it will costs much more cpu time to dump
> > packet and soft lockup will be detected.
> >
> > net_ratelimit mechanism can be used to limit the dumping rate.
> >
> > PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
> >  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
> >  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
> >  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
> >  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
> >  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
> >     [exception RIP: io_serial_in+20]
> >     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
> >     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
> >     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
> >     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
> >     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
> >     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
> >  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
> >  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
> >  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
> >  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
> >  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
> >  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
> >  #12 [ffffa65531497b68] printk at ffffffff89318306
> >  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
> >  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
> >  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
> >  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
> >  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
> >  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
> >  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> >
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
>
> This change is IMHO best suited for 'net': the possible soft sookup
> looks nasty.
>
> @Willem, @Jason, any strong opinion against the above?
>
> Otherwise, @Lei Chen, please repost with a suitable fixes tag and
> adding the target tree into the subj prefix.

I think the fix should be

ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")

The target should be net.

And it needs to address Williem's concern about patch format.

With those fixed.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks,
>
> Paolo
>


