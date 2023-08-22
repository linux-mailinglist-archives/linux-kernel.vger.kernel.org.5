Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E832A784A96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHVTj2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 15:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjHVTj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:39:27 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5501B0;
        Tue, 22 Aug 2023 12:39:22 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5657ca46a56so699507a12.0;
        Tue, 22 Aug 2023 12:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733161; x=1693337961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djYaQVoH38D8PAlG+rZfaiyf1oeIyY+rjISyA+56QkY=;
        b=faXuJ6ZVPm+TKUhpDAkpJQ3ltvGKAc0yyprT4B5mucC87+mvjcR2z3yA2cNRSwVp2c
         /nbqqsyxgb7S6ftT8V2NKFWLhC1r8qodIoV6p98YAO4ELXkFFXBPtDhOLSdHg3jZf7Y6
         xcIKKANcUfvxJoYGqEjPqPxiqNSrM5QMBIqikIfP/pbjl9iatM7epvM4TSUY1C2E74W+
         mibHg106LBtezFdq4m6nC2OdCMJpS2sJ3Nlvl7Q8/cFZN/Iy90mL3Vlg45jtE37Lugif
         WIla0UHrdmc9H++hDieoztjutDf1nZJLSdg4LumsEpgXwTOfZa/cBs1ROsH2Oze/SML1
         4pvA==
X-Gm-Message-State: AOJu0YxJaLjCydd63ESi5+TrLpSSLhlKSwJ6+wXkNjrqo4weHchN4q1f
        ppHXZfHjiF2pMaYlocv+gOQVMO/ZilTuIEADHXI=
X-Google-Smtp-Source: AGHT+IEGd8A47JC8DqNEp1CtzoVcCV+byWmY5mOslixNULZpRTBaInS0DjdM3NnVSOXHtODW4zeNIP7A4QoiwE6IX3w=
X-Received: by 2002:a17:90a:2d8b:b0:26d:414d:a98a with SMTP id
 p11-20020a17090a2d8b00b0026d414da98amr9626080pjd.1.1692733161524; Tue, 22 Aug
 2023 12:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230731060354.4802-1-clive.lin@mediatek.com>
In-Reply-To: <20230731060354.4802-1-clive.lin@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 21:39:09 +0200
Message-ID: <CAJZ5v0jYYN2MpqYW35N+-jzqpfY0ATGfUEwhgY1O3WXk9QoSRg@mail.gmail.com>
Subject: Re: [PATCH] PM: QoS: Add check to make sure CPU latency is non-negative
To:     Clive Lin <clive.lin@mediatek.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chung-kai.yang@mediatek.com, ccj.yeh@mediatek.com,
        ching-hao.hsu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 8:04 AM Clive Lin <clive.lin@mediatek.com> wrote:
>
> CPU latency should never be negative, which will be incorrectly high
> when converted to unsigned data type. Commit 8d36694245f2 ("PM: QoS:
> Add check to make sure CPU freq is non-negative") makes sure CPU freq
> is non-negative to fix incorrect behavior in freq_qos. Adding a check
> to make sure CPU latency is non-negative can prevent this problem
> from happening in cpu_latency_qos.
>
> Signed-off-by: Clive Lin <clive.lin@mediatek.com>
> ---
>  kernel/power/qos.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 782d3b41c1f3..4244b069442e 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -220,6 +220,11 @@ static struct pm_qos_constraints cpu_latency_constraints = {
>         .type = PM_QOS_MIN,
>  };
>
> +static inline bool cpu_latency_qos_value_invalid(s32 value)
> +{
> +       return value < 0 && value != PM_QOS_DEFAULT_VALUE;
> +}
> +
>  /**
>   * cpu_latency_qos_limit - Return current system-wide CPU latency QoS limit.
>   */
> @@ -263,7 +268,7 @@ static void cpu_latency_qos_apply(struct pm_qos_request *req,
>   */
>  void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value)
>  {
> -       if (!req)
> +       if (!req || cpu_latency_qos_value_invalid(value))
>                 return;
>
>         if (cpu_latency_qos_request_active(req)) {
> @@ -289,7 +294,7 @@ EXPORT_SYMBOL_GPL(cpu_latency_qos_add_request);
>   */
>  void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value)
>  {
> -       if (!req)
> +       if (!req || cpu_latency_qos_value_invalid(new_value))
>                 return;
>
>         if (!cpu_latency_qos_request_active(req)) {
> --

Applied (with some edits in the changelog) as 6.6 material, thanks!
