Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F857E0D32
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjKDCHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjKDCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:07:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD9D60;
        Fri,  3 Nov 2023 19:07:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A970C433C8;
        Sat,  4 Nov 2023 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699063659;
        bh=L6ks4yKT0/F+fOvkUaGIHPgT6JzQVMFwAqz5caY4KZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJUrnToOTQovPehLi9haOD6o6/5UCScaj5JM30hNFQItSwGi1w+nMogw1UJ/dJYpc
         ua3XgBh20btA8FNNcYLkjqecTFGkHFMrG0bs6JLz1Up7iX9f62geWyNSHBrE6iL1Zl
         uEgPkL2FyLym3rEwvNYaWzAVaIKSuYTXN3qSzukOQZ41rRUW5ZVmL01GxrE1ywBgQs
         gzknh1xRxRIcS0jDbi7PqRqcfJCD6q3az+h7frcHd4y9NeqEbYOWzEmOad84/06Fns
         h3OnLG5IEEok7PiPAzPDzkaIL4RZiyHzkTMlrRnObJESAbpscTKuRvWHu8izzYbW+G
         0TbNtB5ppbLJg==
Date:   Fri, 3 Nov 2023 22:07:38 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Helge Deller <deller@gmx.de>, daniel@ffwll.ch,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.5 34/52] fbdev: core: cfbcopyarea: fix sloppy
 typing
Message-ID: <ZUWnasfAphVCFPhR@sashalap>
References: <20231029225441.789781-1-sashal@kernel.org>
 <20231029225441.789781-34-sashal@kernel.org>
 <a93b7be2-a0a6-084d-47e6-a0e8fcd5bc2b@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a93b7be2-a0a6-084d-47e6-a0e8fcd5bc2b@omp.ru>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:39:14AM +0300, Sergey Shtylyov wrote:
>Hello!
>
>On 10/30/23 1:53 AM, Sasha Levin wrote:
>
>> From: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> [ Upstream commit 7f33df94cf0156f64eee9509bd9b4a178990f613 ]
>>
>> In cfb_copyarea(), the local variable bits_per_line is needlessly typed as
>> *unsigned long* -- which is a 32-bit type on the 32-bit arches and a 64-bit
>> type on the 64-bit arches; that variable's value is derived from the __u32
>> typed fb_fix_screeninfo::line_length field (multiplied by 8u) and a 32-bit
>> *unsigned int* type should still be enough to store the # of bits per line.
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/video/fbdev/core/cfbcopyarea.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/core/cfbcopyarea.c b/drivers/video/fbdev/core/cfbcopyarea.c
>> index 6d4bfeecee350..5b80bf3dae504 100644
>> --- a/drivers/video/fbdev/core/cfbcopyarea.c
>> +++ b/drivers/video/fbdev/core/cfbcopyarea.c
>> @@ -382,7 +382,7 @@ void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
>>  {
>>  	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
>>  	u32 height = area->height, width = area->width;
>> -	unsigned long const bits_per_line = p->fix.line_length*8u;
>> +	unsigned int const bits_per_line = p->fix.line_length * 8u;
>>  	unsigned long __iomem *base = NULL;
>>  	int bits = BITS_PER_LONG, bytes = bits >> 3;
>>  	unsigned dst_idx = 0, src_idx = 0, rev_copy = 0;
>
>   I highly doubt this is necessary to pull that into stable. This was
>intended to be a cleanup originally.

I'll drop this and the other one you've pointed out, thanks!

-- 
Thanks,
Sasha
