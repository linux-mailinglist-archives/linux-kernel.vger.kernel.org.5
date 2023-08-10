Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E4776FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjHJFgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjHJFgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:36:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB4110C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:36:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so621374a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691645811; x=1692250611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E70CGhh2+uguNNkCmKDizWh7UGndS2uagniYJ3Qp99s=;
        b=DOT9neMnbLEeGCdx86v8AMCh/HeXNenJWKtLQNy4YpnCEtKYrDd5MH7a6mGNe0VmkB
         w4Cb/h0ORQM383FEUX9wpSkCVyRaoY3i8Ti98TCo0J4bmzl6t01Z7ssiGWqDAT0wsvj5
         SKtYbHYiUD4Vzd079rALARgJv6KX4VZ/5tzXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645811; x=1692250611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E70CGhh2+uguNNkCmKDizWh7UGndS2uagniYJ3Qp99s=;
        b=KEUGewAg5bfc6MgEpYNg7T3pyyBVMALXQXYE7cSdnI5kOu4pMnLj7eLF9b8628mbjE
         TTbU89bd5wBAnMUwkU4/51/dEXBXiYQlXWoOP4YOV4kbahejpfj2OUG5Eq0fopi5qNRp
         VzWQiwbBCzHvyvZtcV/sP1M365K7Fh9N9/UnRqjTIbOs3K2NV/cYI1Keg+Jh9PSCxw+X
         Mvz0UfKfXN7SyMuEge5/DIULJrlAqJwJrQRAYy8maOeTz1CQzTiLgqfvyni5dSgrMrZB
         XGzm+E9tZKAcQWh0h70ghhAK/DiBKXj/0h703h2iGtjYYFE/AvWxqhoLcORSyDN0e4kq
         AChw==
X-Gm-Message-State: AOJu0Yw72wTuhMQP+6x6qLPAavyG7FRxnAzXvrsq0ijPPGhB2elv3mzh
        kGMWqvBk5uqFMjOv+okO4QLxtVpJSeZcTQrbrBgKq46GCh4=
X-Google-Smtp-Source: AGHT+IGAiarOa8nG3yiSTyYX4n9FRQ0/Hze0TDu4HUbuSyXlioCNSCsw4d4adH6q+maY/qkvBrapuXcUDepSS2nelfw=
X-Received: by 2002:aa7:c704:0:b0:523:3fa1:6a34 with SMTP id
 i4-20020aa7c704000000b005233fa16a34mr900763edq.4.1691645811273; Wed, 09 Aug
 2023 22:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230809180814.151984-1-eajames@linux.ibm.com> <20230809180814.151984-3-eajames@linux.ibm.com>
In-Reply-To: <20230809180814.151984-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Aug 2023 05:36:39 +0000
Message-ID: <CACPK8XeFVjHxTZxx2GGUiWN9+yqNscCoOJSGw6vH-NkXOWw_kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsi: Lock mutex for master device registration
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        alistair@popple.id.au, k@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 18:08, Eddie James <eajames@linux.ibm.com> wrote:
>
> Because master device registration may cause hub master scans, or
> user scans may begin before device registration has ended, so the
> master scan lock must be held while registering the device.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-core.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index c7a002076292..ad50cdaf8421 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1306,7 +1306,6 @@ static struct class fsi_master_class = {
>  int fsi_master_register(struct fsi_master *master)
>  {
>         int rc;
> -       struct device_node *np;
>
>         mutex_init(&master->scan_lock);
>
> @@ -1326,20 +1325,19 @@ int fsi_master_register(struct fsi_master *master)
>
>         master->dev.class = &fsi_master_class;
>
> +       mutex_lock(&master->scan_lock);
>         rc = device_register(&master->dev);
>         if (rc) {
>                 ida_free(&master_ida, master->idx);
> -               return rc;
> -       }
> +       } else {

I kept getting stuck on the "if else" behaviour, but really the else
is just the non-error path following the device_register.

I reworked the patch to be like this:

--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1326,20 +1326,21 @@ int fsi_master_register(struct fsi_master *master)

        master->dev.class = &fsi_master_class;

+       mutex_lock(&master->scan_lock);
        rc = device_register(&master->dev);
        if (rc) {
                ida_free(&master_ida, master->idx);
-               return rc;
+               goto out;
        }

        np = dev_of_node(&master->dev);
        if (!of_property_read_bool(np, "no-scan-on-init")) {
-               mutex_lock(&master->scan_lock);
                fsi_master_scan(master);
-               mutex_unlock(&master->scan_lock);
        }

-       return 0;
+out:
+       mutex_unlock(&master->scan_lock);
+       return rc;
 }
 EXPORT_SYMBOL_GPL(fsi_master_register);

If you don't mind that style, can you send a new version with that?

> +               struct device_node *np = dev_of_node(&master->dev);
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
> --
> 2.39.3
>
