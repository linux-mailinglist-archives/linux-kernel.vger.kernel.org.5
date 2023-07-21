Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C175C0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGUIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGUIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76012706;
        Fri, 21 Jul 2023 01:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490736153A;
        Fri, 21 Jul 2023 08:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624AFC433C9;
        Fri, 21 Jul 2023 08:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689926460;
        bh=6/6p2VbpQh5R8Sbmnap668JgADLBaSw4BVIzoOLka/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5fguW0eIHgISCjgal336PsRywt7GtEzMETWr9bzcreFB8bzBhnbxuoLHZHImlZsA
         lObQ5whCd3H2TEjmDoEjnZM/08eeC0LcaJpLBRk/mqD8yqM6C3Y0u5rEYGCPffOJ1u
         4Q8ZtXJcABCDG9UMO8pscKpKRRVv9FsFKzjRvD++RKYLiacR8BrSFYTscdThRjqasg
         0TyK2L0o9Y4waPMknT3yU84JqFk+gt7fNM6HEWI24K4pUpBLWqID1fiBCA+8o5nIZy
         88EMNX63HFPbqLE5A7A5Zpwrty/XP8+XamrHmQ7tcpmWddXWGdVK2Am6ISAkSxmIgj
         Mk9KZrrVYDrpg==
Date:   Fri, 21 Jul 2023 09:00:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] mfd: rz-mtu3: link time dependencies
Message-ID: <20230721080055.GB1908841@google.com>
References: <20230719090430.1925182-1-arnd@kernel.org>
 <ZLlMAZPzEmSlzlbV@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLlMAZPzEmSlzlbV@orome>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023, Thierry Reding wrote:

> On Wed, Jul 19, 2023 at 11:02:23AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The new set of drivers for RZ/G2L MTU3a tries to enable compile-testing the
> > individual client drivers even when the MFD portion is disabled but gets it
> > wrong, causing a link failure when the core is in a loadable module but the
> > other drivers are built-in:
> > 
> > x86_64-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_apply':
> > pwm-rz-mtu3.c:(.text+0x4bf): undefined reference to `rz_mtu3_8bit_ch_write'
> > x86_64-linux-ld: pwm-rz-mtu3.c:(.text+0x509): undefined reference to `rz_mtu3_disable'
> > 
> > arm-linux-gnueabi-ld: drivers/counter/rz-mtu3-cnt.o: in function `rz_mtu3_cascade_counts_enable_get':
> > rz-mtu3-cnt.c:(.text+0xbec): undefined reference to `rz_mtu3_shared_reg_read'
> > 
> > It seems better not to add the extra complexity here but instead just use
> > a normal hard dependency, so remove the #else portion in the header along
> > with the "|| COMPILE_TEST". This could also be fixed by having slightly more
> > elaborate Kconfig dependencies or using the cursed 'IS_REACHABLE()' helper,
> > but in practice it's already possible to compile-test all these drivers
> > by enabling the mtd portion.
> > 
> > Fixes: 254d3a727421c ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > Fixes: 0be8907359df4 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> > Fixes: 654c293e1687b ("mfd: Add Renesas RZ/G2L MTU3a core driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/counter/Kconfig     |  2 +-
> >  drivers/pwm/Kconfig         |  2 +-
> >  include/linux/mfd/rz-mtu3.h | 66 -------------------------------------
> >  3 files changed, 2 insertions(+), 68 deletions(-)
> 
> Assuming that Lee will pick this up:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Happy to.  Can you do without a pull-request?

-- 
Lee Jones [李琼斯]
