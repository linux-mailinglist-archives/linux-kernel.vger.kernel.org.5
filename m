Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D53784A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHVTXz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjHVTXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:23:54 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499CE91;
        Tue, 22 Aug 2023 12:23:53 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68bbd45d0d5so108566b3a.1;
        Tue, 22 Aug 2023 12:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732233; x=1693337033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vRvWkHiLQlzYJ0T4TJoqXPJveLoj3En7SEm7QqmgPg=;
        b=WSu1YuzD0cLroxNg7pxarlr32FZ1BBYkx6DheH1SO5+R0SGnnHdLnZABJNQvBlg7tM
         Fms8gXzPZsptE9md1KcqYnKBaQQtzYmBFjoJElLRFN9hq6UFwSdyl0SFZQNwWrvzYjgz
         DD8F24uCRVAE2heiYbHIuZ5TLQhAULrThY9372FuFTge4aHHVgb3FdPqDwNet/ud5uli
         cKywYWUUDU6T2fR41SBbEp22Od2k/jMo3WEyMW2o6bbhE3+Ecow5ZnE/0H8mJ6rNLlW7
         9H9KBLT9v6w9XwCk5GSzy8T5R8yx1/CBCOKCQDNYxjy3lRg7ZVAVkDu6JZXJWQZiC6O1
         7WhA==
X-Gm-Message-State: AOJu0YwPDuPO3S6mrQ5arMsc5WrK68vBy9H0qg5nvnECKh0AqlnVLbqo
        heUm7clOByvPeFmZPCuVGman0ByO+AVCjsJ1mFw=
X-Google-Smtp-Source: AGHT+IHGVPRaWr+d59LoKVGfLZDWhuyOrS9NjpOdXHwPo6NpMlstPvrLuhmY+TwCRYnECZeckT3j9IFSVeoNG5kaNCs=
X-Received: by 2002:a05:6a00:1892:b0:68a:61fb:8025 with SMTP id
 x18-20020a056a00189200b0068a61fb8025mr4482870pfh.1.1692732232733; Tue, 22 Aug
 2023 12:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230724071646.2744900-1-peng.fan@oss.nxp.com> <20230724071646.2744900-3-peng.fan@oss.nxp.com>
In-Reply-To: <20230724071646.2744900-3-peng.fan@oss.nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 21:23:40 +0200
Message-ID: <CAJZ5v0hq7=7TvoMzvbauaK7zZODpS18Y5NikTLy1sCRZMeAH0Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] thermal/of: accessing potential uninitialized value
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
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

On Mon, Jul 24, 2023 at 9:12 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> If of_parse_phandle_with_args returns failure, the cooling_spec.np is
> uninitialized. So move of_node_put below the return value check to avoid
> accessing uninitialized value.
>
> Addresses-Coverity: 25772185 ("Uninitialized pointer read")
> Addresses-Coverity: 25772845 ("Uninitialized pointer read")
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/thermal/thermal_of.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 330690a3a208..4ca905723429 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -291,13 +291,13 @@ static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_i
>         ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
>                                          index, &cooling_spec);
>
> -       of_node_put(cooling_spec.np);
> -
>         if (ret < 0) {
>                 pr_err("Invalid cooling-device entry\n");
>                 return ret;
>         }
>
> +       of_node_put(cooling_spec.np);
> +
>         if (cooling_spec.args_count < 2) {
>                 pr_err("wrong reference to cooling device, missing limits\n");
>                 return -EINVAL;
> @@ -324,13 +324,13 @@ static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
>         ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
>                                          index, &cooling_spec);
>
> -       of_node_put(cooling_spec.np);
> -
>         if (ret < 0) {
>                 pr_err("Invalid cooling-device entry\n");
>                 return ret;
>         }
>
> +       of_node_put(cooling_spec.np);
> +
>         if (cooling_spec.args_count < 2) {
>                 pr_err("wrong reference to cooling device, missing limits\n");
>                 return -EINVAL;
> --

Applied (with some edits in the subject and changelog) as 6.6 material, thanks!
