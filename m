Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A530D777143
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjHJHWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjHJHWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:22:33 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50371702;
        Thu, 10 Aug 2023 00:22:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AACE920004;
        Thu, 10 Aug 2023 07:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691652148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8ho0ZeRgf6GcBDYycgxV6RMNmHgIqASgZeOYExlJaA=;
        b=n26apJIn/795ozqnWJ141CFV4AWyErDmkf+OaUyCNFQqGxjpFaIRyJb824nVFgMu4yDSa4
        ZsgPHNoz/XsNVu4Q1wHG/s9K3BOJ0YSbyUtFspyaDHi3qJ4/bk/tsulYwigsA3FFqCL5ps
        +5vyvADcWT0qiMqpONtfkbDwlGbrfOPT3pmVrmualHJfmkrK/5VG2sky5fLdAhW2maDJ/r
        7aLn4KZprlDINy0EDcnOtnqG/UvXHZkgNNbkaltdS3hMOJK8X0w5O1b5JzT6jAjB1ZzvoJ
        Jp76S0pP30RlSr2+pwC+eEf6vlM+chLnY6ZM8UAPdXgprdENYzkJ6CX7CH/Xqw==
Date:   Thu, 10 Aug 2023 09:22:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: stm32: remove incorrect #ifdef check
Message-ID: <169165213049.964766.5251410326864889456.b4-ty@bootlin.com>
References: <20230801105932.3738430-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801105932.3738430-1-arnd@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Aug 2023 12:59:15 +0200, Arnd Bergmann wrote:
> After a previous commit changed the driver over to
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(), the suspend/resume
> functions must no longer be hidden behind an #ifdef:
> 
> In file included from include/linux/clk.h:13,
>                  from drivers/rtc/rtc-stm32.c:8:
> drivers/rtc/rtc-stm32.c:927:39: error: 'stm32_rtc_suspend' undeclared here (not in a function); did you mean 'stm32_rtc_probe'?
>   927 |         SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_rtc_suspend, stm32_rtc_resume)
>       |                                       ^~~~~~~~~~~~~~~~~
> include/linux/kernel.h:58:44: note: in definition of macro 'PTR_IF'
>    58 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
>       |                                            ^~~
> include/linux/pm.h:329:26: note: in expansion of macro 'pm_sleep_ptr'
>   329 |         .suspend_noirq = pm_sleep_ptr(suspend_fn), \
>       |                          ^~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] rtc: stm32: remove incorrect #ifdef check
      commit: a69c610e13e2b2de8a1ed2683f13e21b3200bd7a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
