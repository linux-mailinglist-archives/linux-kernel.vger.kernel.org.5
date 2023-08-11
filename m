Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6B7784A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHKAme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjHKAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053926AB;
        Thu, 10 Aug 2023 17:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A984E65BB7;
        Fri, 11 Aug 2023 00:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8E6C433C8;
        Fri, 11 Aug 2023 00:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691714551;
        bh=BLVBWqO0aRuEYlrB8Ztjvwvzg8thlHpFoerbknuafcs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=r9jqh2h0KZZYZDtige5DCcjtRdrHmZkgGSr8rZMOFWKpJy1OdDEi7LOi2yZ3k5zxU
         pX49HvM6qmrYYrktUFzgmf25B8sOQRcP2waURBl3xafOLof6sYReACF9Fj1+p9llRU
         idlDYn4fyWUYJTfs9sSyEosdV28AaeeUrJhiYQXJ/Vxh6lRbPWP2sNoBs0fLLmQOgT
         vk9/kSZHMH6u7WOrHm8UXq2xIjNeFdyC77dPnjWOQnOwOqlk4OvjpTUkLodqyVtzl5
         83TkrtHmk+GprKipP+hWghNkre09QTCOZS3nR5X/OYsgCE9uVNrt4DfwMz7rwI9pMG
         wSzsLl261S5PQ==
Date:   Thu, 10 Aug 2023 17:42:26 -0700
From:   Kees Cook <kees@kernel.org>
To:     Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: refactor deprecated strncpy
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFhGd8pa0UFFG3M39YttrfSQj0aO-Xq70XVQpcLM0X6pD9wECQ@mail.gmail.com>
References: <20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com> <202308101155.81497C5B@keescook> <CAFhGd8rfKLY5KujEdvSnqv2MZFhTbEBo_bi7xVacY1pcBC1jRg@mail.gmail.com> <202308101257.47E6ACBD5@keescook> <CAFhGd8pa0UFFG3M39YttrfSQj0aO-Xq70XVQpcLM0X6pD9wECQ@mail.gmail.com>
Message-ID: <4EF40BD8-9FBA-4D01-B2F4-154D32A503EB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 10, 2023 2:17:41 PM PDT, Justin Stitt <justinstitt@google=2Ecom> =
wrote:
>On Thu, Aug 10, 2023 at 12:58=E2=80=AFPM Kees Cook <keescook@chromium=2Eo=
rg> wrote:
>>
>> On Thu, Aug 10, 2023 at 12:25:37PM -0700, Justin Stitt wrote:
>> > On Thu, Aug 10, 2023 at 12:00=E2=80=AFPM Kees Cook <keescook@chromium=
=2Eorg> wrote:
>> > >
>> > > On Thu, Aug 10, 2023 at 06:39:03PM +0000, Justin Stitt wrote:
>> > > > `strncpy` is deprecated for use on NUL-terminated destination str=
ings
>> > > > [1]=2E Which seems to be the case here due to the forceful settin=
g of `buf`'s
>> > > > tail to 0=2E
>> > >
>> > > Another note to include in these evaluations would be "does the
>> > > destination expect to be %NUL padded?"=2E Here, it looks like no, a=
s all
>> > > the routines "buf" is passed to expect a regular C string (padding
>> > > doesn't matter)=2E
>> > >
>> > > >
>> > > > A suitable replacement is `strscpy` [2] due to the fact that it
>> > > > guarantees NUL-termination on its destination buffer argument whi=
ch is
>> > > > _not_ the case for `strncpy`!
>> > > >
>> > > > In this case, there is some behavior being used in conjunction wi=
th
>> > > > `strncpy` that `strscpy` already implements=2E This means we can =
drop some
>> > > > of the extra stuff like `=2E=2E=2E -1` and `buf[len] =3D 0`
>> > > >
>> > > > This should have no functional change and yet uses a more robust =
and
>> > > > less ambiguous interface whilst reducing code complexity=2E
>> > > >
>> > > > Link: www=2Ekernel=2Eorg/doc/html/latest/process/deprecated=2Ehtm=
l#strncpy-on-nul-terminated-strings[1]
>> > > > Link: https://manpages=2Edebian=2Eorg/testing/linux-manual-4=2E8/=
strscpy=2E9=2Een=2Ehtml [2]
>> > > > Link: https://github=2Ecom/KSPP/linux/issues/90
>> > > > Cc: linux-hardening@vger=2Ekernel=2Eorg
>> > > >
>> > > > Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>
>> > > > ---
>> > > > For reference, see a part of `strscpy`'s implementation here:
>> > > >
>> > > > |     /* Hit buffer length without finding a NUL; force NUL-termi=
nation=2E */
>> > > > |     if (res)
>> > > > |             dest[res-1] =3D '\0';
>> > > >
>> > > > Note: compile tested
>> > > > ---
>> > > >  arch/arm64/kernel/idreg-override=2Ec | 5 ++---
>> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
>> > > >
>> > > > diff --git a/arch/arm64/kernel/idreg-override=2Ec b/arch/arm64/ke=
rnel/idreg-override=2Ec
>> > > > index 2fe2491b692c=2E=2E482dc5c71e90 100644
>> > > > --- a/arch/arm64/kernel/idreg-override=2Ec
>> > > > +++ b/arch/arm64/kernel/idreg-override=2Ec
>> > > > @@ -262,9 +262,8 @@ static __init void __parse_cmdline(const char=
 *cmdline, bool parse_aliases)
>> > > >               if (!len)
>> > > >                       return;
>> > > >
>> > > > -             len =3D min(len, ARRAY_SIZE(buf) - 1);
>> > > > -             strncpy(buf, cmdline, len);
>> > > > -             buf[len] =3D 0;
>> > > > +             len =3D min(len, ARRAY_SIZE(buf));
>> > > > +             strscpy(buf, cmdline, len);
>Perhaps keeping the `=2E=2E=2E  - 1` is good because we then don't have t=
o
>check strlen immediately after=2E This does still silently truncate but
>didn't the previous `strncpy` also do that?

Ah, actually there's no need to get too tricky here=2E This should be beha=
viorally identical:

len =3D strscpy(buf, cmdline, ARRAY_SIZE(buf));
if (len =3D=3D -E2BIG)
    len =3D ARRAY_SIZE(buf) - 1;

-Kees


--=20
Kees Cook
