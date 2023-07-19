Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17BF759D92
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGSSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGSSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:39:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC27F0;
        Wed, 19 Jul 2023 11:39:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso6677142f8f.0;
        Wed, 19 Jul 2023 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689791977; x=1692383977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzzhHUMsEPca1REXinNBty7qrU/8lOnoSAoDZgJ76hk=;
        b=qBwFTggRpkj+jX6aVXXFeRKWjGvyH+s2zwyHsO8x4OwE36yuPr/YWDg0sB9FDZGOZA
         COVEaLg1lypqvCy1NhWKHWr/fFShKH/oRzRrVVEPZNuZrdJ51kh9ZvjUlsgXIiDkiBaa
         tIkHqJaAGX8rtax7s7wRpMbAUgreVL5TXfl8uRkwaaTfc2mj9Di9+SCSOv0HC/0vL+Te
         o6EvSiOLwE+LNdQjBiwwugiKf3mXbCKntldwGrw7bFvW4WN6JWmiZVjSZiVs5y8Eiyy2
         EF8HxjaUs9eu4iRmKHG/hTpacyzRbBembvnWO3Vhz5IbLRQhKI13lkV7HXeQSDh0PRvB
         M/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791977; x=1692383977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzzhHUMsEPca1REXinNBty7qrU/8lOnoSAoDZgJ76hk=;
        b=WiHdriZVS9g5/cZ7ekyiOKiF9KRUailOcG1qHk5QjaPJuYPBI1sKgqjOF+CZn6DiW7
         MYzlG4n7cLk6gkV157Hm92neL+bmBlbxNbVgyQRD2WKAho1wcaphdK1Bu6UkL2ugt60b
         9x6HTPrP0brw+yvg47wV3UePN7yrqif7YsRKTOxki9rcDx5HVCpF7iAxzUTeHlqSxRe3
         5jCj7hOtv+FiFaAbUeVMp6jFKkpuzlbsr6LeqBoIhk/4ytdebUu/PW3ctNicRo3WRFj1
         lMBpOhvnyi5Z4K6xnqu7yhEgVi6MSQCiQkXbZl3D596pRK/u5wEXYK+KkcNc7w2SHmQe
         DeNg==
X-Gm-Message-State: ABy/qLYDBLAOVLXyRwB31HGzeItAMxDGJVZzVW9Oy9JfYVTTK5WmB7M6
        uSM2hOSvli2CoCLGD0ZoFxhlZhf9IE1CSUrsOj0=
X-Google-Smtp-Source: APBJJlFejtxmv7imev+zeanVVRwqOImooJH6ndEfKqWAZjWaMbgyBEzzpOgezaGNdUJq3NIBmbFkAxhPTwAGJLJhp8M=
X-Received: by 2002:adf:e104:0:b0:316:d887:624a with SMTP id
 t4-20020adfe104000000b00316d887624amr495707wrz.15.1689791976882; Wed, 19 Jul
 2023 11:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230705090951.63762-1-dg573847474@gmail.com> <7266dc04-8db3-a48b-6844-8530ae7b8adf@roeck-us.net>
In-Reply-To: <7266dc04-8db3-a48b-6844-8530ae7b8adf@roeck-us.net>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 20 Jul 2023 02:39:25 +0800
Message-ID: <CAAo+4rVh4+VX3_EQyFasmfe4aC1aMN1nJmniMs+poUA63OTqFg@mail.gmail.com>
Subject: Re: [PATCH v3] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
To:     Guenter Roeck <linux@roeck-us.net>, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, wim@linux-watchdog.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks much for your time in reviewing the patch :)

Best Regards,
Chengfeng
