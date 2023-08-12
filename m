Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5890779DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 09:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjHLHQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 03:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHLHQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 03:16:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87D30D6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 00:16:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691824567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LGyzicZVP07rxfxQyStf44fzHwtf7f58uRuZrtNG8A=;
        b=mwOJIjD6SZ+l0xonXEx++cXUyXafoZ77DXk+lXKX0hijeReQyI9n6oC0Lo8tcmwAVGo+Vz
        NMau8Gp9G+3R4ncj5eFRio5gvBtGmrMEjBjEs/XkPzz+ePEA4K/GrebDjrYQFjCSNvClpH
        NlYsls3JPwl2J4V6IFsNhnsV3TB2NVgyo7IxWyAdpeRgjfqZrn/mL2Hrck5Ek2vOCeIGrS
        VzxA0WbjWsNcgeepwZQp2yPO0dpqL2DHrJPMZ78IQgMXCGO+NHKY7NGYzT9Ec3L5L5XJ/6
        weSh/zs39kDsRZJyDcOByC6kC49WthcrADSnMGiwWEe4Q0Mk3R1cEVK31VoIJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691824567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LGyzicZVP07rxfxQyStf44fzHwtf7f58uRuZrtNG8A=;
        b=kCrkW0ptI16v0gQCzcevWFGVtMKPiPSf1JaqkD7OHId7GQA0ox1DIbffubHQyQHkjPkpDe
        BPuoAQWgVaEJuAAA==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 08/30] x86/microcode/intel: Rip out mixed stepping
 support for Intel CPUs
In-Reply-To: <20230811222500.GOZNa1PIUVJeBDiBGI@fat_crate.local>
References: <20230810153317.850017756@linutronix.de>
 <20230810160805.418991257@linutronix.de>
 <20230811222500.GOZNa1PIUVJeBDiBGI@fat_crate.local>
Date:   Sat, 12 Aug 2023 09:16:07 +0200
Message-ID: <878raghgso.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12 2023 at 00:25, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 08:37:38PM +0200, Thomas Gleixner wrote:
> I'm confused: when you look at those statements when this patch is
> applied, they look like this:
>
>                 /* BSP scan: Check whether there is newer microcode */
>                 if (save && cur_rev >= mc_header->rev)
>                         goto next;

Bah. this clearly must be !save here.

> Uff, this function is ugly and can be simplified. Perhaps that happens
> later.

Yes, it is cleaned up later. I tried it the other way round, but that
didn't really work out.

Thanks,

        tglx


