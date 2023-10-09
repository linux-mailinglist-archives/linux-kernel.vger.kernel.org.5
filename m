Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFCC7BD59C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345524AbjJIItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJIItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:49:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA6AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:49:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50437c618b4so5320803e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696841355; x=1697446155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+776vboQhTm+2abiwfH74h7cgbYhr3NJObCabRo9sI=;
        b=QGFlL6EwFZMQxZZ/Ttm3Jj06MK7q7h0SSWOVVTVMYQ53CpP8rZgcpQdTmi37Xj5lpG
         QbrtOKrN3o9fM3qQDYN9pH6whAZNtsGayfwZx0uJpGNpZRWo8TRuO8I4Ythal8D27pQw
         ZWlby0Hic3PaWEbsKAqlcv7ZyWmLjUZFc8gtxc5Uvzc8jfYJVFAN94yG72LkoZfn90dd
         aSaNo8TRyKmJseLvq4MeHicfSo+WfcIg3btEpMfaDwjlqKhcZ1OsmPniIrLVzxWNihQT
         w+jQrnFCK3sbKQDP1mJxi4io/HDjK4NjCZAO7kY2+OrEBHmymyiD1Xe3QATVk+cicYEz
         FK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841355; x=1697446155;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+776vboQhTm+2abiwfH74h7cgbYhr3NJObCabRo9sI=;
        b=ZDfghZ2/2wqikreYRFMaX1lw1IeW/glN4hR/Z64D2WiNx8Cv9r5llCdeDcNIRuOZIS
         rCvKQtOq7R93CoR2XqGlobTocLKe53uXgcNQCFeF7HdQq5E6SLsgW8iYQMpsCWJlEn4Q
         6yiJx3DdjPEeZ6b1zXXuDEYgl4vsk3I/RgDCOUpFqLIYtRGE4F/ZcUU8C9jo2XHKHFzi
         PVN5Pf5xoWbI6Ys+Oicfd1TkrgwHGG3/cnG/Rvareeb1ULVpKr4LY4yH9pM+zsW/707R
         cR1o3wCmajuhyahRQv/1cF2VRYeOCXhWqB7jpynxABVJO97sDUmQpbJ6y/5apu3xM9o8
         6nBw==
X-Gm-Message-State: AOJu0YxhkVzW0Db9fq0AiEzEbNxUvBDhnyBD7v4EiwdCPFo60iIL/WVA
        I1AFh+ylQYn9ZzIxdDSh7kPRzw==
X-Google-Smtp-Source: AGHT+IF1hrt67hJyw05Gsu1s8zsE8MHW7O5lYxYtbaMHP87oKAsKaHkU/5xuqXTl2apamOSrnVUIzg==
X-Received: by 2002:ac2:4bcf:0:b0:502:cc8d:f206 with SMTP id o15-20020ac24bcf000000b00502cc8df206mr12621694lfq.23.1696841354936;
        Mon, 09 Oct 2023 01:49:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j35-20020a05600c1c2300b003fe15ac0934sm6352388wms.1.2023.10.09.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:49:14 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231006224644.445295-1-robh@kernel.org>
References: <20231006224644.445295-1-robh@kernel.org>
Subject: Re: [PATCH] firmware: meson: Use device_get_match_data()
Message-Id: <169684135411.1715828.9252611869194225586.b4-ty@linaro.org>
Date:   Mon, 09 Oct 2023 10:49:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 06 Oct 2023 17:46:44 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/drivers)

[1/1] firmware: meson: Use device_get_match_data()
      https://git.kernel.org/amlogic/c/5d59b6a49bb8f6841acf53affc0c4720fe7450e5

These changes has been applied on the intermediate git tree [1].

The v6.7/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

