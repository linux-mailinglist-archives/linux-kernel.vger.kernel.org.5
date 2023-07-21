Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9343D75C3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGUJ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CC630F1;
        Fri, 21 Jul 2023 02:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AADD60C6D;
        Fri, 21 Jul 2023 09:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C06C433C9;
        Fri, 21 Jul 2023 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689933351;
        bh=ouwCwwWgI46JHzeM1cNQaQAbglYhC/bAsFmoa4/zjZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eoi/ytG/5rqYhqQM0rSN/CxEuZmFF89oXIz4ewJGf1ycE5X2Khg7FHZntKXrmNw+2
         Zg9Py2tHG5QfwHEPbVDqeqkeHzcn+2lDabqdhXE/Gl1Nyc0LB4XYZ4UNSdjWsb6cnZ
         5VPDGWgYToHGU0quZMhkjG0VS5ipOeZl9aj1psROUDuDfv++oSYnjtlUiLOenN19Ml
         CtnybW6rsmW1c1ZIADtosGq4jxVsxB9qi4h2Oazk/ucf011KV6Nuv/PHRmHaMrMZKY
         CLIa+/L4nvyIVYnf9mx8kdC0viipNKWSL3nwmT7Mp7KW9UiGV/Rh96SFkxIQ9cLcDt
         lGTgYKT0+0gbQ==
Message-ID: <81fb5c84-4586-9555-1c20-4ab9ec3a78d7@kernel.org>
Date:   Fri, 21 Jul 2023 11:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 05/22] thermal/drivers/tegra: convert to use
 devm_request*_irq_probe()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721094641.77189-1-frank.li@vivo.com>
 <20230721094641.77189-5-frank.li@vivo.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230721094641.77189-5-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 11:46, Yangtao Li wrote:
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
> 
> And tglx point out that:
> 
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
> 
>      519 messages total (there are probably more)
> 
>      352 unique messages
> 
>      323 unique messages after lower casing
> 
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
> 
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
> 
>      The most useful one of all is: "could request wakeup irq: %d"
> 
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
> 
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
> 
> So convert to use devm_request*_irq_probe() API, which ensure that all
> error handling branches print error information.
> 
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.

You got comment - drop this huge text in every commit. Or squash all
commits into one...

Best regards,
Krzysztof

