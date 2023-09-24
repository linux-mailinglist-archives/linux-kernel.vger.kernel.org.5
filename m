Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5857ACBCA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjIXUKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXUJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 16:09:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89989AB;
        Sun, 24 Sep 2023 13:09:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso673393866b.2;
        Sun, 24 Sep 2023 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695586191; x=1696190991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxREjewkNFrWDAgPsnTZpMxgPvvi0KDP02tpQh/XKD0=;
        b=eWjPJH3aG0iPQCwCMmoYqpQnuGeauoPyPnSEwi2vrCBuL4JXmTdrUsj3bitTTlG/q0
         r0nFJU3CGiZnGRpNRB922ztndgKwDyJGK9ZZGZ2O/K5W6h4Mfu6N6sbgk6qRuFzmjzlN
         LCumiBeQqb+y/yql1BTeo1W6AJ0LpjDOi98EgZlP+IXIryQU0TWUztOPIYGMLUOwdx+n
         MSgQPq4wGfEeRwX0kWRe3bIIu0TN2pnY2G8+D6jfEAzA4skjYjMSgaSOkbOr65R4daEL
         oCYt7OtbmyxP5pKggnqudFSIfN7lBHCHGfy2zGW0wFWOXXyAS6dyVaI3YlrwuQewXr2N
         YGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695586191; x=1696190991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxREjewkNFrWDAgPsnTZpMxgPvvi0KDP02tpQh/XKD0=;
        b=BcXVFN9WCb57KPARpFpiuNlpzkQMh0L8AnwjRQIIYyL/lz4B6uecTA33QwwRXhU257
         zEl8bCdVY1l8FIs2kan9vzxHGpJzDpEmCuqiPQ7doBzB7MFuLSZeKR8SNRB1XLBRXnOG
         dIFYpJ3lw6KjGOV83F8NlEOgxkct3Lu6h1gqjYrtg+0J3lKpICyGYrSV5etkYYQswZPG
         4n8hVsVXqlz6+0Kob3DjXgH8jM4ePfEgeGPWRhwAVVOxPNELAOPVwlIj10tdnmgH0rfh
         Swz62aD7Z3zV7Np1v73vX08MNrUDLYcRcmKKhaAb2ljWVZ0WHF8Lud4ZcKAoiGZcPbPY
         Wqrg==
X-Gm-Message-State: AOJu0YwLkV74W3oqH8HPII4sfAnbJWvCoEW/fmNe08USj+xsQhfduGZv
        p5M2dKlosIESK1f1IOqIb5I=
X-Google-Smtp-Source: AGHT+IFacAw8IlUF7W7gT0BHUL/iwLFqkcmREgIzUohJpb5r19xZXpCugD8qQ2/zyVfpFPTyuLkyFg==
X-Received: by 2002:a17:907:7818:b0:9ae:654d:5105 with SMTP id la24-20020a170907781800b009ae654d5105mr4480937ejc.47.1695586190881;
        Sun, 24 Sep 2023 13:09:50 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id la9-20020a170906ad8900b0098f33157e7dsm5342713ejb.82.2023.09.24.13.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 13:09:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: dts: allwinner: d1: Add PMU event node
Date:   Sun, 24 Sep 2023 22:09:49 +0200
Message-ID: <1770354.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <IA1PR20MB49534918FCA69399CE2E0C53BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49534918FCA69399CE2E0C53BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 28. avgust 2023 ob 06:30:22 CEST je Inochi Amaoto napisal(a):
> D1 has several pmu events supported by opensbi.
> These events can be used by perf for profiling.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
> Link: https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L657

Applied, thanks!

Best regards,
Jernej

> ---
> changed from v3:
> 1. remove wrong event mapping of 0x0000a
> 2. add reference url of c906 events implementation (D1 only support events
> described in R1S0 user manual, but event mapping is the same)
> 
> changed from v2:
> 1. move pmu node from /soc to / to avoid warnings when checking.
> 
> The meaning of T-HEAD events can be found in this pending patch:
> https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com
> 
> The patch above also provides a example that shows how to setup
> environment and use perf with T-HEAD events.
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> index 8275630af977..53a984d78e3f 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -73,4 +73,43 @@ plic: interrupt-controller@10000000 {
>  			#interrupt-cells = <2>;
>  		};
>  	};
> +
> +	pmu {
> +		compatible = "riscv,pmu";
> +		riscv,event-to-mhpmcounters =
> +			<0x00003 0x00003 0x00000008>,
> +			<0x00004 0x00004 0x00000010>,
> +			<0x00005 0x00005 0x00000200>,
> +			<0x00006 0x00006 0x00000100>,
> +			<0x10000 0x10000 0x00004000>,
> +			<0x10001 0x10001 0x00008000>,
> +			<0x10002 0x10002 0x00010000>,
> +			<0x10003 0x10003 0x00020000>,
> +			<0x10019 0x10019 0x00000040>,
> +			<0x10021 0x10021 0x00000020>;
> +		riscv,event-to-mhpmevent =
> +			<0x00003 0x00000000 0x00000001>,
> +			<0x00004 0x00000000 0x00000002>,
> +			<0x00005 0x00000000 0x00000007>,
> +			<0x00006 0x00000000 0x00000006>,
> +			<0x10000 0x00000000 0x0000000c>,
> +			<0x10001 0x00000000 0x0000000d>,
> +			<0x10002 0x00000000 0x0000000e>,
> +			<0x10003 0x00000000 0x0000000f>,
> +			<0x10019 0x00000000 0x00000004>,
> +			<0x10021 0x00000000 0x00000003>;
> +		riscv,raw-event-to-mhpmcounters =
> +			<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
> +			<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
> +			<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
> +			<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
> +			<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
> +			<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
> +			<0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>,
> +			<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
> +			<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
> +			<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
> +			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
> +			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
> +	};
>  };
> --
> 2.42.0
> 
> 




