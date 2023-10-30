Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD57DB54C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjJ3Ij3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3Ij1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:39:27 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E32BA7;
        Mon, 30 Oct 2023 01:39:24 -0700 (PDT)
Received: from [192.168.1.103] (178.176.73.57) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 30 Oct
 2023 11:39:14 +0300
Subject: Re: [PATCH AUTOSEL 6.5 34/52] fbdev: core: cfbcopyarea: fix sloppy
 typing
To:     Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC:     Helge Deller <deller@gmx.de>, <daniel@ffwll.ch>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20231029225441.789781-1-sashal@kernel.org>
 <20231029225441.789781-34-sashal@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a93b7be2-a0a6-084d-47e6-a0e8fcd5bc2b@omp.ru>
Date:   Mon, 30 Oct 2023 11:39:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231029225441.789781-34-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.73.57]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 10/30/2023 08:22:09
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 180967 [Oct 30 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.57 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.57 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.57
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/30/2023 08:27:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/30/2023 2:39:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/30/23 1:53 AM, Sasha Levin wrote:

> From: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [ Upstream commit 7f33df94cf0156f64eee9509bd9b4a178990f613 ]
> 
> In cfb_copyarea(), the local variable bits_per_line is needlessly typed as
> *unsigned long* -- which is a 32-bit type on the 32-bit arches and a 64-bit
> type on the 64-bit arches; that variable's value is derived from the __u32
> typed fb_fix_screeninfo::line_length field (multiplied by 8u) and a 32-bit
> *unsigned int* type should still be enough to store the # of bits per line.
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/video/fbdev/core/cfbcopyarea.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/cfbcopyarea.c b/drivers/video/fbdev/core/cfbcopyarea.c
> index 6d4bfeecee350..5b80bf3dae504 100644
> --- a/drivers/video/fbdev/core/cfbcopyarea.c
> +++ b/drivers/video/fbdev/core/cfbcopyarea.c
> @@ -382,7 +382,7 @@ void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
>  {
>  	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
>  	u32 height = area->height, width = area->width;
> -	unsigned long const bits_per_line = p->fix.line_length*8u;
> +	unsigned int const bits_per_line = p->fix.line_length * 8u;
>  	unsigned long __iomem *base = NULL;
>  	int bits = BITS_PER_LONG, bytes = bits >> 3;
>  	unsigned dst_idx = 0, src_idx = 0, rev_copy = 0;

   I highly doubt this is necessary to pull that into stable. This was
intended to be a cleanup originally.

MBR, Sergey
