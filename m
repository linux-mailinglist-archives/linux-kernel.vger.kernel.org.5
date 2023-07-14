Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08D75447A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGNVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGNVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:55:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9792E1720
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vQdHO54UuV3gCY8gwM/eYu482AppwF9ozeR3rwBl9bY=; b=D00WUEntYpgCbirR9xDyK9AZyR
        4+Lpv/UJsBWtGkKn3l7XPh4prokk0KsmyvUNiGxcfoxwiKMCHQthdrgBjEjxWCBU/vUO5Beh46Dyr
        DbFiTYXUYwBENM/MKIURLAjxdTTl/8a98Qsc7JTLRn7Urm+jqFJFHnXEbPpT49GVS6aiZzvbU4/Lg
        mtgxusJxon3R8jE4aZRkHi4m+GNm5BAr2vQX8IeuaV/QeuLIv+mIu4/+XyAbMHmaL+v1Lw1a5CjS4
        QJlQDO7VCSGPjuo30DY823+NP5wZAGTf5ztfQwRn+FP8XfsbAe+4aZecpo4NqRmRFOpgiy85Z3ilK
        B1OG4hCg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKQlI-006OX1-1j;
        Fri, 14 Jul 2023 21:55:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5103F3001E7;
        Fri, 14 Jul 2023 23:55:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B31621372899; Fri, 14 Jul 2023 23:55:39 +0200 (CEST)
Date:   Fri, 14 Jul 2023 23:55:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bruno Goncalves <bgoncalv@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230714215539.GB3273303@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
 <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
 <20230714211021.GB3275140@hirez.programming.kicks-ass.net>
 <ab419bb9-1065-5200-5b22-32f36b0426a8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab419bb9-1065-5200-5b22-32f36b0426a8@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:45:21PM -0700, Arjan van de Ven wrote:

> for kvm and hyperv. not for vmware etc.

There's no etc. VMware is the only one not having it. Xen, KVM, HyperV
all have it.

Then the right solution is to have them implement it. And again, even IF
this was a sane thing to do, it would not be in intel_idle.

The other solution is to no use VMware.

