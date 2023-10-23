Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82187D2D14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJWIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:45:06 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C059DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698050700; x=1698309900;
        bh=cv395rOhvRRsmXYsyvgE2cfgGeGA6dYaArchmFqHrnU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=DxJQMRDDXdj792We1zwaB3UukfXBxpurEuFkdS4lzD3qraKBC2OmlVxjC1qOTjk4F
         GlCSesp4ippmjtpcCQYYoqbtX/kDFMSlNl2vYkGn1EdWOu84ia5a7YFm3nM5LHE/5c
         zyJ9dUEk/l6KxUcu9wKCuKPmfIrPpjw172Ap57CJ+og3XVF9R+U1tAWAWl/6U2YdSe
         P+sAvGw1GkBbaBQncjxyjIo7xKj/fG2VwBNBoBVFLDkybcbLKObSLXU3Xt8dRrzXMi
         yJlAdaP8JChjy8SDUM+mShJ2jTgr1lghY7HJ7BZKfbVhMM9cN9oWkIJoh3VKJb+6bw
         0DtK9Vy6JHl5A==
Date:   Mon, 23 Oct 2023 08:44:46 +0000
To:     =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, hwentlan@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
Subject: Re: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
Message-ID: <OmiJ2t3KUJGjN5EM8mo1cX52UpRgtMZx0oT11igYlRjfeqXtkeQlFdV3OdHO3eA4KkyWKuvSSVX8Ico1zFkioaQQObjLgp0dTu15YE-RWc8=@emersion.fr>
In-Reply-To: <745e35ee-d617-9ce0-8b4e-795c84a5af48@mailbox.org>
References: <20231017092837.32428-1-andrealmeid@igalia.com> <20231017092837.32428-5-andrealmeid@igalia.com> <CzEtDALWvF3EU4DDLLEmH3ms0B25PbsEHRU9b_IqwfyhzdG4zC-XXAU6fm2PnMcngAYmntH7s4iuew0vocN6cO8zUit8kgi-Sb1hBQXNYiw=@emersion.fr> <3r5-_03WC5dK3LaRt1Is78zD_bmT2aaGc5h9jpUGzo2o5GCtGP1zpQNzUxglsieewFklY7xwTrOS9jtI18YlNnnzHNx2Ccw9yM2NuJpDQZU=@emersion.fr> <8c1641e4-a7e2-ecb2-ab7a-c6e2bb3e951b@mailbox.org> <Bi9El_nuZXA997YlVyCzD5s7KfP820IVUuYiB69mgXnjQbfCgOucCBe6aKvSFrMzB_9DwxO2lli_MqLzMuGZ-rmrRp57vePsTwUarEweLJs=@emersion.fr> <745e35ee-d617-9ce0-8b4e-795c84a5af48@mailbox.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 23rd, 2023 at 10:42, Michel D=C3=A4nzer <michel.daenzer@=
mailbox.org> wrote:

> On 10/23/23 10:27, Simon Ser wrote:
>=20
> > On Sunday, October 22nd, 2023 at 12:12, Michel D=C3=A4nzer michel.daenz=
er@mailbox.org wrote:
> >=20
> > > On 10/17/23 14:16, Simon Ser wrote:
> > >=20
> > > > After discussing with Andr=C3=A9 it seems like we missed a plane ty=
pe check
> > > > here. We need to make sure FB_ID changes are only allowed on primar=
y
> > > > planes.
> > >=20
> > > Can you elaborate why that's needed?
> >=20
> > Current drivers are in general not prepared to perform async page-flips
> > on planes other than primary. For instance I don't think i915 has logic
> > to perform async page-flip on an overlay plane FB_ID change.
>=20
>=20
> That should be handled in the driver's atomic_check then?
>=20
> Async flips of overlay planes would be useful e.g. for presenting a windo=
wed application with tearing, while the rest of the desktop is tear-free.

Yes, that would be useful, but requires more work. Small steps: first
expose what the legacy uAPI can do in atomic, then later extend that in
some drivers.
