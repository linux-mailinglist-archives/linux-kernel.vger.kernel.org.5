Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F537FF1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjK3OWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345898AbjK3OWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:22:22 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3823EBD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:22:27 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so12886891fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701354145; x=1701958945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcqtO67BQ7Ejh6P/8TpQ51iGSACoSyE1ViV0XdGtiv4=;
        b=W9jYPet/EfM3iYoyBmkXjDA/Pox7W9qw6DzF/PddzsLS9mNy9yZ7m2CAXHX51F7tCY
         Zi9mI7+dwnJhCAQwUpWT2ySnAH+t8ORdTZ6Z7rOOBQyH0bIis+YcKkF9jPcy7ZYuXNXV
         TaGny+tJKrcbVW3DKc2MXg5Ovc/Us7qKMNSSCnQeDOV6PM+ILMOuz3NRO8E5QjHmJpVI
         ESZINm9+WL0MsffZS+Q68zjQZgYODkQFlsFcLqMJ4bWUqIFwYrGYZ5erIfKUbS22mJsH
         WhSKkKMR8gPKs4QJu0kUgxtKZrkiwuvWS798hKUCHorvE2MgE5W+Pj2x+JDeJl8RO0WY
         ExUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354145; x=1701958945;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcqtO67BQ7Ejh6P/8TpQ51iGSACoSyE1ViV0XdGtiv4=;
        b=UtLKVrMhDmGugTAANHQeLOuoIlP0KP12VfFv+Lb76Qco/cErJVCktdEX2KbuDKFwAu
         WnbJwvZyhACocaQo7E6qKlCcx9/Bl36/q2aEjaSxgo0LsDz7Ppg0YTTQFPG0G1cdbpcO
         ag6Sf63o2rlDktLVX+TZDaRRKnTdNgtB4yDg51V+2akK1tvQoAVEfZsUrJHprq87DQ1u
         CKch5OGQqJ8jIcXzYMFjdLEK52o1gWCDOJjUT57b7qXZ8dVAeyMxfYmr7o2l+OZ+Fchw
         R/U7gwc6dTRgTGkqbbA0dUWUHXufJjrtWu+sjnrv1I8T2dUu//9dp9d62X7IqSoJv57+
         I0Bw==
X-Gm-Message-State: AOJu0YzXyetAZq2R8ScQWUvw63t3iTEU+YGq9AeILGhBuojhdVCKjf1E
        kARDT+eEv1ct8eh2I74qi+4fMA==
X-Google-Smtp-Source: AGHT+IHK7509e2Z3egW/4opgwXQcb3Zrcg7N42KnHWmFyH0mSn++oWBJd1dPqEE/drzGHSJpGBYYkw==
X-Received: by 2002:a2e:9244:0:b0:2c9:bb10:5802 with SMTP id v4-20020a2e9244000000b002c9bb105802mr4689004ljg.19.1701354145305;
        Thu, 30 Nov 2023 06:22:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm2187975wmq.14.2023.11.30.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:22:24 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 30 Nov 2023 17:22:20 +0300
