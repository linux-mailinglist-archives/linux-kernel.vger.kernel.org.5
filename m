Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F187E5BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjKHQ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:57:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6051FF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=35zz3oaC91rkzRiAUrt+HIVdUt7lDfuhbKttZJT5BXE=; b=iCRu/Z0zqhemawD3JWB3WeQc+d
        hN/ghnUAh47hQyEVZ0pxykyeNooBxiy+seDezHlNog9AwrdyGGjfAEQCGxvvdO7F9ZLLdnU8JumA6
        xIVXbsak3TAwCPCI1MaHhLOOLFaAlZamWSPLt3Z3dsKrV1zfpzZ8EaWY5QrZ3PpHaOjmqZuZjxj+d
        ZZiUXtzPeXWUcMaoAABNot9pvZo9JgRTgnv3Z6MluTnRD1uVwl/B5mXuMgRajr8+LfsBjswnJEZM0
        qQd2KFH8lcybPq6O9CIRjBbUsds/OrfkEOj46qjarvYonl8TebwLWetokRwcP3Q381tXCTzs6HfUI
        VT3fFbCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0lrh-00DdMB-2t;
        Wed, 08 Nov 2023 16:57:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D6BA30049D; Wed,  8 Nov 2023 17:57:17 +0100 (CET)
Date:   Wed, 8 Nov 2023 17:57:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231108165717.GM3818@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
 <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
 <ZUulyj7tXnZzv5V6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUulyj7tXnZzv5V6@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:14:18PM +0100, Juri Lelli wrote:
> > +	if (dl_se->zerolax && dl_se->runtime > dl_runtime)
> > +		dl_se->runtime = dl_runtime;
> > +
> 
> Anyway, I have the impression that this breaks EDF/CBS, as we are letting
> the dl_server run with full dl_runtime w/o postponing the period
> (essentially an u = 1 reservation until runtime is depleted).

Yeah, I sorted it with Daniel, we were not trying to fix the same
problem :-)
