Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136BA79A304
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjIKFwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjIKFwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:52:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AD91AE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 22:52:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a645e54806so495657866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 22:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1694411557; x=1695016357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IXsq6kTPsGHqyjk5fsR6TPrgdDZmLIAvnZrI6SR/zXw=;
        b=PpKFKKKxLO/EsKNcxb9craa70PAVsM3c3rGc6jxceaxYo8dMrksyUTDfPXyj1kKORm
         +7q1l+x9iBQf/fSKIDERvHvFA2ez0ejHKlcET5nPf9/YH/URLnLLhVA5ra4ngPgXD33e
         cBmdNJK+JwuMuTL7XtkOK7nk0Z9lbBX9bmD3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694411557; x=1695016357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXsq6kTPsGHqyjk5fsR6TPrgdDZmLIAvnZrI6SR/zXw=;
        b=WbaH7ELCZdWl8l/Ljefoax/6jglJbl9aaq3tcF+jIrgZzbWPUMrc9qureYJhCLdGxB
         9XAvJt/A51cuDbSmjZRm0C4AkyDLST/MZL5hCx+BpPf4HuSwMPGbBFGlSsmB4KtX32Bm
         5gVxoy19FqTrwuXHlc4EXlhpON836FtNBEQEA561hFPV9iTMvhfzd9UHAKVDrl8GSmY4
         uVcTKv2jRkrBAl89DVbmzj7kgXZd05iMuWd13r4jTt2gBGU6zBv6CiODFpummbVfTDcH
         bBhmHlq3vTmWC+Dj0GfjJ+jyqSf7+M8Hwkx02lZ+jvvUChmcDNQXHwu+FL2SGXJnBbvl
         rOIw==
X-Gm-Message-State: AOJu0YzhNtYFqPtbPUFWTWEaGoR/ezQMrPeWZEVLVGZhoWQPIY259oKN
        aNWaRVeRNHnLZS2h3MyIEv/k8PvdiV3pMO7DXY0=
X-Google-Smtp-Source: AGHT+IFyJUJhT3+/OJUTHkJ3l4taTJROUEO6Q14uL96KuCJUVC64SsI0JnDiDqpEiRK6oA6LaBltQVVq40xikY0z5h4=
X-Received: by 2002:a17:906:2921:b0:99d:dce8:41d6 with SMTP id
 v1-20020a170906292100b0099ddce841d6mr7606114ejd.71.1694411557430; Sun, 10 Sep
 2023 22:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230907221016.2978802-1-ninad@linux.ibm.com> <20230907221016.2978802-3-ninad@linux.ibm.com>
In-Reply-To: <20230907221016.2978802-3-ninad@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 11 Sep 2023 05:52:25 +0000
Message-ID: <CACPK8XcUkwNS85Ept62xyCabELHO9xTdMYvxVg2W+GZfAxTa3A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fsi: sbefifo: Validate pending user write
To:     Ninad Palsule <ninad@linux.ibm.com>, eajames@linux.ibm.com
Cc:     jk@ozlabs.org, alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 22:10, Ninad Palsule <ninad@linux.ibm.com> wrote:
>
> This commit fails user write operation if previous write operation is
> still pending.
>
> As per the driver design write operation only prepares the buffer, the
> actual FSI write is performed on next read operation. so if buggy
> application sends two back to back writes or two parallel writes then
> that could cause memory leak.

The driver already has this code:


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  drivers/fsi/fsi-sbefifo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index b771dff27f7f..824e2a921a25 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -874,6 +874,12 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
>
>         mutex_lock(&user->file_lock);
>
> +       /* Previous write is still in progress */
> +       if (user->pending_cmd) {
> +               mutex_unlock(&user->file_lock);
> +               return -EALREADY;

That's an unusual return code. I guess it makes sense in this context.

It's good to fix the potential memory leak, and we should add code to
catch that case.

This will change the behaviour of the character device from "overwrite
the previous operation" to "reject operation until a read is
performed". Do you think there's existing code that depends on the old
behaviour?

> +       }
> +
>         /* Can we use the pre-allocate buffer ? If not, allocate */
>         if (len <= PAGE_SIZE)
>                 user->pending_cmd = user->cmd_page;
> --
> 2.39.2
>
