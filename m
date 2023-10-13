Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389AB7C8401
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjJMLFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJMLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:05:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E3591;
        Fri, 13 Oct 2023 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697195089; x=1697799889; i=wahrenst@gmx.net;
 bh=BGxj+BwMX9nFZ+QPVqdfKu6nxPXMvN1ZFDE1ETwj/UU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mGNc8fGN5CFeBrf3cMJZzlYQTA4Pi2mSo0gw/iPmCtfXr13qfASRS4IcyOxuNakIa5kV4RVK0Mp
 G0e1h5eMPzqnZijHg3SpSNI+R+YVeHL91NiR75L8J+KxwdLSVVfO4Mj11g/BlNV4/kHxhAyFjrLYq
 2ljqwHW0Xgem/klc/7OEOkS/fWrptAthLoR1A+Zepvyo4ZqGpMgFhwJUoU2l2nwNjYa/zYDS/fGN/
 4dJ5qQurQ9LCfmgjyWpiyuH4X/aLppXxVIUUkIbhw5FLIU+RNPa6ExnQKvLsi4nk7ah5zMW/h1sSE
 wqoRZXI0ADrjt59UoXIL59vQQJAATnYzqSlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1rA1HJ33Q4-00Imbj; Fri, 13
 Oct 2023 13:04:49 +0200
Message-ID: <84429d39-aa54-462d-85cd-c5d06a614a0e@gmx.net>
Date:   Fri, 13 Oct 2023 13:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pwm: bcm2835: allow pwm driver to be used in
 atomic context
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
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
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <6ce73b2688f059e7169935699044104cf37b2425.1697193646.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qLjsyI169mT2Sk8ihgWYDKWaaLC2Zmt0vdXtIJHfIiv4kXkywJG
 syJfFn2v0iHRui5dbQGZHr479RFRHmsOWrv6Qd0i4Xh08z+s+T6A9bXTQaEBb1YZEpS5sTg
 53qpWTB2FkzxVvcyYflc05Bx3IRo2ILYbTKUmNNIdCLNYSHg7699SOyMoJonAn/f/P16fHL
 AVTsmZY9YBgyemHPMcxRA==
UI-OutboundReport: notjunk:1;M01:P0:6u7BShyK3YU=;XcAGJXx8/appX345MJkquVx85SW
 HszGBOWCfqRjahvehWV1nhDEvcrLrc1/YG/HOe71Q1Gn7dSvC569fWzY4ol4q5TQ4v+2bEERA
 OVfPBle8rf/6tAb3gmR6Cw1rguSgRJ92QXQna4wTfWK1DkZ1Q8pclm2EZsfuWs+1biLTnMQsD
 pP0uXKAIgLBkwGlkyzLGU9CXGCLtWl/3WNgwRjGp8rZgVNqYQMcD9Jem6YWmxjnu3QqqsvpuI
 fccTftjU2yyVjoLg3FxMb9ZQEmjr45AJTyURsx5iJhtNgJpi/4xjw7zBmISGzHXU+EKp1I2Mm
 TtNhPIuMrzUwkAPlhunGcKKy1Ob5NGYCY/V0m5Qj+WumyAARE4bzuCzBByI8Bj1gbinFAsX+U
 9fFL2iNgcvclQi24ExAul5abBK9AeIaEshHP1dxUjJhFz8o/RkRS7RpwIK4SmJw5+77OQ0Q4a
 P7/IdEobmDlIKspP0WofOgpSHjP0JOIF6wWyzhVuUFRYk9QyhT3vqTYYGxJiWtuHmDyTzKphm
 rHH2+cYfd2JMlI6BVjZbOeHdtyJHX/2462KpoHvFjmJTZFpHvVBWsKZdPUyJmscJ9r3lIGW9+
 8RiBkfQeKz4j0JPxESVe40ZIC6VTJKXQ4RzRlC+Ik9W6V4eSMOfavX1OdrAYNSSPJCWc2tcSA
 ObIn0sBhspd8EBYzzjwsvfNMR8nLOK+CBwe6QXu2FsUtYYNaHTQlBNmWjHtlNtGAH6epFVbcg
 oniqfApzCsdRoPvIKWaw5QmSw10Xo++iPjGP7ghVqC/9JplFKD782E+Veqe4U22S5Oq3vZwCd
 5OAI5TBxS/lQZF51K/GbP4zaL47UU9X786Qq/Q9vCO5eNziIWLv/j7QmnDK04PMSx/vUSOAij
 MXuSO2GlVSvI1msf4R0BSFCAo1dtAMB+w/Gv9q+sBE3lXp6N1vVF0QpQvfvtjYbJsptGUsAhn
 5Ikx846gpTBCmw1JMRWcBrtygvs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Am 13.10.23 um 12:46 schrieb Sean Young:
