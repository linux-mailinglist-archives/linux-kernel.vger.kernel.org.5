Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5B777347
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjHJIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjHJIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:48:45 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DA2103
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:48:44 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso398766276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691657324; x=1692262124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhpLNjH0lO1Z4ilAFY/W8HloMMbCrLVPpqNexkGoMdM=;
        b=Jdqn9ny5hlupVLouDFIZ/Ao3eAQrdeRqscUglBvu/jbpfds4k4mDWuFMVIIE5X7D+T
         gdqjHY4gQMylyjVSgUrwSIM0P2OEO6ANB7rVOA2NdzV4ovc6i4fdEgH1aQNdiVF31sRt
         kZXTz6Nrw7/YMil/OZDQuB7ptCgc+TTjXMKaJG/Jb9AB8Otsku+x3nt3t2AvS1oDXLkr
         nKuZV79qMtZT8XGkRElHmqCkPebACIXkq7wrDHAUA7MqwP+EWwiDAfqkIAtFzMAYIv7K
         moAGU8eFxLLGDo4JyVMsYqTG30ykUY0biDdPGflda6PYsYNTW4nDc1LBcZMlmNm65xfp
         QBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657324; x=1692262124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhpLNjH0lO1Z4ilAFY/W8HloMMbCrLVPpqNexkGoMdM=;
        b=SW95Su3FuMoK1SaqUeKtGGE2nAw++csnuLF3H1DACBNA8oUa85mHOevKwbTw2cVQV4
         0Dr+z+rzhbuanccP1M9bWC2S1gWQ7px+SmaIa85b/34Zj0YHcbdcm+KoOWlSHSsJz2bi
         YZE3mQYd1Rrvbk8fh6ptE82qyb9uf2DG6y82RHCMBaZJv3rlILqBRTPJABH7aGj17l/n
         lyDuqqR2GroDU60yP7FUAL2dBAx+EeRA1ukTHd3OJHkRmFy5tBT/awzLJ5zm2qxDTlx4
         QusN4baP/gccql/89gkSOSaxqqRB6F+VQIq3b3H3OjKwPGZIToE1FZm74nPlvLbV+FRr
         /OKA==
X-Gm-Message-State: AOJu0YypUS6gZ726ZybyOisUbobnJ3kMh3bWZHP0cXOpjKoibyFJy09s
        YD/ZSUDy7TpW1aVnSai2Tr++rdUcaUKHpwO2+eHTfQ==
X-Google-Smtp-Source: AGHT+IF5jTAlHy9XMTToR4rkfJL8m3id0I+b2gh9bgu6SaKo6jhvbpYvsETrV++aunR2fBlif0PbdnUnzCQ3RzJp5og=
X-Received: by 2002:a25:4c02:0:b0:d4e:3ffe:79d4 with SMTP id
 z2-20020a254c02000000b00d4e3ffe79d4mr1876314yba.61.1691657324149; Thu, 10 Aug
 2023 01:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230809100634.3961-1-quic_ninanaik@quicinc.com>
In-Reply-To: <20230809100634.3961-1-quic_ninanaik@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:48:33 +0200
Message-ID: <CACRpkdYwn515kDvO_gDtp4XV=DWjpf_pO-VOQp2KWX_J=ceUMw@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: qcom: Add intr_target_width field to support
 increased number of interrupt targets
To:     Ninad Naik <quic_ninanaik@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ymg@quicinc.com,
        bartosz.golaszewski@linaro.org, quic_psodagud@quicinc.com,
        quic_ppareek@quicinc.com, quic_kprasan@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 12:09=E2=80=AFPM Ninad Naik <quic_ninanaik@quicinc.c=
om> wrote:

> SA8775 and newer target have added support for an increased number of
> interrupt targets. To implement this change, the intr_target field, which
> is used to configure the interrupt target in the interrupt configuration
> register is increased from 3 bits to 4 bits.
>
> In accordance to these updates, a new intr_target_width member is
> introduced in msm_pingroup structure. This member stores the value of
> width of intr_target field in the interrupt configuration register. This
> value is used to dynamically calculate and generate mask for setting the
> intr_target field. By default, this mask is set to 3 bit wide, to ensure
> backward compatibility with the older targets.
>
> Fixes: 4b6b18559927 ("pinctrl: qcom: add the tlmm driver sa8775p platform=
s")
>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Patch applied for fixes!

Yours,
Linus Walleij
