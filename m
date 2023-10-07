Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313DE7BC6C0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbjJGKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbjJGKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:23:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE09A2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:23:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so26563875e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696674203; x=1697279003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B624f8viZ/1zkGyjy2K58RrXte57gw6qOrvl3O2Wa+0=;
        b=Y8IVb66UOMpgNmqcVUEfVZqt9DY6BfUwElAoXzaaBouMVWearm4g+SntJMwkLI/W+X
         VI52OCyr2OfdXeHY2Etf/+5eGtIwot2Feb4kutxSqsQzC8CIWsADwd7fEa8KgCHh0z+a
         Zv3kxH8UGIdbu2aqlUfO27fP09jeE326Q7VgD2oK43/9ZPARzxy0wS1vZMk+kjZ/kIL5
         dhvHNx9LTpNJV30VfzXHkdoq1IgEvmNwT1ESIpalqUVUkLefFd+h1UQjCTPFIBAdeLPV
         brkRjH7qvES/xUut+kdUoZVm4uPNDBdswoFf6TN745wKazQSGQ9IMOjmrIrnubPL1wMP
         hmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696674203; x=1697279003;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B624f8viZ/1zkGyjy2K58RrXte57gw6qOrvl3O2Wa+0=;
        b=E2wHJyQ3pl8UrDJoOcyFNbRqczBYWEm4CE9KhhcH/FkkvpdtTPYmysCrdKrInmieb/
         d7siuSDMQfJBxlS7EeRDnzCI8PedZcQorNJYfKanQ8b/YZG7KdgwKfw2PvnoZMltrmRM
         4NvyTmALxhItm+5HNHJwpl1CVt6U0wp+6C9GZdGghKcES5zTt0Amx4ShETG/2wIwpK35
         0vb/IuEipf7X8oaZ0ATsdwBL8UKyuMwPdk8cpZTGf4EtbEkWx6fOrOVYVlxutvNrAux/
         c1UaZzwfeMWqaAFbZGNTBGp+QNzJQ4/NVZIz0HPzxP+nYxmpI53HKsbaKZVDp85YiB/Z
         ORxg==
X-Gm-Message-State: AOJu0Yx+xPfdoBqkp2DTgFT39M81nPHeC9yJFoR7A0TKGBl5EobnSdwr
        7kMyrQai4DGodkR9gFwJVCmKZGX8lGb0c+dPvoQ=
X-Google-Smtp-Source: AGHT+IH5tRDEMzH77PCOgReSaBgOwSItxJaZ10MvMZHUttF7QLJu7fn2XqzRDfBQvlqR1JLyeKH2qw==
X-Received: by 2002:a7b:c397:0:b0:401:b53e:6c40 with SMTP id s23-20020a7bc397000000b00401b53e6c40mr9663375wmj.10.1696674203044;
        Sat, 07 Oct 2023 03:23:23 -0700 (PDT)
Received: from [172.20.10.4] (82-132-213-54.dab.02.net. [82.132.213.54])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b00405391f485fsm5773401wmj.41.2023.10.07.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 03:23:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230926164529.102427-1-robh@kernel.org>
References: <20230926164529.102427-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: nvmem: u-boot,env: Add missing
 additionalProperties on child node schemas
Message-Id: <169667420087.74713.7725505612482066059.b4-ty@linaro.org>
Date:   Sat, 07 Oct 2023 11:23:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Sep 2023 11:45:25 -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: u-boot,env: Add missing additionalProperties on child node schemas
      commit: 8beb2ec54b65eb08891c9b9c23428712d46d8e15

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

