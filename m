Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE767A9EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjIUUPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjIUUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:15:33 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74626400EA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34fc9b461b6so4465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316505; x=1695921305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZhZTyGMIwZ/ie/LDnjolHR2PA5j6eoOnn74VlJviEM=;
        b=0xY+lD5P3QbdnZk/BqvAF2e218Sge6Op79TTL+H2cBTMefXcjuL4tUQ8+4XApdexgR
         6X364ZRiNtMAIOdhDYSayDxKgdJ5ye/5nfgwe8sl44J5tiLeL2LYiRFExSMq+oy9676B
         9ZVJCr7OgaxdsBtajIBhzsjTEP6xBajZBYwoQBQ8Xym4RXKMCUj2H4ZIhif4MxewwTci
         73k+Ye1mysAsT+Qwv2j+y3OcjAFqXpW3QfXn09QikWddYzfoz1hqMHTmjE9FMpPuZ9RD
         bwGucbdB/31+LWswVjnl13ZNedYplhMWfmf3hWP+0AgMAqdd9EjolbuUa7l8ttBLpQZi
         4NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316505; x=1695921305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZhZTyGMIwZ/ie/LDnjolHR2PA5j6eoOnn74VlJviEM=;
        b=FKjR+cSsd12aoY/wYv8bSxYtD/en9EMA0hCsPkGiUOBY6T63HN1o1+obN7uiJqOI0u
         Jw0zhMTGiZhE88YVF4mCVoUbwLvpktGaQGPGMBc/X6GwV6K0X7oHHcVdRguLhAXwGk7y
         zKCq4LwSb1VjQexy9+PwgKvBjPb6kNagjl+6L5xmlnonRTYZlLttvSBiFHc2lQMax/Jw
         b7gm9jhJpFA42ci72WAR2PtLW+MW6DCP1MBa4qLah3STiTTV6zDYScWQZFRcLWavWX3E
         rCSb1Nc6P4OUW9WTJTzGboTsPEDLi/pFEqtaD9wYZUuXnMFkztPjUtOGbMI4QtjV9RNw
         TIig==
X-Gm-Message-State: AOJu0YwgpvIbO7fp67Xm6YZPAjXV+Fch2J9CudxjIOfGDIdqLS/14y+F
        Zqa9RXSfyab53CSgBqxIAKockfB/ah27Qf8la0GH6s9bk5Q52PCLHuA=
X-Google-Smtp-Source: AGHT+IFWIeurUPvjpL8vBL+NRQRjjve76EQFHIAx0HeE7Z69wb2lo8venh8x2KPWv7LuxH/KDV+UnqVPhre4/L2Akrw=
X-Received: by 2002:ac8:5b11:0:b0:403:e1d1:8b63 with SMTP id
 m17-20020ac85b11000000b00403e1d18b63mr211399qtw.24.1695294572440; Thu, 21 Sep
 2023 04:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <730408.1695292879@warthog.procyon.org.uk>
In-Reply-To: <730408.1695292879@warthog.procyon.org.uk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 21 Sep 2023 13:09:21 +0200
Message-ID: <CANn89i+wUq5R2nFO8eGLp7=8Y5OiJ0fwjR+ES74gk1X4k9r0rw@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:41=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
>
> Including the transhdrlen in length is a problem when the packet is
> partially filled (e.g. something like send(MSG_MORE) happened previously)
> when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> transport header or account for it twice.  This can happen under some
> circumstances, such as splicing into an L2TP socket.
>
> The symptom observed is a warning in __ip6_append_data():
>
>     WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_=
data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
>
> that occurs when MSG_SPLICE_PAGES is used to append more data to an alrea=
dy
> partially occupied skbuff.  The warning occurs when 'copy' is larger than
> the amount of data in the message iterator.  This is because the requeste=
d
> length includes the transport header length when it shouldn't.  This can =
be
> triggered by, for example:
>
>         sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
>         bind(sfd, ...); // ::1
>         connect(sfd, ...); // ::1 port 7
>         send(sfd, buffer, 4100, MSG_MORE);
>         sendfile(sfd, dfd, NULL, 1024);
>
> Fix this by only adding transhdrlen into the length if the write queue is
> empty in l2tp_ip6_sendmsg(), analogously to how UDP does things.
>
> l2tp_ip_sendmsg() looks like it won't suffer from this problem as it buil=
ds
> the UDP packet itself.
>
> Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for=
 IPv6")
> Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: David Ahern <dsahern@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: netdev@vger.kernel.org
> cc: bpf@vger.kernel.org
> cc: syzkaller-bugs@googlegroups.com
> ---

Looks safer indeed, thanks to you and Willem !

Reviewed-by: Eric Dumazet <edumazet@google.com>
