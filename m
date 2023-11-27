Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05247FAD80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjK0Wdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjK0Wdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:33:47 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832421A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:33:52 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b37846373eso34039739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701124432; x=1701729232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRurvJBixT9EaPt149GqF23JO/Hj3FJOfl0g3s+cV30=;
        b=d/kZFQmSqL/CVbe8x/MUYwLDMONqAUs8YcXijkfvYPIRComGmCw4fXjT3b0M2Mcpb6
         Jr1ql3VL3wNfkJVVHplNgIWy/y1TrIaIaI0eg2RAFcZgKhCFpmAyAi5lLZW55OgQyOqx
         DGMVP6bc+Clb2lGACqMGopBdrVHyQUytYf6G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701124432; x=1701729232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRurvJBixT9EaPt149GqF23JO/Hj3FJOfl0g3s+cV30=;
        b=Or3+i5fcTGCSeMQ6IdYAxAb8ckTe9tNk2gh1fvDksFKH9Rk2X1rvG2nWyG6fYusJPx
         j3/UgWOpX0o0LeuH4iBLLRWRLR2hY4PKcNFoPYGJmg5pWH1QZcpqnT8nxdl25MsqRa6E
         CV7U2GEm8dFHOImFMUttUcY7V9gIPFgiBcxSfGN26O++YTQNqls7D4G9cgROi9kP76uP
         /aic/Tzp26wBwqLdfXtbDCI1ZjcgFs6sOjLx94hNbNAWdABf2M6WK7MSZLa8pRKWVzDj
         uiyJqfyowHtnT8GB4xt8mGCsMJTwkd0DtmDNePdNP64h6uRX1zBzmRpqZOL/nCr3eIOj
         gMrg==
X-Gm-Message-State: AOJu0YwhVKQxDYhWq68V6Qd+RKxpvE65fieI8GY9b31P9BuJZSI4O7dp
        59L38nkLem+LP79dWt4Cq4cH89VB9brb5eRaxFw=
X-Google-Smtp-Source: AGHT+IGh5IiXqi5dcw0tW55Z6m25NZgO5YspNsDlNPeNkzRHiMxeLfGiS5mMw/2e+Xpfx5UIOjXfjg==
X-Received: by 2002:a6b:7a07:0:b0:7b3:92ea:3438 with SMTP id h7-20020a6b7a07000000b007b392ea3438mr6812083iom.2.1701124431854;
        Mon, 27 Nov 2023 14:33:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id w30-20020a056638379e00b004665c3f56ebsm2579841jal.15.2023.11.27.14.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 14:33:51 -0800 (PST)
Message-ID: <b0ab598c-4303-449d-8a01-349e642d8c11@linuxfoundation.org>
Date:   Mon, 27 Nov 2023 15:33:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: Don't submit special requests twice
Content-Language: en-US
To:     Simon Holesch <simon@holesch.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231126234839.52434-1-simon@holesch.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231126234839.52434-1-simon@holesch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/23 16:48, Simon Holesch wrote:
> Even though submitting those requests twice should be harmless, there
> are USB devices that react poorly to some duplicated requests.
> 

The change looks good to me. I want to see the change explained in
the commit log. I see the information on why the change is needed.

Please add a bit more information on the change.

> One example is the ChipIdea controller implementation in U-Boot: The
> second SET_CONFIURATION request makes U-Boot disable and re-enable all
> endpoints. Re-enabling an endpoint in the ChipIdea controller, however,
> was broken until U-Boot commit b272c8792502 ("usb: ci: Fix gadget
> reinit").
> 
> Signed-off-by: Simon Holesch <simon@holesch.de>

thanks,
-- Shuah
