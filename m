Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67472766328
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjG1EaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjG1EaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:30:09 -0400
Received: from out-71.mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F6C1FFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:30:07 -0700 (PDT)
Date:   Thu, 27 Jul 2023 21:30:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690518606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeaug6qzs0eQ4nGc13g81NO3qlYaI9kruXZlcPjaNCA=;
        b=mFlae5nXrmsuM6Egk52j6FYIY+Lq7QvVDzhZCO2GLmFC95ZCfzdRDMco0VY+XaYuUHq80R
        UXA2NUruCrkIObnRt8kUAVneAxUw4Uo270c1Mo/C8CNDhJebnCki0OOkfpBU01OQJiCXHk
        vjfNw79nij9z/kdzQydGw4x3YY/jt2A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMNESaE/tWgRd4FI@P9FQF9L96D>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:15:16AM +0200, Michal Hocko wrote:
> On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
> > This patchset tries to add a new bpf prog type and use it to select
> > a victim memcg when global OOM is invoked. The mainly motivation is
> > the need to customizable OOM victim selection functionality so that
> > we can protect more important app from OOM killer.
> 
> This is rather modest to give an idea how the whole thing is supposed to
> work. I have looked through patches very quickly but there is no overall
> design described anywhere either.
> 
> Please could you give us a high level design description and reasoning
> why certain decisions have been made? e.g. why is this limited to the
> global oom sitation, why is the BPF program forced to operate on memcgs
> as entities etc...
> Also it would be very helpful to call out limitations of the BPF
> program, if there are any.

One thing I realized recently: we don't have to make a victim selection
during the OOM, we [almost always] can do it in advance.

Kernel OOM's must guarantee the forward progress under heavy memory pressure
and it creates a lot of limitations on what can and what can't be done in
these circumstances.

But in practice most policies except maybe those which aim to catch very fast
memory spikes rely on things which are fairly static: a logical importance of
several workloads in comparison to some other workloads, "age", memory footprint
etc.

So I wonder if the right path is to create a kernel interface which allows
to define a OOM victim (maybe several victims, also depending on if it's
a global or a memcg oom) and update it periodically from an userspace.
In fact, the second part is already implemented by tools like oomd, systemd-oomd etc.
Someone might say that the first part is also implemented by the oom_score
interface, but I don't think it's an example of a convenient interface.
It's also not a memcg-level interface.

Just some thoughts.

Thanks!
