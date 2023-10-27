Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81277D9EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbjJ0RSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjJ0RSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD4199A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698426942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/IUIuBlUAVSfw0ZYSSp7HA1ApY55xXa4CdJDVH1eo0=;
        b=JAY5/w7M7b5yusg3/ZtnTZ25lJTZdMcmQ6YwrkAUkAaU7P/52rfn2hbnfY4G9F0Q+9XEU6
        usMeDvwTDA+YhlnpbswEVogGGwDfQzYkwZOTCCRSi4pHnAf9A4/0jR5cPrL3y195yVgGyu
        /97oj3xsMjibVoDq2xUwmm2nKDAFV8I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-2CXqmkYBOQiCwQYbVCJzBg-1; Fri, 27 Oct 2023 13:15:41 -0400
X-MC-Unique: 2CXqmkYBOQiCwQYbVCJzBg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9bfbc393c43so20787166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698426939; x=1699031739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/IUIuBlUAVSfw0ZYSSp7HA1ApY55xXa4CdJDVH1eo0=;
        b=usGjMNndFDDBzS+qkSleX/xp2Slu0xPUT3QBN42cOgsfKSySKo9gGHUnPNfassf1+V
         L50roYdxezvQa0N7o0U53g6YgFj6dQcrl9l2ilqGKjMZscNaX48iZcbmownOBY1D5r5z
         kUp4mfkWTEtMoqews3vOYEfBJB7u/oxuGKUDdQrk0b5iZlNAgcaQvFfn8FzeAT7l8W05
         ZrfCVB87Dc8+8ip7wsWAGHfHljZ0M2ktQaiA2IOwCqy3iP8C0LP4071+fWv+v09ZnAGt
         9NzTx5JqbT+GpZ86CG/bihNoBmNgy9dKdhvqiykBRKmkJ/FuEwk3sMMA4liyXwopREC0
         tDfQ==
X-Gm-Message-State: AOJu0Ywu/Db7DwPkUue8cOqCNA92COHoSGUCyM0aNw2fjuq5jBvPZ10t
        mBce/Lz5LqyT4ZoFZP/dUZ1YBNuT9UbSXISM+US9EGVmFtuVpyzXtJSxZbscNYtNbHJVltsrLe8
        JL+/Bj+DmpzTnbXiYFeXUuK0YvVoW/cJ7
X-Received: by 2002:a17:906:6547:b0:9b2:b149:b816 with SMTP id u7-20020a170906654700b009b2b149b816mr2057729ejn.7.1698426939529;
        Fri, 27 Oct 2023 10:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz3zKvAwgByzPtlH8RkxXx58KVrHzT8wVir7rvNE4KKx7DFWWzSBC5wS9Pl7fc9z5bjQxnfA==
X-Received: by 2002:a17:906:6547:b0:9b2:b149:b816 with SMTP id u7-20020a170906654700b009b2b149b816mr2057715ejn.7.1698426939166;
        Fri, 27 Oct 2023 10:15:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-222.dyn.eolo.it. [146.241.239.222])
        by smtp.gmail.com with ESMTPSA id md12-20020a170906ae8c00b009be14e5cd54sm1483469ejb.57.2023.10.27.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 10:15:38 -0700 (PDT)
Message-ID: <e245fb6a37d3c99df6efa934c5f05616bc1df7e7.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready
From:   Paolo Abeni <pabeni@redhat.com>
To:     syzbot <syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martineau@kernel.org,
        matthieu.baerts@tessares.net, matttbe@kernel.org,
        mptcp@lists.linux.dev, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Fri, 27 Oct 2023 19:15:37 +0200
In-Reply-To: <0000000000000fed5606088ee598@google.com>
References: <0000000000000fed5606088ee598@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 11:48 -0700, syzbot wrote:
> syzbot found the following issue on:
>=20
> HEAD commit:    9c5d00cb7b6b Merge tag 'perf-tools-fixes-for-v6.6-2-2023-=
1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D123fbacd68000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D530f7d8ed0a57=
417
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc53d4d3ddb327e8=
0bc51
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40

FTR: preemptible kernel, last mptcp program run on the CPU splatting
is:

r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
bind$inet(r0, &(0x7f0000000040)=3D{0x2, 0x4e24, @multicast2}, 0x10)
sendmmsg$inet(r0, &(0x7f0000000440)=3D[{{&(0x7f00000000c0)=3D{0x2, 0x4e24, =
@empty}, 0x10, 0x0}}], 0x1, 0x24040890)
r1 =3D socket$nl_generic(0x10, 0x3, 0x10)
r2 =3D syz_genetlink_get_family_id$mptcp(&(0x7f0000000080), 0xfffffffffffff=
fff)
setsockopt$inet_tcp_buf(r0, 0x6, 0xd, &(0x7f0000000140)=3D"a7", 0x1)
sendmsg$MPTCP_PM_CMD_ADD_ADDR(r1, &(0x7f0000000300)=3D{0x0, 0x0, &(0x7f0000=
000100)=3D{&(0x7f0000000000)=3D{0x28, r2, 0x1, 0x0, 0x0, {0x2}, [@MPTCP_PM_=
ATTR_ADDR=3D{0x14, 0x1, 0x0, 0x1, [@MPTCP_PM_ADDR_ATTR_ADDR4=3D{0x8, 0x3, @=
multicast2=3D0x7f000001}, @MPTCP_PM_ADDR_ATTR_FAMILY=3D{0x6, 0x1, 0x2}]}]},=
 0x28}, 0x1, 0xf00000000000000}, 0x0)

self-connecting fast-open with an empty data buffer (on a preemptible
kernel, what could possibly go wrong?!? :-P)

The splat is caused by the following check:

	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
                     !subflow->mp_join && !(state & TCPF_CLOSE));

Without a repro it's hard to guess what is going on, but looks a valid
mptcp related issue.

/P

