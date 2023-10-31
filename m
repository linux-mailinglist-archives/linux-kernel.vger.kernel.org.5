Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DF7DCD27
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbjJaMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjJaMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:45:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0BC9;
        Tue, 31 Oct 2023 05:45:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2450BE000D;
        Tue, 31 Oct 2023 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698756352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qf0fOm1zrcrZERfMUBpXiSuKpvHRMAeRL/TftcSoL2I=;
        b=h6qGVg3IstcAz2PHpLDyb8N0nh1lyTzCIsE3BJAFuH9FdUihn95zobK7FnNG+vfOKSZox4
        JR6OvXQ3gKptEnI3r3zPsgEQTC13qwVzAoYlg24Yl14sn4C5RMXBpEynewNFDFWw9csdcE
        4ukeenrUE3kkyYRzLfUa8PrxyKBFrzejfdcIyjIPESOWcMwsoEVup9cdBKdaXUm+TjA6QW
        E1vN6XIOulADr1lmh+7kq+VetFhAdOFTUbJTNENg8q7rKu5xWoPfg4vmDXPErPnYsqQPTr
        yRCdY6xBoTm2VK3WMFnZmf+z8c8PC/ZUDpY5a1PXa7hk1lTOtqK/BlvGC+0VmA==
Date:   Tue, 31 Oct 2023 13:45:50 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231031134522.27e78274@xps-13>
In-Reply-To: <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at>
References: <20231030103415.401ce804@canb.auug.org.au>
        <20231030173228.691620ca@xps-13>
        <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
        <20231031085158.o4ilb5d47sxcqm3o@quack3>
        <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
        <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner>
        <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

richard@nod.at wrote on Tue, 31 Oct 2023 12:30:40 +0100 (CET):

> Christian,
>=20
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Christian Brauner" <brauner@kernel.org> =20
> >> >> A side effect of 1bcded92d938 ("mtd: block2mtd: Convert to
> >> >> bdev_open_by_dev/path()")
> >> >> is that it fixes the problem too. That's a good thing.
> >> >>=20
> >> >> I'm a bit puzzled how to fix the problem for 6.5.y and 6.6.y stable=
 releases.
> >> >> Back porting 1bcded92d938 seems risky to me since the commit is lar=
ge.
> >> >> On the other hand, ff6abbe85634 will not make it into Linus' tree a=
nd therefore
> >> >> is not suitable for stable either. =20
> >> >=20
> >> > Yes, that's one of the cases where stable rules make life harder for=
 actual
> >> > fixes... You can try pushing ff6abbe85634 to stable even if it is not
> >> > upstream since it fixes a real bug and taking the upstream solution =
is
> >> > indeed IMO too intrusive. Sometimes stable maintainers accept such f=
ixes. =20
> >>=20
> >> Yep, let's try this route. :-) =20
> >=20
> > Is there anything for me to do? IOW, do I need to grab that patch or
> > not? :) =20
>=20
> No, just keep Jan's patch. (-:
>=20
> Miquel, we could also keep ff6abbe85634 in the mtd tree and explain Linus=
 the
> conflict, what do you think? That would help with back porting to stable.

It's not relevant if the patch in Brauner's tree is already fixing this
up. Just send the smaller patch to stable@vger.kernel.org asking them to
backport this patch instead of the other one, they are used to this
kind of constraint, no?

Miqu=C3=A8l
