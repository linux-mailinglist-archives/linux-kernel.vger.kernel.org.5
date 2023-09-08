Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE67985F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbjIHKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjIHKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:37:51 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518731BCD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:37:48 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34e15f33a72so6559815ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694169467; x=1694774267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80krzZRowgddWNJtnNp7zFc+ghk0VyfSZBn4jNSA0+w=;
        b=Nrc81z5IGgQhgkRdMKSfrVBXjqVJKnWfuaicGg6NDFCMtgjyGsK3L2IpPr2HlAQILs
         maG9UKsco7S9qFb/0Pp8YAZPhpK6gBLF+KOWH3/hYnnqAcUuFRz0Nuk+nB+ltKyoPxvk
         ca7kXMc6gIgg0rBTvBEk4dTsg2nh7qU4m5gfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694169467; x=1694774267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80krzZRowgddWNJtnNp7zFc+ghk0VyfSZBn4jNSA0+w=;
        b=owvhbbI8lTozfUUF6vLkIzaKYBWDeorcQyX8iH9Qgj6MAhIfuThFekIEj5g/ahCxKY
         c/kZFQRG9UaRZi9KHDhntwsG/xEe6X6/CRAKmUrl5437mmDDCgEvTgBhWpsfeN+ADHAC
         Xut0D7fphhA1+HM+iHkSbhtkr1FU/Lo8/pVo6/uEgx6haXytg+rz2qGA1t6qm6Tgcign
         Gb3+bOroEYNodpBFcRxAz9G6AvN31BULMzHTFIyDie6Od32KTesUhouXx6vR9lVGvzlz
         MbazZ76hs7EQgHjiD8991q1XMVbal7tMu6qPjlwBOUKhGHXjXOmklbnYHC+Ojhs6Mxaz
         DM0Q==
X-Gm-Message-State: AOJu0YwLXphrKRj9b6X2M3SK7KGks4dzGdayBoFTCc6QrhlCVs3Qecbk
        Z1NZX5hNlv+d47WeTM0+j4PjfMIundBRGb24u5WGfIUleLzNrPPX
X-Google-Smtp-Source: AGHT+IFdRKFwiGzVlzSdlYLWipQaRrS6Epqikt0gjNp2AgniwAJNtdyojzLjTBMnvYyhFtmU4skh7IC4Y0aDgdaOxfk=
X-Received: by 2002:a05:6e02:1a42:b0:345:a201:82b7 with SMTP id
 u2-20020a056e021a4200b00345a20182b7mr2940148ilv.26.1694169467753; Fri, 08 Sep
 2023 03:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230907093927.400634-1-treapking@chromium.org> <CABRiz0q9TjryfNs8m6czuExWRCpXiVYw0K7kW62r+jstBAm2Lw@mail.gmail.com>
In-Reply-To: <CABRiz0q9TjryfNs8m6czuExWRCpXiVYw0K7kW62r+jstBAm2Lw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 8 Sep 2023 18:37:36 +0800
Message-ID: <CAEXTbpeiHjPqjkQaRbMcGeL-zPNM4+zo6Qwi1rDcEvmSKYGPkw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Matthew Wang <matthewmwang@chromium.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 6:23=E2=80=AFPM Matthew Wang <matthewmwang@chromium.=
org> wrote:
>
> > +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <=3D skb->len &&
>
> Not fixed. Did you accidentally resend the same patch?

... yes I think I messed up again. I'll send out a v3 for this.
