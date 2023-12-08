Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BDB809DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573402AbjLHIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573364AbjLHIKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:10:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574701712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:10:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3334254cfa3so1018907f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702023035; x=1702627835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8FGaQm/syjEXA6C0bhs8h/3pSINRWAqK55+7duT3eU=;
        b=X31HCTH/mlPH/6rd0xoqHX+N6/p36M9lRCK1QJ5sxaBdYMKVHGBA69faPi7KkZnXSq
         nVeF+2ucRkZGsXMMGlOkpAjQxOFfifAvhXC6ZUzBIn49HhjUsuPFGF1B/cFvXiD8Rp7C
         3ZW6aDmfSPIQBSYynclC7gh3GkDLJf5TZMo6AEO1Bef1z0EbIvQE1lg6ZF3bAlOaylaC
         68iQWj3bUsYeAHFj/FlcFLZ0xlwjgDltTWHsMTtXE8wbritDhO0RuEqN5p8ow4O4F7ls
         FLIlmrIwL01DfcZgSvz72sMq2CEJ0jHqOKe5V2euLr+KrsX95UjXp5NJ0jje0WnvaNYW
         fu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702023035; x=1702627835;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8FGaQm/syjEXA6C0bhs8h/3pSINRWAqK55+7duT3eU=;
        b=iZMRJ8QCZKy7Ax3F/ILAIcLpmvUNcaxIDIh6Nkj4ijLKcu3xnLWjq4JuV4dWI74jwT
         HJgcEwWzN9u0958kHZ9dB61tsAtm0PHW/O1410KOq5WOV1txNXTuZYltabRq8kCzHRZX
         X/YFkcGcskd7zFBtieH1pV1m6t5CCS6zIIBfL56dEkgwEKIDuxogbSoiZ143K5OQeNaO
         dV89QK2ATrmhtBWt6nRIVMvJfvC51pOUvWPz5KuDj1vhtnZCTorQWQlBtOrNulij24jT
         6kP1CylbETrAoOGD4oV3A4ZMV0lKdDwh9a9zsI1YZ64jalwaLqk1G0DW1CpZF2lmvFMp
         qODA==
X-Gm-Message-State: AOJu0Yz8HWRrk1iudd2HF1HABuozbViLQTUNr5B5447QGEOLwEjBDLgp
        SbanIiGRAY8Xi94KxHfTlI4DFQ==
X-Google-Smtp-Source: AGHT+IGTvNgK3uOf9L2pigwXmUD/tLFFR8tI+C9qX7tZ6nfsUK3ZEwzlQXMZvrv6SShWplMsW4KkSw==
X-Received: by 2002:a5d:4d8b:0:b0:333:2fd7:95ec with SMTP id b11-20020a5d4d8b000000b003332fd795ecmr210365wru.39.1702023034692;
        Fri, 08 Dec 2023 00:10:34 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d5641000000b00333dbecdce3sm1453191wrw.62.2023.12.08.00.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:10:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kris Chaplin <kris.chaplin@amd.com>,
        Thomas Delev <thomas.delev@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231207163318.2727816-1-robh@kernel.org>
References: <20231207163318.2727816-1-robh@kernel.org>
Subject: Re: [PATCH] w1: amd_axi_w1: Explicitly include correct DT includes
Message-Id: <170202303354.5900.12072769319108903531.b4-ty@linaro.org>
Date:   Fri, 08 Dec 2023 09:10:33 +0100
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


On Thu, 07 Dec 2023 10:33:18 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] w1: amd_axi_w1: Explicitly include correct DT includes
      https://git.kernel.org/krzk/linux-w1/c/efc19c44aa442197ddcbb157c6ca54a56eba8c4e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

