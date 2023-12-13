Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A5A811B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjLMRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjLMQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:58:19 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D37AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:58:26 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67ad5b37147so45130706d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486705; x=1703091505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fko4jEZO7IcAc5n2WrXVozicqYAVH+5PpOz25KhjD+M=;
        b=gPoXeCKIZNUD18rwaP5XJK9p54C20VPhdPX1OLpNz5Vq6ehl4nZWWdUvBK+qu7phR8
         +2841EjvM8c/yaAwXud79dwaIA/n9MTJX2TDHvAydiFmNLQZ9XxWWM6xnGdVmXKYRjAx
         x0MkNsezFO0QisnqnDbKyRI02GrFgjn0/ZoSpW8sLIwI9FmFLOMMGTuvsf0G79e7rWen
         ysL2Wq0KIoFxZVNqLgLvx0XMCZfVX8f5Be+99fjUeEJ//csAvyw/6SGYgkUiitKgxG8H
         QNW3dT7PV8zDcoEsrv07/jeeOzyJS/ztE8ZMyU0ygSAw4kCFDKY+ckuqT6CGykTMg1n6
         bAqw==
X-Gm-Message-State: AOJu0YxJEujP/ZErI3Noy//WkXpPtARljTVbwauGpnaPkI6v4tSYfggn
        7C0ngcmDl0FmSFDlHFrd1BFa
X-Google-Smtp-Source: AGHT+IFvVkIflp9TiGbkJvpAu1da6qN2nmcyxFmltt+dcHVJ2+E3ImsBHyyCd+RBhaSCAT0Tc+H6Gg==
X-Received: by 2002:ad4:5046:0:b0:67e:f3e3:8291 with SMTP id m6-20020ad45046000000b0067ef3e38291mr2273884qvq.12.1702486705405;
        Wed, 13 Dec 2023 08:58:25 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id mi14-20020a056214558e00b0067a276fd8d5sm131380qvb.54.2023.12.13.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:58:24 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:58:23 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc:     agk@redhat.com, mpatocka@redhat.com, axboe@kernel.dk,
        ebiggers@kernel.org, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
        yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 1/5] block: Fix bio IO priority setting
Message-ID: <ZXnir8x6127EW7Gp@redhat.com>
References: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
 <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
 <20231213104216.27845-2-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213104216.27845-2-hongyu.jin.cn@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13 2023 at  5:42P -0500,
Hongyu Jin <hongyu.jin.cn@gmail.com> wrote:

> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> Move bio_set_ioprio() into submit_bio():
> 1. Only call bio_set_ioprio() once to set the priority of original bio,
>    the bio that cloned and splited from original bio will auto inherit
>    the priority of original bio in clone process.
> 
> 2. The IO priority can be passed to module that implement
>    struct gendisk::fops::submit_bio, help resolve some
>    of the IO priority loss issues.
> 
> This patch depends on commit 82b74cac2849 ("blk-ioprio: Convert from
> rqos policy to direct call")
> 
> Fixes: a78418e6a04c ("block: Always initialize bio IO priority on submit")
> 
> Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

Would be nice to get this block core fix upstream ASAP independent of
your various DM changes.

Please simplify this patch's header like was requested in review of v4:
https://patchwork.kernel.org/project/dm-devel/patch/20231212111150.18155-2-hongyu.jin.cn@gmail.com/
