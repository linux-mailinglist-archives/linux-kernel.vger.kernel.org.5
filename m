Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8080DB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbjLKT7k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 14:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:59:38 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A017C4;
        Mon, 11 Dec 2023 11:59:45 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9d6f8485eso699993a34.0;
        Mon, 11 Dec 2023 11:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324784; x=1702929584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc04vqyrnhop0pBe3eCtDLiJ9h8DibF83HgUEMbY2Wc=;
        b=iW7Su+O7rASe/HwPnYPvXv5DRztGZgaF0MwNyPSDmmmbmdnJRAMKKB46zh2z1XOw4y
         HmhR/T6Yslr4QlR0MrF+/lgKQpDPJLF4gB0WXFljFxc0mMAYxrM5FLASARZTcgvxw/ov
         R2oQW95of2QAVjlNxVgHjMtIG0UV5MtFFykiWlCxatGUvb+YWMNXXJux52OyWQEUg/oC
         fmB56GZCFx+/TaV4xfOn4nPQSEeKk1yE5lNXhIkBsQ1sNyWjx8qGrick9Ye4/q8oI984
         OWKLWKEFJH9L52RdbGkqwBmveXkNtRNYvhYoAQhJrPJS5BYkeG7HSoO9gJEsiwjXaYMw
         kVvg==
X-Gm-Message-State: AOJu0YxDTSf1xvMo08G0KEaP+2N/y5kqt1AAhi8DZ/HY0DyiXn6tlgz8
        NFjzjNzxMo3CZEcgymvGoMu1q6j1Q8wNpd9CfPE=
X-Google-Smtp-Source: AGHT+IFXgx+RCFxRcduPkE9r49zGB6B48p+EDnkwaP9OK6Rnam7VZNdLeLvTornfpGf9ymMChDN4oes/NRXMyCdzFVs=
X-Received: by 2002:a05:6870:f6aa:b0:1fa:f404:b958 with SMTP id
 el42-20020a056870f6aa00b001faf404b958mr9641994oab.3.1702324784232; Mon, 11
 Dec 2023 11:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20231201180928.1103797-1-rui.zhang@intel.com>
In-Reply-To: <20231201180928.1103797-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 20:59:33 +0100
Message-ID: <CAJZ5v0hJbmzBzf9NdUpDB+qhY_uSVaExi=o=1F7X-Y_V5RRmmA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Meteorlake support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

On Fri, Dec 1, 2023 at 7:10 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add intel_idle support for MeteorLake.
>
> C1 and C1E states on Meteorlake are mutually exclusive like Alderlake
> and Raptorlake, but they have little latency difference with measureable
> power difference. Thus always enable "C1E promotion" bit and expose C1E
> only.
>
> Expose C6 because it has less power compared with C1E, and smaller
> latency compared with C8/C10.
>
> Ignore C8 and expose C10 because C8 does not show latency advantage
> compared with C10.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/idle/intel_idle.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index dcda0afecfc5..cfd0b24fd7f1 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -923,6 +923,35 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> +static struct cpuidle_state mtl_l_cstates[] __initdata = {
> +       {
> +               .name = "C1E",
> +               .desc = "MWAIT 0x01",
> +               .flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
> +               .exit_latency = 1,
> +               .target_residency = 1,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C6",
> +               .desc = "MWAIT 0x20",
> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 140,
> +               .target_residency = 420,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .name = "C10",
> +               .desc = "MWAIT 0x60",
> +               .flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 310,
> +               .target_residency = 930,
> +               .enter = &intel_idle,
> +               .enter_s2idle = intel_idle_s2idle, },
> +       {
> +               .enter = NULL }
> +};
> +
>  static struct cpuidle_state gmt_cstates[] __initdata = {
>         {
>                 .name = "C1",
> @@ -1349,6 +1378,10 @@ static const struct idle_cpu idle_cpu_adl_l __initconst = {
>         .state_table = adl_l_cstates,
>  };
>
> +static const struct idle_cpu idle_cpu_mtl_l __initconst = {
> +       .state_table = mtl_l_cstates,
> +};
> +
>  static const struct idle_cpu idle_cpu_gmt __initconst = {
>         .state_table = gmt_cstates,
>  };
> @@ -1423,6 +1456,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &idle_cpu_adl),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &idle_cpu_adl_l),
> +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,        &idle_cpu_mtl_l),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,      &idle_cpu_gmt),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
>         X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,     &idle_cpu_spr),
> --

Applied as 6.8 material, thanks!
