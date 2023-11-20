Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC67F1961
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjKTRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:08:07 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58950BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:08:04 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6cd09f51fe0so3103915a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700500083; x=1701104883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YONG+Z2URy3adHFF9a9PVlDLMWSCL7QCJLkVV8u42Pw=;
        b=ZNkQsobKvKdCL5Kkrx73xMxt+yoOxAEqzqxHfFngU14SX4zsgAupXQztKG+yvgqZL1
         FM3Aqi8+snFliYSusXYCYZM7rVWIotjYuPGz/pr1ADn06YXsElZQCgPOScMz6vpRZevl
         6Lb1tDulwo8ZfQtDob9059QN88PnmtW/n3Ne2d/ARHHS7rkJmacTxfSgW6AupT/x8Wee
         XKb5vT9byw5GYuQpAR0vRgqwkW/W4VsIu2A12/XFTATmuCQAdE2jnoLvwzZg0pQuykR8
         N4STGC4nmcBdZV+PNuTkKeUTq4YxFcmN5jVz1wTJ+WoGEdI9mGajvkLCJT7uVw3xXMJG
         vpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500083; x=1701104883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YONG+Z2URy3adHFF9a9PVlDLMWSCL7QCJLkVV8u42Pw=;
        b=GxLzLUpq0vLFrp/F4PrqtioNgmLeElihM59oebUQTCvnFRFWSqRnNBpuOUARpXISQj
         G21Ho8HWdiYtWP4crZrEJl5eMzBq3WDijes5JyLmfV7vNy4qghqvtoACBSnfid8ffSXo
         I6RWMJr6vzyElAB+i/f3wqH/l/dc3Gns+otOnZwA3WtuzhXOMf/SJj1U+5Qk4ZZwWqx7
         jVfR4SnK7PcbjFR1DPg0TQ1782v7Fvt6xg2+fCtP5U3xcITwcFwpxu6Q6vOB1RGdZV9y
         JC/PxiZbg/A8U9NGqUX3LQYuOMVYIYesWO4yRAVjkylqqizWKZktOHCi4m12CXJVoyWr
         n2cw==
X-Gm-Message-State: AOJu0Yw6k3LBu8R1JIyCesSRrJbopEpigkXYpq7lEltsQ1qCf7XixlOS
        BWlIRc758ml8V2k/QbcUcE7www==
X-Google-Smtp-Source: AGHT+IFntqoennN4i02M6FokmS927XOCsf17rxNKxMCqvhCEf4Qanz23np6ZpH0J6iyKKVqOgDZ1Vw==
X-Received: by 2002:a9d:7f9a:0:b0:6cd:4fc8:3efc with SMTP id t26-20020a9d7f9a000000b006cd4fc83efcmr2991186otp.19.1700500083719;
        Mon, 20 Nov 2023 09:08:03 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o10-20020a817e0a000000b005c98f9d2444sm1389692ywn.3.2023.11.20.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:08:03 -0800 (PST)
Date:   Mon, 20 Nov 2023 12:08:02 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     linan666@huaweicloud.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH 0/3] fix null-ptr-deref in nbd_open()
Message-ID: <20231120170802.GD1606827@perftesting>
References: <20231116162316.1740402-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116162316.1740402-1-linan666@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 12:23:13AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> Li Nan (3):
>   nbd: fold nbd config initialization into nbd_alloc_config()
>   nbd: factor out a helper to get nbd_config without holding
>     'config_lock'
>   nbd: fix null-ptr-dereference while accessing 'nbd->config'
> 
>  drivers/block/nbd.c | 82 +++++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 29 deletions(-)
> 
> -- 
> 2.39.2
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
