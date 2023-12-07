Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAEB8089C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442860AbjLGOCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjLGOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:02:02 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14E610F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:02:06 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d33574f64eso7750627b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701957726; x=1702562526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8G9fbOrQ4XzSAmbK144ee010XvpvgmM3YlNhRHIsD0Y=;
        b=lR8w7jqfx3Vp7uClprER2dUrPddo9nZOVCcmmmmrQusIt9ZoZk3hgHt/6GFd6h/u6/
         eSgHCCcrNuhxUGOyXSDbW0+XzRAc8h0shXzudNxCRL0ARLw/EUNqviNuCAMz7Ky+0Xl7
         WD6leWW4+bG5lypgp0QKCHKtukQQYWJdLzjVEE7jhL7lGcxlE/iiAiX4BELzwvGm6AE0
         DDRcUF9xt5IsIcS0lYvtyD1P2GF2pcm3/7hx/WS1yWrcuhlpR0LHYJ+ijHCiKPlBZpfL
         hJ90+RXChycPYag6wgbEUNR+mwjBt0We/E5b6rHZ25grL+SawIvLBt+V4p4aKpkkk5vV
         ArYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957726; x=1702562526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8G9fbOrQ4XzSAmbK144ee010XvpvgmM3YlNhRHIsD0Y=;
        b=scpHBcKGtY9qr0w1qhsueOADaIurvjvBznRdFnLZ0tlSh1atyE2Yjvg6mEOi4lXSjl
         H7B8/eRaaX62//O0yB8ZdNmZYHvFw9K8wupg5pWXIlIAZ7P3072eARfOZjUh2ljidPkQ
         1x75GffMnQEPUdENh6efAUvk4I481B+fqmqpIGxlhXYsYQzHnMVa3gNSsYQsJW/vOub1
         dLKHr0lLjxHVmABp2kzvPnqR5tqdqyc8M3jrbSyOXHCD6G4pEw2oQCcItcvoKfQ7ghLT
         BBNkYXS7oa3KjQvmzNnTpMcLRM7YnQiCSKPCzPHyA7kgC86bHdf9/wfTZ4+PPTTn4B6q
         2tQA==
X-Gm-Message-State: AOJu0YwB4lYoUxYKesxMIF4AHFMofaX/kkFjiZw72NrO+Rv4aLiklV39
        D5f4G8W2d9Ev/WjxZbd6/2gifpwQIt9kaPYUHG/3Tg==
X-Google-Smtp-Source: AGHT+IHNpZnNhVo3xArPaV4ih/YPMpwg+IyPULyN7ddI6LxkxEThpwK+5zFMwyykgb8b+mZL6gHUbxduL3+w0s0syb8=
X-Received: by 2002:a05:690c:f85:b0:5d7:1940:b38b with SMTP id
 df5-20020a05690c0f8500b005d71940b38bmr2721173ywb.87.1701957725928; Thu, 07
 Dec 2023 06:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20231201153143.1449753-1-jorge@foundries.io>
In-Reply-To: <20231201153143.1449753-1-jorge@foundries.io>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 15:01:30 +0100
Message-ID: <CAPDyKFrkX-=72=cQKd_3Yand-9ovcvXbFNA3uLKFSCccqBgT4Q@mail.gmail.com>
Subject: Re: [PATCHv4] mmc: rpmb: fixes pause retune on all RPMB partitions.
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     linus.walleij@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 at 16:31, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> When RPMB was converted to a character device, it added support for
> multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> to a character device").
>
> One of the changes in this commit was transforming the variable
> target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
>
> This inadvertedly regressed the validation check done in
> mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
>
> This commit fixes that regression.
>
> Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: <stable@vger.kernel.org> # v4.14+

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
>   v2:
>      fixes parenthesis around condition
>   v3:
>      adds stable to commit header
>   v4:
>      fixes the stable version to v4.14
>      adds Reviewed-by
>
>  drivers/mmc/core/block.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 152dfe593c43..13093d26bf81 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
>  static int mmc_blk_part_switch_pre(struct mmc_card *card,
>                                    unsigned int part_type)
>  {
> +       const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
>         int ret = 0;
>
> -       if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +       if ((part_type & mask) == mask) {
>                 if (card->ext_csd.cmdq_en) {
>                         ret = mmc_cmdq_disable(card);
>                         if (ret)
> @@ -868,9 +869,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>  static int mmc_blk_part_switch_post(struct mmc_card *card,
>                                     unsigned int part_type)
>  {
> +       const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
>         int ret = 0;
>
> -       if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +       if ((part_type & mask) == mask) {
>                 mmc_retune_unpause(card->host);
>                 if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
>                         ret = mmc_cmdq_enable(card);
> @@ -3143,4 +3145,3 @@ module_exit(mmc_blk_exit);
>
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
> -
> --
> 2.34.1
