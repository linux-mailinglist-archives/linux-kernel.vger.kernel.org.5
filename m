Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B937FDDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjK2RCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjK2RCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:02:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723E6BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:02:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so70855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701277338; x=1701882138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLapLfMiK02kYDh1bquJqUL8gsBXcNy1X+KHQGHXYD0=;
        b=wAb8pb0xsD//iIrmeWbbXmp2q9DzNfsuu/lcvy8xzxcNGgm1rSpIQY9pCQCSBrG5nQ
         rp0QwEpP/kteaC6dyvu7F26mTSmrs6itvFzrtGstmpWaQikLZf/EWtY2bf79v+xnXIbk
         cohBUH9Fp8XNxTJVZbEI9VLyE6iNlTyLVSLjjisUa0OZL905jR6Hp97HYPWL4BT82rxw
         j2S6AbmKDlGKp+WNDcZHRpjuGUaOMN2MIQdBobC4mL4xTBmFd57QLuKczRSRTVLpdXu9
         kTDc+xtvutNX5uPKkFw0tz6HJjxOcdaediU0qNDp8kSoNg3qtwG6NUx3rl9HV4S3Fbob
         LaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277338; x=1701882138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLapLfMiK02kYDh1bquJqUL8gsBXcNy1X+KHQGHXYD0=;
        b=ljyGZ93KuVoCpCxVcEhXfeiw8kzwxzA4ugzsMCs7nkS8N/J5ceqBVSyFCz0wBL5wWY
         Wtj1jsXrttizjxmYzBa+zrO8CRs9F+5SAbuYDvCvTTAcxic0/uluSHe6mZvgj8m4NcWr
         ZJ0ypWQh3l7wOM3sCAtWZEEpLXTKqJnWwK0LCNF8QA5Mu9MEvHchUREg4Ii3aQNtb3iO
         8GYMpbubBZfo7LknRTocsql+/h3HE/tVCh3Vad0aFgnZGYuEyCdqv7qSwuYK0mHSQ4Q4
         G1Houb52W61P5HslSGUN7ikSYGWuoDjHAUkksyX5FkpMxJKk+W5KW25qcemuX8tl/lps
         tFgA==
X-Gm-Message-State: AOJu0Yzh0Z5JG6O8dnkhforHVcW/vp7OLBdZF807UVvqQ0Vma1xlR5Uk
        9Fxpn9o2Hy4I92GLFX0TAeJm1j7CWi7nXBmu9hYYAg==
X-Google-Smtp-Source: AGHT+IFBkpteu493p6KGhPWnWumYPbA4E84jTO/ph6gkjrWloQemnVn+ZZ7IdYxics91NQxE3ePslWlS5OqrF/dxV1k=
X-Received: by 2002:a05:600c:3c83:b0:3f4:fb7:48d4 with SMTP id
 bg3-20020a05600c3c8300b003f40fb748d4mr949555wmb.3.1701277337573; Wed, 29 Nov
 2023 09:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-3-dima@arista.com>
In-Reply-To: <20231129165721.337302-3-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 18:02:03 +0100
Message-ID: <CANn89iLr53_W2183MU97Eqd9A4sZp7M_kEB79sLp+1pPa7pFcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] net/tcp: Consistently align TCP-AO option in the header
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Currently functions that pre-calculate TCP header options length use
> unaligned TCP-AO header + MAC-length for skb reservation.
> And the functions that actually write TCP-AO options into skb do align
> the header. Nothing good can come out of this for ((maclen % 4) !=3D 0).
>
> Provide tcp_ao_len_aligned() helper and use it everywhere for TCP
> header options space calculations.
>
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
