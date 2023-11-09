Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B637E688E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjKIKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjKIKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:42:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2506211F;
        Thu,  9 Nov 2023 02:42:40 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50906f941so9198471fa.2;
        Thu, 09 Nov 2023 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699526559; x=1700131359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ofd8O34EUlTjRikeujb0X36DMppVJw/V5XbFBobItA=;
        b=BGo4HDAXivF/dYPc9J2J+rsqDNcoa5K0cp+pjQ8RfuKWG4x0sP/dRtZSZjN5kAf3+q
         VoB3jDV6hyp4n5M8GkgHNj8/w5K3ZpTpOJPcabZ5HzB0M/Y3nURI78ECZ6uM3R6UrlxL
         Wng6vdzoyZZpbb15b9+cNbL9XyKoaTxx9uNSRLmKXfhD6/FL5RRdkQc67TkYkeCUXOU2
         FtxvU/jXgbqObLgeLFjO5xRxuBlBBVMnT3DJBONTRsIeRyZKhZ7e7Eea+z4YeBBwBx7S
         GVBwP7p9RXN7D7v24cdW8C8pZLRLYCrsXTjOJH/1sTv3ZzFVegsntnJLoUpS1hvNaqXP
         qCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526559; x=1700131359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ofd8O34EUlTjRikeujb0X36DMppVJw/V5XbFBobItA=;
        b=dGxvoOXLKJrr97q1Lr08H1zoiMH0jr6lrYG470E7yyEOD9Dj2/6CMi4fg01gkmy+Ng
         MM0U1ooH9o89JDk4pvOYdt862YxqfTj/Wx5hJtXp4FGfzT9uJK6hTsvxWAMdttxpif6j
         BDxCdByvBTyf+5s0NqkgU39OIHJsvEmC4yc3ULQ2cCYzPv3y8PW1HDWKPEXpA2xDYJ+o
         pYCrbRNzexXjwvFJ7XaXSoHsE8s5EdanHL8hWgCdaRSZkVzi4VFrGz3rD0SlKFzPlrEB
         g4AkBl0y6cXQ5T8XTJgyuTBH/wYiMdlI749/6MEFsPjXw6fLe8bkuyDyAQcGthWYmxpr
         vmlQ==
X-Gm-Message-State: AOJu0YwwrMtY+xk2hZJA89oU1wHd/8RMoaj/j+aWcrnQ2R9rjELeohHF
        9WpxK3Qph5+CgitTX5/j3cI=
X-Google-Smtp-Source: AGHT+IGswcYKr8YH/mXAiPahqJqYN3kPGqQey+K4c1pIPurlpXv1UY3V9guUiu34dyvwbdbHirBSyA==
X-Received: by 2002:a2e:9186:0:b0:2c6:f3cf:d7a3 with SMTP id f6-20020a2e9186000000b002c6f3cfd7a3mr801297ljg.36.1699526558871;
        Thu, 09 Nov 2023 02:42:38 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b0032da8fb0d05sm7078936wrs.110.2023.11.09.02.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:42:38 -0800 (PST)
Date:   Thu, 9 Nov 2023 12:42:36 +0200
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
Subject: Re: [PATCH net v4 1/3] net: ethernet: cortina: Fix max RX frame
 define
Message-ID: <20231109104236.hejzrczejzjflkwr@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
 <20231109-gemini-largeframe-fix-v4-1-6e611528db08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-gemini-largeframe-fix-v4-1-6e611528db08@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:03:12AM +0100, Linus Walleij wrote:
> Enumerator 3 is 1548 bytes according to the datasheet.
> Not 1542.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
