Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6DC759CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGSR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSR7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:59:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6B1FC1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:59:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-263315da33cso1318116a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689789542; x=1690394342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi+LNMfR/Tz//DqwsS9WjOFzP/lTw2sLHYGwQYYciDs=;
        b=lBj8+nwCuwo596pTyfKXaKrt8yhokPjU3bVcfwCcKcL3iROHxYhHCsmM/soc06CwW6
         BTq62R05+jBWHP8hDAG1coMUVVIqr2/XqxsLAubJyzhbV4q/OR80cns6jxg/J8XH0ooJ
         bxj4mMWhu7x1oBSTP3WGWRpy6Ay6pMqH4fx53iaxYP8OX5hNooeQMOudWEBSV8qlquCS
         iKK025wFAyieMuyayxhQ2AQISO16rdoeNSqewibItvGKfIYzNzEC3HyHqcAeoI8olFsy
         z3qCsZUbNgIE96F5JaY4mIe2nGMWqWX8+HgP/Yog/1TBhArv34r8hHEqk4BsokUIDlC6
         QV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789542; x=1690394342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wi+LNMfR/Tz//DqwsS9WjOFzP/lTw2sLHYGwQYYciDs=;
        b=Eyj6pX5XLkZ6GsJw9DBxh2oaIzImlUMqdX78aPfVZDT2EQ411v+yAXAVGAReS4MfVY
         9ZAhLYx5mK7gl6qwFzY+7fezFF46plTxyA56sNJqNpQdNE4LjPpwsUJiNgjYK8nFarOP
         hD0ewOSifgUsewRsBsJOpgzDAcGXKOHEjaW+YlR7hap+n3jvdtJ4BuZ+I2+cm4JSdujc
         NnqhtoqzPdSR116wV6FtEZ39cR+jCCBpkHrwefYF/A6OpcLw7krEu1C9Agl8NFkyuXYu
         PXgvN7JKSk7He8Bw6if3Y5CctxZBIZIyyFFcH71YfM73Bt1sEPQQJW5x8NNBI3o24bTB
         8UwA==
X-Gm-Message-State: ABy/qLb7hKuArHOOJgXN0bLwI7B4NPW6yqM6BpimnLSv2HRzDJCn68Nb
        khoL7HokYen2ltFe7ZzRLpMhQGgyHLHQtrrws1U=
X-Google-Smtp-Source: APBJJlGqJI4W82lqYn39sz6kXvq00es8CQ163Oepw2UdWjqWLwEUM7xFGagEC7laHVQIwU79fsL2lAeMrml2BlMljKY=
X-Received: by 2002:a17:90a:46cf:b0:258:9621:913f with SMTP id
 x15-20020a17090a46cf00b002589621913fmr2794428pjg.3.1689789541792; Wed, 19 Jul
 2023 10:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230719164729.19969-1-matuszpd@gmail.com>
In-Reply-To: <20230719164729.19969-1-matuszpd@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jul 2023 14:58:50 -0300
Message-ID: <CAOMZO5DOAWWQoTRXbx5DaCx2Hr79YN4bx1DKBywKQOEp6GLARg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Silence output on stop
To:     Matus Gajdos <matuszpd@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Stephen Warren <swarren@nvidia.com>,
        Mark Brown <broonie@linaro.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:48=E2=80=AFPM Matus Gajdos <matuszpd@gmail.com> w=
rote:
>
> Clear TX registers on stop to prevent the SPDIF interface from sending
> last written word over and over again.
>
> Fixes: a2388a498ad2 ("ASoC: fsl: Add S/PDIF CPU DAI driver")
> Signed-off-by: Matus Gajdos <matuszpd@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
