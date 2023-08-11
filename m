Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01377885B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHKHjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjHKHiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:38:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1E52123
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:38:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so131681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739533; x=1692344333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x+skZz2w+2GZJJJ5GEJiqoHp+esKrCNS5oUsbGyl8E=;
        b=bAOHAs3vd3kij2t3yQNT7FcFVIbiKZNYE5xSvqNhe8mesOwxJd8B9fi0l1AhlDUURt
         KE4YfqQwajDEyScI0o715NRL83Ad9KhRReKl3vi4n1IyR84Rh72G0uwLMVp/08HaLzEr
         SCIvG9/Z7xNg+Q1uD4sYqQo8Iy0TAPE63mgOgoRIf8nI6j/j4HK8HHuniovRwrVd6zzY
         QY45jvMcCWHXO3nC9ndbWfdEZhxl4Jgo2mFc5BFTjgumN9b1BHUZCLb9IGNeB3BYW/1z
         QsZ4GMZZASMkHOAxs0ln+1c9/b8A9tas7DI3f/g9TK5J6/GBEx48rwYJfOXXdaFMHvtp
         l85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739533; x=1692344333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x+skZz2w+2GZJJJ5GEJiqoHp+esKrCNS5oUsbGyl8E=;
        b=E92AHY4kAqwvmMMhLQzjgSB4KwAUZxJtoWfqOR/aT1hH2rk4GFucxOWAI7SqdQLUIM
         JFN1g4cY5h/gboGvA2q3zlEz0is0CLwz5o6EzDKLGw83pg+fVloYBEwR+vNk0C5uWbSh
         FN1VQQOd6n317SVtNJCD3feiex8Lzb5SqFcweYdGagHCoDgu+1BZVVfHHkWsYjjNoiPV
         FDdpE/D9nQNEfOiw1RcLsSzC/HOWXflzqNRI/QrvKcRBonOnscHOrrMUyr4IK9jbBxel
         NyRdv9RjcYUFSfiuODvBi/l1ushh6aPuU0DtQt6SYhQwcS7D05oYsv6iPPalQWR29qhD
         D7fw==
X-Gm-Message-State: AOJu0YzgAlg2nhz6jMiks87fDdw2zD/YyamnSIEzyqGXoSxrmjLE2aN6
        csYMOhvVzo0WkXWYkwkl85GOAHrFGctvOAwXJAT9eA==
X-Google-Smtp-Source: AGHT+IGeQgCC7vxP5sPXGpUl3Krf23ZVcWj6E3bFnn5+hm6OdjbWGuICVrqY/ebkeO/npkxX99mFD/ifxO+YuJVku6E=
X-Received: by 2002:ac8:5bc6:0:b0:3fd:ad1b:4e8a with SMTP id
 b6-20020ac85bc6000000b003fdad1b4e8amr156021qtb.22.1691739533220; Fri, 11 Aug
 2023 00:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com> <20230811025530.3510703-5-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-5-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Aug 2023 09:38:42 +0200
Message-ID: <CANn89iLYPk1VpcOACBki6CE82nPp9vD7akZSbBYD+-BVb_0zBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: tcp: refactor the dbg message in tcp_retransmit_timer()
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> The debug message in tcp_retransmit_timer() is slightly wrong, because
> they could be printed even if we did not receive a new ACK packet from
> the remote peer.
>
> Change it to probing zero-window, as it is a expected case now. The
> description may be not correct.
>
> Adding the duration since the last ACK we received, and the duration of
> the retransmission, which are useful for debugging.
>
> And the message now like this:
>
> Probing zero-window on 127.0.0.1:9999/46946, seq=3D3737778959:3737791503,=
 recv 209ms ago, lasting 209ms
> Probing zero-window on 127.0.0.1:9999/46946, seq=3D3737778959:3737791503,=
 recv 404ms ago, lasting 408ms
> Probing zero-window on 127.0.0.1:9999/46946, seq=3D3737778959:3737791503,=
 recv 812ms ago, lasting 1224ms

Reviewed-by: Eric Dumazet <edumazet@google.com>
