Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA707BC6AE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbjJGKR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:17:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CDF92
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:17:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406618d080eso28140765e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696673842; x=1697278642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUq2GChJDBAKCbgHi9jypYjxbAWC/TgAtVYt/nWCOxI=;
        b=LRCg/JePTXrJROCmkrJy51M+HjTv83bXmqyZDreFfOAQIQMQvFSef4rKD/y4fPwKpH
         FGL0X+lYQHjZvDZ7TSnWw8nza4ByJAySkqKc2bRFndX9yktIKuq5eIWvPW/qftrXuVNR
         M9f6szhsS2hebuXL1nVtSmRjAUkBhC7STLvZqywC5MK9VsNuzi4wYD9FnYZ1VQ4N4Yyr
         D3AHlY+NXPMCVNy7Pvzz9IXo1fcMJbsix2TMwqYHZE1/0Nwdt33VgZpL6mSqk5zEtNFO
         Biespn87VIxTQYjmII+HW2N3JdQbDxF9ZG18MRBhO11mvUEbDkm8f0q5MAHJAapT7WNx
         RAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696673842; x=1697278642;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUq2GChJDBAKCbgHi9jypYjxbAWC/TgAtVYt/nWCOxI=;
        b=FN/UeTjr+CQ8aRTuNQ/4HHYocHMZXCvTBXkg+gyJFat9IfE53Mdh7tfVlxDwT0/KvI
         yR3zzZM+EAYEfV57ZuS/HpnNpPgvwg7Yb9rxppfP85aqR+3YVdWHqK3yx1SPuspAJhs0
         FHhcH+W8sv2jC0NRyvuaO2KpE5huxLOrBgp4DF++S+3V8II1te0xzByFZDEo8dVUdFWe
         f6qvdIVE4L/0wtm4zHDposXs9HbrrYVKvd3c0PHSWn4/pNvWI9e9qS+TqPLQTB2mNKA1
         ZgZEvlmT9u37u304ioCxwNPsnn837fmJ2d4x/7e0sOdDHAFt11IkmVhxLQz39jnHnz2p
         rRqA==
X-Gm-Message-State: AOJu0Yx9Ik7mvfNovG1L+tQWxLw2+dYrjqTLvSpY8rDioFR6AK1A2K/k
        m04esk2jaPxDyB+CFHtreBNaiQ==
X-Google-Smtp-Source: AGHT+IH5RU1FO5UDsMVN6VHVw0Z9Pw2rfg0BXTjWX5ElKB1kOGIgKscevIIUak6oNQPhBUiSM6Z2xA==
X-Received: by 2002:a7b:c397:0:b0:406:52f1:7e6f with SMTP id s23-20020a7bc397000000b0040652f17e6fmr9554590wmj.12.1696673842247;
        Sat, 07 Oct 2023 03:17:22 -0700 (PDT)
Received: from [172.20.10.4] (82-132-213-54.dab.02.net. [82.132.213.54])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b003279518f51dsm3892835wro.2.2023.10.07.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 03:17:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alban Bedel <albeu@free.fr>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20230718084804.20139-1-zajec5@gmail.com>
References: <20230718084804.20139-1-zajec5@gmail.com>
Subject: Re: [PATCH] Revert "nvmem: add new config option"
Message-Id: <169667383992.74538.16857754377608067842.b4-ty@linaro.org>
Date:   Sat, 07 Oct 2023 11:17:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 10:48:04 +0200, Rafał Miłecki wrote:
> This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
> 
> It seems that "no_of_node" config option was added to help mtd's case.
> 
> DT nodes of MTD partitions (that are also NVMEM devices) may contain
> subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
> NVMEM core code from parsing them "no_of_node" was set to true and that
> made for_each_child_of_node() in NVMEM a no-op.
> 
> [...]

Applied, thanks!

[1/1] Revert "nvmem: add new config option"
      commit: bb519262f1a9b4c37046be5a3851ab1681d7158a

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

