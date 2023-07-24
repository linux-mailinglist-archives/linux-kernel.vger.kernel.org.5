Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E675F7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGXNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGXNEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF691BCA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690203818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEJ6IysLEVDYiwm532bzJf6jnAfliZIGqES1lq/hZi0=;
        b=HOOXAnockTcL6+T3HINqp/LaE6S7v7QgllRQTRT0aJqLFy5pf+Po/318QPkx4UUSvzTkRe
        g97j9feTnJmU9LjgrLtqSPM+8HszRp8lLd1tTjDThadUGLD5yHo4cOSfYSkrlclIDlQVw2
        9jEOKPZIBluLS0uQCSxtbUQIZiboqmE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-dEf4Z_UvMASkaJlSWpnJvw-1; Mon, 24 Jul 2023 09:03:35 -0400
X-MC-Unique: dEf4Z_UvMASkaJlSWpnJvw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-d07cb52a768so2549062276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690203814; x=1690808614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEJ6IysLEVDYiwm532bzJf6jnAfliZIGqES1lq/hZi0=;
        b=ceR16BVLFlB+NKVzOjjXD5nt6LU70LFXn2SIrfljnSQzq4++0Dc6rvcY/zj/blivOM
         GXHtg9gHbl2aszKAE2lO2xoXTvK7pzlTq+CWt1clY9hVzMFnV9YaIjPD5xm+/5x9Xu4m
         Dp50Ut1079BLwyoB8hd/YWhphzeSHu2qo/4ri8hZcwJcBeMZDFeVEMKp1I55+OOu7sM0
         N28fsd58is2KWnu5WWk7utqkIVzUMGdMiH5N8USamyLz5JtEDGw7Aybeqk9kfaFeulTt
         HZ/DPXK/lGIraNPAw0zr20pigzRSINRr2A2TsId3eSL1C9J3ofQbaCamN/5yUJTiPYe8
         GF0g==
X-Gm-Message-State: ABy/qLZZKQ5Xqz6JRUPcCK6LgMfH1NJGb+V/Je96glSgW5vi2tU3eMFB
        BvsX+lsxNQ/aIn21Qts8mCnB+R2F+omHCO6P5wyUsU5UwPKsN5LkRyt+c5Ef19ImhzXnbH2nkFq
        wGqWSC+X7hOEg/dyPEAgFVvqT
X-Received: by 2002:a25:ae97:0:b0:d07:707c:1106 with SMTP id b23-20020a25ae97000000b00d07707c1106mr5350069ybj.56.1690203814515;
        Mon, 24 Jul 2023 06:03:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkX3XaANJLoQSKhen0rqgYiUyzj6pKZ7KkNfDO6m741yPghbjqd55kIezgH7LpvU9avI+9fQ==
X-Received: by 2002:a25:ae97:0:b0:d07:707c:1106 with SMTP id b23-20020a25ae97000000b00d07707c1106mr5350033ybj.56.1690203814112;
        Mon, 24 Jul 2023 06:03:34 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id 8-20020a250108000000b00cc567b3a869sm2328751ybb.6.2023.07.24.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:03:33 -0700 (PDT)
Message-ID: <dd7c6170def7159b558b79d34520c3d5290e36b9.camel@redhat.com>
Subject: Re: [RFC PATCH 0/3] scsi: qedf: sanitise uaccess
From:   Laurence Oberman <loberman@redhat.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>, Rob Evers <revers@redhat.com>
Date:   Mon, 24 Jul 2023 09:03:32 -0400
In-Reply-To: <20230724120241.40495-1-oleksandr@redhat.com>
References: <20230724120241.40495-1-oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-24 at 14:02 +0200, Oleksandr Natalenko wrote:
> qedf driver, debugfs part of it specifically, touches __user pointers
> directly for printing out info to userspace via sprintf(), which may
> cause crash like this:
>=20
> BUG: unable to handle kernel paging request at 00007ffd1d6b43a0
> IP: [<ffffffffaa7a882a>] string.isra.7+0x6a/0xf0
> Oops: 0003 [#1] SMP
> Call Trace:
> =C2=A0[<ffffffffaa7a9f31>] vsnprintf+0x201/0x6a0
> =C2=A0[<ffffffffaa7aa556>] sprintf+0x56/0x80
> =C2=A0[<ffffffffc04227ed>] qedf_dbg_stop_io_on_error_cmd_read+0x6d/0x90
> [qedf]
> =C2=A0[<ffffffffaa65bb2f>] vfs_read+0x9f/0x170
> =C2=A0[<ffffffffaa65cb82>] SyS_pread64+0x92/0xc0
>=20
> Avoid this by preparing the info in a kernel buffer first, either
> allocated on stack for small printouts, or via vmalloc() for big
> ones,
> and then copying it to the userspace properly.
>=20
> I'm not sure how big the vmalloc()'ed buffer should be, and also
> whether
> vmalloc()'ing it directly in the _read() function is a good idea,
> hence
> RFC prefix.
>=20
> The qedf_dbg_stop_io_on_error_cmd_read()-related patch is actually
> tested,
> the rest is compile-tested only.
>=20
> Oleksandr Natalenko (3):
> =C2=A0 scsi: qedf: do not touch __user pointer in
> =C2=A0=C2=A0=C2=A0 qedf_dbg_stop_io_on_error_cmd_read() directly
> =C2=A0 scsi: qedf: do not touch __user pointer in
> qedf_dbg_debug_cmd_read()
> =C2=A0=C2=A0=C2=A0 directly
> =C2=A0 scsi: qedf: do not touch __user pointer in
> qedf_dbg_fp_int_cmd_read()
> =C2=A0=C2=A0=C2=A0 directly
>=20
> =C2=A0drivers/scsi/qedf/qedf_dbg.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0drivers/scsi/qedf/qedf_debugfs.c | 35 +++++++++++++++++++----------=
-
> --
> =C2=A02 files changed, 23 insertions(+), 14 deletions(-)
>=20
> --
> 2.41.0
>=20

I will test the series, the one patch was already tested.
This was reproduced in our LAB
Will report back after testing

Regards
Laurence

