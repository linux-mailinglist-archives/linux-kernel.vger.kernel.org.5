Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870A80EDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346518AbjLLNg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjLLNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:36:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E5F83
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:37:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA27DC433C9;
        Tue, 12 Dec 2023 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702388224;
        bh=An6pJpMuiYlfSi/g1KRM/yinCkpjxYiXnMPBeXwAN0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAq56hNCUV6DkM14vBoeoLgWhBIxTOhtKi3S9BimwOkCB/1hXMzll/BrxD1PES5jx
         IidMgrFPaeLRXfwFye4rcot9E6XcY3YcU4dxBG43E8PzXkPCD13I5COD+VhtDWDKD/
         0QNvAEJLf1sNjtJyoxqwCsT6OvZ8IKxYvkXqJ3LEW9gXrcP7r276j9PPp/cq/7uQAJ
         dLY+MT2Q/LHMCV+OXquotuZj8FCTIUarGkXqoAKH6Rm6XUnco1GXFwb/qcyekmvXXG
         WlBwVyl2ZZkDmkW6JQoWnrBxtWAwi+uVwhtN3WgkuIxu+wosyMBTd2weJMPEPR+Cbf
         uRYmUCR58/5pA==
Date:   Tue, 12 Dec 2023 14:37:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 12/32] timers: Fix nextevt calculation when no timers
 are pending
Message-ID: <ZXhh/RwjhvrBJsaV@lothringen>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-13-anna-maria@linutronix.de>
 <20231204160350.OTCnqCJf@linutronix.de>
 <87zfyodfxc.fsf@somnus>
 <ZXUHu6Xqdg8NNcPC@localhost.localdomain>
 <875y13mu96.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875y13mu96.fsf@somnus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 02:21:25PM +0100, Anna-Maria Behnsen wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Tue, Dec 05, 2023 at 12:53:03PM +0100, Anna-Maria Behnsen a écrit :
> >> 
> >> Frederic, what do you think?
> >
> > So it looks like is_idle must be fixed.
> >
> > As for the timer softirq, ->next_expiry is already unreliable because when
> > a timer is removed, ->next_expiry is not updated (even though that removed
> > timer might have been the earliest). So ->next_expiry can already carry a
> > "too early" value. The only constraint is that ->next_expiry can't be later
> > than the first timer.
> >
> > So I'd rather put a comment somewhere about the fact that wrapping is expected
> > to behave ok. But it's your call.
> 
> Ok. If both solutions are fine, I would like to take the solution with
> updating the next_expiry values for empty bases. It will make the
> compare of expiry values of global and local timer base easier in one of
> the patches later on.

Fine by me at least!

Thanks.

> Thanks,
> 
> 	Anna-Maria
> 
