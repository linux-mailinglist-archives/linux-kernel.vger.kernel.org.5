Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5E80F23E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346730AbjLLQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjLLQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:17:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B1B139;
        Tue, 12 Dec 2023 08:17:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702397839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=IsSxbOXO8kr3M3mwTOxm60Ib6/Sfb/2lPpnn+xrbANk=;
        b=MgqOdJJFmgzPMEDmG+KroROslkNprpfoHU74xiNAL7cVWSEF9uJx/H6xMOe1hs8M6JcdwV
        aqNSkjoGf1uosmtxiqs2VSeMecva1xF9ohVe1/8AsMuyNKiyOpNY2bIbV7BCRhIcsUquom
        IuKSQNHiskWf9tJxP147+l9C3l1fku1W9pQ632uCK7Iz5C/P5PpY7eEV6ZT0+9Vczshqjo
        hqWGAK4ro8IvWDXKsmwIH5VE7mcy3maKysqP3tTxlFS1d7ZYO9OILS/g02YRkyRQ3FsRal
        ifjF7ZlKESNL62q93CTHut2M1yyEM2Eb1LqeAmTcMfFWfz1uAefeaQ0snpWQpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702397839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=IsSxbOXO8kr3M3mwTOxm60Ib6/Sfb/2lPpnn+xrbANk=;
        b=NeglcHbbPQ8braZWOi4Mx9645ZHZGOKyVZxkWGpxfiHnZ3jr1m1CeS1es7HVy+nQvDXHiB
        BuoFLTTjevqVB+BA==
To:     Andres Freund <andres@anarazel.de>, Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 02/17] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <20231206070423.wp7cxxnwfe3lidm3@awork3.anarazel.de>
Date:   Tue, 12 Dec 2023 17:17:18 +0100
Message-ID: <8734w7qttd.ffs@tglx>
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

On Tue, Dec 05 2023 at 23:04, Andres Freund wrote:
> On 2023-11-22 10:31:31 -0500, Sasha Levin wrote:
>> Currently, the kernel enumerates the possible CPUs by parsing both ACPI
>> MADT Local APIC entries and x2APIC entries. So CPUs with "valid" APIC IDs,
>> even if they have duplicated APIC IDs in Local APIC and x2APIC, are always
>> enumerated.
>
> As just described in
> https://lore.kernel.org/all/20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de/
> and also previously described by John Sperbeck
> https://lore.kernel.org/all/20231122221947.781812-1-jsperbeck@google.com/
>
> this patch causes some machines to "loose" cpus. All but one in my
> case.

Sorry for the delay.

> Even if the commit didn't have these unintended consequences, it seems like a
> commit like this hardly is -stable material?

Shit happens. We are all human, right?
