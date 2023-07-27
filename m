Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1907A765810
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjG0PxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjG0PxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B263271E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68336d06620so1164606b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473183; x=1691077983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyEHfmIdAZusP8ylrb9Uotw6HIeOEzJpt2mwB5LGftM=;
        b=Qcb8L8Ho6rOn1rC0EiVFDR15Gh9M3knRrx7sGFT9bNXn73IpUcHWtyKa13fEUffXeK
         UtOsTQxVrQm4KgUF6Bbc1cwf4alq6fcsogcAjy7fWRZzjcBGeLPKUvlLclFTldRRCjGi
         Qo84N3OjMXDAmjirE1Idm2pfWEUd1qgnKpFqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473183; x=1691077983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyEHfmIdAZusP8ylrb9Uotw6HIeOEzJpt2mwB5LGftM=;
        b=YoJsZF2OeuGap0QMbXcv8Q4DXGrG23quRBFBHRf8DjHIvuVCcCMd2V9LANZa+7XKgE
         bZ57aVLQgibTQ13esrPE7mcarxbn9PdNfm8izX1j61X/rn5ao2LDQIQbWmIT/4knd3mL
         3388ypmZuWZqNgVjKFyRRgeSS7AE8C7yO2BJMeiwgYXARva79jHD85u4Voj+GKepGSSW
         UCh7PHiQthz+qIU1z0T5Fk80MvacW6JOuewEVBaZopHPkt78EbZVZ0MsVovI01KUc2M9
         EOS7TSHzuZeEimfm6jmt1Lca6kNXvdUkxgvH04CLCLn60jLvxey0hKQaNY24ExC10nWL
         t8fg==
X-Gm-Message-State: ABy/qLbqKf3hmvS32X4FcXYFo2pdLtWD7Pl0llbf8467O7gpWNUWKk0t
        +bgPL53fD/+RVjPyMsEQv6KoNDUanSneDC9KCG4=
X-Google-Smtp-Source: APBJJlFoqyR2BKZ04r1FIOAJFPAZ8Ovm5FIqBgpxC7jWT4bd8oyWfIY99FOQVec6GXJfK47I2TYYGw==
X-Received: by 2002:a17:902:dac4:b0:1bb:cd10:8209 with SMTP id q4-20020a170902dac400b001bbcd108209mr5450270plx.50.1690473182764;
        Thu, 27 Jul 2023 08:53:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001b89c313185sm1807914plx.205.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:56 -0700
Message-Id: <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710030625.812707-1-azeemshaikh38@gmail.com>
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Jul 2023 03:06:25 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied, thanks!

[1/1] wifi: mwifiex: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/5469fb73e96d

Best regards,
-- 
Kees Cook

