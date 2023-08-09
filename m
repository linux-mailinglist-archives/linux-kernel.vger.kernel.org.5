Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E6775397
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHIHIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjHIHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:08:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A6E7D;
        Wed,  9 Aug 2023 00:08:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so953193266b.2;
        Wed, 09 Aug 2023 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691564898; x=1692169698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=efeZhhVQ7Hgd+Z5RFLNzm6TIjkcq+2KXdvMHgboSY+c=;
        b=gBizDH7SP+qvPi4NXoWxoAFk8kd8GYsHpwQalZ9/f0yCezaxs5Sh2EoGC9jVPWPDWO
         kw+QHmPyFcDN9xHUSShEGDzwbp5PVcs4U1wL1s8bAPvWM+S/2r5wePFD3qLUB7YwRCkx
         xDVK6GMgLZD4kjkl8oG0Nh2j6PZKwy0RZHdjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691564898; x=1692169698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efeZhhVQ7Hgd+Z5RFLNzm6TIjkcq+2KXdvMHgboSY+c=;
        b=ZH+BCJnwpHMQJoT1nfUPGZuynIHCHGR8Gv03o0iu9cRs9rE99Ev2jJ2df7lBUGzekv
         jO0aCKvjKD+9KGaSMbzBYiWcaGuCCBkjJN6fgT8Jw33IuInpTls3uyHUECRfgJjo6bSv
         zcky5tfsHv9pkSRuJXhFwMGSHCrJ4i7D0CduC2H4hq5ncRyXmX3vADSXHUXTgel0nWpq
         VC6WxL6tvxv6KnU+cwHcdHDkWHHTEn/A071BIfJAvgVhjcMjxRCnSmXbqSR9u2AOweBj
         xUsun+S35UkB4P02O7JJcFcHqV5wLMCzP/9vzT4bEhqNnfk5LPFRgxp0UOem2qUCE4vn
         aHsA==
X-Gm-Message-State: AOJu0Yzch7zpedaycP8hIG+7wvqJzBZ+tNg1LVM1DPa5735SziRVeaky
        /LWfy3DuGFTJvSc699Fur8I6tp796AuhRju20beU6xmtB88=
X-Google-Smtp-Source: AGHT+IG9WPtvvPFcs+JZhfNTSkTxgJ3NLyfBKSn18++X0ix38HHI9F/MDy5a5SjBBE0DCSrRFahuOMQ2XpWuMKw6D0k=
X-Received: by 2002:a17:906:10cb:b0:99b:e6ec:752c with SMTP id
 v11-20020a17090610cb00b0099be6ec752cmr1637690ejv.70.1691564898243; Wed, 09
 Aug 2023 00:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230612195657.245125-1-eajames@linux.ibm.com> <20230612195657.245125-12-eajames@linux.ibm.com>
In-Reply-To: <20230612195657.245125-12-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Aug 2023 07:08:05 +0000
Message-ID: <CACPK8Xe1OmLtLrONZmqib6BhDyPHzj+HcOd15MXyK0QVHPTOEg@mail.gmail.com>
Subject: Re: [PATCH 11/14] fsi: Improve master indexing
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 at 19:57, Eddie James <eajames@linux.ibm.com> wrote:
>
> Master indexing is problematic if a hub is rescanned while the
> root master is being rescanned. Move the IDA free below the device
> unregistration, lock the scan mutex in the probe function, and
> request a specific idx in the hub driver.

I've applied this series, but taking a closer look at this patch I
think it can be improved. If you resend, just send this patch.

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-core.c       | 41 ++++++++++++++++++++++--------------
>  drivers/fsi/fsi-master-hub.c |  2 ++
>  2 files changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index ec4d02264391..503061a6740b 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1327,46 +1327,55 @@ static struct class fsi_master_class = {
>  int fsi_master_register(struct fsi_master *master)
>  {
>         int rc;
> -       struct device_node *np;
>
>         mutex_init(&master->scan_lock);
> -       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
> +
> +       if (master->idx) {

Why do we allocate a new idx if there's already one?

> +               master->idx = ida_alloc_range(&master_ida, master->idx,
> +                                             master->idx, GFP_KERNEL);

If we can't get one in the range we want, we ask for any? Should this
print a warning?

> +               if (master->idx < 0)
> +                       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
> +       } else {

If ixd was zero, we create one. This is the "normal" case?

> +               master->idx = ida_alloc(&master_ida, GFP_KERNEL);
> +       }
> +

We check the same error condition again.

>         if (master->idx < 0)
>                 return master->idx;

>
> -       dev_set_name(&master->dev, "fsi%d", master->idx);
> +       if (!dev_name(&master->dev))
> +               dev_set_name(&master->dev, "fsi%d", master->idx);
> +
>         master->dev.class = &fsi_master_class;
>
> +       mutex_lock(&master->scan_lock);
>         rc = device_register(&master->dev);
>         if (rc) {
>                 ida_free(&master_ida, master->idx);
> -               return rc;
> -       }
> +       } else {
> +               struct device_node *np = dev_of_node(&master->dev);

This change looks a bit different to the idx changes. What's happening here?
>
> -       np = dev_of_node(&master->dev);
> -       if (!of_property_read_bool(np, "no-scan-on-init")) {
> -               mutex_lock(&master->scan_lock);
> -               fsi_master_scan(master);
> -               mutex_unlock(&master->scan_lock);
> +               if (!of_property_read_bool(np, "no-scan-on-init"))
> +                       fsi_master_scan(master);
>         }
>
> -       return 0;
> +       mutex_unlock(&master->scan_lock);
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(fsi_master_register);
>
>  void fsi_master_unregister(struct fsi_master *master)
>  {
> -       trace_fsi_master_unregister(master);
> +       int idx = master->idx;
>
> -       if (master->idx >= 0) {
> -               ida_free(&master_ida, master->idx);
> -               master->idx = -1;
> -       }
> +       trace_fsi_master_unregister(master);
>
>         mutex_lock(&master->scan_lock);
>         fsi_master_unscan(master);
> +       master->n_links = 0;
>         mutex_unlock(&master->scan_lock);
> +
>         device_unregister(&master->dev);
> +       ida_free(&master_ida, idx);
>  }
>  EXPORT_SYMBOL_GPL(fsi_master_unregister);
>
> diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
> index 6d8b6e8854e5..36da643b3201 100644
> --- a/drivers/fsi/fsi-master-hub.c
> +++ b/drivers/fsi/fsi-master-hub.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>
>  #include "fsi-master.h"
> +#include "fsi-slave.h"
>
>  #define FSI_ENGID_HUB_MASTER           0x1c
>
> @@ -229,6 +230,7 @@ static int hub_master_probe(struct device *dev)
>         hub->master.dev.release = hub_master_release;
>         hub->master.dev.of_node = of_node_get(dev_of_node(dev));
>
> +       hub->master.idx = fsi_dev->slave->link + 1;
>         hub->master.n_links = links;
>         hub->master.read = hub_master_read;
>         hub->master.write = hub_master_write;
> --
> 2.31.1
>
