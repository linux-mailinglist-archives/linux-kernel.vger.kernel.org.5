Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F460799E98
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjIJOBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIJOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:01:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73903CC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 07:01:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467F1C433C8;
        Sun, 10 Sep 2023 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694354500;
        bh=4feami3dBSptyUGt9mIvJ79AWuoLTMKWWCgPgrZt3z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfDELed6MzYoBnaSAcTE7etwAsApCxpkWvitqBw5AuZz1FIkZUm4vOQJHTcbApFBq
         zp4F8GHEhwstnKStqq8WQKsX750DBHHQKXffhpR1fLYbRdU2vk2GdsEz/yy9yIYDDS
         vur+HGtA+os56SKO+hBwf9C2nlGqEMDU1iTSKMaB4jDDgEQCjJx7ZfeFgfqLH3/WS1
         bSHM+TdvrVcvMnyTwc61c6rgr4U6JP3WBXakJ5y+2jOlGdT7A9dkxPLvAhb7BU8U5I
         JTJt8PGUNf9BMuEDJyqeatNI0wHDkJ9GnP42M6Aw75x4q4we0nn8N3QXAkSp9kzDjb
         2HZghvgwVG+FA==
Date:   Sun, 10 Sep 2023 16:01:35 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sonia Sharma <sosha@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
        mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v4 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <20230910140135.GC775887@kernel.org>
References: <1694116607-24755-1-git-send-email-sosha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694116607-24755-1-git-send-email-sosha@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:56:47PM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> Fixes: 44144185951a0f ("hv_netvsc: Add validation for untrusted Hyper-V values")

As the current code is correct - it works - I feel that this is more of a
clean-up than a fix. As such I suggest dropping the fixes tag and
retargeting at net-next (which is due to re-open in the coming days).

> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> ---
> Changes in v3:
> * added return statement in default case as pointed by Michael Kelley.
> Changes in v4:
> * added fixes tag
> * modified commit message to explain the issue fixed by patch.
> ---
>  drivers/net/hyperv/netvsc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 82e9796c8f5e..0f7e4d377776 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -851,7 +851,7 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>  
>  	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -860,7 +860,7 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>  
>  	case NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -869,7 +869,7 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>  
>  	case NVSP_MSG5_TYPE_SUBCHANNEL:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -878,10 +878,6 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		/* Copy the response back */
> -		memcpy(&net_device->channel_init_pkt, nvsp_packet,
> -		       sizeof(struct nvsp_message));
> -		complete(&net_device->channel_init_wait);
>  		break;
>  
>  	case NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE:
> @@ -904,13 +900,19 @@ static void netvsc_send_completion(struct net_device *ndev,
>  
>  		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
>  					desc, budget);
> -		break;
> +		return;
>  
>  	default:
>  		netdev_err(ndev,
>  			   "Unknown send completion type %d received!!\n",
>  			   nvsp_packet->hdr.msg_type);
> +		return;
>  	}
> +
> +	/* Copy the response back */
> +	memcpy(&net_device->channel_init_pkt, nvsp_packet,
> +			sizeof(struct nvsp_message));

nit: the indentation of the line above is not correct.

	memcpy(&net_device->channel_init_pkt, nvsp_packet,
	       sizeof(struct nvsp_message));

> +	complete(&net_device->channel_init_wait);
>  }
>  
>  static u32 netvsc_get_next_send_section(struct netvsc_device *net_device)
> -- 
> 2.25.1
> 
> 
