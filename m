Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB77E673E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjKIKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKIKC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:02:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693E2D65;
        Thu,  9 Nov 2023 02:02:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B225921981;
        Thu,  9 Nov 2023 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699524143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHwA8ZjuKs5PsD64751HJy5aT/pjtH4Nv0BUUWN4lQY=;
        b=UElFh/9iV0/RSdMRUc5MEEhCKXNAelQdQYVt8/v22jXg6gDCngN5J/EL2liPDkXGIfdrBY
        LNAKiIgMv2OuKlTJcmLQy2YF+xbKlXK3DV+a+zCJQVdBis8fmgTrD7WMN1UzOP7tXFPvAv
        tBLNXSzFZzDP5PzwfX1C4SqSD1y/xUA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98EBA138E5;
        Thu,  9 Nov 2023 10:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gL9LJS+uTGVVZgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 10:02:23 +0000
Date:   Thu, 9 Nov 2023 11:02:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, ying.huang@intel.com,
        akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, corbet@lwn.net, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZUyuL9_8PPiEflnS@tiehlicka>
References: <20231109002517.106829-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109002517.106829-1-gregory.price@memverge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-11-23 19:25:14, Gregory Price wrote:
> This patchset implements weighted interleave and adds a new cgroup
> sysfs entry: cgroup/memory.interleave_weights (excluded from root).

Why have you chosen memory controler rather than cpuset controller?
TBH I do not think memcg is the best fit because traditionally memcg
accounts consumption rather than memory placement. This means that the
memory is already allocated when it is charged for a memcg. On the other
hand cpuset controller is the one to control the allocation placement so
it would seem a better fit.
-- 
Michal Hocko
SUSE Labs
