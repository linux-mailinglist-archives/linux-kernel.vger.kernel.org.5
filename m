Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322157E9137
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjKLOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 09:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:36:28 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B048272C;
        Sun, 12 Nov 2023 06:36:25 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-daf26d84100so2083012276.3;
        Sun, 12 Nov 2023 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699799784; x=1700404584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEg/GqZ9ffdr41qNZLmDnLzaDF78VTcwORCT27DAN2Y=;
        b=LNKR18n0u6Rg6MWGzi7yc3uumFf2cp+54NlB94AEJoJ3ijW229GrR+ks+H/YSMXQeY
         Yc8PUh5JAgQIe5ozMGc1ns95kk+VqCp8J3y6VsYR7rKSaczGSgKY5RmkbM4Lnx7VEOBO
         BZKYXy7O3OPyramt9SaVPmP0UD3qP3TnBvN0xw8FanfoOCov3JrPWFspmJlCJPLskKAV
         +pc8do96YIrmZ7+VKC1Bmy1VzlywNn7E2SSE/Schu+WImFPZbHwyZ2F9mo0tZE9XhwN3
         RiNDiN4L+iE0FM6mNbRwPHweGDm4Fn0xStBQ0oU0oIXibHWZY94P7wroRApJ3NdRedVZ
         6SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699799784; x=1700404584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEg/GqZ9ffdr41qNZLmDnLzaDF78VTcwORCT27DAN2Y=;
        b=O3Gho7VuFPMsAjNdLYt977v3QeHenOUkgOoNc2hTTXxYOUCAtr3fLhNN3cEpMhspnZ
         DsRzxH+TY2RNgkbUgan4/6ueqHv4D+1zCRJ2YSuJG1NfWvQkLXuS/Dt1GBGhQIggp+mr
         zYghUaS/6+G6ys0m7TbzN9b9GVKJZX8AIbwZrgRBp04VCFJvDykzWl+Fv2P98aGYuaq4
         aYvDHkgCzarCQe12au+pw+hCXFjG1mDXjssruTFuVwlV/KS1y0XejT/FXTLp/mQCwqHw
         jZT2mPKR9nU+eHlZUe3MplDSdRalPgtDe5WLcw/m3KWt++1ebz/iMNVBK0bp7HRLNLgy
         pMhQ==
X-Gm-Message-State: AOJu0YyoEDnr+ds2YkPK7Gn90V6Gn3nQ4T6MZpU4KVCq0WZMZRPEnNwj
        WSvp1ARyu3kPOWkj+qLhdai76oMX8YWf5KjEX+I=
X-Google-Smtp-Source: AGHT+IHJa0K/SIYi3QocMqpFJT0NZRjKg9aj4dbl6NuINmOvWrcM2RDv6aqRpvXpgsslU63zozNcSbu+v5pingjjtYc=
X-Received: by 2002:a25:ccd1:0:b0:da1:b041:70ac with SMTP id
 l200-20020a25ccd1000000b00da1b04170acmr4479217ybf.10.1699799784545; Sun, 12
 Nov 2023 06:36:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003c31650609ecd824@google.com> <tencent_3FF186FD92C8C658498FEEEE6EDACC8BA706@qq.com>
In-Reply-To: <tencent_3FF186FD92C8C658498FEEEE6EDACC8BA706@qq.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 12 Nov 2023 16:36:13 +0200
Message-ID: <CAOQ4uxgVPMHJifBZdrFwn+HoUTrj2Ma9ixrwurvU+=MUYB1_Tg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix memory leak in ovl_parse_param
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 12:35=E2=80=AFPM Edward Adam Davis <eadavis@qq.com>=
 wrote:
>
> After failing to parse parameters in ovl_parse_param_lowerdir(), it is
> necessary to update ctx->nr with the correct nr before using
> ovl_reset_lowerdirs() to release l->name.
>
> Reported-and-tested-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/overlayfs/params.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index ddab9ea267d1..1f73f0173015 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -530,6 +530,7 @@ static int ovl_parse_param_lowerdir(const char *name,=
 struct fs_context *fc)
>         return 0;
>
>  out_put:
> +       ctx->nr =3D nr;
>         ovl_reset_lowerdirs(ctx);
>
>  out_err:
> --
> 2.25.1
>

Thanks for the patch!

I prefer to fix it by eliminating the local vars instead of
syncing with them:

I've kept your commit message and tagged you as Co-authored-by:
https://github.com/amir73il/linux/commit/97d58994e880ccb19e1b9b935928538903=
fca41c

Thanks,
Amir.
