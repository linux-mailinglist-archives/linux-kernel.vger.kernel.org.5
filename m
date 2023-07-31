Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA176929D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGaJ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjGaJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:59:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055C1AD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:58:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so19319035e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797517; x=1691402317;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg2nsL33DJP3APkKNMN9PVz8TJV+b2lWQs0h39zCPdk=;
        b=D0CoOihB3i7vfd0NMuE+IHCa036Obg/hpIa5zSSxwWWza07mstlN8/upTS0yoIfuj5
         Qg6dODVcwzceCYpXrF9g1tFAA/I5TkGckqYyQuqoOY7h7H0xpUa/Jd7z85nZ7QUDxHhc
         EArzckJn73/0IGSJWZllm5YnLABbccWDAZuGWIqaxhgHdV5D4D2OsVvwAvIrVPQX2Qv4
         hb9cBaMHMop6CgT1oMVocppR0fAnA+DzmcgTrl2FHd8Kt7EHyOpaayst2z/RsELa0BYm
         wniLBlCyEK/MXeK86TQdiWtXsaBVqE4tyCt+/TqHDQMEzlR3+fhP4JbYGru2veBQQ4vL
         p0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797517; x=1691402317;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg2nsL33DJP3APkKNMN9PVz8TJV+b2lWQs0h39zCPdk=;
        b=BrfPUXZ2yukPjVFUIyHn9zIz+ZYKvFSbwh9ZJ/XdHrZhwc0MPUcbeurZVQsZ8LX+RK
         nDBi21eBSJcVYaaVyJd6lIlKODTZ8uaNih1xSTf+On5CIWjHpkD2kq5MPzt6N479LZwn
         nIa4f4qIVMvbpmrOoAVicgx2aLUdLlmzHlg0HTudkoDApG6jAbpqpRUcge1NysVkjEGg
         bwzZoQ/YZCsyWlgn3ws2RP5ZiSFbejBAsrmqCYAWlwxe1VPeZLCTr1gcL6JENKY7g1Ro
         P5x+Vxi6Zcve4s/Nh8+7GoLHxbXhlCuTUItxjsMJm2J7VuJ8OD49dW8wV1lpzRl1tXtp
         WHdQ==
X-Gm-Message-State: ABy/qLaDugF5qQnSFg8PCm1WzvB1hlcZNNkHM2Flegphq94xeHi+eNnA
        OTspobaynlsLpFHdUs96+NBiRQ==
X-Google-Smtp-Source: APBJJlHWatIum20TrxpJEWJ1w3MDJ0L8YbqPTf426+yes4pyrdIxTQM3BwWTW5meZG9v5qeIpdgvMQ==
X-Received: by 2002:adf:e586:0:b0:316:f24b:597a with SMTP id l6-20020adfe586000000b00316f24b597amr6780410wrm.46.1690797517412;
        Mon, 31 Jul 2023 02:58:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i17-20020a5d55d1000000b003143be36d99sm12568762wrw.58.2023.07.31.02.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:58:36 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230717225623.3214384-1-robh@kernel.org>
References: <20230717225623.3214384-1-robh@kernel.org>
Subject: Re: [PATCH] ARM: meson: Drop unused includes
Message-Id: <169079751641.200989.17748164958378497482.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:58:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Jul 2023 16:56:23 -0600, Rob Herring wrote:
> of_platform.h is not needed, so drop it.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm-mach)

[1/1] ARM: meson: Drop unused includes
      https://git.kernel.org/amlogic/c/b5bd2ccac2d5b2830c1d59e759e5e35e50639b99

These changes has been applied on the intermediate git tree [1].

The v6.6/arm-mach branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

