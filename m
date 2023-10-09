Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D37BD3EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbjJIG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbjJIG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:57:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47A1A3;
        Sun,  8 Oct 2023 23:57:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF25C433CB;
        Mon,  9 Oct 2023 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696834670;
        bh=WfMc89OGvQiyW+o0qptkoI9flKRYwOtSlIq18M32yQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KkRUwOLfzXI9SPkP6GKCIofqMZ9JKj9RkT0DMadrPpl3bjV6JbA/zcOpCXIXD3HCr
         DbRul+e5KyKUQO+sNeN/G6t/G1NjW/SW6cEnkXryMN1F6YZQc/k4Z/MIE6F9md3DZJ
         FtckpgMJZK9nydDjH6/TXXNajXBFd3zZbOz9nE0nRWGeZL/94n3p2k7V9AB1mrEsgh
         GPWkf1Y0ZQLRDr0bOPF5G0+OHglejBFDgHrJwT6/i7quzXCbjiWIhwEVTpCRDOIfbu
         kPbRwQk6EXagdLs7nzkQ8D2AxQ51pOwNUWcJUPO3Dee3WrzWl1FNC8YuYkMcx7xRgq
         Vn58dKBusd7hQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6c67060fdfaso2949751a34.2;
        Sun, 08 Oct 2023 23:57:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzw4hZpTvXPz9NtDl/8E1PmPR8HMSyeOIKMEWaPbKupGp9RpYbx
        0TrnnT9bEHqKwxdr67/ZOAqPUz5d6KFfXH764Y8=
X-Google-Smtp-Source: AGHT+IGMOGZBw2soP3TkVZNtoWBL1sfXMy+9ml8XcydjSeLYM7BQdD/aczv6M2evuS8JB4Kh1OcM12cPDT01T+L1m8I=
X-Received: by 2002:a05:6870:56ac:b0:1d5:a3b5:d89c with SMTP id
 p44-20020a05687056ac00b001d5a3b5d89cmr16414304oao.3.1696834669675; Sun, 08
 Oct 2023 23:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231007170448.505487-1-masahiroy@kernel.org> <CAFA6WYNqe-e_ZqbxXW5BcmMOxQr42mdJV-o4W4U4XcOsPe0P+Q@mail.gmail.com>
In-Reply-To: <CAFA6WYNqe-e_ZqbxXW5BcmMOxQr42mdJV-o4W4U4XcOsPe0P+Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Oct 2023 15:57:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAPYAUQsKEp9Z-Bm=wJgb_Cebg02K26XGNz=j2Rgajag@mail.gmail.com>
Message-ID: <CAK7LNASAPYAUQsKEp9Z-Bm=wJgb_Cebg02K26XGNz=j2Rgajag@mail.gmail.com>
Subject: Re: [PATCH 1/5] modpost: fix tee MODULE_DEVICE_TABLE built on big
 endian host
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 3:27=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> Hi Masahiro,
>
> On Sat, 7 Oct 2023 at 22:34, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > When MODULE_DEVICE_TABLE(tee, ) is built on a host with a different
> > endianness from the target architecture, it results in an incorrect
> > MODULE_ALIAS().
> >
> > For example, see a case where drivers/char/hw_random/optee-rng.c
> > is built as a module.
> >
> > If you build it on a little endian host, you will get the correct
> > MODULE_ALIAS:
> >
> >     $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
> >     MODULE_ALIAS("tee:ab7a617c-b8e7-4d8f-8301-d09b61036b64*");
> >
> > However, if you build it on a big endian host, you will get a wrong
> > MODULE_ALIAS:
> >
> >     $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
> >     MODULE_ALIAS("tee:646b0361-9bd0-0183-8f4d-e7b87c617aab*");
> >
> > This issue has been unnoticed because the ARM kernel is most likely bui=
lt
> > on a little endian host (cross-build on x86 or native-build on ARM).
> >
> > The uuid field must not be reversed because uuid_t is an array of __u8.
> >
>
> To me it wasn't obvious that DEF_FIELD() has certain endianness limitatio=
ns.
>
> > Fixes: 0fc1db9d1059 ("tee: add bus driver framework for TEE based devic=
es")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/file2alias.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > index 7056751c29b1..70bf6a2f585c 100644
> > --- a/scripts/mod/file2alias.c
> > +++ b/scripts/mod/file2alias.c
> > @@ -1348,13 +1348,13 @@ static int do_typec_entry(const char *filename,=
 void *symval, char *alias)
> >  /* Looks like: tee:uuid */
> >  static int do_tee_entry(const char *filename, void *symval, char *alia=
s)
> >  {
> > -       DEF_FIELD(symval, tee_client_device_id, uuid);
>
> As you have mentioned in patch #3: the limitations of TO_NATIVE(), if
> you can update comments for DEF_FIELD() as well to make it clear that
> it doesn't support byte arrays/strings would be helpful. I think the
> following check that you have introduced in patch #3 can still be
> bypassed for byte arrays/strings.
>
> + _Static_assert(sizeof(x) =3D=3D 1 || sizeof(x) =3D=3D 2 || \
> +       sizeof(x) =3D=3D 4 || sizeof(x) =3D=3D 8, "bug");




I am afraid you missed the point.

bswap_2, bswap_4, bswap_8 do not take a pointer.

If you pass an array or a string,
it will result in a build error
due to the compiler's prototype checking.

The kbuild test robot will catch a build error anyway.


"You cannot build it in the first place"
is better than a comment.










> BTW, for this fix feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit
>
> > +       DEF_FIELD_ADDR(symval, tee_client_device_id, uuid);
> >
> >         sprintf(alias, "tee:%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x=
-%02x%02x%02x%02x%02x%02x",
> > -               uuid.b[0], uuid.b[1], uuid.b[2], uuid.b[3], uuid.b[4],
> > -               uuid.b[5], uuid.b[6], uuid.b[7], uuid.b[8], uuid.b[9],
> > -               uuid.b[10], uuid.b[11], uuid.b[12], uuid.b[13], uuid.b[=
14],
> > -               uuid.b[15]);
> > +               uuid->b[0], uuid->b[1], uuid->b[2], uuid->b[3], uuid->b=
[4],
> > +               uuid->b[5], uuid->b[6], uuid->b[7], uuid->b[8], uuid->b=
[9],
> > +               uuid->b[10], uuid->b[11], uuid->b[12], uuid->b[13], uui=
d->b[14],
> > +               uuid->b[15]);
> >
> >         add_wildcard(alias);
> >         return 1;
> > --
> > 2.39.2
> >



--
Best Regards
Masahiro Yamada
