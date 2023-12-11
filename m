Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F980CE47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjLKOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjLKOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:24:40 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0785E6A54
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:16:02 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b72192f7a1so45270239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702304161; x=1702908961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t6Kg8pIpLZHaK6XOkgWPBGzWw2hTG8f77u5RaPHsCM=;
        b=Lgl9Ls0OWZyaHHPV8pla+sOQEFOebs/RqTn5W/Y4Hsm+icH7P7tPCer3zmnGk4aINb
         nTiSx3itWA1fOrneZ/4RxxsLUZCT7iSqNusS1PsayHnWxCLaGNxqsOQH8pIwQQzxEGlK
         Tsw69Yku8EcLCx0zif3FOLW95/1j4my6ce3Pwjl+pwv5P1AfGdpPBDjACLQhVROMGGw/
         EsvVf9o9fzbNH4+o6/Xy/wb50TLtxYJ/m/gV+U98/FxfCmr+ma2R3QWoO2sy8aVA5TcE
         VSb/PehmZjLAcLcfQDQO5Tlrermhk7G8Fu5gPC00RcKyEKaQTB+D0CzYpAY5svcQy6NM
         N2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304161; x=1702908961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t6Kg8pIpLZHaK6XOkgWPBGzWw2hTG8f77u5RaPHsCM=;
        b=Gz3mK9YjpJm9zouzGzeC7unHioabgqh8fDkB5KPAFgoMpQHS+7pjwDCKnEVbXQGsDP
         4wEAJhsbVsFgAI9T57RCrBMg8Kqn6WlEr48J2ogtQ8gfUKKwz9j+bTZBcZJp9Gpi26cM
         kjJJQjBAdBJDdEqBc5HrwC1lp6Y7+N4DfFipXEId1MwGs1IZnf74++3vdQpoRvMBl07B
         MkPB5PNeJO6QdNBV5fumXw4vJMOBphD53AWpS+9rGyPCp+RPdV0m8rDTeYXmLzPMOLFz
         aU1QPtAmCOz/Sa3kXoriwHx73l05zMMABdzh0huC51lPTvzabaux+vNTS+Kvo1agYLFB
         vOHg==
X-Gm-Message-State: AOJu0Yzv4FFH/FEN4BCJ6NA5SnS6B2Fmi49RVapULpo1cxQngPvby9Qq
        LAK1Qx21tG9XwMkLbJU5BdmOKL5eiYf/g4lLABM=
X-Google-Smtp-Source: AGHT+IGAViM39vfI6E45frCKq5/PpojjvyeQJir0lgGGVehAxWi7iTYdNZFN/dv4wSv/vv8VPOH315eHAokw1/UFMdw=
X-Received: by 2002:a05:6e02:148a:b0:35d:3d59:b3f7 with SMTP id
 n10-20020a056e02148a00b0035d3d59b3f7mr4443201ilk.8.1702304161113; Mon, 11 Dec
 2023 06:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20231211052850.3513230-1-debug.penguin32@gmail.com>
In-Reply-To: <20231211052850.3513230-1-debug.penguin32@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 11 Dec 2023 09:15:50 -0500
Message-ID: <CAKEwX=MzkBt1F2WZaacuCQ+E6eWt1AKvbGZ6JFHy5tkoYigqQg@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     sjenning@redhat.com, akpm@linux-foundation.org,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 9:31=E2=80=AFPM Ronald Monthero
<debug.penguin32@gmail.com> wrote:
>
> Use alloc_workqueue() to create and set finer
> work item attributes instead of create_workqueue()
> which is to be deprecated.
>
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  mm/zswap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 74411dfdad92..64dbe3e944a2 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
>                 zswap_enabled =3D false;
>         }
>
> -       shrink_wq =3D create_workqueue("zswap-shrink");
> +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 0);

Hmmm this changes the current behavior a bit right? create_workqueue()
is currently defined as:

alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))

I think this should be noted in the changelog, at the very least, even
if it is fine. We should be as explicit as possible about behavior
changes.



>         if (!shrink_wq)
>                 goto fallback_fail;
>
> --
> 2.34.1
>
>
