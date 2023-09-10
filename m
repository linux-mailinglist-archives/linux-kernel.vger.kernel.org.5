Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB85A799EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbjIJPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjIJPEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:04:43 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A864F1B5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 08:04:38 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a812843f0fso2197783b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1694358278; x=1694963078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDYqf7NAkj0kLanm9WYb8IsGKxG9JNncVcxESiCiOCw=;
        b=NuKkLXS+2pejhQEg64mdJfJV2f/dE3a7cidT/a0xxQWUD7DdQXqiywloKlQKBVEtXN
         GU3n0durl1WefMFg2Cjf6T+5ZaiB37cfirMAcN45vld2izPhGL0Gzn/0HKNb/SdQkTcV
         hys3N7HOeVLH7WSZzNRMo+ik68spB66MSctB8SfrCqmf5+SDNIElfHUAixsHULHRkXUY
         JepNvztXEKd/M8lgk1PhbTh9IzeXTL5wb2dCVaZ2R14nUOJzCeqdRcQe66PzBy042p4B
         MvAQoLtqhF+BKE1+3Br7MzGf62mcdd5bYFKERA57CIMgc8yx/X2QRF5LpitBUsVTMvdO
         HLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694358278; x=1694963078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDYqf7NAkj0kLanm9WYb8IsGKxG9JNncVcxESiCiOCw=;
        b=lFUl9bsK3VJYpglFfMZI/oXjRaV9Zs1IM3YNq75Tlk7g2xcduHiXs2I4eAwM9gA/Lg
         t5MGnjOg+HD7CqSuU5LFyx1P3sC5vsX836whH2Zn8+7JY+QZNnddbFibfUsi/v3lfc1t
         WqfDUhhhJT1uIkVWxpgsNlxZenbOlBjBIXDlllj0E9gnrcMt1d+o3wKfvHQsxaJW+fGL
         0fPVWlbffbUsypmWKabODzw/dGb5c6RJfP56QRIe0Bui4W9jORPLYXuZeNcX3vojN0Py
         hq68fQYpJc55LE9YkIaeyrLfBUjJunegHKQ8MCt+7/PhiMSeCZkNGd4itw6Jl7F02m/q
         tWAw==
X-Gm-Message-State: AOJu0YymoIXdJijZScID6xxPkMx/h5Ea0mRAbcI2gYnrClD34zHshABp
        Wju4y+8Pzy55DkFgCAm3OCBz/tBGTq7KW0eNQtM=
X-Google-Smtp-Source: AGHT+IEXCD+cmi1LV9MsXjHZZwUEKfle6kVjsgzdfhPyLV3ELs7tz/YuXNuCfcJSgFQueW67sF3UDw==
X-Received: by 2002:aca:2b1a:0:b0:3a7:56a7:6a91 with SMTP id i26-20020aca2b1a000000b003a756a76a91mr6976757oik.23.1694358277912;
        Sun, 10 Sep 2023 08:04:37 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a697:5800:8ac9:b3ff:febf:a2f8])
        by smtp.gmail.com with ESMTPSA id j2-20020ac84402000000b0040324785e4csm1979738qtn.13.2023.09.10.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 08:04:37 -0700 (PDT)
Date:   Sun, 10 Sep 2023 11:04:30 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Max Hawking <maxahawking@sonnenkinder.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Minjie Du <duminjie@vivo.com>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_perf: Fix printk format
Message-ID: <ZP3a/oD0nzaFdPo/@kudzu.us>
References: <f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 12:34:34AM -0700, Max Hawking wrote:
> The correct printk format is %pa or %pap, but not %pa[p].
> 
> Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
> Signed-off-by: Max Hawking <maxahawking@sonnenkinder.org>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 553f1f46bc66..72bc1d017a46 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file
> *filep, char __user *ubuf,
>  			"\tOut buffer addr 0x%pK\n", peer->outbuf);
> 
>  		pos += scnprintf(buf + pos, buf_size - pos,
> -			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
> +			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);
> 
>  		pos += scnprintf(buf + pos, buf_size - pos,
>  			"\tOut buffer size %pa\n", &peer->outbuf_size);
> --
> 2.41.0

For some reason this patch isn't applying cleanly for me, I'm seeing
the following issue:
$ b4 am -o - f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net | patch -p1

...

patching file drivers/ntb/test/ntb_perf.c
patch: **** malformed patch at line 23: *filep, char __user *ubuf,

Please rebase and resend.

Thanks,
Jon
