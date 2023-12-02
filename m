Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000FF801C41
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjLBKjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:39:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8E12E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 02:39:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so4970a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701513558; x=1702118358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/WnMXxklSY059GayMJ+VSslOmBX953aAVO/IsJZMxg=;
        b=dfr6mqATDtY8AR/5BrrNyhhcpWeoNBl+xc2D4SA7mJxkUkKn8FoMHcyrUm4uYVGyCl
         RHhNRtcYx/aXN443mNHfoVhzs+FlGM1CmdkxCYsviaYM/ygtuHqJQj+d9COVybxYoGu+
         xA2wPfSHTYnkn1ALAbI5Rtc0o7m0KyzFN4QPC1U+7d+fZcwTUS3AzsGReiFMBDBD1LoM
         QNy6P0dHErKWVmNKsRbbIqkUh+fVyYFFNg5oz9OX6Yq7OW068gwnGbiyqlmPl2p38HHz
         of9FNlYdr+8CHt2ovR5VCnSjBEHzPgBZHfM/RRw6j0hXRyIDjcBVgQCdomwObaxVXFtv
         rcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701513558; x=1702118358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/WnMXxklSY059GayMJ+VSslOmBX953aAVO/IsJZMxg=;
        b=NIrqnDZn0tZjRIIwHhsbc0RE4iFph3pFrVJeSu0qcoqqYrBRAC1WrBdpjf3ZXewiFN
         c9Rwel/0gQhg1hYdOHbNcRXp8zmQt/4Bbdpi+gKiLTE84eMNy/b8xjJfNc2wZ9h0mTPw
         YUahUBt9uZRUPGkVDospmBZv9W5mrGMEaxfXahuzmANSNXtr4NtDHTNRqQdj+WyZ1T1W
         f1DSjmCWErYQhpiXG2s8uvB3sa+4Hfjw73prMZtj1Jcq63WdpPWflAT6QrzyG8py4ylM
         xzzegscnSHUviIGcNgEKW9m05hJ+2VhBg7YRkJgEeYlQuyBThEw2R15VEuhprWAfTGNP
         CVyA==
X-Gm-Message-State: AOJu0Yy+Cl20k9RAbCnupTUaWgVoM8yvlVCz4r2FOxxdpTsK8D8EEGBH
        IA0l91rNjFa94IOIcvyV2IfVNe3epOuNFzThMaXXHg==
X-Google-Smtp-Source: AGHT+IEi5OTrtVEcDkGkIvxkbNSaIkzFJXWwFDWd22ponu8vPgDwbmKd5sM0/nrKNfd41vaJZ6ufOmz1cWb5r01HaH8=
X-Received: by 2002:a50:d7c1:0:b0:545:279:d075 with SMTP id
 m1-20020a50d7c1000000b005450279d075mr221900edj.1.1701513557906; Sat, 02 Dec
 2023 02:39:17 -0800 (PST)
MIME-Version: 1.0
References: <ZWomqO8m4vVcW+ro@debian.debian>
In-Reply-To: <ZWomqO8m4vVcW+ro@debian.debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 2 Dec 2023 11:39:06 +0100
Message-ID: <CANn89iJ-xLq8Ug1FqKn_Jp_VRXRdAB9mb3nhEjm4tDV251jeMw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] packet: add a generic drop reason for receive
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 7:32=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
>
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
>
> Adding a generic drop reason to allow distinguish these "clone drops".
>
> [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxLFU=
K2Zj08A8MrLk9jzg@mail.gmail.com/
> Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
