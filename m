Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56A75C3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGUJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGUJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4088121;
        Fri, 21 Jul 2023 02:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4781E60BA6;
        Fri, 21 Jul 2023 09:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095B1C433C7;
        Fri, 21 Jul 2023 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689933376;
        bh=/WdXMHKbWxwyonEVRclo0wLd91kkKVfAZMKPPE1jeUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kqgIdhxD0V6qeJTloLa+fbYxziiERFNhfbcPxY5cRO6Hxi9NM+7N3FgcqbPSNl/7S
         2cxoAyHyGNcND7SEwtEWXPqjHtP46bx+rMZ4EK3EfMJX0+rfIKg8oIHGvId7YMdeXS
         2+pwtTiFoYP2lYixvTd8+Hd5k/+ljLraA7eWTN+IkhwoyMWsOmfbQpYlQniZhOTAPO
         wGlR8ENzUKqVs5qsnS+Ljb9jCMeKq+OjkbrMK/k8CAt3MBk29qYMFs4Pdld03vUmmM
         oKTzgQshn8+/XgXfDHHs41ZNbxpm1sBOJY2TGiQ8+iLIJWFZrD0MUjDTPTzdLu/XVF
         CrbpKAhJdIjtA==
Message-ID: <fff3d307-485a-c271-1781-becbd18ec2c7@kernel.org>
Date:   Fri, 21 Jul 2023 11:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 14/22] drivers/thermal/rcar_gen3_thermal: convert to
 use devm_request*_irq_probe()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721094641.77189-1-frank.li@vivo.com>
 <20230721094641.77189-14-frank.li@vivo.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230721094641.77189-14-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

All your subject prefixes are totally mixed up.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

