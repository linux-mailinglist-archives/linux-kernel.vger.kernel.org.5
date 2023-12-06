Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB498076C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442709AbjLFRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379728AbjLFRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:39:14 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6328D47
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:39:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d08a924fcfso11285ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701884360; x=1702489160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epEPAoODqaSsyq6mWAsXlk/zwY3UQrTT5iMw4+zTkgU=;
        b=G7LjdyIBPxbsJPrlhEsc/+rcQEIDcADolRlDc0bxGGMoxV2At6voLXxW1WNg1sPigp
         ubDVSi4drL8F4IeGeN4cp7tKlL85UIPstQN+vSxODzRN8dQ/5WZeYyY4nqyPRkhxaVp8
         3Om4T3p9ZrfI93wQVBqlH1w0yigioBPPlVtUMpALHSKtioytu53GIcjsLQtr0fsQsmr3
         PxJCU90MYP02ZZ7aNCbhKM1/ju2pgzr+AEV7XqfNKMrW9PlvrgOPJQFJ/a4vrgOfpgd1
         sy6cORbKKk5h8ygo1blZd440qABNaIyhZJmZNNKk8Iu8d6r/wdcEK0uHFvynwOQs1WEs
         Souw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884360; x=1702489160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epEPAoODqaSsyq6mWAsXlk/zwY3UQrTT5iMw4+zTkgU=;
        b=mi/M2lA9ERVpyweqR9vhqvH6u/Z9ErhvQL8Ny09m86fbK/OQD9kPCLCDqyvtOwUTt6
         GrsCYQcvz9tVDXnsp2ZRjNWd9Spmy6iG7SBZHnE8MiSFRuIWBDj1KaJ8SL5b5MaVLvJo
         10ObycK5iA9P/pW1Y5zfnmUiQmJQmnM5SmfHWSTTMUEcO8djBzEIhUso/dnLlsJ4+04A
         B93Tz+/SLLjqjuxSL4F7PGjwPVrkIyot8uUO17K4ZMKNj/SqHlyT9V5Kh03KsrjQI54m
         0x3Tm9u+KkqvgIB5f4RbhIHPlKFPTNtA2i+W/P3Shwzjgv75+5doJfT6oDFyXmV2ezul
         UDSA==
X-Gm-Message-State: AOJu0YwzmvP8F90iTc7e3wbuW7JYh8r8Ow6D0gsfzXhJu3X97UG30JU6
        xxl8yczRyOK1MKP7fivFMbKPkA==
X-Google-Smtp-Source: AGHT+IGVTG9OQEKtoS6pjPpVNzMPWylYXwUA5I/GkMnBeOoLO3QQ7WcBm26jNLVY5AwA6U/sTaSzSg==
X-Received: by 2002:a17:902:8f8c:b0:1d0:6ffd:e2d7 with SMTP id z12-20020a1709028f8c00b001d06ffde2d7mr1069589plo.113.1701884360181;
        Wed, 06 Dec 2023 09:39:20 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001cff353696asm81396plx.302.2023.12.06.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:39:19 -0800 (PST)
Date:   Wed, 6 Dec 2023 09:39:17 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Message-ID: <20231206093917.04fd57b5@hermes.local>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Dec 2023 03:38:33 +0000
Judy Hsiao <judyhsiao@chromium.org> wrote:

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index df81c1f0a570..552719c3bbc3 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  {
>  	int max_clean = atomic_read(&tbl->gc_entries) -
>  			READ_ONCE(tbl->gc_thresh2);
> +	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
>  	unsigned long tref = jiffies - 5 * HZ;
>  	struct neighbour *n, *tmp;
>  	int shrunk = 0;
> +	int loop = 0;
>  
>  	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>  
> @@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  				shrunk++;
>  			if (shrunk >= max_clean)
>  				break;
> +			if (++loop == 16) {

Overall looks good.
Minor comments:
	- loop count should probably be unsigned
        - the magic constant 16 should be a sysctl tuneable
