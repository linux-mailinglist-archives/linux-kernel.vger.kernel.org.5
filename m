Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3F7575B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGRHtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjGRHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:49:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B010E5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:49:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68336d06620so5456608b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689666574; x=1692258574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUjFu5dPruXh3TEHR0+I/1mPzXw99ve0GbxQPgZtdKo=;
        b=kGJ93Hcc1PZfJTKke9iC3Knd6sVtXpPMTK6oZxNZMlAygny1++zKP5qubQajsp394D
         +QCwne5/74y3f+THbcppvdLpCg2dW2b4qkdAtQ3Gl4bZSrdL1DOqndZ7Ykw3fp4GNE41
         OLn8/k/PlpJYj4XSHhZlDygSflydSm+/tmnWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666574; x=1692258574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUjFu5dPruXh3TEHR0+I/1mPzXw99ve0GbxQPgZtdKo=;
        b=L2cvGEdrNwst3U51U2xgBCwA+9zFAtTCHSf72Wrdf62xaJaq15LGlbXKfLpNMP6Z2J
         kPbSGlAURia4D8siDEEIMhOdL1XswcFzuBZ3nUZHeMOPiCIUYtk0m72Uomp/rWMseFVf
         CmbSEe80GDx2mgxM+8dKKJ7HN6ZuGpVpLhYj8K2iFJreQzS2rblKilCSdPtOvSlEcmps
         elV0k4xhzhW9eoIkK3812MM5zu14kMupBA3XZwlXafFyxNnvLHh1UpKeluInF1WqPDw8
         bT3CzaPrAhCklwaFOVMnGD8rPcqK/kp534xa5VniJ1gmSvo7hhZwW5hk8n6DJZ5Wz8Gw
         Dfvg==
X-Gm-Message-State: ABy/qLbe2Cybt33WGKwEdhRTR/lD4PZHZ7VfovZHkq+MFuC04MXR46me
        6+xH1wL7heqaqwQCOzxyZtXwZuH1MSLcuu+uaQ4=
X-Google-Smtp-Source: APBJJlGzb4kvOBD37QRatvVBuDMLQ7D0f9v4owIcA9Qds5BrBTQ1+3yjQigBXLe83zRFdmnQeOW6sA==
X-Received: by 2002:a05:6a00:3995:b0:67e:18c6:d2c6 with SMTP id fi21-20020a056a00399500b0067e18c6d2c6mr20307992pfb.5.1689666574197;
        Tue, 18 Jul 2023 00:49:34 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:49d1:35f7:f76f:e7b1])
        by smtp.gmail.com with ESMTPSA id t14-20020a62ea0e000000b00680af5e4184sm932816pfh.160.2023.07.18.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:49:33 -0700 (PDT)
Date:   Tue, 18 Jul 2023 16:49:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Huanpeng Xin <xinhuanpeng9@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, axboe@kernel.dk,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xinhuanpeng <xinhuanpeng@xiaomi.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zram: set zram bio priority to REQ_PRIO.
Message-ID: <20230718074929.GD955071@google.com>
References: <20230718071154.21566-1-xinhuanpeng9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718071154.21566-1-xinhuanpeng9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Christoph

On (23/07/18 15:11), Huanpeng Xin wrote:
> 
> When the system memory pressure is high, set zram bio priority
> to REQ_PRIO can quickly swap zarm's memory to backing device,

read_from_bdev_async() does the opposite.

[..]
> @@ -616,7 +616,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>  {
> +	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ | REQ_PRIO,
>  			GFP_NOIO);

[..]

> @@ -746,7 +746,7 @@ static ssize_t writeback_store(struct device *dev,
> ...
>  		bio_init(&bio, zram->bdev, &bio_vec, 1,
> -			 REQ_OP_WRITE | REQ_SYNC);
> +			 REQ_OP_WRITE | REQ_SYNC | REQ_PRIO);

In general, zram writeback is not for situations when the system
is critically low on memory; performance there is not that important,
so I'm not sure whether we want to boost requests' priorities.
