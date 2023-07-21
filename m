Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5175CE4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGUQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGUQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:19:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662835AC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:18:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3141c3a7547so1659210f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689956288; x=1690561088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sA2hRH6tfaw45jC8b+muVq/w9g9VDpgo6qGxGygAeH0=;
        b=CNaUEWo8mfPYc0zH13AH7uE+VJ33ncwsDfdCgXuFzvC8SlNGdExg4bpxcTRa+TfV5d
         3f8jlokXgLYla/K8kMKXsOqRLmHlmMWezK4yMk82QJ5hmbYV4Zm9LHPm4oBqx2V3ks9U
         MuqSF6EN3h+7Iy5uRM7S7zOXJquE/PLH1X8lMBSSCMsFdxK49xpu+I8cwPVo4OvUWhuw
         rE9qk/zyrkGBfbW6LY4j7kvVBMk9/6NC3iil7iwCZoz+X5GhD3r/9+JG1lXtvKnmvDKw
         J5VBOdlp0lK6Ey3eQHN8md7m1243EbhpSfyMB0jHLGaLIfGonIDXdBvrOf/4dK+YVC65
         ZY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956288; x=1690561088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA2hRH6tfaw45jC8b+muVq/w9g9VDpgo6qGxGygAeH0=;
        b=DJXO0kvGLSBcUoCVOopGkB6+7djdXwTp8KAPMUUu1K6y0tnAi7nGx154mkQp/66Xdy
         KdOxo1q5yJVan4y5FleSS8BGf03hiYoRlj2Y5vtI4F2tiFTDrJvcL4jWYpEFvDn7pyUk
         uzef2Wnc8fJ5QMM4KNOAthUs6za7lobCgJGAvaJJaAD+NjU4vLDSiJosEEOZdAYs+2wa
         qHwh7VfoNE3KNjZgBGtFJZuJNq/LzG1k63szm8RLgKfRAWYZqxJBX9p1gOnvhxjNDVkl
         qmVFXjT1r6S1mQSQg9PPmP6suvl9IdRKsfQ7ZC4/707rNyTqAsN/O7HcAgAK5wAUvpft
         T70w==
X-Gm-Message-State: ABy/qLZ8Sx7pGqRc334S9M4hkvW/3SJumCgZAuj6W7wseUwANsMD67Zk
        WIskUxFD6KN8bvwyLgPdI4VBoSM78B6vnMcNwdw=
X-Google-Smtp-Source: APBJJlFeAtdiYRavePrg+Tz7Q8In1dPtMAHvPMuIL6njPICT0ZwKprhmWBq+pvu411ehMEOjv5G8kQ==
X-Received: by 2002:a5d:5909:0:b0:313:f990:c631 with SMTP id v9-20020a5d5909000000b00313f990c631mr1736281wrd.44.1689956288564;
        Fri, 21 Jul 2023 09:18:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r9-20020adff709000000b002fb60c7995esm4679564wrp.8.2023.07.21.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:18:07 -0700 (PDT)
Date:   Fri, 21 Jul 2023 19:18:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations
 with RBTREE and MAPLE caches
Message-ID: <e61ebbfd-98d2-4dad-98e7-67d81c0cc04e@kadam.mountain>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
 <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
 <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
 <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
 <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:01:03AM -0700, Guenter Roeck wrote:

> Dan, let me know if you don't have time to send a proper patch.
> I have one based on your suggestion prepared that I could send out
> if needed.

I sent it but, aww crud, I forgot to CC you.  Really, get_maintainer.pl
should add everyone from the tag section to the CC list...

https://lore.kernel.org/all/58f12a07-5f4b-4a8f-ab84-0a42d1908cb9@moroto.mountain/

regards,
dan carpenter

