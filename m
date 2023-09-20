Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911E17A89CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjITQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjITQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:56:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772ED9F;
        Wed, 20 Sep 2023 09:55:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 209A121E17;
        Wed, 20 Sep 2023 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695228953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRuJsY73C8doQ4cNf1LjL+UhEmqmPUGsnMHO5Imx8so=;
        b=dKI2cRhasOtnaSBCgHjLyUopF0KNuF+cPl+ufz4nGgCod/Sl8Ub2LjKkQ0FAvxJdjnvDmg
        loN3fdV7iY3W0HfKtQ7/3pa0ZqYapkZuE1Akp8EzbDWK39Heez0rwJ3Xg9iHYJwzuTCz4H
        64/c3qT/xH5HCj7WJ3OK6gSwbOE1Hek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8EDA1333E;
        Wed, 20 Sep 2023 16:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KbyzNBgkC2V7dQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 20 Sep 2023 16:55:52 +0000
Date:   Wed, 20 Sep 2023 18:55:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <ZQskGGAwlsr1YxAp@dhcp22.suse.cz>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
 <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
 <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-09-23 08:32:42, Shakeel Butt wrote:
> Also I don't think reverting 58056f77502f would give any benefit.

Not reverting 58056f77502f would re-introduce the regression in some
non-patched versions of Docker runtimes which cannot handle ENOTSUPP.
So I think we need to revert both or none of them. I would prefer the
later (option 1) as the fix is trivial but I do understand headache
of chasing all those outdated deployments or vendor code forks.
-- 
Michal Hocko
SUSE Labs