> clk_get_rate() may do a mutex lock. Since the clock rate cannot change o=
n
> an rpi, simply fetch it once.
does it mean you checked all possible SoCs (BCM2835, BCM2836, BCM2837,
BCM2711, BCM2712) for this change?

Is it impossible that the real clock can never be influenced by turbo
mode like SPI?

Best regards
>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   drivers/pwm/pwm-bcm2835.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index bdfc2a5ec0d6..59ea154dd657 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -28,6 +28,7 @@ struct bcm2835_pwm {
>   	struct device *dev;
>   	void __iomem *base;
>   	struct clk *clk;
> +	unsigned long rate;
>   };
>
>   static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip=
)
> @@ -63,17 +64,11 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>   {
>
>   	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
> -	unsigned long rate =3D clk_get_rate(pc->clk);
>   	unsigned long long period_cycles;
>   	u64 max_period;
>
>   	u32 val;
>
> -	if (!rate) {
> -		dev_err(pc->dev, "failed to get clock rate\n");
> -		return -EINVAL;
> -	}
> -
>   	/*
>   	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_=
SEC
>   	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
> @@ -88,13 +83,13 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>   	 * <=3D> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
>   	 * <=3D> period <=3D ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) /=
 rate) - 1
>   	 */
> -	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER=
_SEC / 2, rate) - 1;
> +	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER=
_SEC / 2, pc->rate) - 1;
>
>   	if (state->period > max_period)
>   		return -EINVAL;
>
>   	/* set period */
> -	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * rate, NSEC_PER=
_SEC);
> +	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * pc->rate, NSEC=
_PER_SEC);
>
>   	/* don't accept a period that is too small */
>   	if (period_cycles < PERIOD_MIN)
> @@ -103,7 +98,7 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>   	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
>
>   	/* set duty cycle */
> -	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC);
> +	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pc->rate, NSEC_PER_S=
EC);
>   	writel(val, pc->base + DUTY(pwm->hwpwm));
>
>   	/* set polarity */
> @@ -129,6 +124,7 @@ static const struct pwm_ops bcm2835_pwm_ops =3D {
>   	.request =3D bcm2835_pwm_request,
>   	.free =3D bcm2835_pwm_free,
>   	.apply =3D bcm2835_pwm_apply,
> +	.atomic =3D true,
>   	.owner =3D THIS_MODULE,
>   };
>
> @@ -156,6 +152,13 @@ static int bcm2835_pwm_probe(struct platform_device=
 *pdev)
>   	if (ret)
>   		return ret;
>
> +	pc->rate =3D clk_get_rate(pc->clk);
> +	if (!pc->rate) {
> +		dev_err(pc->dev, "failed to get clock rate\n");
> +		ret =3D -EINVAL;
> +		goto add_fail;
> +	}
> +
>   	pc->chip.dev =3D &pdev->dev;
>   	pc->chip.ops =3D &bcm2835_pwm_ops;
>   	pc->chip.npwm =3D 2;

