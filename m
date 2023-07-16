Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA3754E82
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGPLzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 07:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29667132;
        Sun, 16 Jul 2023 04:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A281360C86;
        Sun, 16 Jul 2023 11:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEC1C433C8;
        Sun, 16 Jul 2023 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689508539;
        bh=onrgGfezSZ78zkV6GkuuBBoVKrb8pSR1afTXmN0TJ3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wq7e4dOKQ1LcuxmWoNyPCsvQflML6pA4/VU59zX8ym43ANJ17t05MnRSQ7n781RtP
         BVv2eDLXgawyPls2svjRIYW+P4pew4FS8awr5bx/CnxbNCBU2JmIOIH2IoqmIgHhEL
         r69RSoNlJbTX6dkVENM9muWYcNfhBSGNvMIDsEPNqAZujn6T9mJjINb5wTzScj150m
         w73ZxpISQWmINZQWHfVVv6nF4Qd/an/am/fNET0y3iquk5iftZhj6J71IndMmWfD84
         8CFsPGBzjV6ZbkN+iLy8Su5996kyd/9Ve4XdlNUxgn6euUOTSCTGdTMSb+qfpNnCAm
         av670DaEcsNOA==
Date:   Sun, 16 Jul 2023 19:55:29 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued
 requests
Message-ID: <20230716115529.GA2529084@nchen-desktop>
References: <20230713081429.326660-1-pawell@cadence.com>
 <20230714021436.GA2520702@nchen-desktop>
 <BYAPR07MB5381BA3F7A34D18BC16B86DFDD34A@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB5381BA3F7A34D18BC16B86DFDD34A@BYAPR07MB5381.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-14 07:19:21, Pawel Laszczak wrote:
> >
> >On 23-07-13 04:14:29, Pawel Laszczak wrote:
> >> Gadget ACM while unloading module try to dequeue not queued usb
> >> request which causes the kernel to crash.
> >> Patch adds extra condition to check whether usb request is processed
> >> by CDNSP driver.
> >>
> >
> >Why ACM does that?

Would you please explain which situation triggers it?

> >
> >> cc: <stable@vger.kernel.org>
> >> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
> >> USBSSP DRD Driver")
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >>  drivers/usb/cdns3/cdnsp-gadget.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
> >> b/drivers/usb/cdns3/cdnsp-gadget.c
> >> index fff9ec9c391f..3a30c2af0c00 100644
> >> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> >> @@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct
> >usb_ep *ep,
> >>  	unsigned long flags;
> >>  	int ret;
> >>
> >> +	if (request->status != -EINPROGRESS)
> >> +		return 0;
> >> +
> >
> >Why not you use pending list which used at cdnsp_ep_enqueue to do this?
> 
> It's just simpler and faster way - no other reasons. 

Okay, get it.

-- 

Thanks,
Peter Chen
