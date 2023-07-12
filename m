Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2AC751200
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGLUsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGLUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9D5B0;
        Wed, 12 Jul 2023 13:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582CD6190C;
        Wed, 12 Jul 2023 20:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD9CC433C8;
        Wed, 12 Jul 2023 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689194895;
        bh=umMj9SqdAeHyJMv8GQj726P6iDM27DdawxrEe4QZ+P0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fQ9OTl4DUgChct+LRh18y/+Eegn0pYc0fNitqfYS8KUcNh3rBilIyni/E/UpNvHVu
         3DxjHDwkpnfC4SQqBF5soHY5VlUWdpvI8KzVjKYQTCIGC0I1vXovIRsEhpW6wFA/dg
         f3f19FzCYf4IZijGIW+SgwnNvEio+Mf5Ap9ShFLGEmIaA1B8fAgZlBGGPtxyePQO96
         1+MCOx3+pbIaSGKjg4g7FMxIAb8yghKGGk1sUtDAZltsiS7bc6ljID8G5Fko/zDRnY
         60NIZ/9f5tOh8nk2ZlUEPdSl72rWrzNny5vYbqsYVw3xdBluxgSLkpltjrDPY/uZpZ
         CGB5UFE5j1+bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F835CE00AB; Wed, 12 Jul 2023 13:48:15 -0700 (PDT)
Date:   Wed, 12 Jul 2023 13:48:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [linus:master] [rcu/nocb]  7625926086:
 WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass
Message-ID: <005a79ac-5080-40a5-a7bd-31c0d2e76414@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202307111535.4823c255-oliver.sang@intel.com>
 <ZK1983kQCrN+zCqs@lothringen>
 <842683bc-5859-48be-8ca5-17a1e4bf3f39@paulmck-laptop>
 <ZK7b+vIJpOZhndbm@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK7b+vIJpOZhndbm@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 06:59:38PM +0200, Frederic Weisbecker wrote:
> On Tue, Jul 11, 2023 at 09:41:58AM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 11, 2023 at 06:06:11PM +0200, Frederic Weisbecker wrote:
> > Heh!
> > 
> > The purpose was to see if this lock was ever contended.  I guess we now
> > have an answer, which is "Yes, but rarely."
> > 
> > It looks like the victim commit increased the size of the ->nocb_lock
> > critical section, just enough to make this happen sometimes.
> > 
> > Removing the WARN_ON_ONCE() seems appropriate, especially given that
> > this only happens when shrinking.
> 
> Ok, I'll check that.
> 
> > Should we add something that monitors that lock's contention?  It is
> > often the case that lock contention rises over time as new features and
> > optimizations are added.
> 
> I'm not sure. Should we keep the current ->nocb_lock_contended based engine
> to report contention somehow somewhere? Also does it behave better than our
> current spinlock slow path implementations?

The current spinlock slow path implementations try to be fair, and here
we want to favor the things dequeuing from ->cblist over those enqueuing
to it.  The idea is to slow down the enqueuing when things get busy.

But to your point, given the rarity of contention, is this a real problem
needing to be solved?  My queuing-theory studies and experiences argue
strenuously in favor of keeping it, but maybe there is a better way.

							Thanx, Paul
