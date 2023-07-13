Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A182475191E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjGMGxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjGMGxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:53:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8127119
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:53:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso642474e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689231217; x=1691823217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ffGqa9xbCk52TLK2M6PcwQZHdBxMgCnoeVK2ogdo3w=;
        b=TpX3vt6EfpIOCclCvTKWyOFjacGQ1mu/cYxJf1X9kyLSDzbhZQ8fXb8dmiTK+la77I
         4usCjI82ZnPS0GA8Z+xhZr+m6ufLuGmX6LdXRj9bPh1yI7yESYBtBi3SlR1UR13PAy45
         UQpHQwyiqwxqF35TAOqbzNR9WT6k0QhUW8mdoBDDuH4rSJCoKVN9y2EXl1RDrdxX+Kah
         4Sh/1d1HaxWZI/CTIuZPa8BINZ7K6QsqKTFmbSkqFEjWYPQyXlS9xiDC9AKZzPQV8eRm
         kXCTbaBJ2rNS3xZO/Gn/mFeS2FdH/CxnUs3lXQRZAtuBKi53Gzf441EZtwaJZGbVOhGX
         C5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689231217; x=1691823217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ffGqa9xbCk52TLK2M6PcwQZHdBxMgCnoeVK2ogdo3w=;
        b=QHTm0dNO6Gi4mOHbmDiCRBscCNWDvXGTkBA6aJ9TRSDgUuwQjmvlJOfFR0Rn1MfYnB
         CDkuPdtvECzsep6Qb1tI4ht/3emVB/VBZl2eRq4yw0fCc/unlADyFvsdfjXmXjH2Tc0/
         fRTchbuGlsD/UKgYwN+jTpZaDxHOd5PhkyPXFUM2u3RygggIxTPhSmYf6t820FIrs2e1
         FaKuvwOiFWjbzYL84kkvVIudTf08FpA49IZG2XJhP2hM1WEVRIIY3gNsfk8MeyJlTdhF
         heM3xr68T6zMoVoWXcNdvHKsP2cIBpu3t5ItZ+qYsrYQIwDXT2MTHOWv+vP2ddedkIsE
         4Z3g==
X-Gm-Message-State: ABy/qLbxUT6mAvLbc+KZd9eFDRjUaxXexj7f10gJJIgQNsR1SKBpBWWF
        Ol5k6Fnu7AtL+QqDMffWEZWNCA==
X-Google-Smtp-Source: APBJJlHnOYj9GAW9NvUtU6lFBM2rgbKsls+nKKyjOimWGoQeTGroUemMOX7vZpo5eeFySIhMdwwjqw==
X-Received: by 2002:ac2:4647:0:b0:4fb:8965:7882 with SMTP id s7-20020ac24647000000b004fb89657882mr389459lfo.35.1689231216849;
        Wed, 12 Jul 2023 23:53:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d4cc3000000b00311299df211sm7024591wrt.77.2023.07.12.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:53:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: nuvoton: add missing cache properties
Date:   Thu, 13 Jul 2023 08:53:32 +0200
Message-Id: <168923116919.8134.8724484446996079684.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223154.115312-1-krzysztof.kozlowski@linaro.org>
References: <20230421223154.115312-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Apr 2023 00:31:54 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>   nuvoton-npcm845-evb.dtb: l2-cache: 'cache-level' is a required property
>   nuvoton-npcm845-evb.dtb: l2-cache: 'cache-unified' is a required property
> 
> 
> [...]

This was waiting on the list for long time, so I am picking it up. If someone
else prefers to take it, let me know.

Applied, thanks!

[1/1] arm64: dts: nuvoton: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/a8cf500c42c751b992f5480c390d6ad2419472e0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
