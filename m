Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECF57584F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGRSly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45957E8;
        Tue, 18 Jul 2023 11:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDBF3616A8;
        Tue, 18 Jul 2023 18:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C33BC433C8;
        Tue, 18 Jul 2023 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689705711;
        bh=a5euet8QU4I8gSkyqhMce+/xHpcOSEb0+0iBwAwp+Po=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a75EYDWVHBTWwdDr/oRRYA49Z8F0oIYn+iEQIbUxOEHCBHR6VgVkPDcUxNUk6d7Nv
         mIBg9N2Q9X4n7YoQ8HDvKsgRWooB3vbX9dcKSL4NmujAwVTGHH5a3t9xiscnLEass3
         bk/iyNQcGNzJdPyV+nBHd3GqXqFogb86cr5YCj3t0yXYSbJCl3opC4So3jly/d5gY/
         7lQ0mIF7JS7RSTMHmlzr+VhpbsS70U1Oh0FDx0J7bv3beQTaOY5ItjQ54/lIoQdynR
         cE0EOz1c165exTwIDOE43OzT7Y3wnsQyhSjFHBUQp4u0aw6a12VsndXU+afMt6kxHz
         Jd1hvz+0QFG2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AECA1CE04CD; Tue, 18 Jul 2023 11:41:50 -0700 (PDT)
Date:   Tue, 18 Jul 2023 11:41:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH rcu 15/18] torture: Add init-program support for loongarch
Message-ID: <b6283b82-8a65-4455-8bbf-d597efc26402@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
 <20230717182337.1098991-15-paulmck@kernel.org>
 <CACWXhK=Vc0kKpnOLRxgw-oP+QDJYt3AqD-kvcA1QkUitiW2Jng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWXhK=Vc0kKpnOLRxgw-oP+QDJYt3AqD-kvcA1QkUitiW2Jng@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:56:06AM +0800, Feiyang Chen wrote:
> On Tue, Jul 18, 2023 at 2:23 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > This commit adds the __loongarch__, __loongarch_lp64, and
> > __loongarch_double_float targets to rcutorture's mkinitrd.sh
> > script in order to allow nolibc init programs for loongarch.
> >
> > Cc: Feiyang Chen <chenfeiyang@loongson.cn>
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Willy Tarreau <w@1wt.eu>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > index 3af3a86a0091..e7e23615dbe3 100755
> > --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > @@ -63,7 +63,8 @@ ___EOF___
> >  # build using nolibc on supported archs (smaller executable) and fall
> >  # back to regular glibc on other ones.
> >  if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
> > -           "||__ARM_EABI__||__aarch64__||__s390x__\nyes\n#endif" \
> > +           "||__ARM_EABI__||__aarch64__||__s390x__"\
> > +          "||__loongarch__||__loongarch_lp64||__loongarch_double_float\nyes\n#endif" \
> 
> Hi, Paul,
> 
> Thank you for the patch, but I believe adding only the __loongarch__
> should be sufficient.

Very well, I will remove the others on my next rebase with attribution.

And thank you for looking this over!  Especially as I have no way
to test it.  ;-)

							Thanx, Paul

> Thanks,
> Feiyang
> 
> >     | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
> >     | grep -q '^yes'; then
> >         # architecture supported by nolibc
> > --
> > 2.40.1
