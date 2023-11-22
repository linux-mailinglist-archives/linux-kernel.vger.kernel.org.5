Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC47F502E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbjKVTF5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 14:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbjKVTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:05:55 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B1D8;
        Wed, 22 Nov 2023 11:05:50 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-507bd644a96so40705e87.3;
        Wed, 22 Nov 2023 11:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679949; x=1701284749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3DNU9RMxqoZMqebJLyyHcRZ4hXrYDXHtRdTf424f6I=;
        b=YddPqU7nhBay9bptDw5LcviTSMqpjdX0TlG0iTLzLtX2d7XQGImA2orVtGvWd/Ym0l
         Ezu78/bf8YHGb8Gc2W/sgKeI/7cmU9AOSMY2dlyBgbOeX6rgSr7pae1NHy60I2m5vWJY
         5KlCvor0KI76E+lyhU91+0J5mPr3sOFAweS8FKWk9s2O+esbDiQSh1W2JypOc2aWNdVz
         GXgsiuHJCCiazFI9G7uDW8KIa+NrC47IJcpxQaf2K/DIAj0gnArouceRDpnb9UQZteve
         sTwasf9KALX5goH/Gv/ZqyNla+Z1nGIyxUQ9PVrPyh2vcURD/CKqqzqZ/CNh7zvKQGEV
         D7DQ==
X-Gm-Message-State: AOJu0YxEZg0YPDRPviYj74DjiTKupyJ0SKWC4oaSCGj5IyuTVAbIZH2k
        +6JkBLe/kS10+jUMuzJPVfMaGI0Bvtb11A==
X-Google-Smtp-Source: AGHT+IG5X1M6ejy2DImAB0FL2IBJNKf1oN46NuVKf2uO+SKGT2fIhLuR15/Loa86VgXF2ROYxhDC4w==
X-Received: by 2002:a05:6512:41e:b0:4fb:9168:1fce with SMTP id u30-20020a056512041e00b004fb91681fcemr2282937lfk.59.1700679948672;
        Wed, 22 Nov 2023 11:05:48 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b0050097974ee0sm1944520lfs.224.2023.11.22.11.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:05:48 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-507ad511315so70413e87.0;
        Wed, 22 Nov 2023 11:05:48 -0800 (PST)
X-Received: by 2002:a05:6512:15d:b0:50a:a331:27d7 with SMTP id
 m29-20020a056512015d00b0050aa33127d7mr2505540lfo.33.1700679948230; Wed, 22
 Nov 2023 11:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20231116155312.156593-1-dhowells@redhat.com> <20231116155312.156593-5-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-5-dhowells@redhat.com>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Wed, 22 Nov 2023 15:05:37 -0400
X-Gmail-Original-Message-ID: <CAB9dFds4+gxWidvxWBU8PNO+wiLO0CkpudahjrymFxj5U_qXoQ@mail.gmail.com>
Message-ID: <CAB9dFds4+gxWidvxWBU8PNO+wiLO0CkpudahjrymFxj5U_qXoQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] afs: Fix file locking on R/O volumes to operate in
 local mode
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
> AFS doesn't really do locking on R/O volumes as fileservers don't maintain
> state with each other and thus a lock on a R/O volume file on one
> fileserver will not be be visible to someone looking at the same file on
> another fileserver.
>
> Further, the server may return an error if you try it.
>
> Fix this by doing what other AFS clients do and handle filelocking on R/O
> volume files entirely within the client and don't touch the server.
>
> Fixes: 6c6c1d63c243 ("afs: Provide mount-time configurable byte-range file locking emulation")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index 95d713074dc8..e95fb4cb4fcd 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -407,6 +407,8 @@ static int afs_validate_fc(struct fs_context *fc)
>                         return PTR_ERR(volume);
>
>                 ctx->volume = volume;
> +               if (volume->type != AFSVL_RWVOL)
> +                       ctx->flock_mode = afs_flock_mode_local;
>         }
>
>         return 0;

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
