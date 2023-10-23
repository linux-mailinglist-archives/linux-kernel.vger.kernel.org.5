Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062F7D2A63
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjJWG1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJWG1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF97DB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698042406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irL60YmVQm+inM4bOCBZqZ+DOm0v1MUiGeZOzWuHLf8=;
        b=KUszNFd6l0sY2zkQ1JQSY3vkaTHaDEUkhYkGkGRewW/gpqnu21x+Kg4Ru6vymn2o6NRY3W
        N8kYJujvXS8fT3YoFEhB4OJnEn3gUibTfCsGWH8soV9cLWlQR05BcL2yobadH5d6QWKe89
        AiOCQuCPXIvlx/ZSF4HsHykeNxeJ9S4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-6ew-CY9gMSS8Ce683leUXg-1; Mon, 23 Oct 2023 02:26:44 -0400
X-MC-Unique: 6ew-CY9gMSS8Ce683leUXg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c503804667so23853501fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698042402; x=1698647202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irL60YmVQm+inM4bOCBZqZ+DOm0v1MUiGeZOzWuHLf8=;
        b=T2g/NN90k2hPcIE8vVRYRAlohKk4p2J3ucegofKwv3V60u5KdpT82/w25b/P8l93oj
         c1HTCloazIsjHo0RKa2lYZB0gEc0GbLOLW/1049uJ6y064hVjHep9B4+cIDAu8T0DEwL
         ++/v8Yj4gREkYIUhDkKnK0pNwPI9HuU4s3knH8+syWHCCKfPBkw+aKJJ6LtVorRQ/ToF
         sQX2JysOWxB5MTKk7cyOsOdLyshVRQKW9POp6IvEdWR29HqKm94SBMziQ6AubYi1gljC
         sRmdMqJVYVWWgNfyf9hzokq+YDtcutCKAEWC4xZBd8Pwjuvl5pEXEX56LeZmG6ykQIRY
         QDCg==
X-Gm-Message-State: AOJu0Yz3Wnz+mwPda7myr8qWpBkSonlrMhZKgWDlhTlWw7I/0gbk76ud
        p7i75DAR4n4IOAFaX7Ra4MXMApWhTEllBpbtJiHFFK/OABIIWpZfMndNkJMJJbRcAu/WU9h9Mf2
        qhVAzWz9QzTQKl1klPdmeTSoZ7DBOpWtxgrDBSTbKmYnbgSV/
X-Received: by 2002:a2e:bb12:0:b0:2bf:6852:9339 with SMTP id v18-20020a2ebb12000000b002bf68529339mr5145604lje.3.1698042402386;
        Sun, 22 Oct 2023 23:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGTqr7Zz6W6oqrrvUbedu2UgHymTNUY5aWBr3OGj9nTiOI48TYzlE38qQkMiyQxgM8VXnDeBfNiqBM07qh/rk=
X-Received: by 2002:a2e:bb12:0:b0:2bf:6852:9339 with SMTP id
 v18-20020a2ebb12000000b002bf68529339mr5145587lje.3.1698042402067; Sun, 22 Oct
 2023 23:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net> <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
In-Reply-To: <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 23 Oct 2023 08:26:30 +0200
Message-ID: <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 8:19=E2=80=AFAM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
>
> On Mon. 23 Oct. 2023 at 11:28, Jonathan Corbet <corbet@lwn.net> wrote:
> > Vincent MAILHOL <mailhol.vincent@wanadoo.fr> writes:
> >
> > > On Thu. 1 June 2023 at 16:53, =C3=8D=C3=B1igo Huguet <ihuguet@redhat.=
com> wrote:
> > >> EditorConfig is a specification to define the most basic code format=
ting
> > >> stuff, and it's supported by many editors and IDEs, either directly =
or
> > >> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > >>
> > >> It allows to define formatting style related to indentation, charset=
,
> > >> end of lines and trailing whitespaces. It also allows to apply diffe=
rent
> > >> formats for different files based on wildcards, so for example it is
> > >> possible to apply different configs to *.{c,h}, *.py and *.rs.
> > >>
> > >> In linux project, defining a .editorconfig might help to those peopl=
e
> > >> that work on different projects with different indentation styles, s=
o
> > >> they cannot define a global style. Now they will directly see the
> > >> correct indentation on every fresh clone of the project.
> > >>
> > >> See https://editorconfig.org
> > >>
> > >> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > >> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> > >> ---
> > >
> > > Is there any news for this patch? I would really love this to become =
mainstream.
> >
> > I have concerns about this patch that I have expressed in the past.
> >
> > I'm not going to apply it... since it's a global change that affects al=
l
> > kernel developers, I don't think I *should* apply it.  I would recommen=
d
> > sending it directly to Linus; if you can get an ack from him, I'll appl=
y
> > it then.
>
> Hi Jonathan,
>
> Thanks for the comment, message taken.
>
> Hi =C3=8D=C3=B1igo,
>
> The last version of the patch being from you, would you like to bring
> the topic to Linus yourself or shall I do it instead?

I'm not doing kernel development lately, so please go ahead pushing
this if you want.

Anyway, note that, as discussed in the thread, it is incorrect to say
that it will affect all kernel developers: most IDEs and editors only
have "opt-in" support for editorconfig, and the few that are not
"opt-in", are either "opt-out" or has a workaround (Kate).

>
>
> Yours sincerely,
> Vincent Mailhol
>


--=20
=C3=8D=C3=B1igo Huguet

