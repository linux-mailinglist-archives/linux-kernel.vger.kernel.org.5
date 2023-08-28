Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903078B8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjH1Txs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjH1Txg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:53:36 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 12:53:32 PDT
Received: from out-251.mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32F189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:53:32 -0700 (PDT)
Date:   Mon, 28 Aug 2023 21:43:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1693251839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBIoSRGHysFdf5RQJRIV8orXzVSKFeD3OKu39TO6VvE=;
        b=p+d6meUrhG1AxCMMTIljzjTFhJHUUnaayIIIzfa0Vl/3rmhDyUCOeddWb4ukFzubmOea1U
        2KhIie5pDb/QcsYgP30d/ymSx7pLxjdlKRPXRykyD3uTnrVzwbAxH7f01ykbA6TydKHKyt
        50aq3LG9zWYtXng8B8yP9LIiyBKR5Co=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        nikita@trvn.ru, robh+dt@kernel.org, stephan@gerhold.net,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916/39-samsung-a2015: Add flash LED
Message-ID: <ZOz4460Q/JQcMcU1@L14.lan>
References: <20230822140407.3316-1-raymondhackley@protonmail.com>
 <c016d9ac-da33-4a0b-8684-ab7b4b50ebe3@linaro.org>
 <20230822150035.3803-1-raymondhackley@protonmail.com>
 <fb452457-6687-4f68-9498-92a3077c9a44@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb452457-6687-4f68-9498-92a3077c9a44@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On Sat, Aug 26, 2023 at 02:09:38PM +0200, Konrad Dybcio wrote:
> On 22.08.2023 17:01, Raymond Hackley wrote:
> > Hi Konrad,
> > 
> >> What about the other subdevices registered with the RT5033 MFD?
> > 
> > Currently the MFD is not able to control the flash LED, due to missing
> > driver for it.
> > Alternatively we control it with GPIO pins. With driver leds-sgm3140, the
> > binding is not under the RT5033 MFD.
> Hm.. I have mixed feelings..
> 
> Does the led controlled onboard this chip have some super complex
> functionality that is going to be exposed through a specific driver
> and that is not exposed through the sgm3140 driver?

The rt5033-led&sgm3140 situation was discussed in msm8916-mainline
matrix room before, here is a summary for list.

Using the full rt5033-led driver (old patchset here [1]) has some
benefits, like:
* led can have different intensity levels
* led can (supposedly) be used in strobe mode

Using sgm3140 driver mostly works fine, but there could potentially be
situations where led stops working and a reboot to stock android
kernel is required to get it working again.  So far that has only been
reproduced by first booting a kernel with full rt5033-led driver
(based on [1]), and then booting a kernel using sgm3140 driver
instead.

[1] https://lore.kernel.org/linux-leds/1448446948-13729-1-git-send-email-ingi2.kim@samsung.com/

Best regards,
Henrik Grimler
