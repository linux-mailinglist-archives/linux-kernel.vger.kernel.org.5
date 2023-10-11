Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2E7C47AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbjJKCPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbjJKCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:15:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B8194
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:15:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690d8c05784so4946375b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696990545; x=1697595345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iECfGCpMxcwrOgs+tK/rI+0nJVijEyGocy239dFmGxw=;
        b=FOfsVGOyen6210JUZf6RoaLh4INK/xXaj5V0rJaAm02pRP6SfoPF9LhjkfH4KNaDMG
         y70mn9l7Gkk4LzK/WjeIxKgETTYRLt+IkOZIx9DsYj2pnEI9uuGj2NLLaZy03qIqcOI+
         F/4SZI7ImhLbJOgfLVVVaK6lixakD+4+zwQz5EoYeHLhAO/6vW+2fqD26xsiQzMZU4PK
         3udg3Usvl/HMo0shMJPW2fDDzuS3x5tc/g8P4VbwjvxsInHMDcrKJ3UFyzom6GWCYO3a
         aptnO4MiS+NmtpHpUm/alr/jyjiD2QoTIerc/pEKVlqxcI7cl5yEkC5yJK16+AmdXaHQ
         htyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696990545; x=1697595345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iECfGCpMxcwrOgs+tK/rI+0nJVijEyGocy239dFmGxw=;
        b=JLnj1KiG00O4NZLzawsTkDSWrSLfx3KZnpbiEueXJ/X1pohnH99VHLA5xDK6rqiCI5
         DZDJu/DLpJgzVEmAQ9vQ/zZQmyOom+sgtyU0Czd3xT0Mlb6fy531vyc/GMO35C7BAmyj
         CHpsAa8HUqZABqmir9hbXjW6iwjTE+szKFIIVWOh8B7PnhvSblLL/U9OTodIOAQJBEb+
         v0n3wP8KXUh2dKEwVtEc7smBFSintTeb1IFk7p/TEkUhFSql2h4MLG/R/Dvys4u0uKHI
         2HN19C+VWjqEQ1CcTgSLRUYANamFNNTq6fy/IqjDMrvDFUdsl8TmvS1sZWk/Y+R0Y31L
         SiNg==
X-Gm-Message-State: AOJu0Yyc36FWKR4gcdri17zSoDR4tPV0YJh/74bi460YKc0JQwDzOo2C
        Lh24Szk5wiAGecv7AA34rbid7A==
X-Google-Smtp-Source: AGHT+IHm97r7d3gBuXSWs26WG7XXCFQuF+p7rtRB/I0tH02ivL0P9H4FSQmQz0CNE9SoZk9IC3noqQ==
X-Received: by 2002:a05:6a00:3a16:b0:693:4143:5145 with SMTP id fj22-20020a056a003a1600b0069341435145mr20705305pfb.31.1696990545282;
        Tue, 10 Oct 2023 19:15:45 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b0068c90e1ec84sm8959795pfm.167.2023.10.10.19.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 19:15:44 -0700 (PDT)
Date:   Tue, 10 Oct 2023 19:15:42 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Yuchung Cheng <ycheng@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "morleyd@google.com" <morleyd@google.com>,
        "mfreemon@cloudflare.com" <mfreemon@cloudflare.com>,
        "mubashirq@google.com" <mubashirq@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "weiwan@google.com" <weiwan@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Message-ID: <20231010191542.3688fe24@hermes.local>
In-Reply-To: <PH7PR21MB3116FC142CAECCD5D981C530CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
        <20231010151404.3f7faa87@hermes.local>
        <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
        <PH7PR21MB3116FC142CAECCD5D981C530CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
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

On Tue, 10 Oct 2023 22:59:49 +0000
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> > > If this an application specific optimization, it should be in a socket option
> > > rather than system wide via sysctl.  
> > Initially I had a similar comment but later decided a sysctl could
> > still be useful if
> > 1) the entire host (e.g. virtual machine) is dedicated to that application
> > 2) that application is difficult to change  
> 
> Yes, the customer actually wants a global setting. But as suggested by Neal,
> I changed it to be per-namespace to match other TCP tunables.

Like congestion control choice, it could be both a sysctl and a socket option.
The reason is that delayed ack is already controlled by socket options.
