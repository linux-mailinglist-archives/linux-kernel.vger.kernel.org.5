Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA27E8519
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKJVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKJVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:33:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9088E4205
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:33:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3250C433C9;
        Fri, 10 Nov 2023 21:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699652000;
        bh=2A5emeoFaW6SfVPuP6ICYHNdvN2k2OlVvkzhivtgSU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OL3/gDVCDj0ENfFBpGtZ814MXkpUyTExFJpMM9gnCGmqHwRSL6tqMC+BSepg4WbAU
         FyZ6u4MvUFAEsBo7V4hxlY8DUOiwvMtjANO8o76vKvFAcx2WFdMo2CH1gQF0NCkDTA
         WJkXEzrxa0HqVqjfUu1jkrlgzv+54OoexhAhjv9ZB6e1/JTkpmcBoctBFB3OpuKzQB
         ezE+C+2l2HFOqd8nZqYw8wuao6Q9qt0VLR0fcmnb0dW2E+U/L/cIl5h2ngQctOfiM6
         SAEf6LG8sGlbQ5l6/Iez9FXi8OiBvKgUPxj6Ad1m6ssyOl0izyaQSOkLag6fEylZ51
         dItD/PQB2KwHg==
Date:   Fri, 10 Nov 2023 13:33:17 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [POC 0/7] livepatch: Make livepatch states, callbacks, and
 shadow variables work together
Message-ID: <20231110213317.g4wz3j3flj7u2qg2@treble>
References: <20231110170428.6664-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110170428.6664-1-pmladek@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 06:04:21PM +0100, Petr Mladek wrote:
> This POC is a material for the discussion "Simplify Livepatch Callbacks,
> Shadow Variables, and States handling" at LPC 2013, see
> https://lpc.events/event/17/contributions/1541/
> 
> It obsoletes the patchset adding the garbage collection of shadow
> variables. This new solution is based on ideas from Nicolai Stange.
> And it should also be in sync with Josh's ideas mentioned into
> the thread about the garbage collection, see
> https://lore.kernel.org/r/20230204235910.4j4ame5ntqogqi7m@treble

Nice!  I like how it brings the "features" together and makes them easy
to use.  This looks like a vast improvement.

Was there a reason to change the naming?  I'm thinking

  setup / enable / disable / release

is less precise than

  pre_patch / post_patch / pre_unpatch / post_unpatch.

Also, I'm thinking "replaced" instead of "obsolete" would be more
consistent with the existing terminology.

For example, in __klp_enable_patch():

	ret = klp_setup_states(patch);
	if (ret)
		goto err;

	if (patch->replace)
		klp_disable_obsolete_states(patch);

it's not immediately clear why "disable obsolete" would be the "replace"
counterpart to "setup".

Similarly, in klp_complete_transition():

	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
		klp_unpatch_replaced_patches(klp_transition_patch);
		klp_discard_nops(klp_transition_patch);
		klp_release_obsolete_states(klp_transition_patch);
	}

it's a little jarring to have "unpatch replaced" followed by "release
obsolete".

So instead of:

  int  klp_setup_states(struct klp_patch *patch);
  void klp_enable_states(struct klp_patch *patch);
  void klp_disable_states(struct klp_patch *patch);
  void klp_release_states(struct klp_patch *patch);

  void klp_enable_obsolete_states(struct klp_patch *patch);
  void klp_disable_obsolete_states(struct klp_patch *patch);
  void klp_release_obsolete_states(struct klp_patch *patch);

how about something like:

  int  klp_states_pre_patch(void);
  void klp_states_post_patch(void);
  void klp_states_pre_unpatch(void);
  void klp_states_post_unpatch(void);

  void klp_states_post_patch_replaced(void);
  void klp_states_pre_unpatch_replaced(void);
  void klp_states_post_unpatch_replaced(void);

?

(note that passing klp_transition_patch might be optional since state.c
already has visibility to it anyway)

-- 
Josh
