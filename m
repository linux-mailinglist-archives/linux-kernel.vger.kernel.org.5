Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5177709CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjHDUfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjHDUfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1702A4C37
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EDA620AF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D82BC433C8;
        Fri,  4 Aug 2023 20:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181314;
        bh=52KUF7ASXjYC/XDXuwqGaqu5PqSMpO06sMHL33KXuLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q9lDEPahh6/mGcVWoYorDTP41TyrASjNn1raO9nzESg9Xg9RdYzbrJ0ale8vjR5Ww
         HEjk3xwyFz4s1ynj5VOSdsYmosK/Rk3MrjkLbzlzDv+PRR+Qo1klI6d/QNIfNIX0xj
         NXdPxlYQesAL8pEMwmLdbBua6ZKIaPuOHrwUl5LsrlHQdO+hBdrlAyNQqZZ/px5bQm
         q+ZzPQN6heyqVTZWDM6FbfcwQBmg0mpkfJ+Rray8441uEbfnx5tbWvO0DrKtY9rTJq
         As5Zi07F7ytQvw4tN81AF+g1MsYibJNTW0zylti775g+Pmb9dphAon2nsF9/hAdmp2
         Tu8oOQ46hm4Tg==
Date:   Fri, 4 Aug 2023 13:35:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Ratheesh Kannoth <rkannoth@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [EXT] Re: [PATCH net] octeontx2-pf: Set maximum queue size to
 16K
Message-ID: <20230804133512.4dbbbc16@kernel.org>
In-Reply-To: <8732499b-df8c-0ee0-bf0e-815736cf4de2@intel.com>
References: <20230802105227.3691713-1-rkannoth@marvell.com>
        <18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
        <CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.namprd18.prod.outlook.com>
        <f04cf074-1cff-d30a-4237-ad11f62290b1@intel.com>
        <MWHPR1801MB1918C41E2A44527D178F213CD309A@MWHPR1801MB1918.namprd18.prod.outlook.com>
        <8732499b-df8c-0ee0-bf0e-815736cf4de2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 16:43:51 +0200 Alexander Lobakin wrote:
> > So, will clamp to 2048 in page_pool_init() ? But it looks odd to me, as 
> > User requests > 2048,  but will never be aware that it is clamped to 2048.  
> 
> Why should he be aware of that? :D
> But seriously, I can't just say: "hey, I promise you that your driver
> will work best when PP size is clamped to 2048, just blindly follow",
> it's more of a preference right now. Because...
> 
> > Better do this clamping in Driver and print a warning  message ?   
> 
> ...because you just need to test your driver with different PP sizes and
> decide yourself which upper cap to set. If it works the same when queues
> are 16k and PPs are 2k versus 16k + 16k -- fine, you can stop on that.
> If 16k + 16k or 16 + 8 or whatever works better -- stop on that. No hard
> reqs.
> 
> Just don't cap maximum queue length due to PP sanity check, it doesn't
> make sense.

IDK if I agree with you here :S Tuning this in the driver relies on
the assumption that the HW / driver is the thing that matters.
I'd think that the workload, platform (CPU) and config (e.g. is IOMMU
enabled?) will matter at least as much. While driver developers will end
up tuning to whatever servers they have, random single config and most
likely.. iperf.

IMO it's much better to re-purpose "pool_size" and treat it as the ring
size, because that's what most drivers end up putting there. 
Defer tuning of the effective ring size to the core and user input 
(via the "it will be added any minute now" netlink API for configuring
page pools)...

So capping the recycle ring to 32k instead of returning the error seems
like an okay solution for now.
