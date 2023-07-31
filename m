Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8276A07A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGaSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjGaSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615F219BB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690828413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mleMDQBlgoEZn6B2n7OWtI7BglzC5H6dpI6VTr1crBc=;
        b=I5ElABZZcU4b2LNaHngPVW0vqGoAe+E1wrkPZaRI8kgUTML1KfJ4ODcck+SY2gfqGxM1Zr
        0jewAsKOUNeQuG3xfh9nTJ9USdcuAmCSZtM5tKIjSWq4GuaCk8/RVSbcsOwRQAaFyLl5mx
        2YyOWiokhUrWniICQXYXleD13Uxkx3E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-8xkPxy5RNWKD6BNIIH0biA-1; Mon, 31 Jul 2023 14:33:30 -0400
X-MC-Unique: 8xkPxy5RNWKD6BNIIH0biA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cfc4ebcecso45884336d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690828410; x=1691433210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mleMDQBlgoEZn6B2n7OWtI7BglzC5H6dpI6VTr1crBc=;
        b=WH596NFd08QZm6gFWNzTu7Oz0Qu6vXVrgcuqd9crnVGZf2ns29Guxwn/sZ3eu1HdEG
         qu2u8LtvjmRrpPn3/SoK1ogAd7Kj2srN9lnjPJFgXpCghetBTESk+KSevilVOH9wfYUX
         8oj/E3X1rhsXEYBzR/8g6Bf0/09A2zJ2R3aIWuuuzXsHOQzOy8MNRoGWmmMUTiuPQTJQ
         Vgs6gQxwB6jjZEPRDIZ1D0eypaeg1qucCs9MRxb6FkHETS3XCTf5F3eU/WY0CJx5unPw
         SP4+E4i7YDSGFbo2tmo8GgYAayCc40UfYVgtT0pa3jPKIB4eGFmo3ZAM3nuM0mRvMMm2
         qexA==
X-Gm-Message-State: ABy/qLYNT/pLT3vz4BgIi1wNI1huaAcoX9jtukENaUEklpiZOKcRDMwI
        Sssofn2f5JSE2cV44o3asrX9NY+LSBIwaruDEBigc/S9321XNv9fiXnRKacq/wBjSxumxtF2Wlb
        7zWdloUalx9L4Fi3yTB0e382W
X-Received: by 2002:a05:622a:351:b0:40f:c60d:1c83 with SMTP id r17-20020a05622a035100b0040fc60d1c83mr2424578qtw.56.1690828410159;
        Mon, 31 Jul 2023 11:33:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVqxAPHbbF9CG2rIbBplT4RyiBtuHUbABbvDsfVIW7zQzqhMEzkG7Pghosa3oaDqJmkEDMPA==
X-Received: by 2002:a05:622a:351:b0:40f:c60d:1c83 with SMTP id r17-20020a05622a035100b0040fc60d1c83mr2424554qtw.56.1690828409888;
        Mon, 31 Jul 2023 11:33:29 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id ez3-20020a05622a4c8300b003f7fd3ce69fsm1234168qtb.59.2023.07.31.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 11:33:29 -0700 (PDT)
Message-ID: <a44acf6edf8714f9e247e8de371d0f00521ec6b5.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] scsi: qedf: sanitise uaccess
From:   Laurence Oberman <loberman@redhat.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Laight <David.Laight@ACULAB.COM>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>, Rob Evers <revers@redhat.com>
Date:   Mon, 31 Jul 2023 14:33:28 -0400
In-Reply-To: <20230731084034.37021-1-oleksandr@redhat.com>
References: <20230731084034.37021-1-oleksandr@redhat.com>
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

On Mon, 2023-07-31 at 10:40 +0200, Oleksandr Natalenko wrote:
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
> Changes since v1 [1]:
>=20
> =C2=A0 * use scnprintf() for on-stack buffers too
> =C2=A0 * adjust an on-stack buffer size in qedf_dbg_debug_cmd_read() to b=
e
> a
> =C2=A0=C2=A0=C2=A0 multiple of 8, and also size it properly
> =C2=A0 * accumulate acks and reviews
>=20
> [1]
> https://lore.kernel.org/lkml/20230728065819.139694-1-oleksandr@redhat.com=
/
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
In case it's needed

For the series v2 against 6.5-rc3
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>

Test notes

Linux segstorage5 6.5.0-rc3+

[root@segstorage5 qedf]# cd host2
[root@segstorage5 host2]# ls
clear_stats  debug  driver_stats  fp_int  io_trace  offload_stats=20
stop_io_on_error

[root@segstorage5 host2]# cat stop_io_on_error
false

[root@segstorage5 host2]# cat fp_int

Fastpath I/O completions

#0: 844
#1: 990
#2: 1036
#3: 1116
#4: 953
#5: 822
#6: 882
#7: 1073
#8: 1030
#9: 992
#10: 789
#11: 705
#12: 490
#13: 532
#14: 646
#15: 705

[root@segstorage5 host2]# cat debug
debug mask =3D 0x2



