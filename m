Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D57762C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjHIOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjHIOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:43:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84661FD8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=73aBrZ2cwpTPn0y5vTSDrLaA2V0HA9U842JvtXUElG0=; b=jayMhCdqdzMh/1otSPgVxEVnnf
        CYFMuQlc+KTSf8+zE3cBV7OIE72tUCjtQ5RZQ3kLPDizS6Zl9Ryp+h02vc+V+XEOhF9osZPYjBAjI
        y5VD+ssb959g7suPLONIXc5UcSqY78V/oaEvrhsi6AUCfDbcWqvKH8K1v4W/KriQOBwatyOixR3nZ
        snNi6u2vqdp5bLQdqisl/jSzp/GlQ39p3yXyHMSiYl5Cj605Z+7Y63TDv2CLhgCxexNys2X/2j9k3
        pEW9pGWrmVCeLjNdccPHjJWTG4lKi41hY9rgrBg/dyLU+qrVuXSXsxQhK7c3zNwKjUYbardD1xQF6
        LhfmNSJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTkPQ-006lbK-Hc; Wed, 09 Aug 2023 14:43:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CE3F30003A;
        Wed,  9 Aug 2023 16:43:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D9112028F056; Wed,  9 Aug 2023 16:43:36 +0200 (CEST)
Date:   Wed, 9 Aug 2023 16:43:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 11/17] x86/cpu: Remove all SRSO interface nonsense
Message-ID: <20230809144335.GR212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.192502969@infradead.org>
 <20230809140530.bijq3asl26d2pu7u@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809140530.bijq3asl26d2pu7u@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:05:30AM -0400, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 09:12:29AM +0200, Peter Zijlstra wrote:
> > @@ -2607,26 +2447,26 @@ static ssize_t srbds_show_state(char *bu
> >  static ssize_t retbleed_show_state(char *buf)
> >  {
> >  	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
> > +	    retbleed_mitigation == RETBLEED_MITIGATION_UNRET_SRSO ||
> > +	    retbleed_mitigation == RETBLEED_MITIGATION_UNRET_SRSO_ALIAS ||
> >  	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
> 
> These retbleed_show_state() changes probably belong in that other patch
> which adds the retbleed= cmdline options.

Ah yes, lost hunk that. Let me move it there.

> > +
> >  		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
> >  		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> >  			return sysfs_emit(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
> >  
> > -		return sysfs_emit(buf, "%s; SMT %s\n", retbleed_strings[retbleed_mitigation],
> > +		return sysfs_emit(buf, "%s; SMT %s%s\n", retbleed_strings[retbleed_mitigation],
> >  				  !sched_smt_active() ? "disabled" :
> >  				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> >  				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
> > -				  "enabled with STIBP protection" : "vulnerable");
> > -	}
> > +				  "enabled with STIBP protection" : "vulnerable",
> > +				  cpu_has_ibpb_brtype_microcode() ? "" : ", no SRSO microcode");
> 
> Hm?  What does missing microcode have to do with SMT?

semi-colon then, instead of comma ?
