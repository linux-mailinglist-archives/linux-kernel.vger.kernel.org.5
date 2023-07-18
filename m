Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A875852C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGRSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGRSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:54:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994B1AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:54:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-521650a7603so6453952a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689706456; x=1692298456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QzAKitk3M/tN75cEvJiwBGx+1rjMeU/r6c+9hcTI2Q=;
        b=wHiBnqi7Vx9r8u8s557orKE86gCcAIC0d9/7U1tS7zTC+Ucvm22e/Od5MjZKGa39bB
         ak3RRizdhmCmbePS75G87CH3y5Q9fh7wLriwlsvgxIrvw/bWiUNnBU43SaAgrw/z3cRV
         7KWVHvezokyY6I34Qn4iUug88zEKWV6vYBNbEdwyL29BhFYEU989t0tNwFca6mw28bak
         3ALzVfVs2uYnQKxF9/2R4yoOpb6nfeQqvUpJoB6nTc0oq2Lze8SCNx0u5ZU6xMAPs+Ci
         ZkPdM0BjYiScnBj7ubpqJga6xvgu43nFnNuoXIz9ujETIOjyWPo4xL8g8qI3OjCl3CBA
         P1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706456; x=1692298456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QzAKitk3M/tN75cEvJiwBGx+1rjMeU/r6c+9hcTI2Q=;
        b=caiNVM8dHYFeqh0c5vTAUK++vV+9L4hxOmsqsQCZD0b3DO+greAiCh+QLeFobR83rS
         uC2sn8UwB9Odk1Qima/D4X6KhriLjo8lr/Gj/nUTrEPD5do920VFAWEzsyLn8eS6evM0
         Rdn8UDSsQJ8XQNB9C78JbthIrc/FDdTSJMCIaWy8b6a3VW1C3e7oKR/BxU/C8h0VPzIT
         dnQyD6NnPvogq3TGjCLhluMcvHh78WBuA+e6ShI9/2D5U5AIP372SkGDBpy9rYIGpvVq
         pRTqcQq181R/6knjI/r2pkhW3NjvDzl3syLltbt4wXUM8vpoR/ucYFMBJXxa47VqLWd1
         g/Ng==
X-Gm-Message-State: ABy/qLarOxz+qwCONDVOqRdblG/wY81ZoscLuxHAxbMnNXJ4m9PFSk0v
        NVhAPL2Zc/loAlna4LM/2b75BA==
X-Google-Smtp-Source: APBJJlHD3W8eXwA+SxkLrNtZe1CbFOTUDJIxZyaynp3KQUx904kSrREvv8IvO4Wib73xTYg66B+DgQ==
X-Received: by 2002:aa7:d991:0:b0:521:775b:ec9e with SMTP id u17-20020aa7d991000000b00521775bec9emr644143eds.17.1689706456229;
        Tue, 18 Jul 2023 11:54:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7cf8b000000b0051df13f1d8fsm1608611edx.71.2023.07.18.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:54:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Prefer octal over symbolic permissions
Date:   Tue, 18 Jul 2023 20:53:56 +0200
Message-Id: <168970643386.118933.11425570509753211683.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714150116.2823766-1-thierry.reding@gmail.com>
References: <20230714150116.2823766-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 17:01:16 +0200, Thierry Reding wrote:
> checkpatch recommends using octal permissions instead of symbolic
> permissions. Switch the debugfs files to use the former to silence
> these warnings.
> 
> 

Applied, thanks!

[1/1] memory: tegra: Prefer octal over symbolic permissions
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f54abe0132e405cd482b8cad355cd680e3aec810

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
