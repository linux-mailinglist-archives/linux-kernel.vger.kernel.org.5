Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5742D7BB692
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjJFLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjJFLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:39:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81753E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:39:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3226cc3e324so1947328f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696592341; x=1697197141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5BhJ9uSQO9qYOJdOfwm0O5npfsEid/Wd+Awk+KoQ5M=;
        b=CdErVfa8oGLNwtjV6KXmPOr+xP16RbYMVYvZHVxUh+ZKTLg/h+uP178MrYsuljDcER
         SClFvyDpXLWSSTpzK8w/PFIU3qxFn1DJMRnpDm4/ol/+1kB7SZah/lKoHd9YdR28rqOz
         s7c8QI9mdEbIsJBT1NAIRlO3taCpncxemN76SgaE1ktA+lKPnP8F9xx97LGRnWJ7ECz5
         hx5daMqeHjG9qMbGIAXgUgljN3gcvNvHr/YiaITM/uSEFqrGAJC2iHHEncgaVZyb0xQX
         kLNxjJBUhKm/HB3TswrpsUZBe4lTdLb5dC3pAvDW82EjcIIhD7tPglfzGADHv8Y/h8sn
         wchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592341; x=1697197141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5BhJ9uSQO9qYOJdOfwm0O5npfsEid/Wd+Awk+KoQ5M=;
        b=Gg3VQkuYXOW9tGKauKw2+jr2uukX93DwbrjqjO6/LktRkoj2D33J034fIykshdwLks
         RB7qibPLOnRzgK+nN1ptBSPchB/gRj5VddempcdpbbmoHdiSJAqult8t9Psvlzll5q44
         Q4BEJTQ51FFjI0aXBSkmstaaAueTM5eV1X4AEXAp+Lbx7DNY4nuYhJrGOeASfydNYMar
         psEl32Uxo3lFHKaDQB8FQN6WHYmPD2GGkWqvvKYcB+NziiCbOHbpkQJ1Z2cesGIYmTGT
         L44pVhxPoitII31doTRMM3bKoRDqsE0mzTe/tXRSfN2Eg0Vj5FkxK0UtaIYtqsyebHD8
         nRLA==
X-Gm-Message-State: AOJu0YxUdv3KTwI88dhi60C20n8QmmuP7Aq5sFChb+PRlSOQQNmDgf/B
        kKBKvNVQlJWrLCJdvkoUlhj2OQ==
X-Google-Smtp-Source: AGHT+IH2Qyo4a1/R1ZQkB8R4QL65Ez3OTj2edR2TDGOMlROq5wX4NlwWJHo9NCXv1A98e8n9iiO9vQ==
X-Received: by 2002:a5d:4a0b:0:b0:31a:b3aa:d19b with SMTP id m11-20020a5d4a0b000000b0031ab3aad19bmr6822802wrq.23.1696592340825;
        Fri, 06 Oct 2023 04:39:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm1442191wrw.103.2023.10.06.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:39:00 -0700 (PDT)
From:   neil.armstrong@linaro.org
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/2] arm64: dts: amlogic: add libretech cottonwood support
Date:   Fri,  6 Oct 2023 13:38:56 +0200
Message-Id: <169659226646.1467422.12919977001849409965.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006103500.2015183-1-jbrunet@baylibre.com>
References: <20231006103500.2015183-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Fri, 06 Oct 2023 12:34:58 +0200, Jerome Brunet wrote:
> This patchset adds support for the Libretech cottonwood board family.
> The 2 boards are based on the same PCB, with an RPi B form factor.
> 
> The "Alta" board uses an a311d while the "Solitude" variant uses an s905d3.
> 
> This patchset depends on the usb support for the gl3510 [1] and [6]
> Without it, there will be dt check warnings and usb may not come up properly.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[2/2] arm64: dts: amlogic: add libretech cottonwood support
      https://git.kernel.org/amlogic/c/9f841514c9c238ffd1513ff3a49ba662a54aabb4

These changes has been applied on the intermediate git tree [1].

The v6.7/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
