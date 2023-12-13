Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372E881121F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379010AbjLMMxY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379122AbjLMMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:53:05 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC93255;
        Wed, 13 Dec 2023 04:51:55 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso789363fac.1;
        Wed, 13 Dec 2023 04:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702471915; x=1703076715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZdG9f53iWojvJlp0dRw/Gg/hPo7SN2nW69zkEzGkVc=;
        b=W1pXWwFkwzmRKIDDKWarwgG9EzuwcjxW9pbM6JPS+f1+M8x3MxFaLCHyGAM0aunXvZ
         BRRxZTJT4TKxfZIdKkhxmt4RVvQihTIElSmFsIUtfbUXhsLM8RquBxhi9x2aNDNe9m7X
         EAOb1D5wAoVxeeP21O3o3Qe2Dgc3cJpTTVbGoBNf88Q8pQMIv/iYyHnYXaMxwQ+nVXry
         M2ecEEekt/BsvGGqnFLSJL7eePvPJqWBbK1Qbao5nLGxVk1UK8QHOF//v+Wkpc5ExHc3
         M4Q/JHaVU8nNr8BJ7yWAIFR6W48K2pTs+iR7eVc58FYilPh+FlhPkhdZkPs9bs2vh+QM
         kTuw==
X-Gm-Message-State: AOJu0Yx1ZUz225Ir0PqkMNNuzlnrlGd0e/3r18+yM3YAw8CXe53pNuMB
        OrtiTC19HmJ5QRM2iidXnczOnibu+o4WoiiA19M=
X-Google-Smtp-Source: AGHT+IF2GvASrlb2vnHcx3R+WpqWs3lUMJPslS5M8PZ2C1ZfKJahHhmnOrKvbW6AXAX5qntO0Ob2wHWnBjSLO13DsHc=
X-Received: by 2002:a05:6870:f6aa:b0:1fb:10e7:4f00 with SMTP id
 el42-20020a056870f6aa00b001fb10e74f00mr14653654oab.4.1702471914679; Wed, 13
 Dec 2023 04:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20231212212239.8971-1-tony.luck@intel.com>
In-Reply-To: <20231212212239.8971-1-tony.luck@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 13:51:43 +0100
Message-ID: <CAJZ5v0j4djPUdJ3pdzH+E0npJHxMCHFYj4sG2-=S50=XyX_0qg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: extlog: Clear Extended Error Log status when
 RAS_CEC handled the error
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:22 PM Tony Luck <tony.luck@intel.com> wrote:
>
> When both CONFIG_RAS_CEC and CONFIG_ACPI_EXTLOG are enabled, Linux does
> not clear the status word of the BIOS supplied error record for corrected
> errors. This may prevent logging of subsequent uncorrected errors.
>
> Fix by clearing the status.
>
> Fixes: 23ba710a0864 ("x86/mce: Fix all mce notifiers to update the mce->kflags bitmask")
> Reported-by: Erwin Tsaur <erwin.tsaur@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e120a96e1eae..71e8d4e7a36c 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -145,9 +145,14 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>         static u32 err_seq;
>
>         estatus = extlog_elog_entry_check(cpu, bank);
> -       if (estatus == NULL || (mce->kflags & MCE_HANDLED_CEC))
> +       if (!estatus)
>                 return NOTIFY_DONE;
>
> +       if (mce->kflags & MCE_HANDLED_CEC) {
> +               estatus->block_status = 0;
> +               return NOTIFY_DONE;
> +       }
> +
>         memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
>         /* clear record status to enable BIOS to update it again */
>         estatus->block_status = 0;
> --

Applied as 6.8 material, thanks!
