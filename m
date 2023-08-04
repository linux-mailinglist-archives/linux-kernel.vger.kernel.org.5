Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB476FFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjHDMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:02:11 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9B9127
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:02:06 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-407db3e9669so224591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691150525; x=1691755325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZhCQtFnDyxPkfOkKO4E3UsLO0Txsl66rqqt9O7ZV8I=;
        b=qDS6ttGqU/zs67dKw+hoc0dPw6r3cxK7b9CH1rjcEapNHeyqqg++sQ3VpWqySZgm/F
         YfiiID3jwnWZDRF1inE1LPFKKt5pDWbuuo7Vl/vlODaUC74dirQX85wsrda1iQftxWEV
         s6mrdrT5WP0cLLaqc+FgoCEEDSPxdoJCwnaUOaB78RnI82r+ezKvjuA8TQXkgnO6KYp1
         1wJX6yxbY8rAs2uWJ52Kyx+VnAULfH0UGH+leY4c79UuY0/KTP9mxR0YRzJsIL5+AHW0
         7CqXB6QfD3P6zESSBmmWq2L5Wqn7/Ey4djZwLiMqrHTzW0uFdv4oD5Z2upUSHfVloSA2
         6Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691150525; x=1691755325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZhCQtFnDyxPkfOkKO4E3UsLO0Txsl66rqqt9O7ZV8I=;
        b=h4FwzK+npWIwpSGOeafmd4pO+G5JE5rePCutGGs+guLL+h9/pXMD3okNBsvwWnO7Bf
         NhaOU8FMlwYDd3ge9/1AmJKAqUya54FaxjlIurvykXx5E2CKpcx7q/yzzPOWOxUPulYB
         oDHwdRgbBtodCP+yDaeH5J/qUpWsdXwHxdJx4E50YUFjvof+GTd1u6yT5E0SGDiUj8FX
         VE+1pTKKl0HqaoTocOxRViyay+jZBNXu6mKluFf4K1ghoxE25h659AJ5SAIk6Tz+qsQP
         rYsL7+mT8qa2v42v0p+IHjB/NIn5XQhKFgVdd+BXn2oUeQDOakBteUbvHCDawewj2nc1
         IFHg==
X-Gm-Message-State: AOJu0Yw7WpzDjuPrZ15G50laln1RE1SeRwHBrSjcQwjCsZxo0F4IJI0w
        acqTYLbCZ0sjK5gKV9paKvoPzz9qhh4purSHZUoCZg==
X-Google-Smtp-Source: AGHT+IG+Q7mWxOPe1xSEaUBsoN4Hq+g/YNV4MXVXrtWRnX4iAtgSgH+Frd81r1ps76nF2rY3EpEErrFemFfXwRw5aCQ=
X-Received: by 2002:a05:622a:55:b0:3f2:1441:3c11 with SMTP id
 y21-20020a05622a005500b003f214413c11mr245276qtw.2.1691150525424; Fri, 04 Aug
 2023 05:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <202308041657467504029@zte.com.cn>
In-Reply-To: <202308041657467504029@zte.com.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 4 Aug 2023 14:01:52 +0200
Message-ID: <CANn89iK61nt5o7KBZyjqVP6Q1EREvzg-x_bos8hSGSmwfwZRBw@mail.gmail.com>
Subject: Re: [PATCH] net: add net device refcount tracker to pneigh_queue
To:     yang.yang29@zte.com.cn
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 10:58=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> Add a static net device refcount tracker to neighbour.c to track
> dev's refcnt when pneigh enqueuing and dequeuing.
>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
> Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
> ---


Can you explain how this patch was tested ?

Thanks.
