Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7087CD01D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjJQW6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQW6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:58:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3CF5;
        Tue, 17 Oct 2023 15:58:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697583511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdZPuGSCC5ReGFJbpE1tiWuYcnCkbV9JUfUkQs1rP2Y=;
        b=0JaUjDhMYoXIReATQWNs+OaA1PS0s6HsNl7AsfozWlA6MHoUvzvUB41Ro/4sepQIGD7upU
        YEdOdlaDOdKRW6anMDQFr5yXbTtF6nnOZA72tg5k4ZRYtKEfPbbxRWbZ5pUF4DAcF6mlZ6
        oudW2yBOrVSZGOQGBeqyokpTCbl5Z9fW4q+au81lTxXngqAHCp8C8/ofFih49z5lBxnxgP
        u7I/v9ATam2793mZzBwrry0xYT5YpoP70Wl0j54oYkFwUFU5R6vOLc9Bxr6nxDoZ+UGPxx
        7YoxuTK6CZIl9TdWUcB5jYBxPKSiu1IFrBvzJNRfivsRkEw9VCBb/YEgrlvnFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697583511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdZPuGSCC5ReGFJbpE1tiWuYcnCkbV9JUfUkQs1rP2Y=;
        b=KzfN8CoG4cgw4K4aqgJTEEcODPewhj3JbvVD7JlLNzJZb4sVYG6/zZoklarGWFI8Z7nekl
        QiOmj+tFTDF80bDg==
To:     lakshmi.sowjanya.d@intel.com, jstultz@google.com,
        giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
        lakshmi.sowjanya.d@intel.com,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
In-Reply-To: <87lec15i4b.ffs@tglx>
References: <87lec15i4b.ffs@tglx>
Date:   Wed, 18 Oct 2023 00:58:31 +0200
Message-ID: <87y1g05014.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17 2023 at 18:27, Thomas Gleixner wrote:
> static bool pps_arm_next_pulse(struct pps_tio *tio, ktime_t expires)
> {
> 	u64 art;
>
> 	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art))
>         	return false;
>
> 	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
>         return true;
> }
>
> ktime_real_to_base_clock() does not exist, but that's the function you
> really want to have.

It just occured to me that CLOCK_REALTIME might not really the best
clock to base this on.

It's obvious why this can't be based on CLOCK_MONOTONIC, but I rather
would base this on CLOCK_TAI which at least does not have the issue of
leap seconds and the related nightmares.

Thanks,

        tglx
