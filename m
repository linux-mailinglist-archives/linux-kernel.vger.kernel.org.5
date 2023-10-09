Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39A7BD5DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjJIIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbjJIIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:54:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66E135
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:53:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so4250990f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696841625; x=1697446425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5pyYgDH5Sj0yCWzvyS4ZZ4oeovk0or3XiHl2Z6dYIk=;
        b=IwIyqntZm9kbKO/1iEDjMCF5bMLXQYYPKqUT8rLDXlXJnN3vAYyWzGT91BIm/NBC85
         b4zcz+dqD3dLA385UibDxhewhxFQ9N0M3HL+QX5t3f5ClEkKmzySrXlXG3Dg8FpdtA8q
         +Q7C/dDBaSHBvKEoGULfZYTWEDRPSe53jdItqvZcOoaHD6y7VNtSSxxNkGUGMEBcbZpJ
         EV2v0H1ZVl6xbecZr1DHzyOlhwGdsjYOZ/4EbhAdJ87q+SaXt8JKG0m82+rsGKVK9a6X
         iZQv7GDSlluzcAOWGWsH+cljAFiweZgmSlv5aOrinV20ala4kkRb7gDfvgEoJdGoP4uo
         9RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841625; x=1697446425;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5pyYgDH5Sj0yCWzvyS4ZZ4oeovk0or3XiHl2Z6dYIk=;
        b=U7uN/opQR7ByA55MlqAgxPDe6xofbBIWa//dM/KPXuNNZVdwCOLLRYGBguwm/ImkB2
         V2XAuEV+50S4ZbX8ZfjxYnHTTXBAIf+mkuCv7QYsGOtjLScZaDv5tJ7L5dQ8T3kh++PX
         wS6ovIjzaCRQYshlt0a841p5B0FoKpyyKX263zF4zm2U0vF33sqdRrannz6DBwk24/qj
         HTbROw/C1tSUQxByTYI/3UYWXC4Aq6EIGqyRXjK+LfLghQYafKGINC2CZfMvKz/nc/+i
         GfgmfEcRNBDGN6PJXrxyrtOleKr7QvBUI4lhdQuRC6ilQhS3mU0eLSvYL7K0hiN4PMMU
         Nd2A==
X-Gm-Message-State: AOJu0YzA/9YmWnIrQQoCFOBala+XkMnT7/T6Qjcg1cDqoEZRemDBdOAT
        9fsEWrUnzToXvAGaw8ySPba74Q==
X-Google-Smtp-Source: AGHT+IE4vUOSiqi6La9eRS2WThKGCcdTlP12sUEzDm+D85CLrud1dbwZUTiOhB83Ya/8gzG6puFrSw==
X-Received: by 2002:a5d:4b83:0:b0:321:67d8:c3e7 with SMTP id b3-20020a5d4b83000000b0032167d8c3e7mr12281114wrt.12.1696841625518;
        Mon, 09 Oct 2023 01:53:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b00327cd5e5ac1sm8991293wrs.1.2023.10.09.01.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:53:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     jbrunet@baylibre.com, mturquette@baylibre.com,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231006114145.18718-1-ddrokosov@salutedevices.com>
References: <20231006114145.18718-1-ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1] arm64: dts: amlogic: a1: support all i2c masters
 and their muxes
Message-Id: <169684162458.1721642.4981254140997404903.b4-ty@linaro.org>
Date:   Mon, 09 Oct 2023 10:53:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 06 Oct 2023 14:41:45 +0300, Dmitry Rokosov wrote:
> A1 SoC family has four i2c masters: i2c0 (I2CM_A), i2c1 (I2CM_B), i2c2
> (I2CM_C) and i2c3 (I2CM_D).
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[1/1] arm64: dts: amlogic: a1: support all i2c masters and their muxes
      https://git.kernel.org/amlogic/c/f2d2200e47e942e4df16f0fe8a30aa1d91e4831a

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

