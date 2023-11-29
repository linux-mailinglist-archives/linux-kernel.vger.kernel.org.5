Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38227FD5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjK2Lig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjK2Lia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:38:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F03C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:38:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E3C433C8;
        Wed, 29 Nov 2023 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701257916;
        bh=/djex4o3dqe1i42wuz9PG0/vgKzpHPhwIhOIgQXXL1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uU4whDs6Z1YKngjCmn5gwHACPMm29u1VKm7mUddhCUXuq3xjutAf+mwQ/z0cYHqWF
         90EhlUizj3sy+E1Rq3Y8iPk5NYo9RQILX5fukZP6uGVqJjGImZB4ky8MmYNdunLRRq
         Nx6ghWr+yFeY24UfDxeln7sZz8WV2RrCRITCFjhyLHO3lPf4Pcjmj8JtmwTIZ/27EZ
         nVkcvIeafQJrWpbdTPhMPWp0WxHUYVJoPYs2khEESigfzVGG1E0VX1ZJMCtcAfQf97
         zStLnBYhhxojdu5mIQuSjv41ED45qupXM8dXXCF8u7OMJW96GaKp1TFP+wHsMvmtwy
         9mweFFhWj56tQ==
Date:   Wed, 29 Nov 2023 12:38:30 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231129-fundort-kalligrafie-d4777374ad7a@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128-arsch-halbieren-b2a95645de53@brauner>
 <20231128135258.GB22743@redhat.com>
 <20231128-elastisch-freuden-f9de91041218@brauner>
 <20231128165945.GD22743@redhat.com>
 <20231128172959.GA27265@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128172959.GA27265@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:29:59PM +0100, Oleg Nesterov wrote:
> Forgot to menstion,
> 
> On 11/28, Oleg Nesterov wrote:
> >
> > but please
> > note irq_thread()->task_work_add(on_exit_work).
> 
> and this means that Neil's and your more patch were wrong ;)

Hm, that's all the more reason to not hang this off of PF_KTHREAD then.
I mean, it's functional but we likely wouldn't have run into this
confusion if this would be PF_FPUT_DELAYED, for example.
