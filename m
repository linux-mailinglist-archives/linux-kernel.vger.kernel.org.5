Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8347F2C99
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjKUMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKUMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E9134
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700568665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUFtFB9/4q4gpI1y/9fsg7wSq63KYPuBeyRHJSkbC1k=;
        b=E0w/rF1gDz6vOUL/j/TaysQoe4DHNY0ikVjB1VHqAtV5lT1pRlAvklpHy6y6ZuTb6GqXU9
        NYdXCjyKNXgGGcNXlzbaxE3WU2PvdkDTn9gmfaVANtz1HvG516n9TLHG0yGv6iBnuJ1p3W
        i1kewNjBWmE/15INjfPpmyb/qz4fZ1g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ZYUQOLQRPrWeMNj6AFyuug-1; Tue, 21 Nov 2023 07:11:04 -0500
X-MC-Unique: ZYUQOLQRPrWeMNj6AFyuug-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cbafdb4b6so17288801cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700568664; x=1701173464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUFtFB9/4q4gpI1y/9fsg7wSq63KYPuBeyRHJSkbC1k=;
        b=UwrFdNw1mWY42ZK91UrhLKLYyJLP1EyJE1NFoDhBIq9b8pA4BSLHd4Cy3TsOOjql4b
         FYRHLFMCqpL5KRl1pBa7fZGFdYK6R1MksZutpx4MUH4JgyZEEGAk8Q/vjo3EMF/i65/c
         0DwLbelagLkn3wXlw3paLokjeycfswf2cuJKeljbzy2XjIDOqZqehhPV8xRy2SJrSv5P
         KfTwwX0HAf6aRNRmDr9nbmqSz0s5wytFUcIhaC7MvFYJyic6h+DoMaTavjNMcv9TTay2
         xqz1UsTRXiHNohxLaOEIIoV/Iw1AlbXv+qzFRLfG8ApZInzAmZcUQUCZuMQrNfJ7RDGZ
         hXFw==
X-Gm-Message-State: AOJu0Yx5I80uyqNtmhtwOMGKZX9b8Dn6CwAOoo+isdboKS3zxlO6N9dT
        NU+zrSPtIoYE+47K6q1+4MbNehpjNGlNJbrYFfQtcl/AB1gUc9Lmj37diYdP+Xpi8CIpk4UF0ZM
        vDrSW2dk/tEQSwLDRWHjhMkvU
X-Received: by 2002:a05:620a:4542:b0:775:8fab:8c6d with SMTP id u2-20020a05620a454200b007758fab8c6dmr12651340qkp.1.1700568664167;
        Tue, 21 Nov 2023 04:11:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaQMamlsB9+OZOddaRinOvjEZo8rBDxBsfZUrGETZnBUh+F/A1r2U50deTAKHYwyYGkW1afw==
X-Received: by 2002:a05:620a:4542:b0:775:8fab:8c6d with SMTP id u2-20020a05620a454200b007758fab8c6dmr12651317qkp.1.1700568663786;
        Tue, 21 Nov 2023 04:11:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id bn44-20020a05620a2aec00b007758b25ac3bsm3570065qkb.82.2023.11.21.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:11:03 -0800 (PST)
Message-ID: <7948d79d8e8052c600a208142755b7a74b4aeee0.camel@redhat.com>
Subject: Re: [PATCH v2] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kunwu Chan <chentao@kylinos.cn>, edumazet@google.com
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Tue, 21 Nov 2023 13:11:00 +0100
In-Reply-To: <20231119143913.654381-1-chentao@kylinos.cn>
References: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
         <20231119143913.654381-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-11-19 at 22:39 +0800, Kunwu Chan wrote:
> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (differen=
t base types)
> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
> net/ipv6/route.c:2332:39:    got restricted __be32
>=20
> Fixes: fa1be7e01ea8 ("ipv6: omit traffic class when calculating flow hash=
")

This does not look like the correct fixes tag, sparse warning is
preexistent. Likely 23aebdacb05dab9efdf22b9e0413491cbd5f128f

Please sent a new revision with the correct tag, thanks

Paolo

