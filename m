Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705C57FC216
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345122AbjK1RAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbjK1RAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:00:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B7D4B;
        Tue, 28 Nov 2023 09:00:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so17447835e9.3;
        Tue, 28 Nov 2023 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190810; x=1701795610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELFRihX3CtF7RhjnQusbjB/B/hfaZV0Nbj4a0FnBTOw=;
        b=nMk/vDw/bQ3U2MUGiawahLWPTghwX0cvsHV9mKDCqbLQK2j9iXuZ2V/kqBn0xObzB3
         OL6defTnXWwPHJeyY+j0VYP7uUIEw4wxYjn5+I5FZHbtUV2X6+3qClbALgpODGRGRNiD
         p2IeMI0fqT044oNYVx3XR+GvyZomxbosPUhQkeUwaIEHEUE9PpdgpDiXJCI8paVQ73VD
         wxJz/v65+FuANiBrEqINsOfA4XZAoBE4M4343tho5l/txBGn/nlOJFoIvPmGdz0J8RPy
         L3EehZJrSmjb82VHorftknQoGiOq9K8iFYm901Xs79jLhBnOc5Hq1jaBG6/T4Nk19e46
         Oi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190810; x=1701795610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELFRihX3CtF7RhjnQusbjB/B/hfaZV0Nbj4a0FnBTOw=;
        b=bDqVoQVof7y5hTERSpluAnWzgboAARlYi0UzkS+3xacQ+f46qHyJ6MD25UBjupXKdA
         WSNR1H4w/5W2HTlYSyfl+Dnkg3D75q/X9q6aVyXmGIudogTGiIK8jY5pymFqtN/ojbyq
         rNh5LmVFlqYEbD8iZeQYXGs+Bb1vT1M1FiUPJSR7Sg1VSMYzM4vQdY6fqNiOsbBXLbCo
         uBbAwAUvt4pef90MGw+BhFwrkfYVkLuSW1Dj6bo+7oe/YMaiHBdJYGUNsuEiMOrzfPH+
         1YJKT+rMARP/Yk8elFosf7LXfmU79SZZLlVG4eaxPsIzOdBXeKP01/gVal7E/cx2IhgJ
         WkqA==
X-Gm-Message-State: AOJu0YxrR4bvdCMgCjkqUIvXILJb4A/OoBkqZJZXx6DTcc3NvEx1GmNd
        2qAk0YCiPgajX7fVYdJq2jA=
X-Google-Smtp-Source: AGHT+IGgm/D1KmtQMgeCyY/5kKBhGpQJ2TpH2E/ZvVJuY46OvL1ykEusYln54WAR+F0TPMHS5lkZzQ==
X-Received: by 2002:a05:600c:3b83:b0:40b:2a53:7913 with SMTP id n3-20020a05600c3b8300b0040b2a537913mr11464033wms.13.1701190810132;
        Tue, 28 Nov 2023 09:00:10 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00332cc7c3aaasm15618353wru.21.2023.11.28.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:00:05 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] pwm: Use device_get_match_data()
Date:   Tue, 28 Nov 2023 17:59:55 +0100
Message-ID: <170119076371.215216.199281430371759022.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026195417.68090-2-robh@kernel.org>
References: <20231026195417.68090-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Oct 2023 14:54:17 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> As these drivers only do DT based matching, of_match_device() will never
> return NULL if we've gotten to probe(). Therefore, the NULL check and
> error returns can be dropped.
> 
> [...]

Applied, thanks!

[1/1] pwm: Use device_get_match_data()
      commit: cf5a1a8c8e8875b3fe38835942b393cc1577da55

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
