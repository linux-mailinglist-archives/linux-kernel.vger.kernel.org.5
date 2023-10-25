Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB07D6F66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbjJYOfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjJYOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:35:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA593
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:35:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698244499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IL2vizYkgm1HX9W3iY0AU8VNNkv8/SkAdPvfQ1pfPu0=;
        b=i0pKp5+5FEkEe/VwI0Z421J3DGu626aVdBzSYeCsvtoj8fjzeU9/8nK925TfVCAoZvoyVl
        QGy1pcSCj+T+yqjHyxRjZUZC4U84xX55peapgs8hVo13JSWl+tHfKiV7qSnt8KbmrZmEp2
        3Bgs6afQD9IQrbvpmPkRiIdJXSqEVUWjva7He/BtZgDqgo9OgA0ZqPGFIGInT12K9r3dhU
        9Vu8+pXdd/hs6OcNrVwimAUQNr4PnU7Lek5FGDTct4wZYATiir69Mcs3rTZI5kSV/gLGpp
        9pkqDClRkPUlxcK4hvjvMa9wzLdRy1IyYVmBhYir/UEBQo99WrOeL5nhh/Zfeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698244499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IL2vizYkgm1HX9W3iY0AU8VNNkv8/SkAdPvfQ1pfPu0=;
        b=Yi8GYqSnoj45lkaUi/hlEByCJahwXEXb81xJDuLK7QJZSNLQdI+Ui4w6eRBTUN2Mbp+Ia2
        jS2K9EKBz+Hlt6Aw==
To:     Chen Yu <yu.c.chen@intel.com>, Juergen Gross <jgross@suse.com>
Cc:     Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: Re: [RFC PATCH] genirq: Exclude managed irq during irq migration
In-Reply-To: <20231020072522.557846-1-yu.c.chen@intel.com>
References: <20231020072522.557846-1-yu.c.chen@intel.com>
Date:   Wed, 25 Oct 2023 16:34:59 +0200
Message-ID: <87v8au6a98.ffs@tglx>
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

Chen!

On Fri, Oct 20 2023 at 15:25, Chen Yu wrote:
> The managed IRQ will be shutdown and not be migrated to

Please write out interrupts in change logs, this is not twitter.

> other CPUs during CPU offline. Later when the CPU is online,
> the managed IRQ will be re-enabled on this CPU. The managed
> IRQ can be used to reduce the IRQ migration during CPU hotplug.
>
> Before putting the CPU offline, the number of the already allocated
> IRQs on this offlining CPU will be compared to the total number

The usage of IRQs and vectors is slightly confusing all over the
place.

> of available IRQ vectors on the remaining online CPUs. If there is
> not enough slot for these IRQs to be migrated to, the CPU offline
> will be terminated. However, currently the code treats the managed
> IRQ as migratable, which is not true, and brings false negative
> during CPU hotplug and hibernation stress test.

Your assumption that managed interrupts cannot be migrated is only
correct when the managed interrupts affinity mask has exactly one online
target CPU. Otherwise the interrupt is migrated to one of the other
online CPUs in the affinity mask.

Though that does not affect the migrateability calculation because in
case that a managed interrupt has an affinity mask with more than one
target CPU set, the vectors on the currently not targeted CPUs are
already reserved and accounted for in matrix->global_available. IOW,
migrateability for such managed interrupts is already guaranteed.

I'll amend the changelog to make this clear.

Thanks,

        tglx
