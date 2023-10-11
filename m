Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18767C5906
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjJKQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjJKQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:20:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D764BAF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5855333fbadso4628019a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697041243; x=1697646043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9lJljhG7J0NRk5jXquLEzmz4kKiNkfUkpiLpvv0v7g=;
        b=H98WJaL5RfVoiaalQKFNSgD07kq9V2RvVV0fx+6MFZ2fwuvqP7ctj4r8HYXc0swock
         ruSVU0YrcEJdryMYf4joPZ8F078hcQz7vF8R2cVwCeyaHRGLEOK4290BQb3cfu5WXOYB
         WkZCM+kPzD0yeMQOYBs/J7NrAT8J+2kfGfaVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041243; x=1697646043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9lJljhG7J0NRk5jXquLEzmz4kKiNkfUkpiLpvv0v7g=;
        b=DvHOEEYDEcZ+mu0Jam7n3nfKkXn+bmZ6XV8cuXfccx3qHWSrd7vqUlnOZe/M2ZHK0/
         l9BiRgzS8crn1arQFpxmDwrV7zhWt2fylwuDDCYi8WXKyAzETNVhjWEFm/4yrwr0t9nm
         0cIG8ZWgxUHuJ1YeLskQSNxx5sY3hM04UOIkoCeqBMSwRL5vb226DH/3vj98iaTtCMs+
         lsN6+XTOEW/Qo7Ysx97U7jl4Sgmk23oZSJsdSopgZH4R6S12UpVutXOIHBu7VdljCWG9
         pSe0V79idNPeK4p+HVt7X9Xptrf2BX46ws3ZILaKQXm9R9XTyp0f+cNk/Qa/qygFtmpd
         zxDw==
X-Gm-Message-State: AOJu0YweZ5d0EPdkvJyKtO7uK/bJGtAwnJy1NAqHz2BVz7dezd8ICzdp
        aEUWLo3lSqW7wmKLtRh/jYfjZA==
X-Google-Smtp-Source: AGHT+IFBkkzjfqUFPw2LHU/WJiBG51hkvc97uk8G4hhO5uBiGO2zJPFVWSMOQulsb16+hJ+LUaknmw==
X-Received: by 2002:a17:90a:7541:b0:27c:eb7f:cd00 with SMTP id q59-20020a17090a754100b0027ceb7fcd00mr4432651pjk.22.1697041243325;
        Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b0027cf4c554dasm125627pja.11.2023.10.11.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:20:42 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:20:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
        davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: hci_sock: fix slab oob read in
 create_monitor_event
Message-ID: <202310110908.F2639D3276@keescook>
References: <000000000000ae9ff70607461186@google.com>
 <20231010053656.2034368-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010053656.2034368-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 01:36:57PM +0800, Edward AD wrote:
> When accessing hdev->name, the actual string length should prevail
> 
> Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
> Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  net/bluetooth/hci_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 5e4f718073b7..72abe54c45dd 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -488,7 +488,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
>  		ni->type = hdev->dev_type;
>  		ni->bus = hdev->bus;
>  		bacpy(&ni->bdaddr, &hdev->bdaddr);
> -		memcpy(ni->name, hdev->name, 8);
> +		memcpy(ni->name, hdev->name, strlen(hdev->name));

Uh, what's going on here?

hdev is:

struct hci_dev {
	...
        const char      *name;

ni is:

struct hci_mon_new_index {
        char            name[8];

You can't use "strlen" here in the case that "hdev->name" is larger than
8 bytes.

Also, why memcpy() and not strscpy()? Is this supposed to be padded out
with %NUL bytes? It appears to be sent over the network, so "yes" seems
to be the safe answer.

Should ni->name be always %NUL terminated? That I can't tell for sure,
but I assume "no", because the solution was to explicitly copy all the
bytes _except_ the %NUL byte (using strlen).

struct hci_mon_new_index's "name" should be marked __nonstring, and
instead strtomem_pad() should be used instead of memcpy.

-Kees

>  
>  		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
>  		break;
> -- 
> 2.25.1
> 

-- 
Kees Cook
