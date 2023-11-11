Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DF57E86CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjKKAHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKKAHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:07:52 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12310A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:07:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bd33abbb90so1927877a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699661268; x=1700266068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZOLx6piJ84WzMT/cgtNzYXyAwxaq83dr7vI8k16AOs=;
        b=VpwjBRELtn3hl/lwknWR2q5pKLw7AUqGVcSQIfIb3qH/Qp95CSael2LxODcQZFRqy/
         j7gzlGE/my7dcbuTVo+zsF2j61gF+6j0bUGh3AdBDsMVgiP21fvNWp0C9huXKnVov/yB
         GkrhYD1E91olWVUjdLeto15o49XcVEi2SmCsPlV16hMpIzDX84m2K2nlvaAqSOD6zLBY
         M0ZX0Iea1/MmQ8CwaWx3rENOe0xmnaGhuClBqSULxm9Lv8LGQwBcM5+eSnf0jA9c3R2D
         NG4a0UsXXwAYY8JEZfzxhifRoxxd9y8P2JWVWbmC31KAEbq9mrB0o5fr5u1vi3uo6I3E
         8dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699661268; x=1700266068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZOLx6piJ84WzMT/cgtNzYXyAwxaq83dr7vI8k16AOs=;
        b=By1P42I6BOTW+MJ4ZTZvLfmoR7gRxfgyRZmhk583vnTBvMpSEK5ai5Eq3cG8KmoZH8
         gN0Q0BKvCpKuhHlxRI6DhqWgWgPuP3z0CYPTLmKjKT68O0OickClkPdXpwC//hUCfXTb
         7zpXBt2K38DKA4e7x8b5XuhvTwS79Fm2CIJLf/P9PxNEAQYggoROaQ3RH6VysCBaLroV
         XdHu2Am2I50tbi5E2+XTfZ+VS1T6jc6kNONwAkHYExS5i0kxv6S6XWYljooMrsHJx4IY
         XJNuZpcvGfWyHpr7Cq075LFo9480X+P6EeTPNKGl8/mgtNaerddqdPpJjZnh2yLEQM7Q
         g80w==
X-Gm-Message-State: AOJu0YxXJekIyF3OikECqzs2eSxsp/heEJwsN7kzr2Te5kjz8T/FY6nN
        3rZ/6N8y4BYfvtD+VRLCp0MCvocFBAGPb8yNrw3XnQ==
X-Google-Smtp-Source: AGHT+IEf3RnQ6vghHFIDkcaI3xfo22n0ICD/Y7dXSaL4pgL+HjLTqobf8F4Ab5nqLI350QpkYuW/Ow==
X-Received: by 2002:a05:6a20:daa3:b0:14e:a1f0:a8ea with SMTP id iy35-20020a056a20daa300b0014ea1f0a8eamr792191pzb.3.1699661267932;
        Fri, 10 Nov 2023 16:07:47 -0800 (PST)
Received: from x1 ([2601:1c2:1800:f680:e564:eb78:dbd8:6618])
        by smtp.gmail.com with ESMTPSA id p47-20020a056a0026ef00b00692754580f0sm272439pfw.187.2023.11.10.16.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:07:47 -0800 (PST)
Date:   Fri, 10 Nov 2023 16:07:45 -0800
From:   Drew Fustini <dfustini@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZU7F0d+MCefRskPn@x1>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
 <20231109-th1520-mmc-v5-5-018bd039cf17@baylibre.com>
 <4cf3d481-c16d-4b1c-ab45-3ceff80b0b1b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf3d481-c16d-4b1c-ab45-3ceff80b0b1b@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 12:10:34PM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 06:41, Drew Fustini wrote:
> > Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
> > controller instance which is typically connected to the eMMC device.
> > Add mmc1 node for the second mmc controller instance which is typically
> > connected to microSD slot.
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index ff364709a6df..f5ec9326c4b8 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -134,6 +134,13 @@ uart_sclk: uart-sclk-clock {
> >  		#clock-cells = <0>;
> >  	};
> >  
> > +	sdhci_clk: sdhci-clock {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <198000000>;
> > +		clock-output-names = "sdhci_clk";
> > +		#clock-cells = <0>;
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&plic>;
> > @@ -292,6 +299,22 @@ dmac0: dma-controller@ffefc00000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		mmc0: mmc@ffe7080000 {
> > +			compatible = "thead,th1520-dwcmshc";
> > +			reg = <0xff 0xe7080000 0x0 0x10000>;
> > +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&sdhci_clk>;
> > +			clock-names = "core";
> 
> You miss disable in each mmc node.
> 
> Best regards,
> Krzysztof

Thank you for reviewing. I will add 'status = "disabled"' to each node.

Drew
> 
