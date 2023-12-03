Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B098022C7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjLCL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjLCL0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA4129
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bb8ff22e6so4838770e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602800; x=1702207600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsGJkEMgYOnC7T1jGA9amysHXRjV1SP4w3jzP2mqKYo=;
        b=tibY4AF/1Z6bYVl8z6gEBAosBiYSbvkh0k7E0Xv+NjaOSVejHXPcF/HgFNsIV3AkYr
         28+k9+5ZvYB9emOWqELHwgjQ5ej9QGwIc9znFMHKv4B2KGq+s1KF7MMl7flioI/jPtvL
         gw4Ad0eOo85V5m1hW6hw32loecQ3nmN4ROaqpp9Ncpzt/Y4DhukQ5uG90thcph6WPCwd
         UbjTPPDV453LLW8qllRJEq9R2tnb4txPldeMZph87hoeS+QYNq62bbbPE4+DDpG8vVFL
         4NLUlPT3+7ss0qj7tzoEgAM23tWMQLCbMR32PLlRmN9z969oKsvaCWvU+mJkI+qLJygV
         NAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602800; x=1702207600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsGJkEMgYOnC7T1jGA9amysHXRjV1SP4w3jzP2mqKYo=;
        b=ec6zcxLCwbT+s/63oAJdrCVhKeihOJ5b6DNbzv3nKIIqMQq8qdDXwQSsY6cWs6YtsL
         87RiDSAYnDA6Aypen+OvyB/nqvy35iUvlO19YCnWOhdu4rQVWIFDBYz9I+A72hQLhqOS
         lchla1oyBp1mcKQ/PSwGVj5Qmw0eXsgt27pVkgnKltUgXcQ7EB3dDNklN/9lUfvIQa4v
         akOex5j+u/0eyvschmdth6Wd84/PcUqrYqIWWWUlxHt1GbSbHnPwRHez+XsmfIogOF0O
         mD3iS75NJ5YYcjr3hWdbr+pqvVKnBBxXowu4GVMXTar7yCsdXwxXEgvAeiLy3B2ou9ge
         F5Sg==
X-Gm-Message-State: AOJu0YxHXEqQ93D9ehhTwhQbTnizmFCXVCddEo7ZVjBVfVpiQTmeCMsc
        UcyQzymwJaV2vN9rG9JwzJGjYw==
X-Google-Smtp-Source: AGHT+IGTXjNHVOlRK83VPte/bws5CiHwW/uyqVkiKfSIsKv+KpW+bT01/1EwXLC4NivAlf5yAF6gaQ==
X-Received: by 2002:a05:6512:2c8b:b0:4fe:2815:8ba7 with SMTP id dw11-20020a0565122c8b00b004fe28158ba7mr2247401lfb.25.1701602800000;
        Sun, 03 Dec 2023 03:26:40 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:39 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,sm8150-mdss: correct DSI PHY compatible
Date:   Sun,  3 Dec 2023 14:26:24 +0300
Message-Id: <170160265545.1305159.12554929694574480322.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231111142017.51922-1-krzysztof.kozlowski@linaro.org>
References: <20231111142017.51922-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Nov 2023 15:20:17 +0100, Krzysztof Kozlowski wrote:
> Qualcomm SM8150 MDSS comes with a bit different 7nm DSI PHY with its own
> compatible.  DTS already use it:
> 
>   sa8155p-adp.dtb: display-subsystem@ae00000: phy@ae94400:compatible:0: 'qcom,dsi-phy-7nm' was expected
> 
> 

Applied, thanks!

[1/1] dt-bindings: display/msm: qcom,sm8150-mdss: correct DSI PHY compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1cd83dfe9a58

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
