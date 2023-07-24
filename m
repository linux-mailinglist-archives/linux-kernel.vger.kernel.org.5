Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBDE760151
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGXVj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGXVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18DCD8;
        Mon, 24 Jul 2023 14:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ABD861423;
        Mon, 24 Jul 2023 21:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4394C433C9;
        Mon, 24 Jul 2023 21:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690234793;
        bh=xzsk77oa/MmXqkkg6zmkBhwbeHVVBpPaTZBJoL2yiSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mE3pj1jcdJGd2420B2MZzLHNvk5nkkEfWuzFXJ3om9Bj15J4etmG1pPdOd62aqnZ7
         cOkyC0FqEXXEuGki++nrrpMe/LhUTorHF5UAavZXj97HMbK0Xdgscq9tkc4HyfmTDm
         rhgeFoMfxIfXaa8KUrxgJsAOmaBiBozZQLuOg4qfFjtPig+9XDlXCNtkhuAGkJivVh
         JKCOmpOJWu4MILtwCS+H+WCEWxtJ90JrFwX7P6JB/O6wqM0Wb+H2q0MtatzrI25GJl
         srk/+oSfn8Lb6AghWfDz/CGcUB04U25Rr4od0BYDbT8eljmf5NoOxBJUNbp5rLw1wj
         5f8SBBKVCb4yA==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5774098f16eso61049547b3.0;
        Mon, 24 Jul 2023 14:39:53 -0700 (PDT)
X-Gm-Message-State: ABy/qLbHn7QRhvStCprjsEyKePCtzbzNdVF3QDNhl06MStAGqEioYkyp
        vQkYO31EOYpI41pdXAbXQwG+JaBIevMtB1A6Mr8=
X-Google-Smtp-Source: APBJJlEtzh0Zak8DLTD3txHST1gAslj5+/hgXN8oWWMtjOhMRXd56KETGfklYbd7TsB4WlRAn/u8WQrGL5jyuFYaIuA=
X-Received: by 2002:a81:66c4:0:b0:568:d63e:dd2c with SMTP id
 a187-20020a8166c4000000b00568d63edd2cmr9620907ywc.11.1690234792843; Mon, 24
 Jul 2023 14:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <ZL7qbTU7D1mAJePi@pengutronix.de>
In-Reply-To: <ZL7qbTU7D1mAJePi@pengutronix.de>
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Mon, 24 Jul 2023 16:39:41 -0500
X-Gmail-Original-Message-ID: <CAFkjPT=x7y0USLTXPGbC382NoD=eXd18TbRgaB8S=GX0-_AZ+w@mail.gmail.com>
Message-ID: <CAFkjPT=x7y0USLTXPGbC382NoD=eXd18TbRgaB8S=GX0-_AZ+w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] fs/9p: fix mmap regression
To:     Robert Schwebel <r.schwebel@pengutronix.de>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Awesome, thanks for verifying Robert.  Will send a pull request for
this in a few days.

      -eric

On Mon, Jul 24, 2023 at 4:17=E2=80=AFPM Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
>
> Hi Eric,
>
> On Wed, Jul 19, 2023 at 03:17:04PM +0000, Eric Van Hensbergen wrote:
> > This series attempts to fix a reported exception with mmap
> > on newer kernels.
> >
> > Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file mode=
s")
> > Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> > Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > ---
> > Changes in v3:
> > - Clarify debug print to read-only mmap mode versus no mmap mode in
> >   v9fs_file_mmap
> > - Fix suggested regression tags and propagate across series
> > - Link to v2: https://lore.kernel.org/r/20230716-fixes-overly-restricti=
ve-mmap-v2-0-147d6b93f699@kernel.org
> >
> > Changes in v2:
> > - fix requested changes in commit messages
> > - add patch to remove unnecessary invalidate_inode_pages in mmap readon=
ly path
> > - Link to v1: https://lore.kernel.org/r/20230716-fixes-overly-restricti=
ve-mmap-v1-0-0683b283b932@kernel.org
>
> I've tested this patch series with my qemu setup and it resolves the
> issue. Thanks for taking care!
>
> Tested-by: Robert Schwebel <r.schwebel@pengutronix.de>
>
> ----------8<----------
>
> rsc@dude05:~/work/DistroKit$ configs/platform-v7a/run
> Forwarding SSH port 127.0.0.1:24910 -> qemu:22
> [    0.000000] L2C: platform modifies aux control register: 0x02020000 ->=
 0x02420000
> [    0.000000] L2C: DT/platform modifies aux control register: 0x02020000=
 -> 0x02420000
> [    0.004896] smp_twd: clock not found -2
> [    0.726397] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga=
@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
> [    0.742338] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga=
@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
> [    0.809910] physmap-flash 48000000.psram: map_probe failed
> [    1.201306] 9pnet_virtio: no channels available for device root
>
>  ____                        _                   _
> |  _ \ ___ _ __   __ _ _   _| |_ _ __ ___  _ __ (_)_  __
> | |_) / _ \ '_ \ / _` | | | | __| '__/ _ \| '_ \| \ \/ /
> |  __/  __/ | | | (_| | |_| | |_| | | (_) | | | | |>  <
> |_|   \___|_| |_|\__, |\__,_|\__|_|  \___/|_| |_|_/_/\_\
>                  |___/
>
>  ____  _     _             _  ___ _
> |  _ \(_)___| |_ _ __ ___ | |/ (_) |_
> | | | | / __| __| '__/ _ \| ' /| | __|
> | |_| | \__ \ |_| | | (_) | . \| | |_
> |____/|_|___/\__|_|  \___/|_|\_\_|\__|
>
>
> OSELAS(R)-DistroKit-2019.12.0-00429-g57ffae760eb9 / v7a-2019.12.0-00429-g=
57ffae760eb9
> ptxdist-2023.07.1/2023-07-11T19:56:50+0200
>
> DistroKit login: root
> root@DistroKit:~ mount / -o remount,rw
> root@DistroKit:~ ldconfig
> root@DistroKit:~ uname -a
> Linux DistroKit 6.4.0 #1 SMP PREEMPT 2023-07-01T00:00:00+00:00 armv7l GNU=
/Linux
>
> ----------8<----------
>
> rsc
> --
> Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  =
|
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    =
|
>
