Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17BE7B2D17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjI2HeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjI2HeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:34:00 -0400
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B211AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1695972824; bh=Mxk9l/U073uStCFV2UzL0Jvqq/Vo4Ln1BTaY+q264Og=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=h4UfrgMc/GsgctxJuapIvK1n7NV2LISZyjM4eagWufGdxYn3a8T9eGQXeex2tADbM
         RuSfnz0Aa2M1r9OmxMjaANzArsx8eleoOeYnBkl5bAn7kmPTMU47MmBq66hAGYQnXS
         ffsVjkZKidUECmxdEiX+EkZhCkxEgQWxHEYbKBkg=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri, 29 Sep 2023 09:33:44 +0200 (CEST)
X-EA-Auth: Kph+n6amj/OpMbnfaagrjIvIfM2f1llYlstIKcYMbu7B9oWx5SNQR1QBvj0B4fmVvei9+OhAtDxj3qPLNaYgUr/AVERwIYts
Message-ID: <f8e478c86bb80f37fbedc4f17b782918bc1c3607.camel@mailo.com>
Subject: Re: [PATCH] gfs2: Set error on error path
From:   drv <drv@mailo.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <error27@gmail.com>
Date:   Fri, 29 Sep 2023 13:02:51 +0530
In-Reply-To: <72de9c2e-7c60-4930-acfb-556a1f0fa4c4@kadam.mountain>
References: <ZRZrUMzweaJeEJuD@runicha.com>
         <72de9c2e-7c60-4930-acfb-556a1f0fa4c4@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 10:14 +0300, Dan Carpenter wrote:
> On Fri, Sep 29, 2023 at 11:44:40AM +0530, Deepak R Varma wrote:
> > Set the error variable inside the error path on failure. Saves
> > unnecessary variable assignment during normal execution.
> >=20
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> > =C2=A0fs/gfs2/bmap.c | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > index ef7017fb6951..93bd8ea34444 100644
> > --- a/fs/gfs2/bmap.c
> > +++ b/fs/gfs2/bmap.c
> > @@ -162,9 +162,10 @@ int gfs2_unstuff_dinode(struct gfs2_inode *ip)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0down_write(&ip->i_rw_mu=
tex);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0page =3D grab_cache_pag=
e(inode->i_mapping, 0);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D -ENOMEM;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!page)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!page) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0error =3D -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> It used to be that the other way was faster?=C2=A0 I'm pretty sure the
> compiler can figure it out these days.=C2=A0 Please don't randomly start
> changing people's prefered style unless it's drivers/staging/ code.
>=20
Hi Dan,
Thank you for the feedback. I did not know about the compiler
optimization resulting in original code being faster.
I will let the maintainers comment on breaking the style.

regards,
deepak.

> regards,
> dan carpenter
>=20



