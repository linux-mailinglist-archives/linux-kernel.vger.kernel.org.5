Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815B752A16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGMR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGMR61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:58:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB26271F;
        Thu, 13 Jul 2023 10:58:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6689430d803so707869b3a.0;
        Thu, 13 Jul 2023 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689271106; x=1691863106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKfG851w+7v64HCUqhsyddmrtv9B3jgmy4U+3AJOSi0=;
        b=Tpi8jBVMfJ94R9QoHKdF/j1p1oqMARooFZQhwIPITtI+JJBKapRuurMzkPV1F89njH
         SnroEDQ141QFLB8+jg9ppQBN0FzGuoBxdERA+De5s1gTNYoES5azCIIWe8Urls7cgMFg
         HvY6H5vZJ4LHh9qO3OfPs6vXvLNFJVwD0axmY6gS4snCVEihzxTxIJaTJXrEw9FNgFXR
         qK1nv17xFfUCbJqZNg99cnvS+Z5lcpBywWHavJr75HIf0dGi30w9p6cdBnv+fc6notKw
         eS0APJYWdFUGp3Hs8uqppkt/sdNvv2XZjh4O16mrqbvZOcoNDwRuUoAuqYBeVgJlcJFl
         b+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271106; x=1691863106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKfG851w+7v64HCUqhsyddmrtv9B3jgmy4U+3AJOSi0=;
        b=YrmDuLAYnDn8+0YDOYjOxy6R76fij8+Dn1O+chQU5DFgG7BEM+ysoJL47yS7C4xAlJ
         y7wAExRvh0WjMXRPRqtxG5EV1GToU4Ulqgl0R5ASaWTVufkwOgCs51HSHZoYDZSHzIPo
         1lvegWIxs3CRu923s8GVFmQRZkz4oqERhBtBTQKUBcobHGqnfBEUKLtwNWneDGUrpqg3
         oZ+6SDW7ncsejjW1eqt2ifNphTgemZQCzPC5VIm4Rnattuy8FKDv86840bUAE0BmbT/Z
         +3Hy8AajhkS+i9MAdobmQJ/ZBQDSBcKsETOv27zIvFPAtMOtJnd518ysamIV7bf7s69n
         Hc/w==
X-Gm-Message-State: ABy/qLbmassgBxnQXTxHLGHvbqMlAz1TxgnzEqS0UQhGTv0W+AYTWkhF
        nsHe+JFruE2p7eyRRl3Dhjk=
X-Google-Smtp-Source: APBJJlF4pxyOX6QrRMj57ayz2rAQCz9RkM+99yAE3hanUQ8ewsYaxFr/emoUJqZPa2vARAzo+9IiMA==
X-Received: by 2002:a05:6a21:6d8a:b0:10c:c9ac:14c6 with SMTP id wl10-20020a056a216d8a00b0010cc9ac14c6mr1842851pzb.39.1689271105614;
        Thu, 13 Jul 2023 10:58:25 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t19-20020a62ea13000000b006732786b5f1sm5704610pfh.213.2023.07.13.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:58:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 13 Jul 2023 07:58:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, zhouchengming@bytedance.com
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <ZLA7QAfSojxu_FMW@slm.duckdns.org>
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
 <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
 <63f93f1c-98da-4c09-b3d8-711f6953d8b7@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f93f1c-98da-4c09-b3d8-711f6953d8b7@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 13, 2023 at 08:25:50PM +0800, Chengming Zhou wrote:
> Ok, this version will only get time stamp once for one request, it's actually
> not worse than the current code, which will get start time stamp once for each
> request even in the batch allocation.
> 
> But yes, maybe we can also set the start time stamp in the batch mode, and only
> update the time stamp in the block case, like you said, has better performance.
> 
> The first version [1] I posted actually just did this, in which use a nr_flush counter
> in plug to indicate that we blocked & flushed plug. Tejun and I think it seems fragile.
> So go to this way that only set time stamp once when the request actually used.
> 
> [1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/
> 
> Another way I can think of is to make rq_qos_throttle() return a bool to indicate
> if it blocked. Tejun and Jens, how do you think about this way?
> 
> Although it's better performance, in case of preemption, the time stamp maybe not accurate.

Trying to manually optimized timestamp reads seems like a bit of fool's
errand to me. I don't think anyone cares about nanosec accuracy, so there
are ample opportunities for generically caching timestamp so that we don't
have to contort code to optimzie timestamp calls.

It's a bit out of scope for this patchset but I think it might make sense to
build a timestamp caching infrastructure. The cached timestamp can be
invalidated on context switches (block layer already hooks into them) and
issue and other path boundaries (e.g. at the end of plug flush).

Thanks.

-- 
tejun
