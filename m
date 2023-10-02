Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851F7B4EF8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbjJBJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjJBJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:23:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9883;
        Mon,  2 Oct 2023 02:23:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406619b53caso23534445e9.1;
        Mon, 02 Oct 2023 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696238626; x=1696843426; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+Ccx9PHxjjim4MCiySQlvJuRSaLuBjXA+j1gxO9c74=;
        b=KBIESpwQs58xycoewYWjewlTZYa/5l4L/cVHzKrAwXL/pOtO2eHewys7jha0hETHb2
         xlWX2wj4o/52wGlJYnZAUApQU4b8BMhHukZr5q+u4sSTAAuHOTWOOnFjvqAAyr2BaTn2
         Q0Ud4G/gI8WaxxMsnKT+NohN7CZ2kjO0DgQbmgQxoB++WyneVyFMmSjnX8m1IiV6xxC4
         quogZYIt+YjiDxorSFHLXlQyV1m++A2o2srLUfXQcPPWFwSwIlqIy+QNe5quY9KvnSCj
         FY6U3DWstdkufq2Q9Acff57mjQtM0N1rNZyO5qd9OLrCWXxjmimvhACsIeUqaQ/RzGrX
         1Ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238626; x=1696843426;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+Ccx9PHxjjim4MCiySQlvJuRSaLuBjXA+j1gxO9c74=;
        b=nKc3eMvjWAG9cxuzqZ/yKI1zKQ5LTXleobr+whg51DW3oLn1skzgp6MaDeC3BXzlj5
         fo8e8QPGLLg5guyJhAoisQmno/2xJOTGibkic8VCROIQbBnZROFOy9pCxvig6ysUsvM1
         Pe3LlDdULoRUBOa9qr1w8rj3/zZBg7c2e7rogpx+MsuI8TWbKXiPoF8XQKznFqmQU5LM
         GY/RkPKKkKAO0fyWbxgokIggk8/CYeAKz16eaA1Fc7oDc3NkhVgjoEmITLzeZEIy0b44
         UCiVKE/3l/ZTVetkNavpGAKKqfedCJ93hZ8p1TiLigsrae8n633P1eKN5gu5qmZJdpYq
         LrDw==
X-Gm-Message-State: AOJu0YwHq7eO73l+JuVyX1EtO0xzqzXGIe0MDGlzMi47WaSYr1/Jthdt
        y6zBzVVqbk2+mdPyiCrooNd9xBQZn0U=
X-Google-Smtp-Source: AGHT+IHkHomt7oF0Rlw/likiY1Q1Ay7IWpxmB6Dqf3/s4PFZUu+YDyPtFsh/hPFA/Joql+HkChi7MQ==
X-Received: by 2002:a05:600c:2946:b0:401:4542:5edd with SMTP id n6-20020a05600c294600b0040145425eddmr10517340wmd.34.1696238625927;
        Mon, 02 Oct 2023 02:23:45 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b003fef5e76f2csm6156589wms.0.2023.10.02.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:23:45 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH RFC 0/4] clk: re-set required rates during clk_set_rate()
Date:   Mon, 02 Oct 2023 11:23:31 +0200
Message-Id: <20231002-ccf-set-multiple-v1-0-2df5e9eb3738@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOMGmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNz3eTkNN3i1BLd3NKcksyCnFRd42QjS0MTQ7O0ZEsLJaC2gqLUtMw
 KsJHRSkFuzkqxtbUAcqlFvWcAAAA=
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a spin-off of my initial series[1] with the core-related parts
picked out. Without the core part, the rest of the series only partly
makes sense, therefore I wanted to clarify the state of this first.
That's also the reason why it is marked as RFC for now.

Background:
The CCF is currently very rigid in terms of dealing with multiple rate
changes in a single clk_set_rate() call. However, with the
CLK_SET_RATE_PARENT property, it is very likely that a shared clock has
a couple of children which are changed "by accident" when the common
parent is changed. These children might be clock inputs of hardware
modules, which might have set a required rate previously. These required
rates are most likely still expected after the parent has been changed
by another clock (e.g. a sibling). Currently, it is not very trivial to
get these required rates inside of a clock driver's
{determine,round}_rate() op. Therefore, I think the core should also
participate in the process of ensuring that consumer-set requirements
are still fulfilled after a rate has changed.

Idea:
The idea is to have three rates set per clock, which need to be
considered during the whole process:

1. req_rate: This is the rate required by a consumer. It is set during a
   clk_set_rate() call.
2. new_rate: This is the "new planned rate" for the clock, which it will
   set, once the "finding new rates" process is finished.
3. req_rate_tmp: This rate is set if the clock is "required to change"
   during the process. It basically means that the clock is an ancestor
   of a rate-change trigger.

With these available, the core is able to validate the changed subtree
in a more simple way. It also allows us to re-enter calc_new_rates(),
which is one of the key components of clk_set_rate().

Thanks & regards
Benjamin

[1] https://lore.kernel.org/lkml/20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com/

---
Benjamin Bara (4):
      clk: only set req_rate if it is set by consumer
      clk: reset new_rates for next run
      clk: introduce req_rate_tmp
      clk: consider rates when calculating subtree

 drivers/clk/clk.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 18 deletions(-)
---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230927-ccf-set-multiple-3c291416fc98

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

