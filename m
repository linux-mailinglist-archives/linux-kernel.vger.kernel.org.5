Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47DD7AF290
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjIZSYV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIZSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:24:19 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990910A;
        Tue, 26 Sep 2023 11:24:12 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a9e89fa553so647816b6e.1;
        Tue, 26 Sep 2023 11:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752652; x=1696357452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1jMRdpSdzQrDa2L4TREv6W57Utusu2tmUVuwynV3Fo=;
        b=g3T8f0sHC8FLbHBiykGp4beqQaSbNnIgQldflljH48e29fKs0davxmV7nYDbTJ3mKy
         UP7U0/lAJ2LqprFrr0+hJPA7ivyeHI6IVhgV0SPJO5jkolXXu39xOAw3MU2OyvlC4bmQ
         I8LkBm01RwTHSjg8ir5qNnDgIH1qXrQDUu6l6d4t2GdRpXu4Bl1xalKZFBkcGx8BFzfH
         BnX4/27KkHCNEO478o+rT3wDMgSons6IWJx1mr7dVK137Ah8wk6HANjQaudBSFDJ8Hyg
         5zkfIjLGK1/aJzssuYE6j+C26Q+lVRg2JeZyANXFaS03XjnCND2sn7xfc2t91imSHhNl
         ygig==
X-Gm-Message-State: AOJu0YyUYbDixboNOuMzzOmXgyaJma6eD2/fROOOMVMKgn135lJujsIw
        9vTzpNvk/+QMIcMoGE7YcZsxgEKtFIF/s/I1/D8=
X-Google-Smtp-Source: AGHT+IEJApnyKFAVsD//6ntw+VsS6xU80ugH4FLesVFpfhfQY7QYVZANmM+g46a8zmvq9y4D85SPTRQeVGCGXaNQPvk=
X-Received: by 2002:a05:6808:1823:b0:3ae:100d:5320 with SMTP id
 bh35-20020a056808182300b003ae100d5320mr11905031oib.2.1695752651775; Tue, 26
 Sep 2023 11:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155336.507220-1-bgeffon@google.com> <20230922160704.511283-1-bgeffon@google.com>
In-Reply-To: <20230922160704.511283-1-bgeffon@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 20:24:00 +0200
Message-ID: <CAJZ5v0gRmoSaP3T0s9Li3grBB6DkaXf6D_0oHdw3=-UJWjJEKA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: clean up sync_read handling in snapshot_write_next
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 6:07 PM Brian Geffon <bgeffon@google.com> wrote:
>
> In snapshot_write_next sync_read is set and unset in three different
> spots unnecessiarly. As a result there is a subtle bug where the first
> page after the meta data has been loaded unconditionally sets sync_read
> to 0. If this first pfn was actually a highmem page then the returned
> buffer will be the global "buffer," and the page needs to be loaded
> synchronously.
>
> That is, I'm not sure we can always assume the following to be safe:
>                 handle->buffer = get_buffer(&orig_bm, &ca);
>                 handle->sync_read = 0;
>
> Because get_buffer can call get_highmem_page_buffer which can
> return 'buffer'
>
> The easiest way to address this is just set sync_read before
> snapshot_write_next returns if handle->buffer == buffer.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Fixes: 8357376d3df2 ("[PATCH] swsusp: Improve handling of highmem")
> Cc: stable@vger.kernel.org

If you send an update of a patch, it is always better to give it a
higher version number to avoid any possible confusion.

> ---
>  kernel/power/snapshot.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 190ed707ddcc..362e6bae5891 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2780,8 +2780,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
>         if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages + nr_zero_pages)
>                 return 0;
>
> -       handle->sync_read = 1;
> -
>         if (!handle->cur) {
>                 if (!buffer)
>                         /* This makes the buffer be freed by swsusp_free() */
> @@ -2824,7 +2822,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
>                         memory_bm_position_reset(&zero_bm);
>                         restore_pblist = NULL;
>                         handle->buffer = get_buffer(&orig_bm, &ca);
> -                       handle->sync_read = 0;
>                         if (IS_ERR(handle->buffer))
>                                 return PTR_ERR(handle->buffer);
>                 }
> @@ -2834,9 +2831,8 @@ int snapshot_write_next(struct snapshot_handle *handle)
>                 handle->buffer = get_buffer(&orig_bm, &ca);
>                 if (IS_ERR(handle->buffer))
>                         return PTR_ERR(handle->buffer);
> -               if (handle->buffer != buffer)
> -                       handle->sync_read = 0;
>         }
> +       handle->sync_read = (handle->buffer == buffer);
>         handle->cur++;
>
>         /* Zero pages were not included in the image, memset it and move on. */
> --

Anyway, applied as 6.7 material with some minor edits in the subject
and changelog.

Thanks!
