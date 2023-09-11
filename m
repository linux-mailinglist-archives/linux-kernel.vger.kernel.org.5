Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4379BE00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbjIKV3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbjIKST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:19:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A8110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:19:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso624857166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694456390; x=1695061190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d70ufF0cZdjzu8+wQySqcBMfKEaUVdfwSOMtM36noXw=;
        b=RiDLZTrvGzWA7Xymmok59RzDdjuOMXSVh7x9HUpsyxmcjjy1tyswXZIhEtuos2bN7d
         WVw/8TfvMWHhu7JmRc29ARdL2b1FpfL3LUSMuH16hGmornuksLgatUYDTS8fyak1zItY
         8U9H1mBscRWtnoNHVTmZi/AG1Zi57xadfk3KNcR5VNYAWB+c7myUd3o6U5ix7ubq9qn+
         PRnT/jx1JNqBYYd6wGV59JYJcP1RkmZl8SYQCPzsAT4FN+8Sa2zUx4Ci6ilLwHpAQdxu
         Ui57YVseTqRmPdxwgYRbam4R6F1K6gdUGmHBA7XY9lvc98QIle06e8V46EaRXLMnc6Ry
         HCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456390; x=1695061190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d70ufF0cZdjzu8+wQySqcBMfKEaUVdfwSOMtM36noXw=;
        b=lJ5ncFBC6oI2KHc2I9Bni0Lc+72vrgDRmPw0Gm12EygBhFuu5lM0Om3emmiECiOOnm
         UnNEvfm4CPx4b3uaEJOPUvaZ+8Lt47ld9e9UyC+KJnpwqoxBprhwBgQrZInuwETa2px3
         hYGCAsTSMDtOeq+wLrpc5874FPWGk1JW4TFaERm5FAI+nhZRjlU8hlcm4VRdns8bJFSJ
         oRdcd3lye3jywW5//HJ0d4RvVMPVqudC73PAduvPTFjZ2fSrXqjQYb2uIdEIOktkZ8So
         DcOokyrmePOV/1VB1H0A0v+15slWZaP8B3gmpzf8FSQr55ZDtxgdqpNZv9QZW3vIC6Yd
         /25g==
X-Gm-Message-State: AOJu0YyIuj4X54AXgNGFOALTs0CxEb0E1l9yMiyLxNl2XL8bHui8KFsZ
        yG64Du60AhZBGkK6sMkvTvQ0LkYHjz4Mi3m0MjcFcA==
X-Google-Smtp-Source: AGHT+IG9J7xsG+FP6sYoj3DUy1G4iIcaIxhgbwoUJzMHGmrALj/RSDSp43fnEtymYsvsyde7thnW9d5Z6FTm5Er9e7s=
X-Received: by 2002:a17:906:21b:b0:99b:e5c3:2e45 with SMTP id
 27-20020a170906021b00b0099be5c32e45mr9843704ejd.28.1694456390494; Mon, 11 Sep
 2023 11:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230908235115.2943486-1-nphamcs@gmail.com>
In-Reply-To: <20230908235115.2943486-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 11 Sep 2023 11:19:11 -0700
Message-ID: <CAJD7tkZHWzS5FTjDEDy5WoUrPh1OH78_3XBk2FPYvrUaz7QSew@mail.gmail.com>
Subject: Re: [PATCH] zswap: change zswap's default allocator to zsmalloc
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 4:51=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Out of zswap's 3 allocators, zsmalloc is the clear superior in terms of
> memory utilization, both in theory and as observed in practice, with its
> high storage density and low internal fragmentation. zsmalloc is also
> more actively developed and maintained, since it is the allocator of
> choice for zswap for many users, as well as the only allocator for zram.
>
> A historical objection to the selection of zsmalloc as the default
> allocator for zswap is its lack of writeback capability. However, this
> has changed, with the zsmalloc writeback patchset, and the subsequent
> zswap LRU refactor. With this, there is not a lot of good reasons to
> keep zbud, an otherwise inferior allocator, as the default instead of
> zswap.
>
> This patch changes the default allocator to zsmalloc. The only exception
> is on settings without MMU, in which case zbud will remain as the
> default.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 721dc88423c7..e0217deca084 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -130,6 +130,7 @@ config ZSWAP_COMPRESSOR_DEFAULT
>  choice
>         prompt "Default allocator"
>         depends on ZSWAP
> +       default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
>         default ZSWAP_ZPOOL_DEFAULT_ZBUD
>         help
>           Selects the default allocator for the compressed cache for
> --
> 2.34.1
>
