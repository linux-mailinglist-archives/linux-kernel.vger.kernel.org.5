Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810FD77BDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjHNQ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHNQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6CA8;
        Mon, 14 Aug 2023 09:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B443B621AB;
        Mon, 14 Aug 2023 16:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2065FC433C7;
        Mon, 14 Aug 2023 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692030367;
        bh=5lsPZ8SK0Jh8HjHHDJJGtSSEohvEECM6ocPfbzBa/04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JEgyhuiSU3m4Jia4n6ZxTEVjZ9SXkbTCEU6TEdWOeBkswm2lfFlnQ1LPia6CcB2ey
         ZFEeHfs0RkBQeTcQbPbfApglNo9xbZUisjv97Ev4c5JkIkIOIefvwObJ8EdhUgm+KZ
         SSyHAtcOCp9pqgGJZPY8ZWAILkXmMKRU9lI07ckBjD937VPW5mjf5LhYcZZ7r3JzL0
         pBomIyDOLhDt6I24EGUyn+Uhzwqnh6edAGrmi23WOBw3krwfWvu4+kPl9J5AZLFmNt
         LcnhWtbC4uLIsBtPBLdYjv1BHahFRhGF0+ESjULhvUhteqJGFA/vX3rNamYzkcqY1B
         YWrBfoCjNHtZQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so7188403e87.3;
        Mon, 14 Aug 2023 09:26:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx7DPID2MlP6Hbh5tCyyoAkoKwYvu7BtsHP2iyiSOAF6A7WsUJg
        yqTSdUaVZlvlHBcnl1HolNqfJpolrVjqtFcaPeU=
X-Google-Smtp-Source: AGHT+IHC3kpfPeGs64G5sojfuXHX9s6bcS0IXNoKiElquATEzVdi0tTCdyqu4T+k5XfbN7PC+uu6YP6HQKvpkfzRDPA=
X-Received: by 2002:ac2:491a:0:b0:4fe:1e74:3f3e with SMTP id
 n26-20020ac2491a000000b004fe1e743f3emr6143823lfi.48.1692030365117; Mon, 14
 Aug 2023 09:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <2a9592bf3340f34bf588eec984b23ee219f3985e.1692013451.git.heinzm@redhat.com>
In-Reply-To: <2a9592bf3340f34bf588eec984b23ee219f3985e.1692013451.git.heinzm@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Aug 2023 00:25:52 +0800
X-Gmail-Original-Message-ID: <CAPhsuW7VXegx5+q0L5UHcRMRAyyJHBM_6ag4Y-o4fSiK1yDjCQ@mail.gmail.com>
Message-ID: <CAPhsuW7VXegx5+q0L5UHcRMRAyyJHBM_6ag4Y-o4fSiK1yDjCQ@mail.gmail.com>
Subject: Re: [PATCH v2] md raid1: allow writebehind to work on any leg device
 set WriteMostly
To:     heinzm@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        xni@redhat.com, ncroxon@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 8:04=E2=80=AFPM <heinzm@redhat.com> wrote:
>
> From: Heinz Mauelshagen <heinzm@redhat.com>
>
> This is version 2 replacing my previous patch series as requested by Song=
 Liu.

For future patches, you can move the line above to ...

>
> As the WriteMostly flag can be set on any component device of a RAID1
> array, remove the constraint that it only works if set on the first one.
>
>
> Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
> Tested-by: Xiao Ni <xni@redhat.com>
> ---

... here, below an extra "---" so that git-am will remove it automatically.

Other than this, applied to md-next.

Thanks,
Song

> ---
>  drivers/md/raid1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index dd25832eb045..913cd46b786b 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1519,7 +1519,7 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,
>                          * allocate memory, or a reader on WriteMostly
>                          * is waiting for behind writes to flush */
>                         if (bitmap &&
> -                           test_bit(WriteMostly, &rdev->flags) &&
> +                           write_behind &&
>                             (atomic_read(&bitmap->behind_writes)
>                              < mddev->bitmap_info.max_write_behind) &&
>                             !waitqueue_active(&bitmap->behind_wait)) {
> --
> 2.41.0
>
