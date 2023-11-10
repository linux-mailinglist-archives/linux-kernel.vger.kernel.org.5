Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B67E8016
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjKJSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjKJSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:44 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AC6FA8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:25:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c603e2354fso349461966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699597546; x=1700202346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31LtcSKpeisTVB2mz3N5vJ0iqQnYWaagnM9xZbOW8hI=;
        b=JyjzjcwauyTtcqhBS8UvrLRTbz/zUtlAfQ/ZBJxVLh76smFgqA+WZ7GuiZ813f1BVl
         ngJOkXJaeOON3kqLxp94JoTUjLr+38G0uBJ7+8lZ0nM8PZD+vWMQt7msWN06gtq+wqDD
         dZBhYBz1HsnaKdMzAgMyFYHJbxaLepMG+D9DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597546; x=1700202346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31LtcSKpeisTVB2mz3N5vJ0iqQnYWaagnM9xZbOW8hI=;
        b=RblFVsWmp0kAqcK+pP5abRDp90vsUyPpbcP3DvF/ULWwh7mwGsv5o1N/BPIux9jrF6
         k8I2rHrh9GMrSPazQgYjP/R/Hw/T45xp26RF6j3r9hizQwCwXSsie13HNisfDHM6/Xj/
         Mjxy4Ltj0kgbFsolcU8Kr11a7ZY1j2pa+PN0n7WlWevF7IKNhplvSfMuOrnuB9+VjmmI
         zawRT17GOkoOaDHZdKb4YB6F2v0fXorEvtRiv5gkXT4xOYalu+vIgDsN8OjfE/jphhWF
         gGQWcYYtk5GKPBvkW6McvxjmVO2Qbw0pQ01nR3UjF8ubSlgeGN4MDAejcr3oA6r3YMdy
         Fcow==
X-Gm-Message-State: AOJu0YxfjInUaAY1AVFKfcmSrGCl4WHGows8132sSnhGzQ5stb0yDqRw
        +dDGDlmfgvCorRpoXQqdzb8Wja1rP1IHXWaIfmRPdQ==
X-Google-Smtp-Source: AGHT+IEXD1W//MfsTwxhlIUHRcn5eqbDoMdzk+7vyDeixRhGaCIaTU8BxZfUm8hNFI4xtXjq/4To+Yc/OCr/8S2kIzQ=
X-Received: by 2002:a17:906:5ad1:b0:9ae:3768:f0ce with SMTP id
 x17-20020a1709065ad100b009ae3768f0cemr1340464ejs.0.1699597545623; Thu, 09 Nov
 2023 22:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
 <20231110010139.3901150-5-sarthakkukreti@chromium.org> <CAHj4cs9pS0hgWBpz9bzoJBGwh1iK+0Nuzc5RmJNyZOR5s-7oLw@mail.gmail.com>
In-Reply-To: <CAHj4cs9pS0hgWBpz9bzoJBGwh1iK+0Nuzc5RmJNyZOR5s-7oLw@mail.gmail.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 9 Nov 2023 22:25:33 -0800
Message-ID: <CAG9=OMOsurTDASByqXWiY9W2arWsd6-vNLnRUk2SvgEbPSg5VQ@mail.gmail.com>
Subject: Re: [PATCH] loop/010: Add test for mode 0 fallocate() on loop devices
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I meant to add a reference to the latest REQ_OP_PROVISION patch series
that this patch accompanied, I'll reword the commit so that it is
clearer:

[1] https://lore.kernel.org/lkml/20231110010139.3901150-1-sarthakkukreti@ch=
romium.org/

Best
Sarthak

On Thu, Nov 9, 2023 at 5:28=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> On Fri, Nov 10, 2023 at 9:02=E2=80=AFAM Sarthak Kukreti
> <sarthakkukreti@chromium.org> wrote:
> >
> > A recent patch series[1] adds support for calling fallocate() in mode 0
>
> The patch link is missing in this patch.
>
> > on block devices. This test adds a basic sanity test for loopback devic=
es
> > setup on a sparse file and validates that writes to the loopback device
> > succeed, even when the underlying filesystem runs out of space.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  tests/loop/010     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/loop/010.out |  2 ++
> >  2 files changed, 62 insertions(+)
> >  create mode 100644 tests/loop/010
> >  create mode 100644 tests/loop/010.out
> >
> > diff --git a/tests/loop/010 b/tests/loop/010
> > new file mode 100644
> > index 0000000..091be5e
> > --- /dev/null
> > +++ b/tests/loop/010
> > @@ -0,0 +1,60 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2023 Google LLC.
> > +# Author: sarthakkukret@google.com (Sarthak Kukreti)
> > +#
> > +# Test if fallocate() on a loopback device provisions space on the und=
erlying
> > +# filesystem and writes on the loop device succeed, even if the lower
> > +# filesystem is filled up.
> > +
> > +. tests/loop/rc
> > +
> > +DESCRIPTION=3D"Loop device fallocate() space provisioning"
> > +QUICK=3D1
> > +
> > +requires() {
> > +       _have_program mkfs.ext4
> > +}
> > +
> > +test() {
> > +       echo "Running ${TEST_NAME}"
> > +
> > +       local mount_dir=3D"$TMPDIR/mnt"
> > +       mkdir -p ${mount_dir}
> > +
> > +       local image_file=3D"$TMPDIR/img"
> > +       truncate -s 1G "${image_file}"
> > +
> > +       local loop_device
> > +       loop_device=3D"$(losetup -P -f --show "${image_file}")"
> > +
> > +       mkfs.ext4 ${loop_device} &> /dev/null
> > +       mount -t ext4 ${loop_device} ${mount_dir}
> > +
> > +       local provisioned_file=3D"${mount_dir}/provisioned"
> > +       truncate -s 200M "${provisioned_file}"
> > +
> > +       local provisioned_loop_device
> > +       provisioned_loop_device=3D"$(losetup -P -f --show "${provisione=
d_file}")"
> > +
> > +       # Provision space for the file: without provisioning support, t=
his fails
> > +       # with EOPNOTSUPP.
> > +       fallocate -l 200M "${provisioned_loop_device}"
> > +
> > +       # Fill the filesystem, this command will error out with ENOSPC.
> > +       local fs_fill_file=3D"${mount_dir}/fill"
> > +       dd if=3D/dev/zero of=3D"${fs_fill_file}" bs=3D1M count=3D1024 s=
tatus=3Dnone &>/dev/null
> > +       sync
> > +
> > +       # Write to provisioned loop device, ensure that it does not run=
 into ENOSPC.
> > +       dd if=3D/dev/zero of=3D"${provisioned_loop_device}" bs=3D1M cou=
nt=3D200 status=3Dnone
> > +       sync
> > +
> > +       # Cleanup.
> > +       losetup --detach "${provisioned_loop_device}"
> > +       umount "${mount_dir}"
> > +       losetup --detach "${loop_device}"
> > +       rm "${image_file}"
> > +
> > +       echo "Test complete"
> > +}
> > \ No newline at end of file
> > diff --git a/tests/loop/010.out b/tests/loop/010.out
> > new file mode 100644
> > index 0000000..068c489
> > --- /dev/null
> > +++ b/tests/loop/010.out
> > @@ -0,0 +1,2 @@
> > +Running loop/009
> > +Test complete
> > --
> > 2.42.0.758.gaed0368e0e-goog
> >
> >
>
>
> --
> Best Regards,
>   Yi Zhang
>
