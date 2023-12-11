Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B236A80DE27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbjLKWPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLKWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:15:15 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF492
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:15:20 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35d62401a3dso19998235ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332919; x=1702937719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+NbavSPkNYuuLKazhVu/hAbx07laMBmOoTQUM0p47w=;
        b=uKc867LcrnT2zll+erhwu5iA1GjvlRhqqTni1d3xx+76HCr7wILPbG95X7z0Qf0Xns
         GYkr1wzsqAfqn6YCzRpC4m3TmRjlruLOVSjgQ0QRgnx1jpDWb01tYy6W1SACOlJYJUly
         6K2gg3z7aVtqOhjO3+sf6J85VTVWwyh5hYu5OJqm63ug9VCaOnSLqDXzm44nOqIf/K6b
         zcF82mTAf1xUYZ1H8wUdkLyC4eKTax1kMPxvw8B/LH7soIE8KobmuWs1138iglA0JDvt
         OVlCR5Qc79kDpX1YxGgLjRvkcaaV97EZPudv2EC176l64nqa6zmNpwE2FmHO4jWoOI0+
         ghRg==
X-Gm-Message-State: AOJu0YwLannIVgHWbiYzjI32ryiaKVq1PVjjxqziIHZgq1GtZkY6GGbz
        kqBKKOaNB4RAnfApdblU/Bnf
X-Google-Smtp-Source: AGHT+IHNeSpFqavSvNI7EouqNAWIqxS4EtGj5taHoZVkMX4FUv92lNAhynaV9F2HmvIyMA8Vl+7bmw==
X-Received: by 2002:a05:6e02:148c:b0:35c:9b2c:b9d1 with SMTP id n12-20020a056e02148c00b0035c9b2cb9d1mr5497877ilk.32.1702332919461;
        Mon, 11 Dec 2023 14:15:19 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id z10-20020a0cfeca000000b0067a788e258bsm3671868qvs.133.2023.12.11.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:15:19 -0800 (PST)
Date:   Mon, 11 Dec 2023 17:15:18 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc:     agk@redhat.com, mpatocka@redhat.com, axboe@kernel.dk,
        ebiggers@kernel.org, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
        yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Message-ID: <ZXeJ9jAKEQ31OXLP@redhat.com>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
 <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
 <20231211090000.9578-6-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211090000.9578-6-hongyu.jin.cn@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11 2023 at  4:00P -0500,
Hongyu Jin <hongyu.jin.cn@gmail.com> wrote:

> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> The original submitting bio->bi_ioprio setting can be retained by
> struct dm_crypt_io::base_bio, we set the original bio's ioprio to
> the cloned bio for write.
> 
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> ---
>  drivers/md/dm-crypt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 6de107aff331..b67fec865f00 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1683,6 +1683,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
>  				 GFP_NOIO, &cc->bs);
>  	clone->bi_private = io;
>  	clone->bi_end_io = crypt_endio;
> +	clone->bi_ioprio = bio_prio(io->base_bio);

Weird use of bio_prio() wrapper given the assignment to
clone->bi_ioprio.  I'd prefer:
        clone->bi_ioprio = io->base_bio->bi_ioprio;

Some additional info to be mindful of:

This encryption bio has always been unique (ever since dm-crypt
stopped using the block layer's methods for cloning with 2007's commit
2f9941b6c55d7).

Prior to commit 2f9941b6c55d7, dm-crypt used to call __bio_clone() to
make sure not to miss cloning other capabilities -- and __bio_clone()
does exist again as of commit a0e8de798dd67 but it is private to bio.c
(in service to bio_alloc_clone, etc).

My point: because we aren't using traditional bio cloning (due to not
wanting to share the bio_vec) we also aren't transferring over the
cgroup (via bio_clone_blkg_association), etc.

That can be a secondary concern that you don't need to worry about
(but it is something Mikulas and I need to look at closer).

Mike
