Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195507EF75D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjKQSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjKQSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:16:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E30D5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:16:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60643C433C7;
        Fri, 17 Nov 2023 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700244967;
        bh=bFIc0Jmb5tQNMyAhAlrxbHbRAO4Ghji+FMUgKLz3oAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nr0RZ2kgv1BDedZxHGKBq+ZCVgeKV5QRbY+pPYGSh0Q7na3FBIOD9gzGzhIPsJqsk
         KPeoIStW0BBpkLXapz1exYcCWuqksLiTrwqAP+f4O3WiJ5QyGgTw6kpjY5tkVcU6Ya
         ycVM2wZErXESDcMDVjpUJz72V6hZAgV9RGOGr7JbZ0eI/CX/uRLFanCchGiz7AMZ22
         vZpD9KUyZQVAO0ihZ+Tjk08FC3adFZzxhL3v3h4q6INOL9VpOA/8kqOvQeQ5ZNFxbV
         TR8pARNU2Dnt9TCUgs9KQee8ZVuU+k+R/15HqkvhusqKTkVqz3LudqgS3BpUBKIsVi
         z8lgmLMuaFWwQ==
Date:   Fri, 17 Nov 2023 18:16:02 +0000
From:   Simon Horman <horms@kernel.org>
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, jacob.e.keller@intel.com,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: microchip: lan743x : bidirectional
 throughput improvement
Message-ID: <20231117181602.GP164483@vergenet.net>
References: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:13:50AM +0530, Vishvambar Panth S wrote:
> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
> device supports placing the descriptors in memory back to back or
> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
> configurable hardware setting. Currently DSPACE is unnecessarily set to
> match the host's L1 cache line size, resulting in space reserved in
> between descriptors in most platforms and causing a suboptimal behavior
> (single PCIe Mem transaction per descriptor). By changing the setting
> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
> transaction resulting in a massive performance improvement in
> bidirectional tests without any negative effects.
> Tested and verified improvements on x64 PC and several ARM platforms
> (typical data below)
> 
> Test setup 1: x64 PC with LAN7430 ---> x64 PC
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec   169 MBytes   141 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.02 GBytes   876 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.02 GBytes   870 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.10 GBytes   948 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.10 GBytes   942 Mbits/sec  receiver
> 
> Test setup 2 : RK3399 with LAN7430 ---> x64 PC
> 
> RK3399 Spec:
> The SOM-RK3399 is ARM module designed and developed by FriendlyElec.
> Cores: 64-bit Dual Core Cortex-A72 + Quad Core Cortex-A53
> Frequency: Cortex-A72(up to 2.0GHz), Cortex-A53(up to 1.5GHz)
> PCIe: PCIe x4, compatible with PCIe 2.1, Dual operation mode
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   534 MBytes   448 Mbits/sec  sender
> [  5][TX-C]   0.00-10.05  sec   534 MBytes   446 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.12 GBytes   961 Mbits/sec  sender
> [  7][RX-C]   0.00-10.05  sec  1.11 GBytes   946 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   966 MBytes   810 Mbits/sec   sender
> [  5][TX-C]   0.00-10.04  sec   965 MBytes   806 Mbits/sec   receiver
> [  7][RX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec   sender
> [  7][RX-C]   0.00-10.04  sec  1.07 GBytes   919 Mbits/sec   receiver
> 
> Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>

Thanks,

I think you should have included Jacob's Reviewed-by tag from
the previous posting of this patch [1].

And echoing his comments there, a very nice performance boost :)

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://lore.kernel.org/netdev/e5ffec56-5512-1acc-b85c-ac0771634c22@intel.com/
