Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31FC804C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjLEI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:26:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC2A129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:26:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so57074995e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701764816; x=1702369616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhk0vrrK3aMQqTPPZhkL5dCm1kbb+HSVRSnOFk8wugY=;
        b=bnOUq2X0mfzmXl3wGHhkebS0nutVOP4yzaHaIOMQfbuHp7ZWE7sw/Ju1cP9Vpn+1xp
         iyRU9y5m8QWJtBtXkuwPQWZ1NEkm8nAmcdeSHJJ81opLv9m6MWD3VUYV7ZSl3HX/TJsX
         2/jxc65tZVIleMJxtvMwRDU0Hk0U4j45csBb1BOoYiDKxn5qOoVWaPhqiECXAzcQdJQE
         ElgJv4JxTG1ixRXvsJ45XAMohiYlgd56riZt73vSUOErn4sjGHJOVS8aRp6ZlFGLKFCI
         SxZnyQBHyulS2/5Z88kYvMpz1OMJsYSGDv/LUwKdUui469UZ8b97tqDyETenMGKNjSyu
         ZAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701764816; x=1702369616;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fhk0vrrK3aMQqTPPZhkL5dCm1kbb+HSVRSnOFk8wugY=;
        b=MqCkdXWTglVRLyQkADzbz0e5zfTWHERna1+c1KJQ9RKJWIsImggWcR9KtcBgvfuBun
         ufz3SadUGtFKhX44BB+JCC4VQ87Ogq0aZVc++1OaozfMuNc/kZGqNHxRve4Fe1seALSH
         iRE9B8gc+lMDy7ssjhpUFi03g/yz7kN1t3mAde+8/b3FLLtfrcHS+Ca0S/uePfdMKmhz
         mEGwjkmX1xyC32b6azPUQUPUtGCwf0v6kvUkWExuD2d+6JzjZOrZSlaTDFt9dDy63puy
         idzYBvg0l6AG2HRo8SY7iyS1KZz6YRffiCNlGmFmjf4IwxMnsl3sIS+2MVjwrf1cPHMt
         jLEQ==
X-Gm-Message-State: AOJu0Yye4VuU137edZ3qjHSSYsHpwuHvVgwrIvCIUL2azccI5qTALp+t
        3CO+8O3wFwRG9owRs8zZ9g1o4g==
X-Google-Smtp-Source: AGHT+IHPShSi3GvRNJWHwAxMtJssSWjt72NL4oJ9fh+a8bP3Z8ocH3lCJwCKGGEKvGVi37O0qYOMAg==
X-Received: by 2002:a05:600c:3c96:b0:40b:5e4a:4063 with SMTP id bg22-20020a05600c3c9600b0040b5e4a4063mr214136wmb.131.1701764815659;
        Tue, 05 Dec 2023 00:26:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm21329282wms.3.2023.12.05.00.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:26:55 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Walle <mwalle@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231123102404.2022201-1-mwalle@kernel.org>
References: <20231123102404.2022201-1-mwalle@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: add Evervision
 VGG644804 panel
Message-Id: <170176481474.4073725.14480764473949447794.b4-ty@linaro.org>
Date:   Tue, 05 Dec 2023 09:26:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Nov 2023 11:24:03 +0100, Michael Walle wrote:
> Add Evervision VGG644804 5.7" 640x480 LVDS panel compatible string.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] dt-bindings: display: simple: add Evervision VGG644804 panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2a5244a04e751c8617d5e7707550d97a83b1102d
[2/2] drm/panel-simple: add Evervision VGG644804 panel entry
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1319f2178bdf1898a76ea8c4f00d57b240bbc5fd

-- 
Neil

