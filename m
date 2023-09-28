Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBB7B176A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjI1JdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjI1JdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:33:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2471F193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:33:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695893587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wd8aJJ+FVS2AFo91cxTfRED5C3m/5EgOiSBFs0laTDg=;
        b=EctqP9dCH2FukRed5W57aJs4FAaULC5DWw8BssNOTqPoOuP75otWkT6e/4S66YzFqaotbi
        eFGMwk/iEVmk68VV2U+rHDHajQ8LrokV6dWuG0Crs9RIOFo0CAI/JKNljJFXyBQU1zBEmY
        zQ1sIJf1cMFIC71FY1CaHV69ZMvxZ3ITDsCqNgVqS89ahFZnpbWDuBzonLRfKsZlh6zQWT
        8PbzG4vysIEDFKVNi6oUjkr7PRjeqoNFSMi7Ev8PwesRM0N0/wHgUwf1RemopIUlfdrKLA
        hwp7S7wNpRYcZkbvJqheFbsMyRSEugk7+ekhexj23ibT0hfI31mFdiSzsh3OQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695893587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wd8aJJ+FVS2AFo91cxTfRED5C3m/5EgOiSBFs0laTDg=;
        b=8NoTJO5OW8iDSHv4+miGa3YQtsLMGx4tetVHix61HXTiL+KusDwibcoOfVe5Qa7rBmvXLs
        NitgwLSTZA5sQXAw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 25/30] x86/microcode: Rendezvous and load in NMI
In-Reply-To: <20230927171713.GBZRRjmUDQrV9HVxv-@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.327149876@linutronix.de>
 <20230927171713.GBZRRjmUDQrV9HVxv-@fat_crate.local>
Date:   Thu, 28 Sep 2023 11:33:07 +0200
Message-ID: <878r8qfxrg.ffs@tglx>
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

On Wed, Sep 27 2023 at 19:17, Borislav Petkov wrote:
> On Tue, Sep 12, 2023 at 09:58:23AM +0200, Thomas Gleixner wrote:
>>  
>> -	/* No point to wait here. The CPUs will all wait in stop_machine(). */
>> +	touch_nmi_watchdog();
>
> AFAICT, you're touching the NMI watchdog even in the !use_nmi case.

Yes, we need that also for the non-NMI case because this runs in
stop-machine.
