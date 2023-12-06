Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A881B806AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377242AbjLFJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377229AbjLFJco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:32:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A8F11F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:32:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54ca339ae7aso4760917a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701855168; x=1702459968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilX2682XjnqliowA0bu2DjdfnU2cl4LwaHOv2ey4D5o=;
        b=LwW6fnz5vQMzNwpXYaijtq+ZbH7G189GVn7GLyrB1jURQNpIHQ9w1D625ECxTrzMP+
         RPDg8GAyexoQRM/rcwek+3RoyPYHj1PV4Oa/gfm0xn0tR4sfmwcuYwjz84Xtvm5AfON1
         VT8xaLSAFUV8bn0StdINpNMeRt2y1/vsj0dYrNnizj/vyXqZbMrpeHWlgKK/JoMcIvf7
         UYIJpK/3vxq7iAO44dGZ0+vU3P+Gm6pwkLfZCHViDa8g4WPKChdg9KnCCl3C6+YWnxjR
         Ui5si0Dw76O58pWrSdnRtKHF5ZmSxWbsTSNnRaFhVs8N4lOlfJjCyr5N0T8GURC3Xh5K
         9VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855168; x=1702459968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilX2682XjnqliowA0bu2DjdfnU2cl4LwaHOv2ey4D5o=;
        b=FDYT4UhG2DWGx1v2MicLRx3b5qgdzKZPbwHkpM6kGOTcXtjuOaUoev1TqITodeWkUv
         e3vrP8STHfHlS1TgRF1eTxCaliKSgP0q3tyjCxTv84hs9MhLIE21eDKCGPUYALum1wv3
         MwJzFD3+EJ22w8V7hl1Sdnk5BZU98yt0PNPke1XTPc552bCnOx3ub9MBgEoBoLjC50YF
         MD7vTgBjmgJNPvjs3p2P1zQ2ISIM1rQW56tZYsPmFKN7OLcEXBQpPKe6HL510JLeDTEs
         Qg/lxKjGkifyDctVl3tYB9aZV7jKwSDIo52W5Iz3n8jXkR9h9wdx9KQiVhrkRRpWEWJK
         4XQQ==
X-Gm-Message-State: AOJu0YwaYbN3nmLMMHyEpwu7lClQNdD0LZ7hFdIoS1heInzjsJz81fV+
        IO17PMbPLNzP0fMj2S4sSMGDUw==
X-Google-Smtp-Source: AGHT+IFsG2uhGJ1ANz+DkxB43OgfFlN7l8cr1mGaasXByK19sCTsVqsuwkGaKsfA1Z0KgtoblixnyA==
X-Received: by 2002:a05:6402:619:b0:54d:1dbf:b7c8 with SMTP id n25-20020a056402061900b0054d1dbfb7c8mr482566edv.26.1701855168618;
        Wed, 06 Dec 2023 01:32:48 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id p8-20020aa7d308000000b0054c63cc0469sm2175723edq.33.2023.12.06.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:32:48 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, fastevam@denx.de,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] mtd: spi-nor: introduce die erase
Date:   Wed,  6 Dec 2023 11:32:45 +0200
Message-Id: <170185515581.112933.16347567503579159977.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125123529.55686-1-tudor.ambarus@linaro.org>
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=LkTt39nxPJlaweTI13Scw1mV/6iSb8PVkXi0zhPzjZc=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlcD+3wPJT5I623yxO24AHNOTmovSvgb5+fhcIu PL2PdLYRNSJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZXA/twAKCRBLVU9HpY0U 6fB6B/9IE0xv4j63+beZo/StLTG1g1PJJfz7i2G80zu6QRryqEU6LO2Okyt/8yc3ykEbcVDZjIE V7ojaY28Pqp7eCkslSoM6WG1XZfh4oBd1aEtCqRTQ/fsSeIPncfOEF8uYUypBzNXB7X6WjyKheO +M7Oy0Zqw3x5cLK48keFPimxp5yPDpkJ+fXzDk9lwGKXWQDnc/mJPQsQyi2gcJS4rtL3S725F6j rOCtiPYGe8nNwautm1DDfOZnSzoI3HAhcxgXbyXWTte0Gc2bDIB5RrKNBPWavnDRlSQn4GwKBLH X5/oXc+jXBQvU9TAOnQhGWvagAPVnuDA++kgaWPxpkLHOLkK
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 14:35:24 +0200, Tudor Ambarus wrote:
> changes in v3:
> - fix code, thanks to Fabio's testing
> - found a n25q00 and tested on my side too
> - fixed micron's die erase support
> 
> Add support for die erase.
> JESD216 mentions die erase, but does not provide an opcode for it.
> Check BFPT dword 11, bits 30:24, "Chip Erase, Typical time", it says:
> 
> [...]

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/5] mtd: spi-nor: add erase die (chip) capability
      https://git.kernel.org/mtd/c/9641423174d0
[2/5] mtd: spi-nor: spansion: enable die erase for multi die flashes
      https://git.kernel.org/mtd/c/461d0babb544
[3/5] mtd: spi-nor: micron-st: enable die erase for multi die flashes
      https://git.kernel.org/mtd/c/53919a968b43
[4/5] mtd: spi-nor: remove NO_CHIP_ERASE flag
      https://git.kernel.org/mtd/c/06de1257aae7
[5/5] mtd: spi-nor: micron-st: Add support for mt25qu01g
      https://git.kernel.org/mtd/c/c692ba6de1c5

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
