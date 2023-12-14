Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E521812DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443943AbjLNK50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443936AbjLNK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:57:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2911A5;
        Thu, 14 Dec 2023 02:56:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c495ab68cso8039605e9.0;
        Thu, 14 Dec 2023 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702551374; x=1703156174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HMfppTjCsAQlZ2a3fZBv4GPzszAAfnmigM/QHv3mPQ=;
        b=jTYrGmMSfaLXlBYl/j+QVUJAjraIfaPXuVyiu4/0RPBhowah1xIft5/S3EKqhadteg
         pssvoLa9xZ/Q/bIbw8SCP8UpJW//K4tBvQfBweSH8FePxrXTyjiByCCR41EPi71RdMmK
         i89BNT9sHjZA3n5GkKi1kYYhz6TMt5vSO1xAf6WPmhh7QavjLJYLtuVqtaumPR+4gcRk
         M7e012ayBOJyrnbsy2s78uN/eJXbSnTRpji+ir5UDJgpVxY1zlDCMEZYjzHL53Yq0tDX
         HwgrO3YjV7qPMMRy29xpHNRkPA7yuqB62EQjl5iYxvBVa51CDvtT8wczfrcM3fh48XJJ
         MWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551374; x=1703156174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HMfppTjCsAQlZ2a3fZBv4GPzszAAfnmigM/QHv3mPQ=;
        b=vVYHbWkfHF6AzIt0KEyckaykMeFT53cInVgVwOR8eSXOXwDOTpmfoUwRw/ANfsyHTB
         Qsw44v/6s0ljJj03TaA/ZlHpfniP9t6Qj1jw665U+zPybtUr0BnGSlV+xIIT+8vVKU/S
         VfTvLItneKUb5/Z7paIfSYOvAHlPSoALhyXvBbSs2gXsXY8qpg/TcMTQ5eugdeTkrosJ
         33Hy02WGjzDsRyWDp/0CWzzYoSyV5rO/cR4JTcinUmAlwJfSJyjpOnSf2pahrndQUcsc
         mPHVqUUjIA6APQOfSkcFUcAZOGEuAHxYHPzT+1dPY5ahWViA9s0YVwcm0+c+qjW98ccU
         SzZw==
X-Gm-Message-State: AOJu0Yx9geqhbduCeXu406rjFiPbOS/HMRzTZED4Cj5rKbjz6KvR/02v
        hYeGUKKhOYJc7dTxd6gRU40=
X-Google-Smtp-Source: AGHT+IFIdfKUeuoCGWCCHDyLxN0ccZ+HYFjDI1/L8FwKokS6fVxdoK9NrtDsArFArTpMzWMbzM5OFg==
X-Received: by 2002:a05:600c:1c86:b0:3fe:d637:7b25 with SMTP id k6-20020a05600c1c8600b003fed6377b25mr11633139wms.0.1702551373533;
        Thu, 14 Dec 2023 02:56:13 -0800 (PST)
Received: from [10.0.0.4] ([37.169.173.39])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bcd09000000b0040c26a459b4sm1163640wmj.0.2023.12.14.02.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 02:56:13 -0800 (PST)
Message-ID: <1a97421c-c1f3-4974-ac81-9bc1e224f797@gmail.com>
Date:   Thu, 14 Dec 2023 11:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Return error from sk_stream_wait_connect() if
 sk_wait_event() fails
To:     Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231214050922.3480023-1-syoshida@redhat.com>
Content-Language: en-US
From:   Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20231214050922.3480023-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/23 06:09, Shigeru Yoshida wrote:
> The following NULL pointer dereference issue occurred:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> <...>
> RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
> RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
> <...>
> Call Trace:
>   <TASK>
>   dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
>   inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x83/0xe0 net/socket.c:745
>   ____sys_sendmsg+0x443/0x510 net/socket.c:2558
>   ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
>   __sys_sendmsg+0xa6/0x120 net/socket.c:2641
>   __do_sys_sendmsg net/socket.c:2650 [inline]
>   __se_sys_sendmsg net/socket.c:2648 [inline]
>   __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
> socket waiting for the event. However, sk_stream_wait_connect() returns
> success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
> that waits for a connection with sk_stream_wait_connect() may misbehave.
>
> In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
> connection. If disconnect() is called in concurrently, the above issue
> occurs.
>
> This patch fixes the issue by returning error from sk_stream_wait_connect()
> if sk_wait_event() fails.
>
> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


