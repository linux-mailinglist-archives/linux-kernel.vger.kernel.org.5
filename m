Return-Path: <linux-kernel+bounces-140079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269FA8A0B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2981C21BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793F13FD6E;
	Thu, 11 Apr 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOPPhkJj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4113FD7F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824203; cv=none; b=HlnRsDvO7/JifiacqZPyETkblhHK4dBITZ6gboGFgdN71dKKXuDu6fTCaPymzfHpQ5wezAliv2zER6w66d3g8zVuppy6R4JQ8fFkWdHhfwmZsLmxdc9GRx/DjZvJCUTU/x3k0K8NLDThW2ASLv85QkAmvF41LEO1/1hzQm61/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824203; c=relaxed/simple;
	bh=vo0iSDp1GT2jGs2GGotK34NJkuhKeT5kSx5SYklbTmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=enKD+wZORXcOtcItlvYetP2I1Ek2vZhnlLsTBFUnoDqlE2ZjM98x5YM0/ScQRItSi5d4K9r6+NMAeQsxv4obwWtSKrlznEtrurzTlKaa6DNuHuR8cO+blZM/Ufm6PP1T8anpfPKrREgY3VArFDH53UNpTwRWSWgOuy9Oz4cCdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOPPhkJj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712824199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UWJr1U/EB988q2izFRjBXn0rjFXLneZuCZ+38kBWSdI=;
	b=EOPPhkJjRFqetPKWKNVrYhhvXOfGANJQghWZditPR+u7G/uHx02izXqO0l987N68Mlom47
	OSmgtR5FIRD/EFaTRDCoD9oBcYtpvzsAIN15S1sV5IYP1hVCRwH31YikVlXwDS2E6faoBs
	uwyFfoGu9Qnw8GZlWqYqJ6VcUF6lbWA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-ektBq_WQOweq2xJzEtVX7A-1; Thu, 11 Apr 2024 04:29:57 -0400
X-MC-Unique: ektBq_WQOweq2xJzEtVX7A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343edd4ac01so1377338f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824196; x=1713428996;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWJr1U/EB988q2izFRjBXn0rjFXLneZuCZ+38kBWSdI=;
        b=p16mVHj8spmU+k2xHSchSTasDW/k2JQMaYilePDonn6hxktJjOSsGdAXIuMgxxd5mX
         UoR4TdRhblRJbB224u2DniL4Jm9HbvZIl2LMNKZaZglQ/EAkU/2CpqMUgs4UoTrqMEg6
         rXlL8zQO+SINaBSgeDUlIoIBrpZ4HQ/qjAEhJ3SNiGEWhRDSsPn/SAdp2E9x+UmFwiXp
         XHaGg6mw2Lj0FcBS7ByTbMu1N4R9QvPrMzVG6aP8Z+1hb/3bUubvkFHmBUKGrL2U3Krr
         w72RcNbkk0pcvaMruLj3sKmALaC9cLqnpZYYOCyvpxD5yhpL2aTnRStz2RxL5o4hEtmU
         7eQA==
X-Forwarded-Encrypted: i=1; AJvYcCX98rOhuLIgz5LRmHWAcIYuqRrMNlgeaWPzisz/ALObW90ySTqzKYGvgotZuzzB0RRW39KGMZpCs4ZJD4a9jJr0c5H+8Ntq/ZCNW5BR
X-Gm-Message-State: AOJu0Yw+vZjtZhy/cLNK4fjdoXTUcX8Yv4qRLzQqqm1EZciXKL+NS0I6
	KX9dHuwBSWtccFJvm3f9gxj0+5TeWeGe++e2wjalrTeHfxv/83aOWLa7kESg+Fm8NPEqMQ3ih+G
	pnMM2z9EiX0yHGwbFCARGXOnpB3/5pk9AI419YKPufzwv1u6iyd6ohsm7adQuD22SxhI2/w==
X-Received: by 2002:a05:6000:23a:b0:343:bbec:aef8 with SMTP id l26-20020a056000023a00b00343bbecaef8mr2940101wrz.7.1712824196020;
        Thu, 11 Apr 2024 01:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOM36ybn5Chc07WnwWslEmEdxEt16BEzIrlyYL/G6FAIO+VJ0TLcg+pSAJc39UhyjU94YXzQ==
X-Received: by 2002:a05:6000:23a:b0:343:bbec:aef8 with SMTP id l26-20020a056000023a00b00343bbecaef8mr2940088wrz.7.1712824195664;
        Thu, 11 Apr 2024 01:29:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-217.dyn.eolo.it. [146.241.235.217])
        by smtp.gmail.com with ESMTPSA id q10-20020adffeca000000b0033dd2a7167fsm1215360wrs.29.2024.04.11.01.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:29:55 -0700 (PDT)
Message-ID: <9e0884e2a101215d3376f2ef9a7a68ca86599f0f.camel@redhat.com>
Subject: Re: [PATCH v2] net:tun: limit printing rate when illegal packet
 received by tun dev
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
	 <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Lei Chen
 <lei.chen@smartx.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Date: Thu, 11 Apr 2024 10:29:53 +0200
In-Reply-To: <20240410042245.2044516-1-lei.chen@smartx.com>
References: <20240410042245.2044516-1-lei.chen@smartx.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-10 at 00:22 -0400, Lei Chen wrote:
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
>=20
> net_ratelimit mechanism can be used to limit the dumping rate.
>=20
> PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
>  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
>  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
>  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
>  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
>  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
>     [exception RIP: io_serial_in+20]
>     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
>     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
>     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
>     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
>     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
>     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
>  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
>  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
>  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
>  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
>  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
>  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
>  #12 [ffffa65531497b68] printk at ffffffff89318306
>  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
>  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
>  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
>  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
>  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
>  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
>  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
>=20
> Signed-off-by: Lei Chen <lei.chen@smartx.com>

This change is IMHO best suited for 'net': the possible soft sookup
looks nasty.

@Willem, @Jason, any strong opinion against the above?

Otherwise, @Lei Chen, please repost with a suitable fixes tag and
adding the target tree into the subj prefix.

Thanks,

Paolo


