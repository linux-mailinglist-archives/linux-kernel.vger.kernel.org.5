Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D216766D31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjG1M1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbjG1M0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:26:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0435A8;
        Fri, 28 Jul 2023 05:26:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 12AE3660716E;
        Fri, 28 Jul 2023 13:26:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690547176;
        bh=Zuw3jk8mejPhGkU4q+qt5KLfIfe2BfW1w5UKG2oKYJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CXGHqz2KdwadkHCSRUxB388XGBuPyDuOkH/TrBhRLZROG/LJGdIUiKsxWjDGrpq4p
         qo62jLxKl2bRNl0su1D73yldGjEM8xmC7S6jweG06y1u/2tdWXnRJ1Ih3nTbb6NqqO
         wr4FNBwH9u9F3NcqB+YHRkHgfxNn2B5BNlWKL5lTmxLCijitlJKZvpmHFwbbqWBJLy
         /GJr77MVKq5v7GXuNvAsYQyljhdYDnkgmKqRKhFp2vHptb0+cgMZO+bysK4IXV+iTv
         GQr5a7eoXjcskeHopo9TIa31E4yMY/mhd/BctWaqitn2DLsO7b6Dnpz4dzx4WtVtpo
         nmLCKxDNuKVKQ==
Date:   Fri, 28 Jul 2023 14:26:12 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, tzimmermann@suse.de, corbet@lwn.net,
        christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= 
        <thomas.hellstrom@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-misc-next v8 01/12] drm: manager to keep track of
 GPUs VA mappings
Message-ID: <20230728142612.2ecf99ef@collabora.com>
In-Reply-To: <hi5magp4icayy5dxmylfyxws52cu63jvlhu4yj5xem3acoaylk@msf7zthcr3lg>
References: <20230720001443.2380-1-dakr@redhat.com>
        <20230720001443.2380-2-dakr@redhat.com>
        <hi5magp4icayy5dxmylfyxws52cu63jvlhu4yj5xem3acoaylk@msf7zthcr3lg>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 13:31:36 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> Hi Danilo,
>=20
> On Thu, Jul 20, 2023 at 02:14:22AM +0200, Danilo Krummrich wrote:
> > Add infrastructure to keep track of GPU virtual address (VA) mappings
> > with a decicated VA space manager implementation.
> >=20
> > New UAPIs, motivated by Vulkan sparse memory bindings graphics drivers
> > start implementing, allow userspace applications to request multiple and
> > arbitrary GPU VA mappings of buffer objects. The DRM GPU VA manager is
> > intended to serve the following purposes in this context.
> >=20
> > 1) Provide infrastructure to track GPU VA allocations and mappings,
> >    making using an interval tree (RB-tree).
> >=20
> > 2) Generically connect GPU VA mappings to their backing buffers, in
> >    particular DRM GEM objects.
> >=20
> > 3) Provide a common implementation to perform more complex mapping
> >    operations on the GPU VA space. In particular splitting and merging
> >    of GPU VA mappings, e.g. for intersecting mapping requests or partial
> >    unmap requests.
> >=20
> > Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Acked-by: Matthew Brost <matthew.brost@intel.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Tested-by: Matthew Brost <matthew.brost@intel.com>
> > Tested-by: Donald Robson <donald.robson@imgtec.com>
> > Suggested-by: Dave Airlie <airlied@redhat.com>
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com> =20
>=20
> For some reason this breaks the drm_exec kunit patches:

Fix available here [1].

[1]https://lore.kernel.org/dri-devel/cbf4ccf9-8131-27a0-332c-6942866340d1@i=
galia.com/T/#t
