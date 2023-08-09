Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E14F776015
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjHINAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHINAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:00:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD11FF5;
        Wed,  9 Aug 2023 06:00:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3176a439606so5207615f8f.3;
        Wed, 09 Aug 2023 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691586035; x=1692190835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zloZVxNaHrnYHPz3REtAzM9yYHyeZJvdcxZLzgQr6lQ=;
        b=csJ/pk4GqVFJrM4T0wSW1bliXiqXohqbgBFPHMzJpDgvzAxzSTa+/ifV6yfQNpXArq
         R42ryRFhkIAhNdktL2V3V6l2pXhS9PvukqeYBou3lvyPRJ5MJROBD2J5Vp7SV7cPwChe
         rMFSYw1gHyW75hwO8ylWPxbxPhOvkC6ldMc8EdAOIYkPxMrnz+XCd3TAo1VHZB6Ut3S/
         0rgb+IEGU/N1mvpRuthOoDsCAYJyQZzyWDdqOzNP7ddJd2j06j4QmcjIzoZMHhLFLQBB
         6LOrR6ZjnA9mW81ciJm1qX5LqbOAsNxx/Z+ilTz7NviplBpQWkr8J9TMPiknQIkOlhHo
         DsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586035; x=1692190835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zloZVxNaHrnYHPz3REtAzM9yYHyeZJvdcxZLzgQr6lQ=;
        b=idoPZB1DKbTU5gldmUGo+UBL53XFm0dlcBEcqsYth26kePefebF39tP5SMG2gBb6RK
         RUeRN+x/atYfyLYkgOh0AVEeEzkxhNy9UqsYiX9gJL32wSoGR6aQuBiP84/iO+P34w+g
         8i8KhLH02zE60ia3dOKx2HyD2cc36SKf3J/b6BucFnEEaNUmP85+cJADrAvygTuDM/4B
         y29aWwUvegS/585tDosOg+xU8PweF2t86/bI28fYG9V78OuEF6mH1kAvdM/yc1B+9WZ2
         qEgyJS7/sW0bJushmJ7TB/YTlI9jWlgT8f2UYD9N9E80BrEMJDxu0loIw88SvCui4Kgn
         /Bnw==
X-Gm-Message-State: AOJu0YwubfW79etbDaaHawwRbvU6P2YBziDXaSGWoLddAuyE4FUjQ2bF
        VKKhs3LJG6ObcaS+8jndnaQ=
X-Google-Smtp-Source: AGHT+IHujO9QbdFycDXQ+aeoydvaWfWjdr8SFFtfvRbYeyGnkceJLASmfJlRbG7tFeMkvkLnzXz9LA==
X-Received: by 2002:adf:f608:0:b0:317:7441:1a4 with SMTP id t8-20020adff608000000b00317744101a4mr1964638wrp.29.1691586034572;
        Wed, 09 Aug 2023 06:00:34 -0700 (PDT)
Received: from suse.localnet (host-95-233-25-82.retail.telecomitalia.it. [95.233.25.82])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d490a000000b00317ab75748bsm16694129wrq.49.2023.08.09.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:00:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation/page_tables: Add info about MMU/TLB and Page Faults
Date:   Wed, 09 Aug 2023 15:00:31 +0200
Message-ID: <3770829.kQq0lBPeGt@suse>
In-Reply-To: <20230807105010.GK2607694@kernel.org>
References: <20230728120054.12306-1-fmdefrancesco@gmail.com>
 <20230807105010.GK2607694@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 7 agosto 2023 12:50:10 CEST Mike Rapoport wrote:
> Hi Fabio,
>=20
> On Fri, Jul 28, 2023 at 01:53:01PM +0200, Fabio M. De Francesco wrote:
> > Extend page_tables.rst by adding a section about the role of MMU and TLB
> > in translating between virtual addresses and physical page frames.
> > Furthermore explain the concept behind Page Faults and how the Linux
> > kernel handles TLB misses. Finally briefly explain how and why to disab=
le
> > the page faults handler.
> >=20
> > [snip]
> >
> > +MMU, TLB, and Page Faults
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +The `Memory Management Unit (MMU)` is a hardware component that handles
> > virtual +to physical address translations. It may use relatively small
> > caches in hardware +called `Translation Lookaside Buffers (TLBs)` and=20
`Page
> > Walk Caches` to speed up +these translations.
> > +
> > +When a process wants to access a memory location, the CPU provides a
> > virtual
> > +address to the MMU, which then uses the MMU to check access permission=
s=20
and
> > +dirty bits, and if possible it resolves the physical address and conse=
nts
> > the +requested type of access to the corresponding physical address.
>=20
> Essentially any access to a memory location involves the translation from
> virtual to physical, not only when processes access memory.

Mike,

I'm cutting everything from here on because I agree with your comments, so =
I=20
could just write a long list of 'I agree', 'I understand' and the like. I w=
ant=20
to avoid readers from the aforementioned list :-)

I think (actually, I hope) that I have understood everything correctly. I w=
ill=20
send a new version with the necessary corrections by the end of this week.

Thanks again for your comments and suggestions.

=46abio


