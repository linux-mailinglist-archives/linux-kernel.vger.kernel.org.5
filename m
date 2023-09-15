Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF027A20B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjIOOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjIOOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:19:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E71FCE;
        Fri, 15 Sep 2023 07:19:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9338e4695so33779291fa.2;
        Fri, 15 Sep 2023 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694787592; x=1695392392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9p1y/dHKWZ4mldBm4B4C2rsKuH8pDG1nwww6AtIwFhc=;
        b=S55yFmX9FkgupeoDzmLQsFhYECFXPAPyXlVzrqvOBCbkrinGZZ2WUVj2MrtRWKICEs
         qdLYdYb6iO3bktSn9ocUfX6yM7zTD8ODoOfzk3+ALd9IuACWpUBVTzZxGmmmWR3l11A0
         20XNEUNwKMKCpJceqsh0ChI/xV+4Zgx4j0PyvdskAsm/81uGrz5etlwKPP1Np9rRrCZ4
         Fc/hRyc41U+oAD1r4CfkAMWjkd8Xl0xIXszEZilSjV3AMAtTgz/8OSXrx/mXdbhmiVRB
         KE5ICLV1qqJVg9hKRC071h0SWuvC5Sx+F1wfr8CmQZfUthOz9IGJNvadjAyxbFR3tIzF
         eFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787592; x=1695392392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9p1y/dHKWZ4mldBm4B4C2rsKuH8pDG1nwww6AtIwFhc=;
        b=ZLcHW7B7cgBMWiwC4sQLJf9GF+9FFTPjVCNMmsE8NiKRi68qsgGf7S8gsJSTjD2S3V
         eIsE9sTLJOtekmAJHkYnYYM04yvtUoDPFUwdCJklOmg3bnUdL3SIEUoVwokiwBxdnhIS
         THUkgGTO4pKoWkZhX2wTYbmjtSRJRM5GJZzCCZCSkeZqxug9yD/o7fKwlfyMbHIWUdUp
         YOsSJ+mZGOUpAbTQ/P+3QrohumpXVetvinnGGC084ewsnTIe8tLcQ4od/G/3d6PivxsC
         KjysS4KzUPzGyssk7jvjRdgugi9I9eihh/Y/uHaYIpZrPIp74chgGJuxdBb7mtP/9zfI
         TbEQ==
X-Gm-Message-State: AOJu0YwILZxV3t9+kGDcOAbMxIYynSJAGpUuMX+SfqZpvWeLVlCiYNcB
        ZIOrkV4sIREE5cE+g8dNXUE=
X-Google-Smtp-Source: AGHT+IHmpAzcVMy9/mTX5cEnVsuC3NbKv+46JVCvmYw71ilIB49LnenXkrLGAxFC5kVwaYrjAoW6Xg==
X-Received: by 2002:a05:651c:cc:b0:2b6:e2c1:6cda with SMTP id 12-20020a05651c00cc00b002b6e2c16cdamr1625717ljr.46.1694787591541;
        Fri, 15 Sep 2023 07:19:51 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x18-20020a2e9c92000000b002b6cb25e3f1sm696566lji.108.2023.09.15.07.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:19:51 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:19:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v5 0/3] Move Loongson1 MAC arch-code to the driver dir
Message-ID: <bwwxpczznbfaqpzuzvtgbkmluk6wfxfp25coy6t7mjq3axjnvs@5pvgxumiyjkd>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <ueevvju7i42wik6fevdmvbtypm4su77guyo4zizhrfreexken7@nrcovxfnyuvq>
 <f69ac27a-943c-3966-385a-e12ecd71d33a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f69ac27a-943c-3966-385a-e12ecd71d33a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:23:44PM +0200, Philippe Mathieu-Daudé wrote:
> On 15/9/23 11:55, Serge Semin wrote:
> > Hi Keguang
> > 
> > On Thu, Sep 14, 2023 at 07:44:32PM +0800, Keguang Zhang wrote:
> > > In order to convert Loongson1 MAC platform devices to the devicetree
> > > nodes, Loongson1 MAC arch-code should be moved to the driver dir.
> > > Add dt-binding document and update MAINTAINERS file accordingly.
> > > In other words, this patchset is a preparation for converting
> > > Loongson1 platform devices to devicetree.
> > 
> > No more comments from my side. Thank you for the patches and
> > especially for the patience in the review process.
> > 
> > For the entire series:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > * I'll also send individual Rb tags to each patch so b4 would be able
> > * to take it into account.
> 

> Maintainers using b4 should use the '-t' option, then you don't need
> to do that:
> 
>  -t, --apply-cover-trailers
> 
>  By default, b4 will not apply any code review trailers sent to
>  the cover letter (but will let you know when it finds those).
>  This lets you automatically apply these trailers to all commits
>  in the series. This will become the default in a future version
>  of b4.
> 
> https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html#common-flags

Oh, got it. Can't believe I didn't figure out to take a closer look at
the help-page. Thanks for pointing it out to me.

-Serge(y)
