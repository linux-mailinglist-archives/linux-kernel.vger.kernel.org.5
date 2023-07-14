Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACCC752F44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjGNCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjGNCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:14:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987826BA;
        Thu, 13 Jul 2023 19:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E7EB61BB2;
        Fri, 14 Jul 2023 02:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBB8C433C9;
        Fri, 14 Jul 2023 02:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689300886;
        bh=8Su4tH7Uf2tt1RV6zTUILrzWkPBhK4BHT0mVRJAQcJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDH6ud/gSUOK41K3v0rFH4a4fpC3iav2I462ewa6HLKUipoWl6sNi6NeIC5hPGEcC
         3WQPgXaVDYviIstLnH8GMndaqXNF6TZWul5EI+lR+vqJgIGaozHLTsDU3rBTGIpVDy
         PES2rpu90YlQVKMey+lnkvp0SvaXGBvP9iz1Bp46qQzTbnsskxu/RU2SMzDTqVjs1I
         djw2U01J2xKK8O21bCJKhlWym4anrGlYbe7Irm+KW3sGyVKjm0iS7hJjU5w0bMBP9x
         S80E5a9XZbxCMChvU/LwhII/kkr7Wj9cFGAzDQFSLhHkN2Evx12cXUjMYQGhLh2GK7
         3AFYBgrGal4vw==
Date:   Fri, 14 Jul 2023 10:14:36 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued
 requests
Message-ID: <20230714021436.GA2520702@nchen-desktop>
References: <20230713081429.326660-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713081429.326660-1-pawell@cadence.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-13 04:14:29, Pawel Laszczak wrote:
> Gadget ACM while unloading module try to dequeue not queued usb
> request which causes the kernel to crash.
> Patch adds extra condition to check whether usb request is processed
> by CDNSP driver.
> 

Why ACM does that?

> cc: <stable@vger.kernel.org>
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index fff9ec9c391f..3a30c2af0c00 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
>  	unsigned long flags;
>  	int ret;
> 
> +	if (request->status != -EINPROGRESS)
> +		return 0;
> +

Why not you use pending list which used at cdnsp_ep_enqueue to do this?


>  	if (!pep->endpoint.desc) {
>  		dev_err(pdev->dev,
>  			"%s: can't dequeue to disabled endpoint\n",
> -- 
> 2.37.2
> 

-- 

Thanks,
Peter Chen
