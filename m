Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1617E7756
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345707AbjKJCVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKJCVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:21:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491B3AA3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:21:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso13675105ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699582878; x=1700187678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaTGa+SUf84ch4ZcZ3FeTr2Ug86zQI09TtQ2s60CNrA=;
        b=XhKT1yXdM8p1jQfGh3Ma+EdHObpdTnF9gSp1H7tIh4LXGDvGtS00dA4Zqiwa5MgWz5
         Z+0FzWOhhj1nN2UP5NqnxqWAvabbLdW7uPYk3JXDIXy63AhQxgOXviy3vjU99J5xDGoa
         dmT1zJT/kMBz3R2gKy5U1R6gdryNG704Nn2s1Ca1mT7nQzLhbCObaDm4LlPpEHmY0NZ0
         uWMbPkabvy0BiMvnNdRG2vak4r18d8bRyg+bfAt7ca0W1RlC9DqBW5N/NVCUpnvGvcBw
         a98/uX9Vtrs1XGLedU/Rcarhu3gCrnKDIIGGrBaPluxB+SAe15Qfu934sCmlgt9sRfCh
         tkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582878; x=1700187678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaTGa+SUf84ch4ZcZ3FeTr2Ug86zQI09TtQ2s60CNrA=;
        b=HeUwcTFejsh9JhKfZygCl77ZFftCTg+194DxAYd7fP4PybqriQ3HwiYaWpozQCbKDH
         Q//Ld1naY3mL4aeUIKD3HNBg6UqWE5gTOCoIZdZsGKX41CVlj8kZYJAsMq7Omutc0rGM
         inT1c1T4GuAaWYyp88wBvR2QEng00teuqAnp3Vq9VqpXYC+Dc2TTNG355JBXhEhgUO3z
         IKREf68osTYMjZ/xKsE4hxSreV7Z/YXdnAQsVOGAgOnsaDUh4m7YCFpVoE++sIDzCzuy
         RM1cTqctD3nylbwVk2pv5IPA5VcOtTwREvlEIINWNhyRf1RN1tsUHItLQvps4J0eanSG
         U/0A==
X-Gm-Message-State: AOJu0Yw7eUX06ovBz0MQ3y4XRrorLseKSQfuXX+UgyaFo4IurQoe2N4t
        qWvNypZZIR1DBEKIHO5aGfgPd42ZmRgtpQ==
X-Google-Smtp-Source: AGHT+IF9rleX58cCwJ1kxuM8/mQfuYPi+HIuU2EQbYu8mHLhoqnO4fyviaZXkd03oV6G5KuHdWx05A==
X-Received: by 2002:a17:902:74c5:b0:1cc:6dd3:e73c with SMTP id f5-20020a17090274c500b001cc6dd3e73cmr6327165plt.49.1699582878011;
        Thu, 09 Nov 2023 18:21:18 -0800 (PST)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902eb0500b001c5fa48b9a0sm4174626plb.33.2023.11.09.18.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 18:21:17 -0800 (PST)
Date:   Thu, 9 Nov 2023 18:21:13 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] lib/find: optimize find_*_bit_wrap
Message-ID: <ZU2Tmav832NIeJQk@yury-ThinkPad>
References: <20231028190530.286300-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028190530.286300-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Sat, Oct 28, 2023 at 12:05:29PM -0700, Yury Norov wrote:
> When an offset is 0, there's no need to search a bitmap from the
> beginning after the 1st search failed, because each bit has already
> been tested.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/find.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5e4f39ef2e72..241b6d028eda 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -405,7 +405,7 @@ unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
>  {
>  	unsigned long bit = find_next_and_bit(addr1, addr2, size, offset);
>  
> -	if (bit < size)
> +	if (bit < size || offset == 0)
>  		return bit;
>  
>  	bit = find_first_and_bit(addr1, addr2, offset);
> @@ -427,7 +427,7 @@ unsigned long find_next_bit_wrap(const unsigned long *addr,
>  {
>  	unsigned long bit = find_next_bit(addr, size, offset);
>  
> -	if (bit < size)
> +	if (bit < size || offset == 0)
>  		return bit;
>  
>  	bit = find_first_bit(addr, offset);
> -- 
> 2.39.2
