Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67C7515A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjGMA5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjGMA5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F172F2705;
        Wed, 12 Jul 2023 17:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B53619E6;
        Thu, 13 Jul 2023 00:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2C5C433C8;
        Thu, 13 Jul 2023 00:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209832;
        bh=kzMvqzJkOEzUr76ZNwmRMT6/10WO7WOHuIcNaVsSbtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gJRksAoeavSMXdsgYpDYwVqRB30X8vFxyxsi8Oycy0UPygOP4NybKV5/IigUSoIRF
         aXOJVNe+uHaJEP/CcpbVF6VRRU24DEej5dZjfuNibOw88hSEOfzt2TfFtdQTl8qWNp
         EISBVdlgS5uPGJ/ZiL5W0MAF5xYZDves+Co+v2EAI2mHOagAsEq/zB19JRYvUW7FNd
         w39Ehb0ej/YLhaksrKLbeTLThRtCrbH6QSV1JHSjGO25QykuYjo7isb5nhYkIw2G4n
         zgHh0VWQtsnTKSZy/z0VwP2YccteJmye+ep+HxMtIDc73WwNVw4tnKaXLzsHJ3cyms
         6dTNipS6iJXpg==
Date:   Wed, 12 Jul 2023 17:57:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     pinkperfect <pinkperfect2021@gmail.com>
Cc:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        huxinming820@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        sharvari.harisangam@nxp.com
Subject: Re: [PATCH v2] wifi: mwifiex: Fix OOB and integer underflow in
 mwifiex_process_mgmt_packet
Message-ID: <20230712175711.1431adec@kernel.org>
In-Reply-To: <20230710150130.2449934-1-pinkperfect2021@gmail.com>
References: <20230708070749.2382045-1-pinkperfect2021@gmail.com>
        <20230710150130.2449934-1-pinkperfect2021@gmail.com>
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

On Mon, 10 Jul 2023 15:01:30 +0000 pinkperfect wrote:
> Hi, this vulnerability has been reported to and discussed with chromeos teams,
> the detail analysis, see comments in below code:
> mwifiex_process_sta_rx_packet makes sure rx_pkt_offset + rx_pkt_length <= skb->len
> In mwifiex_process_mgmt_packet:
> 
>         rx_pd = (struct rxpd *)skb->data;
> 
>         // skb->len -= rx_pkt_offset, skb->len == rx_pkt_length
>         skb_pull(skb, le16_to_cpu(rx_pd->rx_pkt_offset));
>         // skb->len == rx_pkt_length - 2, if set rx_pkt_length == 4, skb->len == 2
>         skb_pull(skb, sizeof(pkt_len));
> 
>         pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
> 
>         //skip..
> 
>         // now skb->len == 2, skb->data + 24 is oob from skb buffer
>         // skb->data + 30 is oob from skb buffer
>         // pkt_len == 4, so underflow
>         memmove(skb->data + sizeof(struct ieee80211_hdr_3addr),
>                 skb->data + sizeof(struct ieee80211_hdr),
>                 pkt_len - sizeof(struct ieee80211_hdr));
> 
> On MT8173 chromebook, the arm64 memmove.S / memcpy.S code logical
> cause memove(dst, src, -x) a possible exploitable oob write vulnerability
> not only a unexploitable crash

Oh, didn't see the v2, please address the comments I just sent to v1.
