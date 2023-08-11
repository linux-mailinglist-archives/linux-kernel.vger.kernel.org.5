Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB8778851
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjHKHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjHKHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:37:51 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9260412B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:37:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-407db3e9669so131461cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739469; x=1692344269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpdbPkPSTDtpRUF5KB9ed/xKbYs10zrfWTQAWipjf7Q=;
        b=HfLbTV191BwrwGZH0l9N3aRjOqUmEPk50LIAWPnlYvy+Yu3yMWspzwWCqBxQfXIm2g
         45eCYtF7useuUGRRQ/C+n1S6W5gbPxAtLr6tyW+JEaIcZuznLXV9yx11KUCMOfWrSGom
         ksnWoNRdaz/NpLE/D/7MKpYEM/AOx0esaH1en7tDyPYRajYrZVrgO9v9VrZgLpYlNPHX
         50WThlmlqeRKRp6oc2SZdeUfnFMMDoPpgqA4P6kuEgejPMkr/I4pN++3Y813D7ExsRAz
         j/sn5/4WBV3Vci1UEyrP6O4eVjIHY5vD2RfY1rAqdRhAUjSmzlA81Qm0p4J7qAB2yGic
         JAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739469; x=1692344269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpdbPkPSTDtpRUF5KB9ed/xKbYs10zrfWTQAWipjf7Q=;
        b=Qih3F/ghkDqZvLIPSXChY19mcoTwo03qdQuRoph4Iv6RQDie4L/y49+hdfPho7aM/K
         odhavlFHzs6w7Pb+YKmpPdEkemzi/X5pXXuiy0BSRZ7ts3AiIkJnYHMuWaO/RXXfF9am
         2+6M0PzHPmWlWd661I+4cvi5YWCO9I2CVBxVLPYohfm/S67MeGhkiWpmt2t04BmAm7Hq
         6JKEHxhKBG2oaYwH4Ux4P4x+Tk/b5AY2rUkXYy2x1NSILnf1sZuRtZqgmH8t0IWNXm5f
         sX1dy9bFYrU06Wo0kD9iWzgLDQaofkBKQyXzeSsGFxTVI2VHoxngb+nTTOjzLDCa2QiH
         uXgg==
X-Gm-Message-State: AOJu0YzUfedptaw74pzCzmz97YuHIArXpoO1v9seMXEAceWXDnN99Won
        5CguRtUOKbLDtDVn1bRIl1RRNq0wRNd9ox8fRWP07w==
X-Google-Smtp-Source: AGHT+IHokTJXsTmIZ6lawwV3YIQ4KB/b5AAm++XyHzNyltjHBpPBiT+Ex6hVbdTqBacgWRKasMN3WCy8jlZbVcrmfPs=
X-Received: by 2002:a05:622a:190b:b0:403:eeb9:a76 with SMTP id
 w11-20020a05622a190b00b00403eeb90a76mr119206qtc.17.1691739469579; Fri, 11 Aug
 2023 00:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com> <20230811025530.3510703-2-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-2-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Aug 2023 09:37:38 +0200
Message-ID: <CANn89i+7YeP+N-4bWgU=dMBEhRZBjaY4njv+WhbvbVde_7DoOg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] net: tcp: send zero-window ACK when no memory
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, skb will be dropped when no memory, which makes client keep
> retrans util timeout and it's not friendly to the users.
>
> In this patch, we reply an ACK with zero-window in this case to update
> the snd_wnd of the sender to 0. Therefore, the sender won't timeout the
> connection and will probe the zero-window with the retransmits.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
