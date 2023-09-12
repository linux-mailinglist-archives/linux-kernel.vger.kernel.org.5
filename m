Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26B079D4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjILPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjILPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0071F1995;
        Tue, 12 Sep 2023 08:32:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9374DC433C7;
        Tue, 12 Sep 2023 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694532743;
        bh=aP1q85HwpR6MN+z+kgmwRqnZ5/UeHlephsY4A436iPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KvUJ1pk2rdvvrrQsS5AlI/zh7thGtzqmZ3vtUa+66ZNBtwK2TxbG3eyI+uVCD1zud
         kqeEbGjACxSxzSUDHiIcuTBDZStptYFuJWwYgrrsWbzg8PWGWeDb+zDG+UG+Gfqr9S
         hdfiNtUCWYYNiEjmU13o/O08mLIelGglz6kfYOGnyg0iM0dHvuqZyZgxZ6XONY8Pq+
         J2Wqco412nKm6q7B/9s/8oEcko5QHOhRvVuZ4zAIA8cU+cftx9JrVzFmTvhV4Yz4jZ
         q3wcqIpS46lPZV22MtmDXwAGLc6JMCR9G4UN5DHh060caH92cDMjBDQb/c3F47G29j
         tw3U5rRJyWtqw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so100169601fa.3;
        Tue, 12 Sep 2023 08:32:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YzJ8ek19jUblldG9Ek3SLr7Eqkt0JPhr7PPeZrlzGnulQp1AT/j
        RINI8Qqx/nUd93viJWnt+rJNdhfMnwc1m3N0ig==
X-Google-Smtp-Source: AGHT+IF7yvHU5JtvkJlFSQSpzz6yf0IyFvMIb+pn1jl8NW+pfuw50rW/Mra/ZdqhpnEzrQ5euY2oaMs/mZebFQ9NlEE=
X-Received: by 2002:a05:6512:3b86:b0:500:af82:7dd6 with SMTP id
 g6-20020a0565123b8600b00500af827dd6mr12406327lfv.41.1694532741801; Tue, 12
 Sep 2023 08:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
 <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
 <CAMuHMdVep4Hib0iBabGdFfbCxdftWcJ8wfySGLB8GbmbSmBNhg@mail.gmail.com> <06327197-9b17-481f-8ecc-3f9c5ba3e391@kadam.mountain>
In-Reply-To: <06327197-9b17-481f-8ecc-3f9c5ba3e391@kadam.mountain>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Sep 2023 10:32:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKZuG4dK2ThuTaFKk9b9HtGcvmuJMgZFMeVw7ADg2+_kQ@mail.gmail.com>
Message-ID: <CAL_JsqKZuG4dK2ThuTaFKk9b9HtGcvmuJMgZFMeVw7ADg2+_kQ@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in of_changeset_action()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 11:14=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Sep 08, 2023 at 05:34:53PM +0200, Geert Uytterhoeven wrote:
> > > > Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not us=
e "%pOF" inside devtree_lock")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.c=
om/
> > >
> > > Despite what that says, it was never reported to me. IOW, the added T=
O
> > > and CC lines don't seem to have any effect.
> >
> > The copy I received did list you in the "To"-header, though.

Are you sure that's the header and not in the body?

> > Fall-out of the issues seen with Gmail lately?
> > I do miss lots of email, too :-(
>
> My gmail account dropped a whole lot of mail too in the last week of
> August.  I was out of office that week so I didn't investigate.  I was
> assuming it was an issue with vger...

I don't think it's related to those issues. If I search lore including
my email[1], then it doesn't find it either. Lore only has it in
oe-kbuild. Not LKML or oe-kbuild-all. It really just looks like the
git-send-email style of extracting emails from tags in the body is not
happening.

Rob


[1] https://lore.kernel.org/all/?q=3Df%3Alkp%40intel.com+a%3Arobh%40kernel.=
org+of_changeset_action
