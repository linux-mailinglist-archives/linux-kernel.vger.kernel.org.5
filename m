Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558097FB80D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjK1Khy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjK1KhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:37:24 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC73D72
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:34:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so3809005b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701167671; x=1701772471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yyve/MpYopjqzKEDi1Y9CR3K8+cxDXLytjrxavvjAU=;
        b=vNg89kuFzkutHT6nenw0wB5E+SvIdw2AOS0ytnHwaQyfmaGrcTNUNvFLv8DBdHTZ3B
         g70V+bf5M5PiaUsFBKsJFummHFMx76ca3WHH+bgR4ajRa70uWWBnmC3e6tL2sEEO1/gh
         QwMyGR0pu/N//0xIliW5odG1ccMfY48PWVuuU0dshLqnmn3j7+PQx1RJa8kmQtNBMDhS
         38CXQRmdPKG02dlO6DAL/KbZpeZNRU32AXYOMsDpdEzjYH9i4O96kEoBazNzmK9ntfdM
         Osj1LrbmJwkjx49P5ks07aIpe6l0e2gqrL6SEzaV3BBCsrj7E+trIQzrf+i62hxs59xD
         Mwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701167671; x=1701772471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Yyve/MpYopjqzKEDi1Y9CR3K8+cxDXLytjrxavvjAU=;
        b=pEJnuxSHmxAz3tEV//1YL+BFDZzT/YPlXH0Gw4/l/52mvm4NdDXnXPCTdybIb40hAa
         DEj6n7GRiZQKbl+cC123b8BJzgD+GXlPoZjB+4CwaKPqbtLWDt1bmnyRZw1HtjI69dMX
         +nY8Iaa9ZjS1cOARnit39J5G+qE8g8WFOAqV0NDuBixkXFm+xdbsitClX7PCawwkIDcj
         1T/pUSwJPzgzF2gKS8kHkUQXGMRIkte8VWLCjIye4rsHvXBVIhJZp4t+KdBVaX/Vpl6U
         5T60PDvyhYGtYw0ffVD6Bk8EDjeE78OY6tFlLngpvoO/ua3OmnlLjO/NxW2uiGkU7lND
         P0kQ==
X-Gm-Message-State: AOJu0Yym9Hoz3Tf5cE7PnFLzmFG/dsu7aVRkN1eBBcVEiP/2WGQFpoc9
        c+ab//UDKJg7iEoS8jTcxHV7UA==
X-Google-Smtp-Source: AGHT+IFphre2IOCGQmscY6xeXA4mJ80hFOQLqrzgfqIhwhyj3EcjqOVFv1DI9ExufEeI4z1KX4HrYQ==
X-Received: by 2002:a05:6a20:8f01:b0:18c:a983:a5f2 with SMTP id b1-20020a056a208f0100b0018ca983a5f2mr7390871pzk.29.1701167670999;
        Tue, 28 Nov 2023 02:34:30 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id by6-20020a056a02058600b005c216d903bdsm7982692pgb.89.2023.11.28.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:34:30 -0800 (PST)
Date:   Tue, 28 Nov 2023 16:04:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/3]  OPP: Simplify required-opp handling
Message-ID: <20231128103428.hckenu5khg3n5cok@vireshk-i7>
References: <cover.1700131353.git.viresh.kumar@linaro.org>
 <ZWXA9_VDRKzMA9Nj@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWXA9_VDRKzMA9Nj@kernkonzept.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-11-23, 11:29, Stephan Gerhold wrote:
> Sorry for the delay. I tested the "opp/linux-next" branch (which seems
> to contain the changes in this series already now) with the following
> configurations:
> 
>  - Single genpd used for cpufreq (MSM8909): Works
>  - Multiple genpd used for cpufreq (MSM8916): Works
>  - Single genpd used for cpufreq + parent genpd (MSM8916): Works, warning gone
> 
> Thanks for fixing this! :-)

Thanks a lot.

> I guess I'm too late now but FWIW:
> 
> Tested-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Updated the commits with your tag :)

-- 
viresh
