Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4C7AF37F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjIZS7w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjIZS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:59:50 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CE19F;
        Tue, 26 Sep 2023 11:59:43 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57de3096e25so74902eaf.1;
        Tue, 26 Sep 2023 11:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754783; x=1696359583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmWKOKQNOrostcE1rGyRT5Onp9uerQjKsYo9gD15hsI=;
        b=vjFATSqSkkJOYtThMKaVAveoqAIe54E/00/rGi3NM07By7PFXTDLJZ0EbCM0uZk6CC
         wYxQNGT37NXvo+P/gSboLLSZ55KB0pgUIaOR6vhqcHzeuY/kdXW3lihh7rNoMuPAi7gr
         Yrz6oTNuA4COKx+otDd7OvklXDUXjhz4fGOosfb+dfhknGDanujhMIy6cyne/lJCRDYk
         4n1vf9Z93Jn8pAY+0IdnrJkc12zExrkTpN7G2UECKyv1+XJSVF5qhWACQWSi0WoXc3Bt
         HWb9STf+/Jz2eOZYPOkCKwEYT5c2t+OmQ7ov71lY+8ixcuYMv0v2JYv3bpr4XI8yuR6A
         r6jA==
X-Gm-Message-State: AOJu0YwSEGmTNBOpsbKy664goIb7FLlfcuSxy18prfhNYO2cy8SZMaau
        VEiR6v/Di6+YF/0LdLCVYC+tf+7RZrYo7xMGEoA=
X-Google-Smtp-Source: AGHT+IH82fsk/562NGICov+e19KkLRSnGzrgy+pt38rjz/fKu0w06yw2p/yPJDSQAkftW9gukCo37/8K0j1AFzpinmw=
X-Received: by 2002:a4a:de15:0:b0:57b:7804:9d72 with SMTP id
 y21-20020a4ade15000000b0057b78049d72mr9818067oot.1.1695754782938; Tue, 26 Sep
 2023 11:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-9-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-9-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 20:59:32 +0200
Message-ID: <CAJZ5v0hM3DvEZSyDubd29bkEPDv6JUm8FaKM8+suaWOpKESp+w@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] PM: EM: Add update_power() callback for runtime modifications
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Energy Model (EM) is going to support runtime modifications. This
> new callback would be used in the upcoming EM changes. The drivers
> or frameworks which want to modify the EM have to implement the
> update_power() callback.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index d236e08e80dc..546dee90f716 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -168,6 +168,26 @@ struct em_data_callback {
>          */
>         int (*get_cost)(struct device *dev, unsigned long freq,
>                         unsigned long *cost);
> +
> +       /**
> +        * update_power() - Provide new power at the given performance state of
> +        *              a device

The meaning of the above is unclear to me.

> +        * @dev         : Device for which we do this operation (can be a CPU)

It is unclear what "we" means in this context.  Maybe say "Target
device (can be a CPU)"?

> +        * @freq        : Frequency at the performance state in kHz

What performance state does this refer to?  And the frequency of what?

> +        * @power       : New power value at the performance state
> +        *              (modified)

Similarly unclear as the above.

> +        * @priv        : Pointer to private data useful for tracking context
> +        *              during runtime modifications of EM.

Who's going to set this pointer and use this data?

> +        *
> +        * The update_power() is used by runtime modifiable EM. It aims to

I would drop "The" from the above.

> +        * provide updated power value for a given frequency, which is stored
> +        * in the performance state.

A given frequency of what and the performance state of what does this refer to?

> + The power value provided by this callback
> +        * should fit in the [0, EM_MAX_POWER] range.
> +        *
> +        * Return 0 on success, or appropriate error value in case of failure.
> +        */
> +       int (*update_power)(struct device *dev, unsigned long freq,
> +                           unsigned long *power, void *priv);
>  };
>  #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
>  #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb)     \
> @@ -175,6 +195,7 @@ struct em_data_callback {
>           .get_cost = _cost_cb }
>  #define EM_DATA_CB(_active_power_cb)                   \
>                 EM_ADV_DATA_CB(_active_power_cb, NULL)
> +#define EM_UPDATE_CB(_update_power_cb) { .update_power = &_update_power_cb }
>
>  struct em_perf_domain *em_cpu_get(int cpu);
>  struct em_perf_domain *em_pd_get(struct device *dev);
> @@ -331,6 +352,7 @@ struct em_data_callback {};
>  #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
>  #define EM_DATA_CB(_active_power_cb) { }
>  #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)
> +#define EM_UPDATE_CB(_update_cb) { }
>
>  static inline
>  int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> --
