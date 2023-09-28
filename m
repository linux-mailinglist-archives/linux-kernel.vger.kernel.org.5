Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776207B17D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjI1Jva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjI1Jv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:51:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050A122;
        Thu, 28 Sep 2023 02:51:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB97C433C8;
        Thu, 28 Sep 2023 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695894685;
        bh=cSDK+UH2nr0GMiVRWIpaakkw5si/jCZFr2FE2PgYopQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxmkfzbSA9rWkkV7y1pH8ttaXkDEb3qcaPrCrO5FyOub/Fc5PrNUTEvws/N2GTHhu
         Uf7MzEmwKone+bIR9v1q3YbGvBkZKbvIOEUSNZKNkhEZ7y/cx20vufw4WuxWGuxIrD
         1UosEyYmUQ0SdmXXKeePFt0AqECR8ONEvD8rh9Aq5ayaqddPI8gDp8il9mFbIHIe9F
         J01BCAkwzpo/fZAfqEKPJ72Gv/YmpW8lKlKnvATGsogNAkPZVhNCxYTVmHMGkYPM9I
         8+TYLCpYuqSnsMPfpnXUCZkAMDbKWHgxXyhlwBmq1BS7VS9FK3cwlj/b6MPEvej5zD
         NGyn4MJyGAEsw==
Date:   Thu, 28 Sep 2023 12:51:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20230928095119.GR1642130@unreal>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230927034209.GE92403@linux.alibaba.com>
 <20230927055528.GP1642130@unreal>
 <20230927121740.GF92403@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927121740.GF92403@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 08:17:40PM +0800, Dust Li wrote:
> On Wed, Sep 27, 2023 at 08:55:28AM +0300, Leon Romanovsky wrote:
> >On Wed, Sep 27, 2023 at 11:42:09AM +0800, Dust Li wrote:
> >> On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> >> >If the netdevice is within a container and communicates externally
> >> >through network technologies like VXLAN, we won't be able to find
> >> >routing information in the init_net namespace. To address this issue,
> >> 
> >> Thanks for your founding !
> >> 
> >> I think this is a more generic problem, but not just related to VXLAN ?
> >> If we use SMC-R v2 and the netdevice is in a net namespace which is not
> >> init_net, we should always fail, right ? If so, I'd prefer this to be a bugfix.
> >
> >BTW, does this patch take into account net namespace of ib_device?
> 
> I think this patch is irrelevant with the netns of ib_device.
> 
> SMC has a global smc_ib_devices list reported by ib_client, and checked
> the netns using rdma_dev_access_netns. So I think we should have handled
> that well.

ok, I see

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
