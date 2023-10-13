Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DD77C84C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjJMLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjJMLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:44:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0CA9;
        Fri, 13 Oct 2023 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697197444; x=1697802244; i=wahrenst@gmx.net;
 bh=E4sw15hwyU1NoY3bpxUcoqkpulP82Jyjh/33cePxKVY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dCbnNtRufzgrj4khU2quh8TeUnw+qAOaaJnlXwUUZOysUCuQwU9JG/Sl868B8cyelaj+nBqAp8u
 +R5Mq9NiOoz8FwdUX0c5IYPbcnTKhbml9fiWVPtlzrpvUwcMM9fN75Sm5nJcv/LN0E31SrbpV1fTi
 8wzEdUCIMLoS416avfYkz1PBoD/i6se/u5oh1UfuIVnlzyC1pPqfpuwRMCJAGJ84YTeY22XTvSLbW
 0piPY46oKlctDmQ4n8ZQdyu6p0AmgUKt+l8SNN3I7DU8yITWv08d67LnMXUBE30PvLmcANEPkQIx4
 4pWztymLA6T2XzLzf3Y3irrwnbPwqMKFgztg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1rJPoA0R54-00jpYz; Fri, 13
 Oct 2023 13:44:04 +0200
Message-ID: <cc563313-32d7-4098-b93a-1fa06b8afb02@gmx.net>
Date:   Fri, 13 Oct 2023 13:44:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1697193646.git.sean@mess.org>
 <6ce73b2688f059e7169935699044104cf37b2425.1697193646.git.sean@mess.org>
 <84429d39-aa54-462d-85cd-c5d06a614a0e@gmx.net> <5203415.ElGaqSPkdT@steina-w>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <5203415.ElGaqSPkdT@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qh12HCIU2Roj9OjwMebuwIGpz/NlTN7LEbnAxJqOjHR2EIEGyAj
 HTfwTsTqzi++7mMrYcLBVLAdNFmf1Isrx4WjIUkoZtA3C4NT4cm6vMVPWaRDoT2ul89Ax3M
 YD+wae6bJEZb6tnqpt/XZVCj6vdDCiISxGRwduACeeXAIi00OpWLtEzItfR3Cm+y3Ov76Cj
 SM56uGMzw2UKTKDF9BDVQ==
UI-OutboundReport: notjunk:1;M01:P0:FMHCN7HlECo=;hI+W6/zWR3y5IrZq8KhsuQJi658
 bxReskx8vfTv7lsAbSuBftqGLAzaa6RsqLBpqkcSUJODyaT6xDDv2GLRJCugC2reftQy4j3c5
 /gly1mBONRbocjeOOPWeziFdph2DxKD99QXhXHQNDTMnP8nypGHWq7kw5LqDRroRuKFpFglsH
 a+Gn4Sweg80Vlu8eO5qaovkr4Y5YPE/FzBq25hXjXD6EBMguEXWRQPS3d+7FbgFg7yTPYX4lS
 4rztiYRUtZ2HLc3pRp1MiWtWs6Z11oFZZ7U/lTH2GWzrkW5TcUwbx7YnDCEdKqiOdhLq5qDpm
 /vmgGX0y8Ue1BiUjXsYjJdu8TcIOaaYyzOAOnrk24pBC6htTvHcFXGBga/dckw6TDYYiK8Pva
 ouB7hFsQoH1P876TkwIZ+rY+lRKS2Ap+HZOCbB0pBDJ5EcxT3y59vYBMbs4Nf/2ir/Cpcb2LE
 dOdTtzSYMq6JitSAtcRfExv71WzGE4Gx4eZ9E62Iv0LzSnPmGQB5oTuMMjNmctf4Amwwq+5f8
 WIUBbQDQhTWd6aTrxR9DDN1wdkjnCqdlU1M5A35JOUI+ixxsjvXeUY/g80r550dcJZY7Ababm
 8CUzjVhoWQlMaxLh7cpra/+m00OO/JHiQ5MPQzwION3yUwmWa4KBOfMtaOK7ZfwiF+Yhhs4ad
 bHspF0tYHDW4OjN+zSt+XcIm1h1shvdUFb70Sz/kVhUzvUhukR2EexQDJbJnHBwwwbLglG3zM
 /V/Fx0Jalo0hZEZQ73pUtiLf9nIbgqyA3xVcjWUaAAA8cjms7y+4wAuOgd0PYdY2yd/urS09S
 LnTyZTAVVJNb+lywykng1u3cvQvoe517pJ2OkQ/kwsODJSxCcHGyScA5xbJWInSvJ4DPll/Sz
 t/kxVLAsPZGmG7jZFVOHnKlIWDm4xkHVRsFoMbIlKWM8a4Llf/xQXO3XfzcRC5lsvDo4Z8yw8
 ZdQ//jrvO9HiqPJwWLUguU0mfSs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Am 13.10.23 um 13:13 schrieb Alexander Stein:
