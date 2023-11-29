Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11537FD6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjK2M0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjK2MZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:25:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04AD10C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:26:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b427507b7so27684305e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701260761; x=1701865561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVd0mk/E8WAISTN9cwzB6Xw3Z2qd3DG26hbJb8vpXqs=;
        b=WJy9qKOqwTWuAsKDPzsTAQtS3T59gjjnEMvVxKazNthlBS0gUib8ZjiPE31DpWpzlL
         dKE/f5kC5MHnu7lqeWfUZAt7eKjHgIDr+cR5LR9EniB06B7iuALeXxUoRdjVxb3oQdoA
         wKFClJMZtlvgbMArd/+WLrHl99S3IQ2K117KnmbZ18Tcz7C0bSd/mVoWFCMhcgcHhEc2
         ozlAwuM+LwiEnFdDIR7z3metlnBJJiE21mq4WPQbYNch2yLraDMVRarSeaBqmIC6XDpF
         28k47PwlGCZIo05I4DLQk5AkwDhmLfuu5v1mwPUWE10TcfihI49aY+GI6zlWtvybYLGf
         3ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260761; x=1701865561;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVd0mk/E8WAISTN9cwzB6Xw3Z2qd3DG26hbJb8vpXqs=;
        b=FcfYZ4ddkA38ghduCjA2BdQhQWFmxscKGlj32vfHkIDWl8uVkErBfoGLhA/GEwK1wQ
         3CXUTjlXD5QKfJwc74daMCX9f04ROMXsxx+HAFk3km+J+7HexIU72lKmHMJv6dWsSxtd
         SSuPIXjE/EIwOmvWbWwM2gDFIgmAqIiAuHqFLxa/lD30rwthuppdO3q6QZ4fGaRGObGn
         OmBkpXQ6mAYoq3ZFvy4Hgl4zsRLIff2U9527rUR7JxYJXPoOUghySPGbtRuoB003OtYT
         kXxKPK4O9TVZQEkFVfQG73jdTvvE+YLXb93tDhcTg65GW4jyTdf/axRQ8Syb1E99njO0
         yQSg==
X-Gm-Message-State: AOJu0YxPDk1c27Tr0LvMoKkAhsEgQsuHAzNIJNUMHb/nP1P0cLwvnXy9
        ijNsWSCKN/F/ta0BtZettGgD5g==
X-Google-Smtp-Source: AGHT+IHQ3EA5vBpnyDFB4fnqV7h4/enCyNJtRFRN4wtxlHs+OMVVOZDfwzbw0/OUV/fl7njjlBzgEQ==
X-Received: by 2002:a5d:46c1:0:b0:333:1077:b35c with SMTP id g1-20020a5d46c1000000b003331077b35cmr3785511wrs.47.1701260761421;
        Wed, 29 Nov 2023 04:26:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d67c8000000b00332e84210c2sm15542543wrw.88.2023.11.29.04.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:26:01 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        zelong dong <zelong.dong@amlogic.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        yonghui.yu@amlogic.com, kelvin.zhang@amlogic.com
In-Reply-To: <20230914064018.18790-1-zelong.dong@amlogic.com>
References: <20230914064018.18790-1-zelong.dong@amlogic.com>
Subject: Re: (subset) [PATCH v4 0/3] reset: amlogic-c3: add reset driver
Message-Id: <170126076055.2880660.13057388884278592366.b4-ty@linaro.org>
Date:   Wed, 29 Nov 2023 13:26:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2023 14:40:15 +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> This patchset adds Reset controller driver support for Amlogic C3 SoC.
> The RESET registers count and offset for C3 Soc are same as S4 Soc.
> 
> Changes since v1:
> - remove Change-ID
> - run scripts/checkpatch.pl and fix reported warnings
> - sort dts node by base reg offset
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[3/3] arm64: dts: amlogic: add reset controller for Amlogic C3 SoC
      https://git.kernel.org/amlogic/c/a5468f5ea9a01acf29d02745abae7b82482989d4

These changes has been applied on the intermediate git tree [1].

The v6.8/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

