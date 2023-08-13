Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4C77A73F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjHMPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHMPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:04:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B0E6A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:04:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691939078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67wOu/askamgNgaMWz6ATjabCYrlBnc8iy9pPrPhRdo=;
        b=LuysFXg8c6hn5z/HyX9NbSVhXxREo1k0rcN1T+5U9kWNn1DIS0GEVOH6927u5nTMzvY/QV
        a9Hw8eNg5beK02pP+sKRW2+an5WVBhMC6toRNqjLZ5+/zdKl+ze47z8OUyUy7d3PbYqO4N
        z9t5DZqbLXd/bIWM63CPxoANWKT5pmtbQy4qUc7O4evAwOPeObNwfnbxJoq3Y+Za6ZjMMu
        GmJW3Az/a0Wgk0kMDZu9/gp7tp65IU1qOt6ElSQzcFu3clYv0biJ7OdBY+Ao2Oobh92QTs
        7BUdd5zpRalunEtNiClceEh3P6dPOYw/pfx1Vmxyc7LHXrbI52Vd82Tj+7ibKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691939078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67wOu/askamgNgaMWz6ATjabCYrlBnc8iy9pPrPhRdo=;
        b=vFjSwj+RyWyOIfMIFNHtlga/WqwgJIlxBTvo2edjssPF9NWzlKwQMC+/4hcNNw+6LVXEVC
        3Fqk49Buml2IP3DQ==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <87350ogh7j.ffs@tglx>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx>
Date:   Sun, 13 Aug 2023 17:04:37 +0200
Message-ID: <87ttt3f0fu.ffs@tglx>
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

On Sat, Aug 12 2023 at 22:04, Thomas Gleixner wrote:
> On Sat, Aug 12 2023 at 08:21, Rui Zhang wrote:
>> With this, we can guarantee that all the available topology information
>> are always valid, even when running on future platforms.
>
> I know that it can be made work, but is it worth the extra effort? I
> don't think so.

So I thought more about it. For intermediate levels, i.e. something
which is squeezed between two existing levels, this works by some
definition of works.

I.e. the example where we have UBER_TILE between TILE and DIE, then we'd
set and propagate the UBER_TILE entry into the DIE slot and then
overwrite it again, if there is a DIE entry too.

Where it becomes interesting is when the unknown level is past DIEGRP,
e.g. DIEGRP_CONGLOMORATE then we'd need to overwrite the DIEGRP level,
right?

It can be done, but I don't know whether it buys us much for the purely
theoretical case of new levels added.

Thanks,

        tglx
