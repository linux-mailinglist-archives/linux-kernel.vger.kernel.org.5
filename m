Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71E1808D50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjLGQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjLGQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931D7AC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701965750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMjoqh1pXhrqyjtnMgRySm23T44zv9xVYFWsYjgspZw=;
        b=gMIM1igHT9iNZcoKrCHi3okjPe5dzubhDeTYKdQPwpGw1ozzt0/9bBb79Z6PlxMPoeREbd
        sktVcDeCN0Qstf2UkpsSy4d5JXUeKKkx6hX2xPgYfbQj1bf2maGBjJJKaoWTBwoZCOi5ie
        Dqtpq5i9pcT6HRjrtvtceIUxpzorgGI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-PWnkZh2xNsCfpQLFux4wYg-1; Thu, 07 Dec 2023 11:15:49 -0500
X-MC-Unique: PWnkZh2xNsCfpQLFux4wYg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-286d9064bf8so841189a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701965748; x=1702570548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMjoqh1pXhrqyjtnMgRySm23T44zv9xVYFWsYjgspZw=;
        b=TNp10xOil0AysdUKcokXDhBo7VnCr1rut+wETRlACMg3UVQCvc5pgkDpoet2F2OgtC
         WZTJNjM+FTsQ5n3YdYoMUGLFXl2ncijJNSIzm2RBQlE0DAyV7htBh2paHnGMIr6UoPDM
         vIpNL+tORubkLKXa7bdNnZBHz/rLyM1o8nihCCoyHv+lcnr5CNplQlsNVQaKsYgvBorp
         6wGheRmvREg+ANRf+lDUSILXkcH6hWA3joW2UkqsURzrZ4xWQctNNDYSnp6QjzeyRs19
         jZSiO2uRvtAcd5bG/9jhGE/5GUWxoaH5SG4K9MpKWZexWhLMUyRUx4EOx5B/HFxxIOMc
         2H5w==
X-Gm-Message-State: AOJu0YzLipzSAfdp0MMhJmmifnp758J0AXFnB4AM3oNRkXX5B+KyK86M
        7qZ92tnhbHIQvAP8u/uXU5QUA4dzmZePRy60nUBxZ2dv1AAeJQZ8B0IQJtgaWZdHZ7PhT19zI3d
        JXaRabqOJyrOBUddD98wOdbDiR4qKKqU+NYSoEGv5
X-Received: by 2002:a17:90a:6408:b0:286:5127:d9ba with SMTP id g8-20020a17090a640800b002865127d9bamr6301812pjj.8.1701965748102;
        Thu, 07 Dec 2023 08:15:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDeWROLk2K0c9rgPY/R8uuckZIYCTZHL2VBP97UMXh33XnVapX3S2LNC/E4/LGDDmgmTsUek1InciGIGC3BH8=
X-Received: by 2002:a17:90a:6408:b0:286:5127:d9ba with SMTP id
 g8-20020a17090a640800b002865127d9bamr6301794pjj.8.1701965747782; Thu, 07 Dec
 2023 08:15:47 -0800 (PST)
MIME-Version: 1.0
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
In-Reply-To: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Fri, 8 Dec 2023 00:15:38 +0800
Message-ID: <CALTww28Fz5Y11q1UE8r6qRrwOHgKOWw=iX3AisoSFGh_VhAbJA@mail.gmail.com>
Subject: Re: md raid6 oops in 6.6.4 stable
To:     Genes Lists <lists@sapience.com>
Cc:     snitzer@kernel.org, song@kernel.org, yukuai3@huawei.com,
        axboe@kernel.dk, mpatocka@redhat.com, heinzm@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 9:12=E2=80=AFPM Genes Lists <lists@sapience.com> wro=
te:
>
> I have not had chance to git bisect this but since it happened in stable
> I thought it was important to share sooner than later.
>
> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
>
>    commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
>    Author: Song Liu <song@kernel.org>
>    Date:   Fri Nov 17 15:56:30 2023 -0800
>
>      md: fix bi_status reporting in md_end_clone_io
>
> log attached shows page_fault_oops.
> Machine was up for 3 days before crash happened.
>
> gene

Hi all

I'm following the crash reference rule to try to find some hints. The
RDI is ffff8881019312c0 which should be the address of struct
block_device *part. And the CR2 is ffff8881019312e8. So the panic
happens when it wants to introduce part->bd_stamp. Hope it's helpful
if the addresses are right.

Best Regards
Xiao

