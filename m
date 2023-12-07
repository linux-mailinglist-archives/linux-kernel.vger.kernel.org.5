Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E113808628
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjLGKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjLGKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:13:03 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57B0D59
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:13:04 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso806150276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701943984; x=1702548784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3B67B1TYSjUdt6Cc8K4XbRIZ1QzqkY0WH6+puDGmn4=;
        b=ciHMHUepSltr4g56V7l6mEs/NQDP3xPGlRjPxmgeIFK9L3OwSp/sA8/mHv8AUxjiYS
         e38OTUXVtymi0rj3uhgT6ZMNS5pLylLhBx+FW4FO75IRJDqh2PAI8rf6k26iJfCAmMsl
         ImCm1tuuvvmeQ9v3D9vBEw1iVv9ZoQ+h5E7X5aGpyB9/kb50VxEK8xILiauHQGXpVGA7
         T9m64BQZp16DqTYhAZZm6ylqgK92grDQZ59BWN+nOi5RW2X75smZM6vf0pwk5ufyGROk
         a3X5ENF7ZA7wwstyrHaT+fAxZsq3JIJUXOVQa2RO0xLMcMduq/X1EUyDcGQqzLUeavSo
         /HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943984; x=1702548784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3B67B1TYSjUdt6Cc8K4XbRIZ1QzqkY0WH6+puDGmn4=;
        b=kmuLjgsS4rYOWypWfg5JmUhdZG1ktOqFrDaX5i/osr9X7JQlvVQF+lLqNHOHK6gyiJ
         qvZqfIA/iMcFKpd7n6w3GtoVKa5KlzJelQ/j5h4SP0RBogJI/TmeksqyEvZXsk2WWEfH
         bktd04uYcZ5Bk8D62uiR0Aulz0DPzcOm8S81GT7/CqHreIA3r3uf72Y4khI6k69W9YP9
         r2neJyRCDGulDx3rS1FhnnMYGa0TyN17roT5WceD5Xmw+kFjv0HZ/vPA8Dr2uJemOtt/
         +TtyhCR3WaV3nhGPVayJLa24Ln52ffB9h2qjNkSx8Qs1VRezsgcePedyknpD81VZiKB3
         w28g==
X-Gm-Message-State: AOJu0YzvzaosxOvWCEvhhBtTwkvl7NBeCj/Ix8l7qPgRgUw0O3MNTwkh
        wAFoRxHP3WJgDf6IMofSyuzeAhVWILF8EsffVQ==
X-Google-Smtp-Source: AGHT+IFNn1HUFDtLCOGTeA3m9Ta/i3bQvpYxwVgKKLYlxLDmi9pfv/W/T/9B2nxE7SkRSL3QSWQJtw==
X-Received: by 2002:a25:243:0:b0:db5:4503:6de5 with SMTP id 64-20020a250243000000b00db545036de5mr1932607ybc.60.1701943983997;
        Thu, 07 Dec 2023 02:13:03 -0800 (PST)
Received: from thinkpad ([117.248.6.133])
        by smtp.gmail.com with ESMTPSA id l13-20020a0cc20d000000b0067a22bb8d57sm373453qvh.56.2023.12.07.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:13:03 -0800 (PST)
Date:   Thu, 7 Dec 2023 15:42:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Message-ID: <20231207101252.GJ2932@thinkpad>
References: <78815f1b-7390-40de-8afd-ac71806f4051@linaro.org>
 <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
 <20231201060716.GJ4009@thinkpad>
 <166d307e-7d1b-48b5-90db-9b6df01d87c2@linaro.org>
 <20231201111033.GL4009@thinkpad>
 <f844cd1e-7e4f-4836-bc9a-2e1ed13f064f@linaro.org>
 <20231201123054.GM4009@thinkpad>
 <3a7376aa-18a2-41cb-a4c9-680e735ce75b@linaro.org>
 <20231206131009.GD12802@thinkpad>
 <ZXGVjY9gYMD6-xFJ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXGVjY9gYMD6-xFJ@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 10:51:09AM +0100, Johan Hovold wrote:
> On Wed, Dec 06, 2023 at 06:40:09PM +0530, Manivannan Sadhasivam wrote:
> 
> > OK. How about, "qcom,broken-refclk"? This reflects the fact that the default
> > refclk operation is broken on this platform, so the OS should be prepared for
> > it (by keeping it always on).
> 
> Shouldn't that be
> 
> 	qcom,broken-clkreq
> 
> since its the CLKREQ# signal used to request REFCLK that is broken, not
> the REFCLK itself?
> 

Darn... You are right. I got carried away by the initial property name. Thanks
for spotting!

- Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
