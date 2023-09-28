Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4B77B1D65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjI1NJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjI1NJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:09:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E98198;
        Thu, 28 Sep 2023 06:09:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1249C433C8;
        Thu, 28 Sep 2023 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695906573;
        bh=Qq0hi3e2tKtQJ3+Z8bOvfTj1CKrpaItZITJxOy4HsYk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G9QO6tvR7OcWm8lZ1U+06XFAkTtd20/2iYWGGS8m9DpGgk3Wqbh0igL8reiBJW8XS
         2/N0r8BxxvZeWJNbTzMszbxNsZKtyzfrd0TFew5e32ttARPUYMRQy8KZEqiXK9hqlL
         pJb2dRM7QlU9IDPiYPt2z/gTkmzAK8k01CzvB4PtXk0sTXQly94hcnAt+akohNi6cE
         1CYHqrUw2bZ3NPcZnrs87HAluKxL90XedpoHwpAe+0OBxjX5g0U/WqtKIMgfhS6UHB
         C91lbbCQoXQQuy+Z4O5ninrDG0azWdU/kvvM/bWhOdvwzC6UbM9Z3lqvuK/Ha2pFjk
         DEcsQIV0YNEDQ==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Bryan Wu <bryan.wu@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jamie Iles <jamie@jamieiles.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-leds@vger.kernel.org
In-Reply-To: <3f4be7a99933cf8566e630da54f6ab913caac432.1695453322.git.christophe.jaillet@wanadoo.fr>
References: <3f4be7a99933cf8566e630da54f6ab913caac432.1695453322.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] leds: trigger: ledtrig-cpu:: Fix a warning
 when compiling with W=1
Message-Id: <169590657165.1583104.6448203115570808181.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:09:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2023 09:15:38 +0200, Christophe JAILLET wrote:
> In order to teach the compiler that 'trig->name' will never be truncated,
> we need to tell it that 'cpu' is not negative.
> 
> When building with W=1, this fixes the following warnings:
> 
>   drivers/leds/trigger/ledtrig-cpu.c: In function ‘ledtrig_cpu_init’:
>   drivers/leds/trigger/ledtrig-cpu.c:155:56: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 5 [-Werror=format-truncation=]
>     155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
>         |                                                        ^~
>   drivers/leds/trigger/ledtrig-cpu.c:155:52: note: directive argument in the range [-2147483648, 7]
>     155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
>         |                                                    ^~~~~~~
>   drivers/leds/trigger/ledtrig-cpu.c:155:17: note: ‘snprintf’ output between 5 and 15 bytes into a destination of size 8
>     155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
>         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] leds: trigger: ledtrig-cpu:: Fix a warning when compiling with W=1
      commit: 5272d74b29929c8395720a7e35971a4f0fb6783d

--
Lee Jones [李琼斯]

