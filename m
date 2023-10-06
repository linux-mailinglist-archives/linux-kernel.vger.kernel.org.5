Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6A7BC12B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjJFVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjJFVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:32:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39395BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:32:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449F2C433C7;
        Fri,  6 Oct 2023 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696627951;
        bh=sTC4CetYxtFnNBT5I33REzikDFDQsnbC2qzIKmyK4hU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVi51T6WtnlsXeqgwnvqUdsxuGfdDCT+nMKIznhFwYLe99uSFZBmXJzRxHisAIeSn
         GPGf08DxN3ysRTlU+hJB8Qi/KwXXCMnjs2Gl5X7FY1/Iwnh9EhueFAm07PkJ5qzp3n
         gGLNtsRiovBFsPvSM30duKyt1AFGpLCVWwFYFCzPL3bzrQxqG7VMHqW2Lt9bW4bOz6
         9ZDvIPhVMeB1MSYDGWCEl7Cwd1zNDgpMSDKwBNJkDpTAXzUCvhwkv47yp/3/lSK19F
         3JJ5C/ZbASMIFErooWKUcbu+UzuiZRLJIL9SirtsjG/12h7SgFC18cTvXAIQTfQQFD
         W9Iehn5RdAoGQ==
Date:   Fri, 6 Oct 2023 14:32:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
 support
Message-ID: <20231006143230.4230fdc2@kernel.org>
In-Reply-To: <MN0PR12MB5953B3DD4936EAFC7BBD944AB7C9A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
        <20231004135317.2b460acf@kernel.org>
        <MN0PR12MB5953B3DD4936EAFC7BBD944AB7C9A@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 19:04:29 +0000 Pandey, Radhey Shyam wrote:
> > > +		netif_stop_queue(ndev);
> > > +		if (net_ratelimit())
> > > +			netdev_warn(ndev, "TX ring unexpectedly full\n");  
> > 
> > I don't see you stopping the queue when the ring gets full, am I not looking
> > into the right place? Otherwise this is sort of expected to occasionally hapen  
> 
> We are calling stop_queue if TX ring is full. Is that what you meant?
> netif_stop_queue(ndev);

But somewhere else or just here after printing the warning?

The recommended flow is to stop the queue after enqueuing
a packet successfully, if the remaining space is not enough
to hold an skb with all frags populated. That avoids ever
returning BUSY.
