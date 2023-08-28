Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01978B983
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjH1UYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjH1UYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:24:08 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA78FF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:24:06 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id F211A16C004D;
        Mon, 28 Aug 2023 23:24:03 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cEbrxrMt26Y0; Mon, 28 Aug 2023 23:24:03 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1693254242; bh=O/WRNq9CKZeXYHbZTzZTT4pv7dU3hfELhmbUNVhV6Lo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FCUXPpQ2+L4Syt4lkJAs6aH8lJ6k4gLeWwOzEV6wCjMoRhrfra5Ls1vbTEAs2g5xc
         e4/btR60MJEPK9Zuqge71VrfJ/P5X2tXyVgo3OE5NgltNMoqEuhJzF2YdgEovqt0Cl
         X7+xGxjKq8927tIIeyyLwoqgDrARQP4/q0ze1nKg=
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: es8316: Enable support for MCLK div by 2
In-Reply-To: <ZOzi9BuTo2oXcKta@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-3-posteuca@mutex.one>
 <ZOfRXjuSTxSV89SC@finisterre.sirena.org.uk> <87msyc9mtm.fsf@mutex.one>
 <ZOzi9BuTo2oXcKta@finisterre.sirena.org.uk>
Date:   Mon, 28 Aug 2023 23:22:15 +0300
Message-ID: <87zg2ax6h4.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

>
> In general a MCLK that allows you to configure the dividers in the CODEC
> appropriately for use.  So long as it works your change looks fine I
> think modulo.
Sorry, maybe this question is dumb, but I am not familiar with this
expression. What do you mean by "your change looks fine I think modulo"?

>> +	do {
>> +		/* Validate supported sample rates that are autodetected from MCLK */
>> +		for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
>> +			const unsigned int ratio = supported_mclk_lrck_ratios[i];
>> +
>> +			if (clk % ratio != 0)
>> +				continue;
>> +			if (clk / ratio == params_rate(params))
>> +				break;
>> +		}
>
> Use ARRAY_SIZE()
>
Do you mean instead of all instances of NR_SUPPORTED_MCLK_LRCK_RATIOS?
If so, it's already defined as:
#define NR_SUPPORTED_MCLK_LRCK_RATIOS ARRAY_SIZE(supported_mclk_lrck_ratios)

If not, then I don't see where else I could use it.

