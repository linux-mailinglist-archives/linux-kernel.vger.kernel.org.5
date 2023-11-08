Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFC47E59E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKHPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjKHPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:19:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5C1BE6;
        Wed,  8 Nov 2023 07:19:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso314100166b.0;
        Wed, 08 Nov 2023 07:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699456780; x=1700061580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYNVo9ibeelXZMFCx2bih7YcjMCRn9oc8F4dU6CJcZw=;
        b=AcPLLxj1yi+RcFRYsUMVXCFz6cF1s++Jad6LbbxGA0KMV54iUliQEaARCmqJcnoycb
         MLnkivNnFbau3KtUwer4BUAKkOVCu0VoNDJiFAXvG64pXQ+MkDXrfGvOe3q4lgFCkYpG
         C6omoO1oiGfXXTvb44DWfEkw8hv8VxeQe7FtUqn/V9pYof78qmX2Avg23cv7IIA+Q+rX
         rMgIRixoDL7uEDmKsUgGWCIdgI2lUlmOZ8MfZb8f43JKpUHiVjhz70QFhsr/2xtTm+8g
         56xm0XyAm6ctYHOJp1Wv7Xm+2/7cmWjWJylEW5H2ftn60abYVAl73PYyr//faa78HRyC
         igZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456780; x=1700061580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYNVo9ibeelXZMFCx2bih7YcjMCRn9oc8F4dU6CJcZw=;
        b=nbycQgj0KI+XU0OpnkAxQFVF/+eQVUsMfWr5MeE86mGaKm4JeKXubaL6trxv3Vr62I
         sHxABrff5rO90jZD8rfRAa15veJTYCV6YrSwy5yGmXwebsxYeNbnz7GG/4sMTDIli6lc
         flVclBrH3DJCudCEit2kv3QaPiwDR+jdkPx5WIlW7yXpLnd1ni9+v1X+0C1rrEseZTc/
         CqilWA6aDdFy1iBU7V50mCvTBjTfCoTrf2FSQwbNalFveInxDeOHPpRcGmRdEd/ZvxJF
         EFYEJ+M1nr14foe3HUXXhV8IUkraKjM6nIdA4depSPjfqS1z8AklcIwykOVLtVctD8wp
         so7w==
X-Gm-Message-State: AOJu0YysRApDmNuk2a850aQ/wh/Xht0pZQrxQCzjybpv5sbkN8xadQ/x
        ZIKlDOf4B90Ve0qIN13+wyY=
X-Google-Smtp-Source: AGHT+IGsTV4eYFd+IyDPEhPcw+Ng23LK8rz1I1gklG/eo0ESwFqDvCLgNYk6DOddqjRMjGrBBufATQ==
X-Received: by 2002:a17:906:fe45:b0:9be:2469:bdf5 with SMTP id wz5-20020a170906fe4500b009be2469bdf5mr1720133ejb.15.1699456779981;
        Wed, 08 Nov 2023 07:19:39 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906125400b009928b4e3b9fsm1186061eja.114.2023.11.08.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:19:39 -0800 (PST)
Date:   Wed, 8 Nov 2023 17:19:37 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 4/4] net: ethernet: cortina: Checksum only TCP and
 UDP
Message-ID: <20231108151937.uf3ui4z6vy3i2uhu@skbuf>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
 <20231107-gemini-largeframe-fix-v3-4-e3803c080b75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-gemini-largeframe-fix-v3-4-e3803c080b75@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:54:29AM +0100, Linus Walleij wrote:
> It is a bit odd that frames that are neither TCP or UDP
> (such as ICMP or ARP) are still sent to the checksumming
> engine, where they are clearly just ignored.
> 
> Rewrite the logic slightly so that we first check if the
> frame is TCP or UDP, in that case bypass the checksum
> engine.
> 
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

If this patch doesn't fix anything and isn't a dependency for anything,
it shouldn't be present in a series targeted for "net". And anyway, I
think it's not needed in general after the discussion on v2.
