Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645AA802623
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjLCSJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:09:38 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F1D6;
        Sun,  3 Dec 2023 10:09:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701626931; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=HD013oKEY/KfaGYVjdW0BKpb8BZryAHUC477hAmAi2Lngfq1KZjZNa+kXnRaSJesAEjtilcX2HzPFQ+SIN7T5MrugYui3pUrOn8HiQQFXLo4mtOX5JyOCM0bKOCB2z75hPyAD/3iNA8n5IChsjEBJX380gBBTVvEucKMJn+Tuxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701626931; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=jig7nqOtSLq3le2nJnQ+h5DRxXbpyeM6+FUUU6eub08=; 
        b=I/jEA/xvVZl5u/aVb2qGfb0njKhX+yqejs6qBiX+agCmPoQt//qusk+exmqKaVLZzcowDbPmurbfXPnkjalzhxIdw0Vhiat8qjKsQB/0kgj3yxLcDBYN/Us2toQtAhYescc4Zsk/4x0vvU8YfZekPyPFf1yuNsbauVhZNJA4tqY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701626931;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jig7nqOtSLq3le2nJnQ+h5DRxXbpyeM6+FUUU6eub08=;
        b=ISmc0HM7xP436viT81IWbs+UyQ6qOS8WGreQyEiChIdL45uKHjio113JYcwwsjQg
        aXs62Nm26/R+RpYbMbpXVs1XMsr0cAw1IhmbHQ8zESEDK9RdIWV6A7aQJ3N7/Ouv1zo
        X6Y0PbMOo+RhCdMAHY9wkN8gebwkpFycOVBBuEgA=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1701626900046660.6408974070963; Sun, 3 Dec 2023 23:38:20 +0530 (IST)
Date:   Sun, 03 Dec 2023 23:38:20 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Suman Ghosh" <sumang@marvell.com>
Cc:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Samuel Ortiz" <sameo@linux.intel.com>,
        "syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com" 
        <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c30ddee40.70f9a1a945075.1438711881490299499@siddh.me>
In-Reply-To: <SJ0PR18MB5216AB7B26C1F34A8748F2DADB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <cover.1701530776.git.code@siddh.me>
 <476cccdcb57645784889fc82f0c7c10ff4c8b8c0.1701530776.git.code@siddh.me> <SJ0PR18MB5216AB7B26C1F34A8748F2DADB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Subject: RE: [EXT] [PATCH net-next v2 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2023 22:29:39 +0530, Suman Ghosh wrote:
> Hi Siddh,
>=20
> >@@ -180,6 +183,7 @@ int nfc_llcp_local_put(struct nfc_llcp_local *local)
> > =C2=A0=C2=A0=C2=A0=C2=A0if (local =3D=3D NULL)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> >
> >+=C2=A0=C2=A0=C2=A0=C2=A0nfc_put_device(local->dev);
> [Suman] One question here, if we consider the path, nfc_llcp_mac_is_down(=
) ->
> nfc_llcp_socket_release() -> nfc_llcp_local_put(), then inside
> nfc_llcp_socket_release() we are already doing nfc_put_device() if=20
> "sk->sk_state =3D=3D LLCP_CONNECTED", with this change we are doing it ag=
ain.
> I guess you need to add some check to avoid that. Let me know if I am
> missing something.

The socket state is set to LLCP_CONNECTED in just two places:
nfc_llcp_recv_connect() and nfc_llcp_recv_cc().

nfc_get_device() is used prior to setting the socket state to
LLCP_CONNECTED in nfc_llcp_recv_connect(). After that, it calls
nfc_llcp_send_cc(), which I suppose is a connection PDU by some
Google-fu (NFC specs is paywalled).

In nfc_llcp_recv_cc(), we do not use nfc_get_device(), but since
one must send cc (which is done in nfc_llcp_recv_connect()), I
think we are good here.

This patch change doesn't touch any other refcounting. We increment
the refcount whenever we get the local, and decrement when we put it.
nfc_llcp_find_local() involves getting it, so all users of that
function increment the refcount, which is also the case with
nfc_llcp_mac_is_down(). The last nfc_llcp_local_put() then correctly
decrements the refcount.

If there is indeed a refcount error due to LLCP_CONNECTED, it probably
exists without this patch too.

> > =C2=A0=C2=A0=C2=A0=C2=A0new_sock->local =3D nfc_llcp_local_get(local);
> >+=C2=A0=C2=A0=C2=A0=C2=A0if (!new_sock->local) {
> >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reason =3D LLCP_DM_REJ;
> >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0release_sock(&sock->sk)=
;
> >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sock_put(&sock->sk);
> >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sock_put(&new_sock->sk)=
;
> [Suman] don't we need to free new_sock? nfc_llcp_sock_free()?
>
> [...]
>
> >+=C2=A0=C2=A0=C2=A0=C2=A0local->dev =3D nfc_get_device(ndev->idx);
> >+=C2=A0=C2=A0=C2=A0=C2=A0if (!local->dev)
> >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> [Suman] Memory leak here. Need to call kfree(local).

Yes, you are correct. Very stupid of me. Will send a v3.

Thanks,
Siddh

