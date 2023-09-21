Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04C7A95F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjIUQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjIUQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CAA110
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:17 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-414ba610766so13131cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315434; x=1695920234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2u6FN1SftgW++v8P+zRdQ8M7vk5MQi7XZAYI++8wbU=;
        b=U6d6cSHaVBXCY9C4WZlrfhngPyLVcYobCLrl8Dn/LACCFWy0S1fYh0+v5lWz/Upjcv
         Pf9MVlybGHld8G6Bmnuw28/qroYky8iRhRXyZtNxFtCNSPnvd/tDwpGwTcZIwWZKTjmU
         sND4VlnoOOzTMkTsbWP73uyYnEwfZbh5YJDs3wvnZtI4SmvNQIjK/kQKKT5slnE0SsQN
         KXPtT6uHiWxCbgYpyjoHtzPKV1qOxLbmPwSOcvPxliaaEq2Tnhg6NnZDicEA6CTsb+1k
         AZNcp7F881HxHDVaoMtLoyn2rxQrcaAcpiE3CTMx9tToU3LMGWukdKBDkg9qEYggt343
         X3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315434; x=1695920234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2u6FN1SftgW++v8P+zRdQ8M7vk5MQi7XZAYI++8wbU=;
        b=qSfWf5IdqMinhTGlYL/LJIqZ9T02063E70HgBSQpjx6O1A5qPHERBN0QVZFgwvx7ri
         LobeyzsLOTtwTZqInUzp6ClC7/yPVeNuqFftX9OUcCHxTvf1qtpP6RV8JnL4LrLghzWv
         tTmfYLVFiMwJxOTzPScWytNtNGRwdrUgrnddDRRpb7WTl6sFsaxTE3EFK72uJq6SwtkR
         QGVJyS5ehw5zuWc+ps7qUo7a9tTLE+mN7J0kVzTQZcmXAYtig/CB7wE3b4NIYq8xIfmB
         0fTEouDSzhEmToXLWFSgADmMUP872sanmDRIqp6wV84/rvQDxjZIFX2ACqIRQaDVcgEG
         nlBA==
X-Gm-Message-State: AOJu0YyNYM13UIX0LgeTvo4mEvSINLR6cSUDuk4PyyPcmN3P/L05FYxV
        V+YN4+B2EpuouoKJe12DQ3OknqGJEXhaGxCLngLOCNfRn4u5Cgo0JBg=
X-Google-Smtp-Source: AGHT+IFV3vDWa7KdA0yQL7JHzFNdXvAQ2asrdok6dafCPy1rMKmY7RBvf74useO0LezTQyngHc30DzRXhMIB/7XbWKw=
X-Received: by 2002:a05:622a:290:b0:416:6784:bd60 with SMTP id
 z16-20020a05622a029000b004166784bd60mr271347qtw.21.1695314980488; Thu, 21 Sep
 2023 09:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230918190027.613430-1-dima@arista.com>
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 21 Sep 2023 18:49:29 +0200
Message-ID: <CANn89iKp4LnpQ6fpTYc==ixqTNQgndBmOzj7w-_GN0hOfZyppQ@mail.gmail.com>
Subject: Re: [PATCH v12 net-next 00/23] net/tcp: Add TCP-AO support
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 9:00=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Hi,
>
> This is version 12 of TCP-AO support. The changes from v11 address
> Eric's review comments. The biggest change was defining a common
> (struct tcp_key) that merges tcp_ao_key with tcp_md5sig_key on TCP
> fast-path, therefore in order to help reviewing I provide
> the ranged-diff between the versions here:
>
>    https://gist.github.com/0x7f454c46/fe546b9cf323ca21acc3d0eabbd41236
>
> There's one Sparse warning introduced by tcp_sigpool_start():
> __cond_acquires() seems to currently being broken. I've described
> the reasoning for it on v9 cover letter. Also, checkpatch.pl warnings
> were addressed, but yet I've left the ones that are more personal
> preferences (i.e. 80 columns limit). Please, ping me if you have
> a strong feeling about one of them.
>
> The following changes since commit a5ea26536e89d04485aa9e1c8f60ba11dfc546=
9e:
>
>   Merge branch 'stmmac-devvm_stmmac_probe_config_dt-conversion' (2023-09-=
18 12:44:36 +0100)

Sorry for the delay, but I was looking at a bug in TCP MD5.

I will ask you to fix it, before we change everything in the stack
related to MD5 :/

I am releasing a syzbot report right now, I will CC you on it.
