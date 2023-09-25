Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B347AD59D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjIYKNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjIYKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:13:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6D448A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:59:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0882FC433C8;
        Mon, 25 Sep 2023 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695635945;
        bh=iJrTtczHiEmaVCzPFKPPb4YRyBiOSAFyoPe4Ilwhn+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qinEol59UJwv04peJb2qYSlLfco2Il7Pxt1qR73otlu7Qa+JN9xGjpW9W8uCB6Ezi
         FZVEgVPJoOOalo+nEiDzcB2zxVZhkcEM7rJokrYjF7OH0VjNAXxrF8SlZWn9Lv7tMe
         azQZMJWQSAb/NqedwgXhdO8Nlb9gdWax1MSNtEaTkPsZZ65rmhj7uLfYudA5gwa6jz
         J/5Rlx8hy6kjQwUWf2gIHMzezoVeyMrvNFwu1iVS+ipPs2IVPU2kpCGdjJwU62fMvZ
         40+RUP6KjoBYMnm/Fq1mffHYlZYqJLFfTzP6agT9I48z9Hc9aFq2SCH41mmOZTsZf4
         kyc4SvuID3G9Q==
Date:   Mon, 25 Sep 2023 11:59:02 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Arthur Grillo <arthurgrillo@riseup.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        tales.aparecida@gmail.com, andrealmeid@riseup.net,
        mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/3] kunit: Add kunit_move_action_to_top_or_reset() to
 reorder actions
Message-ID: <ct6ydugpx3c5uklimg2w5irwtezxmcdikqn64p3hds5tjrb3y2@hvomhcxsbl34>
References: <20230920-kunit-kasan-fixes-v1-0-1a0fc261832d@riseup.net>
 <20230920-kunit-kasan-fixes-v1-2-1a0fc261832d@riseup.net>
 <CABVgOSk6cvPHs3CsoG0FgHz9Y1OT31ZCk=eu5cCOXyg03uNpBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSk6cvPHs3CsoG0FgHz9Y1OT31ZCk=eu5cCOXyg03uNpBA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Sep 22, 2023 at 04:00:21PM +0800, David Gow wrote:
> On Wed, 20 Sept 2023 at 14:12, Arthur Grillo <arthurgrillo@riseup.net> wr=
ote:
> >
> > On Kunit, if we allocate a resource A and B on this order, with its
> > deferred actions to free them. The resource stack would be something
> > like this:
> >
> >          +---------+
> >          | free(B) |
> >          +---------+
> >          |   ...   |
> >          +---------+
> >          | free(A) |
> >          +---------+
> >
> > If the deferred action of A accesses B, this would cause a
> > use-after-free bug. To solve that, we need a way to change the order
> > of actions.
> >
> > Create a function to move an action to the top of the resource stack,
> > as shown in the diagram below.
> >
> >          +---------+    +---------+
> >          | free(B) |    | free(A) |
> >          +---------+    +---------+
> >          |   ...   | -> | free(B) |
> >          +---------+    +---------+
> >          | free(A) |    |   ...   |
> >          +---------+    +---------+
> >
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > ---
>=20
> Thanks. This is a really interesting patch: my hope was that something
> like this wouldn't be necessary, as in most cases freeing things in
> the reverse order to which they were created is the right thing to do.
>=20
> It looks like, from the comments on patch 3, this may no longer be
> necessary? Is that so?

Yeah, it's no longer necessary

Maxime
