Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7027D465E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjJXDxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjJXDwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:52:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E310E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:52:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41cbd1d7e04so23843151cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698119550; x=1698724350; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HLvkudqanD7ho/JohV3yYMvdl0m/YZEqjpT0bM0Y7Gw=;
        b=XNc3KcIb+IR8QS+MHo1fOpYYF218BMMpw9ZcQas/Zpj/xANT2PzcX4M5DsFY6GkHqo
         GerPdig2n7O8sfAn0qDHvpz7jzGrLAenJNm2fMLtJgW6GHMP1BM/mocMG5qmzrI00V8z
         OD2X/6lxilvyC0tlj2dWBsJrLgBQnunzBka62gH08EiefGgRKntxbfvMO3yzbVXTldlr
         QPnp2txrzw92B0Cicpf2FTbrf7sRyc3NGEdJdeTq2R4bArrNpYRBleLaA/LChZocuWuk
         pjqLpKlaAh+qrOCmUZL5tI60SseyZxjXGmoEe6jGKxvMeejw6mSyHUDZQTDbWUQwK6Hr
         j0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698119550; x=1698724350;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLvkudqanD7ho/JohV3yYMvdl0m/YZEqjpT0bM0Y7Gw=;
        b=kxE2+wI04u8aijhzB5o1qbTZNnJNCk5nvMTFPU73P0AOln+GgpigEVE+HSXhzo0bDA
         r2VXqG/elt1bK0DYu7Ame/iEGjguRlvruCqT8k7ds1GiG5ojv3vuAntlQG6ucf1iEJha
         GX9pNgJvFT8vca5Nupi6gqa7UONMprFpLCKcpZUbzBORuoGNY6Lhq7N4GH5awMLKXCrw
         wcIpFzKAMS4JqJfy6ZCl36wQs/VFOQMW6/Bl7QVAHez2hPsnRwbcRtLqMTNcJ2rY/OZ8
         WAEi2P0q8nuyGvOTAHtVeu3Dy4dpsCmtqA/0DyYvaqtuPGFoUO484EjzjP7hUBuYQP6m
         EhCw==
X-Gm-Message-State: AOJu0YyhcqN8qKtle7iOXONvShTSEi6M5F8CEKm0s9aZX3XRHF0lyYjg
        XERjetNsMsaDiBofUgq6/w8M
X-Google-Smtp-Source: AGHT+IHxiDP0oQS0IHZl9PGSzz8xG4YIOPId7UdDJm7uyxgqMm7h4born+PADWw4P1qOvg39+RCjvw==
X-Received: by 2002:ac8:5c08:0:b0:41b:ff51:4e72 with SMTP id i8-20020ac85c08000000b0041bff514e72mr11390786qti.48.1698119550281;
        Mon, 23 Oct 2023 20:52:30 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id kr25-20020ac861d9000000b004181c32dcc3sm3179140qtb.16.2023.10.23.20.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:52:29 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:52:29 -0400
Message-ID: <85311850a862fe6ccb946634429b890a.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v11 11/19] dm verity: set DM_TARGET_SINGLETON feature  flag
References: <1696457386-3010-12-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1696457386-3010-12-git-send-email-wufan@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> The device-mapper has a flag to mark targets as singleton, which is a
> required flag for immutable targets. Without this flag, multiple
> dm-verity targets can be added to a mapped device, which has no
> practical use cases and will let dm_table_get_immutable_target return
> NULL. This patch adds the missing flag, restricting only one
> dm-verity target per mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v1-v10:
>   + Not present
> ---
>  drivers/md/dm-verity-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This seems reasonable to me and matches with other users of
DM_TARGET_IMMUTABLE.

Alasdair, Mike, can we get an ACK on this?

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 26adcfea0302..80673b66c194 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -1503,7 +1503,7 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
>  
>  static struct target_type verity_target = {
>  	.name		= "verity",
> -	.features	= DM_TARGET_IMMUTABLE,
> +	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
>  	.version	= {1, 9, 0},
>  	.module		= THIS_MODULE,
>  	.ctr		= verity_ctr,
> -- 
> 2.25.1

--
paul-moore.com
