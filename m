Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E167C031E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbjJJR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbjJJR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:59:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE639D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:59:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso187975a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696960742; x=1697565542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1TIuimi/4iNqWfZhkdgCqCgPh9EXGV/EamH/mMM+fY=;
        b=mbGiertwvWYamM+aNKPr2cCQA+HiLPCFu40udrV9vYWhwv3NktaY6xCWjCJbPt3FFt
         PG/bnwlEUTI6g35HV/KDl1pDr2KM4r4++5gqZk4vCZ+JuRuOpThNwnroi/VEsY9Tgct2
         AnCGhYH5J7H6jCV42naZpHfThBTvqqM/y6Ng2Z5fJllf+CXS1q14frxP1JIWNZrsLQ1L
         rNaXXPo4OfGDiaZSdhe495proUVXyG7UoztYpeYGUHXLOyrKYNBr8lCPsMsTumLLzQ03
         Z43UYvkY5Pqj1Bgq+/rzxtDvL5iMyW+pA0jHX/nzIhQu4C56k7DcRFM3Jehlr5KJjYsK
         5mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960742; x=1697565542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1TIuimi/4iNqWfZhkdgCqCgPh9EXGV/EamH/mMM+fY=;
        b=Ja34azegt09uvlLdH+/8AxLAG0MEAgTL525vxyrUTob9LxfdrK8T6+zkfbbGDZTZHi
         v+4o6iWYcd9zAKprbznQEdusphj6ETYdXFaAzIJwvJodA9OQAu+C/rsMjR3u7LXtzaeK
         j8w09BXc4NcTIRcJF98OwJTTWS7lppIiCmbDmPswZAjzwMn0G2e4f28Afoj5v4pw2R1M
         X2Oy8fPbNqvwyZ31pX2iimuB8htMI+OavMyrRgeYGT/L/Rl22nr4Ee8J5JvHAWaPdlY9
         ectVV1M/TLub+OXRogKewV0r3jpb5aIBjEhGVTzEL8G+8EYCdAioeKtlAMBFjVhAhBcR
         YMSw==
X-Gm-Message-State: AOJu0Yz3on6JuV2Sf7KkNwKbja5ElG1IyO8/KMW3lftU8KU8iqk4EwSU
        e+AFUtpOTyTHhI4jUQ7wXS0oxwwCQGycO3v21OcXNdm/O714YP/4rEc=
X-Google-Smtp-Source: AGHT+IFBjf4+jhA5R1S4LfIZl/PoHi7DBMB4Y++BcAbRlrtJ1OribXCLcIPF3cLZbNsEXcD2yDyVPecj3Kps21xbSc0=
X-Received: by 2002:aa7:d1d9:0:b0:531:157d:ba2d with SMTP id
 g25-20020aa7d1d9000000b00531157dba2dmr14928139edp.4.1696960742207; Tue, 10
 Oct 2023 10:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZSVHurzo/4aFQcT3@work>
In-Reply-To: <ZSVHurzo/4aFQcT3@work>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 10 Oct 2023 10:58:50 -0700
Message-ID: <CAFhGd8rwzaa5hFtJa6hf0i8OrgAx2tgvtXrHvKFzgYijd2KKAg@mail.gmail.com>
Subject: Re: [PATCH][next] atags_proc: Add __counted_by for struct buffer and
 use struct_size()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Tue, Oct 10, 2023 at 5:47=E2=80=AFAM Gustavo A. R. Silva
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

Looks good to me.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  arch/arm/kernel/atags_proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
> index 3ec2afe78423..cd09f8ab93e3 100644
> --- a/arch/arm/kernel/atags_proc.c
> +++ b/arch/arm/kernel/atags_proc.c
> @@ -7,7 +7,7 @@
>
>  struct buffer {
>         size_t size;
> -       char data[];
> +       char data[] __counted_by(size);
>  };
>
>  static ssize_t atags_read(struct file *file, char __user *buf,
> @@ -54,7 +54,7 @@ static int __init init_atags_procfs(void)
>
>         WARN_ON(tag->hdr.tag !=3D ATAG_NONE);
>
> -       b =3D kmalloc(sizeof(*b) + size, GFP_KERNEL);
> +       b =3D kmalloc(struct_size(b, data, size), GFP_KERNEL);
>         if (!b)
>                 goto nomem;
>
> --
> 2.34.1
>
>
Thanks
Justin
