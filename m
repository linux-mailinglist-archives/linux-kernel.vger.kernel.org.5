Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E17FEC02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjK3JjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:39:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B845D4A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:39:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so8480a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701337149; x=1701941949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+w0Xsdxg1xmtFzBpIVytZrwRsCdJaB2rhHg1ObCl0ac=;
        b=EboWee2QIgu+TNRwGRV1uzm7x8ddpkdlWN3dnuIxKzJynRdVoMtJdpUKZrqBGcXGoB
         ioSfR8vs5rG2yyVyTVjdzkQFLxyd/bx8Hm9IxBgqMf6cfsfJH2u88lDL8lt7WHqPqlyl
         z6fWuDTTrWDwl9AFimk6oHaiuSj3m7uQcx5u6bm2KDcnhMBnwzwCyBe6XnTsNGvfaiu3
         wrTwyBbsDBqsglVlQDp7stGGcaSkP4on3UqZOnfsydoHs4oz0eyjmvbNZuoP+awyFpyo
         5GSCPLPyyohrjmB9dG3WRzKRqbZkaVuYdq7R7IJq3VywG048YF/i0AC37i3K289sp1As
         MtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701337149; x=1701941949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w0Xsdxg1xmtFzBpIVytZrwRsCdJaB2rhHg1ObCl0ac=;
        b=AE0bTPC2SIZW+HEbwkgflBQ06Dtek8P11fTvBeBYOsD96pbNiGSbGNIyyNzPGqPzXj
         AMWFwYcFeyYQbBlFqKerHlo9BcsPO4wKqLoKf26gkZJ1y986NWlzjXPzg9lgJnB5jkil
         Hu2z/uw0HIZZ/mTxahV15Ius0VhfjMBBumiwoTzfjOIeb/5ypobYm8jYnuP/ovXXvsgr
         U83sd7KawqJZwIzey8DlrQ+r9RcMCsfPHTfWqIDaCsGYdSyBOyHhkW0fZAt6ydY+G1kG
         Sfmjo++RBI5jLR+P0q7oL4qlnBCmIOI2ThJe8/SRj4kQ+M0PNSnT5uKWKT6KEiloxfhg
         FGnQ==
X-Gm-Message-State: AOJu0Yx1qASrfy/Z8pQM9abys8IvC0/xDJs/MFsgWRxyhvtyVrL6WXbs
        0K+Z0eZONGcnOEH0KFKUK87hsYD0QxEXL8M26YcuXQ==
X-Google-Smtp-Source: AGHT+IH01CaFUo5z6hh/wFpSzJm4ZGqsz0fZRtVHaFB0ZsdcL1YwoDq/BZCXrmXYJW7dz2uCJh9PfLM0rycp3Xm/4k4=
X-Received: by 2002:a05:6402:1cae:b0:54b:81ba:93b2 with SMTP id
 cz14-20020a0564021cae00b0054b81ba93b2mr122702edb.2.1701337148606; Thu, 30 Nov
 2023 01:39:08 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLy_ufLD=BWDJct2chXMDYdZK=dNb4cnPYD5xo3WW1YCrw@mail.gmail.com>
 <CANn89iKpO35x-mFNgGA1axhn1hrq2HZBOFXo+wkTRPKxCQyQKA@mail.gmail.com>
In-Reply-To: <CANn89iKpO35x-mFNgGA1axhn1hrq2HZBOFXo+wkTRPKxCQyQKA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 Nov 2023 10:38:57 +0100
Message-ID: <CANn89iJ7h_LFSV6n_9WmbTMwTMsZ0UgdBj_oGrnzcrZu7oCxFw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Nov 30, 2023 at 9:42=E2=80=AFAM xingwei lee <xrivendell7@gmail.co=
m> wrote:
> >
> > Hello
> > I reproduced this bug with repro.txt and repro.c
> >
> >
>
>
> Is your syzbot instance ready to accept patches for testing ?
>
> Otherwise, a repro which happens to  work 'by luck' might not work for me=
.
>
> The bug here is a race condition with rds subsystem being dismantled
> at netns dismantle, the 'repro' could be anything really.

Can you test the following patch ?
Thanks.

diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa735b5915fc03e29cbb155b2aff2c..36d2871ac24f383e4e5d1af1168=
000f076011aae
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2197,8 +2197,6 @@ static void __sk_destruct(struct rcu_head *head)

        if (likely(sk->sk_net_refcnt))
                put_net_track(sock_net(sk), &sk->ns_tracker);
-       else
-               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);

        sk_prot_free(sk->sk_prot_creator, sk);
 }
@@ -2212,6 +2210,9 @@ void sk_destruct(struct sock *sk)
                use_call_rcu =3D true;
        }

+       if (unlikely(!sk->sk_net_refcnt))
+               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
+
        if (use_call_rcu)
                call_rcu(&sk->sk_rcu, __sk_destruct);
        else
