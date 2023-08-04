Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8C770944
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjHDUB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHDUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:01:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACEBE6E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:01:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691179311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPXpbtrhmH9JrEPxLdyGNLudKN3Xs+LoeQQ9ZLOqY3Y=;
        b=H6x1rRrQr27fb4VS69LDcDUE1yw5vv/gizP94LVMUpyHZT1tIruUpgm/v/jSUlr4v4Dez5
        k4SAuQ+H0fyQE4kL8G4YeNPfkwxENKHqNG7p4peHfIvwN0UAOpwvf9ZF3F4qobh2PhbL6N
        oD7LCiJDQEdnrKHXOMRx0vkNaBD33AFWE5B8y5fg2lKEhnP+mPUxlO4Sr0MEBhtRnI+Hf3
        L0/GWgIjVWp2yh1q3IzqfpFVdFZljtBqnefuvUlr2cLKf4BuFxQ6YG62eHzO8TF8qDhGhb
        KubhhVvMdbDKmgwYCSZtAGMis6ii8hU+2Eqf/yf+PRwbe/c5iL80ueVtfBxOCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691179311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPXpbtrhmH9JrEPxLdyGNLudKN3Xs+LoeQQ9ZLOqY3Y=;
        b=KFT0Q7c001P/51w4HKqpLOqj2J7Oy1ZFH0bT1axyqiIwCV6U7h01umbaoiEvnufO/QAq+T
        uvi48o1P6XHOrtAg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V3 01/40] cpu/SMT: Make SMT control more robust against
 enumeration failures
In-Reply-To: <20230804175051.GKZM06e6VTtAYwTRWO@fat_crate.local>
References: <20230802101635.459108805@linutronix.de>
 <20230802101932.758513086@linutronix.de>
 <20230804175051.GKZM06e6VTtAYwTRWO@fat_crate.local>
Date:   Fri, 04 Aug 2023 22:01:50 +0200
Message-ID: <87tttemv9t.ffs@tglx>
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

On Fri, Aug 04 2023 at 19:50, Borislav Petkov wrote:
> On Wed, Aug 02, 2023 at 12:20:59PM +0200, Thomas Gleixner wrote:
>>  kernel/cpu.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -630,6 +630,12 @@ static inline bool cpu_smt_allowed(unsig
>
> As discussed on IRC, the name and what the function does is kinda
> conflicting.
>
> What it actually queries is whether the CPU can be booted. So something
> like this ontop I guess:

No objections from my side.
