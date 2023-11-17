Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB57EF639
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjKQQaZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Nov 2023 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKQQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:30:24 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B4194;
        Fri, 17 Nov 2023 08:30:21 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso3166312e87.1;
        Fri, 17 Nov 2023 08:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700238619; x=1700843419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gRGViebN5UIVPhYisJJilLXPh7pb0PWL5nNBzX21fU=;
        b=RZPXOws67z2e5hp7SWdr0xQ0KuOXD3fo7QMvQK16zgO4q73J/AhUJC+pKVa4kiyG1l
         Hh1aFEdMBnXyjCnPX88Gdg+7gfSCoIptBd8Zxgc+ekQ1UqfIVX5n+cZk8prLGKAsQnKU
         xI43Qo8jGAjxiXRTP81pvqfyB1VhGSt63MCdREZXaI8maWOy5YDSg2OmagszocmXbtxk
         hYmMRdSl+tRCvqMqOdWH5+GAzxbKMft4cWWGKT/Q2JqeaLT+X7ruQngTOtWFFOxuHGtJ
         ppNHbq2Ij1RcRmTAuf2te/OKmISCfIhNzsBpa6padnu52C2qOFJYmRnqfqOirNtaldh+
         EBpA==
X-Gm-Message-State: AOJu0YyCRinT4idW0znUDAX+PbUFu1WBZpZPodmMlxDlmWB5HqmrAd+G
        cpoMjEhdc4pxcKqAhXDvjaM4GItHPceXPg==
X-Google-Smtp-Source: AGHT+IFG4t5wn7qEp4+WvBQ9OsfM+jl4yc7TSzV8v9768oGnQU+KCdg0NY/gfoW4g/wKmIe854uCvg==
X-Received: by 2002:ac2:54b2:0:b0:507:975f:6ccb with SMTP id w18-20020ac254b2000000b00507975f6ccbmr70109lfk.2.1700238618904;
        Fri, 17 Nov 2023 08:30:18 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id bo1-20020a0564020b2100b005435d434a90sm853729edb.57.2023.11.17.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 08:30:18 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso3277314a12.1;
        Fri, 17 Nov 2023 08:30:18 -0800 (PST)
X-Received: by 2002:a17:906:748c:b0:9e1:a5eb:8cb4 with SMTP id
 e12-20020a170906748c00b009e1a5eb8cb4mr15087651ejl.58.1700238617911; Fri, 17
 Nov 2023 08:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20231116155312.156593-1-dhowells@redhat.com> <20231116155312.156593-3-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-3-dhowells@redhat.com>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Fri, 17 Nov 2023 12:30:06 -0400
X-Gmail-Original-Message-ID: <CAB9dFdtaWy_KOONZ_TLw8vnkDQp_2B1=vWfFrHv1K55M3AutKQ@mail.gmail.com>
Message-ID: <CAB9dFdtaWy_KOONZ_TLw8vnkDQp_2B1=vWfFrHv1K55M3AutKQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] afs: Make error on cell lookup failure consistent
 with OpenAFS
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Markus Suvanto <markus.suvanto@gmail.com>,
        linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:53 AM David Howells <dhowells@redhat.com> wrote:
>
> When kafs tries to look up a cell in the DNS or the local config, it will
> translate a lookup failure into EDESTADDRREQ whereas OpenAFS translates it
> into ENOENT.  Applications such as West expect the latter behaviour and
> fail if they see the former.
>
> This can be seen by trying to mount an unknown cell:
>
>    # mount -t afs %example.com:cell.root /mnt
>    mount: /mnt: mount(2) system call failed: Destination address required.
>
> Fixes: 4d673da14533 ("afs: Support the AFS dynamic root")
> Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/dynroot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index 4d04ef2d3ae7..1fa8cf23bd36 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -132,8 +132,8 @@ static int afs_probe_cell_name(struct dentry *dentry)
>
>         ret = dns_query(net->net, "afsdb", name, len, "srv=1",
>                         NULL, NULL, false);
> -       if (ret == -ENODATA)
> -               ret = -EDESTADDRREQ;
> +       if (ret == -ENODATA || ret == -ENOKEY)
> +               ret = -ENOENT;
>         return ret;
>  }

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
