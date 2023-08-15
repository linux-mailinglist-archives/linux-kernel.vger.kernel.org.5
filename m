Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BB77CAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbjHOJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjHOJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:42:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658881BD1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:42:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so47008745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692092566; x=1692697366;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=o3HpNllNIJATl4218cwCPumVvNpYnT0jHatxINajSxA=;
        b=SrmhGXAAFUIGe82A+SUcvUAGa8VztrbtO7q1uzgKt4Vbv9oPVwWnBFHrG1KFOpipTh
         vkpvagvBYDVIqigFSnqE6SviWmy+infbKsoBL+SQP+9x/h3aur3EGPC4gsYXbIWkEGom
         TFDLlvaC0pW9aAjoxThOnJuXdvXvB4duh7ZzZ3DPjJX5hwTrhdwQ0vaV9TqwO0mDjbI/
         5m1ktq35S0c2moN+61gc3v4kLsuL49QP5SA61ToMEYFagU+NiHpfCjc25+50RVHdJxur
         X76F1TKhUVzUxuKnNjYvf0egrdhxXHKn+LyU5y/ps4ewLrp37KK6jCRNGWCWyZJe+xTF
         2tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692092566; x=1692697366;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3HpNllNIJATl4218cwCPumVvNpYnT0jHatxINajSxA=;
        b=He0hek7rlAjijAfAPpJ7ZFG9ob4VMJsCqOjLaCxBa3NeB1hNEih3+1pJdion162mvF
         H6Z0Y28O3QPXIroxMw0ZWZtu9lqn0CgHnbKVJUacQApI1zxlGKpop9mx8aqkqqzBoZy0
         Szn7GK4Y+kNxQUpIUZNebWc32r2VehuBeXnJg6iAQskT8B7iTiptNckY3/vckE8H+wKT
         NQHjDA3hYKO4b/d2Bmyi7Z8/fypXMA0O8V46jkLpepIIKYn9dP2RnK6Di1DGhKAdgRiF
         EhTyZJRFgoRaBPKR48y4TNG/sLZcEpyU+7o/1oQ9it07d5xVoDyYY88gsW8ht2F5DPVo
         7kmg==
X-Gm-Message-State: AOJu0YxBpPeHg3A5S5LVkEfdWcQZRNDF8NJF6BDK7T67JFmi22uZIjml
        8AtzvnvYL2GYh2f6ATcWgbHDpw==
X-Google-Smtp-Source: AGHT+IEAnsI0NDPngUs538CsVemZRyT6ErVk9cE0dJy5QJptvg+a3O1YaadMfUnwJy9AzieYYWfo0g==
X-Received: by 2002:a7b:cd95:0:b0:3fc:114:c015 with SMTP id y21-20020a7bcd95000000b003fc0114c015mr9087147wmj.39.1692092565313;
        Tue, 15 Aug 2023 02:42:45 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a9fa:56eb:482a:ba03])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d4281000000b00317a29af4b2sm17166640wrq.68.2023.08.15.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:42:44 -0700 (PDT)
References: <20230815092751.1791195-1-christianshewitt@gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: amlogic: add more basic audio support
Date:   Tue, 15 Aug 2023 11:37:58 +0200
In-reply-to: <20230815092751.1791195-1-christianshewitt@gmail.com>
Message-ID: <1jh6p0vdyj.fsf@starbuckisacylon.baylibre.com>
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


On Tue 15 Aug 2023 at 09:27, Christian Hewitt <christianshewitt@gmail.com> wrote:

> This mini-series adds basic audio support to the P200/P201 (GXBB) and U200 (G12A)
> reference boards. Few people likely have the original reference boards which have
> extra audio capabilities, but the device-trees are widely [ab]used by users with
> Android set-top boxes whose hardware is copy/pasted from the reference designs to
> get working installs. Adding basic audio support does no harm to the real boards
> and helps the secondary cause.

Still, this is something you have not tested on the u200 reference
design. I believe this was already discussed in the past.

The u200 is far more complex when it comes to audio and certainly would
not work on this no-name android device. These device are heavily
"inspired" by the reference, but trimmed down in many aspect including
audio capabilities - NOT copied.

People abusing the u200 or p200 DT does make the patchset valid

>
> Christian Hewitt (3):
>   arm64: dts: meson: add audio playback to p200
>   arm64: dts: meson: add audio playback to p201
>   arm64: dts: meson: add audio playback to u200
>
>  .../boot/dts/amlogic/meson-g12a-u200.dts      | 129 ++++++++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-p200.dts      |  60 ++++++++
>  .../boot/dts/amlogic/meson-gxbb-p201.dts      |  39 ++++++
>  3 files changed, 228 insertions(+)

