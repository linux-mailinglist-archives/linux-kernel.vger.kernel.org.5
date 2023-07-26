Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C31762937
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGZDXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGZDW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:22:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D57F2682;
        Tue, 25 Jul 2023 20:22:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-78706966220so53146439f.1;
        Tue, 25 Jul 2023 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690341777; x=1690946577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NL3EuYyvjjhZCYD78dzuWYzAA4q7ImU5255kcivdAlA=;
        b=YrDQVT3n1O3EiYwvIGJo9jid1fKsLNw2s5BtVJ5JvGxYyPR1XjrUtnjfk86ybuDqvD
         mjkbbUuyR5VaB9rjSCR72ECLkPoHrMLk2ceMPKchY63bLMTQ0uCFoaZDI1rHSRdcZkBa
         Rj4LJYewPahFgAw+IE0I66Qm8T3wULByAcoETQYDq8VJzatnTf4P27YEUdI0SknFz3lz
         XEQP6TM/KY0h1JyYR68C89+l8h3L8U59mSzM8/oIOIzhC7QsCaK/HqQy8I1TjSgmiW8m
         rYeskGDA9hosrrCFYfjvbKnf/0CWiTVMAuWvQE8UyAnzJLx1bvG10rIKl4kTIK4KL4+E
         i4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690341777; x=1690946577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL3EuYyvjjhZCYD78dzuWYzAA4q7ImU5255kcivdAlA=;
        b=ZFUKr3MXFFgpLVQJoQ99KRY+WH6Go2sZFT0h+jdGANo7rzlk8tpjzBo7G7WJZSCHeT
         3tCbY6k1XVuoHm+FZ+4gEUGEazWKBca+5jWHT4N+OnF5NWYQRZFMAr6XvZi+T9MC54wd
         hIr1mM0BCvMECsNtC32s5ynjunHwcailj2ICnzTf5uh/K4bRHCvR14jVw3JUT2A/IsYs
         JJikH7aGPBifoJoDg49RUXogLq46FPxLxDCp2lzBcLTbxH6qlsQ47xyLsJLkjGYl7OJ2
         c07ph9qLIp6zawMxw24yrwPK8M3WdjbwGqFibLr+TCIVeQ1QSpzhAMRwA5L7KIJZTCT0
         /czA==
X-Gm-Message-State: ABy/qLYY8J6bLZsCBf0b8xLtBhZUMlfv9hX6QAw0B3FEZf+AAfyN1mB3
        Ym33E5S9SflmCttw05qfhmQ=
X-Google-Smtp-Source: APBJJlH6yBw+cvBcbmXyvs1PZzwvZEc6/RU38mhLvcrD3wYRbKLXGce0SxktHOdc8rnQsf8pyEfhoA==
X-Received: by 2002:a6b:1446:0:b0:77a:ee79:652 with SMTP id 67-20020a6b1446000000b0077aee790652mr603947iou.1.1690341776913;
        Tue, 25 Jul 2023 20:22:56 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i75-20020a639d4e000000b0055387ffef10sm134985pgd.24.2023.07.25.20.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:22:56 -0700 (PDT)
Date:   Tue, 25 Jul 2023 20:22:53 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Zink <j.zink@pengutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725200606.5264b59c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:06:06PM -0700, Jakub Kicinski wrote:

> any opinion on this one?

Yeah, I saw it, but I can't get excited about drivers trying to
correct delays.  I don't think this can be done automatically in a
reliable way, and so I expect that the few end users who are really
getting into the microseconds and nanoseconds will calibrate their
systems end to end, maybe even patching out this driver nonsense in
their kernels.

Having said that, I won't stand in the way of such driver stuff.
After all, who cares about a few microseconds time error one way or
the other?

Thanks,
Richard
