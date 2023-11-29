Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE137FDF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjK2SKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2SKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:10:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00EB9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:10:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so748a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701281457; x=1701886257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnncOB2h9jk2qjqG+JIa0//zO7OvYoVVbykcUe7Jp/c=;
        b=bGYotj5rsTyGBNiNZ1wGEy8Ux4gKjH0aU0z6sHYy9wHZPJW7c0sIvJCW1orhTEefEP
         bJEdO4EAkiQzI+dyJcmGBQ1X799cyOYm0/Qk8H9jpA/TZiipH9BAgV0hIHHamuaEbEqm
         /mduHdNv8iq7ECdB1egzeGux3mugY2h/AXdBB7HwsdREAE23u74lSlsH3+8cLQf9VpZM
         hi2xMyFSsf3y3NYwU+0qe+UI1xGdS6t+VaZStIGKQwksVdZvjzAm2VEUtNFQSQKPGbe+
         mJM1EkYqV5buzAKNJ1QQkatvn00pTwEwV3Bpc8sUH7wNkGnmsTFcwM+SWVhUCuzPO0A2
         Q30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281457; x=1701886257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnncOB2h9jk2qjqG+JIa0//zO7OvYoVVbykcUe7Jp/c=;
        b=CJSusb8alOLCrY4s9hKC7Xh+7qZ2auMDYO2qHzepsW0sTO8b5L3/XmOU75onWjpwpp
         04o3BtJEFst4U+3wNScEplbJ3n3jauF+CvgR7s6HNL1c7kfK8FW71ZKX91+anPueaQoF
         r1A6cD6OTQQu7UGisqiKNNN3+Ll9WAAuGmnCrIk6OL1nthlo9c4p6bquqfgcL1xno1Zg
         jjEhbrA6vlZOrg4NEE6p/DTu3tUln+Fq29O3Fx3XFzNYQj1lnGV84rWkiJDcjZLPoQxU
         SmO+m7EWYQpiohcmFemdvlPqzyPMG/ar/JJKO0O4s+Fa4EbWrlLe9FxM3F7S+qhdrXFE
         A9RQ==
X-Gm-Message-State: AOJu0YxL3oPuAyucDSWl4HzSAGpAJxukiZX7AWDY6P3tJQHepQMJzPQL
        cqfCA93MG3tobjetjpzLlLRc3dPoXrC4YXo51yBN/A==
X-Google-Smtp-Source: AGHT+IHLXlzTI+N/IYiqmHn8zamPjw1heaZyyJEhUCCIo5P8wqmxHtc3KxwNqm6ZvQxeKqJ3Qxrr5q0UW3DEEznGUyU=
X-Received: by 2002:a05:6402:11c6:b0:54a:ee8b:7a99 with SMTP id
 j6-20020a05640211c600b0054aee8b7a99mr853479edw.0.1701281456539; Wed, 29 Nov
 2023 10:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-8-dima@arista.com>
In-Reply-To: <20231129165721.337302-8-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 19:10:45 +0100
Message-ID: <CANn89iKHXv_eNgc0525r=RAREqNXenf+StMHzK2=K_uKj-N4rQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> This extra check doesn't work for a handshake when SYN segment has
> (current_key.maclen !=3D rnext_key.maclen). It could be amended to
> preserve rnext_key.maclen instead of current_key.maclen, but that
> requires a lookup on listen socket.
>
> Originally, this extra maclen check was introduced just because it was
> cheap. Drop it and convert tcp_request_sock::maclen into boolean
> tcp_request_sock::used_tcp_ao.
>
> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
