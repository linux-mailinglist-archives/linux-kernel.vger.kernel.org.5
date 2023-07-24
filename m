Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF43E75EE47
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGXIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjGXIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:48:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A910E6;
        Mon, 24 Jul 2023 01:48:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68A326607029;
        Mon, 24 Jul 2023 09:48:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690188513;
        bh=Zjy3Rsv9lo1VbeTw2uMo83jvJBhbL51/vCj6P5OZnjw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oZtI02nAH/g+z3t+cRxRIxH4roa4RJN5x+XIvLlNZGUSJG/ZD9WCg6KScBrDgzecI
         V3AhzDnnVdo+M7mynMcm1TPlZg0JqhVqqw6pXC3aSFp+mHtOim2pjbzcSi08zH2g3J
         dRXlFdcW3W6AzhLAVvzHpvsCTR06h2/P9u3uWwUj9B75Zu0SbKvAk10eJUm1+qAeDC
         PGdqi/xPXd7lbXuAWX+qT3yJbxvDXDRSWuq6u0zXhockOWZ3ujEAn5JHEnIbDAKEMU
         FArdoWuoz5XeNoGenBD96pmAWCXYbZSma/qGAuYc81qOmsH6RJeNdVaqac6lSNaEn5
         FRpOOm6jQ/djA==
Message-ID: <55e72667-dec5-dab0-9d1b-dc127fe4d065@collabora.com>
Date:   Mon, 24 Jul 2023 10:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] drivers: soc: qcom: rpmpd: Fix MSM8976 power domains
 setup
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230723140712.9438-1-a39.skl@gmail.com>
 <20230723140712.9438-2-a39.skl@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230723140712.9438-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/07/23 16:06, Adam Skladowski ha scritto:
> Downstream kernel parses resource names based on pm8950-rpm-regulator.dtsi
> in such file qcom,resource-name takes three values: smpa,ldoa and clk0.
> First appearance of RWSC/RWSM point to msm-4.4 kernel

Are we sure that RWSC/RWSM being present isn't firmware-related?
What is the observed issue, why are you removing RWSC/RWSM and what did you
solve with that?

If it's just about dropping unused resources, that may be unused only on
firmware versions older than "X".

> which is way newer than what this platform was shipped with (msm-3.10).
> For the max_state downstream code limit value to TURBO inside dts
> with only one turbo_high being placed in msm-thermal bindings.
> One of effects of requesting TURBO_HIGH vote is rebooting of device
> which happens during voting inside WCNSS/IRIS,
> this behavior was observed on LeEco S2 smartphone.
> Fix regulator setup and drop unused resources.

That's fine, but you're missing a Fixes tag, which is required, being this a fix.

Regards,
Angelo

