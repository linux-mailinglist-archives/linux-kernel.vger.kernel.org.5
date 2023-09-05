Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B721D793007
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjIEUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjIEUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:31:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15668E;
        Tue,  5 Sep 2023 13:31:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a645e54806so387288766b.0;
        Tue, 05 Sep 2023 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945881; x=1694550681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgTzGf3A5ABFaOAKIOcvbbSGQ+ICpNJmns+q5eLD6Uw=;
        b=lPeDHI5AZRmLG1HHLgn0KXn3Wspu1oRL6Rt0rJGIpc6FMVyMy3UZTyl4LgAv/pZbyP
         mATDVq6LyID0TXpW8BXvxk2Kp5GNLAncryinfIYdyg5cAr/OTk5aPueVBbveYPvsShqS
         aE/hJdmY4lCFwwMaoAYceXQ1JD6pgmo2FKe9j1RYr6tsp3X2GOgTx8kh/pgvIrf8xigE
         UbvcYRSzQ5unZHMM074LQFaEfSuqIAnj4dzgGUbm1cHXqJoVT0FVZhyetgo3aRx8Ipmv
         73YGlWiy6gMGD/+C9TOUfNaQq1vbZSUG4mDT0NFMAV16cC0q5LmOQdR9bcpztp4E0X6Y
         JN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945881; x=1694550681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgTzGf3A5ABFaOAKIOcvbbSGQ+ICpNJmns+q5eLD6Uw=;
        b=CwyuWgbeyCNgMyCgQve+nv0HhuMnJMJwLYFF2jzI8ePAis9QFCbN4VDMYjAHrGacQ1
         O9gMOsAQ31Y1hf68ddSmjG3NGuDy0EfG3W1Tkt4HfVymAOGIPGmf9wX1VHCVIYGycZ5T
         rzI0J2NEbcOulLVwlK+2eeCeEi9o32JoxV6w2cdvhLMv5RH7nMF+xm6oh2vCxQ4KoK4l
         /BPbpgkHVuTOpE8ck0sOjXM2dgl0143NLP2CqEH7vVBxKetgHVhqkv42xGAUfI/w2Cyg
         vmh0gkbDG25kN6pxZ7A5R+mNpZEurQ7iqsMYZbfk6hTbHgXXMdV4gvIKl+djCS7lqNom
         40Ew==
X-Gm-Message-State: AOJu0Yy2Q6du82JhxI74C0ctXWQ9UNp+P1FG7LVO/Mk/Aak1w0/8fLxV
        ueazZy7Cu9vv2f0ToOaQj6E=
X-Google-Smtp-Source: AGHT+IE8Ds1Fhnf96UooRYa+B+2f6mBXEO1bpMNk1UHPXQ808A78VR9ByCkJN3v1B2Gy1JkrO34TRA==
X-Received: by 2002:a17:906:214:b0:9a1:ce57:8e47 with SMTP id 20-20020a170906021400b009a1ce578e47mr665120ejd.68.1693945881305;
        Tue, 05 Sep 2023 13:31:21 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id a25-20020a1709064a5900b0099bd8c1f67esm8124988ejv.109.2023.09.05.13.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:31:20 -0700 (PDT)
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
Date:   Tue, 05 Sep 2023 22:31:19 +0200
Message-ID: <3760158.kQq0lBPeGt@archlinux>
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

On Monday, August 28, 2023 6:30:22 AM CEST Inochi Amaoto wrote:
> D1 has several pmu events supported by opensbi.
> These events can be used by perf for profiling.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
> Link:
> https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/
> pmu/rtl/aq_hpcp_top.v#L657 

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

What's the status of dependencies? Are they merged?

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
> https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C21777BB
> E2A@IA1PR20MB4953.namprd20.prod.outlook.com
> 
> The patch above also provides a example that shows how to setup
> environment and use perf with T-HEAD events.
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi index
> 8275630af977..53a984d78e3f 100644
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
> +			<0x00000000 0x00000001 0xffffffff 0xffffffff 
0x00000008>,
> +			<0x00000000 0x00000002 0xffffffff 0xffffffff 
0x00000010>,
> +			<0x00000000 0x00000003 0xffffffff 0xffffffff 
0x00000020>,
> +			<0x00000000 0x00000004 0xffffffff 0xffffffff 
0x00000040>,
> +			<0x00000000 0x00000005 0xffffffff 0xffffffff 
0x00000080>,
> +			<0x00000000 0x00000006 0xffffffff 0xffffffff 
0x00000100>,
> +			<0x00000000 0x00000007 0xffffffff 0xffffffff 
0x00000200>,
> +			<0x00000000 0x0000000b 0xffffffff 0xffffffff 
0x00002000>,
> +			<0x00000000 0x0000000c 0xffffffff 0xffffffff 
0x00004000>,
> +			<0x00000000 0x0000000d 0xffffffff 0xffffffff 
0x00008000>,
> +			<0x00000000 0x0000000e 0xffffffff 0xffffffff 
0x00010000>,
> +			<0x00000000 0x0000000f 0xffffffff 0xffffffff 
0x00020000>;
> +	};
>  };
> --
> 2.42.0




