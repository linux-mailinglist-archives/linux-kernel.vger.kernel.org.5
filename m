Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799780E507
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbjLLHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjLLHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:46:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC927AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:46:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E68EC433C9;
        Tue, 12 Dec 2023 07:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702367212;
        bh=Ry+0HOKGnrROeRDuXfVg3iVo2Hj0Ooc8riVJECBIRVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gIAZ0t27m2A4ZTpCVBQuIu2wQkSlygEsFdxVu017zBIB2lD7vOST7aIXouds16+6U
         IO0DE8aJMEI4zcReGH69LFua0fj3qWHjIybDh/rkPHsbnIQs5cIzTYjcBMzpfKPI6u
         cvpQIRaskJKmpzrw2UgMSy6RuH51FaSRpBlEF88KU9mtn5tXL+oWfjNSbUalkmg8Jf
         GV/JhpV0g9uRjxevSRkz+xX6wcKJvcwRvPhpaCtfgSO3mj+XWXbIrOSRkZdp1of8Ar
         6b3H4bZUVnvma+al9VRkq8Bz9VWFkmT50soPfpEQBFqyptuyNs3AyaXFX1gxMC4tXh
         W3MUD2YvP+8/A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so6083660e87.3;
        Mon, 11 Dec 2023 23:46:52 -0800 (PST)
X-Gm-Message-State: AOJu0Yyp6P5Ii5s+STtgq6Akwvi6dM3Wzrj7MpAoCL3TF9z+y/Pg6gb2
        N+TXHAWgbsWLM+THAaCIzcsrfBbBM2lj28PQ3t0=
X-Google-Smtp-Source: AGHT+IG3bR3Lcd82FvG3az8HYJgPLAE9nxxNkTnuKqti/naUDTGHp1e/eeep5o1bVubLakxCtKpQyd2g6CehqN6XxKI=
X-Received: by 2002:ac2:5e9b:0:b0:50b:e625:3009 with SMTP id
 b27-20020ac25e9b000000b0050be6253009mr2296886lfq.97.1702367210579; Mon, 11
 Dec 2023 23:46:50 -0800 (PST)
MIME-Version: 1.0
References: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>
 <202312041419.81EF03F7B7@keescook> <CAPhsuW43g-M+xvzD0N1JsJ_zGnvZQOw2Bi1TEqoHKanPnvMHLQ@mail.gmail.com>
 <202312080926.FBF7A2DDD2@keescook> <CAPhsuW5F1aRrCRW-ad5Sq=cgxHX+QgXgYZyMX17Zj4Mj=Jnhjw@mail.gmail.com>
 <ZXfzqsstA6tTPpF8@infradead.org>
In-Reply-To: <ZXfzqsstA6tTPpF8@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Dec 2023 23:46:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6k_Kh+iFq5jpbkn+-zFScg1_EpfEPRtMNDtyxhMsj0vQ@mail.gmail.com>
Message-ID: <CAPhsuW6k_Kh+iFq5jpbkn+-zFScg1_EpfEPRtMNDtyxhMsj0vQ@mail.gmail.com>
Subject: Re: [PATCH] md/md-multipath: Convert "struct mpconf" to flexible array
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Dec 11, 2023 at 9:46=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Dec 08, 2023 at 10:11:10AM -0800, Song Liu wrote:
> > We marked it as deprecated about 2.5 years ago. But to be honest,
> > I currently don't have a plan to remove it. I guess I should start thin=
king
> > about it.
>
> Let's just kill it off ASAP.  It never had a large user base and based
> by dm-multipath not long after it has been added.  It also doesn't
> support any uniqueue hardware and has no on-disk format.

Thanks for the suggestion.

> If you want any blame deflected from you I'd be happy to send the patch
> to remove it.

Let me give it a try. I am kinda curious what gonna happen. :)

Thanks,
Song
