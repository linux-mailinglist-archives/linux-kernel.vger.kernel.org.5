Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AB80A5B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573987AbjLHOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573983AbjLHOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:37:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90AD1996;
        Fri,  8 Dec 2023 06:37:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702046247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wTnEfkDV0ksdFlV4Uy6ZwJKJWVB47H0+VrHAzxTWeNI=;
        b=t1ZgvjeFbVz8d5yWkvuAn4KGcNmzXXXDp3ImQ2rPznUWM0tLTY97zxVTGx7tcHvQo5B8Tk
        m5pCuhxDRCN5t0ilmAItG0moTvLNa3f/E00sjK0R1EiddkwGd794dvtEBDNuFa7EmPlo6N
        PDkKdBgLh4+xDBvz0izz4GyrkOcqOpyep8JDQyTCC+PfDhE6xrshpXPOgAGDBKwqVSaHW3
        ZRxz+b2yzsWXCYqVcJaFp+PlUAUkWkkMcEgWZ5YOy4iNNJG4TY2TkvpqQO3K/A1FBg/3pi
        bqWonSQzpLRd5l+sZGLyb6Roz+cyij2HdVvvhXDRSyOIGkyOGofk+mkNxd3U3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702046247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wTnEfkDV0ksdFlV4Uy6ZwJKJWVB47H0+VrHAzxTWeNI=;
        b=TAqNS9gY2mYV8Xm381n6vh/SXLE+MsVcYcieubV8l2ogD49Fixu20Kq6QLJArHHNxiIqsq
        nSbeawYIBDQUVzAg==
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v7 2/2] irqchip: irq-qcom-mpm: Support passing a slice
 of SRAM as reg space
In-Reply-To: <20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org>
References: <20230328-topic-msgram_mpm-v7-0-6ee2bfeaac2c@linaro.org>
 <20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org>
Date:   Fri, 08 Dec 2023 15:37:26 +0100
Message-ID: <87fs0csqu1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27 2023 at 16:52, Konrad Dybcio wrote:

The prefix in the subject is wrong. Also please write out register. This
is not Xitter.

> The MPM hardware is accessible to us from the ARM CPUs through a shared

to us? Can you access that hardware? I doubt it.

Please use neutral tone as documented in Documentation/process/

> memory region (RPM MSG RAM) that's also concurrently accessed by other
> kinds of cores on the system (like modem, ADSP etc.). Modeling this
> relation in a (somewhat) sane manner in the device tree basically
> requires us to either present the MPM as a child of said memory region
> (which makes little sense, as a mapped memory carveout is not a bus),
> define nodes which bleed their register spaces into one another, or
> passing their slice of the MSG RAM through some kind of a property.
>
> Go with the third option and add a way to map a region passed through
> the "qcom,rpm-msg-ram" property as our register space.
>
> The current way of using 'reg' is preserved for ABI reasons.

It's not an ABI reason. It's backwards compatibility with old device
trees, right?

I'll fix it up for you this time. No need to resend.

Thanks,

        tglx
