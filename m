Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44705774257
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjHHRm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjHHRlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:41:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB817238DE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:18:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso82417961fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691511458; x=1692116258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGR/FDAz6QwzMVqhMqlOHMf82ldcSZKkfY2QM99zIzc=;
        b=OWmQrDL43R8nWBDtpJnlnxbVW7stxMSEXZOdVNSQn7ppLbA2weFLvS1eA8/7TmdBIY
         5/9MaeHT7MCY3VBDQC3Dw1VeTSV5XtxpFFBnn722R7WP3SaTFSMB6gH6umfbEs9awCKA
         Juul7kT3NPkHV7k1VjQ7xwv4ORAKOSQLWOClrJ+ipA+0w5J9j0Q6+VF/bKaM5l0wj2h5
         uoXu41bLRJURMvu9XPu1+/u6p1ML+yI8/QySb/8b91x5s0CpjQUl1knBgRQ+gfGOqIVk
         NCbttj9taJaYin5fKIWeIaLPRMu5SQtLiLPU/YDpu0UZ8LMSZ3O6koZldVTWw7fIWr8V
         /UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511458; x=1692116258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGR/FDAz6QwzMVqhMqlOHMf82ldcSZKkfY2QM99zIzc=;
        b=bzaBP/ybJylafUUu3PAtLpNonYXKY2c2yJVGNPE7K8mmi5G+PiEoTtdzO1UmD+kAXx
         5rfuoF0zQ2IRbtliuiTwLOc+YROU4HfIYdCbSBOkVQbWZDOD1GtQLiI4hGwtZorO/++T
         G5k6WNF7+dgxfKwwm1oYNStb3SUOeid2LyDwyggEMXYLd5h2R/tpRyCodKQI2iBGsTIi
         lB2kCW3VpBO+lAuGz3bNRen7usqRvmxLeC0OSjt6rMe7/gnLJGD4Pk95MHbfrsZ5KU1s
         XBZhwfh+pTBws0btFANfjyEtZfDzAluBmWymxBnOJEvKbQyFkJ6skihnMydHbx4pviUx
         teyw==
X-Gm-Message-State: AOJu0YyYfn0mhstjQQStyTBCPPhNGG6FC7x2oiclPI5XDgmiArq+lHXT
        Mm8D6ZDLKnxrFodcKtvyOYGMwAp3NzJOWUaAPbk=
X-Google-Smtp-Source: AGHT+IFzDPeVzQZoYJKpnuTnwP9ABSYbuSXkjD6PnqoZvzUu25vMVnUvTGUH/D3RmOCcWmeDluW3cg==
X-Received: by 2002:adf:f984:0:b0:313:e391:e492 with SMTP id f4-20020adff984000000b00313e391e492mr7187996wrr.17.1691489278679;
        Tue, 08 Aug 2023 03:07:58 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:efd4:f3df:2c50:1776])
        by smtp.googlemail.com with ESMTPSA id e11-20020a5d500b000000b003143c9beeaesm13109420wrt.44.2023.08.08.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 03:07:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@libre.computer>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] usb: misc: onboard_usb_hub: add gl3510 support
Date:   Tue,  8 Aug 2023 12:07:44 +0200
Message-Id: <20230808100746.391365-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the bindings and driver support to trigger the reset
pin of the Genesys Logic gl3510 usb hub.

Jerome Brunet (2):
  dt-bindings: usb: add device for Genesys Logic hub gl3510
  usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support

 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 3 ++-
 drivers/usb/misc/onboard_usb_hub.h                        | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.40.1

