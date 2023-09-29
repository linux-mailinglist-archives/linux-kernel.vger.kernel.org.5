Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B497B2D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjI2Hjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2Hjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:39:31 -0400
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84046180
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1695973158; bh=jCXpnkD65gBL82o/dmwBwRzPh1cMJECkbSyB2ZedaOU=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=jABpx6pjJbOoRCTDeUAFVzC32vkF7Vx+lrp3RpxHCCCs27wAfLOHe7CsRqNuCQsKU
         uigTJYElqBhY6h+BV/nPzkwRzA5PPkAcpejkvMA6T+SsAY+BBMW/9hPhiD7LCCsYPw
         b+as3MUdyGCG6iSJExvT9kThbGvGssJlG0Jem1Cc=
Received: by b221-5.in.mailobj.net [192.168.90.25] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri, 29 Sep 2023 09:39:17 +0200 (CEST)
X-EA-Auth: UlFkxK2sLNWRc9kMuK0MPizk6AYjvh9OiodH7TWZlBB6qMjIFdaikrp+ZyO5wfQccBmhJTUB1GHw/xXmuVpNPcUu6AVPBw/f
Message-ID: <0c1ed836c5a306331e1b2a97217c3c9f7e1fb701.camel@mailo.com>
Subject: Re: [PATCH] gfs2: fix 'passing zero to ERR_PTR()' warning
From:   drv <drv@mailo.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <error27@gmail.com>
Date:   Fri, 29 Sep 2023 13:09:11 +0530
In-Reply-To: <a2d702b0-e819-47b0-a945-c2e38a162381@kadam.mountain>
References: <ZRXA7n0wD83zhPxC@runicha.com>
         <a2d702b0-e819-47b0-a945-c2e38a162381@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 10:06 +0300, Dan Carpenter wrote:
> On Thu, Sep 28, 2023 at 11:37:42PM +0530, Deepak R Varma wrote:
> > Resolve the following Smatch static checker warning:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fs/gfs2/acl.c:54 __gfs2=
_get_acl() warn: passing zero to
> > 'ERR_PTR'
> >=20
> > by returning NULL when an extended attribute length is zero,
> > instead of
> > passing on zero to the ERR_PTR().
> >=20
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
>=20
> Passing zero to ERR_PTR() is not a bug.
>=20
> You're patch doesn't change how the code works at all, right?=C2=A0 So
> it's
> like a cleanup patch.=C2=A0 But the code was nicer in the original.
>=20
> This is just a false positive.=C2=A0 Ignore static checker false
> positives.
> Fix the checker instead.=C2=A0 Although in this case, I can't think of an
> easy way fix the checker.=C2=A0 Perhaps don't print a warning if the
> callers
> check for NULL?
>=20
> The passing zero to ERR_PTR() warning is actually a pretty good
> heuristic.=C2=A0 90% of the time in new code this is a real bug.=C2=A0 Bu=
t in
> old
> code then probably it's 0% real bugs because we've been reviewing
> these
> warnings for over a decade.
>=20
> I have a blog which might be useful.
> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and=
-null/
>=20
> When I'm reviewing this patch I think:
> 1) Does gfs2_xattr_acl_get() return zero?=C2=A0 And it does.
> 2) Does that look intentional.=C2=A0 It's harder to tell because there
> aren't
> =C2=A0=C2=A0 comments and it looks like it might be a missing error code.=
=C2=A0 But
> =C2=A0=C2=A0 when you read it closely then actually it does look intentio=
nal.
> =C2=A0=C2=A0 In terms of Smatch, I consider it "intentional" if there is =
an
> =C2=A0=C2=A0 "error =3D 0;" within 5 lines for the goto.=C2=A0 (Other lan=
guages like
> Rust
> =C2=A0=C2=A0 are better than C because they force everyone to follow the =
rules.
> =C2=A0=C2=A0 #trolling).
> 3) Do the callers of __gfs2_get_acl() check for NULL and they do.
>=20
> So this code is fine.
>=20
> I hope this helps you in your review process.=C2=A0 1)=C2=A0 Ignore old
> warnings.
> 2)=C2=A0 Ignore false positives.=C2=A0 3)=C2=A0 If you think it is a bug,=
 then try
> to
> figure out how it will cause a crash.=C2=A0 Look at the caller etc.
>=20
Hi Dan,
Thank you for the review, feedback and guidance. This is really
helpful.

regards,
deepak.

> regards,
> dan carpenter
>=20



