Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05877F63DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbjKWQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjKWQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:24:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAC61A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:24:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7570C433C9;
        Thu, 23 Nov 2023 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700756698;
        bh=8qbTRbdLFdnXb3Xe8uP0IN8YCP7nL2AK2pZi0k8jVmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmnZyFi9UMYT31BH9Q3rAbNfIaVQ0bRDx2OxJp8JC3rGb5UBAa/ZbMLbt/oJhrtgy
         XQfk4Ja/ihC5b4N7oj+pbXArjp1ErDUiUsHfGVpN1prX6E4NqkVCAdTa7YKTx3RMzO
         CCzgc6Nc08iu4BX33NSVnfADwm12OkUR6BbVR+6uZ8my99h87K6pqcNq+QStsFkVkN
         iCdESVJWG2oGoQYr39+vyW7w17U6oydSDnJB0BBp/X2jXoJuRUEHiLoq2YXBgfo4D4
         6JfNQmixj3sbRZEA4YVVRpfW+tL8FsdMvhdHGegCCfGhFpUx79OXEwzB9cAw0XEGkW
         VQwoEDItqb3tQ==
Date:   Thu, 23 Nov 2023 17:24:48 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, nd@arm.com
Subject: Re: [PATCH RFT v3 0/5] fork: Support shadow stacks in clone3()
Message-ID: <20231123-edelherzig-feiern-b53339f5a639@brauner>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231121-urlaub-motivieren-c9d7ee1a6058@brauner>
 <ZVyg0WgILK35xjBn@arm.com>
 <ZVzWRIA9AfXHeWMW@finisterre.sirena.org.uk>
 <20231123-geflattert-mausklick-63d8ebcacffb@brauner>
 <ZV85khoUcFyKhQ+w@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV85khoUcFyKhQ+w@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:37:54AM +0000, Mark Brown wrote:
> On Thu, Nov 23, 2023 at 11:10:24AM +0100, Christian Brauner wrote:
> > On Tue, Nov 21, 2023 at 04:09:40PM +0000, Mark Brown wrote:
> > > On Tue, Nov 21, 2023 at 12:21:37PM +0000, Szabolcs Nagy wrote:
> > > > The 11/21/2023 11:17, Christian Brauner wrote:
> 
> > I'm still not enthusiastic that we only have one implementation for this
> > in the kernel. What's the harm in waiting until the arm patches are
> > merged? This shouldn't result in chicken and egg: if the implementations
> > are sufficiently similar then we can do an appropriate clone3()
> > extension.
> 
> The main thing would be that it would mean that people doing userspace
> enablement based on the merged x86 support can't use the stack size
> control.  It's not the end of the world if that has to wait a bit, it's
> a bit of a detail thing, but it would make life easier, I guess the
> userspace people can let us know if it's starting to be a real hassle
> and we can reevaulate if that happens.
> 
> It's also currently a dependency for the arm64 code so it'd be good to
> at least get ageement that assuming nothing comes up in testing the
> patches can go in along with the arm64 series, removing the dependency

Oh yeah, I'm not fuzzed whose tree this goes through. By all means, take
it with the arm64 series.

> and then adding it as an incremental thing would be a hassle.  It's
> likely that the arm64 series will be held out of tree for a while to as
> more complete userspace support is built up and validated so things
> might be sitting for a while - we don't have hardware right now so we
> can be cautious with the testing.

Ok, that sounds good to me.
