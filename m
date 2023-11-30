Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF777FFE39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377164AbjK3WBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377109AbjK3WAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:00:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAD1704
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2865742e256so71777a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381658; x=1701986458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dVg37Ua/Fw8B4HenbavCwGuNNfMvZwQLsawmvgiFEY=;
        b=JaAtaLETeFPcZfLusfg+sVJzpWLsuAnHiF2ftTLldOgh8PGm1K+jcKT7qD5jL23Y5b
         lFbljIXPc6G3TpAFhop5eyrzmfyYPp4xnxP7X/ZX43azb5/DUv7TnUN6MZ65uO0wYhzT
         whchbSeKkeXB3Bwdloc3VENkPE13cmHm8ggdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381658; x=1701986458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dVg37Ua/Fw8B4HenbavCwGuNNfMvZwQLsawmvgiFEY=;
        b=BaZ3CSYijh7TQUr8F3Y7IgRdmbhEI3kk2xvIM8zdaNpBq6Hc65zrhltICQIk1RJSLi
         KF5Vf5WV44PS/cRQbkDSKBbcOQ4Q5JSZahE+3RB8g51Lhf7qpszjtb8A/PVidE19vUbQ
         gGpsMy18tAM89FojB2uMswHbHRW53SQncmpHJILnoLo5W9kKF6OVVsCJWwx/0QwQyLFz
         EtN0Ab0fYl6m9sh0+feCKpvZE70Dio2TMVvhSI6gJ5Ozyis+PRxKjLRQW/nqAxbWtu7K
         mSSud6FRrRMBGjq3vES3umJ90KKwWDryW8EznSVeS0yUw74mI/p+hP2Zd9/v+E6oBiyg
         27dw==
X-Gm-Message-State: AOJu0Yxki+EJtBPIpdiJ8dfcTzYuRwWa7BcSNabimX6IWd1CZJbtnT2R
        yfvToHZ3LPw8+ADL9QZesyy5KQ==
X-Google-Smtp-Source: AGHT+IFVQzyt3ZEAJi0Q3FYVK8pWYeRrbWgsx+Kjpk955Jz4SeetOEmMkauMSk0Wlc5GDWJ/xhk5wA==
X-Received: by 2002:a17:90a:717:b0:280:2840:80bd with SMTP id l23-20020a17090a071700b00280284080bdmr20463973pjl.49.1701381658572;
        Thu, 30 Nov 2023 14:00:58 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id qe16-20020a17090b4f9000b002864ab4dfffsm895373pjb.11.2023.11.30.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:58 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
Date:   Thu, 30 Nov 2023 14:00:54 -0800
Message-Id: <170138165207.3649333.12518532307083460238.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 22:48:49 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both data->subsysnqn and data->hostnqn to be NUL-terminated
> based on their usage with format specifier ("%s"):
> fabrics.c:
> 322: dev_err(ctrl->device,
> 323:   "%s, subsysnqn \"%s\"\n",
> 324:   inv_data, data->subsysnqn);
> ...
> 349: dev_err(ctrl->device,
> 350: 	 "Connect for subsystem %s is not allowed, hostnqn: %s\n",
> 351: 	 data->subsysnqn, data->hostnqn);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nvme-fabrics: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/5ef935fd5520

Take care,

-- 
Kees Cook

