Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352D37C60BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjJKW6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJKW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:58:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36EC6;
        Wed, 11 Oct 2023 15:58:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79faf4210b2so15199539f.2;
        Wed, 11 Oct 2023 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697065106; x=1697669906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZjpywd39e3oUzQ981/tIhqY59XPDyM578u4zxzj7m4=;
        b=Q2uh7Eg0ZtUcY/fizL73ehXgE0zUfUHAxYKsBGX5dAGH0SKkLkB4BlROvS7UAXMyD/
         ejKILCULIa0J5a7WjWGEjrZ/X/MzCKyFYMMzWugPM7+RxMT7xIbzCRa34Ya1aAvR0adS
         z9qMIUV24qTBuAGmXKhXKsjjCou3cPBtdDyh2lmjc3DLLI9T0NbH/RNFWcs34E/ZMB0H
         EOCFpi3FQG/sUe05ApPJTxzcQsTUhqaj3X5atFo4hDkragXvu2ke602RelLSi+vrsjWP
         wc8GbjvjA8GstfocovL0UJGk4i7ZljDXUmZylLEKCRxTti9c0q/LaW6BjiLz4qd10HMn
         tYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065106; x=1697669906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZjpywd39e3oUzQ981/tIhqY59XPDyM578u4zxzj7m4=;
        b=GccfdM8KxcAxR6YUgiEf3ElCBTTZiEiVmaCAoQCoIiQISwQ7wBTthtGVUZhkz0mYkR
         Xp+6s4fQ150rA6Q/6oWiIufYEaLlkD9XCgFiNoboRzI00Vwt+C4zqq2xpgGDBxzQxgS0
         zXcUN10fTRhWlPAoOqWA4KeHHdBW4aFPkK++gIZe+NITDdU9HCVEXW0eSl6RI5qE+pLJ
         2VALLyopSn2l3J7yQpUmovZZFc6rXGIwOmf67kkRKcOqmBaab0FHiJqtWCsBK9G09fL5
         53YSq3XG72/YOFCHbR0nNPkbCDvWh61FxpqmeFKXk02w4rGTtySzo4pqJB3/6j29eSV8
         sCiA==
X-Gm-Message-State: AOJu0YxP/RCU91VYh4DUwNvUEG17URZy9oxW4Mv3/XbHhNBWPFE1CHjr
        O+WavF2NjTpG6mX12FBsf7A=
X-Google-Smtp-Source: AGHT+IGTV7EFyEohxnKdIIX6IqZ1yzIm0Y7yFYY9oW4EHhmC61OLh6EZN72xVZZe7msvNSr9f7v6Sg==
X-Received: by 2002:a6b:ec17:0:b0:791:7e14:4347 with SMTP id c23-20020a6bec17000000b007917e144347mr24932693ioh.13.1697065105881;
        Wed, 11 Oct 2023 15:58:25 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:fcdc:5119:7b2f:72b3])
        by smtp.gmail.com with ESMTPSA id dq15-20020a0566384d0f00b0043a1f6dc8d4sm3632691jab.4.2023.10.11.15.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:58:25 -0700 (PDT)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 0/3] Add initial devicetree for Turing RK1
Date:   Wed, 11 Oct 2023 16:58:20 -0600
Message-ID: <20231011225823.2542262-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again list,

This is the second version of my patch to bring in support for the RK3588-based
Turing RK1 SoM. In my previous cover letter, I perhaps should have specified
that the RK1 is a little bit unusual in that, though it *is* a true SoM, it is
targeted toward home-hosting/edge users directly as a compute node, and as a
result the vast majority of users will be seeing it more like a
micro-bladeserver, rather than an off-the-shelf part meant to power a larger
system. This was my rationale for previously sending this as a single .dts,
targeting that use case.

However, Heiko previously made a good point that it still depends on a carrier
board to be "complete," and then I reminded myself that not all users will be
treating the RK1 like a mere "node" -- some will be incorporating them into
larger carriers, which the RK1 is meant to enable (not the other way around).

This version tries to strike a compromise, by moving the SoM-specific stuff to
a .dtsi, introducing a .dts specifically for the "opinionated" view of the RK1
as a carrier-agnostic node, and adding another paragraph to the PATCH 3/3
changelog explaining that.

I am wondering if there will be an objection about the .dts having the exact
same base filename and `compatible` as the .dtsi. I am not sure what word/term
to use to mean "RK1 but thought of as the system itself and not as a piece of a
system," but am open to suggestions. :)

Cheers all,
Sam

Sam Edwards (3):
  dt-bindings: vendor-prefixes: add turing
  dt-bindings: arm: rockchip: Add Turing RK1
  arm64: dts: rockchip: Add Turing RK1 SoM support

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-turing-rk1.dts   |  21 +
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  | 623 ++++++++++++++++++
 5 files changed, 652 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi

-- 
2.41.0

