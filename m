Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77FC7572E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGREix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGREiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:38:50 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C4E52;
        Mon, 17 Jul 2023 21:38:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579efc32377so48101507b3.1;
        Mon, 17 Jul 2023 21:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689655128; x=1692247128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWTPh21wQ0o2nnFjvu96hvu6BzutgKcmu1Ba9eo4YQk=;
        b=LXn0OrrCc8nSXZdXi43REx4QkR6y4xsPZFtSDG7gHOy94spKlPCdQwoGAcZ4RCR1Mf
         qfWOREEYgEZca/DN3y7fHxeehmfwjrq4cv9yzA1ReNRhqtXmD/3qLV/qW/qOVAZWjd4z
         TsEaVX5pP9DTshtD388ghYE2qFE1x9jNdMzhCTepFqATxb5vCu511APXOXckjSYDmLC+
         OuCLpXbE7ZkuvRxXhIYI2oNxouU57iNEBFIjiA4SVBjom5eBsiAgsc16bXmB/6s0f8sj
         WInpSy37EDWSw1QnKRSK3a+zU78dj6AMybRng8MAJiImSJm4hGdDLmtF/rpLp8fd0MXc
         wl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689655128; x=1692247128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWTPh21wQ0o2nnFjvu96hvu6BzutgKcmu1Ba9eo4YQk=;
        b=ggmvllTzn1ibSQSTTS6JY+W6tTOLZ+RizoTNcRrk0mvUlaIsIRDGYiAFab/JkXjkTA
         vOcvhBPX0LMIeIRXwtn0CHA4rrlgvqXKl838uya5DSofGh492dOMhF87W6Nl0s42iwO6
         Wr5aLeu6z6k9qJfevv2nrEgEDQKRfXUgGypZOXg2o7HmQnInOVpTx3i9dev3LPS6j6Gf
         Kg1X/xNol1XTC594HPwVtnWUT+JFRzQ+4M6z6kmyyYdh2oIKQmso+EsqxJq/nil7atHL
         b05/np4wAzU/t/Q5/vv6neJR6ToE+Ft+VdrVXbLoq7E0k9krCeH6StRVsz7882ShKfN6
         UWHw==
X-Gm-Message-State: ABy/qLabrT/100zeqLXGIHEjIZ1mBTyaKgBfDDOrP4R2Gr33nZyEIEoo
        i6C3GXVAcegI6lfIBjuHFq1sSHD/a+mWY4t4MeQ=
X-Google-Smtp-Source: APBJJlHODCyMhaRZAuj+B70ISRhuEA2eb/B1FFauIWR4wnse95GNXOFli7atYze+0le6B+cGF+V8c+5eR7wh14v97yM=
X-Received: by 2002:a0d:c0c7:0:b0:561:a123:1041 with SMTP id
 b190-20020a0dc0c7000000b00561a1231041mr12706032ywd.29.1689655128450; Mon, 17
 Jul 2023 21:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com> <202307121653.4A9C69C655@keescook>
In-Reply-To: <202307121653.4A9C69C655@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 18 Jul 2023 00:38:37 -0400
Message-ID: <CADmuW3UY=w0p-h1h4qOord7z1nFnvpyCOU3fcCaATm_PvFFUeA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 7:54=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Jul 03, 2023 at 06:12:56PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since DEV_ASSIGN is only used by
> > TRACE macros and the return values are ignored.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> Looks good -- thing is using return values from the macros.

Just to confirm, you mean *not* using return values from the macros?
