Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F77EF78E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjKQSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:50:37 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B425CE6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:50:34 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso2233202276.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700247034; x=1700851834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtpYAOIzka1JBZk8iAppwwSnkzFLFfJkyz+jdr3nWyE=;
        b=Ox7GGa5lvbFsB6OFCm0JduYejFsWng/7QAbNYILaxQzOXw5ryZ3gGXcohJnUYwqWxI
         M387O6Kg/0IfGXTIMDiHLv6FBYWoTfXXnYSLLxKIjBekczh0xAy9qzedb6iR70xIvWeJ
         pAjtmwMPBczU6mxPBXsiJKDby1FcPFTsMXWhiknnuUAzJ+FNNewzkdCPHhjlKJcramvU
         ek3c6QlXCPixHT6ke5QJ0DH1z9wLHRZ+A5dPVml1VeLhvxD+rzU5h48lTanmF4TWUP0+
         /Lfhe7st7tHvqGK2BHdOc3wZR4oigDrnGHJUUykNsNTokUmWl8eahgsj7Dhwm4MldZfx
         gXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247034; x=1700851834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtpYAOIzka1JBZk8iAppwwSnkzFLFfJkyz+jdr3nWyE=;
        b=hIxwhYMRO0vxWA4BFnh3WSCtriB/9yXGwvU7uNcdHJqpn2n0jUPb48Qdf+OA5lt5/Y
         n0WRKNKMiMDRe/vh6rRpNKx6JwkkMPJ4UbBnFF8QNvFjBSlwvEETp8ThkE8qSWtIQ+3b
         1tavi7T8ZVOM31Fr6fxATqtXrwFUTdVzYLXS+8JgReHHmaaXnox26i7ru+sCzMJMlVGA
         cLzHyad2mcJ7Rln9Lw8TYUP4WnkCqOXMyhb2zyB/dC2sFhYHUmZ8K83Kcm7UL8thI2Rk
         lpdalk5LQqzh/fnvBWcPnGkP88meJ8tDSWblrlwOWL7ngNbXYlPO6oarSLsTKo81VoOc
         iyJA==
X-Gm-Message-State: AOJu0Yybfq1O+jG8Dp6m6+m+uAZ34NSD7C8gsiIsR1KfffuH84oANeUu
        fvSlXigr2scPfZfMS90m5gFAs39pLn9SMp6QQ7rKcDY7nh00Ii6FTVqpNg==
X-Google-Smtp-Source: AGHT+IFi5dwlJjXKeALdkQ3r7NL6Ns0Vqtg+0GbT2TnyYHl6vrk7ylgtgCrw4Xy73kvNJHON7kCIdI2uoaIh9nEMUls=
X-Received: by 2002:a05:6902:1508:b0:d91:c3fe:6144 with SMTP id
 q8-20020a056902150800b00d91c3fe6144mr286813ybu.3.1700247033764; Fri, 17 Nov
 2023 10:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20231116191409.work.634-kees@kernel.org>
In-Reply-To: <20231116191409.work.634-kees@kernel.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 17 Nov 2023 10:50:21 -0800
Message-ID: <CABdmKX1oNw+quAd+ALcgGoz-PPsvy=O6YM4f2_SmP+dQBddzAA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Replace strlcpy() with strscpy()
To:     Kees Cook <keescook@chromium.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:14=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy(=
)
> completely[2], replace strlcpy() here with strscpy().
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

strscpy returns -E2BIG when it truncates / force null-terminates which
would provide the wrong argument for dynamic_dname, but
dma_buf_set_name{_user} makes sure we have a null-terminated string of
the appropriate maximum size in dmabuf->name.
