Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A535E766541
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjG1HZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjG1HZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:25:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831024209
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:25:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe110de3b6so517895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690529124; x=1691133924;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC2uPCbToE0m3ZToGXtqKgfNYoGwnR2bOs0T+f4TQb4=;
        b=krhHtg/yZG28sgoKDE4q3E0qt1xKkATMNX7S9hgWxcNXVhXB0WtCWYAbedtQnnsXvZ
         2ThZm40tzSe5LL4VHeC85M4j3LKlgppVdsbgtggeLHmcuMRt4OXbevYUl0S8kRFlAdAy
         1Mrm/pgf/NLqJNeImWoEfRNDz9G+xLjuRch9n3ZGMltabpexIcylSC8bqOU0T6iLvQxH
         ZmDSUmv4rDQdrLlrTf969I7FcVunYXprrqK0c+Bt5q0RhJD+WJ7uT55PRKwnmkeZ6fq2
         iQMgtfawbQqCF4LtP8nbh0quXheR7qUX/PBwJQcB7nzGhLLexSBa9/TX+2Ukj2dfJulH
         IqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529124; x=1691133924;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC2uPCbToE0m3ZToGXtqKgfNYoGwnR2bOs0T+f4TQb4=;
        b=Mxgr58/YOFZSQlMI87y6GnTK4FnKA3rTHhUF13IrqpcVkMW+u6h3SJW1sIKm0kfqpI
         /gAGMJhg2jBJZWGComHBh/3OTG2ZxZSsgbCHBBCUWPMd8sbbkSM062MhIi/+bXFYf6Ok
         anKPnd1W3sawK66vp5WGWtvBIVFlTh5F7LwXXPSBkA+646pVqM/6jKrFAaBAIqS8kHH4
         JRdBYPtNIFV5AA1P4W6UQEtzxWdm+4LwRIqluK4LLk76aIJnnXozVvMBxXWJwSgOmEP5
         CA0SPj4ZTHb8OEeTU06CMHo8WnWW1C4ag2Na39wf5XBPNx/D6gDN4l/ZlnNz/331QRWQ
         g/UQ==
X-Gm-Message-State: ABy/qLahHmS1p/X6pVNLGJkP6pqeSm0cIg/ZhrTApppRRVC4UtdcM2C+
        0r7IFWS/EnwQM5g32wDcAz/ENg==
X-Google-Smtp-Source: APBJJlGxDsJHoN183tKnzmjRp61u82uZlHM4MzMqviCdk6CR2wdFNVMjPnD1hSjVTNyE8calyxsKNA==
X-Received: by 2002:a1c:750a:0:b0:3fb:af9a:bf30 with SMTP id o10-20020a1c750a000000b003fbaf9abf30mr1221542wmc.2.1690529123882;
        Fri, 28 Jul 2023 00:25:23 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b003063db8f45bsm4029311wrv.23.2023.07.28.00.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:25:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Richard Alpe <richard@bit42.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se
In-Reply-To: <20230410082051.2948510-1-richard@bit42.se>
References: <20230410082051.2948510-1-richard@bit42.se>
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
Message-Id: <169052912292.84958.2878083739379282423.b4-ty@linaro.org>
Date:   Fri, 28 Jul 2023 08:25:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Apr 2023 10:20:50 +0200, Richard Alpe wrote:
> Add a schema for the NVMEM eFuse (SFP) layout on the NXP QorIQ SOC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
      commit: ed5254aa4a61373570657ac66d9362dc89027ca1
[2/2] nvmem: add new NXP QorIQ eFuse driver
      commit: 435e3ef5a1d39a2c7b00963e0bff9e5eed5e1147

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

