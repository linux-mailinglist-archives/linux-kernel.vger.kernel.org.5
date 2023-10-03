Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3C7B6B42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbjJCOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjJCOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:20:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC3A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:20:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673EDC433C8;
        Tue,  3 Oct 2023 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696342849;
        bh=kijvf7JbMse2Pa56drfQ4oD20Lx+m2oWU3VtMOZGsPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSgAGnbQfr7tHgoiwKO/rNA1dl/Zxqmh0lmh3HxZxe8HEsShwZy9yRL7Vu7TsUcI7
         GIwvAnwtlUHJt5YOLVp0kn2Q37A4g1GNVVSqQ1V0URKg0k0GAhFUnTIGw6tTwYe7cJ
         gUs1GFE3wzu5vyIEhvVrOhKGw0h9FD5DMnDQ3ypJhIXHnab7Cu0T8kAoQFjZ+183/Q
         Evnlvxy764/PuXtXIS42FdnS8ZjMOJ+WiVXc8Vh/teYch7gYVAMA8JW9wNZl0nbT5E
         wHSykFeXb8Dd21N/Z2QG7800lXgnH7hHmmxyt6hDpR2cfb7hGPPMmGIJnbvGq98LbM
         rWlW1ZMrarLvw==
Date:   Tue, 3 Oct 2023 16:20:45 +0200
From:   Simon Horman <horms@kernel.org>
To:     Mahesh Bandewar <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
Message-ID: <ZRwjPegND0V4jF6U@kernel.org>
References: <20231003041701.1745953-1-maheshb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003041701.1745953-1-maheshb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:17:01PM -0700, Mahesh Bandewar wrote:
> add support for TS sandwich of the user preferred timebase. The options
> supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
> and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
> 
> Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().
> 
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> CC: Richard Cochran <richardcochran@gmail.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> ---
>  include/linux/ptp_clock_kernel.h | 51 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/ptp_clock.h   |  7 +++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 1ef4e0f9bd2a..fd7be98e7bba 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -102,6 +102,15 @@ struct ptp_system_timestamp {
>   *               reading the lowest bits of the PHC timestamp and the second
>   *               reading immediately follows that.
>   *
> + * @gettimex64any:  Reads the current time from the hardware clock and
> +                 optionally also any of the MONO, MONO_RAW, or SYS clock.

nit: I think a '*' is needed on the line above.

> + *               parameter ts: Holds the PHC timestamp.
> + *               parameter sts: If not NULL, it holds a pair of timestamps from
> + *               the clock of choice. The first reading is made right before
> + *               reading the lowest bits of the PHC timestamp and the second
> + *               reading immediately follows that.
> + *               parameter type: any one of the TS opt from ptp_timestamp_types.
> + *
>   * @getcrosststamp:  Reads the current time from the hardware clock and
>   *                   system clock simultaneously.
>   *                   parameter cts: Contains timestamp (device,system) pair,

...
