Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAADD780FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378378AbjHRQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355209AbjHRQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E13AB9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76FC1635AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68301C433C7;
        Fri, 18 Aug 2023 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692374423;
        bh=iP/51u+uQFWCLdwtYcMg4R1ihG1dtKyEgVl061uxXSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mJBtD6CKFoX0BrH8Ad3opJi+b9L2DlGvibsEXsIdJTZzrk389LSv6twt1jofziuNN
         DfdWCMQMUucaG4I4phvDTtRCAH2doFcPDLPJTq9BRGoVv0E8GUVCJBJnw8nY5bW25p
         U/RQQz+W8zP4oimcao2JY5Aj10qeRRYQZDNvcO6M8hN26Zj/pb/zcmjyhLDYxOSVPa
         2x2ror6HBAGtee5T8184hXFP6rK906QzYUsxANZfMS65aznToJ/DuCmUcXdylCJg6C
         G1yA89sAAB6YYhHOuSVD5ZWB4jcGtfcQBQN6G7moieEoDgpU12H78grZg8nmRqiMg+
         /kCwdyCHVHUQw==
Date:   Fri, 18 Aug 2023 09:00:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>
Subject: Re: [EXT] Re: [net PATCH V2 1/4] octeontx2-pf: Update PFC
 configuration
Message-ID: <20230818090022.50e1c46a@kernel.org>
In-Reply-To: <SJ0PR18MB5216486E191AD5D8B6B12F3CDB1BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
        <20230809070532.3252464-2-sumang@marvell.com>
        <20230809160517.7ff84c3b@kernel.org>
        <SJ0PR18MB5216486E191AD5D8B6B12F3CDB1BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for replying a week late, always a good use of maintainers time
to swap back all the context from random conversations!

On Fri, 18 Aug 2023 06:54:52 +0000 Suman Ghosh wrote:
> >If there is any error in open() this will silently take the interface
> >down. Can't you force a NAPI poll or some such, if the concern is a
> >missed IRQ?  
> [Suman] I can check the return type of open() and report in case of
> error. But even if we force NAPI poll we might not be able to control
> the watchdog reset. If we have a running traffic and interface is up,
> when we force NAPI poll, then the new packets will have updated
> scheduler queue and we will still loose the completion interrupts of
> the previous packets.

Why does it matter that you lost an interrupt if the poll has happened.
Can you describe the problem in more detail?

> Do you see any issue if I handle the error situation during open() call?

No, for years we have been rejecting code which does this.
If the machine is under memory pressure allocating all the buffers 
for rings can easily fail and make the machine drop off the network.
You either have to refuse to change this setting at runtime or
implement prepare/commit reconfiguration model like other modern
drivers, where allocations are done before the stop().
