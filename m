Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC5807506
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379311AbjLFQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378338AbjLFQcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:32:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1EED5A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:32:10 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-286c01bff06so421a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701880330; x=1702485130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpWHSnwqX6HGw3nev19mj+TqZHsprVdc8TbYWfoKuUE=;
        b=hczI5FflWAyfvrcSjcRo8KE49yShQdAWyJc7PDYOufzjiksL0s4wFG34Jc8x7jg4jY
         3IgvxZne3HgQHxHAIkt+lISSp3v1hw3uTky6+U+60Q2zR/rIRTJ7ueTcKSwjq0Bp1JC9
         Ania92CEkCoL/daTmkCyiKVNJR0MqUWLCsFCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880330; x=1702485130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpWHSnwqX6HGw3nev19mj+TqZHsprVdc8TbYWfoKuUE=;
        b=k62NLK/N1BncL4XlG8h1wOJHfrPnug2Rkx5KbxB+9mo/Wlm9pzvJJwuNlyPcBHTXFb
         0pH7h+BQvFL9Yid98qkxGsJd/wpec3DMuDs/hb674Scis4MnGvQUyn1pEDimQxTHqq+A
         NdSbcGrMvLQwfRN0VL3cFR0i+KRdIKZkPV23N76Oq/robYM5eAc03nJJn5/MUuxunN7X
         ZLT9KAV9jankYxwxT+qbdFpbo7Huqs9ut7dg2Xe+CViy2GSLSKmmYimUuKpWiNd9rKPq
         QSYjuOcVeW1H+UjBdnYUNRi0DiRt8iMnA6XUDtedWsS2aHiGwChOgORwcyf+JSsRBX4L
         yQDQ==
X-Gm-Message-State: AOJu0YzRDsYvsZVgpqBL7ROGB3nJpUzDA+mDA3b85+qbGuunZ5W/VggK
        GDIL+QPISbqR5Tyxp5XWcGrRXRURaBaGT6cM2xtEu2F1CTbzithz8R0=
X-Google-Smtp-Source: AGHT+IHMeqL8lOmKvUkMF2gAiKe1sHWTw8ksly3QdH0Alfj1FCDrqNZxJ3UJiuivodxNNhhTwt3fLmoYyoFbwHRY8Q8=
X-Received: by 2002:a17:90b:4f49:b0:286:b8a1:f1a2 with SMTP id
 pj9-20020a17090b4f4900b00286b8a1f1a2mr825338pjb.44.1701880330074; Wed, 06 Dec
 2023 08:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20231206123719.1963153-1-revest@chromium.org> <ZXCNouKlBlAKgll9@Laptop-X1>
In-Reply-To: <ZXCNouKlBlAKgll9@Laptop-X1>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 6 Dec 2023 17:31:58 +0100
Message-ID: <CABRcYmKK0F1F5SzXoUpG4etDz2eGhJoSZo56PHq7M+MNjcjTKA@mail.gmail.com>
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:05=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> w=
rote:
>
> On Wed, Dec 06, 2023 at 01:37:18PM +0100, Florent Revest wrote:
> > In __team_options_register, team_options are allocated and appended to
> > the team's option_list.
> > If one option instance allocation fails, the "inst_rollback" cleanup
> > path frees the previously allocated options but doesn't remove them fro=
m
> > the team's option_list.
> > This leaves dangling pointers that can be dereferenced later by other
> > parts of the team driver that iterate over options.
> >
> > This patch fixes the cleanup path to remove the dangling pointers from
> > the list.
> >
> > As far as I can tell, this uaf doesn't have much security implications
> > since it would be fairly hard to exploit (an attacker would need to mak=
e
> > the allocation of that specific small object fail) but it's still nice
> > to fix.
> >
> > Fixes: 80f7c6683fe0 ("team: add support for per-port options")
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Thank you for the quick reviews Hangbin & Jiri, I appreciate! :)

I just realized I forgot to CC stable (like I always do... :) maybe I
should tattoo it on my arm) Let me know if you'd like a v2 adding:

Cc: stable@vger.kernel.org
