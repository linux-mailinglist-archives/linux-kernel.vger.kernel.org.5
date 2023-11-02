Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF247DEE9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjKBJGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjKBJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:06:01 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31AF137;
        Thu,  2 Nov 2023 02:05:56 -0700 (PDT)
Received: from [192.168.1.103] (178.176.78.246) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 2 Nov
 2023 12:05:46 +0300
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
To:     Piyush Mehta <piyush.mehta@amd.com>,
        <laurent.pinchart@ideasonboard.com>, <dan.scally@ideasonboard.com>,
        <michal.simek@amd.com>, <gregkh@linuxfoundation.org>
CC:     <siva.durga.prasad.paladugu@amd.com>,
        <radhey.shyam.pandey@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231102071138.828126-1-piyush.mehta@amd.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4661c898-2520-96b5-2f1c-8b013abd2a5c@omp.ru>
Date:   Thu, 2 Nov 2023 12:05:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231102071138.828126-1-piyush.mehta@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.246]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/02/2023 08:52:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181066 [Nov 02 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.246 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.246
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/02/2023 08:56:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/2/2023 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/2/23 10:11 AM, Piyush Mehta wrote:

> There could be chances where the usb_ep_queue() could fail and trigger
> complete() handler with error status. In this case, if usb_ep_queue()
> is called with lock held and the triggered complete() handler is waiting
> for the same lock to be cleared could result in a deadlock situation and
> could result in system hang. To aviod this scenerio, call usb_ep_queue()

   Scenario. :-)

> with lock removed. This patch does the same.

   The last sentence is hardly needed.

> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
>  drivers/usb/gadget/function/uvc_video.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 91af3b1ef0d4..0a5d9ac145e7 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -460,11 +460,12 @@ static void uvcg_video_pump(struct work_struct *work)
>  			req->no_interrupt = 1;
>  		}
>  
> -		/* Queue the USB request */
> -		ret = uvcg_video_ep_queue(video, req);
>  		spin_unlock_irqrestore(&queue->irqlock, flags);
>  
> +		/* Queue the USB request */
> +		ret = uvcg_video_ep_queue(video, req);
>  		if (ret < 0) {
> +			usb_ep_set_halt(video->ep);

   Hm, you don't say anything about this change in the patch
description...

[...]

MBR, Sergey
