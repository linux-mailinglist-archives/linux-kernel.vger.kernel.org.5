Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59457A1F70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjIONCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjIONCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:02:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52FF10E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:02:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502153ae36cso3402684e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1694782953; x=1695387753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6UZffakOMwph92nd+kWC1xMQkck4fFTNUb9ro2z14A=;
        b=Vav1nPGbT5GhyD7PHAGcSdmn+Hk0wFrIqM26hEPGFzQIxajzAo0BhikBve48ZtTpd5
         yIU3iUu6mWSKp/4Ifk/seAfMBqLE1VXcRMuLRrYWfoLuxfUOdYgowhdej2c9zp+UGno+
         LTn8Iibwa62xFDoHy0WE98HFPtldmgP8eH8GReW4TdOLru3nRjZ8SK0r7WHwlYT7fttv
         lWRL+QLbksfz7o4Ta2TpnRaQRe6SJtY+bBvJr9/+bSjmq73zWc+V2LVGLfrP1L+IXb3S
         xRh8+YL7h8R06YOIm8esWJKWPOR4dy3ckTr+Qz/r3YDXNZGBgnO1THIa7c2RZdlNMtuS
         23/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782953; x=1695387753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6UZffakOMwph92nd+kWC1xMQkck4fFTNUb9ro2z14A=;
        b=d79P9xgV3GA/ihksxbRr6btfzbgsKzbYzcj6LsIzmKpVvzALqh5jkZqlsZ7Uvkd6bV
         SIIzvkDmZ5tBJ7EFDoyu6rnhJWlZwMJk13UbdPufbmAFw8kXsgNJaKmnhihmJHDlNXn6
         ModI7R35/22lAfb15K2sQ6iWjJle1SvIX3vKTh+lXW/+duszvzcVPtMvGwbpZTgOh0cr
         hTXfvH+VLH36uhrdSyC04L3BVHpsMqgV5Wd+66Uch7746o/qPhYMvn3ZQktv7T2N3OVj
         LCXFU/pURnx43Yu2t7oQp8G1gpSnw9FSJ46q9hgRahcF1BLF7gjzU29ZCZzWugHY8FfC
         Qhjw==
X-Gm-Message-State: AOJu0YwzAHklCNTX5aQucN+na2RoZ1/aQAH6Ryq9Qk5IfMaG0+sS8QBI
        7o1YdOx+r0/+1hGshQBSrjs4Cw==
X-Google-Smtp-Source: AGHT+IGjPyu7jb40b9QIC9voQV7XmcSDtVJwj9b+6ctkxoJV4zNkFeT6teRxdaReR4z9TzYi2xuDwA==
X-Received: by 2002:a05:6512:3b21:b0:4fe:a2c:24b0 with SMTP id f33-20020a0565123b2100b004fe0a2c24b0mr1776729lfv.26.1694782952704;
        Fri, 15 Sep 2023 06:02:32 -0700 (PDT)
Received: from dwr-latitude-5400.. ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id a15-20020a19f80f000000b004fe37339f8esm634600lff.149.2023.09.15.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 06:02:32 -0700 (PDT)
From:   David Wretman <david.wretman@ferroamp.se>
To:     parthiban.veerasooran@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Thorsten.Kummermehr@microchip.com,
        UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com,
        andrew@lunn.ch, casper.casan@gmail.com, conor+dt@kernel.org,
        corbet@lwn.net, davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, horatiu.vultur@microchip.com,
        horms@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, rdunlap@infradead.org, robh+dt@kernel.org,
        steen.hegelund@microchip.com,
        David Wretman <david.wretman@ferroamp.se>
Subject: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support for Microchip's LAN865X MACPHY
Date:   Fri, 15 Sep 2023 15:01:19 +0200
Message-Id: <20230915130118.927821-1-david.wretman@ferroamp.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
References: <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
On Fri, Sep 08, 2023 at 07:59:18PM +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE‑T1x
> MAC‑PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
> 
> By default, the chunk data payload is 64 bytes in size. A smaller payload
> data size of 32 bytes is also supported and may be configured in the
> Chunk Payload Size (CPS) field of the Configuration 0 (OA_CONFIG0)
> register. Changing the chunk payload size requires the LAN8650/1 be reset
> and shall not be done during normal operation.
> 
> The Ethernet Media Access Controller (MAC) module implements a 10 Mbps
> half duplex Ethernet MAC, compatible with the IEEE 802.3 standard.
> 10BASE-T1S physical layer transceiver integrated into the LAN8650/1. The
> PHY and MAC are connected via an internal Media Independent Interface
> (MII).
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Hi Parthiban,

Thanks for these patches.

One thing I am missing is settings for PLCA parameters. I feel that the
driver is a bit lacking as long as this is missing.

Adding support for the ethtool plca options would make this much more
complete.

Regards,
David

