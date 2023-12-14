Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167A4813126
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjLNNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNNQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:16:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B38810E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:16:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so12540a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702559814; x=1703164614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOwx/mzdDKXszuaQLdYZ1msi9ylZyxJ8mX7DjwOPBEw=;
        b=jeNqshmtzVItlAWzSzV8k3NGNGlSbaJlo0wClasTi5q3siJPbUBufJyjHQ+7JeFSy9
         GcJ7QdYz8voqHQg5JilAaqYRRAPjrp72jeijcdb0VCd6dNfkZjswZXP+QZrq9ohW0Wu4
         oL2hRRRnrX/Hkd4BvxJyvs9pu1MS9T2Q3pgCDMyCksC4saUAka80RB595tjaSHoBzXi3
         2C8Ha3xWvaJ6h3PnWV+NZMbqpBRlr3gd8EalTjTd7Mj5w5vUnVCnGtNHE+DO7JHFTVLc
         LGl1p8fwasGipoTYWuiN7fnz1SJk35CEP74tZOIxfbQ6OF9DwmLaa4b1BF6I+/u+OSWH
         0Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559814; x=1703164614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOwx/mzdDKXszuaQLdYZ1msi9ylZyxJ8mX7DjwOPBEw=;
        b=DfrSFFWnUaHu7m8a48x9XmJ1w/P2yWYU0a7nf1zQBC/nXoQEIz/IzZrPXCLn6Tfa+u
         gKLKa/CmOLgaqZkSAF6NKUlkMv1C81nQaO0OBAYOZXAIerADb77kIPqapnefohhUr8ny
         xDadq2+FrVyCnheMN5gDB+zVtKkALUPwifiF1k1meCkx3WP3afUqfZHLh9A3s1hy/BNC
         vygesZhUbreI4pC2W51bSiIaNtmpvQlYFdI4iNqFOZVZxY4TQUo60JGWLa0swZFbx3AT
         qyuD9ZDc5IK5JIlRq7VyWa5TWd1VZ7wAeFBmmgN4KfdTI1g09Lj5bYrSPaK44DW8K00N
         wb6w==
X-Gm-Message-State: AOJu0YybW1uLdLxk5iGHY9kQJEKQIoYEoT+hpHXIIhMMJhXJ261EWd6P
        0uynLnqhRkI0XDP7nH/LphVSJ+Fdbx+7+/I/WjA79w==
X-Google-Smtp-Source: AGHT+IGPDxq0uza/+XgXG2IMOVmp4USK/BgaYfsY2x/YbZF38+w2YUrljG49XX3YUQ0U6joCplt/Sk0pleh5niEVIrM=
X-Received: by 2002:a50:bacf:0:b0:54d:6a88:507e with SMTP id
 x73-20020a50bacf000000b0054d6a88507emr682903ede.4.1702559813499; Thu, 14 Dec
 2023 05:16:53 -0800 (PST)
MIME-Version: 1.0
References: <63bd69c0-8729-4237-82e6-53af12a60bf9@gmail.com>
In-Reply-To: <63bd69c0-8729-4237-82e6-53af12a60bf9@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 14 Dec 2023 14:16:38 +0100
Message-ID: <CANn89iLcXjzWQSs9VW-=c0d0YL0Ksc4B54cTYZawUUnBkSLRNg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipmr: support IP_PKTINFO on cache report IGMP msg
To:     Leone Fernando <leone4fernando@gmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:28=E2=80=AFPM Leone Fernando <leone4fernando@gmai=
l.com> wrote:
>
> In order to support IP_PKTINFO on those packets, we need to call
> ipv4_pktinfo_prepare.
>
> When sending mrouted/pimd daemons a cache report IGMP msg, it is
> unnecessary to set dst on the newly created skb.
> It used to be necessary on older versions until
> commit d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference") which
> changed the way IP_PKTINFO struct is been retrieved.
>
> Changes from v1:
> 1. Undo changes in ipv4_pktinfo_prepare function. use it directly
>    and copy the control block.
>
> Fixes: d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference")
> Signed-off-by: Leone Fernando <leone4fernando@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
