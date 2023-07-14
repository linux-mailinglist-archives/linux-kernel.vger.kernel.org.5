Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AAA75392F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGNLBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGNLBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:01:37 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721FE1FEA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:01:34 -0700 (PDT)
Date:   Fri, 14 Jul 2023 11:01:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1689332492; x=1689591692;
        bh=F3OiycbB7GwewJiwDg1BPAMuGwncE0fbQtGP05byLxg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=q2d8DrMuIwkModOw3DwooRH7TZ9c++tg28yaJ1iWYJU4EcAPwJ8Ypp9YmqsKFe9y3
         B3YCPVQ6SbBQwoJLtgOuRji+NIbAcB0OM330aM8q3C2R8gpZwsJmg5A10B/KvBCdFx
         XHfhI8BURyiseu7lnmQAvp1KeLdNn1d3a6m3wgFTjO6oIoCEey/zLgDUMT/eas+eWy
         L8mudu9r6uIZxbFf52RCTjuma+QEbAddngsM3X/AmocQ8TY4qqwW8cJUkA9kRDlcvL
         ablhpBngARj6eWLsqII/Jcq7Lj2LThVf/rrpeRBRpOhkS+U14EnFAI6EqDWqvKDg9p
         HSibtV9lR623g==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/8] drm/client: Convert drm_mode_create_dumb() to drm_mode_addfb2()
Message-ID: <0KNCLmzXJwmF0RTaQXUBd456dzaM5QsAot8g_yT36aNlEhJbSssTxBOS95x99DJHYkEzUJeMO7zJCX4JGjX6DEmY40BWtLKVZf6nB4HQMSc=@emersion.fr>
In-Reply-To: <9090c1b423e0b56c8e906155fe53ff0841830a03.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org> <9090c1b423e0b56c8e906155fe53ff0841830a03.1689252746.git.geert@linux-m68k.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 13th, 2023 at 15:17, Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:

> Currently drm_client_buffer_addfb() uses the legacy drm_mode_addfb(),
> which uses bpp and depth to guess the wanted buffer format.
> However, drm_client_buffer_addfb() already knows the exact buffer
> format, so there is no need to convert back and forth between buffer
> format and bpp/depth, and the function can just call drm_mode_addfb2()
> directly instead.

By any chance, is the commit message wrong? The title refers to
drm_mode_create_dumb(), but the description and code refer to
drm_client_buffer_addfb().
