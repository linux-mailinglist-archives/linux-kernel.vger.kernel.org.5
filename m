Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DC808764
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjLGMLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjLGMLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:11:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA34CCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:11:10 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701951068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9U+J2PYz5K8VTk4xKojeBZbrIzbmQ95qisG94Y4Oss=;
        b=fUfIFYYAG7SnDMXX9+bax9S3Lc9+oebi956c9zyuAuZA2ztzu0uTrY5NVYWClH6v+P/4tA
        rUkCWLXm5TLk7onlWYZUN/Nw5xYTaiL+xUpsyA2Ffl7keb3UNDo23CXup9tIFRGiOiWCEI
        WbYUl0IIGT3Lm/oKDG0cQWdMs6sxwAFhfm1+Gev20Px5pBAg/PxWcEj4o3TyzQA0pI2qP4
        Sb2SetUhgjhxmb2Jq6QJT/ZBFCd18e3/2zcnAUd8b2RmBvKQliusr6qxMVB8HKppNDcEi2
        pWkAQC/3S6/pQ0HlguhpqQbVhNy6s3jLgzJ77QGTIuI8vpowk52Dd/ebAXvNgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701951068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9U+J2PYz5K8VTk4xKojeBZbrIzbmQ95qisG94Y4Oss=;
        b=R4XR6dPyiamxYE0hnqAy31lXtiaRRzSFy/7v8JyJUhIVtZr3LQPV1UZoLmTwJmnoysPxTo
        TPcgSF2Vc91Yo9Dg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 00/32] timers: Move from a push remote at enqueue to
 a pull at expiry model
In-Reply-To: <20231201092654.34614-1-anna-maria@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
Date:   Thu, 07 Dec 2023 13:11:07 +0100
Message-ID: <878r668b6s.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

> Hi,
>
> the queue grew because of some additional cleanup patches and splitting
> already existing patches to make review easier. Several minor things had to
> be reworked. For all people who did testing, I would be really happy if you
> could test v9 as well!

bigeasy triggered a warning during boot. So I'll go and fix it and will
send a v10 when I'm done.

Thanks,

	Anna-Maria
