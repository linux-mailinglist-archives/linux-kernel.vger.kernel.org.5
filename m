Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1B780D04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377433AbjHRNwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377444AbjHRNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B2035A1;
        Fri, 18 Aug 2023 06:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B209367C6D;
        Fri, 18 Aug 2023 13:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3480BC433C7;
        Fri, 18 Aug 2023 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366718;
        bh=1KZFBWNdlntFa/Z2Z1spldkJwv/aV42XP2jUCjlDuYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tLJL9dtGbh9q139iBzu32zpAArcdT1DRINlB6hjm7TcDprlYmB9W81ifSpWFxAO1Z
         kdqiQPnPbk3a8ShYaDJuH37KnySQCEtpu+SpVSG0jrQHhBc5rT53KLSiEC8vvcYMGL
         uveAobLdy2yNgJchg+RbCCkdJlqq7//Wmx3IsSmMe8ZLjOEl7UXS8M2B+VGQTqbqVq
         OhfeUZdCW7fpsrULCFkXk3wSgFzf3439uC0R874XwY5H2xBmLakvFBC/Tjgme9u43q
         1ftXQKf0NKDmzd00YWclftJXZh6MFuQnyT6cshwG0twHfJnb1Fa3+TYF6BybBR2BkH
         jm0L1HP++fIvA==
Message-ID: <09df85cd-27c7-d64c-9792-41110bf32fce@kernel.org>
Date:   Fri, 18 Aug 2023 15:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] pinctrl: qcom-pmic-gpio: silence -EPROBE_DEFER message on
 probe
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, linus.walleij@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817145941.1091418-1-bmasney@redhat.com>
 <a3431eaf-053a-4e1c-b082-e87a3aaefbf3@linaro.org> <ZN5KIlI+RDu92jsi@brian-x1>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZN5KIlI+RDu92jsi@brian-x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 18:26, Brian Masney wrote:
> On Thu, Aug 17, 2023 at 05:01:19PM +0200, Konrad Dybcio wrote:
>> On 17.08.2023 16:59, Brian Masney wrote:
>>> The following message shows up one or more times when booting a Qualcomm
>>> SA8775 Development board:
>>>
>>>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: can't add gpio chip
>>>
>>> Convert this over to use dev_err_probe() to silence this message.
>>>
>>> Signed-off-by: Brian Masney <bmasney@redhat.com>
>>> ---
>> That looks odd, why would it ever defer?
>>
>> SPMI should be up by the time it gets a chance to probe.
> 
> You replied within the same minute of me posting that patch, which is
> the fastest review I've had to date on an upstream kernel list. Before
> we continue, please verify:
> 
>               [ ] I am not a robot
> 
> :)
> 
> So SPMI is up and probes normally the first time, and is up by time this
> driver probes. I think the probe deferral is happening somewhere in
> pinctrl, however I am not sure exactly where. I added some tracers to
> the kernel command line and here's some relevant log messages:
> 
>     device: 'c440000.spmi:pmic@2:gpio@8800': device_add
>     bus: 'platform': add device c440000.spmi:pmic@2:gpio@8800
>     PM: Adding info for platform:c440000.spmi:pmic@2:gpio@8800
>     bus: 'platform': __driver_probe_device: matched device c440000.spmi:pmic@2:gpio@8800 with driver qcom-spmi-gpio
>     bus: 'platform': really_probe: probing driver qcom-spmi-gpio with device c440000.spmi:pmic@2:gpio@8800
>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: no pinctrl handle
>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: try to register 12 pins ...
>     pinctrl core: registered pin 0 (gpio1) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 1 (gpio2) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 2 (gpio3) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 3 (gpio4) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 4 (gpio5) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 5 (gpio6) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 6 (gpio7) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 7 (gpio8) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 8 (gpio9) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 9 (gpio10) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 10 (gpio11) on c440000.spmi:pmic@2:gpio@8800
>     pinctrl core: registered pin 11 (gpio12) on c440000.spmi:pmic@2:gpio@8800
>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: no hogs found
>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: error -EPROBE_DEFER: can't add gpio chip
>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: Driver qcom-spmi-gpio requests probe deferral
>     platform c440000.spmi:pmic@2:gpio@8800: Added to deferred list
> 
> The second time it probes the device is successfully added.

There is a bug in DTS. I'll send a patch.

Best regards,
Krzysztof

