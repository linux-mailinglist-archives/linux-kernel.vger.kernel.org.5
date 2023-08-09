Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82FB776305
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjHIOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjHIOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE01EE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BDFA63D01
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DF7C433C7;
        Wed,  9 Aug 2023 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592716;
        bh=Wr9cFgm6xSs6mjUOqRcDglcWyGoDaCa70ogEzfhhv8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUnvAil3pqUkXhx7zaD1OmRPIvBmhPYjzifd33X1fpvpoJ3pQpCYZkc+M/LZ+LVx/
         iXWIs0zFP0uH1BL7dc0PyAWpZZqlkK52vLizD1IoSQ8F9y1fjpjRXr24yYoqUWUtjr
         JNvBb2zMPOH37CIfsQqceY9bu64qbzO76NL/ZeAA74qJ/UjfnAYGZ4hz4xwtgfBHlV
         d+lvwRUPb7DOanscaWPZO7DdYrhS8B18+v2Rcp9TYN/D1jOZdhbKOakVwV8PDAaRPd
         sev9b5XuARfyuDjrjOdqcqN+gMRAXBXqYMKbbYdUbx4m0azFMlKS21XyEI2M8ssTGo
         LamPYdqEQruBg==
Date:   Wed, 9 Aug 2023 10:51:53 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 11/17] x86/cpu: Remove all SRSO interface nonsense
Message-ID: <20230809145153.cl7gys2ddagecbuf@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.192502969@infradead.org>
 <20230809140530.bijq3asl26d2pu7u@treble>
 <20230809144335.GR212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809144335.GR212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:43:35PM +0200, Peter Zijlstra wrote:
> > >  		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
> > >  		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> > >  			return sysfs_emit(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
> > >  
> > > -		return sysfs_emit(buf, "%s; SMT %s\n", retbleed_strings[retbleed_mitigation],
> > > +		return sysfs_emit(buf, "%s; SMT %s%s\n", retbleed_strings[retbleed_mitigation],
> > >  				  !sched_smt_active() ? "disabled" :
> > >  				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> > >  				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
> > > -				  "enabled with STIBP protection" : "vulnerable");
> > > -	}
> > > +				  "enabled with STIBP protection" : "vulnerable",
> > > +				  cpu_has_ibpb_brtype_microcode() ? "" : ", no SRSO microcode");
> > 
> > Hm?  What does missing microcode have to do with SMT?
> 
> semi-colon then, instead of comma ?

Nm, I was confused.  Comma is fine.

-- 
Josh
