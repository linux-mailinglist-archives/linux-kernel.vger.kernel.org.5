Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7067A9BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjIUTEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjIUTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790405AAA8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:50:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695280434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YvLEhWqpp10DHQybiMtOstRD38rvF1Ru/Oh6BvcZMo=;
        b=Y3Bqy2zLhdU6TwfJW0h8nIvZPZeS1ke61eAinG1mPar+gYmpfVOKo71bU7LNyjPVSloj8p
        zpAfnuswyWFQIN9ytSgNHVXiIQ9LDp5Ln8kfDaEseyzpvkJxDaoR81/gkSGcb3v/wGPrMS
        RkeZsT/tFOfCgc82Me+sigei5ltY/+MdliGElpRWyPpbgL8F3ao6pxFD6ZdzzC14kDWSF4
        RlMYgWByuQTQFUBWnJCySHfG8WopCdJieSoZRRCQNgOk4XRTT/PnMzeRIyil1Xm9DEj0xT
        yAdVA1vKOBrAIIEP4+YuMIOGpvm0F8ooXss/z6KiEYWmBFC4OufldIjXdsHF9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695280434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YvLEhWqpp10DHQybiMtOstRD38rvF1Ru/Oh6BvcZMo=;
        b=Q9Dl4IIBPIEbU6p64zQsM7T0ZXaoSGW7kshpj0lcgUEYZKzVSE7OU4CgqHJ9ci4gvPg/RM
        u1+upMriXhYrOmAQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH printk v1] printk: fix illegal pbufs access for
 !CONFIG_PRINTK
In-Reply-To: <20230921021859.GA14418@google.com>
References: <20230920155238.670439-1-john.ogness@linutronix.de>
 <20230921021859.GA14418@google.com>
Date:   Thu, 21 Sep 2023 09:19:44 +0206
Message-ID: <87led0f17b.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> I wonder if anyone really use !PRINTK kernels. Can we get rid
> of CONFIG_PRINTK?

It is used. It is one of the big annoyances during the last several
years of the rework. I get bug reports relatively quickly after breaking
!CONFIG_PRINTK. The reports come mostly from the kbuild robots, but also
from real people.

If someone has limited space/memory requirements and does not care about
dmesg, they can save a considerable amount of kernel size and memory by
turning all that off. The problem right now is that !CONFIG_PRINTNK is
horribly hacked together with dummy implementations and useless real
functions that pretend to do stuff.

After the rework we can work on splitting out the code based on
functionality. If done right, it will be trivial to "implement"
!CONFIG_PRINTK in such a way that changes to real code don't explode
every time on !CONFIG_PRINTK.

John
