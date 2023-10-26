Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1367D7F48
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbjJZJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZJFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:05:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF50128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:05:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507c5249d55so920228e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698311114; x=1698915914; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2oJ1jlhG9oorUzXX4oCyrJv+zqn7eGeLFSxbQPDqXZA=;
        b=ESKih3a57luFdaSENN83jzufTDZnZFreqhyMIaY3HwW3yOCS8bGmDeM8yW1IDWrwMe
         HQCT+V2CKMdIy1K3qsAURH0m8iTAFzbqQ/vWInQ9DtRb0faDxRkus9eu/bVnbHaGzHip
         bDuYbkLLX+k+398lKiK3Zr3z/E9ULiL8+CwkbLAPzQvtmrhoZuVOQsVES1K7k1iKsCOv
         6R5rAAfe4uVcD6sVoZP67vFAD6Ocl0lJnINVdfCdCTLoBja5iLFiq9z88iHfXnZtjugw
         +iEUKQrui/+ozLxAejZnxPX4wfV33gYS0Dc9khZmiVScuHVFlHI9iC4I5z7MEnZN/ykF
         cL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698311114; x=1698915914;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oJ1jlhG9oorUzXX4oCyrJv+zqn7eGeLFSxbQPDqXZA=;
        b=I9baDslWCa0zRbx+pzj4cMwUeBbB5Wj9xpMNBJ9S3zhXHnHFGlXElNdn7c9TldBg/Q
         2yOMjKMXoofQYC8EhOWVpPWCfEMz5i8Hnd6LS21poHsjc3+xRwBGoXU/Bu+eOIHVp1ME
         xldfSi4Fkrs6iIEJswLcNXtb7qyWDe9AW4G6fBwrWlOefHNbSoUGs5Cn1lI1thhq8Aqd
         by7IfohmaxGE7TqfWZQoN0Z+Tsf7DhI7lYDho1qjmjuyOY2gHgXoPQDtnbAeh6ZMUXZo
         yPjwDdMCwpZKi5J7btW9PlZoDfYYwTQ5e/JyojWNeLuEwYNpQt0XS+hqqNkTp/bY4gsk
         4EvA==
X-Gm-Message-State: AOJu0YxYwIuuG4A6SToMYQPABVzH4x/PlHsBHVStw5yni8JmEQwTN2gb
        qZ4UFWs3CaQ5lIymFXAU18znfw==
X-Google-Smtp-Source: AGHT+IEcCo3MOL+v7ls4UAXtPy1Nexq4e+KJmgrR62ctOhHdOSO3Z3oUqSIP3cFHn7yVMZtyqgo36Q==
X-Received: by 2002:ac2:538b:0:b0:507:ae8b:a573 with SMTP id g11-20020ac2538b000000b00507ae8ba573mr12792622lfh.51.1698311113795;
        Thu, 26 Oct 2023 02:05:13 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d5c0:32f3:899b:123c])
        by smtp.gmail.com with ESMTPSA id az32-20020a05600c602000b004053e9276easm2005317wmb.32.2023.10.26.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:05:13 -0700 (PDT)
References: <20231026073156.2868310-1-rong.chen@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "Rong.Chen" <rong.chen@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
Date:   Thu, 26 Oct 2023 11:01:53 +0200
In-reply-to: <20231026073156.2868310-1-rong.chen@amlogic.com>
Message-ID: <1j34xx4uuv.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 26 Oct 2023 at 15:31, "Rong.Chen" <rong.chen@amlogic.com> wrote:

> From: Rong Chen <rong.chen@amlogic.com>
>
> For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
> Starting from SoC family C3, setting this bit without SG LINK data
> address will cause the controller to generate an IRQ and stop working.
>
> To fix it, don't set the bit CMD_CFG_ERROR anymore.
>
> Fixes: 18f92bc02f17 ("mmc: meson-gx: make sure the descriptor is stopped on errors")
> Signed-off-by: Rong Chen <rong.chen@amlogic.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 9837dab096e6..c7c067b9415a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  
>  	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>  	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
> -	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
>  
>  	meson_mmc_set_response_bits(cmd, &cmd_cfg);

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
