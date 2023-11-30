Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0057FF7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345811AbjK3RFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3RFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:05:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7A610D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:05:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338B1C433C8;
        Thu, 30 Nov 2023 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701363910;
        bh=RzSKagrT+3ey649/vwouXJ0AF6xcU8DgN3n3RI/4R9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlikIAiZ77eoCBeIlQzItIdxQjiV+b12uuExG4flotNXT8cuMmfPWLyx5UUnYklte
         OGG4bJASBOXmpvtI3tuDqOYUoKwIwbCWQ7b8a6veFVz4ocY/KJmzHYJHQuZozE8+Pb
         WHogpEHylw1VQ/4NjKJg1RH4eRBddNWor7npy0BZbSds+OOBSbiwPXJoj4u77J40d9
         ZUjJ94E7/Mx98Diq6OQ4JFRw1CoKCBpPG2VTgzdUtbmjZ4sjZcoWrfYn5oD2rqRqt2
         Ptac8iz8+ApSJCNJr/kwb8GP5boq/hRrkEDAOzSbY9BPMey3tiJGHpJi9P0G8isjNB
         8+aLH8h1kuUnQ==
Date:   Thu, 30 Nov 2023 17:05:06 +0000
From:   Simon Horman <horms@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <20231130170506.GG32077@kernel.org>
References: <PH7PR03MB7064CC413965BFE5E005B273A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064CC413965BFE5E005B273A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:48:05PM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This change is for the PHC devices that can measure the phase offset
> between PHC signal and the external signal, such as the 1PPS signal of
> GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> the existing ptp_extts_event so that application such as ts2phc can
> poll the external offset the same way as extts. Hence, ts2phc can use
> the offset to achieve the alignment between PHC and the external signal
> by the help of either SW or HW filters.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

...

> @@ -228,7 +230,10 @@ struct ptp_pin_desc {
>  #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
>  
>  struct ptp_extts_event {
> -	struct ptp_clock_time t; /* Time event occured. */
> +	union {
> +		struct ptp_clock_time t; /* Time event occured. */
> +		__s64 offset_ns;         /* Offset event occured */
> +	};

Hi Min Li,

if you end up respinning this patch, please consider correcting
the spelling of occurred.

>  	unsigned int index;      /* Which channel produced the event. */
>  	unsigned int flags;      /* Reserved for future use. */
>  	unsigned int rsv[2];     /* Reserved for future use. */
> -- 
> 2.39.2
> 
