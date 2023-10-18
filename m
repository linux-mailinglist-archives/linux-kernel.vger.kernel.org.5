Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7507CE759
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJRTIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjJRTIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:08:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42BF11F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:08:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a29359c80bso59274539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697656082; x=1698260882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEDDXOwUBOTP0ob0yPcID6lS1qUx48BjXcmqRUbCC3Q=;
        b=WGbJ8L3Rl+jtKoPsUhVoxw9U2g8NQtg8V9iaudGEQ3gnDn6j9PW+TpKRQIhGBFYma9
         r6S1iiHcKRyNu1Zd+0IHesiyXRMaiCsFdHoisgCBrwyxXMaTqJ5cMdhRY4+dA2H9JC03
         fv8U1e0y9HTgRCgy8WWC9ZHUXNVDsGGPJKNEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656082; x=1698260882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEDDXOwUBOTP0ob0yPcID6lS1qUx48BjXcmqRUbCC3Q=;
        b=DNtGfc5adUE5yUXIXhCWdG8ColQOCjFrE58ICYggONmMZcdaFi9ZtQudgwXVCOlVEO
         dtQOIOzGPXEecInkmYdsyPoVTEuiKMZ2Mhn4n/dwJGfYbGUo4owRsaUyBLsk8ir+Pw/7
         cddbGjBWjPy4tRH4gxJF/moLmmfD56YD2eSt7D9pNwYjN3D4c0TjgIJf7+CGMixJI0iq
         ga3s8vpAXouFhFJmopvhoZU+68/wLRfZ+SF5fKonYwQMaJYP/IxjpxPJEc42UtxJrZyt
         6vMaHK7XkgtXgKbf58BeMHLwd5ZHHV3RxngrO2vSvvuDbQ7MwEVUytoCkfShc/Y2+6tu
         f4AQ==
X-Gm-Message-State: AOJu0Yz9x0ZJtk+TuXm2bmAxb9sM3ONUk0l6iwaUzp9Yk/CYwl6HiS94
        bUQW1W9ynA6fmZJz2djH7IFJIw==
X-Google-Smtp-Source: AGHT+IEb8K9JivIiDdJvTYkRWVcFRkSMFzysZi9fbNS8GC7PoRIcGsS4IE+VR539cbz5D00A4ZwqQQ==
X-Received: by 2002:a6b:671b:0:b0:7a5:cd6b:7581 with SMTP id b27-20020a6b671b000000b007a5cd6b7581mr203528ioc.2.1697656082045;
        Wed, 18 Oct 2023 12:08:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 9-20020a5d9c09000000b0079199e52035sm269584ioe.52.2023.10.18.12.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:08:00 -0700 (PDT)
Message-ID: <662a7ca4-beee-4ea3-b77e-4d5af1462f13@linuxfoundation.org>
Date:   Wed, 18 Oct 2023 13:08:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/efivarfs: create-read: fix a resource leak
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <2a96e3a8-48a5-46ae-9a0c-b5f2def0a257@linuxfoundation.org>
 <20231018015921.16890-1-zhujun2@cmss.chinamobile.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231018015921.16890-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 19:59, zhujun2 wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/efivarfs/create-read.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/efivarfs/create-read.c b/tools/testing/selftests/efivarfs/create-read.c
> index 9674a1939..7bc7af4eb 100644
> --- a/tools/testing/selftests/efivarfs/create-read.c
> +++ b/tools/testing/selftests/efivarfs/create-read.c
> @@ -32,8 +32,10 @@ int main(int argc, char **argv)
>   	rc = read(fd, buf, sizeof(buf));
>   	if (rc != 0) {
>   		fprintf(stderr, "Reading a new var should return EOF\n");
> +		close(fd);
>   		return EXIT_FAILURE;
>   	}
>   
> +	close(fd);
>   	return EXIT_SUCCESS;
>   }

Thank you. Applied to linux-kselftest next for Linux 6.7-c1.

thanks,
-- Shuah
