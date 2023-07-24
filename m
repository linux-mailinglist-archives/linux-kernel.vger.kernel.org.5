Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03FB75FA13
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGXOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGXOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:43:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37867D2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:43:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98e39784a85so1167183066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690209797; x=1690814597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWtBMwxjTwxYWh+dw3/8mngiuHp6BECAcQUcMWQtOq0=;
        b=n3iSISe9tTfRu/kre2x1L0mivaM2UTKHvN14BmPHSiAYxxhP7GU6tXtSn5XYsmzJpo
         /djMPW3gg4HNLg0vRfL4Cd/7V9DaPexQyrMIFvMUriPY2tPllshxIdp4MsqVhu1Us+jB
         QXVnY9J1rTKpCqI1tKlEq+YtOi6knWXbR8ibI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690209797; x=1690814597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWtBMwxjTwxYWh+dw3/8mngiuHp6BECAcQUcMWQtOq0=;
        b=K91DqgIDqavbBxaCldjaJR+7BnWz6ceier0aKHO2UWVZFWNE3bvR6oo3NERPYGfeBQ
         DXGl4oHsRsg8VixOIbqXLqZxVR1Sesoc7FeshZQePyZD5BG3+0lYUHV6mq/LV3Avw7Rt
         I9XbLlJEE9AHBCOwMOXdZumEHiRTpYPgwTmf7LAO10OxfEXg4LtaWK6By8ewkI2sLgQT
         MvLfE33Xl8WJ+wPXcBcrFf7v7hfD3ALLQxu0gMBlk85tZJWi8vh6syAEOTqV9EtaCFb0
         xWVhF4LAM7yQIM1MFcwv4OKwpB1MRWl7aRQ39GTBa0hZ87cEBJDpQklyqkfGbsLGOQy6
         I1ZQ==
X-Gm-Message-State: ABy/qLblPz+XzKGDAgjNzIo7TMsNd39DSdjywKkxeGYQq56Fj2TxFWDf
        bJOBOwvwGmMWDDGlMBvQvXbnVwN54m+GmdEr0vwTBg==
X-Google-Smtp-Source: APBJJlEJ++BMwaJfOYS5QSck6VeKtoXZyF5jK7NnG0gtqQ6srKymRKQXQJQUpiGGU+gMOiFVmkOUMH2YV3pKOuj5RBA=
X-Received: by 2002:a17:907:86a8:b0:966:1bf2:2af5 with SMTP id
 qa40-20020a17090786a800b009661bf22af5mr16284235ejc.22.1690209797651; Mon, 24
 Jul 2023 07:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230521082813.17025-1-andrea.righi@canonical.com> <20230521082813.17025-4-andrea.righi@canonical.com>
In-Reply-To: <20230521082813.17025-4-andrea.righi@canonical.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Jul 2023 16:43:06 +0200
Message-ID: <CAJfpegtK=dh0yNdvxSC8YF6vOYqGPM5EOWny07jYDdFc0qfhTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ovl: validate superblock in OVL_FS()
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2023 at 10:28, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> When CONFIG_OVERLAY_FS_DEBUG is enabled add an explicit check to make
> sure that OVL_FS() is always used with a valid overlayfs superblock.
> Otherwise trigger a WARN_ON_ONCE().
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  fs/overlayfs/ovl_entry.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index b32c38fdf3c7..e156649d9c71 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -97,8 +97,20 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(struct ovl_fs *ofs)
>
>  extern struct file_system_type ovl_fs_type;
>
> +static inline bool is_ovl_fs_sb(struct super_block *sb)
> +{
> +       return sb->s_type == &ovl_fs_type;
> +}
> +
> +#ifdef CONFIG_OVERLAY_FS_DEBUG
> +#define OVL_VALIDATE_SB(__sb)  WARN_ON_ONCE(!is_ovl_fs_sb(__sb))
> +#else
> +#define OVL_VALIDATE_SB(__sb)
> +#endif
> +
>  static inline struct ovl_fs *OVL_FS(struct super_block *sb)
>  {
> +       OVL_VALIDATE_SB(sb);

This could be written simply and naturally:

    if (IS_ENABLED(CONFIG_OVERLAY_FS_DEBUG))
         WARN_ON_ONCE(sb->s_type != &ovl_fs_type)

Thanks,
Miklos
