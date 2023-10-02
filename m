Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754DE7B4C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjJBHBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjJBHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:01:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168D3BC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:01:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406589e5765so30131485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230062; x=1696834862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY0pGPase8DAPqfUfT8zLIwupYNhs+ANJOrUn57BoW8=;
        b=cxtqljFw3W6BH9rWR1igF+AD0MrugHQDDE95Z4uVha+LDNnofSLdFo+hvoW3/xSQBk
         I71iZNR7/9pBf/cJ5Z9WYMbpARNUzkoL05DcurCS/KE3saPYQaDBRRed7sOKZilq0Z6H
         hWl2MQ65ZvfLe4LxatTI+v+nUm50T0IjBrxrFDtfpuguDfcgF9bgl+Yss0t/I/7PbA9e
         NgMvrTdHyr8R9+Llxdor5GdqVI5oXUqgOwPwaM/Ezvp7uqz2qhDvOTRrDSihPZYddw8u
         vOfBW6RmAmdhrZVv+6Z5qeF+SB+QHkBRGAME1oECDy87jFjviruhcDmamSU4U5CnunNz
         abHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230062; x=1696834862;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY0pGPase8DAPqfUfT8zLIwupYNhs+ANJOrUn57BoW8=;
        b=AsiE3oQprfvU/M8k7pK0BpyuOBU/mWZuHZYDXvqnR8uBbwOkgv5w0+Qhqr2UEzWAYO
         1LbABgtfLpS8DjuLZuT+FBlJa9Z9SuGf4V57uLemjUcjRKhdQEgxZdXw0R5RIjCUd1Pp
         d0vC4qpDB/E4+sBWgV0lJFxXqTtV8NYOANBDM9NdoBHbjtiu506nQqw4p7jPAVJGvGEz
         ZX9cO8Hsh8UqRk0hkXkIpgToUHNQP9mrtoe4pK2bGjK+TIXPc+KPcwLpJyd6U21VBzic
         q+CuIzXBgpSNN9+B7avwymYB/ZBCq3xeLvXJ3CauvLGa+tOBEcenedCwcGD4/WLilQOm
         ZH6A==
X-Gm-Message-State: AOJu0Yz1/I7svO4ccR+vaik1+mQPeOx6CHiJithJqUk8ePZgUK8szzQe
        rYWmZ6SF9cCvYVU2GThRQRcSIA==
X-Google-Smtp-Source: AGHT+IFaCMBuWg5TQzZ8F+fXy536sYD86fhXX3Qt7RMVopoYPkSdFbYvPmBNx/iZzn+a2xlQnqMhFw==
X-Received: by 2002:a5d:5151:0:b0:31a:e772:ddf6 with SMTP id u17-20020a5d5151000000b0031ae772ddf6mr8873550wrt.39.1696230062112;
        Mon, 02 Oct 2023 00:01:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id r17-20020adfda51000000b00327c79ca7c6sm2440715wrl.80.2023.10.02.00.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:01:01 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
In-Reply-To: <20230925135326.1689396-1-jbrunet@baylibre.com>
References: <20230925135326.1689396-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: g12: name spdifout consistently
Message-Id: <169623006126.3465675.17408655598798133472.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:01:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Sep 2023 15:53:26 +0200, Jerome Brunet wrote:
> g12 and sm1 are fairly similar when it comes to audio.
> Both have 2 spdif outputs. While the 2nd output is named "spdifout_b" for
> both, the 1st one is named 'spdifout' for g12 and 'spdifout_a' for sm1.
> 
> Use 'spdifout_a' for both instead.
> 
> This change does not fix any particular problem. The intent is just to make
> it easier to have a common card definitions for platform designs using both
> SoC families, when spdifout is used.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[1/1] arm64: dts: meson: g12: name spdifout consistently
      https://git.kernel.org/amlogic/c/3f0b916f3a7eaa8aab6f6ab465a4f5342b5253c7

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

