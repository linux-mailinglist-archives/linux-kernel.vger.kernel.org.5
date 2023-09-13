Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1AF79F2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjIMUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIMUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:31:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D43E1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:31:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-570836f1c79so143929a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694637074; x=1695241874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IruvCp7wp5R92eQW4msrJwWXirSuqIhpelb+f6ev20=;
        b=J0Q3GPfe8b6G9voiwpbTdO9J/pjvGr2ecJAJAqrGN/ALTXrq0FyeIz0JJ2kMgMJGRM
         9y3EMU2kMVdx8W4YZm0Bl67Ke0QPkpZD07E9IMsRlhEHQeYPKbUZqsxaUZDspas39BPg
         F74FrxFOfmHBCcf/AH7fl0iMefbXMNvxL5gMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694637074; x=1695241874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IruvCp7wp5R92eQW4msrJwWXirSuqIhpelb+f6ev20=;
        b=gyX+eX+J63uQ8RSpTgvPq9LL+wnHGmjj8smYfLk6WY5FBD7185vBMp2L1ALwY8BXhX
         RXR4/dm4eOzW6NBBk8QUHlTs0cLBICU6Dl1dxlngpXotP8azvW0354de+sbCgCVhzZOK
         O9QpNWr4fjwjNPLEP+Jh5+aruqdW+n+ExySM7fwlVtfO0N9VbgyMdug1q/wZY4INx0DT
         t7i35F/vL5UeOg5gSCjkInqeLUmPtrgt8iyj102pR0f6Cy4z9jrCQ4DFz92YidzCWso1
         K88eGBe9H9AP6fwMyp0OXIUjo2f6kg6PN4kEuQVevY4DASVwSNh1nyTDJuEwsvzcwL8V
         EaoA==
X-Gm-Message-State: AOJu0Yx/Z2/4KH3RF2tQ8ZHZ8smycv8iADklr1TFhBjJCEqY82shmB3m
        tmJpcuhHJq4X+KuJ4zm5MplFZQ==
X-Google-Smtp-Source: AGHT+IGrroCbvJyS5XOoog5UqhUAoS6N1655uh0h/DoAeMUPZp6oAQ5Kb2ogXIIDTyk15/OMj6C0ig==
X-Received: by 2002:a05:6a21:789c:b0:153:39d9:56fe with SMTP id bf28-20020a056a21789c00b0015339d956femr4244092pzc.47.1694637073727;
        Wed, 13 Sep 2023 13:31:13 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:93b7:d435:bb08:332b])
        by smtp.gmail.com with UTF8SMTPSA id i2-20020a170902c94200b001b81a97860asm38860pla.27.2023.09.13.13.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 13:31:12 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:31:09 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Matthew Wang <matthewmwang@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix oob check condition in
 mwifiex_process_rx_packet
Message-ID: <ZQIcDWKrmgoPkwlN@google.com>
References: <20230908104308.1546501-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908104308.1546501-1-treapking@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 06:41:12PM +0800, Pin-yen Lin wrote:
> Only skip the code path trying to access the rfc1042 headers when the
> buffer is too small, so the driver can still process packets without
> rfc1042 headers.
> 
> Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when rx packets")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

I'd appreciate another review/test from one of the others here
(Matthew?), even though I know y'all are already working together.

> ---
> 
> Changes in v3:
> - Really apply the sizeof call fix as it was missed in the previous patch
> 
> Changes in v2:
> - Fix sizeof call (sizeof(rx_pkt_hdr) --> sizeof(*rx_pkt_hdr))
> 
>  drivers/net/wireless/marvell/mwifiex/sta_rx.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> index 65420ad67416..257737137cd7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> @@ -86,7 +86,8 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
>  	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
>  	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
>  
> -	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
> +	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
> +	    rx_pkt_off > skb->len) {
>  		mwifiex_dbg(priv->adapter, ERROR,
>  			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
>  			    skb->len, rx_pkt_off);
> @@ -95,12 +96,13 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
>  		return -1;
>  	}
>  
> -	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> -		     sizeof(bridge_tunnel_header))) ||
> -	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> -		     sizeof(rfc1042_header)) &&
> -	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
> -	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
> +	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&

Are you sure you want this length check to fall back to the non-802.3
codepath? Isn't it an error to look like an 802.3 frame but to be too
small? I'd think we want to drop such packets, not process them as-is.

If I'm correct, then this check should move inside the 'if' branch of
this if/else.

Brian

> +	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> +		      sizeof(bridge_tunnel_header))) ||
> +	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> +		      sizeof(rfc1042_header)) &&
> +	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
> +	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX))) {
>  		/*
>  		 *  Replace the 803 header and rfc1042 header (llc/snap) with an
>  		 *    EthernetII header, keep the src/dst and snap_type
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 
