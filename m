Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC814772D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjHGRpH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHGRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:45:04 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7171710;
        Mon,  7 Aug 2023 10:45:02 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56d279a4d5cso945088eaf.1;
        Mon, 07 Aug 2023 10:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430301; x=1692035101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWKNVFPG2tk11UK8ShmuaIuXv6kvQHWLsHEKxszVH4E=;
        b=epWKavYJDsEMKBrONVIP0A/OhkscwkvEA3vTy5OBKaNMRgv5y60IjpTUx974Mfx3rA
         TJX/PexYui/PP/BJzsK7vNfMy6AgG7HUlh2JdrpyfK4l+9t4/VZBO2d2+5eUxlyMfxq5
         wT4d/v40gUO5x15tiA34xLBZvGtQ1tKfLHQW54U0wNGWVAtWLmjNaavcDVQpyGOxPhcM
         tYM1o4F8Dgt905lLf6hoqEaBsvj4meSg50jdwNEoPurTldVTmfDLc3Uk8REq481mec03
         ceGwjHWTvwyPTQeB6ewSqrcg6GDp+m8j/0/6wx9mw/kXVGJ7744UbS9Rd87LnlUBZ6P3
         2DVw==
X-Gm-Message-State: ABy/qLbfe0dhDyE30AmU+0pHFLpk2Xp9Q7BdTl9VbRaIEw5Rxd+3upi2
        6AMnlYY/SmiMn6NHevCg/CAd/ScbV/LQLpDcGfq3uBy8
X-Google-Smtp-Source: APBJJlHIs1Rd+8IBsAtPW72ueQVYXf1CaTX97GCshJ93wMpSx0aG6YLWBWfqKydbnmKuq9XeVtYAw+GgLZ8IIBr3ziI=
X-Received: by 2002:a4a:e251:0:b0:566:951e:140c with SMTP id
 c17-20020a4ae251000000b00566951e140cmr17718901oot.1.1691430301602; Mon, 07
 Aug 2023 10:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-amd-pstate-cfi-v1-1-0263daa13bc3@weissschuh.net> <20230807160635.GA3061@dev-arch.thelio-3990X>
In-Reply-To: <20230807160635.GA3061@dev-arch.thelio-3990X>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 19:44:50 +0200
Message-ID: <CAJZ5v0jNiq_-T9nF_-Xe7q_XMfxSbU7OzC02Y8SrhYv6XjX=Aw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: fix global sysfs attribute type
To:     Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jannik Glueckert <jannik.glueckert@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux LLVM Build Support <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 6:06 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Thomas,
>
> On Mon, Aug 07, 2023 at 08:37:45AM +0200, Thomas Weißschuh wrote:
> > In commit 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_root()")
> > the "amd_pstate" attributes where moved from a dedicated kobject to the
> > cpu root kobject.
> > While the dedicated kobject expects to contain kobj_attributes the root
> > kobject needs device_attributes.
> >
> > As the changed arguments are not used by the callbacks it works most of
> > the time.
> > However CFI will detect this issue:
> >
> > [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show_status+0x0/0x70; expected type: 0x8651b1de)
> > ...
> > [ 4947.849409] Call Trace:
> > [ 4947.849410]  <TASK>
> > [ 4947.849411]  ? __warn+0xcf/0x1c0
> > [ 4947.849414]  ? dev_attr_show+0x24/0x60
> > [ 4947.849415]  ? report_cfi_failure+0x4e/0x60
> > [ 4947.849417]  ? handle_cfi_failure+0x14c/0x1d0
> > [ 4947.849419]  ? __cfi_show_status+0x10/0x10
> > [ 4947.849420]  ? handle_bug+0x4f/0x90
> > [ 4947.849421]  ? exc_invalid_op+0x1a/0x60
> > [ 4947.849422]  ? asm_exc_invalid_op+0x1a/0x20
> > [ 4947.849424]  ? __cfi_show_status+0x10/0x10
> > [ 4947.849425]  ? dev_attr_show+0x24/0x60
> > [ 4947.849426]  sysfs_kf_seq_show+0xa6/0x110
> > [ 4947.849433]  seq_read_iter+0x16c/0x4b0
> > [ 4947.849436]  vfs_read+0x272/0x2d0
> > [ 4947.849438]  ksys_read+0x72/0xe0
> > [ 4947.849439]  do_syscall_64+0x76/0xb0
> > [ 4947.849440]  ? do_user_addr_fault+0x252/0x650
> > [ 4947.849442]  ? exc_page_fault+0x7a/0x1b0
> > [ 4947.849443]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > Reported-by: Jannik Glückert <jannik.glueckert@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217765
> > Link: https://lore.kernel.org/lkml/c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com/
> > Fixes: 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_root()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>
> Thanks a lot for the quick patch! Unfortunately, it seems like neither
> of my AMD machines support amd-pstate so I can't test this but it seems
> like the right fix to me.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Applied as 6.5-rc material, thanks!
