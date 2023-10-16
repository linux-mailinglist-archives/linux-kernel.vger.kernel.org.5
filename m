Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C777CB688
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjJPWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:23:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5762C95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:23:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50618C433C7;
        Mon, 16 Oct 2023 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697495024;
        bh=bRrY6z8Qu3DHxdJ9AWDgW2EEHgMVRnN3AxmhHve8YT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vDG8J87nBqFt4L6UK9UD0UURS6rn2Zw5xR5YguOBewzOHIpPmFmU7m2BWITb6nKtP
         1bUMsnYgmBJ4ihkMfm+CKSQdB3svbnsafQLeqhOFOT8aktvznQeOxoMXxDgMEtluL7
         /ItwqYCfITwZEq0Uie/0PtTtmP9FVsNExso+35t63ihM5YqgcXBMy5DV+4xCo7+VDv
         TPMkgErh0SFf1NgbrzXJ+Ix4F2S+8Vj/+cEVZJ8gJvDyeHUSUfZ2MG8WTaTulWAS4S
         EnMQJ/67pYltlKrmgWTsmdVmhsC1YnbjYbAx6+rDe3WByYmkhpCkwcVyU596eWuhgB
         UfsfQyYAwwdZA==
Date:   Mon, 16 Oct 2023 15:23:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Takeru Hayasaka <hayatake396@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231016152343.1fc7c7be@kernel.org>
In-Reply-To: <20231012060115.107183-1-hayatake396@gmail.com>
References: <20231012060115.107183-1-hayatake396@gmail.com>
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

Thanks for the v2!

Adding Willem, Pablo, and Harald to CC (please CC them on future
versions).

On Thu, 12 Oct 2023 06:01:15 +0000 Takeru Hayasaka wrote:
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..a2d4f2081cf3 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2011,6 +2011,18 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define	IPV4_FLOW	0x10	/* hash only */
>  #define	IPV6_FLOW	0x11	/* hash only */
>  #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
> +#define GTPU_V4_FLOW 0x13	/* hash only */
> +#define GTPU_V6_FLOW 0x14	/* hash only */
> +#define GTPC_V4_FLOW 0x15	/* hash only */
> +#define GTPC_V6_FLOW 0x16	/* hash only */
> +#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
> +#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
> +#define GTPU_EH_V4_FLOW 0x19	/* hash only */
> +#define GTPU_EH_V6_FLOW 0x20	/* hash only */

nit: please note that these are hex numbers,
     next value after 0x19 is 0x1a, not 0x20.

> +#define GTPU_UL_V4_FLOW 0x21	/* hash only */
> +#define GTPU_UL_V6_FLOW 0x22	/* hash only */
> +#define GTPU_DL_V4_FLOW 0x23	/* hash only */
> +#define GTPU_DL_V6_FLOW 0x24	/* hash only */
>  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
>  #define	FLOW_EXT	0x80000000
>  #define	FLOW_MAC_EXT	0x40000000

What gives me pause here is the number of flow sub-types we define
for GTP hashing.

My understanding of GTP is limited to what I just read on Wikipedia.

IIUC the GTPC vs GTPU distinction comes down to the UDP port on
which the protocol runs? Are the frames also different?

I'm guessing UL/DL are uplink/downlink but what's EH?

How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
GTPU_DL_V4_FLOW differ?

Key question is - are there reasonable use cases that you can think of
for enabling GTP hashing for each one of those bits individually or can
we combine some of them?

> @@ -2025,6 +2037,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define	RXH_IP_DST	(1 << 5)
>  #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
>  #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
> +#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
>  #define	RXH_DISCARD	(1 << 31)