> Hi,
>
> Am Freitag, 13. Oktober 2023, 13:04:48 CEST schrieb Stefan Wahren:
>> Hi Sean,
>>
>> Am 13.10.23 um 12:46 schrieb Sean Young:
>>> clk_get_rate() may do a mutex lock. Since the clock rate cannot change=
 on
>>> an rpi, simply fetch it once.
>> does it mean you checked all possible SoCs (BCM2835, BCM2836, BCM2837,
>> BCM2711, BCM2712) for this change?
>>
>> Is it impossible that the real clock can never be influenced by turbo
>> mode like SPI?
> Assuming the clock can change, which I would, then a clock notifier seem=
s
> appropriate. See [1] for an example.
i remember a similiar approach for the CPU frequency for the RPi. At end
the we decided to let the firmware handle it and don't use clock
notifier, see [2] and the related links for more background. The fact
that the VideoCore has the real control makes it hard.

I don't want to say that's impossible.

[2] -
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20190520104708=
.11980-1-nsaenzjulienne@suse.de/
>
> Best regards,
> Alexander
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> commit/?id=3D90ad2cbe88c22d0215225ab9594eeead0eb24fde
>
>> Best regards
>>
>>> Signed-off-by: Sean Young <sean@mess.org>
>>> ---
>>>
>>>    drivers/pwm/pwm-bcm2835.c | 21 ++++++++++++---------
>>>    1 file changed, 12 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
>>> index bdfc2a5ec0d6..59ea154dd657 100644
>>> --- a/drivers/pwm/pwm-bcm2835.c
>>> +++ b/drivers/pwm/pwm-bcm2835.c
>>> @@ -28,6 +28,7 @@ struct bcm2835_pwm {
>>>
>>>    	struct device *dev;
>>>    	void __iomem *base;
>>>    	struct clk *clk;
>>>
>>> +	unsigned long rate;
>>>
>>>    };
>>>
>>>    static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *c=
hip)
>>>
>>> @@ -63,17 +64,11 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip=
,
>>> struct pwm_device *pwm,>
>>>    {
>>>
>>>    	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
>>>
>>> -	unsigned long rate =3D clk_get_rate(pc->clk);
>>>
>>>    	unsigned long long period_cycles;
>>>    	u64 max_period;
>>>
>>>    	u32 val;
>>>
>>> -	if (!rate) {
>>> -		dev_err(pc->dev, "failed to get clock rate\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>>
>>>    	/*
>>>
>>>    	 * period_cycles must be a 32 bit value, so period * rate /
>>>    	 NSEC_PER_SEC
>>>    	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
>>>
>>> @@ -88,13 +83,13 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip=
,
>>> struct pwm_device *pwm,>
>>>    	 * <=3D> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rat=
e
>>>    	 * <=3D> period <=3D ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2=
) /
> rate)
>>>    	 - 1
>>>    	 */
>>>
>>> -	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC +
> NSEC_PER_SEC
>>> / 2, rate) - 1; +	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX *
>>> NSEC_PER_SEC + NSEC_PER_SEC / 2, pc->rate) - 1;>
>>>    	if (state->period > max_period)
>>>
>>>    		return -EINVAL;
>>>
>>>    	/* set period */
>>>
>>> -	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * rate,
>>> NSEC_PER_SEC); +	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period=
 *
>>> pc->rate, NSEC_PER_SEC);>
>>>    	/* don't accept a period that is too small */
>>>    	if (period_cycles < PERIOD_MIN)
>>>
>>> @@ -103,7 +98,7 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip,
>>> struct pwm_device *pwm,>
>>>    	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
>>>
>>>    	/* set duty cycle */
>>>
>>> -	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC=
);
>>> +	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pc->rate,
> NSEC_PER_SEC);
>>>    	writel(val, pc->base + DUTY(pwm->hwpwm));
>>>
>>>    	/* set polarity */
>>>
>>> @@ -129,6 +124,7 @@ static const struct pwm_ops bcm2835_pwm_ops =3D {
>>>
>>>    	.request =3D bcm2835_pwm_request,
>>>    	.free =3D bcm2835_pwm_free,
>>>    	.apply =3D bcm2835_pwm_apply,
>>>
>>> +	.atomic =3D true,
>>>
>>>    	.owner =3D THIS_MODULE,
>>>
>>>    };
>>>
>>> @@ -156,6 +152,13 @@ static int bcm2835_pwm_probe(struct platform_devi=
ce
>>> *pdev)>
>>>    	if (ret)
>>>
>>>    		return ret;
>>>
>>> +	pc->rate =3D clk_get_rate(pc->clk);
>>> +	if (!pc->rate) {
>>> +		dev_err(pc->dev, "failed to get clock rate\n");
>>> +		ret =3D -EINVAL;
>>> +		goto add_fail;
>>> +	}
>>> +
>>>
>>>    	pc->chip.dev =3D &pdev->dev;
>>>    	pc->chip.ops =3D &bcm2835_pwm_ops;
>>>    	pc->chip.npwm =3D 2;
>

