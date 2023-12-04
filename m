Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F580803F23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjLDUQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjLDUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:16:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA6107;
        Mon,  4 Dec 2023 12:16:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so1221579e87.3;
        Mon, 04 Dec 2023 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720987; x=1702325787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxnz7PaULk+xJC6024GR3t6cngdVEej7qz+5rlPj9m8=;
        b=ISfLnGdRJZDZx1DxneKeXnIxWZvrkJlBu8EIeHeqs5JrisJUxsuAMv7/HbzirDTEmy
         7Xm2Sx1wJo7Za41SZYZ/NnXgDrVT8TeJD6i10c+XNX3dx0MaMLJaJJZlaQEDA/WtVZwg
         unT8yWF6whAhMXu44yMil5qCTEefXucrzSB1d1nq0Nq3OxqmzuaW9yDwWVZO+hQgwyoC
         1v0b/kcqKGRiAydqwxc62njQNNzZgmgujBAvDNfEPRN2bPdQctG4wTRC1GFGMS6KGPJd
         y/GL79dl1eicSXwGnNGsdYcqbk0OK3vDMaqSqguH3aHf+R7WPSueCNBYpQYrYMz8scQb
         W2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720987; x=1702325787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxnz7PaULk+xJC6024GR3t6cngdVEej7qz+5rlPj9m8=;
        b=mxtjHV8zOTZefeKGW4djeuYf5sD4XypKO3coYZ+PJxdv19Jp4atU2RaU5lqSTTl+yR
         NkHC5gweBpHtLRUFcGXG6iV/bSY8R6MTToBIOWAMwk67UbG3i6Ifl+tijiI9GREJJoAR
         bjpIO08t1CybBDb+sLaRfDgOb8LVKbwoow3Fw9M6E29KTdSPTOEpBbASRS5KhZxST8iB
         N/RUokuxZkrZPOBuIZt3hVEJluPaEI2oCXVKHKvVhpT5JYVeJ1DhiTQdV7B2GkVvEQJb
         pYzm9pzobyIhkjS8U8SHlLi3Q7ZnglYmzZDeAEeY3VnoePIfvRiYDtClczPqxR8iO4MA
         DCLg==
X-Gm-Message-State: AOJu0YwAdE4kaT6ogdR7LixZvfxbncLE+j7NvfdZiut6/FrV36Ay4XPE
        gLIluF/nCFo8a9x1n14BVGQgveUHZU+8uQlsUBo=
X-Google-Smtp-Source: AGHT+IFFS/LxkhcJWraSuR+9Wwuyd5MEmhcy+jjsGk3cixWkemQBCHl/a25uxzZBP/ANio2oh1Ic/iD5UrKJJHPb+ho=
X-Received: by 2002:a05:6512:3c9c:b0:50b:f0f2:6cbb with SMTP id
 h28-20020a0565123c9c00b0050bf0f26cbbmr2056549lfv.60.1701720987006; Mon, 04
 Dec 2023 12:16:27 -0800 (PST)
MIME-Version: 1.0
References: <250053.1701698519@warthog.procyon.org.uk>
In-Reply-To: <250053.1701698519@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 4 Dec 2023 14:16:15 -0600
Message-ID: <CAH2r5mu1bg6X5wxMpOxWS4t0XUS5-mY3ENfbm_vEytPce4HQxg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix non-availability of dedup breaking generic/304
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <sfrench@samba.org>,
        Dave Chinner <david@fromorbit.com>,
        Xiaoli Feng <fengxiaoli0714@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Darrick Wong <darrick.wong@oracle.com>,
        fstests@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added missing Signed-off-by line (and also for the two previous
patches from David) and added Cc: stable and tentatively merged into
cifs-2.6.git for-next pending additional testing

On Mon, Dec 4, 2023 at 8:02=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Deduplication isn't supported on cifs, but cifs doesn't reject it, instea=
d
> treating it as extent duplication/cloning.  This can cause generic/304 to=
 go
> silly and run for hours on end.
>
> Fix cifs to indicate EOPNOTSUPP if REMAP_FILE_DEDUP is set in
> ->remap_file_range().
>
> Note that it's unclear whether or not commit b073a08016a1 is meant to cau=
se
> cifs to return an error if REMAP_FILE_DEDUP.
>
> Fixes: b073a08016a1 ("cifs: fix that return -EINVAL when do dedupe operat=
ion")
> Suggested-by: Dave Chinner <david@fromorbit.com>
> cc: Steve French <sfrench@samba.org>
> cc: Xiaoli Feng <fengxiaoli0714@gmail.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Darrick Wong <darrick.wong@oracle.com>
> cc: fstests@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/3876191.1701555260@warthog.procyon.org.uk=
/
> ---
>  fs/smb/client/cifsfs.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 4d8927b57776..96a65cf9b5ec 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1276,7 +1276,9 @@ static loff_t cifs_remap_file_range(struct file *sr=
c_file, loff_t off,
>         unsigned int xid;
>         int rc;
>
> -       if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
> +       if (remap_flags & REMAP_FILE_DEDUP)
> +               return -EOPNOTSUPP;
> +       if (remap_flags & ~REMAP_FILE_ADVISORY)
>                 return -EINVAL;
>
>         cifs_dbg(FYI, "clone range\n");
>
>


--=20
Thanks,

Steve
