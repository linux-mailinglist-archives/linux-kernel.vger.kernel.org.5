Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67561788007
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjHYGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjHYGig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1451FD4;
        Thu, 24 Aug 2023 23:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C8763325;
        Fri, 25 Aug 2023 06:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2796CC433CA;
        Fri, 25 Aug 2023 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692945514;
        bh=4cEp/6KzHQizRDijVJvbQ5QBccVlujjp1hrBrw0pho4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=btlmsO07f7TXE7eVzge3rVB56h5HAu/P5P8ovEW++HZoYSPN5RmUMu4HwMmlOJ14/
         t/m0NC9bh+USn9Hh/VyE3yjB1SgaVTsaciInBeDXi63ZL3Mno0D4qR63r1FWA/Atbn
         WG2GgLKtSGbCTT/bfv1bSV8uYkpx2iAEPazNVRXMVo08N1gprZOmgGYR8mNKNTeknk
         oEvHby7rowffKYndt7hsqKqFK/6vfwXm1vmE/ClmmhIFOL6LVH2Djc3KvvdTK/SQRU
         iPT5dHfxBRsf3CP2Dwiw/l1ehzayrUY1u/FXE0l5yLFfsvcekz4TC5AFS5+w/TeQfW
         DOANh9qNb/jwg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so858866e87.1;
        Thu, 24 Aug 2023 23:38:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyk8sqWkDT24XaQ/c2tAXccM5v7k7fRLxOPneWp8lnFTM1mueBP
        fMWGYYof2qT2o99zc8qjX0TZlN1P5oceGcBNXaA=
X-Google-Smtp-Source: AGHT+IEJ/fLHq7+nyt6vu29hGtadaIPPWVUHPGGMJbZOfrA1o7MZOmrnr0mVGOCAKg3Bd7U1xPrhKkKMaIHEJ1MOV7k=
X-Received: by 2002:a05:6512:615:b0:4fd:d9dd:7a1a with SMTP id
 b21-20020a056512061500b004fdd9dd7a1amr12280848lfe.31.1692945512098; Thu, 24
 Aug 2023 23:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230825025532.1523008-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230825025532.1523008-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Aug 2023 23:38:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW724NzpM1xMaT-L_xt+8yn6pvf5udrnUwArx921+b0r1g@mail.gmail.com>
Message-ID: <CAPhsuW724NzpM1xMaT-L_xt+8yn6pvf5udrnUwArx921+b0r1g@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] md: fix two regressions related to export_rdev()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yukuai3@huawei.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 7:59=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Those problems are found by a new mdadm test(see details in commit messag=
e)
> in my VM, it's not 100% reproducible but run this test in a loop, I can
> always reporduce them within 10 min.

Applied to md-next. Thanks!

Song

>
> Yu Kuai (2):
>   md: don't dereference mddev after export_rdev()
>   md: fix warning for holder mismatch from export_rdev()
>
>  drivers/md/md.c | 21 +++++++++++++++------
>  drivers/md/md.h |  3 +++
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> --
> 2.39.2
>
