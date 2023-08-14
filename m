Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6663F77B18F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjHNG12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjHNG1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:27:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60211E4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:27:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691994419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IvzIn0pNRc5Djnvzs+gpxlTdN4qBZz4rtDezbbyN0U=;
        b=x4QwarwYTSGvYUHYGJiZ3oF6ot4ZWtZloQ50uAgdH8y/2mWslQ9hDG2/JoBDH4ZlybGo7A
        K/sRtSFYRkIMMn3dW/fvxBcPTt4gtLtetDzWvDzRWdPoMbYdBLMdC4AYHKw7shubHsEWOo
        9RdkW6IO37l6/P8Fahi+xpM7Aj9bLmiN1EZDgIHhMGmciAcFpHuNc+iE2wXgScST9EFYjB
        G4xd1j5/IBk5W6o3W8A2gTYFLd4JIq0GqWpE+PSeCM2C1g9BzGVMVtv1Fs8/iJk9rmjc52
        MDbkv8fZjZoQc0qeX1s39x3mvPNz289LYb3TTFC+enGjB7o+IDgi4ktbkAqA7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691994419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IvzIn0pNRc5Djnvzs+gpxlTdN4qBZz4rtDezbbyN0U=;
        b=ec5mxwjXXFWTuFJMSHfi7byVO7v3QXK0IywTBc4QX3TfJTWZnT91enIqNkQFgLQ5QKXd9S
        Nhuf7phyWjXl1BBA==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <0331cd3b00ef6afc5f039f0343f010227ed18fa8.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.026097251@linutronix.de>
 <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
 <0331cd3b00ef6afc5f039f0343f010227ed18fa8.camel@intel.com>
Date:   Mon, 14 Aug 2023 08:26:58 +0200
Message-ID: <87o7jaf8b1.ffs@tglx>
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

On Sat, Aug 12 2023 at 08:00, Rui Zhang wrote:
> On Sat, 2023-08-12 at 14:38 +0800, Zhang Rui wrote:
> BTW, can we consider using system wide unique core_id instead?
>
> There are a couple of advantages by using this.
> CC Len, who can provide detailed justifications for this.

I have no problem with that. But as I said before we need a discussion
about the ID representation in general so it becomes a consistent view
at all levels.

The other thing to think about is whether we really need all these IDs
explicitly stored in cpu_info::topo... The vast majority of usage sites
is in some slow path (setup, cpu hotplug, proc, sysfs ...).

Thanks,

        tglx
