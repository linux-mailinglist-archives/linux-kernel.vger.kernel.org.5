Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89462789DF5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjH0NJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjH0NJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0A713D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1834362897
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 13:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0942C433C9;
        Sun, 27 Aug 2023 13:09:01 +0000 (UTC)
Date:   Sun, 27 Aug 2023 16:09:00 +0300
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Message-ID: <ZOtK7LwdDbVzCvjR@arm.com>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-5-revest@chromium.org>
 <202308251535.551E797B1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308251535.551E797B1@keescook>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 03:38:36PM -0700, Kees Cook wrote:
> On Tue, Jul 04, 2023 at 05:36:28PM +0200, Florent Revest wrote:
> >  static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
> >  				 unsigned long arg4, unsigned long arg5)
> >  {
> > +	unsigned long current_bits;
> > +
> >  	if (arg3 || arg4 || arg5)
> >  		return -EINVAL;
> >  
> > -	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
> > +	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
> > +		return -EINVAL;
> > +
> > +	/* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
> > +	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
> >  		return -EINVAL;
> >  
> > +	current_bits = get_current_mdwe();
> > +	if (current_bits && current_bits != bits)
> > +		return -EPERM; /* Cannot unset the flags */
> 
> I was pondering why PR_MDWE_NO_INHERIT can't be unset, but I guess it
> doesn't matter. Anything forked with have it off, and any process
> wanting to launch stuff before locking down can just skip running the
> prctl() until later.

I had a similar doubt initially but then realised that the no-inherit
mode won't be inherited and concluded it's ok.

-- 
Catalin
