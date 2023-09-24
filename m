Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887257ACB8D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjIXTCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjIXTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:02:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17998FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405621baba7so21041435e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695582139; x=1696186939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5L27vyhB+29gla8F3SJpsrlKTGzHdOCjPLcg4h4ukig=;
        b=sSnBQ4XO88nc402Jpx2dQOHq16N54qiG6DBwHiUqXXyUVA5X0PaY8eRMFRDB5pGFh4
         u1qwq+xcNP8GrS/0+7cEFpTZbh6+Xy9N4cNRJo0Y7Fm2LYiEELpWLQ9WPVhLmVRT0aaW
         uI2bsoK26SaSD7SnuMIYnkWqxmX2j9JnhPy/elS2syMppnvsFs7faxPMt2Mk7xrU6OF1
         qR6cZiGHgBvk0jS7ZEk7g+R9gk5aXCcOLZF5HfCkDBUsbmL1zlie5MGCvYF/rrTIez1h
         lCnWiNiv0dK/FZl4Bc0KrM91YtbXUnC8xFuIr8jeB6hjw+MuCaLkL2GTBy4mN6ay8fOB
         ogLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695582139; x=1696186939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L27vyhB+29gla8F3SJpsrlKTGzHdOCjPLcg4h4ukig=;
        b=IUcOAiaeXAnaixhuqPJLf6Ql+uh+XyPltrWP4/MaQfju18r8udNe+OnN4s4viyY6GW
         H8sr4mZqrHKWR1k/uTJ8NL8pYLjcQ+unzvLm3xUAUxTIQvA9GELF5g1Vs/QYRdG6ZNKG
         JSe+UTrc+t8/sv75Y7RUFUZbYEtsznBa3AQQtuT/tfsdYxDp4GcRWzD5BYoo0w97AXgm
         xGkp/emWcb5S9atGVJs9HlN/xya1GvaKMcF8e3Z/pL3KyXGY8ENMlQNG2pDB9P4dyC4H
         M3CbZ1UwTI5NKQuObMllt+6i0l0rP+w8m2uG7BtZPC+tjRgOirrbnlbK7vKl53zHF+8r
         9Etg==
X-Gm-Message-State: AOJu0YzXOPucp3k3Ka0sO6f3NQouHQZ0VcCS4qHXzqTYAe9Ry6OoTii3
        Z0/jwlS5q63e5gLQGIeB7XyKnA==
X-Google-Smtp-Source: AGHT+IErq5Wt5aJa91F9/ZnewsJx+gdkW3B8V6qLAXXHgkuVJWQLKuUo78IbX63mkvUfQKV2Y4swOg==
X-Received: by 2002:a05:600c:2215:b0:402:e68f:888c with SMTP id z21-20020a05600c221500b00402e68f888cmr3731029wml.7.1695582139484;
        Sun, 24 Sep 2023 12:02:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm12980507wmh.35.2023.09.24.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:02:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: nuvoton: add missing space before {
Date:   Sun, 24 Sep 2023 21:02:05 +0200
Message-Id: <169558197845.54884.14770173145446066681.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705150045.293879-1-krzysztof.kozlowski@linaro.org>
References: <20230705150045.293879-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 17:00:45 +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> 

Patches were waiting long enough on the lists. I assume there are no objections,
at least none were shared, and this just slipped through the cracks. I applied
to my tree for further soc pull request, but if anyone wants to take it
instead, let me know.

Applied, thanks!

[1/1] ARM: dts: nuvoton: add missing space before {
      https://git.kernel.org/krzk/linux-dt/c/73f20a373811b303fc5bd8f3d5a4c5c1582f1ba2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
