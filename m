Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448117C826C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJMJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjJMJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:45:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B395
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:45:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3A5C433C7;
        Fri, 13 Oct 2023 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697190307;
        bh=Kq+efvoffOt5jS47RsqUV97caihjUuG3Sct/ZpxjosI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvBkjMTqu+0f9BSQmHmmpZeFzeZ829jM2YqwDO6mpjFV5wUzUBfxWT9M2T/3lbKVO
         DzD0uvoO8NUQVc8ghd9v/W7ClKKhbTBgjWP0Sx873dh2VVmlwmWYvyXaoAX8to/4NK
         AkGfp5syn3N/TIepGZcaRDx8LmQF4QtYGMXZaQYZ4/nqIwrlOTHND17pCoc8R1BNfB
         62Y03uCDLZBL1NQAv4/c2Xm1XTzAQ5iimtZ5IJ+y8/QVkiFPYQVrTI24/6HawIotQG
         vZei8Wr5wu38PNNDcQC6qPiLxkOYQ19mOm46o33562ZrKnRHMqOiNUG/oWvS1GXa2u
         p7I/X4Pg/wHIA==
Date:   Fri, 13 Oct 2023 11:45:03 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: remove helper function
 prism2sta_inf_handover()
Message-ID: <20231013094503.6xnohuoivlysmlpp@zenone.zhora.eu>
References: <ZSkKux4LMgYiaNMx@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkKux4LMgYiaNMx@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Calvince,

...

> -/*
> - * prism2sta_inf_handover
> - *
> - * Handles the receipt of a Handover info frame. Should only be present
> - * in APs only.
> - *
> - * Arguments:
> - *	wlandev		wlan device structure
> - *	inf		ptr to info frame (contents in hfa384x order)
> - *
> - * Returns:
> - *	nothing
> - *
> - * Side effects:
> - *
> - * Call context:
> - *	interrupt
> - */
> -static void prism2sta_inf_handover(struct wlandevice *wlandev,
> -				   struct hfa384x_inf_frame *inf)
> -{
> -	pr_debug("received infoframe:HANDOVER (unhandled)\n");
> -}
> -
>  /*
>   * prism2sta_inf_tallies
>   *
> @@ -1724,7 +1697,7 @@ void prism2sta_ev_info(struct wlandevice *wlandev,
>  	/* Dispatch */
>  	switch (inf->infotype) {
>  	case HFA384x_IT_HANDOVERADDR:
> -		prism2sta_inf_handover(wlandev, inf);
> +		pr_debug("received infoframe:HANDOVER (unhandled)\n");

while I think the patch is correct, I believe you should take
this opportunity to use a better printing function. I am not a
network developer, but I believe network people would prefer
netdev_dbg() at this point.

The pr_*() family is one of the most generic printing method,
useful for debug and few other situations. Other printing
functions should be preferred because the provide more context.

Andi
