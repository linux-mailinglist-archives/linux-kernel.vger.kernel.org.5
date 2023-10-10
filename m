Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9207C438F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJJWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJJWOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:14:10 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12368CA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:14:08 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3add37de892so3620026b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696976047; x=1697580847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6pbDms3RyM3jb2IaCSOLn/IpF6WKFJjPqGtzVU+4l4=;
        b=Fy/yEgEO+bIvd8a0IqHlkxbURxQN1CgpzIQn8eJtrWBMN7BG4o9JTcDEAa5ARSm8Sa
         hYLScaZxFPD7/MPBG4m/ZsuBj1KJwQnoq5pH7wjBhSL/sXs019iOmK6ooW6LsH/kvjAW
         g/f8nDgQspdiUGAuZCSE/a33AcpHMWzTKvRZlccJTOE3Y7WI1jkpv0kV7LG8WqQl8c1P
         qzGR8qbQKFT8ZAJcYDwCS9e+iCXFZsQ95QGreicNtYWQAu2wXBo9K1lRHCH3eDLDdPye
         Zg2eQ/6q4vb3C3Ji2lJQ493mkPEVXAYVrmpCawXbg3PSzyIbXZNQzL6JRUaqckAPAswJ
         TIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976047; x=1697580847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6pbDms3RyM3jb2IaCSOLn/IpF6WKFJjPqGtzVU+4l4=;
        b=wuySmhya7nbckhgzwXUjU8td4f26EVVoBLhCSXDzo8jRQbZr1JkmBUK3AT2zX3sjM9
         2MyjwNNiz7eFRgUL6yBHm73rFa66Gch3ycBJ8i2ei1TxxFkeghGcm6uA8aXgBbA0enQA
         lG2IkoMQ6KKdaFpZdx7zOUhpk1LuqbxCgxJA5pbo3I8LzbHg9TzOn4NHjlzKVnvfO08T
         pQrdVP9Ivlm6AuW45QkESvketq5c42wbIIOTEH9yWz5W2Rk3jPN/bOj34aro+JKNWFfd
         /UBA2nrjzn6o6XZuSFRYD6KwSwLx4tJwXCQTJ4Rsfr0MPyclRyFNx5XNUrATlmQH4e+E
         uNVg==
X-Gm-Message-State: AOJu0Yx/X5NwD6a9ZPWXUk7GGA66BSSLBXMUfO4o16kbB7qakugEsMwF
        v9Qx8bKFXEaFinY5xI4Jo7Hc3Q==
X-Google-Smtp-Source: AGHT+IH1hYMXf+bvS40ruI4BNBgGya+y5fS9x/ScDoNoNAahfc4HILbmE/RvuXRxlre06ZDlQm1XDw==
X-Received: by 2002:a05:6808:2a7b:b0:3a4:31c6:7650 with SMTP id fu27-20020a0568082a7b00b003a431c67650mr17782774oib.26.1696976047267;
        Tue, 10 Oct 2023 15:14:07 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id n18-20020a637212000000b0057e7ae47893sm10775059pgc.47.2023.10.10.15.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:14:06 -0700 (PDT)
Date:   Tue, 10 Oct 2023 15:14:04 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
        dsahern@kernel.org, ncardwell@google.com, ycheng@google.com,
        kuniyu@amazon.com, morleyd@google.com, mfreemon@cloudflare.com,
        mubashirq@google.com, linux-doc@vger.kernel.org, weiwan@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Message-ID: <20231010151404.3f7faa87@hermes.local>
In-Reply-To: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 12:23:30 -0700
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> TCP pingpong threshold is 1 by default. But some applications, like SQL DB
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
> 
> The pingpong threshold and related code were changed to 3 in the year
> 2019 in:
>   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> And reverted to 1 in the year 2022 in:
>   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> 
> There is no single value that fits all applications.
> Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> optimal performance based on the application needs.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

If this an application specific optimization, it should be in a socket option
rather than system wide via sysctl.
