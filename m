Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B626803CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjLDSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:19:16 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE946D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:19:22 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d626e4f79so1781275ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701713962; x=1702318762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBNv3IbWjBVpXKO0KWS/oZmgI8ueyLpWoqPSPTS7jmA=;
        b=aVw1RKlXrDKEN0YrryTeh/rTuxdOqB2pOzFua2DZTCVv5uAlE97wXwb9ko3uKAABoM
         gsHAzWccKhmMX2ze4YeMY19VPpB2ps/2blXMhQYSfGyfWHD0iERHRDLJZbYJ575CrWgE
         X1GprKRlB4PGgmceUMzrpmothSZwlBPYVmXKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713962; x=1702318762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBNv3IbWjBVpXKO0KWS/oZmgI8ueyLpWoqPSPTS7jmA=;
        b=MFB3NSs24gZIdqBWzVc1ZHWAc0TpqmbVCd/oZGUsM6R5siXpgkk7zxuDCxx3VFzI8z
         XSjazfst2vFd+MG+Cqk2YsfDJN2mwjyv/9+4pKQ7FDx+PjERa7fYbTKFSmFSbHLmsIqm
         gAnNl88BrRocbqZqeCUPeeF7/l7Yfl71Z3S97hhyktTGZzTuxoWqenkQXxGH0BiHdj3O
         8Z9d/9Mvwz2LKpMw8/byVMwc4vFqTeWCaQqYmakzW+XSRQELucszbHfET/J/kdSC5hK7
         xhOcOPzl6l7rvhjOFnOp6ddW62DTG7IMl+h9hTsLk9zCipGQm5I2LRLI1Qo9WsLOqIeq
         Kjvg==
X-Gm-Message-State: AOJu0YwcjcCxBWWFhefBt0K0blY9JOcHaubsIMuD2h9z8bRdHspsyyUy
        ERSouhXe7g3VAfVCgettIO67IQ==
X-Google-Smtp-Source: AGHT+IFMDZKhGaKgWVoGSb6Btx7wquC0v9+rJdeAZcJBVDCP41JQU98ri/DZPxY0fVPGXjqX0iOIYw==
X-Received: by 2002:a05:6e02:2167:b0:35d:4688:e9aa with SMTP id s7-20020a056e02216700b0035d4688e9aamr14115886ilv.1.1701713962134;
        Mon, 04 Dec 2023 10:19:22 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bg15-20020a056e02310f00b0035d30f0675csm51564ilb.5.2023.12.04.10.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:19:21 -0800 (PST)
Message-ID: <834f187e-a469-4457-b4fa-6a6eb0419ea8@linuxfoundation.org>
Date:   Mon, 4 Dec 2023 11:19:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usbip: Don't submit special requests twice
Content-Language: en-US
To:     Simon Holesch <simon@holesch.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231130231650.22410-1-simon@holesch.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231130231650.22410-1-simon@holesch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 16:10, Simon Holesch wrote:
> Skip submitting URBs, when identical requests were already sent in
> tweak_special_requests(). Instead call the completion handler directly
> to return the result of the URB.
> 
> Even though submitting those requests twice should be harmless, there
> are USB devices that react poorly to some duplicated requests.
> 
> One example is the ChipIdea controller implementation in U-Boot: The
> second SET_CONFIURATION request makes U-Boot disable and re-enable all
> endpoints. Re-enabling an endpoint in the ChipIdea controller, however,
> was broken until U-Boot commit b272c8792502 ("usb: ci: Fix gadget
> reinit").
> 
> Signed-off-by: Simon Holesch <simon@holesch.de>
> ---
> 
> Changes in v3:
> - handle errors in tweak_* routines: send URB if tweaking fails
> 
> Changes in v2:
> - explain change in commit message
> 
> Thanks again for the feedback!

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

