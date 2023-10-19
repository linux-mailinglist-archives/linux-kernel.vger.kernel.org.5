Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4DE7CEFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJSGQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:16:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C26BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:16:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6be0277c05bso3358239b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697696171; x=1698300971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yH/UjLgq32jH++PpMoUqJLeIFE0ZYZEDnxQSEj9bfyQ=;
        b=XhQ9rch0+74TVCHpR01n3JHumgle+KuMfQscJmbaLNgjAh2Jqde2xQDbA+N3Crk8fi
         a2WLAWqMwipqF4DdSDHumJCyN0L6bWFQHLcb0DSkiqrOZQsaZVDkuVVYrdBGAIGqhCxK
         QPaze6Bn84FFwXoDAKtSUzhWGnzxYS1FWprqj50rGJiyaCtbHTxHzdIQlf2jSfA/Dyh3
         igPWdmrg3yYoUtBVGldc6ENP7hzbihwScFYDNLDW0UiKAqQz2V7EX4N29/lx7CVN8fWB
         7n4+r2S4GCQMCjJQUNWKJzZ4fecndvvLrJERZsd9xw+6eeu0NI3k+qUlTfdM3gYhGc8l
         h1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696171; x=1698300971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH/UjLgq32jH++PpMoUqJLeIFE0ZYZEDnxQSEj9bfyQ=;
        b=pgLKjWP0CrbxJq84Svu/XGIx1lajG8MIeC7xAWuHbZvONTVzGA+a6fRA+Un/6cdoXJ
         6Te98JmrihmgEo7v8H8gAryiHjab6Rz7tKZu174oMx3PFF6hzwivQ7al22DZxPLIe1Rs
         jq+PxRPpBbqVUgGkiu1mnng2a9kegTqVr2an8X8MyQZ64gXk8a5ad1fdzG4TRTdGhfyB
         EREbWOUU4Ue2T7fW43UI0VUxH8tDD+U2kTwrgfrR0SpgVnjBmg5u9T8Cb4JUKrkzW9rp
         J4jbkj9H9dku/SzWSpZEDjl1GjO6TNL3JVKmiJE3N2VO9/zT54NRdA96NyLEx4T/r4xS
         JvhA==
X-Gm-Message-State: AOJu0YzWTQgRpGCawrNW2a/If6QXxB79T+vsLUX0Iwf2QAcso87s4aMR
        uNWUScP1mIXNw6QPj5ruzEATGg==
X-Google-Smtp-Source: AGHT+IFaTXuhZLlg7nK3UyK8fM+1t0TG+C2O2i5DXfpYAeJ5f2mO+dwIkmiwoqHBiZRsQHyYhwplMQ==
X-Received: by 2002:a05:6a00:1a8f:b0:6be:3c44:c18b with SMTP id e15-20020a056a001a8f00b006be3c44c18bmr1167269pfv.25.1697696171321;
        Wed, 18 Oct 2023 23:16:11 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id x13-20020aa79a4d000000b006be0bd6a4d8sm4325600pfj.36.2023.10.18.23.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:16:10 -0700 (PDT)
Date:   Thu, 19 Oct 2023 11:46:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Message-ID: <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-23, 10:06, Stephan Gerhold wrote:
> Add the necessary definitions to the qcom-cpufreq-nvmem driver to
> support basic cpufreq scaling on the Qualcomm MSM8909 SoC. In practice
> the necessary power domains vary depending on the actual PMIC the SoC
> was combined with. With PM8909 the VDD_APC power domain is shared with
> VDD_CX so the RPM firmware handles all voltage adjustments, while with
> PM8916 and PM660 Linux is responsible to do adaptive voltage scaling
> of a dedicated CPU regulator using CPR.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Applied patch 1 and 3. Thanks.

-- 
viresh
