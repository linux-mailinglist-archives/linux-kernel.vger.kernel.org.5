Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE476973F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjGaNM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGaNMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:12:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FE10F0;
        Mon, 31 Jul 2023 06:12:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA0491F74C;
        Mon, 31 Jul 2023 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690809141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0G/5kQCeYWmkFZEH2dxqKEVz6fKHKJ6oQP2DPUUb1jg=;
        b=WtRk7D3xJiXUE7HfgZ5OkBhRcliUorhI9tOzybJLiJrL0OF8OqDxE0rRDxRN8PlXthLfxp
        uvL9/ChJ1dYCZlFxeGeadpfmTFtmYJe6heQzKRhgiLmW+6tpHOabAqVkRyiGOTc+AsC8YG
        mRwYyGrqhDOuRrPxzNHUHHr3vTa9E7c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7534133F7;
        Mon, 31 Jul 2023 13:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P/apKTWzx2RvMQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 31 Jul 2023 13:12:21 +0000
Date:   Mon, 31 Jul 2023 15:12:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMezNBQYHBOKve80@dhcp22.suse.cz>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
 <ZMNESaE/tWgRd4FI@P9FQF9L96D>
 <ZMN3Do86cxsXyD84@dhcp22.suse.cz>
 <ZMQME4f9Okp8Rl7N@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMQME4f9Okp8Rl7N@P9FQF9L96D>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-07-23 11:42:27, Roman Gushchin wrote:
> On Fri, Jul 28, 2023 at 10:06:38AM +0200, Michal Hocko wrote:
> > On Thu 27-07-23 21:30:01, Roman Gushchin wrote:
> > > On Thu, Jul 27, 2023 at 10:15:16AM +0200, Michal Hocko wrote:
> > > > On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
> > > > > This patchset tries to add a new bpf prog type and use it to select
> > > > > a victim memcg when global OOM is invoked. The mainly motivation is
> > > > > the need to customizable OOM victim selection functionality so that
> > > > > we can protect more important app from OOM killer.
> > > > 
> > > > This is rather modest to give an idea how the whole thing is supposed to
> > > > work. I have looked through patches very quickly but there is no overall
> > > > design described anywhere either.
> > > > 
> > > > Please could you give us a high level design description and reasoning
> > > > why certain decisions have been made? e.g. why is this limited to the
> > > > global oom sitation, why is the BPF program forced to operate on memcgs
> > > > as entities etc...
> > > > Also it would be very helpful to call out limitations of the BPF
> > > > program, if there are any.
> > > 
> > > One thing I realized recently: we don't have to make a victim selection
> > > during the OOM, we [almost always] can do it in advance.
> > > 
> > > Kernel OOM's must guarantee the forward progress under heavy memory pressure
> > > and it creates a lot of limitations on what can and what can't be done in
> > > these circumstances.
> > > 
> > > But in practice most policies except maybe those which aim to catch very fast
> > > memory spikes rely on things which are fairly static: a logical importance of
> > > several workloads in comparison to some other workloads, "age", memory footprint
> > > etc.
> > > 
> > > So I wonder if the right path is to create a kernel interface which allows
> > > to define a OOM victim (maybe several victims, also depending on if it's
> > > a global or a memcg oom) and update it periodically from an userspace.
> > 
> > We already have that interface. Just echo OOM_SCORE_ADJ_MAX to any tasks
> > that are to be killed with a priority...
> > Not a great interface but still something available.
> > 
> > > In fact, the second part is already implemented by tools like oomd, systemd-oomd etc.
> > > Someone might say that the first part is also implemented by the oom_score
> > > interface, but I don't think it's an example of a convenient interface.
> > > It's also not a memcg-level interface.
> > 
> > What do you mean by not memcg-level interface? What kind of interface
> > would you propose instead?
> 
> Something like memory.oom.priority, which is 0 by default, but if set to 1,
> the memory cgroup is considered a good oom victim. Idk if we need priorities
> or just fine with a binary thing.

Priorities as a general API have been discussed at several occasions
(e.g http://lkml.kernel.org/r/ZFkEqhAs7FELUO3a@dhcp22.suse.cz). Their usage
is rather limited, hiearchical semantic not trivial etc.
-- 
Michal Hocko
SUSE Labs
