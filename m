Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0A7CE12A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjJRP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjJRP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6224C116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697642855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LO3U/3O7orcDX1UKblPetHP+0g37M+8wNFC9UUNpGbg=;
        b=GhGhvTDa6Qk9bqLYG2EUWr1HAXBq4VmXcQJS9J/zdI1IUzkBLhW8PgcO64c/JdQ7cnIUYa
        5JZhBSNdEELEFsxkawIXVtuCa/VNUhOFpYxkthyEuhg2FH087SlycYCDmAhF5GLFQrJ0tw
        rKEbVpxzKCgbCQNVrLHNLu9LK7xg+kA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-WsQtEvmRPiWajntt-xIjVQ-1; Wed, 18 Oct 2023 11:27:23 -0400
X-MC-Unique: WsQtEvmRPiWajntt-xIjVQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d35dda745so46251036d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642843; x=1698247643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO3U/3O7orcDX1UKblPetHP+0g37M+8wNFC9UUNpGbg=;
        b=dvWyxXGNd3ftK/QjRhF7+HyqEhz+YM/sNnPPVHZh2H767KunajKMF1Jyid2qt7+s1l
         PSD2HRftS1tvgAM30hAZBUY76eRR3ql8QqSG8vSbWi9ojihW9GpXqQzLABO1I2GUXNzg
         EXQPNYCCm/0igYgMAlgLkaM6cCCXdfrUT1tsAXMiTFjaqpSfU4hJ+9GeM4S+8QC/LXzZ
         m/sHtmmCjix9B+wbsTdkww0no9tgIgCJSHNvr5GaMV8MG9+dveQEDgimvgzi4uppUSDO
         SU4XtsV7uwCpNF4c8IHegON/bGKJBpo8FicDg8tqiHmvjVe8oOqiDHi/aL3NUHu5mF6s
         vUjg==
X-Gm-Message-State: AOJu0YyeITzV/Dw3sOal0kGn3Jy7mPIu9fl3Ii6WG2CMU80QXT6RdOwe
        YZcjMAz5CBhB5uvx+p4zOhCr1DdHfYuGp+UBFKIvnmj/Icpco99o6cZoQHwOI1lzDG6/Jp5/URu
        SKnZPEfDmmDiSlurxnpwMATrjHfeUS81s
X-Received: by 2002:a05:6214:2602:b0:66c:ffe1:e244 with SMTP id gu2-20020a056214260200b0066cffe1e244mr7592497qvb.62.1697642842839;
        Wed, 18 Oct 2023 08:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6fCGqNMshOHcVQgHFixpMRES/AbjqtXvQxpoRaWfInZXTWRZ0YrGHrSAVlJmDRabVuafBLg==
X-Received: by 2002:a05:6214:2602:b0:66c:ffe1:e244 with SMTP id gu2-20020a056214260200b0066cffe1e244mr7592455qvb.62.1697642842210;
        Wed, 18 Oct 2023 08:27:22 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id dy20-20020ad44e94000000b006588bd29c7esm35137qvb.28.2023.10.18.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:27:21 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <CANn89iJUicsEdbp7qrsaSUg8jQ=dBUr0nK296LxXp5rnPrw8cA@mail.gmail.com>
References: <20231016125934.1970789-1-vschneid@redhat.com>
 <CANn89i+pQ3j+rb2SjFWjCU7BEges3TADDes5+csEr1JJamtzPQ@mail.gmail.com>
 <xhsmhil74m10c.mognet@vschneid.remote.csb>
 <CANn89iJUicsEdbp7qrsaSUg8jQ=dBUr0nK296LxXp5rnPrw8cA@mail.gmail.com>
Date:   Wed, 18 Oct 2023 17:27:18 +0200
Message-ID: <xhsmhfs28lzmx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/23 17:00, Eric Dumazet wrote:
> On Wed, Oct 18, 2023 at 4:57=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>
>>
>> Looks reasonable to me, I'll go write v2.
>>
>> Thanks for the help!
>
> Sure thing !
>
> BTW, we also use TIMER_PINNED for req->rsk_timer, are you working on it t=
oo ?

Ah, no, that wasn't on my radar. This hasn't shown up on our systems
yet. From a cursory look it does look like it could lead to similar issues,
I'll add that to my todolist. Thanks!

