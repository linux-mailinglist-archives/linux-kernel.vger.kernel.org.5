Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFF8771053
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHEPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:04:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015CA4;
        Sat,  5 Aug 2023 08:04:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb91c20602so6523425ad.0;
        Sat, 05 Aug 2023 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691247880; x=1691852680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytrMVlVv1UK/Az0eboWXoW3oWMRE9Ry5HZu9EP4O7Hk=;
        b=Mk+wLubbtaR1qwT8sRDFUvnGC6q178WVxAnUzZsXJqb78Bi7HyfLQv37e9+cNYgtfe
         MQvhVW1w9wG3pNf4iVnRViD6V/Mp8AnkEDNpASleivqmUYhIGhJpXanqfrXnkYmH4UkV
         Z2yHlUV1PM3SllRDNxjkTCraMkCryDBud3mNwFmocYm4pJPzqEP5n9/f3GHoM7Vniqar
         Q4xrpQDPfaXefIboS0GHi0BJ/79Le7cHAmeaRjyEPJLEySe48L5MUbzRO44rI+usXfNE
         qJVZhx5e3aSLKKKtUdKrWrKZZgtoCXVv2WE/SE6BSueIAFzmL6a4pRD+DJWqZWssDr6p
         NOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691247880; x=1691852680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytrMVlVv1UK/Az0eboWXoW3oWMRE9Ry5HZu9EP4O7Hk=;
        b=Kyo8Uzoon51Jy8iK2wGCnnosMRENlbocv39ORUNzFpIexuC0KHsO5t/td1GbmJMuBB
         PTrCsylj+phq+WTSNqQDWVglUncnEabMmnceds4JNPPiYKp5qx0DExpRvrsOlxx6yNDS
         vK+NhJeNbswGKnX909faieT4+ZV80Tu7FGZb9W/rtjVHix7NeqAlAocb4vjQBzvS3FIx
         7KLN3oBMltmj89TbdVcOM33msRpsdUgZpOh5EqD35J/fiOrt1kPpOdVvZJcreJVIVuep
         6ytoAtXmtl2Z8BmrE9J0fHT6m2xECzjFYYkbWHkHyTEvkqCi4lU0M2Qaa5GfPZlHi8dF
         HoXQ==
X-Gm-Message-State: AOJu0Yz6jzVx2Ezm7izF2jHAQ5mtwkVhrJ0GNbMAhAKKlv74Ps1xffah
        S1aeXoJeqyER+R3arp9L7FM=
X-Google-Smtp-Source: AGHT+IF82ItI3skCFLQdfd5ecBJpcyON+saJ/4iH20OqWKlhvzIiHpi4OFMsVyx/ucee9F5mPKGlig==
X-Received: by 2002:a05:6a20:8e19:b0:140:5067:84b3 with SMTP id y25-20020a056a208e1900b00140506784b3mr2213271pzj.0.1691247880108;
        Sat, 05 Aug 2023 08:04:40 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b006870ccfbb54sm3263234pfh.196.2023.08.05.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 08:04:39 -0700 (PDT)
Date:   Sat, 5 Aug 2023 08:04:36 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Zink <j.zink@pengutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Kurt Kanzenbach <kurt@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
Message-ID: <ZM5lBG+eXG9WukOV@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
 <20230804132403.4d9209de@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804132403.4d9209de@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 01:24:03PM -0700, Jakub Kicinski wrote:

> Richard? Sure would be nice to have an official ack from you on this
> one so I don't have to revert it again ;)

No objections to this version, as the correction is behind a feature
flag that is opt-in per device flavor.

Thanks,
Richard
