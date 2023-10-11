Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C8B7C5AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjJKSKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJKSKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:10:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27099E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:10:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405459d9a96so10265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697047830; x=1697652630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll2dO80dKdNtktHpD8Nup75jkjUJEZ6P5R1J+WyNECY=;
        b=YkKwz31F5HP8JUaJw1v+viSHW2+XXpHLRke3TRM/2azgDWa0OOAn6n/dtblz1eu+Be
         h/v6AfOD6VcpccnJJ4mH/XZWRN125507eLaCvYFVyGG6sIua7RU7eoVMcXjH1hBzI5jk
         Pq08rjSZYSYdsf3pFIy5iZuS5LZQ06DDzwPBQqR8cTG7XVoRDh2+LgR0buuihvVYx78s
         JQjW1iijNjw7qB3+DMQJvX7mBaSdEDzUDblB2iG4jdme28F94fUAJIC9a2lsoIXhMa+r
         U1ko1dQG8Wyx5/ePX4mMeoXq+7PH0n4q2kMEIzg5tMZeknSKOfzOpEUezB50HrK6rBm7
         UX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047830; x=1697652630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll2dO80dKdNtktHpD8Nup75jkjUJEZ6P5R1J+WyNECY=;
        b=u9bi+hEsI/TON5IC3sfg1EyzT8bgGi2/oXzqW/DcBMSuGT00hfXMJBzD1j3tUjpyJl
         WLCSMiU+mxEOSHPfqgs7kc7yf1BmB2w7Uq3BOawhVbSjrLEkMnocbLRj+L28ITNnETqX
         yAr4TSZPETu372fQAfvlJqdnTwf+ZmoIVOud1FCAINu7Q13mvoQuMmGD5DQuC8DeKb5/
         Dp45lLc+HbySHv/dx8WVr8k+fNoY59xFu7WnG9vWlDuKVsNFO5WSxqcYaR3HmHZNofFS
         U38yBW4JC+y30v1KcbKWvuyiilGqwv+0yTZOSAtmb3CbIItvxIj38i95n8ykF8YSZr8X
         mogg==
X-Gm-Message-State: AOJu0YxtSvhShqunLcrtXHIWQZHJaeblChEkypKhVVT1pI2Wzu16ffrH
        l3xrHd+egGcjdav3qiL1BpRrhIhjHmNc128BVGr/Ow==
X-Google-Smtp-Source: AGHT+IFNcNJNI8p4w8N17R8rGdiSVF/UkTipnQdlUZgaXk0kTR/bUKb2YXdrQKszl5vchkfRD8n+6CMPbZSnorHqKzM=
X-Received: by 2002:a05:600c:1ca6:b0:400:c6de:6a20 with SMTP id
 k38-20020a05600c1ca600b00400c6de6a20mr125146wms.3.1697047830169; Wed, 11 Oct
 2023 11:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231009230722.76268-1-dima@arista.com> <20231009230722.76268-10-dima@arista.com>
In-Reply-To: <20231009230722.76268-10-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 11 Oct 2023 20:10:19 +0200
Message-ID: <CANn89iLD=ySFfPYkrb+oN2fuMhimxXfHrhs4Pv9_60f912rzmQ@mail.gmail.com>
Subject: Re: [PATCH v14 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
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
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 1:07=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Add support for sockets in time-wait state.
> ao_info as well as all keys are inherited on transition to time-wait
> socket. The lifetime of ao_info is now protected by ref counter, so
> that tcp_ao_destroy_sock() will destruct it only when the last user is
> gone.
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/linux/tcp.h      |  3 ++
>  include/net/tcp_ao.h     | 11 ++++-
>  net/ipv4/tcp_ao.c        | 46 +++++++++++++++++---
>  net/ipv4/tcp_ipv4.c      | 92 +++++++++++++++++++++++++++++++---------
>  net/ipv4/tcp_minisocks.c |  4 +-
>  net/ipv4/tcp_output.c    |  2 +-
>  net/ipv6/tcp_ipv6.c      | 72 ++++++++++++++++++++++---------
>  7 files changed, 181 insertions(+), 49 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index c38778b0baa0..51458219be4e 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -512,6 +512,9 @@ struct tcp_timewait_sock {
>  #ifdef CONFIG_TCP_MD5SIG
>         struct tcp_md5sig_key     *tw_md5_key;
>  #endif
> +#ifdef CONFIG_TCP_AO
> +       struct tcp_ao_info      __rcu *ao_info;
> +#endif
>  };
>
>  static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 629ab0365b83..af2caf7e76fc 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -85,6 +85,7 @@ struct tcp_ao_info {
>                                 __unused        :31;
>         __be32                  lisn;
>         __be32                  risn;
> +       atomic_t                refcnt;         /* Protects twsk destruct=
ion */

This needs to be a refcount_t
