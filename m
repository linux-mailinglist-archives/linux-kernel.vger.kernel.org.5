Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3207E98D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjKMJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMJZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:25:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57D10D2;
        Mon, 13 Nov 2023 01:25:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-407da05f05aso31093925e9.3;
        Mon, 13 Nov 2023 01:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699867512; x=1700472312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3/evD/xaoF543UV7hJCiw9gNPQF7YDdq7P3hZjA/Xk=;
        b=QWomP6N9eE8ZJEuetj6w2VJXi3o37A7UgBTMHeNy9wx57ObFSk/boeK75JR1kImvjc
         jZSNkJZGgu6WWzA3in4z+3Rv9syxAahG1+BgfnN3iwx00Y9nzR1eeJfWzKDjFa4IcE3I
         Q2vx6NQvEhfzG+twGsPper45uFQn5h7RC4jrP6c1AwDGvt20Zk8zOd7vVgqvaPxVNThX
         C1xDelwJSD9hiiLmKE927/92C7cYEwSSbQJdE4gEoy0AUHFpl6+XrzXvY7Ou4YTtmmry
         T8xHCLvi9oC3yyVDTnrosmrpGE84i3YveX4fqk6OJ+PcoWTLoOH6vDBl1am2VtzetTNC
         pnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699867512; x=1700472312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3/evD/xaoF543UV7hJCiw9gNPQF7YDdq7P3hZjA/Xk=;
        b=g3GMUllXZ+D65vk6SmBMszmo13ANgbVhD5tViuW/uohFtGlmRJ8HnkQmI69IiippX4
         7OrWOYZfSg4/adu+/9b8aB6fidr8m/lGsYZgtH9WeboqnOjtTAmmyBkRJ8xwYXPBIDus
         7mxRwMsyDzBVDDC7ipC166rGOiC33k+4pk0d3p+UPkQiDgzN3D/Kd3ujfzR2CpeS8FNe
         fTV95ciuh95IehTgtfoFAwmV4NYUskXRT4mRcmA4xt39OMvPfDoqbgfXsFO1uimNK4+m
         n7Tag9kNgjMd1/9YXyW0/jAoW2qgfWDUY0/b+iEyk/81G8TwV1rJMGzS4R8WYQkhvino
         wfMQ==
X-Gm-Message-State: AOJu0Yx/BZy7OyCgU2yArQgngQMJbsbMcw8tOj8AML5hfOo7FWTU8mhE
        L2k0JZhqXhiurkqXtu/lBM42T0x8XEAAjjZJfgGMW/Gr
X-Google-Smtp-Source: AGHT+IGG3e0ULTHpPoQfTWqsbEv9x4DhbnlAWOPX8Bv+hYP5jcQhKwySKiY/k4P5DVifDlV86kzKA4WiDh69n/qlojc=
X-Received: by 2002:adf:a414:0:b0:32d:8872:aac8 with SMTP id
 d20-20020adfa414000000b0032d8872aac8mr4817978wra.31.1699867512315; Mon, 13
 Nov 2023 01:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20231112095353.579855-1-debug.penguin32@gmail.com> <2655833.BddDVKsqQX@oscar>
In-Reply-To: <2655833.BddDVKsqQX@oscar>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Mon, 13 Nov 2023 19:25:01 +1000
Message-ID: <CALk6UxoRHWsJYuTcqg7zvf5rxGwMQymMpjGuSEw3d+syAVyt=g@mail.gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
To:     Anders Larsen <al@alarsen.net>
Cc:     keescook@chromium.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Niek Nooijens <nieknooijens@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 2:16=E2=80=AFAM Anders Larsen <al@alarsen.net> wrot=
e:
>
> On 2023-11-12 10:53 Ronald Monthero wrote:
> > qnx4 dir name length can vary to be of maximum size
> > QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> > 'link info' entry is stored and the status byte is set.
> > So to avoid buffer overflow check di_fname length
> > fetched from (struct qnx4_inode_entry *)
> > before use in strlen to avoid buffer overflow.
>
> [snip]
>
> >
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > ---
> >  fs/qnx4/namei.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> > index 8d72221735d7..825b891a52b3 100644
> > --- a/fs/qnx4/namei.c
> > +++ b/fs/qnx4/namei.c
> > @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
> >       } else {
> >               namelen =3D QNX4_SHORT_NAME_MAX;
> >       }
> > +
> > +     /** qnx4 dir name length can vary, check the di_fname
> > +      * fetched from (struct qnx4_inode_entry *) before use in
> > +      * strlen to avoid panic due to buffer overflow"
> > +      */
> > +     if (strnlen(de->di_fname, namelen) >=3D sizeof(de->di_fname))
> > +             return -ENAMETOOLONG;
>
> sizeof(de->di_fname) equals QNX4_SHORT_NAME_MAX, so this test fails as so=
on as
> a filename is longer than that!

I suppose de->di_fname can be QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX isn't it=
 ?
It's set based on di_status, if di_status is set, then it will be
QNX4_NAME_MAX and otherwise QNX4_SHORT_NAME_MAX.
We capture that into namelen, prior to the  string length check  - if
(strnlen(de->di_fname, namelen) >=3D sizeof(de->di_fname))
as below:

        de =3D (struct qnx4_inode_entry *) (bh->b_data + *offset);
        *offset +=3D QNX4_DIR_ENTRY_SIZE;
        if ((de->di_status & QNX4_FILE_LINK) !=3D 0) {
                namelen =3D QNX4_NAME_MAX;
        } else {
                namelen =3D QNX4_SHORT_NAME_MAX;
        }

BR,
Ron


> This quick fix (untested!) should do the trick (and avoids computing the =
length
> of the name twice):
>
> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> index 8d72221735d7..7694f86fbb2e 100644
> --- a/fs/qnx4/namei.c
> +++ b/fs/qnx4/namei.c
> @@ -40,9 +40,7 @@ static int qnx4_match(int len, const char *name,
>         } else {
>                 namelen =3D QNX4_SHORT_NAME_MAX;
>         }
> -       thislen =3D strlen( de->di_fname );
> -       if ( thislen > namelen )
> -               thislen =3D namelen;
> +       thislen =3D strnlen(de->di_fname, namelen);
>         if (len !=3D thislen) {
>                 return 0;
>         }
>
> Cheers
> Anders
>
>
