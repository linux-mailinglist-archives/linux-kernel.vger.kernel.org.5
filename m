Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022097620C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjGYR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjGYR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:58:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58F62685
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so5274442a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690307915; x=1690912715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMKz+TTfcKiqAZL/r0ZMj0g0KndoteFH21pGmnEW37o=;
        b=Fx/HAWViQYXbLSWPN4TDWSm+xGmkKajrRZBKgKzNAQjTjA4BLlOBUSFvzQHA+Dux9o
         7BLa5Lxm7a8nfFLM0/Dd3yRACTU1Kc7XCvlyX1XnSc2AgF0WU6v8qXULtFGN3S1KM894
         QxxcY3JZeihzx6NZiXJuGibHGvK4kA073L/xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307915; x=1690912715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMKz+TTfcKiqAZL/r0ZMj0g0KndoteFH21pGmnEW37o=;
        b=HfVflCABBhvlVLwjAaDpNQ0BIUhw6NfT+bpavrwZEXYlEsyqS6EMW4HMY0y430Yuwm
         TAS3xRNsTm4jmybs5HgxH8S5uLySBKte6ad4HqCutWUm8e+pW0fouyKDQDVf3O20yFVH
         pjQkaeSiEZzeDmYixtZ+7rjwnMi7hiuPJWIVkW15j75GB2T2y9gCxrUtmC/QJplpTD0E
         flpSAkGuWN0DG4cqNH0Vjx/AOPRzNZ3sI02/iO/dhP0J7TH7kGdUwOBwOI/VZiX24X0S
         FKhib7QPl4h77Ky4+BzB8S/clMkIYpHmVNx5FavKpNjh5wTUziLuQtWQpB+YECafovX1
         nAyg==
X-Gm-Message-State: ABy/qLZh+oZX0za/bBQrr7MaN/zSE5neLR70zteBm5uKPoUWvUqa7SFQ
        oLA6S7Jb/sBZVk9E2Kf99/udfewGWJE0ZDmsv+lzZMiO
X-Google-Smtp-Source: APBJJlGxntsBQkRQOQpzqKoF88BaILZVf/1wPyCchLZHY/ClHxKa1TdOrsx/R4wkiZuVAN9ViHaK8w==
X-Received: by 2002:a05:6402:70c:b0:522:2f8c:8953 with SMTP id w12-20020a056402070c00b005222f8c8953mr4515600edx.39.1690307914892;
        Tue, 25 Jul 2023 10:58:34 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id dy16-20020a05640231f000b005224f840130sm948419edb.60.2023.07.25.10.58.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:58:34 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1500a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:33 -0700 (PDT)
X-Received: by 2002:a50:d6de:0:b0:51e:5773:891d with SMTP id
 l30-20020a50d6de000000b0051e5773891dmr136155edj.4.1690307913684; Tue, 25 Jul
 2023 10:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com> <1690285689-30233-5-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1690285689-30233-5-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 10:58:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+LULPZW7fccz2aMqfrR=fuOvBAb7LN-mGYeppuxAQZw@mail.gmail.com>
Message-ID: <CAD=FV=X+LULPZW7fccz2aMqfrR=fuOvBAb7LN-mGYeppuxAQZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 4:48=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Add latest added DMA_CHAIN_DONE irq to QSPI_ALL_IRQS that encompasses all
> of the qspi IRQs.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't think this really does anything since the interrupts shouldn't
really be "hanging around" when a PIO transfer starts and that's the
only place it's used. I suspect we could actually fully remove that
bit of "Ack any previous interrupts that might be hanging around" code
and everything would be fine.

In any case, I don't have any huge objections, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
