Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5C7D259F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 21:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjJVTkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 15:40:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67329F2;
        Sun, 22 Oct 2023 12:39:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54041e33845so766467a12.3;
        Sun, 22 Oct 2023 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698003596; x=1698608396; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjC8Y/pab1L2l+rQYaE4Wv4U+6siS+n8WEbIoYjl9EE=;
        b=isESi4p3o6WWWMEuIxMU3XECqadMVlsJPxF9AFbtkoUQX4wn05bbcGdgsURbkUTKdA
         LesPwpe/26vvjIcYKHBedjB/z5carbm6eYXVLhL+Vwcj8/DC+LXKf3VIPY7tQc5vSflw
         tJ7uP4ej5HVFomP63vNWkUY72UH0WllZnTS4/AUisBIxucxNuHYFx/9NNHCSpn8gM5dY
         hQRkPdNaH7C0gNijknty0qWrwiMUQ7No3ofqEKVEiDCkQ4IvUMhJKwsD+oyMr/F4i+C7
         pfY35pQK3r69BfMyB+4p15BexUXACs0yLLoR/UNuUQhgRMg/Ij+cxFYDrr5JkClVBKcg
         BSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698003596; x=1698608396;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjC8Y/pab1L2l+rQYaE4Wv4U+6siS+n8WEbIoYjl9EE=;
        b=dGDhvAT97cq99aqel8X3Zybx57DKmSZPy6SQejryyb3hplM+JpERERVDpk95g9o5VD
         YJR12SNnb8XYJN17ryMr6pf5Rxt48lZJtyPGCePBW3//j+ufNDe9Ff51Pxa5lhY3s9CO
         jM9HWsSXtWYacCPctHFiZe2lQ2527ZavPqFnFtfR32/hSLCU6Jx7QOK9Y3wXZpjyel12
         a/7pfKXEGnQikT9SXm59CZ09I/X7E48OHlH34+lxmrwfly1qFdDiwF6Qy8Q1oUQKxm/r
         dWgF1eJQARh2+JGPWo6E6ouEA6dJzHZE6gQ732auUhwJg4fM2mXNdKeziZWCOcWmS+SX
         7kaw==
X-Gm-Message-State: AOJu0YxKjSL9aT68WQziP5aet+vpXFT1QM3ZVXzxoIws+sMWS2/kqC8p
        4dUfxVoP4ml96AM57Fr+TCKYoQza+Q==
X-Google-Smtp-Source: AGHT+IFjmlS9mGTAgKE4sgcptpjUjCGSm8iAsiwbpIRFVysII3bzJ4jGnLYn8oxXyhO5axtnHISWBg==
X-Received: by 2002:a50:aacf:0:b0:53e:1388:cb2e with SMTP id r15-20020a50aacf000000b0053e1388cb2emr5144044edc.35.1698003596358;
        Sun, 22 Oct 2023 12:39:56 -0700 (PDT)
Received: from p183 ([46.53.251.94])
        by smtp.gmail.com with ESMTPSA id f9-20020aa7d849000000b0053e49302056sm5101480eds.64.2023.10.22.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 12:39:55 -0700 (PDT)
Date:   Sun, 22 Oct 2023 22:39:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@vger.kernel.org
Subject: PSA: BITS_TO_LONGS() most likely returns size_t, not what you think
Message-ID: <bc0958d7-385f-49b5-97e9-6355b29a2502@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote the following code today (don't ask):

	for (int i = 0; i <= BITS_TO_LONGS(NR_CPUS) - 2; i += 1) {	
	}

only to get near infinite loop. Note that NR_CPUS is "int".

This is because BITS_TO_LONGS() and __KERNEL_DIV_ROUND_UP() macros work
together to promote everything to "size_t". The loop essientially
becomes:

	for (int i = 0; i <= (size_t)-1; i += 1) {
	}

This is easily fixable by doing very sketchy and obvious thing.

--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -16,7 +16,7 @@
 #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
+#define BITS_PER_TYPE(type)	((int)sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))

Ideally __KERNEL_DIV_ROUND_UP() should return the type of the first
argument but this stuff is UAPI header which complicates things.
