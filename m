Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C497B2756
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjI1VRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1VRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:17:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067AF3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:17:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8a822508so1779523666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935846; x=1696540646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOLKD+dZ4eKUfIGgNxL5xyo6MXfu46Z0PMVOhkalApk=;
        b=HWMcDsBhoC8OcpJzthYDv+JDLRXkUlAGuXWR3YIYy1c5pMm/pbmoeOMCQA8KnOv/rZ
         pRDbrPFwUj8vQx22cPN5nbfSBcaYdt1Yg9IFm4YL26gqVHLezZ5grCyqLI8AZMnGwG2d
         c58hSl4HiNCxF+JnaWcNY++cVmEXjQI/xbBPYN6GZPbzFXqKybOjv46ko/DTF5rFDGP5
         3A38ETRrZAmYqq1JVoBomIuVRjtpaI+kV6DcGR6SsPFGwmdAyNv/o73CIiqvjTmhbwqg
         Nc/3Ufjte3nh1i9YprM4ZkHW3iz9X0rC6LLnIa7OE8YiKxcj2sqkiBysxD41AMsHSXpN
         phXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935846; x=1696540646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOLKD+dZ4eKUfIGgNxL5xyo6MXfu46Z0PMVOhkalApk=;
        b=FcsAEZZkB1tecAorzh+DiLZDYi5L409qYzbtaJgt8m9jgVqW6Y04P4HylVT2JsADwf
         1jSAuXdyQvlRoTqpf7koeHKpTABk+2+UR11ZuCpJsxYUeM+U1HquFkNQH3ZjY+oVam9n
         p8v0OcDqs2kU3r4Kvu/e3SdLLrquocvkR75yyuVGdJK7SCtZYpFzlrxK85mtnJs60/9k
         pYpgdCEMznbInPXxMbwBGAkiyqrpPYIsvYst3RSzPfJOP9mkh7FRjNvsZVMxjCCnH/Lp
         V09Q8Gob/Z4Zws8QFE6kW7G9jpsOineHno3PZ71YRLQW9Wbn2Uuk59Klfz2ZVsOwFLCL
         tlzQ==
X-Gm-Message-State: AOJu0Yx0IU1nm2i7+MYhdWHlFUuqi2Qi1ELjzFLDDg8QgMWGPi13nd1u
        6cFt70KH3EAmH+g5FWFOUZI=
X-Google-Smtp-Source: AGHT+IFiqFTKmdhbxuHnd0UkrdV7E62jBybvnImlXxobRDF3xRWcomLQKKackBEZSRbT9T+ehKcVlQ==
X-Received: by 2002:a17:906:530c:b0:9a1:e941:6f49 with SMTP id h12-20020a170906530c00b009a1e9416f49mr2551299ejo.44.1695935845835;
        Thu, 28 Sep 2023 14:17:25 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id bu10-20020a170906a14a00b0099bd7b26639sm11455976ejb.6.2023.09.28.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:17:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 23:17:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] irqchip fixes for 6.6, take #1
Message-ID: <ZRXtYzIA5dK1iPVb@gmail.com>
References: <20230924094105.2361754-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924094105.2361754-1-maz@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Marc Zyngier <maz@kernel.org> wrote:

> Dmitry Baryshkov (1):
>       arm64: dts: qcom: sm8150: extend the size of the PDC resource

This SOB chain, while valid, is a hodgepodge with no rhyme and reason:

  Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
  Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
  Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
  Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
  Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
  Signed-off-by: Marc Zyngier <maz@kernel.org>
  Link: https://lore.kernel.org/r/20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org

Besides the ordering, people in the SOB chain should not have a separate
Reviewed-by tag: *of course* anyone who forwards a patch with a SOB has
reviewed it, it's basically implicit.

So the tags should be something like:

  Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
  Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
  Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
  Signed-off-by: Marc Zyngier <maz@kernel.org>
  Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
  Link: https://lore.kernel.org/r/20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org

Ie. we generally sort the tags not chronologically (or whatever the original idea
was), but group them topically, sort the groups by importance, and only within
the group is there chronological order.

Thanks,

	Ingo
