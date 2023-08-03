Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9A76E333
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjHCIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjHCIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:33:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEDD4ED6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:30:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so7051925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691051416; x=1691656216;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNIwIsxjJmaxEOlzObqYJVtWFyFSXBlHeRED/hdg1QM=;
        b=zkUcyVf3rAwfq2kXleCApjRklB37tbgUSpZJZcWihX4YqFsXhDPT08HsaeexVppIJN
         BiU979I05J7Ofco1yJWqA2Selw2anFzQlMJ9b52bRDU5eSQu+4HDT3WaWhqRYYJNXco0
         607gAj2kCIAI4OOaryKYJVoHAkZqOgEGJCeyy6Kv6afJRG6e8PnwJh82sAfN/mWJaieu
         mMgdCZhaqDtzx4UUKqHD4XYciCWO4ial6KfutteiIblA0R2kN2yxKpd8vnQeAsp1Vawr
         1wR4BsZQgBhVIZbRqxJ5os3lbxJnlsjlUtyZgsSFHhPAEDqNcyFQWozO1WWvxAGUcBuy
         AGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051416; x=1691656216;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNIwIsxjJmaxEOlzObqYJVtWFyFSXBlHeRED/hdg1QM=;
        b=G5Z1eJ6wQNf3uj1NQIgfYAAR0F76FYX7CkLD7lLIRy34Qkwug3maXuJj19Trn6oI93
         Y/BmhwJCcoh1LSdiEe1eGPS9R2AuxOd7mrVlQK6lzz4eKBmjZVPFHOPXrRXxeUYp0q5O
         sKBTOyEMhhbRrTu6cT0d7p+mo/FvxSnrciMgo4Dgdf9KwmUbI8k6N0inZ3hm6JblPYiW
         0wPvfosWuHKUg+lfNtRmXKgcI61WsOpfHicd1vUGkV4hJ021U2bX50OEmQil2JkjLUQz
         VMU4zjVe6g+Vdx0PN9FmIUYaa6bV4P3nUwjv8hUjtPeH366DtR+41WUHAlEmhNy0+iHb
         3u8w==
X-Gm-Message-State: ABy/qLYNNyktiS+cw+XWKyanfQCT6EjGu6vsq+Qdl3+of2vyc7kZOSI9
        1CAjA8BNwPhevk9/tH2RfRZpRQ==
X-Google-Smtp-Source: APBJJlEmlEgVB4qWrr+du5op9x/yldXQVJG0mpC1p+iIiQpwaJOgPx/9LF3cVhUUTgDcV982JHnuWw==
X-Received: by 2002:a7b:c4c5:0:b0:3fe:19cf:93c9 with SMTP id g5-20020a7bc4c5000000b003fe19cf93c9mr6412813wmk.1.1691051415958;
        Thu, 03 Aug 2023 01:30:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c219600b003fc080acf68sm3646649wme.34.2023.08.03.01.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:30:15 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     andrzej.hajda@intel.com, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        u.kleine-koenig@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandor Yu <Sandor.yu@nxp.com>
In-Reply-To: <20230721124415.1513223-1-Sandor.yu@nxp.com>
References: <20230721124415.1513223-1-Sandor.yu@nxp.com>
Subject: Re: [PATCH] drm: bridge: dw_hdmi: Add cec suspend/resume functions
Message-Id: <169105141513.2515343.11302551139534235865.b4-ty@linaro.org>
Date:   Thu, 03 Aug 2023 10:30:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jul 2023 20:44:15 +0800, Sandor Yu wrote:
> CEC interrupt status/mask and logical address registers
> will be reset when device enter suspend.
> It will cause cec fail to work after device resume.
> Add CEC suspend/resume functions, reinitialize logical address registers
> and restore interrupt status/mask registers after resume.
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: bridge: dw_hdmi: Add cec suspend/resume functions
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=db1184e410744a680f92ca21e5acd5ae54510db8

-- 
Neil

