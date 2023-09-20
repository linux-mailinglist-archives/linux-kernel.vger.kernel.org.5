Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533237A7752
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjITJZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjITJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:25:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EDA12F;
        Wed, 20 Sep 2023 02:25:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0BEC433C9;
        Wed, 20 Sep 2023 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695201910;
        bh=+Vx4pZyRUu1fyYPhOi72zytZP5DFTTN2SI/8tCaJRjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvoSEPeffyivIH5CT28GoxlHRWvGT8nI6rZcrGnSCP6Lnm79ksnS8+6TA8PxN+yi3
         0KQ5ntj66H6wThAh66/jNwsM7jK10nRNss2HY4PTf1Zz8rlT8jUkwcY1pywD/KVdw0
         2pxPMqnHxiFvS8l7uCnCacHDJvfR0m35IK2MZ7lM=
Date:   Wed, 20 Sep 2023 11:25:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@suse.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <2023092032-applied-gave-0bff@gregkh>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 10:43:56AM +0200, Michal Hocko wrote:
> On Wed 20-09-23 01:11:01, Jeremi Piotrowski wrote:
> > On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
> > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > 
> > Hi Greg/Michal,
> > 
> > This commit breaks userspace which makes it a bad commit for mainline and an
> > even worse commit for stable.
> > 
> > We ingested 6.1.54 into our nightly testing and found that runc fails to gather
> > cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
> > into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
> > fine.
> 
> Could you expand some more on why is the file read? It doesn't support
> writing to it for some time so how does reading it helps in any sense?
> 
> Anyway, I do agree that the stable backport should be reverted.

That will just postpone the breakage, we really shouldn't break
userspace.

That being said, having userspace "break" because a file is no longer
present is not good coding style on the userspace side at all.  That's
why we have sysfs and single-value-files now, if the file isn't present,
then userspace instantly notices and can handle it.  Much easier than
the old-style multi-fields-in-one-file problem.

> > > Address this by wiping out the file completely and effectively get back to
> > > pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.

The fact that this is a valid option (i.e. no file) with that config
option disabled makes me want to keep this as well, as how does
userspace handle this option disabled at all?  Or old kernels?

I can drop this from stable kernels, but again, this feels like the runc
developers are just postponing the problem...

thanks,

greg k-h
