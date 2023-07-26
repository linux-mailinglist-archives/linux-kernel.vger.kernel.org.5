Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02E4763E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGZSQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGZSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:16:11 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84CA26A8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:16:07 -0700 (PDT)
Date:   Wed, 26 Jul 2023 18:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1690395365; x=1690654565;
        bh=MHVHWNiRFk45RwUMHZjzyqHvHB/7TIueiT4PFTuQxkM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ay7oOHLfmGFsPbhpVgaXw64CWpTLO2Jc7obTWA9nxpU99nWyg4mLHOmhPKH0etHJG
         zd/gfMJRP910cx4K1jopLYL4mD7RcG/qE2niaVn5dSyl4/GQ87k0ZuEw1IiP10dLbA
         4jYhX5Lctrc2U07p3KVkD2zWiCnf/Qu4kL4D5IIGrPaqZh+q0v8YnjvCn/Q5hPosAV
         uM+tantdEa91El/9a+pXSQB4ztN4MfhFZ4xV1QkzZ6YCWCzF98+ypc4FUWU2OGbG+e
         /GY99WJj/z/XAkOz6G9KgEA9q3dIDlEFUtDN4vKs6wDVbVTmX8q6WpCN1CYxQfJGJi
         h5iSTkTOHzuOQ==
To:     =?utf-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v6 3/4] drm: Expand max DRM device number to full MINORBITS
Message-ID: <83s0YPWEdYE6C2a8pa6UAa3EaWZ2zG-q7IL9M-y6W1ucF9V54VnZtigKj3BGKUA2FZpIrs0VVxmpHO2RAhs_FdOnss9vNLQNSHySY8uH7YA=@emersion.fr>
In-Reply-To: <20230724211428.3831636-4-michal.winiarski@intel.com>
References: <20230724211428.3831636-1-michal.winiarski@intel.com> <20230724211428.3831636-4-michal.winiarski@intel.com>
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

On Monday, July 24th, 2023 at 23:14, Micha=C5=82 Winiarski <michal.winiarsk=
i@intel.com> wrote:

> Having a limit of 64 DRM devices is not good enough for modern world
> where we have multi-GPU servers, SR-IOV virtual functions and virtual
> devices used for testing.
> Let's utilize full minor range for DRM devices.
> To avoid regressing the existing userspace, we're still maintaining the
> numbering scheme where 0-63 is used for primary, 64-127 is reserved
> (formerly for control) and 128-191 is used for render.
> For minors >=3D 192, we're allocating minors dynamically on a first-come,
> first-served basis.

In general the approach looks good to me. Old libdrm will see the new
nodes as nodes with an unknown type when it tries to infer the nod type
from the minor, which is as good as it gets.

We do need patches to stop trying to infer the node type from the minor
in libdrm, though. Emil has suggested using sysfs, which we already do
in a few places in libdrm.
