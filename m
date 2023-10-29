Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF567DAD85
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjJ2RdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2RdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:33:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746CAC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:33:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698600798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJlX6iTgddsSs48S6F5ORRxnCz8wkuh8YCy/0tpW4Aw=;
        b=SHx+UJzs82DuqD2OG2lmPOr6Jlg5kNAMKK6nTvJ3KyVdm1IcPzpQamMm8mHl+TqRRpR5p7
        7eseFp+BDNbsUHL8AvVLrXviy/u+fHho0KJxsm50eaFG8nV//igioU4B7S72nvwsucx0xD
        V5ROuI2sSmXggLBCyUvw0xidup+/z3x8ZhumzkpFboFLuG5oP8f8bJ1zRSWcQkLEpzXa74
        BkH5nzpDRhdGXS9LPbthREc4WakHoXC2pwsVwUyNbqNAwj67xIwjSffuPYOqXIv0OVpe2R
        qyMgs92DYY5zXWIS6f6xq645JsS98fO+DOjlb4bpVHSPZSw7biXzmmlcYVVxig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698600798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJlX6iTgddsSs48S6F5ORRxnCz8wkuh8YCy/0tpW4Aw=;
        b=1clZw2E3i212BYI5PAx65/Buq7wGOYnphEG9U7g7HJ10STuCLsxSDt2Q/SkNJvLLnpqZk/
        1oy57CuQaGtbUvDA==
To:     David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
In-Reply-To: <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
 <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
Date:   Sun, 29 Oct 2023 18:33:18 +0100
Message-ID: <87o7ghz63l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28 2023 at 20:24, David Woodhouse wrote:
> @@ -24,12 +24,16 @@
>    extern void lockdep_hardirqs_on_prepare(void);
>    extern void lockdep_hardirqs_on(unsigned long ip);
>    extern void lockdep_hardirqs_off(unsigned long ip);
> +  extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
> +				       struct task_struct *idle);

Lacks a forward declaration of 'struct task_struct'

