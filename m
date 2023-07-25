Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79747761018
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGYKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjGYKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8565630EB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A3D615E0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14BBC433C8;
        Tue, 25 Jul 2023 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690279294;
        bh=cNm5KR2clJ9E6gKfFOvr+cYuSl9J8RzUM49N3VLff7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSX8gh19ZWgcIvuAtsQjGlPPJEpE5mhu/81cBl6XFlmRYk2fawqHt2kRTmVRzofoC
         q1P8PRwMvZtEMqGwR8vIu6uo5/6NkyLgTOQUpFRA7XPGxRuP6r13m82SBQ92J5czK8
         zp8F2hxD91cbKcpYWgqgsoca6cZGB3CLj9vTxDbacs8kK0mlxc04PogfACgxOs4E6c
         4RgKFUYGvEyznwKKTriEE2yAyFFlNXcp90D6KnGIcr4hn9j6asEeDkvCim/m/GCyRy
         DbNm3wXOJGf1mp/0hHnAY2GjD90g7JpM2LQODjADfwvGOqtZdyG4TwUM45fjEQ26Dj
         k2dZhN9xrSNqQ==
Date:   Tue, 25 Jul 2023 12:01:31 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, vineethrp@gmail.com
Subject: Re: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
Message-ID: <ZL+de6G6VRsoKChy@lothringen>
References: <20230714120852.23573-1-frederic@kernel.org>
 <20230714120852.23573-4-frederic@kernel.org>
 <9347e3d4-e774-f75f-22c4-6c2dba294423@joelfernandes.org>
 <ZLHh71KIIioR85aa@lothringen>
 <CAEXW_YRTtvq0_YZiN=V9DZi2QxrC4hQFeUC9=JrgAKkg8KAnmw@mail.gmail.com>
 <ZLLjEVxM+kf84vgI@lothringen>
 <20230717173049.GA2760149@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717173049.GA2760149@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:30:49PM +0000, Joel Fernandes wrote:
> I think I see what you mean now. Maybe I wrongly assumed the above 'Skip
> reprogram of event' code could early return and skip over
> "tick_program_event(KTIME_MAX, 1);", but I think it cannot because of the
> "expires != ts->next_tick" check.
> 
>  Maybe the "tick_program_event(KTIME_MAX, 1)" bit in tick_nohz_handler() is
>  supposed to handle buggy hardware where an unexpected timer event came
>  through? In such a situation, the idle loop will not write
>  "tick_program_event(KTIME_MAX, 1);" again because it already did so the
>  previous time, as you pointed.

Well at least if the double write was put there intentionally in order to
fix buggy hardware, this was neither mentionned nor commented anywhere AFAICT.

Thanks.

> 
> Adding Vineeth who is also looking into this code.
> 
> thanks,
> 
>  - Joel
> 
