Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05607806224
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbjLEWuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbjLEWuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:50:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F76A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:50:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AF0C433C7;
        Tue,  5 Dec 2023 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701816615;
        bh=5x+DUlQVMX4rI7C/lbZIjEUnEMm9TF3RtDPL84aa0IY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qzUuzTyXqMMGkKhJrn0avRKUlTtuVRfv/LG3aS+yYIyilDbFJlKiPBV4QT/OhAyvB
         REmuJ97m0Ki7HhmIxYX3L0D26m+YeruHvP8BYlXfZ/dLY8ucBjEP9+vKTPwP2J16xT
         KJpUroGmXr/ssEPipGeyjd5M1TGe8ld645GkOxgYCpbF+igL01H3sKvrGZ1aUpweC0
         AiGMUlNIrvmDafNTG/4O/n/dCNabro47BUi6/sMduEXxnnqyGfbIK98p9vzNHWBSiE
         4p+AHuLGe3tttS3KUX7Uhu+5fAh1zA6Af0RHboehlcZ6Ei3k14EB1vKs92lYRSGUX+
         vHBVzdrjsfZ8w==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so64358935e9.3;
        Tue, 05 Dec 2023 14:50:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyrjV7ARNHYi6uLmFHCb+25xQIkJBRIdgTKuUF3uH0lwyuGqtEO
        jNTQYL7/YdDrM+YyW4T225zRVA9f1OANIaZIJJs=
X-Google-Smtp-Source: AGHT+IGYT2ppXKePS26ax/2UBvv5gM94PgtHGfQeEYRZVI9vMWhldLMI2tj8QziTQ3Nn5fTMlBxU2W7RMAXv7ppzCbE=
X-Received: by 2002:a05:600c:3093:b0:40b:5e59:da99 with SMTP id
 g19-20020a05600c309300b0040b5e59da99mr21446wmn.172.1701816614079; Tue, 05 Dec
 2023 14:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net> <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
 <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
In-Reply-To: <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 5 Dec 2023 14:50:01 -0800
X-Gmail-Original-Message-ID: <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
Message-ID: <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 2:41=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> > On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Wei=C3=9Fschuh wrote:
> > > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, str=
uct ctl_table_header *header)
> > >             return -EROFS;
> > >
> > >     /* Am I creating a permanently empty directory? */
> > > -   if (sysctl_is_perm_empty_ctl_header(header)) {
> > > +   if (header->ctl_table =3D=3D sysctl_mount_point ||
> > > +       sysctl_is_perm_empty_ctl_header(header)) {
> > >             if (!RB_EMPTY_ROOT(&dir->root))
> > >                     return -EINVAL;
> > >             sysctl_set_perm_empty_ctl_header(dir_h);
> >
> > While you're at it.
>
> This hunk is completely gone in v3/the code that you merged.

It is worse in that it is not obvious:

+       if (table =3D=3D sysctl_mount_point)
+               sysctl_set_perm_empty_ctl_header(head);

> Which kind of unsafety do you envision here?

Making the code obvious during patch review hy this is needed /
special, and if we special case this, why not remove enum, and make it
specific to only that one table. The catch is that it is not
immediately obvious that we actually call
sysctl_set_perm_empty_ctl_header() in other places, and it begs the
question if this can be cleaned up somehow.

  Luis
