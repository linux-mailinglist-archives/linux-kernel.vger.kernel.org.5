Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFEF763FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGZThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGZThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:37:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1454D19BF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:37:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690400237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJzZzid0M6tqJXFCxxcxkARxu6y0Ijf8cxu9iI9KQ6g=;
        b=pFucqBTAkwxYGMvtmtdOynvU/sgwqsMEY/NCqMI7pzd4Sll3GfQhG5sTvZNft3McxA0C+2
        3a4ANeVftSU9s8TunGzlq+2BUtMrlE3Jhs5QzshC83AP2Q3tKPaGbgRwOYehBNRUbkPV6c
        tlJZmPhRRCXqB8dJVhvHO82yGE1PjWatywNxeDWxXUuIjbEQrc3AyHMfdis6We0+qLrACC
        ydBpEOmcuOiaQqXByf2IXpBjdm2HD9cj40OJUJ4ZFpgn506wI7jznhqeyYb2prKlWo6d4f
        FfrLW2A9FNiLRuU677C1GqH8y/0nYJUhXwbOwQ95EEHU2H6K6i5sBaLWZifOqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690400237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJzZzid0M6tqJXFCxxcxkARxu6y0Ijf8cxu9iI9KQ6g=;
        b=+wg/aTKN084r/ajc1hY4RJat7h7CPzgmGWYbzcrUrh02U3vFZmz6TafpsVkCiKINykuZAu
        vjHOW3AS85+jUeCQ==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
In-Reply-To: <ZLVEVoZTbYi3LbjK@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx> <87h6qz7et0.ffs@tglx> <87edm36qqb.ffs@tglx>
 <ZJW0gi5oQQbxf8Df@feng-clx> <ZJhUiO+bdBoLU5WF@feng-clx>
 <87r0px40o5.ffs@tglx> <ZJ2Grrn7sq9Jdxf6@feng-clx>
 <ZLVEVoZTbYi3LbjK@feng-clx>
Date:   Wed, 26 Jul 2023 21:37:17 +0200
Message-ID: <87pm4esbv6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17 2023 at 21:38, Feng Tang wrote:
> On Thu, Jun 29, 2023 at 09:27:10PM +0800, Feng Tang wrote:
>
> I plan to put these together and resend. Can I use your Signed-off-by
> for your code?  

No. I'm reworking the topology code at large scale and this temporary
hack is just in the way. Give me a couple of days to polish it up for
posting. That will just provide the correct information out of the box.

Thanks,

        tglx
