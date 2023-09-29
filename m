Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E197B3A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjI2TPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjI2TPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:15:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4271B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:15:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bd8f89baso11743162b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014904; x=1696619704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGE+mhT2J6BxwaI8MX/iLRb/F1GWPeFnuoGQKhDB53k=;
        b=GVglu8Nj7jisIEkxrDhQbeuRbWX8htfLe5FWp6e9gQlQIHEQDDf4krF1LXH7orhySN
         MQ7P4AjCuyt3oRcQJqJB2l7aOomyefTHgCL/YFnCHRkUbMCkTuOWUiEyvxU6Jvpp5bpi
         S3ibDWSG0pYApj1tvwpQbUYsnZbXudff7oee0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014904; x=1696619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGE+mhT2J6BxwaI8MX/iLRb/F1GWPeFnuoGQKhDB53k=;
        b=lYkHxjcyl/+joCNtru3ZBb9S0uuzC20dE8aUom3Ej7Amqh1c86nXZD2qEzZGq2t2Ma
         0sIE2GzW7xRU0SdAA/OHaOE9JQMS6XxoXAPjnxSwiE6stahJWDiIQy25I5dIR7Z+I+lH
         sxIz7e6znVmcbwH6rT6eHPZalfRQ7l8cILF19edOMtJLvgDwyyY9zEwX+nwiRxdT8u1m
         opHdPZY7VtHgXx/e7rM1+MMyO1GD6KaeIpE/i3SlvAbCktmQrcQKRj7h3pHZLFoyGLV6
         21ZJ1TRuJjdpeplimKyPmgUyabzupb2DrQDQWBLsnCy3hJqMenk2TjhgSTmNuiui1TLJ
         dVrg==
X-Gm-Message-State: AOJu0YxbD6mCity9eQ+XN8M3rskzyhC6uFAsLDjL1DXihFB9YntULu6z
        cFhjPyUXXIecVxcuyWDr127Hcw==
X-Google-Smtp-Source: AGHT+IGdWrWALlMstgZLw0gTzX8sPC+R7tbZh2lrWw0eupjJZhVRje8lP169zMl1usYEXoSsJDs8vg==
X-Received: by 2002:a05:6a21:4985:b0:140:c838:2b2e with SMTP id ax5-20020a056a21498500b00140c8382b2emr5182838pzc.22.1696014904595;
        Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b0069337938bdcsm4816734pfd.125.2023.09.29.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:15:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
Date:   Fri, 29 Sep 2023 12:14:59 -0700
Message-Id: <169601489953.3012131.13922425518082792309.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZQSr15AYJpDpipg6@work>
References: <ZQSr15AYJpDpipg6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:09:11 -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
      https://git.kernel.org/kees/c/93d2858dd630

Take care,

-- 
Kees Cook

