Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D909D7697FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGaNrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGaNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:47:32 -0400
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 06:47:29 PDT
Received: from out-99.mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE7170D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:47:29 -0700 (PDT)
Message-ID: <337b535c-e2a3-bd65-d1c5-fd7199432891@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690811149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLKb003HBI5xzLCoz1yU7MsFEkEiCvyVgDi7hTTof4c=;
        b=WXBxmoFogi4S8Yp707opUTnSN81JhKHLHVCKYlQWrFDVCwSVryXdHrXf9AgrAo/OOgr+LM
        2T/NKplQowTlRQGULTwQx9ELezPVE142NdknNXSIvmAU1Xk4ngM3p4FPtSa3toreTlFMiW
        /crMI/HrTHzeOi95+LpZPtdczVZOeYI=
Date:   Mon, 31 Jul 2023 14:45:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: lan743x: skip timestamping for non-PTP
 packets
Content-Language: en-US
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
References: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 13:54, Vishvambar Panth S wrote:
> Currently all the RX packets are timestamped and the timestamp is appended
> to the RX packet for processing, this reduces RX throughput. This can be
> optimized by timestamping packets only when the PTP messages are received.
> The RX PTP Configuration register [PTP_RX_TS_CFG] specifies what are the
> PTP message types to be timestamped. The PTP_RX_TS_CFG_MSG_EN_ configures
> Sync, Delay_Req, Pdelay_Req, Pdelay_Resp Message types to be timestamped.
> The RX_CFG_B_TS_ALL_RX_ bit enables storing the timestamp for all RX
> frames, now this is cleared as only PTP packets will be timestamped. The
> RX_CFG_B_TS_DESCR_EN_ enables storing the timestamp in an extension
> descriptor. When PTP messages are received the timestamp will be stored
> in an extension descriptor of the RX packet.

Even though the performance benefit is clear, the PTP subsystem provides
options to select whether PTP filters must be applied or all packets
must be stamped. I think it's better to implement both options as the
hardware supports them, there are use cases where timestamps are needed
for all packets. Linuxptp can be easily configured for both variants,
the hardware/driver documentation can state that there will be
performance degradation for all RX packets timestamps mode.

