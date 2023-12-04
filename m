Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F010803E03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjLDTDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjLDTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:03:13 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AAB2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:03:19 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-495d687b138so1157927e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716598; x=1702321398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8OsxNuHP/Mk0jzn3oUdmiDmSoUgRFcHUL7SKw08Lik=;
        b=T6I1TcbOttluAnwwZfPB0MHmBYk2fZZtv8IH9x76lUCfVl86sZ8QntmsVl9Wwh2d+i
         3CZ0yPOROooSbBOAaCl19R/NeSYdyhlJc8MdeRn61Ld2QiD7KSgYiSMQwWQtDD8IHqUM
         Ngvri/ITieowMJlQkw9Vl7HhxatH6IT/cWe2AEqvUCuKdHuTEZ35qq+c2xErY8MB1Jw1
         Jvur6ZrjWKsdfxcikuu1LwNe0FgtEbYd6dZk6hffWUXhw52nNQeoeR0uB6pRivi+mczi
         giZLW6o2X5pIj1ilKOuk7APX0sg0QBB0J7tBpZDMOVyov02OfgCGbbC3E0sLU0lEvNYj
         YACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716598; x=1702321398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8OsxNuHP/Mk0jzn3oUdmiDmSoUgRFcHUL7SKw08Lik=;
        b=izuXe48CWSNWSv0jLHW45arDh8+zhCCzvTLS+t7DHResOXQMjQpYlzE6U33vSlka2v
         7waRPy6JNdIcNNINuJVek412imgC0FZNmBb5TDGJ4GhsclxOvM1fls7OJz6lkzbjWCjz
         577Lb6puA7dIFBq5KZKQJ2T1bsZNgDlMD/HJBZKTy6RWx0eJbRywnEcpw3yHQQwVISYr
         5bzXXOh1DAe8waytMQNYxZ13hizXZNHIOVcC/UmgBrCxAFLPvgnb9lsrzI1DDJfUdux1
         6I0NcM06/RV9M/0ueLBE8Z1kEYe5ZhCjQmKqrsUK7jkZJqmg+BduXHAXlBUEAa2LjOoz
         atmg==
X-Gm-Message-State: AOJu0Yyqa4RDeCBDlqRHhOvDakYQEMqjumqDHESCM3S6L3PSf/4a9BXL
        FC+PBtcbTFd1K+5qvqPMz8wTGpfnW3m5ZsLB6+k=
X-Google-Smtp-Source: AGHT+IGP/1uzSO8EfURseQLuaM0LLow2VMvh1hhECiFS7K5uBiO+q456UysWI4/cbldZAQYS2uIEU+ulphXknhBVooA=
X-Received: by 2002:a05:6122:993:b0:4b2:e534:b5d1 with SMTP id
 g19-20020a056122099300b004b2e534b5d1mr1412281vkd.33.1701716597485; Mon, 04
 Dec 2023 11:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20231204180428.925779-1-jaegeuk@kernel.org> <20231204180428.925779-3-jaegeuk@kernel.org>
In-Reply-To: <20231204180428.925779-3-jaegeuk@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 4 Dec 2023 11:03:06 -0800
Message-ID: <CACOAw_xo_73xxqUty_2e6mvPA8A45MXEefOe8gr7f7owU1XuXQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: check write pointers when checkpoint=disable
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On Mon, Dec 4, 2023 at 10:06=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> Even if f2fs was rebooted as staying checkpoint=3Ddisable, let's match th=
e write
> pointers all the time.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 617340e9ea7f..9a874b4d1501 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4741,7 +4741,7 @@ static int f2fs_fill_super(struct super_block *sb, =
void *data, int silent)
>  #ifdef CONFIG_QUOTA
>         f2fs_recover_quota_end(sbi, quota_enabled);
>  #endif
> -
> +reset_checkpoint:
>         /*
>          * If the f2fs is not readonly and fsync data recovery succeeds,
>          * check zoned block devices' write pointer consistency.
> @@ -4752,7 +4752,6 @@ static int f2fs_fill_super(struct super_block *sb, =
void *data, int silent)
>                         goto free_meta;
>         }
>
> -reset_checkpoint:
>         f2fs_init_inmem_curseg(sbi);
>
>         /* f2fs_recover_fsync_data() cleared this already */
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
