Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F620779556
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjHKQzd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjHKQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:55:31 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB02D7D;
        Fri, 11 Aug 2023 09:55:31 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56d75fb64a6so415411eaf.0;
        Fri, 11 Aug 2023 09:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691772931; x=1692377731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTQqkkPYcIfD6dJJByzooT8UPz1lJcIxZqzAyRvmCqI=;
        b=HKJUEmbOQY8wgPsjB3lY6WRDW6v9FAfseYr58ZtYjhY506ozMkOdXBe+sKfEM+zg+W
         RqycZ0LBvBR9pe4ms17GSTfW1rINvASkPAenajuVqlx4FDh/wd37e8vU+C8UQjPJdQQ9
         O5CBcd2hB4uuEtauTb1UhnCH0GUBmU9yS3YynkiolWONUPkkeK0SAedchSMV8/hyse4E
         jlhwydJ0JDJhaTZ+8vLrWHfbhz9Li1cGDyt54lREtqhf5Y4xXswvWzmY+zBoTVpGTdhx
         6m4yJ6SuCcpL2cIk1VkqHuUjHurG+P40BES/aVNPowwOw6egRi/uNAkeOPcsPXfR55jp
         dj0Q==
X-Gm-Message-State: AOJu0YwTRkAVhSeuBISjgf15uP30VOpGVqHX5e15fGs1GWJKtP2tGnqN
        a717iKsGIxCxnUWQPzSQnyReXnsiCdx84dU03FbCVQR4ZZQ=
X-Google-Smtp-Source: AGHT+IEVa+py3wEfHBgVZ95VICoZy/Uf5NEmDzrfAEH99viNNNjK0BKnRZJ+96adoYzQDJR6Xpdhkda0vL6Sno2PjCk=
X-Received: by 2002:a05:6820:1ace:b0:560:b01a:653d with SMTP id
 bu14-20020a0568201ace00b00560b01a653dmr2308895oob.0.1691772930921; Fri, 11
 Aug 2023 09:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230811084523.1689671-1-rui.zhang@intel.com>
In-Reply-To: <20230811084523.1689671-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 18:55:19 +0200
Message-ID: <CAJZ5v0jgvfzN+Ug9G_gLV=NXLvfmuC98XzjLes709g2uypQ5nA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: intel_soc_dts_iosf: Fix thermal_zone removal
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rafael.j.wysocki@intel.com, daniel.lezcano@linaro.or,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Fri, Aug 11, 2023 at 10:45 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> All of the existing callers of remove_dts_thermal_zone() pass a valid
> pointer as the argument, so checking for the NULL pointer is redundant.

True.

> Plus, when calling remove_dts_thermal_zone() from
> intel_soc_dts_iosf_init(), it is possible that
> 1. dts->tzone is an error pointer, when the sensor fails to be
>    registered as a valid thermal zone
> 2. dts->tzone is unregistered in add_dts_thermal_zone(), when some
>    failure occurs after thermal zone registered
> In both cases, there is no need to unregister dts->tzone in
> remove_dts_thermal_zone().
>
> Clear dst->tzone when add_dts_thermal_zone() fails. And do thermal zone
> removal in remove_dts_thermal_zone() only when dts->tzone is set.

Well, I'm not sure.

thermal_zone_device_unregister() will do nothing if the thermal zone
is not really registered AFAICS and it is prudent to restore
SOC_DTS_OFFSET_ENABLE on failure IMO.


> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/intel/intel_soc_dts_iosf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
> index 7a66d0f077b0..c5203ba8f0b9 100644
> --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> @@ -212,7 +212,7 @@ static int soc_dts_enable(int id)
>
>  static void remove_dts_thermal_zone(struct intel_soc_dts_sensor_entry *dts)
>  {
> -       if (dts) {
> +       if (dts->tzone) {
>                 iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
>                                SOC_DTS_OFFSET_ENABLE, dts->store_status);
>                 thermal_zone_device_unregister(dts->tzone);
> @@ -277,6 +277,7 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
>  err_enable:
>         thermal_zone_device_unregister(dts->tzone);
>  err_ret:
> +       dts->tzone = NULL;
>         return ret;
>  }
>
> --
> 2.34.1
>
