Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21020800C8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379047AbjLANtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379035AbjLANty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:49:54 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C831A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:50:01 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d41657b7a5so6697847b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701438600; x=1702043400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfySJ1dICjdiZC+5VblosUQS3JDiDAAyeia/RplhGk0=;
        b=fQ4cP/8pgshf9N6pPumZ3VGaCCKFDNfUuMDQuEqiluVPvRidw9Hog6riazMQoElkDW
         WuUk5z6wpX71PYf+pQ3JvlKQ8Gi+gCYF62zESpoSACmxw/gXOM6J8jnS/pDN9bi9m/8m
         8eeRtcS7ejjAQ/QZsWFhLx3BYzmnkb8aYz4I5EtNQzCvXK91/xxdm8MFV2qr9FoMgYxj
         inJ+UH/B9elbhfYeczOqcDwoAhougggwo2NT6T8HeVYmi3llI5hVWW00BFfXhbzyGUa6
         uFwYLtaFWeLo1IFAPJZI9hQSsrmKFEFwSXsbJdjm2jwOW4zjWbrQewstBglcNqKn9AF4
         8SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438600; x=1702043400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfySJ1dICjdiZC+5VblosUQS3JDiDAAyeia/RplhGk0=;
        b=OkO+O1H7mcAev+CPOC2fcqy/fepRZ+EmOKlnEsRfMPyXhu/Fd7qiJzwV4G8br54E1H
         WuM6FCIcaAUgzLTmgC0FxdTreR7TEOgKFnyvpTixdnB3vrRzAp3miFg87YPpPetbO+yZ
         Q2Aes6dlS0It2HwdMrCAJ1Um/eALwKZb8XyL71tulBnaHWInYIH+8XIgKKwk4+3NswUg
         OPSiLWq3z9aQLudOsEcjM8RnSqUGbSV21Jpm8/aY0WqIokwsc77uhZQ9MvWbN0Vxxx+B
         kxVUSjuz2Dgga4fkBD9f3RFsfVop8tVO4eXW1PJeeK4iBVKqUaNA86UDxvX1FvkxtGkw
         Dtgw==
X-Gm-Message-State: AOJu0YyTR9Q0pv5/q2cTiUhU5pfXedKzQAYbT6iYHkTjwpNZzOh0bnUJ
        n+rfZgZQu4FuNUp6AzrS8qg/uAE6kLO7865s9zED4FV2CBV6lA==
X-Google-Smtp-Source: AGHT+IHQToXFr5QJi82uP07+DFRxW+gxsKh/J3FFC68XDtOw5J1ywL28KJALLPmXIid0kp29CJzY1ne8nnGCIncF9oo=
X-Received: by 2002:a81:81c1:0:b0:5cd:2f3a:a58c with SMTP id
 r184-20020a8181c1000000b005cd2f3aa58cmr25599280ywf.37.1701438600482; Fri, 01
 Dec 2023 05:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20231115210245.3744589-1-robh@kernel.org> <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
 <CAL_JsqLcqpGa=sc9niVK=-4LtVyr3jtUBcQJ2pNsafc3PQpj_g@mail.gmail.com>
In-Reply-To: <CAL_JsqLcqpGa=sc9niVK=-4LtVyr3jtUBcQJ2pNsafc3PQpj_g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 1 Dec 2023 14:49:49 +0100
Message-ID: <CANiq72=_VtkEYLYZxz9uyAgFuL4-ZemUAmfWYZR3bcWaDSB=TQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 2:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> Can you fix that up while applying? This patch has only been ignored
> for 2 months.
>
> I really only care about getting the includes right so I can apply this[1=
].

Then I would recommend saying that in the patch itself.

If you want to take it in your series to go faster, you can take my:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

If you want me to apply it, that is also fine and I can do so.

Cheers,
Miguel
