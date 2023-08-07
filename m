Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB36772922
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHGP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjHGP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:27:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507AA1980
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7cRgz4y4UNjYdJkJx9xCOww5SjVBcnlVxBW3449Tu/s=; b=SQBe4ik5EZj5PnSBGnEHe73Ch+
        AitjglaNlvx5VJOcJyldY9PzTpbCWI1Ie4vUBUF5mIt7vwaRsyLSSWUCokPsjcOSpegW8fc9zyt3s
        rWfJqNMH2VANk8ptl5T5c9jm/PKZpodYE25dNBq7PSFDjcVnn0WcoTd2XYZeN77vvWHzfXFihPm/e
        NsuXrgZNuya4dF0yF0c4B/FSSHJPrOyThy7bK/pFSah6EzZ9nyJ5pEJ3P1YKEAArs6imRkUfC0fxL
        phs/7AEqVS17viZ1k7goL8Xnv/qXu+or9ZPa/9x9PTyXBwnk+tdbgOBs7ntpZqJPX2loF7DyVouZS
        r3K4EltQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qT28R-00BrKo-2N; Mon, 07 Aug 2023 15:27:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AE2D30014A;
        Mon,  7 Aug 2023 17:27:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A41720299019; Mon,  7 Aug 2023 17:27:06 +0200 (CEST)
Date:   Mon, 7 Aug 2023 17:27:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 25/53] x86/acpi: Use new APIC registration functions
Message-ID: <20230807152706.GC569857@hirez.programming.kicks-ass.net>
References: <20230807130108.853357011@linutronix.de>
 <20230807135027.744726431@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807135027.744726431@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 03:53:12PM +0200, Thomas Gleixner wrote:
> +static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)

just stating on the record what I said during review last week: whoever
caused these APIC and ACPI names to go together was a sadist.

Same 4 letters but permuted differently :-/ this is so very hard to keep
straight.
