Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA6B7726D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjHGN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjHGN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:56:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC13A9E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E3CDE21A82;
        Mon,  7 Aug 2023 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691416447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sO+ISmA3blEzydvQ5tSDlYEwVxNgQwIYJuThjSRudg=;
        b=Zz18dUdBnGBh3kyIA8F29HRu7yZrtnmtNDDPKFvgyFYbq6B024R6nrngjQPUr+ma/fJnPs
        BzluzzCOA3IhnaGialPArEZin4oqEFiWNTbOOax3fs32Yu3TKGZGCKE3dYN6NSg4ZVvFa2
        tmqQfUOV3G/c69jhtfwuaSTnjuk51/I=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C203D2C142;
        Mon,  7 Aug 2023 13:54:07 +0000 (UTC)
Date:   Mon, 7 Aug 2023 15:54:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hardlockup: set watchdog_hardlockup_warned to
 true as early as possible
Message-ID: <ZND3fGv3e5C_JP9h@alley>
References: <20230805160144.121875-1-liusong@linux.alibaba.com>
 <20230805101705.3a38ce9aacc924f1c9f0842b@linux-foundation.org>
 <bc4da863-dacb-66a7-133d-0e6e91e4477a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc4da863-dacb-66a7-133d-0e6e91e4477a@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-08-06 10:52:57, Liu Song wrote:
> 
> 在 2023/8/6 01:17, Andrew Morton 写道:
> > When resending, please tell us some more about the effects of the
> > change.  Presumably there are circumstances in which excess output is
> > produced?  If so, describe these circumstances and the observed
> > effects.
> 
> Hi,
> 
> I haven't found duplicate warnings in the real environment.
> 
> However, considering that when system occurs hard lockup is basically
> abnormal, it
> 
> seems more reasonable to set "watchdog_hardlockup_warned" to ture, rather
> than
> 
> waiting for all kinds of information to be printed.

I believe that this is not needed.

watchdog_hardlockup_check(cpu, regs) is called on a CPU periodically.
There are two callers:

   + buddy detector checks the particular CPU when the solflockup's
     hrtimer callback is called. See watchdog_hardlockup_kick()
     in watchdog_timer_fn().

   + perf detector checks the particular CPU from a perf callback,
     see watchdog_overflow_callback().

Neither timer nor perf callbacks might be nested. They are naturally
serialized on a given CPU. So, races are not possible in this case.

Best Regards,
Petr
