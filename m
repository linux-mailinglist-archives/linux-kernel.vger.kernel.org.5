Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7A1794241
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbjIFRuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbjIFRuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:50:08 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00291E59;
        Wed,  6 Sep 2023 10:49:35 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c26bb27feeso94445fac.0;
        Wed, 06 Sep 2023 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694022565; x=1694627365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OckE9XR7XqLavE1NTvHSJ96NXkQ2QIgEye4jTfkAdg=;
        b=hJtEV2yJVYq7K/Lu8g2Cn4pNDMcsdH9cXp5cncBsNb4KqrwxAbl3Dc/We7FzNWOVeq
         XJUTS1qdzyO0m0wiBMlbUWUUIhuJVTziXyGgT988QVVsHEmN3xNbR6xUD1u4XKTsKNrx
         0eQ1XOTzaeEYA5QJsDt9IYmjPOTvc7w6A3cQuBEQUQObfNSZFnfh65lRJiXhQl3Ky8YI
         J5Kj1R7pgNEdVaL/EeZkJHUzIcVlYT98uk2/c/b1d3J9WRypb8kjt45PXnnfSX6iulPL
         RMv/W+pF7z9+WLm3r4GNRH7kPO+ZR13tpnEYCA/23ckYbxhVltXw5fOmZXiXZMRHfyeM
         zdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022565; x=1694627365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OckE9XR7XqLavE1NTvHSJ96NXkQ2QIgEye4jTfkAdg=;
        b=Ws//R61ALVbEKi1N+NhgsHlqlutCwbbfWllSQwiWxSnYpZMF/Q14+8U+s0addZF5Vi
         +3FXZUKcq0V2dyouwYgyL/YclCzTWSl1xfVEiWJgNbAwMbKUH9KHQRbfWtbGAO4ISk52
         bpoue7KMjWXoGkPuTZ3rVu1ZTAQIVGAdu/VaoaSv+yu/9DT5d23GCj2t5fo6GnF8J3Cw
         v6uVQ7rpLhK0Ej9uYU6o8g+TnprNjU6WZgvyovbyGmxWaihhZ5wVutNbHIHBF3nnrA8L
         p7xQ0fHQCAbmRBbGLUg8FmAD3XDT1w6OPYW0UHATDEPQuFJa4LX0qyIjokpV5PGRPYV9
         kQ1A==
X-Gm-Message-State: AOJu0YxLE0O32oRfqYon9TrBNXBRxGGlZPgU2/+BZcoZ73iiH9amzXB8
        5phKUxonQQoXY0SkQ31InqK2h3TYcT+WeUVY1Cw=
X-Google-Smtp-Source: AGHT+IH9425uguIPlZWIuuKXrAiVTNUvU96FSm7pht9qHJYP0oafzxBFwJjkkOT7Wg95M0jvIp6eTzknNatrc9ZNSUM=
X-Received: by 2002:a05:6870:5488:b0:1b0:5290:c95e with SMTP id
 f8-20020a056870548800b001b05290c95emr18777117oan.42.1694022564983; Wed, 06
 Sep 2023 10:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20230906115928.3749928-1-alpic@google.com>
In-Reply-To: <20230906115928.3749928-1-alpic@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 Sep 2023 13:49:14 -0400
Message-ID: <CAEjxPJ7bu7tC3-xYN9mnh8jGtH6EOP0e5SC+LNR_uhK18dM+cQ@mail.gmail.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
To:     Alfred Piccioni <alpic@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 7:59=E2=80=AFAM Alfred Piccioni <alpic@google.com> w=
rote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file permissions.
>
> Two possible solutions exist:
>
> - Trim parameter "cmd" to a u16 so that only the last two bytes are
>   checked in the case statement.
>
> - Explicitly add the FS_IOC32_* codes to the case statement.
>
> Solution 2 was chosen because it is a minimal explicit change. Solution
> 1 is a more elegant change, but is less explicit, as the switch
> statement appears to only check the FS_IOC_* codes upon first reading.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> V1->V2: Cleaned up some typos and added tag for -stable tree inclusion.
>
>  security/selinux/hooks.c | 4 ++++
>  1 file changed, 4 insertions(+)
