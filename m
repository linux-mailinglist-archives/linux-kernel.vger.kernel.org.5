Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53876766F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjG1OXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbjG1OWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:22:43 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AAD3C05
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:22:34 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:22:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1690554152; x=1690813352;
        bh=qUTyVGmY+SUpg3/1PHbpdRRzD/ZAMSvRleoyIi8Jdus=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Jy7+jRZ+kBFwVXICl01cgJ2HPRNBr8O9uTX2knZ+VspFsWH62GRPqefxbMJcQs4Wq
         YEzXZ8Gi30qX/hFqn3lMyt7LIosgfuefoRUMF1RmfJMGL83E4JyVxXOgTF4UoqMVJe
         5ThuUBDvZHIHqoi3Et+FWWjSizGr9WQ3u8sbbhWph2c9MNquS32xySuWAbttDS8JjJ
         07LCgwla0VsDSOpt7iYab7F1GLY0xtdsATmgGXiLsrzPxmrISXAlHNHZbAuBkk0Em7
         3vuKneYBaIlhrVCfHl/7zMIYpCJPun3+zrDYPsv/HQiLTaWL1Mh/s5j08QJufnDb5F
         W5zzuNdH3sMEw==
To:     =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        James Zhu <James.Zhu@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v6 3/4] drm: Expand max DRM device number to full MINORBITS
Message-ID: <TAdBP5BOy3cy7VnUb4t7ZkDOMK6wI_gPCjXanItN3TOsA1TbSk_6yrlcPTqvk3AZjamo96yHlEhjpfNUPFF6tA_9K8iRoie3h_z5Jf6zNtc=@emersion.fr>
In-Reply-To: <69801f61-37b0-3e46-cbef-31ff80ae9a34@amd.com>
References: <20230724211428.3831636-1-michal.winiarski@intel.com> <20230724211428.3831636-4-michal.winiarski@intel.com> <83s0YPWEdYE6C2a8pa6UAa3EaWZ2zG-q7IL9M-y6W1ucF9V54VnZtigKj3BGKUA2FZpIrs0VVxmpHO2RAhs_FdOnss9vNLQNSHySY8uH7YA=@emersion.fr> <69801f61-37b0-3e46-cbef-31ff80ae9a34@amd.com>
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

On Thursday, July 27th, 2023 at 14:01, Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:

> > We do need patches to stop trying to infer the node type from the minor
> > in libdrm, though. Emil has suggested using sysfs, which we already do
> > in a few places in libdrm.
>=20
> That sounds like a really good idea to me as well.
>=20
> But what do we do with DRM_MAX_MINOR? Change it or keep it and say apps
> should use drmGetDevices2() like Emil suggested?

DRM_MAX_MINOR has been bumped to 64 now.

With the new minor allocation scheme, DRM_MAX_MINOR is meaningless
because there is no "max minor per type" concept anymore: the minor no
longer contains the type.

So I'd suggest leaving it as-is (so that old apps still continue to
work on systems with < 64 devices like they do today) and mark it as
deprecated.
