Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13F779E6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbjIMLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjIMLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:25:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09FA1726;
        Wed, 13 Sep 2023 04:25:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACBBC433CB;
        Wed, 13 Sep 2023 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694604331;
        bh=gd4Qg3wRr62r6hfNz7SvyOMx7SR3EXpHDzF31oJWhNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fo1KTGbXd6yIn2G5OTB8aXaZ0oNY2PoRgqPMb2bkR3QDXuZ8OoFmfTmR6bLztmi9x
         jyZAjwygsU0QQE9I5pvecp8p/1rV7QYk8kyonQyaeOCkMljHwP8tR+SWIyw/Cr9T5t
         ZmiQXLvzQEwP/AVEwCewjBiQwSh1+pyaIBkCKzvwXwbq+wBlx0dQ/R4b9YLUfExxsD
         jJdxRfmio/ua4K1MB/slVwl9PClTibPp3A3/dOl17tBr5BCoMJMVm99RhGLqzgd7aB
         JyTOQpbieVzjmdGEYpEreJcgKyH5aeo2sy2FKM/rGqgOFfIyQOz24kSHnS8azaKE0j
         dOt1psUDKAnfQ==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d7f0048b042so5799666276.2;
        Wed, 13 Sep 2023 04:25:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YwR8ZdpLdYrXWML4H2rKx2UQXNdFt1tBFTDuwMJL2m/clvmBjnP
        cV4gUvDrUixRZl9z0vNpceo6AQ+7e4VXv1rYpDw=
X-Google-Smtp-Source: AGHT+IF++WTrqbY3O8aaxIaa8Yma5uo3TC1iem9FGG5Ad85NyXYy6VAVo51407NjSpy8mj+70+8MDQDzOS1MswcqFvI=
X-Received: by 2002:a25:d009:0:b0:d7b:9d44:767a with SMTP id
 h9-20020a25d009000000b00d7b9d44767amr2030302ybg.17.1694604330438; Wed, 13 Sep
 2023 04:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <d38582083ece76155dabdfd9a29d5a9dd0d6bce7.1693855091.git.christophe.jaillet@wanadoo.fr>
 <20230905122827.GD184247@linux.intel.com>
In-Reply-To: <20230905122827.GD184247@linux.intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 13 Sep 2023 14:25:03 +0300
X-Gmail-Original-Message-ID: <CAFCwf11LyA-pyq2kZ_oJhCtw_LCyx3h_a4JTurPvRNBFngzqcw@mail.gmail.com>
Message-ID: <CAFCwf11LyA-pyq2kZ_oJhCtw_LCyx3h_a4JTurPvRNBFngzqcw@mail.gmail.com>
Subject: Re: [PATCH] accel/habanalabs/gaudi2: Fix incorrect string length
 computation in gaudi2_psoc_razwi_get_engines()
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dani Liberman <dliberman@habana.ai>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 3:28=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Mon, Sep 04, 2023 at 09:18:36PM +0200, Christophe JAILLET wrote:
> > snprintf() returns the "number of characters which *would* be generated=
 for
> > the given input", not the size *really* generated.
> >
> > In order to avoid too large values for 'str_size' (and potential negati=
ve
> > values for "PSOC_RAZWI_ENG_STR_SIZE - str_size") use scnprintf()
> > instead of snprintf().
> >
> > Fixes: c0e6df916050 ("accel/habanalabs: fix address decode RAZWI handli=
ng")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Applied to -next.
Thanks for the patch.
Oded
