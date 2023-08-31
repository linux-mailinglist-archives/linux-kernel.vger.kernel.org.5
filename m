Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE35F78F33E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347126AbjHaTVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHaTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:21:02 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674F1BF;
        Thu, 31 Aug 2023 12:20:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d78328bc2abso898746276.2;
        Thu, 31 Aug 2023 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693509658; x=1694114458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wbzlv8disLj7A2gUnosYJ6WIjChVtdbBfyuqGrNqa0=;
        b=fkNihbxsjFiO4Yy/ALBTB9j0MoeafVGBRDXPZqDPCGVDTjb8xwUXyTh5ym7mrHNYJB
         u8D9H1tdrmRvRprxnS+sHBsUvnUzKKctLWt2TPGr9l4ClrbkSYjo1LGXbxSmv9XD8RmC
         8JzZ3TEhEDAVtD2ePnXqsitwFyBBV5pDeJD9NI2e0UZGq33NO0dZ8dUiLTrxj9Do+3GA
         zsie4gd8Nr7lgIdW08iEyRuYfjHeOEDBq3y3AfEOuu+qlJjA7ohkU5HcdVD/TO1kGXO8
         fyqogyBWbCFN8BBUH6j/Lg64N6DQi1BIqTUMbL/wWALuGo/ewb6AX7Z6scJ2tOiWB3oI
         h9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509658; x=1694114458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wbzlv8disLj7A2gUnosYJ6WIjChVtdbBfyuqGrNqa0=;
        b=LN4aRJ6URBgN5ZaUszAk5CrF8o6a0VHM6KR0OwNHtpep3d7CesP3dRH3MtEtRtgpdz
         9NE2oPac+adqv+FcQ1SsVpRLybgC3IlnbpU5a3qy1egL9yCsYgVPvhAtNaMmEqBX/GS5
         ICYWwHP0P24NcJeBLq9ubS/eytMGrIevJ7M9UTwI/hPsr2yqB+9B4fVuYi9cSrOvddMX
         +cMaG0tSCePZPIdCo8Sahac2Hzi9F0z35LfN+OjBg31L86XxSeSolJ5NnnoKv4JsczLF
         mVGTYvg1HMF01aRl/nVHI76ojSjw901r5Jt/E5CsH+0Q9Iveox/Cgt42bwcZ0htYDxfG
         Te+Q==
X-Gm-Message-State: AOJu0Yw0HqMZB0RST83xh+pRTa1xAsZGbYHjrmPwMbe0KVQFwJe3/Ihq
        Af6fCpJDxiE+c8oY7aySsl2T9SWTSMM8VY5bff0=
X-Google-Smtp-Source: AGHT+IHl6H0dFLAY5n6rn7XFWLhdwzVwte2RPpdn+27DZ1cDaeeuhCKyhKciDpVZBdZt0OkaJexx5vGijFlvi9AJwM8=
X-Received: by 2002:a25:6d89:0:b0:d10:e6a2:1947 with SMTP id
 i131-20020a256d89000000b00d10e6a21947mr587569ybc.19.1693509658624; Thu, 31
 Aug 2023 12:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230831143638.232596-1-azeemshaikh38@gmail.com> <202308311141.612BF8D@keescook>
In-Reply-To: <202308311141.612BF8D@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 31 Aug 2023 15:20:47 -0400
Message-ID: <CADmuW3XpGR-jzq0SP8wVp+W3ZXZ9hgLpNrLrEox0K3Pyw5kfXg@mail.gmail.com>
Subject: Re: [PATCH v3] scsi: target: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 2:42=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Aug 31, 2023 at 02:36:38PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since return value of -errno
> > is used to check for truncation instead of sizeof(dest).
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> > v3:
> >  * Address readability comment.
> >
> > v2:
> >  * Replace all instances of strlcpy in this file instead of just 1.
> >  * https://lore.kernel.org/all/20230830210724.4156575-1-azeemshaikh38@g=
mail.com/
> >
> > v1:
> >  * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@g=
mail.com/
> >
> >  drivers/target/target_core_configfs.c |   24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/tar=
get_core_configfs.c
> > index 936e5ff1b209..d5860c1c1f46 100644
> > --- a/drivers/target/target_core_configfs.c
> > +++ b/drivers/target/target_core_configfs.c
> > @@ -1392,16 +1392,16 @@ static ssize_t target_wwn_vendor_id_store(struc=
t config_item *item,
> >       /* +2 to allow for a trailing (stripped) '\n' and null-terminator=
 */
> >       unsigned char buf[INQUIRY_VENDOR_LEN + 2];
> >       char *stripped =3D NULL;
> > -     size_t len;
> > +     ssize_t len;
> >       ssize_t ret;
> >
> > -     len =3D strlcpy(buf, page, sizeof(buf));
> > -     if (len < sizeof(buf)) {
> > +     len =3D strscpy(buf, page, sizeof(buf));
> > +     if (len > 0) {
> >               /* Strip any newline added from userspace. */
> >               stripped =3D strstrip(buf);
> >               len =3D strlen(stripped);
> >       }
> > -     if (len > INQUIRY_VENDOR_LEN) {
> > +     if (len < 0 || len > INQUIRY_VENDOR_LEN) {
>
> Agh, sorry I missed this before: the first "if" needs to be "len >=3D 0"
> otherwise this:
>
>         ret =3D target_check_inquiry_data(stripped);
>
> will be passing a NULL pointer...
>

Hmm, the current implementation of strscpy never returns 0. If
sizeof(buf) is 0, it'll return -E2BIG. Do you still prefer that I
update this to check for len >=3D 0?
