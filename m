Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE9A79FDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjINIAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjINIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:00:49 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614E1BF6;
        Thu, 14 Sep 2023 01:00:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-64b8e1c739aso4415906d6.0;
        Thu, 14 Sep 2023 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694678444; x=1695283244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8F9T8J053YQMscaSaisfFP3x9A/nwLzOssGfj6BwlE=;
        b=CQgyUvvxbQYq47/SJT4JjNG2LpwkTooSL0/GS/VACVVyzP90nZlgOY8nLi+hAPLZAe
         lSHwpuhrD66hYTwdLliHG6Kxfz/fCbqyOSlTpNgVt5o0oST7CeEJAslJX6zQuB578BgQ
         wTRVU9s7HLDxPVJaE8e+3nNrLlNPq/VRMTgVDNLu6YOmQ1Dui4ew/jNnMrZuI33/jS/o
         WmrdbC5l+V+XUcs8HjOxaIwYJ8czNCZ1fub+zRE4A7gpcVjMpvTUAKetG5J+H9/dG8Xp
         MDKAZIixEXAUozpyFjcmgCmkcOisGLmAHLqjkXOixiWp7hrsJrb12sYX9wKbblKYeD79
         u//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694678444; x=1695283244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8F9T8J053YQMscaSaisfFP3x9A/nwLzOssGfj6BwlE=;
        b=vfFxsVOIxRiGZj5HT/JhLNUCht9ACdhJP6hiHNKS9zAx3IHtijD8EBfIyhdjz/262a
         gTm988keDfGA5gYKkrZIGC2hFynjkkbTO3EcrsGT33oHbgw5mx5pNLZX47pcy1Ny4TJy
         lX1EOv3tmSDncZ8vzaVush+FaLwvyTHIfp6n0yCJisEO6tEqqU9RGqkAvzhdirKIAAYJ
         WJjuAYGpSjdtciiWtYmRQhARLUAB22K3c5jmgJlIMUpvH1vFOJvulqv0kSHs/+/Nkdi1
         yIa8IfNylHGjVXujnNhXEBy/iIzL5WXRuAXLUEP1/icsBA+uN9Vz29vwKrVYMwLVz5wU
         4i0A==
X-Gm-Message-State: AOJu0YzvFv4oK6LeITOb8A1+sNhiN/Oev0HITUuzePGMAtCVZBUleyMj
        suNVYk5epSEpRHISltzg8n4Sp3NUBbST06AnG5U=
X-Google-Smtp-Source: AGHT+IERUzsU3IkZMmquqlUe6UZl/69j7L03jmUS7ZjX/Le1OWcDLACLhpLxe6Ojxsc/nAr7XtUGujfW+R2nfQgECqg=
X-Received: by 2002:a0c:ab4f:0:b0:656:1d37:3afd with SMTP id
 i15-20020a0cab4f000000b006561d373afdmr1066143qvb.54.1694678443965; Thu, 14
 Sep 2023 01:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230914000348.25790-1-michael@allwinnertech.com>
In-Reply-To: <20230914000348.25790-1-michael@allwinnertech.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Thu, 14 Sep 2023 16:00:32 +0800
Message-ID: <CA+Da2qzr0SBu-kUtFTnBqT+OObFOSTFgmU30L3B-Rjv3rYbGKw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add new flag to force hardware reset
To:     Michael Wu <michael@allwinnertech.com>
Cc:     ulf.hansson@linaro.org, CLoehle@hyperstone.com,
        adrian.hunter@intel.com, jinpu.wang@ionos.com, hare@suse.de,
        victor.shih@genesyslogic.com.tw, avri.altman@wdc.com,
        asuk4.q@gmail.com, axboe@kernel.dk, brauner@kernel.org,
        f.fainelli@gmail.com, beanhuo@micron.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 08:04, Michael Wu <michael@allwinnertech.com> wrote:
>
> Entering the recovery system itself indicates a transmission error.
> In this situation, we intend to execute the mmc_blk_reset function
> to clear any anomalies that may be caused by errors. We have previously
> discussed with several MMC device manufacturers, and they expressed
> their desire for us to reset the device when errors occur to ensure
> stable operation. We aim to make this code compatible with all devices
> and ensure its stable performance, so we would like to add this patch
>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>

like: https://lore.kernel.org/linux-mmc/20220603051534.22672-1-quic_sartgarg@quicinc.com/

You should enable it in the vendor host.

> ---
>  drivers/mmc/core/block.c | 2 +-
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b5b414a71e0b..29fbe0ddeadb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1503,7 +1503,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
>         pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
>
>         err = mmc_cqe_recovery(host);
> -       if (err)
> +       if (err || host->cqe_recovery_reset_always)
>                 mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
>         mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 62a6847a3b6f..f578541a06b5 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -518,6 +518,7 @@ struct mmc_host {
>         int                     cqe_qdepth;
>         bool                    cqe_enabled;
>         bool                    cqe_on;
> +       bool                    cqe_recovery_reset_always;
>
>         /* Inline encryption support */
>  #ifdef CONFIG_MMC_CRYPTO
> --
> 2.29.0
>
