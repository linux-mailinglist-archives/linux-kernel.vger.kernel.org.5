Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1777DAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbjHPGt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbjHPGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:49:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFE91FD0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:49:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B18DE1F74C;
        Wed, 16 Aug 2023 06:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692168553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4bO4q3DFLkSAtmvUq+ZKw9sKGdZUVknegi6CSzfugZU=;
        b=ZsX6smdEVteWd98vAaeNm2z7kbPFhiM9F6u8oOtvUpnmJSlqq3kUY9+Zs7Xt4nyfwtCiu4
        hppFZb8i9YIn2hRhhYVEQLjtHOE2tr2aeHfEL4z2lO/KLGaPxvdfxxclTW7LwtGCSMPCA+
        ilXX+CzjWdu6484X79btbIR9g9oQ5UE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 864D8133F2;
        Wed, 16 Aug 2023 06:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K2PmHWlx3GS0ewAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 16 Aug 2023 06:49:13 +0000
Date:   Wed, 16 Aug 2023 08:49:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
Message-ID: <ZNxxaFnM9W8+imHD@dhcp22.suse.cz>
References: <20230811090819.60845-1-ying.huang@intel.com>
 <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
 <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-08-23 09:59:51, Huang, Ying wrote:
> Hi, Michal,
> 
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Fri 11-08-23 17:08:19, Huang Ying wrote:
> >> If there is no memory allocation/freeing in the remote pageset after
> >> some time (3 seconds for now), the remote pageset will be drained to
> >> avoid memory wastage.
> >> 
> >> But in the current implementation, vmstat updater worker may not be
> >> re-queued when we are waiting for the timeout (pcp->expire != 0) if
> >> there are no vmstat changes, for example, when CPU goes idle.
> >
> > Why is that a problem?
> 
> The pages of the remote zone may be kept in the local per-CPU pageset
> for long time as long as there's no page allocation/freeing on the
> logical CPU.  In addition to the logical CPU goes idle, this is also
> possible if the logical CPU is busy in the user space.

But why is this a problem? Is the scale of the problem sufficient to
trigger out of memory situations or be otherwise harmful?

-- 
Michal Hocko
SUSE Labs
