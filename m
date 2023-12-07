Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5E808F04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443448AbjLGRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjLGRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:42:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80310F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:42:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3035C433C7;
        Thu,  7 Dec 2023 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701970942;
        bh=XActvnt3u4hVPQCbSWjczs0CUksp+uATv6dyECFr7ds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hO5ooNVgtmHhpxNK2pAHaJJKLA0UwCH3ibX4kDCSuEbRyjoZ5qSC7cygJUi9d+/M+
         SkzDG3gw1QKcPt9H5zbhqdQhGboNQUmbpANZMA8WAMb/pOU6pgoTA8v9CXKYFA4jLR
         c1k9utyZwmRhhfFehCNCQexO5GVAWtka2DJ7BphUiwYyiSGmEcWSOweJLfIRhsmxZe
         H4DT3Rv4O9VG/Si5ASZfjcumvO/yAsNjsQmXqfgdFRHylHPd12jaZwn6WydZ6QttdN
         hva/cZFoy+fBfirtYNBmPXzbWiSJfnHJ+6PUnba4sbmOJrH1t+mWyWxHL5M3y0X1Y2
         5Pvzis3iLwoFA==
Date:   Thu, 7 Dec 2023 09:42:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     Zhipeng Lu <alexious@zju.edu.cn>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Jie Yang <jie.yang@atheros.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
Message-ID: <20231207094220.77019dd0@kernel.org>
In-Reply-To: <SJ0PR18MB52161F73B08DA547F7A8F3B8DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231207143822.3358727-1-alexious@zju.edu.cn>
        <SJ0PR18MB52161F73B08DA547F7A8F3B8DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
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

On Thu, 7 Dec 2023 17:08:15 +0000 Suman Ghosh wrote:
> >+		kfree(tx_ring->tx_buffer);  
>
> [Suman] I think we should do tx_ring->tx_buffer = NULL also, to avoid use after free?

It's up to the driver. Some may call that defensive programming.
