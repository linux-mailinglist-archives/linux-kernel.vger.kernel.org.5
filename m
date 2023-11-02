Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333317DE98D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjKBAlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjKBAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:41:06 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2A6113
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:41:00 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7dd65052aso5516327b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698885660; x=1699490460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXv7lNcUKE/bPvUbNVQ0cVR7ltHedHv7vFfJ1xNnXoo=;
        b=D9no4B2d4cqTGIzHucsVFeKxSN5A9mmIMdqIFPQ4RzAt/VBlLU8VAsOB0wV1fh0xsm
         H/pGzVf4EBLMd92afH6nNZWydrUBamPyPQGA09x25gWCeiCuojHllt3VZKhGgqSZ7JN2
         q2ZJUwqYiKVXBEfkThmZU2HnvWbjFEDOVoK2ywFzJT6aTLhlR0Y36hEgrJfKxZAmvtra
         t/yknTSLg9RmHfFDGoVX/1GkHFCPhER4T8a8fdr95/HnWQs087yaa507YscWGoUlpBP2
         arbLoim6AdpCroVlMlqTCqOYjLwBoZrwy7LMrf4pfW3fXZGqJuYZUCqAC5oAVQ1fkOfs
         NR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698885660; x=1699490460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXv7lNcUKE/bPvUbNVQ0cVR7ltHedHv7vFfJ1xNnXoo=;
        b=WAmFbeVA04euClmMdC4Y1Ddf8+SKoeqGtFo+CUJ1pgcCCjepPicJuzoAeDF2qE/QPG
         P6RcZXxabjLP9NjlgIirqQcAhLwXeUZhZYmOGXxFbE5hT9AlZdc0Ec73iO+/A+aoMTnh
         hP5VXoFdPTK2P4KyeMKn62vf+F7oFrycm0n01+PIHj6OjwWEC5/qQ54hC+gYCE7h6Y9B
         7t1JOnN95n0SaJx9cyHRSDslWs6wluXZnzHoramrLZQZQ2oFlqiYMoVk4XEIOuZ4OY/D
         8EYaounuzxbBtFnh/FnfM7bGrvhr4G2/8tLoTNTXl/XSFdD0hKwp+jrt/6QIijFeg5CQ
         77vw==
X-Gm-Message-State: AOJu0Yw7g7TVJcGmAkvb4Ocx8LM4ZcmoJ2PffkcN65K6MsZCBtKbcVyh
        sTp+Q6nHlL00zRlChktDgkg1hRxSL0GojG0f0THo
X-Google-Smtp-Source: AGHT+IHX5SByOusRzJbw7XlPM3jE3Ppiy/SLY9W8Ke82qVvDL1WHm97FTYfGRSVFyvB1nXe4XZRil3a/EiFE9ySrnAI=
X-Received: by 2002:a25:db13:0:b0:d9c:a3dd:664e with SMTP id
 g19-20020a25db13000000b00d9ca3dd664emr15078806ybf.56.1698885659901; Wed, 01
 Nov 2023 17:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <1696457386-3010-12-git-send-email-wufan@linux.microsoft.com> <85311850a862fe6ccb946634429b890a.paul@paul-moore.com>
In-Reply-To: <85311850a862fe6ccb946634429b890a.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Nov 2023 20:40:49 -0400
Message-ID: <CAHC9VhQHizyP3frH61jQi-8eNeNvg9UcPkvPv6Kk3k7rMsCziQ@mail.gmail.com>
Subject: Re: [PATCH RFC v11 11/19] dm verity: set DM_TARGET_SINGLETON feature flag
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> >
> > The device-mapper has a flag to mark targets as singleton, which is a
> > required flag for immutable targets. Without this flag, multiple
> > dm-verity targets can be added to a mapped device, which has no
> > practical use cases and will let dm_table_get_immutable_target return
> > NULL. This patch adds the missing flag, restricting only one
> > dm-verity target per mapped device.
> >
> > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > ---
> > v1-v10:
> >   + Not present
> > ---
> >  drivers/md/dm-verity-target.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This seems reasonable to me and matches with other users of
> DM_TARGET_IMMUTABLE.
>
> Alasdair, Mike, can we get an ACK on this?

A gentle ping with a reminder ...

For reference, the full patchset can be found on lore at the link below:

https://lore.kernel.org/linux-security-module/1696457386-3010-1-git-send-em=
ail-wufan@linux.microsoft.com/

> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-targe=
t.c
> > index 26adcfea0302..80673b66c194 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -1503,7 +1503,7 @@ int dm_verity_get_root_digest(struct dm_target *t=
i, u8 **root_digest, unsigned i
> >
> >  static struct target_type verity_target =3D {
> >       .name           =3D "verity",
> > -     .features       =3D DM_TARGET_IMMUTABLE,
> > +     .features       =3D DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
> >       .version        =3D {1, 9, 0},
> >       .module         =3D THIS_MODULE,
> >       .ctr            =3D verity_ctr,
> > --
> > 2.25.1

--=20
paul-moore.com
