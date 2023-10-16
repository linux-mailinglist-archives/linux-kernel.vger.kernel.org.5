Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20777CAFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjJPQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjJPQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:37:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2483E7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356DEC433C7;
        Mon, 16 Oct 2023 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697473460;
        bh=tmS2WVsDC8a8uXLukYPlcrQc2u6u82VNkXvp5EUy8xg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MqW1B05lebvow0fs9yOoO69OMLPgOKGaK8NY3MAQp7FVjzVyC0J3ocQ12mFF2jjzJ
         yiuc0vi3WX1tpW5lGReg8gYluLJt3Ad1tmebsq8AYlE3J5GBTceQOvVtbgF648IOqE
         RHrWEHojBRPaNXpjEpINOM+5/8Y3VQ/GR25YGXsT07i5DTGXERjyAN/UrayFycK/IM
         CdFzNuZUOhvFiiKC4n9Cq60e5tO49BhJXNjpPFJYOd+oOc0DaMu4BIj9f54lSD9dxb
         XTds0Ye/k76PGAUJeU+WqkG9f67ByYRFBuIClMzCXy4FvmBQzpf2w3Kbe1tjiu35gP
         Ltw8YCY8I2qXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C98F1CE0868; Mon, 16 Oct 2023 09:24:19 -0700 (PDT)
Date:   Mon, 16 Oct 2023 09:24:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <246fe818-57a7-4cee-a11b-390df3eee101@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
 <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
 <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
 <6b66305f-8172-463e-a50d-324c0c33a6ea@t-8ch.de>
 <a5f1a910-dbac-44d8-b9f6-5725bea948b2@paulmck-laptop>
 <aa77a065-fcc9-4d3a-8531-fd994587c48f@t-8ch.de>
 <0c8446a7-473d-49bc-9413-d1b9176f13b1@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c8446a7-473d-49bc-9413-d1b9176f13b1@paulmck-laptop>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:18:18PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 12, 2023 at 09:34:53PM +0200, Thomas Weiﬂschuh wrote:
> > On 2023-10-12 12:06:33-0700, Paul E. McKenney wrote:
> > > On Thu, Oct 12, 2023 at 08:39:14PM +0200, Thomas Weiﬂschuh wrote:
> > > > On 2023-10-12 11:25:02-0700, Paul E. McKenney wrote:
> > > > > [..]
> > 
> > > > > I have a signed tag urgent/nolibc.2023.10.12a in the -rcu tree, so
> > > > > please check the lead-in text for sanity.  (Everything after the digital
> > > > > signature is automatically generated.)
> > > > 
> > > > Looks good. But it's only a listing of the commit subjects, correct?
> > > 
> > > Pretty close, just a few added words on the last one.
> > > 
> > > So the question is whether there is some larger issue that Linus should
> > > be made aware of.  If these are just simple fixes for simple bugs,
> > > we should be good, but yes, I do need to ask.  ;-)
> > 
> > These are simple fixes for simple bugs.
> > 
> > Do you always have to ask specifically or can I just mention it in the
> > pull request in the future?
> 
> I would be extremely happy to simply copy text from the pull request
> into the signed tags.  ;-)
> 
> We would just need to agree on the format.  For example, in this case,
> there will eventually be two signed tags, one for the urgent pull
> request early next week and another for the pull request for the upcoming
> merge window.
> 
> Proposals for the format?

Actually, proposals for the signed-tag text for the urgent commits?
Left to myself, I would use the same text shown below that I proposed
last week.

							Thanx, Paul

------------------------------------------------------------------------

tag urgent/nolibc.2023.10.12a
Tagger: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Oct 12 10:50:08 2023 -0700

Urgent pull request for nolibc into v6.6

This pull request contains the following fixes:

o	tools/nolibc: i386: Fix a stack misalign bug on _start

o	MAINTAINERS: nolibc: update tree location

o	tools/nolibc: mark start_c as weak to avoid linker errors

 MAINTAINERS                      | 2 +-
 tools/include/nolibc/arch-i386.h | 4 +++-
 tools/include/nolibc/crt.h       | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQJHBAABCgAxFiEEbK7UrM+RBIrCoViJnr8S83LZ+4wFAmUoMqATHHBhdWxtY2tA
a2VybmVsLm9yZwAKCRCevxLzctn7jAE9D/9aa/OzGPI9VFKcN1gIW8dYJnXvSI3n
+gUMjRhlWnx2DBxBkpg7jmiPUXySlsOzHoo9sgtMuOVXhkdmODZ5RL7drKJXNqxs
xmpb70mftOtj/+qx3CEj71K45t5pkwidRTwOuwcNGOGM4xb6sw7kVCWinsKGSPjh
l8pcJxquY2ZcKKp1OciT37IYw6AcWUz4v/JCeKLOg9FFlxIrenR56u41f7OR0GM/
D1kggSHuwAk+b0BmnUXEig2Ys0bORZ1sRQnTHjQEmba4kr41DzarwdIXMU2LUS3m
dIxTtSs8kRSRZ21A9rGNEnezwZaYVdRraH3LQcDYQ4lsaccZc7xUICzHwj/DVri1
PkHVrZzii/PZGIADLYEn1ob9PjbuPXbpf6p1xZsnOCaKv1n4DcG2fHsIsCTptHkr
qT8+DDu2x74WiD+lAaEuOJV1UeCDjQrTyrK2Impvg1af/d0xS6hUvDeap09OhLpW
odLgtpO5xRLsWFrKl/FGCZIsLXUkvpn3F2FfU3nLgFWMFiuw6Nkk+hLlr34WqTGs
A+LRYktd8moFPJRzUhgOr1jZpy8SUhs3MRWlfJ3I3FHQvCYFDX95xHsl5brZ3Vkp
UAfRPpJmJYfIzhfj7kQZQFJ+mCIfRI0jb+6VyF/u9/MaicfMes4YlUwKEUGBbx+f
rrUmEilQCZd3Sw==
=Wnux
-----END PGP SIGNATURE-----

commit 90864f0679fdbb3b2e1c3bdbe4b0a34df785cb0a
Author: Thomas Weiﬂschuh <linux@weissschuh.net>
Date:   Thu Oct 12 00:37:38 2023 +0200

    tools/nolibc: mark start_c as weak
    
    Otherwise the different instances of _start_c from each compilation unit
    will lead to linker errors:
    
    /usr/bin/ld: /tmp/ccSNvRqs.o: in function `_start_c':
    nolibc-test-foo.c:(.text.nolibc_memset+0x9): multiple definition of `_start_c'; /tmp/ccG25101.o:nolibc-test.c:(.text+0x1ea3): first defined here
    
    Fixes: 17336755150b ("tools/nolibc: add new crt.h with _start_c")
    Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
    Link: https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/
    Link: https://lore.kernel.org/lkml/20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net/
    Acked-by: Willy Tarreau <w@1wt.eu>

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index a5f33fef1672..a05655b4ce1d 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -13,6 +13,7 @@ const unsigned long *_auxv __attribute__((weak));
 static void __stack_chk_init(void);
 static void exit(int);
 
+__attribute__((weak))
 void _start_c(long *sp)
 {
 	long argc;
