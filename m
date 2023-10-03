Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F47B6F24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbjJCQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbjJCQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:58:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A1D7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:58:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso909601b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696352314; x=1696957114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB+S1YCmVNYqbqAQ+T3/ufqEOj65Grfc2veRvmhXV5E=;
        b=A7k4esaBepFg9Ms+jKEKL/+s/kFhoNew3h8xjX8SUh2uq2oh4rlpJ/IS0EqijK6h/4
         XYzBxNeqc6tmm+GFiP+DPgvKSuD3BGqK2eiNQSdAY/jLyEyJ3rCCbQv3xsTlTZXkV9or
         ENDAadaF1k2ZZB0yqOTTilxMJcO8Lj1bVLPAmFgOlJmb+4ABlLZXxVZf9oqy0+fdHO4B
         URgaCpg5xVbp19bUezC2yZoZ+E41I3ZS9Wp83q56s/NTjXyhHF/VErODL42TKPFUagJv
         /x4u8NM+N0VREyhS3HhDkFqvrb9uA+/TfGOUc7iprkPp0ahFyZ/FZTq+vgrwSU+DWtqJ
         I9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352314; x=1696957114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB+S1YCmVNYqbqAQ+T3/ufqEOj65Grfc2veRvmhXV5E=;
        b=kF6O1PDr9qDqHJDkfjYzXcvx5bFLYzQIzD7Slm7oiZ2Fuhxau5utgo3VX2QEggh2JK
         J1XA2Kve/K/R+FMxzwMSdk9VLV3P1xdTmWHKUkOH2y2CBFtN92I6OPJ/4vgH+HsSeJ1r
         BB+lzGCoL4SQv6TeRJGC1cFm7/BrrZ3GvC4S73WPYpIjHUZFHgKJ6CBlM20UluRHRT6A
         Qm4pSl4k5qwTzAhop6JJUJ60oPuNcO7n0zfvTy+3uWWE2MUhBG/5cd42gdcB3Xe/H01V
         etkG6syBLo15r7yHrWIJAi2ieHjLyZfEoTeqEzODhoEoWCYNKJ/xsImpwnVjwNvZvh1m
         WNHw==
X-Gm-Message-State: AOJu0YzLVsRiCWeQFfprT6ZkVRKuwgIZ2zB8s8iLnzlSD2IT9eMC3ki4
        8N8+RaPzwrfiHX7TmUIydGek2w==
X-Google-Smtp-Source: AGHT+IHJTXVcg0erc8ScctpbfOr4hzSjMSi6Uc5LT6rdnqMehBDMTcjvTkv0ZK5e6iy2SR4qgnr9SQ==
X-Received: by 2002:a05:6a00:b84:b0:68c:49e4:bd71 with SMTP id g4-20020a056a000b8400b0068c49e4bd71mr137218pfj.34.1696352314477;
        Tue, 03 Oct 2023 09:58:34 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id j7-20020a62b607000000b0068bbd43a6e2sm1651877pff.10.2023.10.03.09.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:58:34 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:58:32 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Michael Pratt <mcpratt@protonmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rafal Milecki <zajec5@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Michael Pratt <mcpratt@pm.me>
Subject: Re: [PATCH 1/2] mac_pton: support MAC addresses with other
 delimiters
Message-ID: <20231003095832.2fce1e16@hermes.local>
In-Reply-To: <20231002233946.16703-2-mcpratt@protonmail.com>
References: <20231002233946.16703-1-mcpratt@protonmail.com>
        <20231002233946.16703-2-mcpratt@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 23:40:02 +0000
Michael Pratt <mcpratt@protonmail.com> wrote:

> From: Michael Pratt <mcpratt@pm.me>
> 
> Some network hardware vendors may do something unique
> when storing the MAC address into hardware in ASCII,
> like using hyphens as the delimiter.
> 
> Allow parsing of MAC addresses with a non-standard
> delimiter (punctuation other than a colon).
> 
> e.g. aa-bb-cc-dd-ee-ff
> 
> Signed-off-by: Michael Pratt <mcpratt@pm.me>
> ---
>  lib/net_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/net_utils.c b/lib/net_utils.c
> index 42bb0473fb22..ecb7625e1dec 100644
> --- a/lib/net_utils.c
> +++ b/lib/net_utils.c
> @@ -18,7 +18,7 @@ bool mac_pton(const char *s, u8 *mac)
>  	for (i = 0; i < ETH_ALEN; i++) {
>  		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
>  			return false;
> -		if (i != ETH_ALEN - 1 && s[i * 3 + 2] != ':')
> +		if (i != ETH_ALEN - 1 && !ispunct(s[i * 3 + 2]))

Having looked at same thing in DPDK already, this looks overly broad.
There are only two common formats in the standards (isn't it fun
when standards disagree). IETF uses colon separator and IEEE uses
hyphen separator. Linux convention is colon, and  Windows convention
is hyphen. There is also the old Cisco 3 part format with periods
but adding that makes no sense.

Also, it would be bad to allow bogus values where two different
types of punctuation are used.
