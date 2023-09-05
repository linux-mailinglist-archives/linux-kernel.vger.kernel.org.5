Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD57793090
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbjIEU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjIEU7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:59:06 -0400
X-Greylist: delayed 98 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:59:02 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB29413E;
        Tue,  5 Sep 2023 13:59:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3173EC433C7;
        Tue,  5 Sep 2023 20:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693946987;
        bh=mkx/dPJMnOTKSIAXVGOSOvPvbtAhymmkbWUf2/o8bP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B1aXsENle5M1LbqtGkCzB1GOPqjIXm+HkowH36Dmkx/c457P8SvXSBT9l0FwsDLGN
         xgteeNbP/qDdDTIDBG8hmfdoKDSqoodyLDYDnuFpbxgxtrjYnS5Je1TUAGZegMivnl
         KWzqXKypOgcCFjhTT4+w2mb5rOgln7p/ZG+cL8ulhEnqWP86BTA9ayKWoDL1POP0JY
         Tv0RPJE9OJYKik6BiS6gJrgG1K0+Lf6+Isv0QOyzQm4KuAo+RMHvMyoLhRB/dv+L6d
         q3PKu0XGW70+MHV8Geqky+nSbSFyRqpoFPEjBQ/V6qtF13jkM2Z1en8LRwmPgusqdW
         OOHrhrkf71YoQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5009d4a4897so5041700e87.0;
        Tue, 05 Sep 2023 13:49:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YyuSctE02qE/zssc+SMNzXGxgPoXjpi2n1+NOrxWJSCESRGV8Zk
        oQE7PHHdVVZbbxWCTZSXkf+s3kW10f/sYTWJeqw=
X-Google-Smtp-Source: AGHT+IEla/8Tm0udQR5JU3+Bw/LnShDMBbes3IfH1Gkcc9EhFjTSJdW3ASesbyKBvchrpKWDEDemK6DMC9yfNibCRtI=
X-Received: by 2002:a19:2d15:0:b0:4fb:94c6:fd63 with SMTP id
 k21-20020a192d15000000b004fb94c6fd63mr613941lfj.17.1693946985154; Tue, 05 Sep
 2023 13:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230903095059.2683850-1-visitorckw@gmail.com>
 <20230903183058.1301b149@nvm> <20230903201024.GD2692213@sivslab-System-Product-Name>
In-Reply-To: <20230903201024.GD2692213@sivslab-System-Product-Name>
From:   Song Liu <song@kernel.org>
Date:   Tue, 5 Sep 2023 13:49:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7GDauaO-VZC54uvFu7oCoBd=dMVBsi2xNJbMDkwfOqqA@mail.gmail.com>
Message-ID: <CAPhsuW7GDauaO-VZC54uvFu7oCoBd=dMVBsi2xNJbMDkwfOqqA@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: eliminate if-statements in cmp_stripe()
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     Roman Mamedov <rm@romanrm.net>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Sep 3, 2023 at 1:10=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
>
> On Sun, Sep 03, 2023 at 06:30:58PM +0500, Roman Mamedov wrote:
> > On Sun,  3 Sep 2023 17:50:59 +0800
> > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > > Replace the conditional statements in the cmp_stripe() function with =
a
> > > branchless version to improve code readability and potentially enhanc=
e
> > > performance.
> >
> > The new code will always do two comparisons and a subtraction (3
> > instructions in total), whereas the old version could return after just=
 1
> > comparison, or after 2 comparisons. So depending on the data values it =
is 3x
> > to 1.5x as much operations performed than before, there unlikely to be =
any
> > enhancement of performance.
> >
> > Also IMO the previous version is more easily readable.
> >
> The reason behind my proposed changes was to eliminate conditional
> branches in the code. While the original code could occasionally achieve
> early returns, many compilers, such as x86-64 gcc 13.2 compiling with
> -O2 flag, still generate branch instructions. Processors typically have
> deep pipelines, and a branch prediction miss can result in a high
> penalty. Therefore, even though early return might not be possible, the
> new branchless version of code could still offer efficiency
> improvements.

We need more information to support the efficiency improvement here.
In this case, I would like to see some benchmark results (micro
benchmark is fine).

If we cannot show the difference in performance, I would rather keep
current code.

Thanks,
Song

[...]
