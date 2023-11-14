Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1E7EB94A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjKNWZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjKNWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:25:08 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258CDD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:24:59 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5ac376d311aso68446587b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700000698; x=1700605498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZH1moAA0yVg/Bb0Aws1epxcC7ep8j8z+Au9OoiC60Y=;
        b=YLwfwu8f4r9Why3kj5g+LjIriHAIWAZSK2cqGUVcK/FL1qccdznGhtlV0Mi1ZtMhNG
         PzEDavVxIdD2i7wac6AxaWnvXvuYDZhBLu0lA8OBrn/ofkPDaF9wynJzXVS8E9COnA4a
         1DiIsn8Q1mHdL1PVWRfkLmtL3nMS974daABG8RyoE32AeIls5DnjSIA4XC3le11UFDgO
         EVAhfRi33dHllU2nvt+/dO5EvSzVn2yYoP4z9Traqp3H6Vzrv6a0WDgsgv+Q76PpYUUB
         S3tfo5wvatOEnrfNEZvziq5t9JXtN/NTNO4u3S8lxS09iDr5bVaWre/Okw+/1ly16hDh
         iIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700000698; x=1700605498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZH1moAA0yVg/Bb0Aws1epxcC7ep8j8z+Au9OoiC60Y=;
        b=i07X7+i/g1wy+MqgrsKha4vS8sER7xeJsBDkZBHUanoXOBdTAjZzZTqE90pGHFz1H1
         CROfsTI8rJYA1O2tD5am3viXO9xHOoYvlVyQt2ysyTlIlaOzE1aOI/jsBO74V8O2r5YI
         Yj1vhExuYnwccZiJJB0FE5gCuxTOLw+oGf7yof1/llcGX0/BOsH6ntXsbuYde3lPwYZi
         x3yM258Zp/mGZPdYmbtg6iHvdlQJebkEYERi0tihNZGi93RZNI/hBN6bwGt7mlmRf40T
         juzvoccHqUvwjbrlPvSPo3KT5AFo2t2GP2ZYJPHFZBRmpdYslkp4Cdjt7AV+ZfyRYiK1
         BAEQ==
X-Gm-Message-State: AOJu0Ywbv/tSUzm0oqUJ0jwoaZPqa+VsRBVksuRsoXA34TowgE4G05DJ
        I+C3mLQX49EtgDNqJaZ9mOwYMg==
X-Google-Smtp-Source: AGHT+IEz88PTlxccW21WoEn2f42pE+pucQRcPi0Qyotu8SKV4KH1w7/IOT3aZDt9e1YeaqgPDQ7h+A==
X-Received: by 2002:a81:73c2:0:b0:59c:aea:d877 with SMTP id o185-20020a8173c2000000b0059c0aead877mr11208270ywc.40.1700000698319;
        Tue, 14 Nov 2023 14:24:58 -0800 (PST)
Received: from x1 ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m1-20020ad44d41000000b00670c7fd09cbsm3706qvm.95.2023.11.14.14.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 14:24:58 -0800 (PST)
Date:   Tue, 14 Nov 2023 17:24:55 -0500
From:   Drew Fustini <dfustini@baylibre.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC and
 microSD
Message-ID: <ZVPzt0w2+wNz6PnH@x1>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-6-3273c661a571@baylibre.com>
 <20231114-subsiding-tipoff-f3c15ef22985@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-subsiding-tipoff-f3c15ef22985@squawk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:24:40PM +0000, Conor Dooley wrote:
> On Tue, Nov 14, 2023 at 04:08:00PM -0500, Drew Fustini wrote:
> 
> > +&mmc0 {
> > +	bus-width = <8>;
> > +	max-frequency = <198000000>;
> 
> > +&mmc1 {
> > +	max-frequency = <198000000>;
> > +	bus-width = <4>;
> 
> If there's another iteration of this patchset, can you use a consistent
> ordering for your properties please?

Bah, I don't know how I missed that. Thanks for spotting that. I'll fix
it if there is another rev. I still need to see if Jisheng's is okay
with the most recent changes in the driver patch.

Drew
