Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15F9813479
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573694AbjLNPS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjLNPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D159120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702567112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uouXIP/mY6V89mn8ffGDizGjbA5gvdMVTlnAPaRcEZY=;
        b=L0Au00VYVHL1qUBKfIqAOayJ4ho7ubYcR/YUHiwEJ8gP9SIiqOiyVISMyIAhDoX9AEKF7s
        OAdBfmTD1GztbwlzMoAiWsYC7bNGlZtWQ075lpnuNwYCp+yW1LnFK0Sv3bApdWOFl4dMrO
        rxt2mwPnR1UlLJMpIeaGGyQK4PXKOBU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-xklQx0sXPYWJeZzTf_H8Ow-1; Thu, 14 Dec 2023 10:18:31 -0500
X-MC-Unique: xklQx0sXPYWJeZzTf_H8Ow-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1f72871acdso134445366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567110; x=1703171910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uouXIP/mY6V89mn8ffGDizGjbA5gvdMVTlnAPaRcEZY=;
        b=WQLIetAh1folJToIFCvsAkVQtMnIaP/luaEifB0xJAdu28xbwTWqZlV9YKmd9TCle4
         Ty7Bqmrzbpgkgo2r7QD4e8cwi53jl2OV0+nBNvFmWff5xGfw1yuO30TnwPuxfcJvvGlm
         yZtTJHlXpoVl8AX8HhfYzn7wBx2xmMZorqR8Wlbt11tartzR/wyqFWYKvzHNSJoHelS9
         bHWlxyUqVWKib9hz/4fpuy9lQSlpr57pWOWn0AGQTBWP1P5V+RFov7gbSk2p9gIBpdrE
         euZ5juArygdjZu8J7Xwi1M5C0BTytixZxtkHHR49+fr0wbrfAW+iCg2CS1+TWVKeiRDn
         iaHQ==
X-Gm-Message-State: AOJu0Yx2CDJV2gI3weYtR5yzPF/L3+rv0PZKsykA4c65j/Od31wP1Hyv
        4Q/0MHZzaMKcppyuZc4MqGsuCqnlSTX4HbtkC0PIbPQKKtbPRH+ayfib7Slm4R9lb0vctsO4tGu
        Q7E+T/GPKFE/+Nj/9xvVsLl38
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11509614ejc.5.1702567110037;
        Thu, 14 Dec 2023 07:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbLh6Ckh+2C7wi9l0Q+FDN5slGlIEm9FPCvaL/O8/HwM1PTKqTgUfLgM/T/AGEUxS/XBLhng==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11509595ejc.5.1702567109820;
        Thu, 14 Dec 2023 07:18:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a2310f34d0asm725097ejc.196.2023.12.14.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:18:29 -0800 (PST)
Message-ID: <4837d1401e1610764eeea7446280de87d51912f6.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_check_listen_stop
From:   Paolo Abeni <pabeni@redhat.com>
To:     syzbot <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martineau@kernel.org,
        matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 14 Dec 2023 16:18:27 +0100
In-Reply-To: <000000000000703582060c68aeab@google.com>
References: <000000000000703582060c68aeab@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-13 at 10:53 -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:    2513974cc3e1 Merge branch 'stmmac-bug-fixes'
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D116337fae8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db50bd31249191=
be8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5a01c3a666e726b=
c8752
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1119061ee80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D110ca006e8000=
0

It looks like tcp_diag_destroy is closing the listener subflow, while
the mptcp stack is not expecting anyone to touch it while in listener
status. I guess we can relax the mptcp_check_listen_stop checks.

/P=20

