Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0507E75B7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGTTPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGTTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:15:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FEC171D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:15:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2756a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880498; x=1690485298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAy1IEMzEKnBqRGLhWLekSm4eET+PZas5kwMX/alrsM=;
        b=w32q6DB+CVWrHhcm6JkTEoQAAVTVDyS/PnK86FjgSSB/Lr3/lB3ACqhaNaaUrNDK0w
         icepJnmeU5mGKl9Kw6h5BsdGKexycm4ybvnnbOF/p6TWatoZvr8yucvBaP9vfrUrri2E
         xJG35S8oppQqnj/p37imqF+tIcjHj2PGMkdrLR8++vIRXEMCWc39qJh2XxGuyz9l7TWh
         EunZd/KPmhsKGyBoN9w9OmvVnkgfq1XwtW7CblUxKSkMHmanbUoqIB1Uw5FemMm47yCx
         NMMGIZNfrHfTf90+CRzJf3kys3TAM6pfhLwX/Gdp0GR32iXuviO4kB5zW0aDk6i3otiZ
         W21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880498; x=1690485298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAy1IEMzEKnBqRGLhWLekSm4eET+PZas5kwMX/alrsM=;
        b=T6Xl6TMi4rBX0zyDPwh3rPSASguiXfFviQs6dgzSamiErePGe6ow+Y6T0kZqSlGu1J
         /tqP85wKszWL7DKCMZKnep//joyimpZOPsvwFJ8m5UPhkM8dzzLHq610LECitcBeOgre
         qDgDB+FYDqVNdO82GQRj8oKc8wcDEpP+rN3s6gCevEGwJVdT5dEf/2aioOoyPTIYdsLM
         BUDyCMcdpm+Rcxw24lZD50C0CmUlwXYxQmz1o6RBZkLPsFQH8lQlSYHhL2cGQicqyw+H
         SxqskTrbgOqc/lXxAU0SQatXdTgDEmEYSlCey6OS1gyjK26ag3odHmoBnzRWAR1Dfsnx
         IrcA==
X-Gm-Message-State: ABy/qLaMzh0la9Q2bbIquuVtMjexq5tMV2t1tgKkZcKj/XwAskpnihaZ
        GPfeH15jNQCqmc17Awf8DgAukqIVcCddAAzJwC4YrA==
X-Google-Smtp-Source: APBJJlHQg9NmnVAiEnIEfExWOiEKsBneck65xNomT9GlPUYaiO3MdCoUT1IayLIR4gMV5Eqe7ILOteX01vOKqXcPros=
X-Received: by 2002:a50:d50b:0:b0:51a:1ffd:10e with SMTP id
 u11-20020a50d50b000000b0051a1ffd010emr19916edi.3.1689880498256; Thu, 20 Jul
 2023 12:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
 <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
In-Reply-To: <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Thu, 20 Jul 2023 15:14:20 -0400
Message-ID: <CACSApvaBBmQsEJBZcht0--zqyWcoJm0vfiCw4RiA0AyyaJQsMw@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
To:     Eric Dumazet <edumazet@google.com>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 3:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 20, 2023 at 8:48=E2=80=AFPM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
> >
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > The MPTCP code uses the assumption that the tcp_win_from_space() helper
> > does not use any TCP-specific field, and thus works correctly operating
> > on an MPTCP socket.
> >
> > The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > broke such assumption, and as a consequence most MPTCP connections stal=
l
> > on zero-window event due to auto-tuning changing the rcv buffer size
> > quite randomly.
> >
> > Address the issue syncing again the MPTCP auto-tuning code with the TCP
> > one. To achieve that, factor out the windows size logic in socket
> > independent helpers, and reuse them in mptcp_rcv_space_adjust(). The
> > MPTCP level scaling_ratio is selected as the minimum one from the all
> > the subflows, as a worst-case estimate.
> >
> > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> >  include/net/tcp.h    | 20 +++++++++++++++-----
> >  net/mptcp/protocol.c | 15 +++++++--------
> >  net/mptcp/protocol.h |  8 +++++++-
> >  net/mptcp/subflow.c  |  2 +-
> >  4 files changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c5fb90079920..794642fbd724 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1430,22 +1430,32 @@ void tcp_select_initial_window(const struct soc=
k *sk, int __space,
> >                                __u32 *window_clamp, int wscale_ok,
> >                                __u8 *rcv_wscale, __u32 init_rcv_wnd);
> >
> > -static inline int tcp_win_from_space(const struct sock *sk, int space)
> > +static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
> >  {
> > -       s64 scaled_space =3D (s64)space * tcp_sk(sk)->scaling_ratio;
> > +       s64 scaled_space =3D (s64)space * scaling_ratio;
> >
> >         return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
> >  }
> >
> > -/* inverse of tcp_win_from_space() */
> > -static inline int tcp_space_from_win(const struct sock *sk, int win)
> > +static inline int tcp_win_from_space(const struct sock *sk, int space)
>
> Maybe in a follow up patch we could change the prototype of this helper
> to avoid future mis use :)
>
> static inline int tcp_win_from_space(const struct tcp_sock *tp, int space=
)
> {
> }
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Thank you for the fix!

> > +{
> > +       return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
> > +}
> > +
> > +/* inverse of __tcp_win_from_space() */
> > +static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
> >  {
> >         u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
> >
> > -       do_div(val, tcp_sk(sk)->scaling_ratio);
> > +       do_div(val, scaling_ratio);
> >         return val;
> >  }
> >
> > +static inline int tcp_space_from_win(const struct sock *sk, int win
>
> Same remark here.
>
> Thanks for the fix !
