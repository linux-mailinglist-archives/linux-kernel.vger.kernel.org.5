Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD12580DAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbjLKTX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKTX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:23:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E98BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:23:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5331C433C8;
        Mon, 11 Dec 2023 19:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702322614;
        bh=NQb2rHrXZBC2qUTW9Bi96GGbDXlv9qtiv4KE2DukMZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AMme99iKkntnUrXuqksuKV8S9Z0XBRo4r/dUWRy7Ecb/57h3O5zfQDbYuhWxXTbDW
         rNOS/yeyWp4FG6kT4ZpqR3/gG+U7uuzKWQAqStlqNnYSnByosexY2n6mRAJmRhapS5
         MFNJSQqQYA8zCGRVNzw+7c/2jamKT3Z+EP7fPWPKm0Pg7DnSyweEaxDJ/4qC1QdwEH
         kyE3xq3Rus0MbPaZ0bkqBhPkgfTUv+x6MDaQ7xhO8VBZOb/8tNSUJU6f8wX1eQ7y/x
         DJpJ5C+NGJQ3rRjcqXHLr/c96oukNWoVRtm93UjY2E7tRCoYTzjmTl4SLYpN/CctNX
         s8pnQR/Dt9cJg==
Date:   Mon, 11 Dec 2023 11:23:32 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "David Christensen" <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [PATCH net-next v6 08/12] libie: add Rx buffer management (via
 Page Pool)
Message-ID: <20231211112332.2abc94ae@kernel.org>
In-Reply-To: <03d7e8b0-8766-4f59-afd4-15b592693a83@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
        <20231207172010.1441468-9-aleksander.lobakin@intel.com>
        <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
        <03d7e8b0-8766-4f59-afd4-15b592693a83@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 11:16:20 +0100 Alexander Lobakin wrote:
> Ideally, I'd like to pass a CPU ID this queue will be run on and use
> cpu_to_node(), but currently there's no NUMA-aware allocations in the
> Intel drivers and Rx queues don't get the corresponding CPU ID when
> configuring. I may revisit this later, but for now NUMA_NO_NODE is the
> most optimal solution here.

Hm, I've been wondering about persistent IRQ mappings. Drivers
resetting IRQ mapping on reconfiguration is a major PITA in production
clusters. You change the RSS hash and some NICs suddenly forget
affinitization =F0=9F=A4=AF=EF=B8=8F

The connection with memory allocations changes the math on that a bit.

The question is really whether we add CPU <> NAPI config as a netdev
Netlink API or build around the generic IRQ affinity API. The latter=20
is definitely better from "don't duplicate uAPI" perspective.
But we need to reset the queues and reallocate their state when=20
the mapping is changed. And shutting down queues on=20

  echo $cpu > /../smp_affinity_list

seems moderately insane. Perhaps some middle-ground exists.

Anyway, if you do find cycles to tackle this - pls try to do it
generically not just for Intel? :)
