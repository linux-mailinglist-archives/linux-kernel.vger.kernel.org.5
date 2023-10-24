Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF87D4D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjJXKTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjJXKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:19:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26AFAC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:19:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4081607b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698142749; x=1698747549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqO6g6+dHIfm5WicwZoijQGJjSQbfYTG3kfOYZFggB8=;
        b=fqQD3tpamQ8xRx16KWqnyhhyesq7hJIuEAK0zDJnYwtVA2f5Ku8l8UB0/eBN31rlMM
         P2mlG/HptRsniSV/A9XDaWMoG7QsozsNO3R0YYiG3C/XTq2TCYwhVt9zWTBHcK7s+YJr
         Kbd3NaYuxFyDnO6oo8Q768vVvzwEVOcpimAxn0Aa5oxkUGmaz+LMYMLIiBRyufQw2Ndc
         xum7MwSsRFJAz1pv0QTx3OTft9FufjPtfzpmMwnsldB/v40z9JMXQzH5Xcn7ql96Bldq
         m/0kNVJF0ywVIY+5tXtGl3kOVVVSaa/U6zbIvPaFqsmPie62R/XngO8fVS+XHOYD+GbH
         puhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698142749; x=1698747549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqO6g6+dHIfm5WicwZoijQGJjSQbfYTG3kfOYZFggB8=;
        b=Hc6Ftgjgm/OKdGbRG0qdrv2VcW4rh7mcNMuNzTG3Zwg04JqL4Wi1FdhJAJhS3y0zVl
         W0M3rDflwo35exUj1gJdjTKK3W2qaKpvfXXTflIxEimsmU+m1rS+OtALcbXbLL+70mx2
         9zr2Hm7s53KbGVpcgVngB5C9UeN7NJMvGh+8nf4/vdPMVI7O/YM8IZ1uVHPNbkCWHNb8
         B7OFoKnLn2/K7GSOOp09M1bnhuyloc8OVacUraNHZz0lKjqKQ9tya/L49D4jKG6Nfd5U
         6IIfqJjSL93qOo/OTssDVK6Rj4nCY07SCZWDRh+5ZTzmobxHpYOv2qMaNxncgHd6CFk5
         TmkA==
X-Gm-Message-State: AOJu0YzxP7wbjH5Ya4tGfMr+EU8oz41Ijf3EYrbBQV7cyvcHM26AZNOL
        I78LE/wj186LuGzTmuWTrI/lIQ==
X-Google-Smtp-Source: AGHT+IF0r5iIQe3b6PKgM/nbB6MiSvY8q/dd3Mr2AyfJDcmwP7NF+cbaTDwX8FZQiIbRRRIVtwjwTw==
X-Received: by 2002:a05:6a20:96d5:b0:17e:4f56:f5be with SMTP id hq21-20020a056a2096d500b0017e4f56f5bemr1810110pzc.22.1698142749323;
        Tue, 24 Oct 2023 03:19:09 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id u202-20020a6279d3000000b006b3dc56c944sm7708372pfc.133.2023.10.24.03.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:19:08 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        vincent.chen@sifive.com
Cc:     nylon.chen@sifive.com, greentime.hu@sifive.com, zong.li@sifive.com,
        nylon7717@gmail.com
Subject: [v5 0/2] Change PWM-controlled LED pin active mode and algorithm
Date:   Tue, 24 Oct 2023 18:19:00 +0800
Message-ID: <20231024101902.6689-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the circuit diagram of User LEDs - RGB described in the
manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual[2].

The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period.
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to the driver.

Updated patches: 1
New patches: 1
Unchanged patches: 1

Links:
- [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Changed in v5:
 - Add the updates to the PWM algorithm based on version 2 back in.
 - Replace div64_ul with DIV_ROUND_UP_ULL to correct the error in the period value of the idempotent test in pwm_apply_state_debug.

Changed in v4:
 - Remove previous updates to the PWM algorithm.

Changed in v3:
 - Convert the reference link to standard link.
 - Move the inverted function before taking the minimum value.
 - Change polarity check condition(high and low).
 - Pick the biggest period length possible that is not bigger than the requested period.

Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.

Nylon Chen (2):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties
  pwm: sifive: change the PWM controlled LED algorithm

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 drivers/pwm/pwm-sifive.c                            | 10 ++++++----
 3 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.42.0

