Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5806B7E80C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbjKJSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbjKJSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5282707A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:13:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso3005282a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699611182; x=1700215982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+mxjtMW/dfKr4kgC+G+KtOl9HaxfFELBQo/XvtL6sA=;
        b=z5qahyMFb+DiX7qHPyR2BpT2MQbDb8d9GWzT4dx+KUW4d8ex/lip61VN/mrWTWwWJw
         +ZgTPfPGyHzDcMpqAbLtwnqEFY6RxCtVGVr/8z8LSB+GATrGgQ6yEou4dt69ik+FVGgJ
         uRHLrNQttFXzXwL327NrZ+KhUf/fcCaVgtJMEWaJpm4uUaB/FdNlTsEcwmdtSn1a20mN
         1mNQAFk0gnZbhEDltVA54EiUP9Ga+sOzBcsqT43TCVS0WzOmgrGy5pHpWw3ZbdbJzm7n
         WA2GkAGTWhNotynsxkI0smkobGnengSV3wtzreYiqNS4uw0tYlqz6zleh/KNi7385M90
         O64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611182; x=1700215982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+mxjtMW/dfKr4kgC+G+KtOl9HaxfFELBQo/XvtL6sA=;
        b=i3WzgvsO7fmEuCWZ1E8yxWhM7F6+Vgv/4i4xGPqVVrZr0zn3A1oIfP7cvQemQ6KDcs
         WW6S5K1v5Sm9G/IDB7gUkRnZFcOL8iwWGBCM5SF8BFBG2rLGpnhxiSqgOZs75aYKS2MA
         dUeQ7zoqKyswDWsqx6MwTimUnNSCkYPB3BWXnYQDPTR0S86Lwp0Y8Xxk70DwlAYci5+9
         1aHZ4OaUKIo1wEcxilz7YqbZhH3lGBfX0gL8PInI7zu/vijpQItjVtsUr11lHyrDl6by
         D7aM7A6ISaSxmcS4/SkzUXvE/epcsy+Kl7v5AOJfvi5mkrAUVVWpVEJgOLRNskoMy2W1
         gWNA==
X-Gm-Message-State: AOJu0YyoSV9SRX2a+RXUbtKcEGSqCX5oEd4BiNJ10zVBDJM+oWc4O9gF
        /Uu5mgLmZCKG5ZsruZs4bvJDTA==
X-Google-Smtp-Source: AGHT+IEAuph3Sgu08/3NXxqkoU7KWFD18CdByptzoZMtFL6u0eCZP2+mIrfwdGlFmLCqhtqDF59obg==
X-Received: by 2002:a50:8e1b:0:b0:544:a213:a6fc with SMTP id 27-20020a508e1b000000b00544a213a6fcmr6912240edw.2.1699611181778;
        Fri, 10 Nov 2023 02:13:01 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v25-20020a50d599000000b0054353639161sm946774edi.89.2023.11.10.02.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:13:01 -0800 (PST)
Date:   Fri, 10 Nov 2023 11:13:00 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Brouer <jesper@cloudflare.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
Message-ID: <ZU4CLCk1APrD3Yzi@nanopsycho>
References: <ZU3EZKQ3dyLE6T8z@debian.debian>
 <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Nov 10, 2023 at 10:30:49AM CET, edumazet@google.com wrote:
>On Fri, Nov 10, 2023 at 6:49 AM Yan Zhai <yan@cloudflare.com> wrote:

[..]

>1) Note that net-next is currently closed.

I wonder, can't some bot be easily set up to warn about
this automatically?

