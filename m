Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03E4751E21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjGMKDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjGMKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:03:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5C269F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:03:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so583808a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242586; x=1691834586;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGlDIyrrfNAq/yp93QtArxGFLqlQI2VbX5YT6nCkJec=;
        b=dRMUT/whHAaqfW62jCLHfa3YAYIoSb/L33DoG8qef7m5uyaWftiZ6aHVo7EdPXCuue
         mpWPNSlvyDl8E9zg488amopoa40UCmSROulQTLgONzQoY9OwZARbI4e5hSDRXj4af3LT
         j9seR79WLt5m98CBWnG6TUkMNdKP0ZYBuMYOHLn+NsSLnk8yuvdguLDmEcu9j035kGPX
         ZnY+KHBUCez2YbTt6zxHoviEu0cdLcB4AzaUiN4DUGrwTOHUMQ1IZXty8rRu2bzIK5hB
         KErrA/clD3DcD+itYeG1hxtH+tDXK/yDY/8jmCnbN/p5Sc144FjYlZb5/RqUod4sgzje
         ejAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242586; x=1691834586;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGlDIyrrfNAq/yp93QtArxGFLqlQI2VbX5YT6nCkJec=;
        b=frLGd+16XUia8101cxpQf9uVuaPiJ8VO+D5kbWN69BbHwL/k3qQ7uK/++4x+y4nD9/
         iV9dYrWziwgM8b1qzxogsW/PXx8b2y15Y+nvm8YWgfKxnYr4tIHN/zoDTEKCj6FDIeGJ
         EDN7zADkmEVW2yF8hnXEHNnclmMdYP9aWKQN1ngHbf6d8eZL2UgGtqR7dPstioCvC8eW
         5QqO/B6iHP4eBfBfby2X/Jw+02xZyy4kKmwN49hQC2oVrB6/cjfRloENw4q33bOXjOSu
         vampUCGMAEj73VwarmXxU5JuRHJG5BEFAhc4QoHZjnSAJBSBig1VSLyjTXHpMFP0k71G
         dxHQ==
X-Gm-Message-State: ABy/qLb1sfCfgY2jIqdZZzZsemGQbjMSd+NEx43WGZjcotFojEMQiFy8
        0chKmqMvQFWsl/K0Dyu+JvXssja/hrTCstD/cQ7VLA==
X-Google-Smtp-Source: APBJJlG0P8JjG7quzdt3aed4/aGpuXKVi0PuT9bBYRTMrdueHE8H83Z1oxV0y7WYLZqDc96rvJyz9g==
X-Received: by 2002:aa7:d511:0:b0:51d:91d2:335b with SMTP id y17-20020aa7d511000000b0051d91d2335bmr1561993edq.1.1689242586245;
        Thu, 13 Jul 2023 03:03:06 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w22-20020a056402071600b0051de3c6c5e5sm4007740edx.94.2023.07.13.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:03:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20230627204630.9476-1-zajec5@gmail.com>
References: <20230627204630.9476-1-zajec5@gmail.com>
Subject: Re: [PATCH V4] dt-bindings: nvmem: fixed-cell: add compatible for
 MAC cells
Message-Id: <168924258532.15442.13233045007197917854.b4-ty@linaro.org>
Date:   Thu, 13 Jul 2023 11:03:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 22:46:30 +0200, Rafał Miłecki wrote:
> A lot of home routers have NVMEM fixed cells containing MAC address that
> need some further processing. In ~99% cases MAC needs to be:
> 1. Optionally parsed from ASCII format
> 2. Increased by a vendor-picked value
> 
> There was already an attempt to design a binding for that at NVMEM
> device level in the past. It wasn't accepted though as it didn't really
> fit NVMEM device layer.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
      commit: b7495ea1b534fa4d73e5132f05ecc79f5068aa22

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

