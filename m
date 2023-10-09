Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66577BEF58
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379100AbjJIXtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379043AbjJIXtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:49:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA2A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:49:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so8734495a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696895348; x=1697500148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWFBDu8ko+Lwn2b6W5QF7+wg6DRHPxWmFe2xYb2aiM0=;
        b=w/YgA6HKdYQNbSrx1ojyA+nJKg/1GMbtiR4Vgotnn+0Mu+dxPJl2n2ul93LczpPlYg
         8B4fcM+0q2G4mzwawiqrxMh3SG9J4KRFwnYk1xsdH2WoBJDaLGuVnPmr1ueggx2B2ug4
         oBTmxG0hv3A7O+lSD9d4z2wFX6cNi3QTIl5lHVhPq8wuMJvg/ZHwEb0AhvXT+VqQvASV
         Vhbg2CHL8IYkF9mznN1JAY+SBWrp5S1/Nnhk0oruOada0d8qyPsCcZpTkoncZj3nk4is
         ZvEL5yNua0KD3OOyUxBBjcipmxr6wO+fz5xEL3taj/bmVba3Zg97acApY8+jlUrxXQ8O
         5KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696895348; x=1697500148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWFBDu8ko+Lwn2b6W5QF7+wg6DRHPxWmFe2xYb2aiM0=;
        b=BcnTHdXXwqMxrQDuR4G1q7uEn+T1SwzwuKy5whrddCZqK/NtvSSnXpyPIoVxbPw5ex
         /eMbUpB27D/3HdIXItEUjmuSpm7THYOhoC9RH8kmg+vfdEOex+H7+0mEW8jOnRvoW0hq
         2ChZQ31P8b6+2QGjXvR/HL28z7gylbpybjLfF+V6cen1yETjYEjS9fBv5TkFV5/hiDM2
         soszV2/Ch3ERwit7GIxQTBjAd9MKyINZ7EyjNw+rv3WoMcbgEjtAGQu+M1SHQFHArXxl
         Hzn7eSRRPb7jkhrucIytO7R1lHIfXUkvMCmrAFHipZvj4Obb5FyxLJjfAWCbDOx1AGSV
         xoUQ==
X-Gm-Message-State: AOJu0Yz9LXPYQVhD/yez7+mwCdlg7ZpShEj5mOYvqVC6NJ6/Q60bR7W7
        gHGhTwBM+kE7B0qITHKaDkrXerC91FzBVxYAqKKFWQ==
X-Google-Smtp-Source: AGHT+IEZU4Sz3NJ/tlAQJLXA8SAjvhWPvXTbQLHBmKyfF8fk76AwoUyvKdaafL4oQUOV3CPkS9uDRtezaI9Fz4xlEyI=
X-Received: by 2002:aa7:df86:0:b0:52a:1d9c:83ff with SMTP id
 b6-20020aa7df86000000b0052a1d9c83ffmr15150271edy.1.1696895347954; Mon, 09 Oct
 2023 16:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZSRFW0yDlDo8+at3@work>
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 9 Oct 2023 16:48:55 -0700
Message-ID: <CAFhGd8obPWF5469BwFAXmZ7czOB6f68gdOGqCPFL+dbs5KzDyw@mail.gmail.com>
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:24=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
>
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..379ebe03efb6 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -85,7 +85,7 @@ struct viommu_request {
>         void                            *writeback;
>         unsigned int                    write_offset;
>         unsigned int                    len;
> -       char                            buf[];
> +       char                            buf[] __counted_by(len);
>  };
>
>  #define VIOMMU_FAULT_RESV_MASK         0xffffff00
> @@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu=
, void *buf, size_t len,
>         if (write_offset <=3D 0)
>                 return -EINVAL;
>
> -       req =3D kzalloc(sizeof(*req) + len, GFP_ATOMIC);
> +       req =3D kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
>         if (!req)
>                 return -ENOMEM;
>
> --
> 2.34.1
>
>

The __counted_by annotation and the usage of struct_size look right!

Reviewed-by: Justin Stitt <justinstitt@google.com>
