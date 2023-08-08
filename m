Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7F773EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjHHQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjHHQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:32:01 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE031003;
        Tue,  8 Aug 2023 08:51:52 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so4861208276.0;
        Tue, 08 Aug 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509900; x=1692114700;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6N1XKRd3IIvzmwYdc5soH1xY2QJlkn+NV481zGwNtg=;
        b=gA5H2P/CsEIG4nBsIESEDyKqk/3VGmxS2MDtlHxdbbgKwmgA063kHzW1zY8OiAEMjP
         hh8dvf3+j3532UMnUC5osOXad8E3xVVWmv5LiwWLaiXkSnVKZEALiHknhE+iP+ruwBvu
         z0rTRRKbC4bGEpF1OpMDhbJeihEsoL5nBvWaC1U7/XRbUqc769v7iuhIDo1jYQmoji3N
         60QzjlC3ZEEpRqxQclcVRD5qeA1UNgDiXeIYV4V+d4X0LYyJdFaXeettw4083t47B6oY
         fpiHggLgCtz7Se1Hu2IH3KhbeDYJWrEHGb1E0tLXMtKjge/JkXonxnQQPGUjKIoDygI1
         05bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509900; x=1692114700;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6N1XKRd3IIvzmwYdc5soH1xY2QJlkn+NV481zGwNtg=;
        b=YwcC8ENviiC4D8L1SPzevtcjh4mGhvFX4Z1sgX/u7k2Gb2P5hWLadLYbkFC5fVjGev
         DnJzuDaZoyaszxSa3QubHKCvFhSMGafX/ZyFRN0QDUGMy0g2XWoqKLsyC9nFxB81f9R2
         2I5WWPQU2HtGvjycxisV2mJgSP9WTAPCXKyMe+IQoWNKMxSt0VZHiAISn4se8u18Uuaz
         RsjSblhX+rWijMpPNH+YJplZekNNp64tXmOK75VlQxbgwBtnYca8wLivoAP1Xrb/Onat
         2ZQmo1oezp192/TribDDKWE0xiXAhZvhplAJapRwljxO2pBjZaVwUX+L6qhIPeTTtdRV
         mapA==
X-Gm-Message-State: AOJu0YwOfFcieAoWfGi50FtlytezC/jnCEVS+BtLlXZEjahyXBHqEheZ
        umynDtHegCTQyVh43xy48Od4IS3Aa1xGR2Ey
X-Google-Smtp-Source: AGHT+IEQyuj601LKf1oS+UK2OGZHjSTR0IUIgF5tB9/SucUWs48lti84aZvNpk40HX2GcVefw3oldQ==
X-Received: by 2002:a17:902:ba95:b0:1bc:4722:1146 with SMTP id k21-20020a170902ba9500b001bc47221146mr9174308pls.4.1691500069950;
        Tue, 08 Aug 2023 06:07:49 -0700 (PDT)
Received: from smtpclient.apple ([103.7.29.6])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b001bc0f974117sm8951304plg.57.2023.08.08.06.07.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2023 06:07:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH net-next v3 3/3] net: tcp: fix unexcepted socket die when
 snd_wnd is 0
From:   Menglong Dong <menglong8.dong@gmail.com>
In-Reply-To: <CANn89iK16069CvbA+p=WyZVYftvHs=FviQp1GSWUTG2ihRfKDA@mail.gmail.com>
Date:   Tue, 8 Aug 2023 21:07:40 +0800
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19C01818-58B5-43BF-9D59-123B30949B95@gmail.com>
References: <20230808115835.2862058-1-imagedong@tencent.com>
 <20230808115835.2862058-4-imagedong@tencent.com>
 <CANn89iK16069CvbA+p=WyZVYftvHs=FviQp1GSWUTG2ihRfKDA@mail.gmail.com>
To:     Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 8, 2023, at 20:49, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Tue, Aug 8, 2023 at 1:59=E2=80=AFPM <menglong8.dong@gmail.com> =
wrote:
>>=20
[=E2=80=A6=E2=80=A6]
>>=20
>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>> index d45c96c7f5a4..f30d1467771c 100644
>> --- a/net/ipv4/tcp_timer.c
>> +++ b/net/ipv4/tcp_timer.c
>> @@ -454,6 +454,18 @@ static void tcp_fastopen_synack_timer(struct =
sock *sk, struct request_sock *req)
>>                          req->timeout << req->num_timeout, =
TCP_RTO_MAX);
>> }
>>=20
>> +static bool tcp_rtx_probe0_timed_out(struct sock *sk)
>=20
> const struct sock *sk
>=20
>> +{
>> +       struct tcp_sock *tp =3D tcp_sk(sk);
>=20
> const struct tcp_sock *tp =3D tcp_sk(sk);
>=20
>> +       u32 timeout_ts, rtx_ts, rcv_ts;
>> +
>> +       rtx_ts =3D tp->retrans_stamp;
>> +       rcv_ts =3D tp->rcv_tstamp;
>> +       timeout_ts =3D after(rtx_ts, rcv_ts) ? rtx_ts : rcv_ts;
>> +       timeout_ts +=3D TCP_RTO_MAX;
>=20
> If we are concerned with a socket dying too soon, I would suggest
> adding 2*TCP_RTO_MAX instead of TCP_RTO_MAX
>=20
> When a receiver is OOMing, it is possible the ACK RWIN 0 can not be =
sent all,
> so tp->rcv_tstamp will not be refreshed. Or ACK could be lost in the
> network path.

Yeah, I concern abort this too. I introduce the funtion =
=E2=80=9Ctcp_rtx_probe0_timed_out()=E2=80=9D
here is to offer a more reliable way to check the timeout in the =
feature.
And for this time, we can fix the problem first, as you advised, adding
2*TCP_RTO_MAX instead of TCP_RTO_MAX.

> This also suggests the net_dbg_ratelimited("Peer %pI4:%u/%u
> unexpectedly shrunk window %u:%u (repaired)\n"...) messages
> are slightly wrong, because they could be printed even if we did not
> receive a new ACK packet from the remote peer.
>=20
> Perhaps we should change them to include delays (how long @skb stayed
> in rtx queue, how old is the last ACK we received)

Sounds great, which is more valuable. I=E2=80=99ll change them
in the next version.

Thanks!
Menglong Dong

>> +
>> +       return after(inet_csk(sk)->icsk_timeout, timeout_ts);
>> +}
>>=20
>> /**
>>  *  tcp_retransmit_timer() - The TCP retransmit timeout handler
>> @@ -519,7 +531,7 @@ void tcp_retransmit_timer(struct sock *sk)
>>                                            tp->snd_una, tp->snd_nxt);
>>                }
>> #endif
>> -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
>> +               if (tcp_rtx_probe0_timed_out(sk)) {
>>                        tcp_write_err(sk);
>>                        goto out;
>>                }
>> --
>> 2.40.1


