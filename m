Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1009077B62E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjHNKMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjHNKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:11:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EF10F9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:10:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so29198315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692007854; x=1692612654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgN2oiVAhApfVm/31d/EjOaZdUELytGSbaFguIaDR9Q=;
        b=ZhdLzpdGuOhLUUVkGOy6ORKSCQCI+vZTdtqh331WBJAOVcqpOBt2bBPyt2NKia0+Jv
         9OoetT5cypoy2sVJGQzIgOwoh3zpoQQqwuMSahHL2XmXE4MPsOe7HLQSoFILGaO1oWq7
         cp/JS+EEz84vcoqEOi07jfSKqwLO6vpXMOrG34STIIeO2Vq7wqUlmhzrdS7xVxCJvXAj
         KbCtJP6+WMz1Vazfn/6wwH55YuxafB4i8GyTz+xd4V8n24UqY6S5vZYGhYZfozAKEtxa
         EDbot9am28PSjROBEl4igL7LrISfLpRXpBl7m/mxicK/3MbakFFBrkVAuowqa/l9qmgV
         E6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692007854; x=1692612654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgN2oiVAhApfVm/31d/EjOaZdUELytGSbaFguIaDR9Q=;
        b=MpHlbclSx8efuK01hByY6LNkuM6E17Qn4TgTfKLtjL+Ajk+8vSUU3s28h26tucle/R
         8Mik/TDJsAjm2lxLJ9vtkS1cMiFleoXCcGREYQ6y662plszd1SzDIDGQMLADsMXVUie2
         aAlV06imT5K1McSsyy0fGXrx9uLeRiAZ3y4SSFtJLFtqXwcg4utjC92gCV9Hg8BuvLlt
         C3CXAFjQuJDwxZmY/+kuda2P8OhIWgOc7HHCN6SllCI45zFMGPpnJsSTA55VwzPNp4EU
         iLbEs/dGCfq/30dGMm8EpBwGbHYHSq5txyhxS3sL2dxCkZRd2P87Mhap8TRN01jU0Ui4
         hocw==
X-Gm-Message-State: AOJu0Yy0S2ynFuvjCC9bmRSna1CCiw0lHgYO4WTqa7QO8wPB/XPEsqOJ
        WqUPn13zghONawll5QR0RwbpbQ==
X-Google-Smtp-Source: AGHT+IH+cZSHekOLwjMUJ152aJZabewgj2aJGaKl3OuqxxTBG+Z32qFTzMWt7ldEeXhpAH5Z/GiZZQ==
X-Received: by 2002:a05:600c:3b96:b0:3fe:10f8:8714 with SMTP id n22-20020a05600c3b9600b003fe10f88714mr9228555wms.7.1692007854435;
        Mon, 14 Aug 2023 03:10:54 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm16750396wmd.19.2023.08.14.03.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:10:53 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] ARM: imx25: print silicon revision at startup
Date:   Mon, 14 Aug 2023 13:09:59 +0300
Message-Id: <169200755848.527063.7971182196567978147.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802184046.153394-1-martin@kaiser.cx>
References: <20230802184046.153394-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Aug 2023 20:40:44 +0200, Martin Kaiser wrote:
> Resurrect the unused function to print the imx25 silicon revision at
> startup.
> 
> This patch set is blocking Arnd's work on enabling -Werror=missing-prototypes.
> 
> Arnd, could you pick up these patches in your tree as suggested by Stephen?
> 
> [...]

Applied, thanks!

[1/2] clk: imx25: print silicon revision during init
      commit: b8a06b125c245eb946d88847e052294a85b206c3
[2/2] clk: imx25: make __mx25_clocks_init return void
      commit: 5dc176079b7a8ba7ff89db10e0c9784856c79d7f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
