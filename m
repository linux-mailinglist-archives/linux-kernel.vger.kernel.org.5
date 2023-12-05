Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44219804C40
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjLEI0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:26:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2795811F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:26:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b399a6529so39588195e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701764814; x=1702369614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8z1G//lxs01T/5lt3W2SRfFFQQSfR5y5qtuiOgOqS8=;
        b=gV3y8UgZBIhUsKQs9gHG4Fooj8+llnpyKZ2iXe4gb0n2tDGjE81jzhc+DxNGyr4H+f
         iY9kkUq9P6quJGe97r99ImEp4iDKnxglXBcsVWUfhDce2TXHeTZUhDq3PFDNTtcdaPhn
         96Iyat5mbX50e9tBxmmz400L8GBAm+DEN2a57yCNY291En8a2SlQlBrfzIK8nWtpKvmE
         MCPQp2oyx4pwebRXP6j4LKRSqaLoqfffnWXGvQdsUBAQGzzWneKgGnhkHesUhqcM/oPk
         zVxFaAjtZw2k9cOkVdPmM3FciIih60wgnRtDoiOpGopLRa0oo6N9+3s6dIf91T/r1FgT
         YJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701764814; x=1702369614;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8z1G//lxs01T/5lt3W2SRfFFQQSfR5y5qtuiOgOqS8=;
        b=QRtw1IpxYbOh8mYP0udbAeqoQP9GdOgZewIcdTkCgLZzQWPxLZS5Xchd+KKk6W2y9I
         R0+7O+vK63NPHDoQviIFM5jB0X0Itir2s4pL3txO+qgEvVw+4SeDMJw4KC+rhxq5mRNO
         ykysZiazpu/jc5eIAQHfYOODNU0Lixi9ytikJoy/rVh/B7PpG8SY0JVkqoGvm1DBE5mc
         pgs2pjdhGUYVpm4nXBcSBXmwX8regK/xydNS5dOmqVLCuKoh7blegn/iS3bdA7Aoh0mv
         ZnNBjJB8OMuElLSwxiI77sSB2CBt5RqTTl7loJNHw3jyHcdoMnkwixw6Hyj7Y0ZudVzm
         cBgQ==
X-Gm-Message-State: AOJu0YzdJ0iwDJ3oVijkBZoyemmnUGyyvHHcEZWKFkwNaTKBPAL13eR3
        H/qvo5+jRb33avD3E6Rqe5yoNw==
X-Google-Smtp-Source: AGHT+IFCMMvrABPHwS0NJdVCcXSdpuq3NACgGkVh6j9EYUzk74mmdJWxN4/71i9g2VB1GlznRsJr2w==
X-Received: by 2002:a05:600c:a02:b0:40b:5e56:7b6b with SMTP id z2-20020a05600c0a0200b0040b5e567b6bmr283025wmp.180.1701764814623;
        Tue, 05 Dec 2023 00:26:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm21329282wms.3.2023.12.05.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:26:54 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        kernel@pengutronix.de
In-Reply-To: <20231123-drm-panel-ili9881c-am8001280g-v1-0-fdf4d624c211@pengutronix.de>
References: <20231123-drm-panel-ili9881c-am8001280g-v1-0-fdf4d624c211@pengutronix.de>
Subject: Re: [PATCH 0/3] drm/panel: ilitek-ili9881c: Support Ampire
 AM8001280G LCD panel
Message-Id: <170176481371.4073725.12586560786525230750.b4-ty@linaro.org>
Date:   Tue, 05 Dec 2023 09:26:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Nov 2023 18:08:04 +0100, Philipp Zabel wrote:
> Add support for Ampire AM8001280G LCD panels to the Ilitek ILI9881C
> driver.
> 
> Also set prepare_prev_first, to make sure that the DSI host controller
> is initialized to LP-11 before the panel is powered up. Tested to work
> with samsung-dsim on i.MX8MM after commit 0c14d3130654 ("drm: bridge:
> samsung-dsim: Fix i.MX8M enable flow to meet spec").
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/3] drm/panel: ilitek-ili9881c: make use of prepare_prev_first
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=68c193c8d4a403222ce51c8b08bd1715f8b74274
[2/3] dt-bindings: ili9881c: Add Ampire AM8001280G LCD panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=7ff02f82c3e9ddd5dd81957c8659d350261196ae
[3/3] drm/panel: ilitek-ili9881c: Add Ampire AM8001280G LCD panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2748848ceaf32671927c3b19672ba3104a1dba7e

-- 
Neil

