Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6E800431
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377664AbjLAGzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjLAGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:55:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03D31724
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:55:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93EFC433CA;
        Fri,  1 Dec 2023 06:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701413726;
        bh=rvlUpmCWet3DQSETpKuQuIH6X2X3rucwyaSzL3cBqiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pc0kazKsvlCfPs4Z3xYAx0puK+inFDLkK4qFrkNh8zKe4t1UwmC8qYzYiWmHRUPHJ
         lcOj9w/9965gZb+M30Y1vBvNU6rkgVBW2tWol+SKtsndToHXvY1LL79b/XeZlWVird
         HZ2kQbcUuscBK38s/3Vd3Z0lD9d8caViEk02OudksTno6ezB//2npADfKRHfA4w9Kz
         jqKTO4NWB5faullFHz+7PG8dUi91obE6Mlv4L5GYCm5dYuICUeUov9ll9L3GRLjSn4
         HyRxjgh3gKM3QWOitiqCLDCLF+Ro9XzjqmDHH5G18pQXJ7Qi6wDn+01NMhT+EDARgp
         XWdqR+sSu+/ig==
Date:   Thu, 30 Nov 2023 22:55:24 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "David Christensen" <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 13/14] libie: add per-queue Page Pool stats
Message-ID: <20231130225524.76d41381@kernel.org>
In-Reply-To: <289bf666-b985-4dc4-bf0a-16b1ae072757@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
        <20231124154732.1623518-14-aleksander.lobakin@intel.com>
        <e43fc483-3d9c-4ca0-a976-f89226266112@intel.com>
        <20231129062914.0f895d1c@kernel.org>
        <f01e7e91-08f1-4548-8e73-aa931d5b4834@intel.com>
        <289bf666-b985-4dc4-bf0a-16b1ae072757@intel.com>
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

On Thu, 30 Nov 2023 17:45:10 +0100 Alexander Lobakin wrote:
> > Meh, this way the stats won't survive ifdown/ifup cycles as usually
> > page_pools get destroyed on ifdown :z
> > In that patch, I backup the PP stats to a device-lifetime container when
> > the pool gets destroyed, maybe we could do something similar?  
> 
> I still can pull the PP stats to the driver before destroying it, but
> there's no way to tell the PP I have some archived stats for it. Maybe
> we could have page_pool_params_slow::get_stats() or smth like this?

Why do you think the historic values matter?
User space monitoring will care about incremental values.
It's not like for page pool we need to match the Rx packet count.
