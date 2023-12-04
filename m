Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C738042B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjLDXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLDXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:42:26 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C11BFF;
        Mon,  4 Dec 2023 15:42:32 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db510605572so3332837276.0;
        Mon, 04 Dec 2023 15:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701733351; x=1702338151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNAMR8ZWVSQZ/2NChBGejZHuaFiOZmfXGcZ8gNFGqro=;
        b=JXy/F/exlMH7LBJtL9xBwzNcGWlbI2d9pIyF7ubDPpIZHEJBKUi4f/ApevFAgTNBGL
         dAinbnfaN94ARU/50z2oeGjwpuxEJEA2jDAk8QTLuyoX/QGbgDd/RjVTWWtWclNG7Ms+
         aYQ4h6sFxeoLvJ3+RvrIpz4Ewm5X1me8f5zX6qZ+l9QDyy2+UfI+l17ZX/JcDA2FJXn4
         2LTeLAkqvfCGhd0/4NJMjI/FYAvLBLnSJZwzvuMtEDUD5UIk6Z9pObU4QTwhbpEeeDHO
         rxCtmpLMwwOkOqKfhz8f+huCwhxvhqCWPzlAAiNxuk0+lSL+m3ni2euG2JEmFex4/l3l
         36BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733351; x=1702338151;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SNAMR8ZWVSQZ/2NChBGejZHuaFiOZmfXGcZ8gNFGqro=;
        b=GRJNEdNrbscGwov97NcMbg/SPPbOg7PuDE3LxWiaceX/uBkXDs8hkuzroL8CLf3ds+
         aHZ+8eGSFQ1EqvjjmNC3eoauwq+UURKeOKNoG1hovhlVgH/ldY0y7IV72E9uxmFzwdsD
         fwYOiE3Rh/CSn/NTPjLp5lFkGIBKtE/n9DpYqBMrUxji2M1tQE9/1FE9vQlAfwHSdGB4
         1Lb/2JTqOGU67V0lBENWkd2xqyXuYV8Q2HxmcLRP4bvkKeuvxu41/CnNCXoeS9urAVki
         /TyUo+o9Vi7zWmaYm5dhuddvb7gRz/eMVCAia5+dqddcpXVSMTGL1kI8nMM7aU3L92Fs
         MggQ==
X-Gm-Message-State: AOJu0YyskhYX8/GxpQx1p/rZMI7kUGyFVYJrmzD4wv9wi3LeE02YZuos
        hD0RgwkpM7vBqtkGzG0oZTLIbup0iRQ=
X-Google-Smtp-Source: AGHT+IFEwGBqGAivM84Fi2uGsVErqSSzYjUPeHAZKjtz6evL5K5weFTO/yjlefYI0luOnnCURffwlQ==
X-Received: by 2002:a25:d158:0:b0:db5:449c:5ebf with SMTP id i85-20020a25d158000000b00db5449c5ebfmr8411789ybg.38.1701733351438;
        Mon, 04 Dec 2023 15:42:31 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id r13-20020a0ccc0d000000b0067a4a8f9456sm968321qvk.38.2023.12.04.15.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 15:42:30 -0800 (PST)
Date:   Mon, 04 Dec 2023 18:42:30 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Eric Dumazet <edumazet@google.com>, Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Message-ID: <656e63e6b166a_37b1262943c@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iLww-JGAuyD4XFvpn1gy52hgHQwHE1o-UvHu6sU3-6ygw@mail.gmail.com>
References: <ZW4piNbx3IenYnuw@debian.debian>
 <CANn89iLww-JGAuyD4XFvpn1gy52hgHQwHE1o-UvHu6sU3-6ygw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] packet: add a generic drop reason for receive
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> On Mon, Dec 4, 2023 at 8:33=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wr=
ote:
> >
> > Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches=

> > from consume_skb to kfree_skb to improve error handling. However, thi=
s
> > could bring a lot of noises when we monitor real packet drops in
> > kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones=

> > can be freed, not actual packets.
> >
> > Adding a generic drop reason to allow distinguish these "clone drops"=
.
> >
> > [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xc=
xLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
> > Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> =

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
