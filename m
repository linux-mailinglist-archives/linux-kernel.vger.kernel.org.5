Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED937DF1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbjKBLv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKBLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E89E4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698925862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXvh0HaN7chqLYewNa2LL+UKTHm+C7BuJqCkmXwm+hI=;
        b=USCyJZSTDBCXDiq5yT9cLdzjZZnMPqg/SIWV8fo7pZCEiuowbR3Ysylz625DvPIBZN1rzr
        sydkyZjOsC4qEZpkuQ7Indg5HsTWAgaXd3KHt2bHP2OaDjTDA+BPqZuq6kKKxfFjHtUhf0
        uw7OGWiGk3epPAALvs1uE9t9BGAYr9M=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-qyri4EJdPqmIB0aOVYsApA-1; Thu, 02 Nov 2023 07:51:00 -0400
X-MC-Unique: qyri4EJdPqmIB0aOVYsApA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc1682607eso7139515ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698925860; x=1699530660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXvh0HaN7chqLYewNa2LL+UKTHm+C7BuJqCkmXwm+hI=;
        b=hcH6Nfy4GTVt/Ge0LZfAxaioqRYMOeHeYWtlJ59g6QJzzIiF2oHgsMmqyca8LSCxrx
         3oXVjDBf92HZewPioC4wptzuv0RMs1Tgwv7bQ/Apb8cp5EHhpWY8/5CmcDJV0/IGoNjj
         YEU7kpAIk+8c+2VZwXGFWaKIjj39VpjJdOKWcOsfZGaOJCqHYu5Frs/iW2tQbdZwsjLr
         AeVUPzIitbD5eQxE/fasRUiaBN62xZTmHq+3D1iv8aVNHDfnnFR6waAGRXKEsUL69f4o
         NGSh57xPHf/3pzVSQ5tIO7dUa2RYOowKq1tCrhzTyd504H75vwA4hLVSyXgCmMilrg6O
         L5ag==
X-Gm-Message-State: AOJu0YzhfhMBR93hNOQCPUpNzzS/bI4LKrzmgVX+/VQEmAEM/sodD5pR
        HHGP+6zfNKVm8ryEoPHrdGuk0YW8qr92A0SUGlGxvNfyrt3U0irOIy8Pk33m0JfpOImG7xO6clv
        6mueflqlPOwhiraTRmW6nfCwm/aWr+CgqqHH15qmj
X-Received: by 2002:a17:902:ec91:b0:1cc:54fb:60f9 with SMTP id x17-20020a170902ec9100b001cc54fb60f9mr10689023plg.37.1698925859920;
        Thu, 02 Nov 2023 04:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeDlGc9ZGH6KLUUs2Oy1+WEmNgkUJb5lFfrVvtguyJjyCi7rE9YZlkZPXYJTVtaydPfwGnkT4uiclyiO5PhFc=
X-Received: by 2002:a17:902:ec91:b0:1cc:54fb:60f9 with SMTP id
 x17-20020a170902ec9100b001cc54fb60f9mr10689005plg.37.1698925859679; Thu, 02
 Nov 2023 04:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231102015141.1355762-1-suhui@nfschina.com>
In-Reply-To: <20231102015141.1355762-1-suhui@nfschina.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Nov 2023 12:50:47 +0100
Message-ID: <CAHc6FU5H-Ju9129Xr3RGA6DePDL58tQ7nOkSJXdig4gJc1w+WA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: remove dead code in __acquires
To:     Su Hui <suhui@nfschina.com>
Cc:     rpeterso@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 2:54=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> clang static analyzer complains that value stored to 'gh' is never read.
> The code of this line is useless after commit 0b93bac2271e
> ("gfs2: Remove LM_FLAG_PRIORITY flag"). Remove this code to save space.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/gfs2/glock.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 3772a5d9e85c..347f8a020c82 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1524,7 +1524,6 @@ __acquires(&gl->gl_lockref.lock)
>                 return;
>         }
>         list_add_tail(&gh->gh_list, insert_pt);
> -       gh =3D list_first_entry(&gl->gl_holders, struct gfs2_holder, gh_l=
ist);
>         spin_unlock(&gl->gl_lockref.lock);
>         if (sdp->sd_lockstruct.ls_ops->lm_cancel)
>                 sdp->sd_lockstruct.ls_ops->lm_cancel(gl);
> --
> 2.30.2
>

Thanks, I'll add this.

(The subject "gfs2: remove dead code in __acquires" is misleading
because the function this is in is called add_to_queue(); __acquires
is just an annotation.)

Andreas

