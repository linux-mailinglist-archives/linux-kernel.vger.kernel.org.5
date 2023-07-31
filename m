Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46087696C0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGaMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGaMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:50:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA90DB8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:50:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690807807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkGvdOI2kct1CFJlcjLcLX0x3m4VxYwGOMwYMRRKML0=;
        b=MSiAQhLjV7dYGf+ex9yAJNh+x2kWqhJy5CHN/Ho3GmBrukYvgYCYMnoxvfqTn1FsShSume
        3Pj26PB24axJtLZOz7BLm++o8s9XIfJ+DfCooPA0F9wILYWMtUXtUad8DJS0np0fcaLgRH
        mhg5Z+Lb/7/U+jTY2CotsdXVRCfvqu66I/fpD4/CCOYZXvqBpxnzO1HsFhb03yeIlQAg0j
        1sE1Y4nBrtxpKsA6QMAYVMTZYJ1YDmu3iiKYcnz4fgEhgdBhf8gy2d6SV1CAMTle4y1DAj
        Hv5eITgDOmJwl/TYjiP76Kw02wNtrLgBgwAtkI1Vu94V70RvOLYkkOzhraFyqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690807807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkGvdOI2kct1CFJlcjLcLX0x3m4VxYwGOMwYMRRKML0=;
        b=PU0DlnO1rUbQs/958k+z7sA4y8Xe8x+3WAGOZxmh54GMcQFMrao6N/kfJ4u8PnYOpdKrGf
        /NwDESS0RvEZn0Aw==
To:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
In-Reply-To: <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com>
References: <20230724131206.500814398@linutronix.de>
 <20230724132045.555787669@linutronix.de>
 <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com>
Date:   Mon, 31 Jul 2023 14:50:07 +0200
Message-ID: <87y1iwnt34.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31 2023 at 12:17, Juergen Gross wrote:
> On 24.07.23 15:34, Thomas Gleixner wrote:
> This is introducing a regression for Xen PV guests: those have no ACPI
> tables, so smp_found_config will be 0. OTOH num_processors has been set
> already using hypervisor data, so setting num_processors to 1 here will
> overwrite the previous setting.
>
> Below diff on top is fixing the problem:

Fixing? You can't be serious about that.

Why can't XENPV pretend that it has a smp configuration detected,
i.e. setting smp_found_config as any other special get_smp_config()
implementation does?

XENPV is already a major pain to deal with. No need to expand the
related insanity all over the place.

Thanks,

        tglx


