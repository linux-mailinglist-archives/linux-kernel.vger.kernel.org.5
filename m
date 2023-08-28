Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B715478BB96
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjH1Xlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjH1Xlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:41:32 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F08129
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:41:29 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76de9c23e5cso261607385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693266089; x=1693870889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjMIoXslynq24DOJiW33MMcsv/sh8tQtQqHO+N8He+8=;
        b=1EoXeb3OOiImuMjjfHwUlmsY0ztLDASdSyw8ID2X17CIXW81x9Atszg92hG4E2wnZE
         KGvFfl9TzCZD1ThqK7VxGiOZIEZY5QDYRrJmf3G4Y1hOimVgFXBkqKkI6RME54XbQxmg
         49+M8MDQEzj8Mp6tpKM9nm5fbethPmE8p2Z8TkL1a1t3yGqpWW1liz1CT3GbCClMINb5
         Nb9dxjJCGXv7sirwAPdSlEQLQBIOGt2j5rqYvuNk9lIvy8QT/9vdebPh+1+51bDOkixU
         AltTHjCtpB8jaL71XD97KMCuukI+SYF/aX3RVXN4nlGg9XfopfBs9gc3qEqhA03zShb4
         ctKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693266089; x=1693870889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjMIoXslynq24DOJiW33MMcsv/sh8tQtQqHO+N8He+8=;
        b=hOq6EyPC7IXQY8uZFz97liF78Cj4ERFolitUb5p1pXg7MrV1XktLPdGJ05CJLpTL8W
         WmSX8rsqBgydqw4Tjs99UryIWZUoqwGEA4ut9KBbsc8P44K8d2WnhJqDQfv38OE8cUvt
         +BCwIl9LJBAPO2gaOvW2j+V59DYNCCpc9vZsMdoHXjhmutbwpoJdRqRsjyqDe2bWm7M2
         DBldKScJWI29jHvIFQb7Pn4prd9vuErJ19GxQ+HcStmXa9mcpeVHu6iYIj9N3xLn2cNQ
         UW/995dnzeqySKFIZlZQhze/zp459w7uS3QSc6k+jSfVNEQJEn77Hi1wBLL5lrRcT42/
         cH8Q==
X-Gm-Message-State: AOJu0YySc/hnWKJzldmUTWrBOvNqAH+mvjXg/LminKTKzgisESRxaoAo
        wJRNwC3OvpVtO3hFMwmTEaZsPu0CkKWgpFOQZBVlNw==
X-Google-Smtp-Source: AGHT+IGz2NbllmhHMPcJmnADheTpGmYefJXR5RnW4sLSsK1HF+0ZQuC9eNUyS3O1ILjxAa720JTnJHJznRBM7D4EWpM=
X-Received: by 2002:a05:620a:444f:b0:76d:b0d9:8714 with SMTP id
 w15-20020a05620a444f00b0076db0d98714mr26714497qkp.5.1693266088761; Mon, 28
 Aug 2023 16:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230828-scsi_fortify-v1-0-8dde624a3b2c@google.com>
In-Reply-To: <20230828-scsi_fortify-v1-0-8dde624a3b2c@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 16:41:18 -0700
Message-ID: <CAKwvOdmaeupeLgJWjMD4iJ1pi9NFTN-MTp3uC0jDVp2T2+Ctxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] scsi: fix 2 cases of -Wfortify-source
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Aug 28, 2023 at 3:25=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> clang-18 has improved its support for detecting operations that will
> truncate values at runtime via -wfortify-source resulting in two new

^ -Wfortify-source

> warnings (or errors with CONFIG_WERROR=3Dy):
>
>   drivers/scsi/myrb.c:1906:10: warning: 'snprintf' will always be
>   truncated; specified size is 32, but format string expands to at least
>   34 [-Wfortify-source]
>
>   drivers/scsi/myrs.c:1089:10: warning: 'snprintf' will always be
>   truncated; specified size is 32, but format string expands to at least
>   34 [-Wfortify-source]
>
> When we have a string literal that does not contain any format flags,
> rather than use snprintf (sometimes with a size that's too small), let's
> use sprintf.

Even better, Ard points out this could be strcpy (or one of the
variants). Will send a v2 tomorrow.

>
> This is pattern is cleaned up throughout two files.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Nick Desaulniers (2):
>       scsi: myrb: fix -Wfortify-source
>       scsi: myrs: fix -Wfortify-source
>
>  drivers/scsi/myrb.c |  8 ++++----
>  drivers/scsi/myrs.c | 14 +++++++-------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230828-scsi_fortify-9f8d279bf9aa
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>


--=20
Thanks,
~Nick Desaulniers
