Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5178E8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjHaIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbjHaIrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:47:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0837CEA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:47:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40a47e8e38dso199771cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693471653; x=1694076453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik1gJpmACdK/zEYsDZLMBYhWNKKU7+LfXVBjZIp1WHE=;
        b=Vwaq3KoY2hbu2eXGNEYSR/QWN2d9ZOJdrEe3JPif0ZkLN7t+NT0cQyAThAxBylr1X+
         K8xr9AwpnwFe3t+r826UumNfHwmiFHKmKMExeG4pwiaIS68ByiLBid6OdQ9IIDOPyIU1
         UyxrmhDHKOdIvRLEOcre975KO2iog8RCrYz9lSMB+d8j0KYL9IH/aX4gWYNoB1o1jjTG
         KqwUthLHoQVouaDCpq2ASj2jWr/5E9SOH3P4w71aWKoQMHXOwFWdSK+biXAHW6lFDbSF
         GAPVv20/Bdg00KwuccWBMJ1csDi20324w2JoHE0r5n3QXwlc9qxno3RukxQAPjby+eHZ
         0AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471653; x=1694076453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik1gJpmACdK/zEYsDZLMBYhWNKKU7+LfXVBjZIp1WHE=;
        b=IhUZjX7MMl/mBTJzGkiDO197tQEq2dZb4Vh0BlWiIsodBZ5LBdu+pu9JkarZjrltvl
         JyFM3lsL6qJ8Fe3KHJSyCPB6rAphU1lX1ei7x2WhKSsw8eQUx2Pr2qUO7T4JxLTkAmWz
         BDMP0V4WusqWRmk2+spYe9ViZmejoH3WnrfU6Z+tLWkzOw2O3/tQSbo/o5UR6GjGsTm2
         /VRkzlFqSN1TeTAaYS9e0v1Qq0i4FGll3kkdbaraduLCKL7K3HHzVHjmdrMAgDYYDFzo
         8hltgC/Zjz2kli+MmldbErSxNrTIkBPWnW6wpi6oKJb7UxO+dFgm0+c3xXEoYvD0lWw3
         oigA==
X-Gm-Message-State: AOJu0Yy/0I8Q68ARI8vzNFJ048LLHiGbNkGSgTFRelrb5RYW+1b7gb77
        Zb9/duKQFYIQLWJod7h1AsWM6xZ24V2k+M2guOQc5Q==
X-Google-Smtp-Source: AGHT+IGjhbtjPkyPgzUQ4bF4aaMCSzibBATftYGGU7NMw4m85xX9Rl+6D9tDH8+xK+2pmXRvIerhq+IHrN68JY9N+Do=
X-Received: by 2002:a05:622a:1ba7:b0:410:9855:acd with SMTP id
 bp39-20020a05622a1ba700b0041098550acdmr210744qtb.14.1693471652689; Thu, 31
 Aug 2023 01:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <64ed7188a2745_9cf208e1@penguin.notmuch> <20230831081702.101342-1-mkhalfella@purestorage.com>
In-Reply-To: <20230831081702.101342-1-mkhalfella@purestorage.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Aug 2023 10:47:21 +0200
Message-ID: <CANn89iLNACt6vh5OAjDmRxpQ3-DkuUP_Vfh9AZGpGinzwJ-1dw@mail.gmail.com>
Subject: Re: [PATCH v3] skbuff: skb_segment, Call zero copy functions before
 using skbuff frags
To:     Mohamed Khalfella <mkhalfella@purestorage.com>
Cc:     willemdebruijn.kernel@gmail.com, alexanderduyck@fb.com,
        bpf@vger.kernel.org, brouer@redhat.com, davem@davemloft.net,
        dhowells@redhat.com, keescook@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, willemb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:17=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Commit bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions
> once per nskb") added the call to zero copy functions in skb_segment().
> The change introduced a bug in skb_segment() because skb_orphan_frags()
> may possibly change the number of fragments or allocate new fragments
> altogether leaving nrfrags and frag to point to the old values. This can
> cause a panic with stacktrace like the one below.
>
>

> In this case calling skb_orphan_frags() updated nr_frags leaving nrfrags
> local variable in skb_segment() stale. This resulted in the code hitting
> i >=3D nrfrags prematurely and trying to move to next frag_skb using
> list_skb pointer, which was NULL, and caused kernel panic. Move the call
> to zero copy functions before using frags and nr_frags.
>
> Fixes: bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions onc=
e per nskb")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reported-by: Amit Goyal <agoyal@purestorage.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
