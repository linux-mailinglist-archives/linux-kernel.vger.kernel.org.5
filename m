Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7967FC905
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbjK1Vyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1Vyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:54:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0992197
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:54:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC3DC433CA;
        Tue, 28 Nov 2023 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701208491;
        bh=z44ibZOrFlszmgHWlfyw3aYj1Gw4MaU3RP+orxkHHo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XRH/rJr7KKpwy/TMRdREroOV1PzoMf75NiWLpzKhbLQC92P1mcrvo6lTFqODiFuN1
         E8N7vpBDQorBvDslWDz4FE/fjvjANrRXPc+fQiUDSLxvva4TW8k6lxuCQI1BdUsx59
         uactW5Y/Iy+spdfneOaCLy73Twsnptd/TGSm3CHNjnxW8Mx34ubw9uipxVUzoFT5/R
         CX0v0wjHAit700kZldvV/LOOIjM/zexm7dKyHvAwiPRi96LsaFED57WT5tIH1MK2rY
         rqlKln3ZF53noobQXp+XNod3pVKVSevi3q7RUN8L56UQPQED8EAvIqb2xYDllBgIzz
         V6bCy8ifXyqxw==
Date:   Tue, 28 Nov 2023 13:54:50 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v1 1/2] octeon_ep: implement device
 unload control net API
Message-ID: <20231128135450.4542dfe0@kernel.org>
In-Reply-To: <PH0PR18MB4734B57CC289557366F68A47C7BCA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231127162135.2529363-1-srasheed@marvell.com>
        <20231127162135.2529363-2-srasheed@marvell.com>
        <20231127184306.68c2d517@kernel.org>
        <PH0PR18MB4734281BD887FD9AFD64B2DEC7BCA@PH0PR18MB4734.namprd18.prod.outlook.com>
        <20231128082712.223c4590@kernel.org>
        <PH0PR18MB4734B57CC289557366F68A47C7BCA@PH0PR18MB4734.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 19:08:26 +0000 Shinas Rasheed wrote:
> > Yes, I think it went in before I had time to nack it.
> > I'm strongly against using the IP stack to talk to FW,
> > if you read the ML you would know it.
> > 
> > No new patches to octep_ctrl_net will be accepted.  
> 
> Control net doesn't use the IP stack at all. It's a simple
> producer-consumer based ring mechanism using PCIe BAR4 memory.
> Sorry maybe the nomenclature suggests something of that nature.

Ah, got it. I read that as "separate netdev for control", my bad.
Just one nit then:

>+	dev_info(&oct->pdev->dev, "Sending dev_unload msg to fw\n");

Is it really necessary to print this at info level for each remove?
Remove is a normal part of operation and we shouldn't spam logs
unless we have a good reason..
