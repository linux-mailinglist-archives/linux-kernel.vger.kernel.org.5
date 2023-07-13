Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E937526B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjGMPYC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGMPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:24:00 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617C134;
        Thu, 13 Jul 2023 08:23:59 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98dfd15aae1so21042966b.0;
        Thu, 13 Jul 2023 08:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261838; x=1689866638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrE6LY2wmxVu6SrdiDWyyjLd4AHotqYK1QoQuBvkj3M=;
        b=gXIBMETr61BUB80tiimK2MUVz1hlRVmjDssCE/6ofBA4kOB+fGBvyCfaVugVHKAlLL
         IS/J/HgXuVzEZh4Vk2Vgadavee7uiVZZvNaTxTn63GWEQErqF+LiKQhw+PXDipCyEILF
         DM39Y0tyOWq5J3l7S9ghv7k6ucz6UZEAki66P0Cf2wy7rlFRbxyDId715o9iRA0+W6mQ
         Sm5j5nSSvxJVZ5EgTyOorzOHf8SphGYLx4V0ZVSy5PXvulzYjJW/oxvlxHZXr3sbelbU
         wne4roF7TCOmgGJsMH3el0SJ9o9CeN3XEowcRXDsqPucqOg6r8AeG8/X5l+kyFSUn/sg
         RCzQ==
X-Gm-Message-State: ABy/qLYtlMWlEfxiOS8RYBVDpfwQzhm4bfz8MMddBSMNiMGkP2lmY92h
        gBdfwv4wizGlMPPZA88F+LXqb2r7+EEBuPiNNvY=
X-Google-Smtp-Source: APBJJlGi3f9rnzgFLBm8Q9r1GpDwzKwioXzayy1WG2P4eJ1Q49QD9da5U9DpCLrgyjqsUkso5pyRyPPd+sB1bbq+/pM=
X-Received: by 2002:a17:906:74dc:b0:994:1808:176b with SMTP id
 z28-20020a17090674dc00b009941808176bmr1254391ejl.6.1689261838133; Thu, 13 Jul
 2023 08:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230703080252.2899090-1-michal.wilczynski@intel.com> <20230703080252.2899090-9-michal.wilczynski@intel.com>
In-Reply-To: <20230703080252.2899090-9-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jul 2023 17:23:47 +0200
Message-ID: <CAJZ5v0jDOOhcTcYnDrkWbto1f_XJRs4Yd3huQcRJhhCoBGVcQA@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] acpi/nfit: Remove unnecessary .remove callback
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        dan.j.williams@intel.com
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 10:03 AM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Nfit driver doesn't use .remove() callback and provide an empty function
> as it's .remove() callback. Remove empty acpi_nfit_remove() and
> initialization of callback.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>

This one is not strictly related to the rest of the series, but it
does depend on the previous one, so assuming that the previous one is
not objectionable, I suppose I can take them both.  Dan?

> ---
>  drivers/acpi/nfit/core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 124e928647d3..16bf17a3d6ff 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3402,11 +3402,6 @@ static int acpi_nfit_add(struct acpi_device *adev)
>                                         adev);
>  }
>
> -static void acpi_nfit_remove(struct acpi_device *adev)
> -{
> -       /* see acpi_nfit_unregister */
> -}
> -
>  static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
>  {
>         struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
> @@ -3488,7 +3483,6 @@ static struct acpi_driver acpi_nfit_driver = {
>         .ids = acpi_nfit_ids,
>         .ops = {
>                 .add = acpi_nfit_add,
> -               .remove = acpi_nfit_remove,
>         },
>  };
>
> --
> 2.41.0
>
