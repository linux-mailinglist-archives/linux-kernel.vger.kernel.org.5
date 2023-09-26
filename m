Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5B7AF057
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjIZQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIZQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:11:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B8EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:11:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695744689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0JlHzT+UyuDZfIaljaX+5n1d4OtnV3M3qFQqBCB2to=;
        b=fy5bfUPz+Wi9/i+1RM1Eh1285OnunQYqTsZ1BBgz3avvUOAnbYtzRqwcr6aZJ4osVXSZPK
        QBKS5cXCg+tBwLQmjAlet/Q+RIeqUa0iz7Bez3zQdum3LWqWlF9DT0sNLEFO7/TtXfAEB0
        NbvyrGgmlHzMZeTQFCz1rUbI3g2F+YbcRye43PhXE5dVbR+x38C09SWi+yFQqi2YmXQZeC
        xDL2HcAgL93npvpVcNhSyuUK7AZVf2qso+9bKPFa/ayVViubWo0MJskd4v4fMIyGkW33pb
        ETO9N9R3VkNie4w05mqUNa3jSYhy6CMiMxnTwRJ2n5kO+pqJpsNPS/Aw3Ga30g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695744689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0JlHzT+UyuDZfIaljaX+5n1d4OtnV3M3qFQqBCB2to=;
        b=IHrIvV1+oKkfoTE6tlKr3NfGoTjo4HRY/Xq1grnmvKzTosJ9xqnjy6tZwlQOj0y9Fo+jFT
        MsAaT8Zk1251aGCg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 20/30] x86/microcode: Sanitize __wait_for_cpus()
In-Reply-To: <20230922162429.GKZQ2/vfYY21ty5bqR@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.022650614@linutronix.de>
 <20230922162429.GKZQ2/vfYY21ty5bqR@fat_crate.local>
Date:   Tue, 26 Sep 2023 10:51:33 +0200
Message-ID: <87wmwdfhbe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22 2023 at 18:24, Borislav Petkov wrote:

> On Tue, Sep 12, 2023 at 09:58:15AM +0200, Thomas Gleixner wrote:
>> +	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
>> +		if (!atomic_read(cnt))
>> +			return true;
>
> <---- newline here.
>
>> +		udelay(1);
>
> And here.
>
> Otherwise it looks too crammed.

Oh well.

>> +		if (!(timeout % 1000))
>
> MSEC_PER_SEC - no naked numbers pls.

MSEC_PER_SEC? Thats really wrong because timeout counts in microseconds,
no? So USEC_PER_MSEC.

>> +			touch_nmi_watchdog();
>>  	}
>> -	return 0;
>> +	/* Prevent the late comers to make progress and let them time out */
>
> s/to make progress/from making progress/
>
> Nice, otherwise.
