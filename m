Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5717995DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbjIIBvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjIIBvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:51:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D07186
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 18:51:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so43330641fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 18:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694224270; x=1694829070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PrToj7FeDRLWjKBQmt7EM4KaQEIvjVbVJx9Xts6lKOU=;
        b=FU/jo9CmBRp87h5YF6u89FZLl2nXROKCYBvuMKyMAErvenw/EmaHq2zB+mVe/jwnRD
         8ZQKCwQdtQLlSxbor6OVKMAbpJ/YQMqGQK/CEpJOy2nWZhNCLpH+LPALfrEbd3W32at2
         Dr/5/RieJNlZLmjOKE+ji3rdDPyO5d/PWa1OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694224270; x=1694829070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrToj7FeDRLWjKBQmt7EM4KaQEIvjVbVJx9Xts6lKOU=;
        b=D0METd2PWjMhbB/Aat4DThOSRZirvXqG1mJ10XCpb4SoPopFdZevhyND3Btvds0WNX
         pkK6YtxADO8WMPP0lBecXB5T9Q+IoeB6kMIio50stB/j9ZM4K9SZg9klBz6ZU/doFsHY
         P47ZZi/oBv4ZFnHWx3SmJwH9JwxsXgOfzDV8vGgSTf8C9hnxuLjM83O6gSArw/RavBGY
         vHQ8TlxRCb6bYDx+rVYIKHsRxWcQqV/gJhFTHzCgriXwiEkG4DFuRG/l0IhEI+gcpQqh
         1rN5Lpik7/w8Wu5gwips6mx4UgQuUynmSVHjF4R9pA9Zlsx3cm7knBqkVBKROqeS8vya
         2JTg==
X-Gm-Message-State: AOJu0YxlALeYVLWeFUBcok11Ep8f2jBv9t9G+ludEgcHUaaF78dv49nA
        maqnm40AKTArr9cv/Deo8i07NVe83El0ONmUAq52OA==
X-Google-Smtp-Source: AGHT+IHOIuHOCzsUY5H2PPqv3Yp9QbQ2cgHuTrW+0DRaNEAH0oKwk+XmuIxDsdNpVRHw7osDHATTPHsIdwdlvW4jllM=
X-Received: by 2002:a2e:9b5a:0:b0:2bc:c51d:da9e with SMTP id
 o26-20020a2e9b5a000000b002bcc51dda9emr3351866ljj.21.1694224270514; Fri, 08
 Sep 2023 18:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230908203603.5865-1-frederic@kernel.org> <20230908203603.5865-4-frederic@kernel.org>
 <CAEXW_YTxSft0cZkq6UOsdkDxLCjMZfqqK3fBVz6He0UebCqS+g@mail.gmail.com>
In-Reply-To: <CAEXW_YTxSft0cZkq6UOsdkDxLCjMZfqqK3fBVz6He0UebCqS+g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 21:50:59 -0400
Message-ID: <CAEXW_YQec-aUxMQ_tGx9N6_pF=K9vhWZEPT6JGKcemcBXOM+7g@mail.gmail.com>
Subject: Re: [PATCH 03/10] rcu/nocb: Remove needless LOAD-ACQUIRE
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > * Callbacks can be concurrently advanced between the LOAD-ACQUIRE on
> >   ->nocb_cb_sleep and the call to rcu_segcblist_extract_done_cbs() in
> >   rcu_do_batch(), making any ordering based on ->nocb_cb_sleep broken.
>
> If you don't mind, could you elaborate more?

Ah, I see you deleted the counterpart memory barrier in the next
patch. I was reading the patches in order, so I did not notice. I'll
go read that as well. It might make sense to combine this and the next
patch, not sure.

 - Joel
