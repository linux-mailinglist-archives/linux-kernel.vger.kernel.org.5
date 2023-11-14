Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F97EB956
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjKNWaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKNWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:30:33 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B4C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:30:30 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-777745f1541so395657585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700001029; x=1700605829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XST0nJe2LTZ4oHvfVDx7eyej+3hWOw1VagBLPa3XUw=;
        b=xKbUDYIrLlOI33Sp9f82M2rt6VNkOPlg5ByrRzr26yt/7G5zFKeYH1O6pBoZqAkfH7
         vKZ4JGZR/azgL8e+X33N3ktQ29+Z9QmKdG0A94VsDCdmgDQeMkwrSWGWuNfCc/vyE7oH
         45uVlJJaWYakhWIItOtwWtSKLt1242WiI5vqPfT6Zykwb+yeSz0KXhnMnbMDkZtQgYZ7
         LJZqc6tcuZEFy+XY0npgygLf0anZN/l+rLqAFkSpWuWyXtsY2UKvXid7Szfb0S1VkO/l
         tBraPztCx0bhucOavgCxrmPVW2npCP/QLMXkMuZqoq00yxVAAQALwqJ7XDiq9Tu5dU4g
         SVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700001029; x=1700605829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XST0nJe2LTZ4oHvfVDx7eyej+3hWOw1VagBLPa3XUw=;
        b=GkAkzCDATaEdzf8h1FzT5mZ8xoMsImWDZZ+0ExkY1vwfEHhwrfpCKYKr7vMEFIiTUq
         S2k08ZHg1HlgPv9+TNrrkKz+FfA4F9eJIYuRMhc0mTqadA00br7kl2IMfPmeGF6hjLhn
         A/C2b//5JUu3aRZrEM7B0Hn+Y7cTHBE3TZ8dMeL9TKtoaUcirdxeJnMX4isqzTP5rkqG
         UJjyYKSBkgIHxv/jD1quTPQgmWcp4eglt3QmRfXNGFJrHeuzz8UmxP4sfhmOmWmghugQ
         z6MIq3qcIlEOMNXCP23RZpoHzUhUcO/81aoKYCyBt2w+kMupEPy/ny4WyEyWUbljvvCk
         uKFg==
X-Gm-Message-State: AOJu0YzDI7iEoaipVOVu9tpljrgKEzqGep2HGp8koElD1YwKL6JAa+DW
        rLpCemhkhqmQVMClZUUynJjd2A==
X-Google-Smtp-Source: AGHT+IFMKHaDQrXdjPlVZanAMM7n0JSJwglGmnqidJ3M4rjzD/Zj6FS0kt5MVg8MvJG467X+FEDorg==
X-Received: by 2002:a0c:f9cc:0:b0:66d:5dd:26f6 with SMTP id j12-20020a0cf9cc000000b0066d05dd26f6mr4147253qvo.25.1700001029699;
        Tue, 14 Nov 2023 14:30:29 -0800 (PST)
Received: from x1 ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id c14-20020a0cd60e000000b0066cf06339bcsm21546qvj.0.2023.11.14.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 14:30:29 -0800 (PST)
Date:   Tue, 14 Nov 2023 17:30:26 -0500
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
Subject: Re: [PATCH v6 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZVP1AoosripWj3gs@x1>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
 <20231114-starring-swarm-0e1b641f888c@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-starring-swarm-0e1b641f888c@squawk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:27:44PM +0000, Conor Dooley wrote:
> On Tue, Nov 14, 2023 at 04:07:59PM -0500, Drew Fustini wrote:
> 
> > +	sdhci_clk: sdhci-clock {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <198000000>;
> > +		clock-output-names = "sdhci_clk";
> > +		#clock-cells = <0>;
> > +	};
> 
> If only you had a clock driver to provide these...
> 
> Is someone working on a resubmission of the clock driver?

Yangtao Li posted an initial revision back [1] in May but I don't think
there has been any follow up. It is for sure something we need to have
in mainline so I'll take a look at getting that effort going again.

Drew

[1] https://lore.kernel.org/linux-riscv/20230515054402.27633-1-frank.li@vivo.com/
