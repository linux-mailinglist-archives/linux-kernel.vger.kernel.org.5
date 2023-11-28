Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011D7FB0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjK1Dsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1Dsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:48:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32123137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:48:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A4CC433C7;
        Tue, 28 Nov 2023 03:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701143338;
        bh=PVKHaxw29CXdPuv0Tdfwu+PUXQdjfm5GiOBmQ4yY6rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r2AK5R0s4zEPQ+xq1D2IBOnv+3ogybxvlBWJ1CstUx1dZuF3q4/hpGM6CrL/TfYSH
         /PwMDaIJ10Dmtwpc1NogLyoIIRuVukm602uCgenlIL/ZVsm2uEkRUaQnzApNQUmI7F
         GAUl2OMB6nWPJO7VAW92ML/HBccrBCiexCdtw2uxZMqz2xbFJ2TfnpgYM4x9hbCXlB
         7XQXGvp0xjTIdzMEW36oHfZ+YpYp+Hr23G194i3JtodMQude7t69zHpe4WMzFiKrDq
         lF/38RPqUugy6NtX7F2RwZ417rNmIhBo4mg736qSeCHc2DtkpTtjl+6yewhA4LKmh9
         Lxgt7tp6kumtA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so60504881fa.1;
        Mon, 27 Nov 2023 19:48:58 -0800 (PST)
X-Gm-Message-State: AOJu0YyNy0T4WgLctlAEs+lVR97jUKYcBz+2HuCP5AKZr8vzB6OQ0Jsh
        0z9EpWVOTsTnfQFHIlLyLNj4NdBvVZ5SOdKHbCM=
X-Google-Smtp-Source: AGHT+IFjsbDzfoxndySx0WSj6G80JiRs8ekfR3AVT8TuyV3YlXwFkCGch9+qwJ0dggg/WcfByATufMWFcjqvkA9ccyA=
X-Received: by 2002:a2e:8650:0:b0:2c9:acf5:18fc with SMTP id
 i16-20020a2e8650000000b002c9acf518fcmr514116ljj.1.1701143337072; Mon, 27 Nov
 2023 19:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
 <20231124075953.1932764-2-yukuai1@huaweicloud.com> <CAPhsuW5mjvpMmEN5g_-ADQgJKZ1=QyNxxSw-7kq-W2jww09Aag@mail.gmail.com>
 <e3b8298c-1154-c5ce-d025-b9346a6cd2ab@huaweicloud.com>
In-Reply-To: <e3b8298c-1154-c5ce-d025-b9346a6cd2ab@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Nov 2023 19:48:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW65mcz3xLH7FH+ZceLmuMx9uLqKr7a3d9LB=nHgEJkWsg@mail.gmail.com>
Message-ID: <CAPhsuW65mcz3xLH7FH+ZceLmuMx9uLqKr7a3d9LB=nHgEJkWsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] md: fix missing flush of sync_work
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 6:07=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/11/28 8:02, Song Liu =E5=86=99=E9=81=93:
> > On Fri, Nov 24, 2023 at 12:00=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Commit ac619781967b ("md: use separate work_struct for md_start_sync()=
")
> >> use a new sync_work to replace del_work, however, stop_sync_thread() a=
nd
> >> __md_stop_writes() was trying to wait for sync_thread to be done, henc=
e
> >> they should switch to use sync_work as well.
> >>
> >> Noted that md_start_sync() from sync_work will grab 'reconfig_mutex',
> >> hence other contex can't held the same lock to flush work, and this wi=
ll
> >> be fixed in later patches.
> >>
> >> Fixes: ac619781967b ("md: use separate work_struct for md_start_sync()=
")
> >
> > This fix should go via md-fixes branch. Please send it separately.
>
> This patch alone is not good, there are follow up problems to be fixed
> completely after patch 5. Can this patchset applied to md-fixes?
>
> Or I can split patch 1,4 and 5 for md-fixes, and keep others to md-next.

Yes, please split the patches into two sets.

Thanks,
Song
