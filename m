Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45E47F799A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbjKXQmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345427AbjKXQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:42:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D819B5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:42:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4079ed65471so15582365e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700844166; x=1701448966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY57yW8jqPx4DCjz4gafCo99TqRgCQishv/BZqsXq+M=;
        b=Wvr3re2xvbKnzDYL/dG3QRaJCPSfCQe4K0zb6Ido4yJ6oZD34H4ig7OUsHVW5VkFl0
         ocQ972xInpVZcp6LwGcrhmftlRkqcaz+Gn9ejaL4Ii5Mfd9c0UwAlbqmShiODcfX/XgH
         mIc/2kU81QmI92bDG2TxSy8U4dDn6QEjZIpI8gOyaRGi9VirzpKV2to6m7Us/c4ScIzd
         jq5TTeqepGte+Q01zd/Po80ELNodwifNWB/YxY0Y4lSiTqJQ9kCKQ+R+q83OArwT3PE0
         d4ojJjfGwvhW/CwyIQEVHgHzKiEGNGjASKHyAdQZiZGUTR6CZetfk4/8WdwRa39L+p12
         hyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700844166; x=1701448966;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY57yW8jqPx4DCjz4gafCo99TqRgCQishv/BZqsXq+M=;
        b=vO1VHlTy0Z5+9ixj+z1nqE+VaN1G+UiurDJiHlfpRJ19ECKv41lDGYcVukHxVvXS7j
         nCHVmJqGXGYEE9dutBmFw41i5gUTHSQKxYpE5SiW1UHokg9aEXso2GBCcxSWTTk4Smqw
         POnyDU5BTnN0JkAvveWGqu/im48W50Dj49IbwOgzfz3aJUm1sTSUA8XtodWc17kGyUYm
         Q8oqwcmn/LdcehtQ2ULxkl2ZN2Sn7TrYSiJLCGMyv9mG6TC8v1p4gi3DOn10oFgz44NX
         b9GqkJSDMp8LORlKNXsnn2X1zyYGcreZ3RWL/vO4DJl10OHEvs5geiYSe35tdCLLqZbH
         Q8Vw==
X-Gm-Message-State: AOJu0YyE7v/Iy5U+lar3GJoXCXocU020Fu0Aqu/5sGF6N/XSmwqbwagX
        06hekg54Jcy4TsZJqdvuQRkpww==
X-Google-Smtp-Source: AGHT+IF0qtFjt0i/sxwkQJ9BDFSUDAmlZ1vNck5maPD+WnShRNQ0koLnOjpHlDBfcr97NsaHGHftKA==
X-Received: by 2002:a05:600c:1f93:b0:401:2ee0:7558 with SMTP id je19-20020a05600c1f9300b004012ee07558mr3057188wmb.32.1700844165899;
        Fri, 24 Nov 2023 08:42:45 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1243:6910:fe68:2de5])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm6159082wmo.39.2023.11.24.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:42:45 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Lukas F. Hartmann" <lukas@mntre.com>
In-Reply-To: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
Subject: Re: (subset) [PATCH v9 00/12] drm/meson: add support for MIPI DSI
 Display
Message-Id: <170084416459.2546450.3587219733392523958.b4-ty@baylibre.com>
Date:   Fri, 24 Nov 2023 17:42:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to clk-meson (v6.8/drivers), thanks!

[01/12] dt-bindings: clk: g12a-clkc: add CTS_ENCL clock ids
        https://github.com/BayLibre/clk-meson/commit/bd5ef3f21d17
[06/12] clk: meson: g12a: add CTS_ENCL & CTS_ENCL_SEL clocks
        https://github.com/BayLibre/clk-meson/commit/5de4e8353e32

Best regards,
--
Jerome

