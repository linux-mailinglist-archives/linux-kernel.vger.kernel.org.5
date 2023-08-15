Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B877D062
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjHOQwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbjHOQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:52:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587431B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:52:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bba48b0bd2so37197185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692118351; x=1692723151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WU61sDbAiqqbH8I4EHycwjHMRPF7UpaeAi6j88GTWM=;
        b=JknilBfZ8vJ2uS6xiggl6D8ZO/ESLuNJXje0eWh825lDXrEsnEaaKLrwwyvv0uN/Cr
         Lb+mdCKNIXqb9ygJt6wqgRhbgh5Tukk8R9hZS0YRcMs7cN4GTD8w3Bnh0KYu0iQkhsOH
         Ql90A3+NJ8w+5Jsnw1KEtIKI0GeH1EKY7LrGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118351; x=1692723151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WU61sDbAiqqbH8I4EHycwjHMRPF7UpaeAi6j88GTWM=;
        b=A76QF52rp3PuGzIkIkUzLfCLJxjovgjHAD4k4zT3QeT996dc88kTdi+vAOh7HjJVZo
         Q6lim9NTQhkPkLg2fG3/EQ4lK0xt8Af+lvPybb3UbkLccXU5ss7Axrk5RHkpNfN91ESj
         k7wvCpZT23hD2Bic9Xg9p1CWORfvx7B/IB8wzdKaKkoIQQPfb9J8s+DWzM2FQBy85wV3
         9MJeFqumC+KANoDglbz1Qy8KI63L6OJ1dHE6+314E6YCYVRwdabGizFM6LTm8mSgvYVp
         UaX2XfmuQaPK1NjMCVjRYipCavcvCfn/dmWB4DGEcSs9/F4c9RkbiQR6A7K0Od5kDUlC
         9yqg==
X-Gm-Message-State: AOJu0YwF9N0URPhEhlGAs+mcSvAYbwd1TQxxM6Tb99oDcjuRtFYZHncr
        xOZjDhKgzg3h7w2NExdphU3P3w==
X-Google-Smtp-Source: AGHT+IEcqbkJnRxjhuInXKD3uYUMAm3Of1WLzjVQdHZmHoQBHFX2gVtIdwUuLbaIV8rjUcU7seHMxQ==
X-Received: by 2002:a17:902:d4cf:b0:1b8:9b1b:ae8e with SMTP id o15-20020a170902d4cf00b001b89b1bae8emr12591905plg.59.1692118350823;
        Tue, 15 Aug 2023 09:52:30 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001bdccf6b8c9sm6663169plj.127.2023.08.15.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:52:30 -0700 (PDT)
Date:   Wed, 16 Aug 2023 01:52:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Rob Clark <robdclark@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: defer __dma_entry_alloc_check_leak() printk
 output
Message-ID: <20230815165225.GF907732@google.com>
References: <20230815152822.3660784-1-senozhatsky@chromium.org>
 <b6d28992-5adc-5df0-91e5-7fd0571b1465@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d28992-5adc-5df0-91e5-7fd0571b1465@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/15 17:42), Robin Murphy wrote:
> On 15/08/2023 4:26 pm, Sergey Senozhatsky wrote:
> > __dma_entry_alloc_check_leak() calls printk -> serial console
> > output (qcom geni) and grabs port->lock under free_entries_lock,
> > which is a conflicting locking dependency chain as qcom_geni IRQ
> > handler can call into dma-debug code and grab free_entries_lock
> > under port->lock.
> > 
> > Use deferred printk in __dma_entry_alloc_check_leak() so that we
> > don't acquire serial console's port->lock under free_entries_lock.
> 
> Hmm, the print really doesn't need to be under the lock anyway, it only
> needs to key off whether the "num_free_entries == 0" condition was hit or
> not.

I thought about it, briefly. __dma_entry_alloc_check_leak() reads
global nr_total_entries /  nr_prealloc_entries which are updated
(inc/dec) under free_entries_lock, so I didn't want to move
__dma_entry_alloc_check_leak() outside of free_entries_lock scope.
