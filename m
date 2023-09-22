Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4227AB2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjIVNaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjIVNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:30:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBAE4B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:30:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5789de5c677so1583434a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389429; x=1695994229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEXXxtAaC4ky8k28Oo7NrqKscKudBPHppqHeDnkzTvg=;
        b=k4fZbfn3dmTkpr1eKlDOJkRvrU+ePBeJ3+G6SxEVy3q6mef4KlqzAuDiFgFsb7MY33
         c0zptYb/mnn2SA1wtTaFlKK2YKqA8yTlmL7a0gOEPpfBKkPyYe/mQMgwfYgeYFa3CNGM
         jsbLYAxtm+HMf+Ib3fFrAFHq58GlXUENz7HL62YeFfITloRmTgFyWbg/48yetwwCcMyv
         vOoEZ7vNc4faLXbB+fwWaCWvYCNo+c0KzCrTs8xAB8yDv+mpDi2QyTKO1LjgF+lVviKb
         igVdO4yT++WRVDRfEfEXDVzRLtzOyZhr7Qqqrz0sW0QixnXzN4xOqWvdrn8dhDq8V+M0
         GN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389429; x=1695994229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEXXxtAaC4ky8k28Oo7NrqKscKudBPHppqHeDnkzTvg=;
        b=jQknHRaTNzZulxN0Q89N94lhJvCiLNFr0/Rr+leTMeLv17MNAlFT6HYECadvdGWEQn
         R2DsIyy+ZsjwQQa95BqKT7sjmRqVHfCJRPK/dUEIjAvA0SlwINRQu/b7QySa7og9JHVM
         8uZ75+Beme/T3yJhkiyIsBbHPVsrQMwaaERwKpqGHLjZ0DC/vadNjcxiN5Z3LF29RnIK
         J0rvNh3hkt820GuJNYk+Qs2TqyQiomNbJzLeD8uCFdbV0MlWY6m6Blek016/mDx0L4V1
         ZWL/wx+V+7q7PW/1OHo5sv/FrBnIDpk86FEnWLvDHL/M6Y5c+ferzEcXSjuiKtNxhIml
         t7Zw==
X-Gm-Message-State: AOJu0YwUONSG3sDSNMghSnXiJZgL81U3E0DyUwsiL1E4TGgb4QVfIOvr
        RZzgY8AxnBD3yHkvwfTiUwU=
X-Google-Smtp-Source: AGHT+IFcUTc5fw6pAkQV0oegpKWkDcHaEnc5xW/PawogxBs/JPnE+nt1X9Qi+rnPHNtesftRYd4lFA==
X-Received: by 2002:a05:6a20:428e:b0:15a:478f:9f2e with SMTP id o14-20020a056a20428e00b0015a478f9f2emr9656017pzj.1.1695389428733;
        Fri, 22 Sep 2023 06:30:28 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id j21-20020a62e915000000b00686bef984e2sm3148424pfh.80.2023.09.22.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:30:28 -0700 (PDT)
Date:   Fri, 22 Sep 2023 06:28:14 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v4 2/5] lib/test_bitmap: add tests for
 bitmap_{set,get}_value()
Message-ID: <ZQ2WboApqYyEkjjG@yury-ThinkPad>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-3-glider@google.com>
 <ZLyQk5Wmcx7Cf84W@yury-ThinkPad>
 <CAG_fn=WQORJConbBPzaNF2Nuxaf9Jmhy1Vgj=nk7gj902SQxOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WQORJConbBPzaNF2Nuxaf9Jmhy1Vgj=nk7gj902SQxOA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 09:57:32AM +0200, Alexander Potapenko wrote:
> > > +     unsigned long val, bit;
> > > +     int i;
> > > +
> > > +     /* Setting/getting zero bytes should not crash the kernel. */
> > > +     bitmap_write(NULL, 0, 0, zero_bits);
> > > +     val = bitmap_read(NULL, 0, zero_bits);
> > > +     expect_eq_ulong(0, val);
> >
> > No, val is undefined.
> 
> Why? bitmap_read(..., ..., 0) always returns 0.

Because it's unexpected and most likely wrong to pass 0 bits. We
guarantee that bitmap_read() will return immediately, and will not
touch the memory. But we don't guarantee that we return any specific
value.

It's not a hot path, at least now, and we can spend few extra cycles
to clear output register and return 0, but user should not rely on it
in any way, especially in a test that is intended to show an example
of using the new API. 

Consider a less relaxed environment, where we really have to count
cycles. In such environment, we'd return a content of the 1st input
argument, just because it's already in R0, and compiled doesn't have
to:

    mov r0, #0
    ret
