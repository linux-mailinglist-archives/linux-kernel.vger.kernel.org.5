Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D207F9B80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjK0ISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjK0ISp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:18:45 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA113D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:18:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332c0c32d19so2687689f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073129; x=1701677929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h89GXbFD81NDzhGTriqWBEbkzw5Rvdu8mS0nXlRxJHI=;
        b=CaSiCn5qhOnoOALpWTS59DvjrLEBzZBlsOylL1HSIcQBzKknZ5WNruQCAjRCWwQrN9
         lhIb4Eafhug8JZG2FeXrf/ApjFphiBxtKjY/X3oy2R+UQxCfq6MVK5nED2q5xRzwENAC
         Im7Tkf3vXvGtVcoX+piiLA71x7A2sw4958rTuejghM+LUQflpN7xyahVr6E5j/zU+yC6
         r2P3IPMiMGDfHfFngIux4wVUnVjyxAlQi25vp+BH7b6wCMYxZH/jMAgf4emuzBCgGTcd
         jke+1hvKtD7VilhGKmelTLmmYVqdgGNJXHelhE5qf5g1nskAVhO/+yrZ6G+uAyXnJdm8
         GngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073129; x=1701677929;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h89GXbFD81NDzhGTriqWBEbkzw5Rvdu8mS0nXlRxJHI=;
        b=p9XWOh6wWQTKp2UkjdenTPmMiD8G3mhqTpdLTyy0BUtVaZFnLmMB9+LzoWOGUkcoP6
         QtVOd91LuLog0FxSx3hIRCF9X8eWs12k3EUCo6kOz/eSLwCHzkKSZVS+MGOc3stx9ObJ
         Aoki2f8E1SP4KdCkginy7iAnD15ICA1A8/HIpPvXGfjoOmwpu/e1YeHztxv6XJZv9PEb
         tTz3sJGm1fI1KZ45lxwC+/XzfRxWXqt6lLOt3uC/mU39HQAIIJjT/7MBmWvWSb0vja0x
         mvRIAI3o6zy5OHZ9rZttM14PcZ8WdiG2zMIqPPFV1ZPrWV0bIIGM8Z3tbeVOCetfv9VO
         MfOw==
X-Gm-Message-State: AOJu0YzeeP7H3hpo976cr4chI/ybmGTqtEUEpv2ZXlaz3qKEr7xs3caG
        MawaJ5spVCP4MQz1PfgNblTyXA==
X-Google-Smtp-Source: AGHT+IE122eG2RYM0HV+QgTktY0OcgpWuFBem0h1klzynMJY5BA3qL25KkkwogUqQew3t81Osn/r/g==
X-Received: by 2002:adf:fa85:0:b0:32d:8eda:ba65 with SMTP id h5-20020adffa85000000b0032d8edaba65mr7922595wrr.66.1701073129284;
        Mon, 27 Nov 2023 00:18:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w12-20020adfee4c000000b00332f82265b7sm4992855wro.20.2023.11.27.00.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:18:48 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Miles Chen <miles.chen@mediatek.com>,
        Alexey Romanov <avromanov@salutedevices.com>,
        Evgeny Bachinin <EABachinin@salutedevices.com>
Cc:     kernel@sberdevices.ru, evgen89bachinin@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231108125604.162383-1-EABachinin@salutedevices.com>
References: <20231108125604.162383-1-EABachinin@salutedevices.com>
Subject: Re: [PATCH v1 0/2] firmware: meson_sm: cleanup error paths inside
 probe()
Message-Id: <170107312844.1083555.11730115434079674375.b4-ty@linaro.org>
Date:   Mon, 27 Nov 2023 09:18:48 +0100
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

On Wed, 08 Nov 2023 15:56:02 +0300, Evgeny Bachinin wrote:
> At first, patches series refactors sysfs node creation to avoid extra code
> paths. After that, the resource leak in probe error path is fixed.
> 
> Evgeny Bachinin (2):
>   firmware: meson_sm: refactor serial sysfs entry via dev_groups attrs
>   firmware: meson-sm: unmap out_base shmem in error path
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/drivers)

[1/2] firmware: meson_sm: refactor serial sysfs entry via dev_groups attrs
      https://git.kernel.org/amlogic/c/d397965e584e0f2c6193b927c1e7693d514a6738
[2/2] firmware: meson-sm: unmap out_base shmem in error path
      https://git.kernel.org/amlogic/c/d8385d7433f9c7d718448465e30d6b8c1207b59f

These changes has been applied on the intermediate git tree [1].

The v6.8/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

