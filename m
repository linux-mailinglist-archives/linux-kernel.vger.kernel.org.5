Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1621B79FDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjINIKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjINIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:10:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F0DF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:10:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402d499580dso6818735e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694679037; x=1695283837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMQkGRZuOWX33tb/PbqZ09rPOB4FDk/5Zw4MRHH7S/U=;
        b=Y5XKTJ3awKNyiRBpjxXyfGWJqTzZ4r4RJVwHOwuINvVdMlEPYidfzaihFYi37Hsp20
         PXMYAVaqTsWJIAYKGtKtTAM68RAex7iGZ5SwdGx85PNUlAua/AKTbpuYZpFAgTagLpz/
         ERzlgmD9RNu0dHsfmw27K7LhM90M1IdjiFE6ahg2drjLy6knMYQZAsZtRvVkZpCqMtjJ
         0VfL01/78lGEMerF5rQ3C6pJ+EsYdXUPSczHXOs2UTcJF2Tfk7qBDa4Qle4Hw/xjXctX
         ish8wQJdkdURkrL8QNbB2KS0tTLJ0boa3HAIrn6ogE9x6EF74onpT+Y43MRPFaSc3HHf
         PPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679037; x=1695283837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMQkGRZuOWX33tb/PbqZ09rPOB4FDk/5Zw4MRHH7S/U=;
        b=D8vdK4okjjuELMGm8QMjKQBeCQYmDHRyAv/zB2IFG4OXqPUtvqIreOSHD5TTsEd9Pa
         qFllVjbJjEge6dY1+nQUcz0J7pZ1w3garIQmFCMrdkUR3+4707j1SrANFPTReT8Pc9jw
         PQkPvBnKlSmq/K1WjcJOdT/Rsh6t7I/kziw2xSeuEEno93Q8w1ZQkAVN77tKPQDW/rd/
         K6IGeYhLkWXZoQn0HKg7Ago2v+xJ2EIrn2hOqhN4CCC05CYOgPAwzAUDd02NRpI48kk+
         K9PdMmV5+OFTPnK7rluz1tc7u1gHWZFo/EHDdJULmou1mjkqczWOQKKLLqspTEojZHST
         sM1w==
X-Gm-Message-State: AOJu0Yx3sRyQqVELv9UCrLbPmNPvRBU7MADOvVl2HQfTPNay3M1ibXxD
        w2BQpSg63Vqj36coSgMZzySv/g==
X-Google-Smtp-Source: AGHT+IFxqQhwwTKH7xN4uv6LGeh2UbDCXDARXiHHlwBMWje0PJgx+4KKpeNEfWz3z+zCwLa6ijabNw==
X-Received: by 2002:a7b:cd1a:0:b0:3fd:1daf:abd8 with SMTP id f26-20020a7bcd1a000000b003fd1dafabd8mr4084494wmj.40.1694679037547;
        Thu, 14 Sep 2023 01:10:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b004030c778396sm4152155wmr.4.2023.09.14.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:10:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] arm64: dts: exynos: remove unused TMU alias
Date:   Thu, 14 Sep 2023 10:10:30 +0200
Message-Id: <169467902474.16247.5261231734946349576.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911133342.14028-1-m.majewski2@samsung.com>
References: <CGME20230911133414eucas1p116d395f8219ea34c284aa21d46033fa6@eucas1p1.samsung.com> <20230911133342.14028-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 15:33:39 +0200, Mateusz Majewski wrote:
> The ID of this alias is checked by the exynos-tmu driver, but isn't used
> anywhere and omitting it does not cause an error. Indeed, this is the
> only Exynos device that defines this alias.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: remove unused TMU alias
      https://git.kernel.org/krzk/linux/c/f28dde395937e000585ac87c0d1c18885661161d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
