Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C022A7EF5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjKQP4Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Nov 2023 10:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:56:22 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B534AA;
        Fri, 17 Nov 2023 07:56:19 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9becde9ea7bso654107866b.0;
        Fri, 17 Nov 2023 07:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236578; x=1700841378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oexZKi4jraVZMBko6mtbaiC7v5lb9xeMULv/R6WBNzs=;
        b=jit75G0yw5bafT70oA///ru6t2isK3BcPtA3w0b9/+N9nJu7xilpv7PmBc8P+pvdin
         Zw+axdAFQvAYXJVh6WHYC/nWkDHlpZy7sVq+fxHOxBFdiQihTaSYJlR8ZfEkl/PqPvir
         do0jHbZQdJfdP+aumg0IGUDIVfxZugWBqsYcAd9hYqkjAGqtPbwca67Fe9hXJH+zt100
         JUTIgDRJbMFgY0QuiMRR7CPi8hy3THKRrc3nKMRYg9o4/cO+tQJlKWIoZf+/Tt7QP23d
         6EGl4DNZFCJLkNn3kbVRrGpBeSdC+6+5xYG81x4yHIm7MAesmBUyysJ181ztwwsWtIw/
         IEqg==
X-Gm-Message-State: AOJu0Yy3seeNQ8BQGsJ7Moeevc1Q/Cgr1ammdjLr9qRD9k2YJMDEkfFB
        /JiaXDgKidRCl5XCoVPN20CVqz9L7hw5TQ==
X-Google-Smtp-Source: AGHT+IFNuQzkhKpalczv/PK5PjOQ9FMyCZenJlyg4h9yi4U9ZDcfKIa7T79iYRZeUTlHbrOU4AVkEA==
X-Received: by 2002:a17:906:fcc2:b0:9ad:8a9e:23ee with SMTP id qx2-20020a170906fcc200b009ad8a9e23eemr4989418ejb.13.1700236577705;
        Fri, 17 Nov 2023 07:56:17 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id gt2-20020a170906f20200b009aa292a2df2sm903782ejb.217.2023.11.17.07.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:56:17 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9df8d0c2505so411706066b.0;
        Fri, 17 Nov 2023 07:56:17 -0800 (PST)
X-Received: by 2002:a17:907:7e94:b0:9f2:859f:713e with SMTP id
 qb20-20020a1709077e9400b009f2859f713emr5983220ejc.3.1700236577239; Fri, 17
 Nov 2023 07:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20231116155312.156593-1-dhowells@redhat.com> <20231116155312.156593-6-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-6-dhowells@redhat.com>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Fri, 17 Nov 2023 11:56:05 -0400
X-Gmail-Original-Message-ID: <CAB9dFds=jqwytP=F=RYD2AnOXBj9bBLc6wuO+yCy3m9308o6iw@mail.gmail.com>
Message-ID: <CAB9dFds=jqwytP=F=RYD2AnOXBj9bBLc6wuO+yCy3m9308o6iw@mail.gmail.com>
Subject: Re: [PATCH 5/5] afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:53 AM David Howells <dhowells@redhat.com> wrote:
>
> Mark a superblock that is for for an R/O or Backup volume as SB_RDONLY when
> mounting it.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index e95fb4cb4fcd..a01a0fb2cdbb 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -407,8 +407,10 @@ static int afs_validate_fc(struct fs_context *fc)
>                         return PTR_ERR(volume);
>
>                 ctx->volume = volume;
> -               if (volume->type != AFSVL_RWVOL)
> +               if (volume->type != AFSVL_RWVOL) {
>                         ctx->flock_mode = afs_flock_mode_local;
> +                       fc->sb_flags |= SB_RDONLY;
> +               }
>         }
>
>         return 0;

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
