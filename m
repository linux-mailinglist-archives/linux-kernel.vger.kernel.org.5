Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23288751E12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjGMKCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGMKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:01:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E62626B7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:01:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9924ac01f98so82642966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242469; x=1691834469;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/M+pj3sOHUyESIK93V4GQh+1nRLUFIcF7Y/I33mUxQ=;
        b=PF7NZgKmP2RkxrFnKSy8s1zMvSzfBwLHcqSq6qpC/yOx85SeOX1/IiEz5B/pYvd0gd
         X3Q5tU+pWDcsIbxZlW0q3x5jZDkYwmoxuELnwD0x+E7wvRCdiS5ldf1pbZPMZf1Nl8bL
         IZScRt/OQVD8uGoFKVqs5zKtJpwVfMYjQYSM9rHz9r82Ny1hJi5TfgqV4W0v2ZU3JBnp
         pMe9L/xGL8jox8/ixOz1oBBXuOndXcz86iAE9qr4wH8GJFsvht0MaZ4hmwZXhTThiDYz
         9LSaAFq9adU+W2nsTYLz/SlmXS/xT2xNAnhAIE3egnJFex1DHAytr3q6VbZ/vl4X7TGw
         no2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242469; x=1691834469;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/M+pj3sOHUyESIK93V4GQh+1nRLUFIcF7Y/I33mUxQ=;
        b=R/5JUqPfvnT5Z1Wfedgp332/4zp8KmSfpTPqVyqwpMF7FtzFJCqLnVHm7UbpA3Rs4G
         h/mhwP04dxKfQIvLrlZpqQZfy1ndvMS5llkyqgV4z9tAK6I6K+jheXoEgOqrgzsp5yAA
         ZYJ6g2GADd9fHhPHLfyYovQPHG5eZ098eQ4t58/A9DOeJN5jOflXyAVE5/n453wd3XEV
         m9R4SSzmsHhg5wEheTLjZaD+Ef2hJWhywGQ+0yn81rv5NFj7zWNuhJFumv8fmXnCPLrd
         HDpnYrDYb4GM2Q7zFhyooO6dERdi18o8RGEINEuTSX6ODs83S7quebmqosqUkNLlJJVt
         pHVg==
X-Gm-Message-State: ABy/qLZogLbdNraw8W8u4g3c3p/gBkrNej0x70m/TkwAmmbD7tt77N4W
        nlPk7b3dOMlyA234f2qnhK0jNQ==
X-Google-Smtp-Source: APBJJlEqtwreGESohUF4BGCg9ioea4Pgd3hPuliT8cWOafgfdREMplipu6B24Py+pFdOX3VMzCi38g==
X-Received: by 2002:a17:906:1c9:b0:994:758:fa4a with SMTP id 9-20020a17090601c900b009940758fa4amr1038460ejj.46.1689242468874;
        Thu, 13 Jul 2023 03:01:08 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id lf16-20020a170907175000b00993928e4d1bsm3776545ejc.24.2023.07.13.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:01:08 -0700 (PDT)
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
In-Reply-To: <20230616213033.8451-1-zajec5@gmail.com>
References: <20230616213033.8451-1-zajec5@gmail.com>
Subject: Re: [PATCH] dt-bindings: nvmem: fixed-cell: add compatibles for
 MAC cells
Message-Id: <168924246786.15304.6050913171032604227.b4-ty@linaro.org>
Date:   Thu, 13 Jul 2023 11:01:07 +0100
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


On Fri, 16 Jun 2023 23:30:33 +0200, Rafał Miłecki wrote:
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

[1/1] dt-bindings: nvmem: fixed-cell: add compatibles for MAC cells
      commit: a7964674427bdf5aa9ff342e4dfb8a4d345851a1

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

