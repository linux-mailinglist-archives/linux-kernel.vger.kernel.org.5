Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509FB80DD41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345303AbjLKVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbjLKVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:33:49 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A211D6;
        Mon, 11 Dec 2023 13:33:55 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f4bb2e5eso68866241fa.1;
        Mon, 11 Dec 2023 13:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702330433; x=1702935233; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GuWoYoYO6sRvbnyCheKJ1TTzWhOsQ+JdBJa00C2vjxk=;
        b=CZYtVsFi+JyBpuscYTBSuhqjX40IWbdxFFBk4X/EthfZWpOwivjKIOfoiTeczw4Teg
         ZObOC3Y5VKcJ37XrWIB9V5ewc4EK2GqQ/P949Uxwzx6D4vUNumN5GZKtiPHysYuWPy9s
         MwTc9e25HqZlrHCwkjfhhsM3QkZbUz6xG7BG7HCGBJwUBs44Ku25TCYArPRclHybV9jO
         4KlmRtFhXO2l88WmCsBsbf2YhmrID14lWrmVwLKPTwVZ6oqjwCxf5o4hUPeSGtVqictk
         rQ02E7AesVQCbpt9MP+jLQD7HMY9zivNenq8dCpWkJM2U1vy0brjkIzfKRiM7s4RoBeX
         pC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330433; x=1702935233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuWoYoYO6sRvbnyCheKJ1TTzWhOsQ+JdBJa00C2vjxk=;
        b=vJOKD9xZU2D2oI4NrANvbmkrmk48l0Eu8wbtyC4/KvyVgW5Weiy4S2z47QVtpGoGgQ
         1ZUX54Fs9s3oRk9HYi8eERFlvgunC0CHVA/CyTBh4RNuDNKsz+a4zsejm0LRkv9HgJYZ
         cg+YHhc8tnRQp+F+Z+K/wLmhdt6aCHd7yvSMfzzDkKBSY+b34s4R91PaOKRr24jQLdw4
         rj9Ney12QrNiiEO2zQ9uGru+E2MiemPZzF//+6cGU46xUQq5Sylzxpl9uqsjdymuCwXl
         KtJHx3N2fqxIAQFFgJvsXuCuM5Sm8zQE/lmRQ/h0J2x7seU/nM1iXC3T3zO7GpntG8Ep
         oB/g==
X-Gm-Message-State: AOJu0YxK4PtFK+ngWeKlhPZaS+BpB+OAAxS0c98jwGiXNwDX6+jrhPze
        KE8FysVWLyiPrL7ytqluwqNe+Desu5aRpA==
X-Google-Smtp-Source: AGHT+IFmjwCxjJvL+STe5SNdiH7sR3BCrFhwSBGiEJGZ2iyK0La6raGUagddZdTaoHojBjDA7WYECA==
X-Received: by 2002:a2e:a311:0:b0:2ca:7218:1963 with SMTP id l17-20020a2ea311000000b002ca72181963mr2088622lje.54.1702330433050;
        Mon, 11 Dec 2023 13:33:53 -0800 (PST)
Received: from t470.station.com (37-33-94-228.bb.dnainternet.fi. [37.33.94.228])
        by smtp.gmail.com with ESMTPSA id f6-20020a2eb5a6000000b002ca0ed22a22sm1279130ljn.63.2023.12.11.13.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:33:52 -0800 (PST)
Message-ID: <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com>
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS
 lookups
From:   markus.suvanto@gmail.com
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Dec 2023 23:33:50 +0200
In-Reply-To: <20231211163412.2766147-1-dhowells@redhat.com>
References: <20231211163412.2766147-1-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ma, 2023-12-11 kello 16:34 +0000, David Howells kirjoitti:
> Hi Markus, Marc,
>=20
> Here's a set of fixes to improve the interaction of arbitrary lookups in
> the AFS dynamic root that hit DNS lookup failures:
>=20
>  (1) Always delete unused (particularly negative) dentries as soon as
>      possible so that they don't prevent future lookups from retrying.
>=20
>  (2) Fix the handling of new-style negative DNS lookups in ->lookup() to
>      make them return ENOENT so that userspace doesn't get confused when
>      stat succeeds but the following open on the looked up file then fail=
s.
>=20
>  (3) Fix key handling so that DNS lookup results are reclaimed as soon as
>      they expire rather than sitting round either forever or for an
>      additional 5 mins beyond a set expiry time returning EKEYEXPIRED.
>=20
> The patches can be found here:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dafs-fixes
>=20
I tested this patches
6.7.0-rc4-gdfbc00cb940b
It seems that not existing directory will remove my valid rxprc key.

Reproduce:
1) kinit ....
2) aklog....
3) keyctl show=20
Session Keyring
 347100937 --alswrv   1001 65534  keyring: _uid_ses.1001
1062692655 --alswrv   1001 65534   \_ keyring: _uid.1001
 698363997 --als-rv   1001   100   \_ rxrpc: afs@station.com

klist=20
Ticket cache: KEYRING:persistent:1001:1001
Default principal: .....
...

4) ls /afs/notfound
5) keyctl show  =20
Session Keyring
 709308533 --alswrv   1001 65534  keyring: _uid_ses.1001
 385820479 --alswrv   1001 65534   \_ keyring: _uid.1001

klist
klist: Credentials cache keyring 'persistent:1001:1001' not found

-Markus

