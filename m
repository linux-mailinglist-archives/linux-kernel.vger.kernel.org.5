Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04938752A96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjGMSyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjGMSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:54:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41BE3589;
        Thu, 13 Jul 2023 11:54:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-262fa79e97fso524530a91.2;
        Thu, 13 Jul 2023 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689274437; x=1691866437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/Rh3N7Hpk2RvvFOi7xZjggtoYOkILDnWZuYI4DoA10=;
        b=HW5cIj8f6UrrRKqCSEGCEMigQIuAtz5FZOoyenrcfjQXnkfk3x91KqAgmOfMu8rjb0
         Ck7tu7PddO79GoM9qYGS7C5Xmp7NtD3l3Ns10x1+yAakLRUN0IwG4ffbzHFORM5JjEK7
         XoqNvaQKUfKQuOFxG8WDYi3aM5Mwe7+AaPuBKK9Iih+Z8SC1e7KILlhVi9WuzfQdrHlp
         tX9sJsE4pQET7vVqcOht85rsQOHTeT9LGfxwrSPrzw69KHgZP3dH4E01yzu5A0S6DWwQ
         7EBTGYF8Cw5Pp86VOfuv5xYomnc9HKvK9VUJmyCveJoOvbxWORxNPPNzkQ1CVAsvt35m
         O2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274437; x=1691866437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/Rh3N7Hpk2RvvFOi7xZjggtoYOkILDnWZuYI4DoA10=;
        b=Q4zGKmKl3FfJ0jQjeHwnZedqU36DzpOMEd8XvNjxrsiY+7JEl8jdnoyBngf0HMJXXq
         l6Iz7U15V46irymToyX+50XyLH2Mo7rYjFPehEZnETASLIfi7nnktEodehKtKnC+cV/l
         g4g9VSrfvT30crZwf/ynQZXHehufoQyhg2jh8kTRtEU7sld6RWQlCZEJqfmPALv0fD5R
         CFNsDzr7AHlDY3XuGL4aVS5dFvK41qq2P8IzuZMHJ6Zq3xzF642J6/qOk9FgUAHSQHuy
         eV2nDR9RBBdzl373mRmNwavfNbsoCW2Tkgx2EYU7dm23bS/FPJf1wAQF3A6bqdl1bvaO
         IvNg==
X-Gm-Message-State: ABy/qLbMADM/57V1QEUvcfMFHsF4+M5JYfbZa+GtQBGr5HFEYNnizQUO
        nC7oVVsw9CN0x6LIaCJHqvs=
X-Google-Smtp-Source: APBJJlH+ZBRMwsng5OvfXU8dbB3Xd4jXwQ7bYsHQHvrkPh/St/88lWUsQjEONL/kaZAV4BM6m8npqA==
X-Received: by 2002:a17:90a:43c3:b0:260:d8c0:ae79 with SMTP id r61-20020a17090a43c300b00260d8c0ae79mr1339393pjg.35.1689274436784;
        Thu, 13 Jul 2023 11:53:56 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090a2a4d00b00262eccfa29fsm13036699pjg.33.2023.07.13.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:53:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 13 Jul 2023 08:53:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Linux PM list <linux-pm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: Consider switching to WQ_UNBOUND messages (was: Re: [PATCH v2
 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE
 mechanism)
Message-ID: <ZLBIQ550U-PhkuKJ@slm.duckdns.org>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org>
 <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
 <ZK3MBfPS-3-tJgjO@slm.duckdns.org>
 <20230712080504.GA3100107@hirez.programming.kicks-ass.net>
 <CAMuHMdUMRS9_nJXp3rrWQrODRQcBQggze0k=0GjSScCknFmmgQ@mail.gmail.com>
 <20230712122745.GH3100107@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712122745.GH3100107@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 02:27:45PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 12, 2023 at 11:04:16AM +0200, Geert Uytterhoeven wrote:
> > Hoi Peter,
> > 
> > On Wed, Jul 12, 2023 at 10:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Tue, Jul 11, 2023 at 11:39:17AM -1000, Tejun Heo wrote:
> > > > I wonder whether the right thing to do here is somehow scaling the threshold
> > > > according to the relative processing power. It's difficult to come up with a
> > > > threshold which works well across the latest & fastest and really tiny CPUs.
> > > > I'll think about it some more but if you have some ideas, please feel free
> > > > to suggest.
> > >
> > > We could scale by BogoMIPS I suppose, it's a bogus measurement, as per
> > > the name, but it does have some relation to how fast the machine is.
> > 
> > That's gonna fail miserably on e.g. ARM and RISC-V, where BogoMIPS
> > depends on some timer frequency.
> > 
> > R-Car M2-W with 1.5 GHz Cortex-A15: 40.00 BogoMIPS
> > R-Car V4H with 1.8 GHz Cortex-A76: 33.33 BogoMIPS
> > 
> > while the real slow 48 MHz VexRiscV gets 128 BogoMIPS.
> 
> Hehe, OK, really bogus then. Lets file this idea in the bit-bucket then.

I think it can still be useful. On ryzen 3975wx, it's 6989.92, so while it
may be off by some hundreds of percents, there are still orders of magnitude
signal range and that should be enough to suppress most spurious warnings.
I'll post something later today.

Thanks.

-- 
tejun
