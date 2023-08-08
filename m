Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D27748EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHHTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjHHTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:44:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731416B16
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:48:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so19412005e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513300; x=1692118100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uf6Qwp5IcBfnw8cvFBZLBD+6OL+Kh6Nn1R+GOEG85Xs=;
        b=pTO3E+bDUQBxEWbStdHmEJ+mRxE1x8rKrGZET0e5t/tuf97PkeNnstXmTdkvFXN3qn
         iaapx6OWovEGi31JU2k+WIbEmIZOMv6mGr2RV9xb5gxnaR9YxvbtUwogRzE/KkOtNatx
         uUyUUR6g5Pznkn/GAA10/fex6mffzrhOHmETT27KDT6yehwH89d1FtRf1zQGTb9/Cskr
         UEEnTSRxDInMsT/5Mk36+iHtTmLl16NqFcQwkJf6wt3fHjAxPmZQsAaiBdes2CEJxmOB
         sOG0DNm88jE5L+eQOMAjkCPoqbvm7R+3Plm+PBPlbDg63KGojPX1DJC367joUbVs5iCj
         k/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513300; x=1692118100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf6Qwp5IcBfnw8cvFBZLBD+6OL+Kh6Nn1R+GOEG85Xs=;
        b=BkhjNtpz6/CkbFvDyUxtfn0QPB7FWIDESZM0z2nLdljHZn47iF9kRMTipW48dI7CvC
         QLnrjh1g/Cj23U3p483FQoyJbQuPUXXEmM6Y1Q/gQapUmOPZ4FfeX3313OmmCzrfgqwi
         pG2GhecISBF9hfb46mbrFnPUU4hHPItB596KNTF0NzUxao1tWXp2bKiyPfkEC9zPvqg1
         eDOLzE1MnI688htZkv2OzUSF6ylrjDIv9Siii4AMY+KzvaZhuTJ9qRZ47SKsAO3z358r
         1/a8LE8u3zhw8wfyze+w5/okNNsvd95B8qoQdXGA5LcEXLMvlpQbBm0NXr72JmdXBBbG
         QtFQ==
X-Gm-Message-State: AOJu0Yx/q+I7oH9GpgDTHmINahC66HV+MLgLHYhQhMqxHx4UGAC4XvJ7
        AhttTSRx3xUOgMONrhGKKVBrlzPvKOk+4UvwhsYu2w==
X-Google-Smtp-Source: AGHT+IEoY3AsYBoeqi4l/r6UwxzB9eht2nw5J7VW0R/XG0aViKCtpjVte+QLSioXOu6hnHCUhQPKuQ==
X-Received: by 2002:a2e:3004:0:b0:2b4:6d59:7863 with SMTP id w4-20020a2e3004000000b002b46d597863mr8284441ljw.25.1691493425593;
        Tue, 08 Aug 2023 04:17:05 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003fa98908014sm17836323wmq.8.2023.08.08.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:17:05 -0700 (PDT)
Date:   Tue, 8 Aug 2023 12:17:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] arm64: kgdb: Roundup cpus using the debug IPI
Message-ID: <20230808111703.GB411689@aspen.lan>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
 <20230807152444.GA375529@aspen.lan>
 <ZNEV_mz4VU1HyBc9@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEV_mz4VU1HyBc9@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:04:14PM +0100, Mark Rutland wrote:
> On Mon, Aug 07, 2023 at 04:24:44PM +0100, Daniel Thompson wrote:
> > On Mon, Aug 07, 2023 at 11:28:52AM +0100, Mark Rutland wrote:
> > > On Thu, Jun 01, 2023 at 02:31:51PM -0700, Douglas Anderson wrote:
> > > > From: Sumit Garg <sumit.garg@linaro.org>
> > > >
> > > > Let's use the debug IPI for rounding up CPUs in kgdb. When the debug
> > > > IPI is backed by an NMI (or pseudo NMI) then this will let us debug
> > > > even hard locked CPUs. When the debug IPI isn't backed by an NMI then
> > > > this won't really have any huge benefit but it will still work.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > > Changes in v9:
> > > > - Remove fallback for when debug IPI isn't available.
> > > > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> > > >
> > > >  arch/arm64/kernel/ipi_debug.c |  5 +++++
> > > >  arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
> > > >  2 files changed, 19 insertions(+)
> > >
> > > This looks fine to me, but I'd feel a bit happier if we had separate SGIs for
> > > the backtrace and the KGDB callback as they're logically unrelated.
> >
> > I've no objections to seperate SGIs (if one can be found) but I'm curious
> > what benefit emerges from giving them seperate IPIs.
>
> Mostly an "I'd feel happier"; they're logically unrelated and having them
> separate avoids the risk of them unintentionally getting in the way of the
> other.
>
> > Both interfaces are already designed to share and NMI-like IPI nicely
> > (and IIUC they must share one on x86), neither is performance
> > critical[1] and the content of /proc/interrupts for the IPI is seldom
> > going to be of much interest.
>
> Sure; I understand that. The flip side of "neither is performance critical" is
> that they're seldom tested in terms of interaction with one another, and hence
> for robustness I'd prefer they're separate.

We can't really stop them interacting when kdb is enabled: both activate
special logic to intercept console messages and this is much more
complex than the "is this my IPI?" tests.


> I agree it's not strictly necessary, but given we can easily free up an SGI
> slot, I think it'd be worthwhile. We can always decide to fold them together in
> future if we have to.

Agreed.

It should be very little bother to "reclaim" an IPI from the diagnostics
machinery if that is ever needed. So seperate IPIs is no problem from my
point of view.


Daniel.
