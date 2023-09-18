Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48537A5526
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjIRVlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRVlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:41:19 -0400
Received: from out-225.mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D2090
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:41:12 -0700 (PDT)
Date:   Tue, 19 Sep 2023 07:40:58 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695073271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKF5pL6j1FaLIvd2+LW2+OTS2g0SVXD9k2NzY4oj/+o=;
        b=eAJF0wJ6X+530eG3LxNkM63PN7qnRhh/PzY1ZTLxsu03jkiohE+49ByAC21ZDo4tPqDmtD
        Utn+P2HHAWUCvdC82d1DJZj0HWLlFu7mjzqztVYJuCuS5sYcUXfbGos0zKvYfKnhR7Z5qA
        qsZyeZ553i9kSJquTAxHnKvwFOqfq7ojHi4OXupJ5Ksrc+skSooeb1y5IKQ9gRlRxHPlBd
        Gq+2ryiO6nAieBGVdorZt/bQxqNXWh2iM5PgGV7fJTiz2Y6F3ZwH7oPw7iAwLBvrwWlW9+
        mD/6OBOASGm4iSvTSmfKC45Yy3MNMGO/0KHhvpuKeDWRO5DGQMM1wyjRIxgOyA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/9] drm/panel: nv3052c: Sleep for 150ms after
 reset
Message-ID: <ZQjD6gCEo62gMBX2@titan>
References: <20230918125853.2249187-1-contact@jookia.org>
 <20230918125853.2249187-4-contact@jookia.org>
 <7fc1ca68-ca7c-59b2-0b70-27bc34d83cee@quicinc.com>
 <ZQi4fFZ0VnsUIiXO@titan>
 <4d2079d66249a7052acded0abf30169a4e95d151.camel@crapouillou.net>
 <ZQi8Z45VCqr-GqN6@titan>
 <0d6b0159552b10548391a9bd88449d12c13fdcd6.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d6b0159552b10548391a9bd88449d12c13fdcd6.camel@crapouillou.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:34:51PM +0200, Paul Cercueil wrote:
> The driver is guaranteed to always reset the panel in sleep-in mode -
> as long as the panel was off when the driver started.
> 
> What I'd suggest if you really need to support a case where the panel
> was enabled by the bootloader, is to read the 0x0a register after
> enabling the regulator to read the mode, and sleep 120ms if it was in
> sleep-out mode.
> 
> But that's only if it's a case that you can test with. I won't accept a
> patch that makes sense on the surface if it addresses a corner case
> that nobody ever tested for.
> 
> For what I know, this patch just adds a huge delay to panel boot-up for
> all existing users for no valid reason.
>
> 
> Cheers,
> -Paul

Thank you very much for this feedback. I am more than happy to throw these
sleep patches in the trash and come back later with a proper solution when
I have an actual hardware setup and use case to test on.

John.
