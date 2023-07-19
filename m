Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40F759FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGSUeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGSUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:33:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D42110
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:33:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so8415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689798738; x=1690403538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR9pDkJyvmFWST+35dZB5yTNR0r3RHw1ebNMcx5Qd6M=;
        b=uL2HOOquQYa31IPJEl4PmmdUctPuTDJgnqV4mGmiVM5IdcsRs6rqJnY6MTjCvv0rlN
         eCUOUpiZ3Qt/9yB6TAB16yQXfGDhL5+Zj8+8pqHjT+zOn2pY5wH1zGSillzpNGoaDVAm
         thsj1tF1L33429IeB3jua+fgkGDU2KPnP4gqLoAU6NdXY+TXEOKpqnYkmASCuANXDU8w
         jtPhbaE0dHatW4TFMcE3YAadKluYUkLd+fz55FdWCRaCDkZAo3XoCn9gxEPC/LOgA8rA
         O2RRoOogewaipvKjrRKunU4VmSNqZVXoNoGmXlYy7ehwtEV240CetocVTU/QAWrvb6ci
         OWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798738; x=1690403538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR9pDkJyvmFWST+35dZB5yTNR0r3RHw1ebNMcx5Qd6M=;
        b=O+ozPxGu8rstxemQjLEBWfjPzjmY7vMBUIVwaP4NuwmkGNjpKiaH7STNXJa9CXHpoR
         2F/HVVchP8fgVw8GSCxr3YwYvahZnWhggsBqY1gN5ESJEOF1lE2xhfV7TvZhkOdxU55q
         lfZYJd5U7PhQeew8CFY9GgN7eWpLTjY9g/N0fIrYUx7PJB5U37QpMfyRaUFV5gNLXwcy
         mnRHqjGEM48/j6gcARbimcWwCw+dj88eB/XqJwF1ELlV4LJGqChD65BMRd6EjWAQoNvR
         azzWWoBvbLymbnFwpV+eEacmacgIZcOBdnniaJwW6zdLmYmzPWKT6Ro8F7MQph1gSKsC
         pBTg==
X-Gm-Message-State: ABy/qLaALw2JMKZEKk1ointU//Q4nvgEmrPYR8nt0LpROzaEk8VJpjTI
        B0yNSer831yyIb8jtvrzRqzYmou95zzh70bIoVxy2g==
X-Google-Smtp-Source: APBJJlEOaaiTThiWvm5e5CN75cIBZiiqyhQgRIxe43rNlyPkftMs6m4KPulKKJjgioQIMKeW/nCSYjxy4wlP8vjFq90=
X-Received: by 2002:a05:600c:3d9b:b0:3f1:6fe9:4a95 with SMTP id
 bi27-20020a05600c3d9b00b003f16fe94a95mr31994wmb.4.1689798738407; Wed, 19 Jul
 2023 13:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-4-glider@google.com>
 <ZLd+J3BkI3oK5vCw@yury-ThinkPad>
In-Reply-To: <ZLd+J3BkI3oK5vCw@yury-ThinkPad>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Wed, 19 Jul 2023 13:32:06 -0700
Message-ID: <CAFKCwrg75LVDYXMV1eZqB7MfJSvocq4WC9O1WiSTKAdPhvZevw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:09=E2=80=AFPM Yury Norov <yury.norov@gmail.com> =
wrote:
> This is the 4th time I see mr. Stepanov's credentials in the patch.
> I've no doubts he's a worthy gentleman but please avoid mentioning
> people in source code. Suggested-by is enough. IIRC, the rule for
> that exists for about decade.

Thank you for your kind words :)
Indeed, Suggested-by is more than enough.
