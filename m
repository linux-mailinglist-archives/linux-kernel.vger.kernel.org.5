Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC67A2D95
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 05:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjIPDOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 23:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjIPDOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 23:14:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A171BE3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 20:14:15 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3aca5c85a34so1699350b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 20:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694834054; x=1695438854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MknbitcS/IjJP/65rG9i/JxHOahzo3C2CRnHV4etzRQ=;
        b=UjhO2+tUE2klSEf1MEmIBOSCHOpp0gpGyP6TVRDETgUGzA9lrRWz26FKCtv9f4Rwm0
         HEHOgkn8PnCUZO5CIqyWLt6d7n5WPIqEV9TSt+jQ/kTyTLuZxzFPQbA/du7SBoPFVhj9
         FnJror1LxI2H5Gb4YUB+zvXktUCvdBf0Sxwi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694834054; x=1695438854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MknbitcS/IjJP/65rG9i/JxHOahzo3C2CRnHV4etzRQ=;
        b=THHAitbbNluxMw/dFXbNvrrkmDjrj5Tr87UziuTvXTifCTP2Rs/5wJvj8FjHSnS9UY
         gUFq0lMv4tyJIit8HdkfwJPWl27yyd23H0UjToRaD4HZpxKdOfSMq7JdFePiIIQ6ret1
         epfGN2dnGmfOL53/nLRnSuAgsuxIkWMSs2dhGv7hN3GWeaKXwS9o6vxdEHDe9aJSM7u4
         3WVNOIPkel8p5wuEU+yhJ3I3Em7iSg8566rgvGBRj9P+K5rpNfWsJ8Q0kf3ivwUQz3Le
         KyKUjn4WeqjEnzs/TKdCeHWxFSZOb+3R+PLgBugizgQKc3/I0KHxtn3ALAI4lyKmfe7B
         RCAA==
X-Gm-Message-State: AOJu0Yz4wVxTL6Hn1NxqhVrTK/I2wkGHrCRQnTYQGKbqZOTnHBmbi4d8
        ZYT7EMUzS+CJD4jJVJJLdQ3kog==
X-Google-Smtp-Source: AGHT+IH87UT1CQrYAkuG73czaxNBQAFxkoqGd1ZXXFaZvrdeZTklZIgS2mnZZD3t7+h6ES5+HCpY6A==
X-Received: by 2002:a05:6808:182:b0:3a3:6e43:e681 with SMTP id w2-20020a056808018200b003a36e43e681mr3856696oic.58.1694834054630;
        Fri, 15 Sep 2023 20:14:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j2-20020aa78d02000000b00660d80087a8sm3594809pfe.187.2023.09.15.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 20:14:13 -0700 (PDT)
Date:   Fri, 15 Sep 2023 20:14:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Ogness <john.ogness@linutronix.de>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix duplicate wq_update_pod_attrs_buf
 allocation
Message-ID: <202309152011.EAFC890@keescook>
References: <20230913101634.553699-1-john.ogness@linutronix.de>
 <CAMuHMdWts9NKU=DfPujTKAQNU6T3uawVtejwiTkp=usMu0rH-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWts9NKU=DfPujTKAQNU6T3uawVtejwiTkp=usMu0rH-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:24:25PM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 13, 2023 at 8:05 PM John Ogness <john.ogness@linutronix.de> wrote:
> > One of the hunks for the patch resulting in
> > commit 84193c07105c ("workqueue: Generalize unbound CPU pods") was
> > applied incorrectly. This resulted in @wq_update_pod_attrs_buf
> > being allocated twice.
> >
> > From the kmemleak detector:
> >
> > unreferenced object 0xc0000000040074c0 (size 64):
> >   comm "swapper/0", pid 0, jiffies 4294937296 (age 1936.580s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<0000000076b83a6e>] .kmalloc_trace+0x54/0x190
> >     [<00000000898f2356>] .alloc_workqueue_attrs+0x2c/0x60
> >     [<0000000063365e1f>] .workqueue_init_early+0xe4/0x4b8
> >     [<00000000ca97ff39>] .start_kernel+0x8d0/0xba4
> >     [<000000002ee12080>] start_here_common+0x1c/0x20
> >
> > Remove the redundant allocation.
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Stephen posted a similar patch before:
> https://lore.kernel.org/all/20230905174935.2d75feab@gandalf.local.home

I tripped over this kmemleak report too. It'd be nice to get this into
-rc2. Tejun, are able to get this or the Sep 5th patch to Linus soon?

-Kees

-- 
Kees Cook