To:     oe-kbuild@lists.linux.dev,
        Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        luca.weiss@fairphone.com, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com,
        quic_gurus@quicinc.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: [PATCH v7 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Message-ID: <17a8a637-3477-41fe-959f-7784cf6d6b2e@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130013615.14287-5-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anjelique,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjelique-Melendez/dt-bindings-soc-qcom-Add-qcom-pbs-bindings/20231130-094701
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231130013615.14287-5-quic_amelende%40quicinc.com
patch subject: [PATCH v7 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
config: csky-randconfig-r071-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302200.RcTP9m0Y-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231130/202311302200.RcTP9m0Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311302200.RcTP9m0Y-lkp@intel.com/

smatch warnings:
drivers/leds/rgb/leds-qcom-lpg.c:1055 lpg_pattern_set() error: uninitialized symbol 'lo_pause'.
drivers/leds/rgb/leds-qcom-lpg.c:1056 lpg_pattern_set() error: uninitialized symbol 'hi_pause'.

vim +/lo_pause +1055 drivers/leds/rgb/leds-qcom-lpg.c

e98a860f65428a Bjorn Andersson    2022-05-23   904  static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
24e2d05d1b6898 Bjorn Andersson    2022-03-03   905  			   u32 len, int repeat)
24e2d05d1b6898 Bjorn Andersson    2022-03-03   906  {
24e2d05d1b6898 Bjorn Andersson    2022-03-03   907  	struct lpg_channel *chan;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   908  	struct lpg *lpg = led->lpg;
e98a860f65428a Bjorn Andersson    2022-05-23   909  	struct led_pattern *pattern;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   910  	unsigned int brightness_a;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   911  	unsigned int brightness_b;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   912  	unsigned int actual_len;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   913  	unsigned int hi_pause;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   914  	unsigned int lo_pause;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   915  	unsigned int delta_t;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   916  	unsigned int lo_idx;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   917  	unsigned int hi_idx;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   918  	unsigned int i;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   919  	bool ping_pong = true;
e98a860f65428a Bjorn Andersson    2022-05-23   920  	int ret = -EINVAL;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   921  
24e2d05d1b6898 Bjorn Andersson    2022-03-03   922  	/* Hardware only support oneshot or indefinite loops */
24e2d05d1b6898 Bjorn Andersson    2022-03-03   923  	if (repeat != -1 && repeat != 1)
24e2d05d1b6898 Bjorn Andersson    2022-03-03   924  		return -EINVAL;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   925  
e98a860f65428a Bjorn Andersson    2022-05-23   926  	/*
e98a860f65428a Bjorn Andersson    2022-05-23   927  	 * The standardized leds-trigger-pattern format defines that the
e98a860f65428a Bjorn Andersson    2022-05-23   928  	 * brightness of the LED follows a linear transition from one entry
e98a860f65428a Bjorn Andersson    2022-05-23   929  	 * in the pattern to the next, over the given delta_t time. It
e98a860f65428a Bjorn Andersson    2022-05-23   930  	 * describes that the way to perform instant transitions a zero-length
e98a860f65428a Bjorn Andersson    2022-05-23   931  	 * entry should be added following a pattern entry.
e98a860f65428a Bjorn Andersson    2022-05-23   932  	 *
e98a860f65428a Bjorn Andersson    2022-05-23   933  	 * The LPG hardware is only able to perform the latter (no linear
e98a860f65428a Bjorn Andersson    2022-05-23   934  	 * transitions), so require each entry in the pattern to be followed by
e98a860f65428a Bjorn Andersson    2022-05-23   935  	 * a zero-length transition.
e98a860f65428a Bjorn Andersson    2022-05-23   936  	 */
e98a860f65428a Bjorn Andersson    2022-05-23   937  	if (len % 2)
e98a860f65428a Bjorn Andersson    2022-05-23   938  		return -EINVAL;
e98a860f65428a Bjorn Andersson    2022-05-23   939  
e98a860f65428a Bjorn Andersson    2022-05-23   940  	pattern = kcalloc(len / 2, sizeof(*pattern), GFP_KERNEL);
e98a860f65428a Bjorn Andersson    2022-05-23   941  	if (!pattern)
e98a860f65428a Bjorn Andersson    2022-05-23   942  		return -ENOMEM;
e98a860f65428a Bjorn Andersson    2022-05-23   943  
e98a860f65428a Bjorn Andersson    2022-05-23   944  	for (i = 0; i < len; i += 2) {
e98a860f65428a Bjorn Andersson    2022-05-23   945  		if (led_pattern[i].brightness != led_pattern[i + 1].brightness)
e98a860f65428a Bjorn Andersson    2022-05-23   946  			goto out_free_pattern;
e98a860f65428a Bjorn Andersson    2022-05-23   947  		if (led_pattern[i + 1].delta_t != 0)
e98a860f65428a Bjorn Andersson    2022-05-23   948  			goto out_free_pattern;
e98a860f65428a Bjorn Andersson    2022-05-23   949  
e98a860f65428a Bjorn Andersson    2022-05-23   950  		pattern[i / 2].brightness = led_pattern[i].brightness;
e98a860f65428a Bjorn Andersson    2022-05-23   951  		pattern[i / 2].delta_t = led_pattern[i].delta_t;
e98a860f65428a Bjorn Andersson    2022-05-23   952  	}
e98a860f65428a Bjorn Andersson    2022-05-23   953  
e98a860f65428a Bjorn Andersson    2022-05-23   954  	len /= 2;
e98a860f65428a Bjorn Andersson    2022-05-23   955  
24e2d05d1b6898 Bjorn Andersson    2022-03-03   956  	/*
24e2d05d1b6898 Bjorn Andersson    2022-03-03   957  	 * Specifying a pattern of length 1 causes the hardware to iterate
24e2d05d1b6898 Bjorn Andersson    2022-03-03   958  	 * through the entire LUT, so prohibit this.
24e2d05d1b6898 Bjorn Andersson    2022-03-03   959  	 */
24e2d05d1b6898 Bjorn Andersson    2022-03-03   960  	if (len < 2)
e98a860f65428a Bjorn Andersson    2022-05-23   961  		goto out_free_pattern;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   962  
24e2d05d1b6898 Bjorn Andersson    2022-03-03   963  	/*
24e2d05d1b6898 Bjorn Andersson    2022-03-03   964  	 * The LPG plays patterns with at a fixed pace, a "low pause" can be
24e2d05d1b6898 Bjorn Andersson    2022-03-03   965  	 * used to stretch the first delay of the pattern and a "high pause"
24e2d05d1b6898 Bjorn Andersson    2022-03-03   966  	 * the last one.
24e2d05d1b6898 Bjorn Andersson    2022-03-03   967  	 *
24e2d05d1b6898 Bjorn Andersson    2022-03-03   968  	 * In order to save space the pattern can be played in "ping pong"
24e2d05d1b6898 Bjorn Andersson    2022-03-03   969  	 * mode, in which the pattern is first played forward, then "high
24e2d05d1b6898 Bjorn Andersson    2022-03-03   970  	 * pause" is applied, then the pattern is played backwards and finally
24e2d05d1b6898 Bjorn Andersson    2022-03-03   971  	 * the "low pause" is applied.
24e2d05d1b6898 Bjorn Andersson    2022-03-03   972  	 *
24e2d05d1b6898 Bjorn Andersson    2022-03-03   973  	 * The middle elements of the pattern are used to determine delta_t and
24e2d05d1b6898 Bjorn Andersson    2022-03-03   974  	 * the "low pause" and "high pause" multipliers are derrived from this.
24e2d05d1b6898 Bjorn Andersson    2022-03-03   975  	 *
24e2d05d1b6898 Bjorn Andersson    2022-03-03   976  	 * The first element in the pattern is used to determine "low pause".
24e2d05d1b6898 Bjorn Andersson    2022-03-03   977  	 *
24e2d05d1b6898 Bjorn Andersson    2022-03-03   978  	 * If the specified pattern is a palindrome the ping pong mode is
24e2d05d1b6898 Bjorn Andersson    2022-03-03   979  	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
24e2d05d1b6898 Bjorn Andersson    2022-03-03   980  	 * last in the programmed pattern) determines the "high pause".
05c1d2a258599b Anjelique Melendez 2023-11-29   981  	 *
05c1d2a258599b Anjelique Melendez 2023-11-29   982  	 * SDAM-based devices do not support "ping-pong", "low pause" or "high pause"
24e2d05d1b6898 Bjorn Andersson    2022-03-03   983  	 */
24e2d05d1b6898 Bjorn Andersson    2022-03-03   984  
24e2d05d1b6898 Bjorn Andersson    2022-03-03   985  	/* Detect palindromes and use "ping pong" to reduce LUT usage */
05c1d2a258599b Anjelique Melendez 2023-11-29   986  	if (lpg->lut_base) {
24e2d05d1b6898 Bjorn Andersson    2022-03-03   987  		for (i = 0; i < len / 2; i++) {
24e2d05d1b6898 Bjorn Andersson    2022-03-03   988  			brightness_a = pattern[i].brightness;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   989  			brightness_b = pattern[len - i - 1].brightness;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   990  
24e2d05d1b6898 Bjorn Andersson    2022-03-03   991  			if (brightness_a != brightness_b) {
24e2d05d1b6898 Bjorn Andersson    2022-03-03   992  				ping_pong = false;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   993  				break;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   994  			}
24e2d05d1b6898 Bjorn Andersson    2022-03-03   995  		}
05c1d2a258599b Anjelique Melendez 2023-11-29   996  	} else
05c1d2a258599b Anjelique Melendez 2023-11-29   997  		ping_pong = false;
24e2d05d1b6898 Bjorn Andersson    2022-03-03   998  
24e2d05d1b6898 Bjorn Andersson    2022-03-03   999  	/* The pattern length to be written to the LUT */
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1000  	if (ping_pong)
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1001  		actual_len = (len + 1) / 2;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1002  	else
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1003  		actual_len = len;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1004  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1005  	/*
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1006  	 * Validate that all delta_t in the pattern are the same, with the
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1007  	 * exception of the middle element in case of ping_pong.
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1008  	 */
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1009  	delta_t = pattern[1].delta_t;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1010  	for (i = 2; i < len; i++) {
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1011  		if (pattern[i].delta_t != delta_t) {
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1012  			/*
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1013  			 * Allow last entry in the full or shortened pattern to
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1014  			 * specify hi pause. Reject other variations.
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1015  			 */
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1016  			if (i != actual_len - 1)
e98a860f65428a Bjorn Andersson    2022-05-23  1017  				goto out_free_pattern;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1018  		}
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1019  	}
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1020  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1021  	/* LPG_RAMP_DURATION_REG is a 9bit */
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1022  	if (delta_t >= BIT(9))
e98a860f65428a Bjorn Andersson    2022-05-23  1023  		goto out_free_pattern;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1024  
05c1d2a258599b Anjelique Melendez 2023-11-29  1025  	/*
05c1d2a258599b Anjelique Melendez 2023-11-29  1026  	 * Find "low pause" and "high pause" in the pattern in the LUT case.
05c1d2a258599b Anjelique Melendez 2023-11-29  1027  	 * SDAM-based devices require equal duration of all steps
05c1d2a258599b Anjelique Melendez 2023-11-29  1028  	 */
05c1d2a258599b Anjelique Melendez 2023-11-29  1029  	if (lpg->lut_base) {
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1030  		lo_pause = pattern[0].delta_t;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1031  		hi_pause = pattern[actual_len - 1].delta_t;
05c1d2a258599b Anjelique Melendez 2023-11-29  1032  	} else {
05c1d2a258599b Anjelique Melendez 2023-11-29  1033  		if (delta_t != pattern[0].delta_t || delta_t != pattern[actual_len - 1].delta_t)
05c1d2a258599b Anjelique Melendez 2023-11-29  1034  			goto out_free_pattern;

lo_pause and hi_pause are not set on this else path

05c1d2a258599b Anjelique Melendez 2023-11-29  1035  	}
05c1d2a258599b Anjelique Melendez 2023-11-29  1036  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1037  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1038  	mutex_lock(&lpg->lock);
05c1d2a258599b Anjelique Melendez 2023-11-29  1039  
05c1d2a258599b Anjelique Melendez 2023-11-29  1040  	if (lpg->lut_base)
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1041  		ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
05c1d2a258599b Anjelique Melendez 2023-11-29  1042  	else
05c1d2a258599b Anjelique Melendez 2023-11-29  1043  		ret = lpg_lut_store_sdam(lpg, pattern, actual_len, &lo_idx, &hi_idx);
05c1d2a258599b Anjelique Melendez 2023-11-29  1044  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1045  	if (ret < 0)
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1046  		goto out_unlock;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1047  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1048  	for (i = 0; i < led->num_channels; i++) {
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1049  		chan = led->channels[i];
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1050  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1051  		chan->ramp_tick_ms = delta_t;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1052  		chan->ramp_ping_pong = ping_pong;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1053  		chan->ramp_oneshot = repeat != -1;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1054  
24e2d05d1b6898 Bjorn Andersson    2022-03-03 @1055  		chan->ramp_lo_pause_ms = lo_pause;
24e2d05d1b6898 Bjorn Andersson    2022-03-03 @1056  		chan->ramp_hi_pause_ms = hi_pause;
                                                                                         ^^^^^^^^

24e2d05d1b6898 Bjorn Andersson    2022-03-03  1057  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1058  		chan->pattern_lo_idx = lo_idx;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1059  		chan->pattern_hi_idx = hi_idx;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1060  	}
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1061  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1062  out_unlock:
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1063  	mutex_unlock(&lpg->lock);
e98a860f65428a Bjorn Andersson    2022-05-23  1064  out_free_pattern:
e98a860f65428a Bjorn Andersson    2022-05-23  1065  	kfree(pattern);
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1066  
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1067  	return ret;
24e2d05d1b6898 Bjorn Andersson    2022-03-03  1068  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

