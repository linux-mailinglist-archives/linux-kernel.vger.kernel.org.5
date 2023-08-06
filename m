Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB99777130F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 02:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHFAFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 20:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHFAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 20:05:13 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D018B;
        Sat,  5 Aug 2023 17:05:12 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bba7717d3bso2463738fac.1;
        Sat, 05 Aug 2023 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691280312; x=1691885112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGO1VfGHV59sGcd/OlhM815rBhbcYsIBbQw+i+B46zk=;
        b=aW0ADirHmQDgbrxgIti/gd97ygIxQCtXCEtQBwZfBUOEThVaswhFvBtuEREUlzRnTK
         SZC6cBrERFCNTds83qBtu6th+nJ03EOCdpZLF8mfRPerVOj99KAnuILoX3sep6P2YAna
         3IK3AzNq75bCgJprvFRGaPOK4omvtnIPo4CrpuGKVcmvnwSX8NuFo5nNbBXTOBNxU/tm
         vl5p86LkSZkEDo51SdSrqQZ9MAeMIDEnMsyxuRNXPMrzEUHnsozDkBYydvtHCqRrf52U
         KG7Dx+nJ1v1J6WWkRxXdqb5M3KVW0Tqc0vmvfsKLw4/82wGM8uoyWCep43SXetEyvGzN
         Qsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691280312; x=1691885112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGO1VfGHV59sGcd/OlhM815rBhbcYsIBbQw+i+B46zk=;
        b=dpaWJJq3Sxuu8jsdYK9rS3eycyDamXHepQ20pwN8Hd8YLnmZE8zd7lBP5xBBjZH6M2
         4xWKOI6uw2HYc8TE3AFoz82GR/lmGCcyBiE/92PDzlLmugekLoX2qIgR32QOAaJrX8Yv
         g3RAjxU4vwPIryUQNiOeRJbhBTotqyoSkBQ/+Xv6nPfnu2nlZphulffVQxtcf7QNyzOr
         O6S5Ck4ktX8YRIugicYmO+peK2FK63USGqPRcEDhmNPJqG4wz3c6POUiySOHCGnYNayM
         lVTibzAQ1wjwnhjcbu5eUTgn+96l0K4T7DG7MSHzSidR0MxRH29i77HHvu6qSf0HeS3J
         g0DQ==
X-Gm-Message-State: AOJu0Ywaf9XacJzwLqLO69lN5DYHn8VMESGxNlOmvhN/hdetFkdVTPIj
        SSoFuOS8A4mGmPTBmtTqOr4=
X-Google-Smtp-Source: AGHT+IFYBscoDRUKj+BsfMN/xQKOUlh7C1v/0IlLZDRRaERctoSYra5uRwT9I0LHxe2OLVgh3OKXkQ==
X-Received: by 2002:a05:6870:4393:b0:1bb:8867:f7ef with SMTP id r19-20020a056870439300b001bb8867f7efmr7210903oah.25.1691280311691;
        Sat, 05 Aug 2023 17:05:11 -0700 (PDT)
Received: from Dell-Inspiron-15 ([2601:18c:8380:74b0:e8e5:f40c:d741:8f07])
        by smtp.gmail.com with ESMTPSA id g22-20020ac870d6000000b004054b435f8csm1611704qtp.65.2023.08.05.17.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 17:05:10 -0700 (PDT)
Date:   Sat, 5 Aug 2023 20:05:08 -0400
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] arm64: dts: amlogic: Used onboard usb hub reset
 on odroid c2
Message-ID: <ZM7jtD2rniWAexVZ@Dell-Inspiron-15>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
 <20230121175639.12818-4-linux.amoon@gmail.com>
 <ZMrFb7H1ynwwBSCA@Dell-Inspiron-15>
 <45d25fd5-465f-347b-448b-ce171626f34e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d25fd5-465f-347b-448b-ce171626f34e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 11:30:21PM +0200, Krzysztof Kozlowski wrote:
> On 02/08/2023 23:06, Ben Wolsieffer wrote:
> > 
> > Hello,
> > 
> > This patch breaks USB support on the ODROID-C2. As soon as the
> > onboard_usb_hub module is loaded, all USB devices disconnect.
> > Blacklisting onboard_usb_hub makes USB work as expected.
> > 
> > I tried to reproduce the problem by manually toggling the reset line,
> > but the problem seems to be specific to this driver. When reset is
> > asserted manually, the devices disconnect, but they all enumerate again
> > as soon as reset is released.
> > 
> > Also, I have been unable to make USB work again (until the next reboot)
> > even after unloading onboard_usb_hub.
> 
> Wasn't this patch made exactly to fix USB support, not break it? I might
> be missing something but maybe this was not tested at all?
> 
> Best regards,
> Krzysztof
>

I have been using USB on the ODROID-C2 for several years without issues.
It looks to me that this patch was designed to make reset control for
the hub more elegant, rather than fix a specific issue. The same change
was applied to several devices, so it seems plausible that it was not
tested on all of them.

Thanks, Ben
