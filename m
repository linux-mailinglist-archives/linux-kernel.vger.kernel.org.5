Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541637C8B23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjJMQ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjJMQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:27:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D910A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:25:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c8a6aa0cd1so18726855ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697214339; x=1697819139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGsIQtn1kUOEPH/EyvUO5nXHmKVACT2hdgnYK7YYsf8=;
        b=MAlztth3RyslyF84xmcY5tfcU2AGBZQz5P3EreddPRY/Q5C5UVWkRn2zTXN5lWaJTX
         YHHlD4QJJ8S9yWL6lpmTOEUgIa2Q5SU4F6xj6nr5njiu6hPsPutyRulJNSwI9HcS6J55
         GJ/rqR6wp7Qc4BFqW6ZxwqvFH0Cl1cUKTem6DKFJS6HTgsQXy/OPNoBWPoUv4HOOpgo0
         UMe+XYg0Y3yuPP8V9Rtk6fUlNWQb3WSmeNygsKBoH0X6L/ovV7GknJaS4NV5CdyZCPfP
         MbODyDAz7pfHuYXMFxKF4xgj+K8Q9EAfkLnw5Tp9Aricbo4/PtLpsGQCL5HzE2HWb/ca
         AGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214339; x=1697819139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGsIQtn1kUOEPH/EyvUO5nXHmKVACT2hdgnYK7YYsf8=;
        b=qkL6mPpsJ+7igLBgG/7kALR8ZNOvYrC3wp4iRX/xo4lyG8ftCX76mLlamYbbL1kaFp
         p60/dSbil09U4vZpUuVx8jbRxRLoKmzE6YxwfxYdoBojrfgoRGwA+CnU2eVlIewynKt+
         WyeAaZzSPgTqcBj51+RCBlPJjl/1+/SGwTFWF3ieTxH0mpn7oZmNjDBclvwDWcF7hPtE
         rHf+PY4JAkXmsBkE5tS2ioHBUQhBxyyZgsDb+WTEcctY2F2rhO8Phsah73RIrKLQjrCG
         Ju7cpTRNYcGBPKq29eXpo7m2TuUp/PQu1U4Q1xcpN5vpqgOL4NVczYxLQGPeIDc0WEok
         EPvQ==
X-Gm-Message-State: AOJu0YzHWC6k5kv6Wl74tNd7nS5aH5n8rPNubMdDcQTCzwvXcMKHFLUF
        BQy2VHJ3TzgK2aYuMuO1M+EcSA==
X-Google-Smtp-Source: AGHT+IHpc/Tkf9Pt5e2oD3IFVvwS6bTXm6J3mOQbVyXxjR0oCfbQQ1e+XvWpuSp0soQAKko2C1ScUg==
X-Received: by 2002:a17:902:d2d1:b0:1ca:220:ce42 with SMTP id n17-20020a170902d2d100b001ca0220ce42mr2271443plc.37.1697214338684;
        Fri, 13 Oct 2023 09:25:38 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709028ecb00b001c3721897fcsm4025457plo.277.2023.10.13.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:25:38 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:25:36 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231013092536.09183d47@hermes.local>
In-Reply-To: <20231012231029.tqz3e5dnlvbmcmja@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
        <20231011222026.4181654-1-florian.fainelli@broadcom.com>
        <20231011222026.4181654-2-florian.fainelli@broadcom.com>
        <20231011222026.4181654-2-florian.fainelli@broadcom.com>
        <20231012231029.tqz3e5dnlvbmcmja@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Is there going to be a corresponding change to iproute2 devlink?
