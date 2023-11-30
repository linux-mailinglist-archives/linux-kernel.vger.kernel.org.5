Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECF27FF4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjK3QYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjK3QYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:24:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40310F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:24:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8430C433C9;
        Thu, 30 Nov 2023 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701361489;
        bh=kV8tizWIsmyBHYG9QWSQvffaJTYnRvbTCWtHtmex8xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtG7pF0sEbDdJ4m61zETde9fq5BFMpnnDQdsN2uCKwftC9YAjJHcX6r1p5DktsaRz
         SPgjvw8+Mgxr3s0QwQ6L/kSTZv6nnGBWWt2u/sjWZs/OQGy7qA5odpK9M5vpzzj/Oa
         /OmIJ2+d9biow5Lp66RGEOEu8/iZciy2wKszVdWrFv9MKrsYe+yFspQN2it4sBGnb8
         3kq3TWzZ9oBSR8nDS4gEBQO/zm3zhauXAYCkeinDw5ZAJq0Odq6yokaKMiq51JOKZc
         GsDevNLvPHe8ddXdhVRmqUilyX7GS1QuSYRvghRQxad6qLt1AmJGRZLziOW/ZQySvz
         smPa0+Y2AK+Tg==
Date:   Thu, 30 Nov 2023 16:24:44 +0000
From:   Simon Horman <horms@kernel.org>
To:     Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>
Subject: Re: [EXT] Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
Message-ID: <20231130162444.GA32077@kernel.org>
References: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
 <20231129172633.GG43811@kernel.org>
 <CO1PR18MB466634805050CE390447F811A182A@CO1PR18MB4666.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB466634805050CE390447F811A182A@CO1PR18MB4666.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:36:22AM +0000, Subbaraya Sundeep Bhatta wrote:
> Hi Simon,
> 
> >-----Original Message-----
> >From: Simon Horman <horms@kernel.org>
> >Sent: Wednesday, November 29, 2023 10:57 PM
> >To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
> >davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> >Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> ><gakula@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Linu
> >Cherian <lcherian@marvell.com>; Jerin Jacob Kollanukkaran
> ><jerinj@marvell.com>
> >Subject: [EXT] Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
> >otx2_get_pauseparam
> >
> >External Email
> >
> >----------------------------------------------------------------------
> >On Wed, Nov 29, 2023 at 10:53:42AM +0530, Subbaraya Sundeep wrote:
> >> All the mailbox messages sent to AF needs to be guarded by mutex lock.
> >> Add the missing lock in otx2_get_pauseparam function.
> >>
> >> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause
> >> frames via ethtool")
> >> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >> ---
> >> v2 changes:
> >>  Added maintainers of AF driver too
> >
> >Hi Subbaraya,
> >
> >I was expecting an update to locking in otx2_dcbnl_ieee_setpfc() Am I missing
> >something here?
> >
> I will send it as separate patch since both are unrelated and I have to write two Fixes
> in commit description.

Understood.

In that case I am happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

