Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47908802E62
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjLDJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:18:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2CDD6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:18:26 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a196f84d217so407780366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701681505; x=1702286305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXAi5NI2MrW3Fatk16RutSorqhrUvDxDYgQUDzoTfbM=;
        b=pBTtMaNkFYJXWT8MvFNiQDVfo4JW05flMrS9IbSYHs1e8RO083Nqts+x0qd6aa/vbQ
         otyzFHXgxj00BydGqE611hGKDiArr/+gC6CVEWD1RHjwZUYFzADhrvK92+VEVIl8GTNS
         UF3mLqEBSUxFqJ/UN6WX0FPnVXFvzIGMvIx1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681505; x=1702286305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXAi5NI2MrW3Fatk16RutSorqhrUvDxDYgQUDzoTfbM=;
        b=NpXaflivGBpiOtvfbZc1B8tTunhYvBJGyzYTtfip8Nn1eL1t/khBVvc78drqc4COlT
         7GbPrJd9nqbq2bHF0rpmPSUF31RBnDjpkyXWoxtYqgMMHPx00iivfUZFy7LwpeflLmHp
         nVOpvaMk1kootGfDHr6Yk8ZXP2qUaiYaFRvxKKyo7pcn0uQGVSd+Adx7rik7yK1g2T2R
         7PdRfcDWjLjT4iQwuC6p88Wr8EUnmOHF2ccXApx8pCE7RvMqRhm0gUhsge42GrDo9Eo4
         38yLxVfBZBueDKllOMel6F2r9icZKGt5Ym7D67G9pWSQf7w5orsUJHWfLB9BJh+Z778p
         yltA==
X-Gm-Message-State: AOJu0YwuCnfMSRY+YK0FXHAeNTF2PPW3/kwK3XDyV+Tbiue7T4ggRKh7
        5PIZXCUBvzerdUD/pUR7U0B+u7tpnrtLHptfiwV+mg==
X-Google-Smtp-Source: AGHT+IHEEGkN1fICudbIMnSmiwiXlbJEyZRDhNcoe/EUi/R4BiPvNP6hh/8OuUPPci9oaSihwOyS1tQM2RXeEl//EYE=
X-Received: by 2002:a17:907:1719:b0:a18:a4f6:39e6 with SMTP id
 le25-20020a170907171900b00a18a4f639e6mr2909772ejc.72.1701681504683; Mon, 04
 Dec 2023 01:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20231116075726.28634-1-hbh25y@gmail.com> <CAJfpegvN5Rzy1_2v3oaf1Rp_LP_t3w6W_-Ozn1ADoCLGSKBk+Q@mail.gmail.com>
 <27ad4e0d-ba00-449b-84b9-90f3ba7e4232@gmail.com> <ZWovK12GaC-_Ya0Z@redhat.com>
In-Reply-To: <ZWovK12GaC-_Ya0Z@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 4 Dec 2023 10:18:11 +0100
Message-ID: <CAJfpegt4+W2N0UW=6JtCAhVdkJisy5Q0+=T19fkQBDcRxjAn4g@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Hangyu Hua <hbh25y@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 at 20:08, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Dec 01, 2023 at 10:42:53AM +0800, Hangyu Hua wrote:

> > I think setting fc->dax to NULL keeps the memory allocation and release
> > functions together in fuse_fill_super_common more readable. What do you
> > think?
>
> I agree with this. fuse_fill_super_common() calls fuse_dax_conn_alloc()
> which in-turn initializes fc->dax. If fuse_fill_super_common() fails
> later after calling fuse_dax_conn_alloc(), then cleanup of fc->dax
> and other associated stuff in same function makes sense.
>
> As a code reader I would like to know how fc->dax is being freed in
> case of error and its right there in the error path (err_free_dax:).
>
> I think I set the fc->dax upon initialization. Upon failure I freed
> the data structures but did not set fc->dax back to NULL.
>
> To me, this patch looks reasonable.
>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Applied, thanks.

The patch is clearly correct, so I have not major issue with it.   It
just bothers me a little that we have two cleanup instances when we
only need one, but I bow to the opinion of the majority.

Thanks,
Miklos
