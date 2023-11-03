Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9387E021C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbjKCLQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjKCLQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:16:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E3D4B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:16:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7dd65052aso23549347b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010203; x=1699615003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=buw+fPQjkqOoDJ8FzsNomO2ko/plF9LZXlM9e/ZYhhY=;
        b=yL+1gIOJp99Yc/HIpyHLBisbBEKXmzvMQvr3opwzR9L774pGIket9PdfXQ+HALqYCw
         pYhui5SrzUDQgeob+UVWKAYGcwDYEFdoWSCgfZyK2xIGl03qUUNqaTvr/sOTPps5tQ7U
         8wZxqJH2NuadX4PxZgS3erSHUJ43JTeAVbS5TtaWC1Ow4SDKWv50CeRr27FWymo5ZpDv
         cszQx1GdCKnjJHrJjc80iPrllxQEx7BsbYZNQnSOP3sbDhsHjtcsI3K+3KDazALZnWMP
         0PQcxg6IBoL3cPfT17EOFsvoCznzCFndVpsH3ZScZMyOcNVKE9/81TDPBU9ntfZ60ko+
         4Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010203; x=1699615003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buw+fPQjkqOoDJ8FzsNomO2ko/plF9LZXlM9e/ZYhhY=;
        b=QvhoYdkPswULnTSPcXcSEHHAKE4lj4+YzqIoBgzm4YiAFg1YNhcamzMcatIKtFNhgO
         Sh0e9Hvt0hUyj4AZA7hI5c5lHfvx32EpuySJDLxHhEZYaUCG09y2ucamoH5ZvbOD+6VG
         mxSz7La6WfHVCyDmjkWxqOBlwZnk0oJpcqMmHohWI5d7zbOwHcqzaWwnu+Jrco8k7VpV
         JOm2pmRUGFH3pqGb085ndmcdokuQDL0kldhXgqi5aYzIcUPK7ABjxTOFNHzLbCiW1wmU
         bKr7eodSYjPQfvAtkp/h+n2SDT43vdBda8LA2vYP9hiqpx9SXU/7dK6w4PzkSSconZZr
         p1lg==
X-Gm-Message-State: AOJu0YyxOzdgfzP/9h3QSVlZyD7VfmNiYNpV9/po0wU/hk7dxn7Grzob
        MQ81k2+fnI5jhF/m4MJ6QtkleyY2+j3GPawGtDBtLMxD83PNWaUi
X-Google-Smtp-Source: AGHT+IGyjr6NUayCQQujZiQaRSFdUxMLM11x+h8U7pT93Rf9UXiFzMrsaJqTmrsddlV1FpetiqrpSWTM/dUHzF7hDgo=
X-Received: by 2002:a25:b11c:0:b0:d9b:351:6657 with SMTP id
 g28-20020a25b11c000000b00d9b03516657mr20462930ybj.23.1699010203288; Fri, 03
 Nov 2023 04:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231026061458.1116276-1-n-yadav@ti.com>
In-Reply-To: <20231026061458.1116276-1-n-yadav@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:16:07 +0100
Message-ID: <CAPDyKFoxXHmFKOx2_Noi9s7Fd9CVuduwCu0wvm3OHRgaDeM7Gg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: fix start loop index for TAP value parsing
To:     Nitin Yadav <n-yadav@ti.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 08:15, Nitin Yadav <n-yadav@ti.com> wrote:
>
> ti,otap-del-sel-legacy/ti,itap-del-sel-legacy passed from DT
> are currently ignored for all SD/MMC and eMMC modes. Fix this
> by making start loop index to MMC_TIMING_LEGACY.
>
> Fixes: 8ee5fc0e0b3be ("mmc: sdhci_am654: Update OTAPDLY writes")
>
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 544aaaf5cb0f..aae9d255c6a1 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -606,7 +606,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>                 return 0;
>         }
>
> -       for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
> +       for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>
>                 ret = device_property_read_u32(dev, td[i].otap_binding,
>                                                &sdhci_am654->otap_del_sel[i]);
> --
> 2.25.1
>
