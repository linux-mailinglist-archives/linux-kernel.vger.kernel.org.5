Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A335805F77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjLEUcO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 15:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEUcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:32:13 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A1129;
        Tue,  5 Dec 2023 12:32:20 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b9b5b254e2so395882b6e.1;
        Tue, 05 Dec 2023 12:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808339; x=1702413139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrrURgKTtD+/aJbAAUAqOTwAaLDrzLDH8ZvaiOXDJfo=;
        b=iHGIIwRLgoj+n6VPUunhEHYW7TH8+5lQgEpGGBoeE+CL85yMf+sym7/Ri6cVFEPIaC
         pSgC1nLChtV2m3SU/OVsSChQdYYOgO2AutJFNk9xllzioeDNMnpGtGHSp1Y4JNlDIC60
         rsTFfJs2Z3jGH8WGjNUe+E3dveT5aKlRyGIA5rvXbCCBZDaiQHAtiA7E2pxYzMzDZfH3
         zvbOx8pZWF4+Sy7m2R1hMwj3oI/kHMo+jsBJlfiblBAWOq5ykYB/nDOvgmqlWXtNiUBr
         Tixq4+ynQYai5YMio8D6/Ae43NBNfslqX0pkOnheyIE1a01vsZS1tt3xO0FBdxEEQK1t
         5fWA==
X-Gm-Message-State: AOJu0YzB1T/+KI9kq60G5hG23bE/PWc34Kq15br0PbBaIlm2sb939sp2
        hEzijJH8hlGEiGkx7cFmBBAopQuBH5GUngehQTQ=
X-Google-Smtp-Source: AGHT+IGXU4XJWbJY2fCwe+yPX2kwu5P84xfw4o3ss15ZSGJpQCn0mpk9LtkheiRtcKEQN7sRSuHC3LmzYWMjcp+gd3c=
X-Received: by 2002:a05:6870:961f:b0:1fb:5e42:5096 with SMTP id
 d31-20020a056870961f00b001fb5e425096mr3848589oaq.5.1701808339245; Tue, 05 Dec
 2023 12:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20231120185942.2320424-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20231120185942.2320424-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 21:32:08 +0100
Message-ID: <CAJZ5v0iitqskhEU7jQGJpj_=panoLTkcnVMuY3ST_UN30J2aCA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Allow firmware balance performance
 EPP without code change
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 7:59 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Firmware can specify balance performance EPP value by enabling HWP and
> set EPP to a desired value. The current implementation requires code
> change for every generation to add an entry to intel_epp_balance_perf
> table.
>
> Some distributions like Chrome, which uses old kernels should be able
> to update balance performance EPP, without code change.
>
> There is a check to avoid updating EPP when the balance performance
> EPP is not changed and is power up default of 0x80. Move this check
> after checking if the HWP is enabled by the firmware and there is
> a valid EPP value set by the firmware.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index a534a1f7f1ee..dd6d23e389f1 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1691,13 +1691,6 @@ static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
>  {
>         cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
>
> -       /*
> -        * If this CPU gen doesn't call for change in balance_perf
> -        * EPP return.
> -        */
> -       if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE)
> -               return;
> -
>         /*
>          * If the EPP is set by firmware, which means that firmware enabled HWP
>          * - Is equal or less than 0x80 (default balance_perf EPP)
> @@ -1710,6 +1703,13 @@ static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
>                 return;
>         }
>
> +       /*
> +        * If this CPU gen doesn't call for change in balance_perf
> +        * EPP return.
> +        */
> +       if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE)
> +               return;
> +
>         /*
>          * Use hard coded value per gen to update the balance_perf
>          * and default EPP.
> --

Applied as 6.8 material with modified subject and changelog, thanks!
