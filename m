Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ECC79FDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjINIKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjINIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:10:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49E719C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:10:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40472f9db24so2132815e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694679035; x=1695283835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hin5IormyU5dD/AsuAUUHoFBHLo1oonPXuLbsZDcZfM=;
        b=qc6tGIzJnXHJrkKuKH3zQCkBaNa+nHl0dY76oNkioDPkTilWsKWPTaH+FBcK0w4a2n
         w19xC4X9l1nKOJX241+zH6AvEaJZZqqGl6wQpvMkPRS1LHyNFtNwF1pmY9HOU5H5SfHf
         ApxExjKerMMFhDLoGCMgC4c10BVDXfJImxYIRlxgMNrLEq+rKR7u05pDe6RpFDTE6Ekn
         1npNGmMjRBY151t5W/Kvrd6c9wTpwS4ghOsmjMyrjRHDoQE4kYJWuSNESW7zjIqc7zYS
         tdUr0H4NPZBpiiNAyUiOjoxn4rNUsMSpJA/yD4At3JhUtRgZpUV+V4N2iGiimQ+SbRNM
         9dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679035; x=1695283835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hin5IormyU5dD/AsuAUUHoFBHLo1oonPXuLbsZDcZfM=;
        b=SVd911gz4PmgPrY3rb+AOqWOSmfwqtbfTcqZ09QBUEphtdK56r5VjZxk0a5/yyhP+G
         6h+ERJgTSLkpjo9W4kjrPqamOdZZMSzCUx1FexF5DrmXd90kseosTyQ+giDkrRB9eJjt
         NJvhmVB5GTLQ37qBhakS9Ld6xHJiSugschjvBrOv3cI9epWXIQPAzDO6fnqWABbkBCrb
         /Q0Fh6F0i6T2qEEnLXdwTbflEpPMnHJsgaBOdNGZK3D7sb0AvnS87XD45hUDBDyNHDnX
         t+j0XvFR7CnpAexAeGink7x9hyolB4rvLae+Y62DwiukhY+KYUGyIioGXT6G90hINE2+
         FBwQ==
X-Gm-Message-State: AOJu0Yy3qXKloOrS8Za8GPQD6CSPtUjnHbkX5OIOQVEdB3WFCigqn/T3
        40whIpviBeINZ8Wej4D5vFmS8w==
X-Google-Smtp-Source: AGHT+IE4V2wgERUskaxyDybA22SPbjKwWDreD4TUrJWgmpWBN9TSuDjDhVZXOc5XcG6yR7iBkfIb2w==
X-Received: by 2002:a7b:cbd7:0:b0:3fb:a506:5656 with SMTP id n23-20020a7bcbd7000000b003fba5065656mr3969326wmi.32.1694679035279;
        Thu, 14 Sep 2023 01:10:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b004030c778396sm4152155wmr.4.2023.09.14.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:10:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: exynos: Use pinctrl macros for exynos5433-tm2
Date:   Thu, 14 Sep 2023 10:10:29 +0200
Message-Id: <169467902473.16247.3464125892860371063.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912055635.49092-1-jaewon02.kim@samsung.com>
References: <CGME20230912060640epcas2p43a9e6e11906d03641e76fb3df97462b8@epcas2p4.samsung.com> <20230912055635.49092-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 14:56:35 +0900, Jaewon Kim wrote:
> Use pinctrl macro instead of hard-coded number.
> This makes the code more readable.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: Use pinctrl macros for exynos5433-tm2
      https://git.kernel.org/krzk/linux/c/d8c326bd5aa5d6aac0c4826dfeadcb02dc77ab88

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
