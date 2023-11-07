Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922637E383F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjKGJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjKGJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:54:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBD811A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:54:34 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507973f3b65so7336964e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350873; x=1699955673; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KVxbyf63W63AUZ1cjifrLlcVV0rg+APXv/mnMjOM+w=;
        b=pytBYZQV9ZnZlU4wxdv96tF2HwEufIfvVY8y7Q02ZSam9shdF5GNSTx1grkLNNkFoi
         mcr1D9QZweNlf/jGlm6aO4/TO3DYlg319BvMxpf81h8sIXz8PgYv4W1VcMp/TGZh2CUR
         rriWFufywFj6z6Myuw0TbleYODnd8eVqfNtUIdcrxOK0x87pxJxUhRi5Cq3ruY0m45G/
         HY39MkplRgMG7fNWkXT7c2spYrsgOWrnzutAhbzpj/dbj/kbj1KtAg6vhmoc/4909mlO
         Os/IkzoUiVPSeeLJzbxlfmLk7vrz5RD41/iCZTrb53F//YbFyDZgi5bf55GbghD71pPo
         3f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350873; x=1699955673;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KVxbyf63W63AUZ1cjifrLlcVV0rg+APXv/mnMjOM+w=;
        b=vgu1+YFxCvkyo+yMqS4+FH7oBGL18h8hM9RZUQCcAXLJ+zO8n02TQAoLVaslrvIEVp
         KrvX7xDfYnYrOxZLBEQ4wHoACWgh+yvhngajOP4vzGPFXJdgntxYThVjoz84oRrkBVd8
         Z07fjLfBNYn/uodlZk03ZKaS5tG4DOXAUL5+4HtRjYH3/K16uQPfXsaDZ6zrtIOI8Mab
         1J/bBrg0zGzcmfPDSJtkFLhEv8zqpIRCX159TSOvjAuxKhAUYK5sW+aM+ZyRdEWY5Enu
         67I1BH6clr1EjY80OOpkApiq+voO94FEi46TVJRTrj01oY8Y2/I+nkBM8iKMMte12DPV
         kqAw==
X-Gm-Message-State: AOJu0YzubfEdM1KRAW/dTpyA7QoqM3cDTFWc1lMTH6g/+tLJM/kbdddo
        YuJMlZdulO9atxgnvDZ6RldbDQ==
X-Google-Smtp-Source: AGHT+IHaEDMyUObMlXrFqoLoDzJvzNU0tys1WG7+cZQWqx4WDBC+KFxmSp6l8CrC/bJVSZX+Ze64xg==
X-Received: by 2002:a05:6512:201c:b0:508:266a:e85f with SMTP id a28-20020a056512201c00b00508266ae85fmr23464114lfb.1.1699350872555;
        Tue, 07 Nov 2023 01:54:32 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v3 0/4] Fix large frames in the Gemini ethernet driver
Date:   Tue, 07 Nov 2023 10:54:25 +0100
Message-Id: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEJSmUC/4XNQQ7CIBAF0KsY1mIKlGpdeQ/jAulAJ2nBDA3RN
 L27hJUujMv/J//NyhIQQmLn3coIMiaMoQS13zE7muCB41Ayk41UQjQt9zBjQD4Z8uDIzMAdPrk
 VrRqkPZ7EXbOyfRCUurpXFmBht1KOmJZIr/ori3r6w2bBG95brYVyUjqlLhMGQ/EQyVcyy09G/
 2JkYeygjDams23ffTHbtr0BA5R4owcBAAA=
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the result of a bug hunt for a problem with the
RTL8366RB DSA switch leading me wrong all over the place.

I am indebted to Vladimir Oltean who as usual pointed
out where the real problem was, many thanks!

Tryig to actually use big ("jumbo") frames on this
hardware uncovered the real bugs. Then I tested it on
the DSA switch and it indeed fixes the issue.

To make sure it also works fine with big frames on
non-DSA devices I also copied a large video file over
scp to a device with maximum frame size, the data
was transported in large TCP packets ending up in
0x7ff sized frames using software checksumming at
~2.0 MB/s.

If I set down the MTU to the standard 1500 bytes so
that hardware checksumming is used, the scp transfer
of the same file was slightly lower, ~1.8-1.9 MB/s.

Despite this not being the best test it shows that
we can now stress the hardware with large frames
and that software checksum works fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Do not reimplement the existing oversize check (sigh what is
  wrong with me). Drop that patch.
- Drop the gmac_fix_features() since we are better off falling
  back to software checksums dynamically per-frame.
- Add a new patch to bypass the checksumming engine if we are not
  handling TCP or UDP.
- Link to v2: https://lore.kernel.org/r/20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org

Changes in v2:
- Don't check for oversized MTU request: the framework makes sure it doesn't
  happen.
- Drop unrelated BIT() macro cleanups (I might send these later for net-next)
- Use a special error code if the skbuff is too big and fail gracefully
  is this happens.
- Do proper checksum of the frame using a software fallback when the frame
  is too long for hardware checksumming.
- Link to v1: https://lore.kernel.org/r/20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org

---
Linus Walleij (4):
      net: ethernet: cortina: Fix MTU max setting
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Checksum only TCP and UDP

 drivers/net/ethernet/cortina/gemini.c | 66 +++++++++++++++++++++++------------
 drivers/net/ethernet/cortina/gemini.h |  4 +--
 2 files changed, 45 insertions(+), 25 deletions(-)
---
base-commit: e85fd73c7d9630d392f451fcf69a457c8e3f21dd
change-id: 20231104-gemini-largeframe-fix-c143d2c781b5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

