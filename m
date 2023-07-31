Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349F7769BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjGaQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGaQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:00:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF1A7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:00:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6727E66018CF;
        Mon, 31 Jul 2023 17:00:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690819223;
        bh=JESYBgP90SbmhpiB/iCVLG+3rmUtF6P9tLKvU2lWr7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJDGOxFAIVjCl/H3qL1ragU6dyqFeK7uyghmCyCnSKQNm+3EQ7WmioINpElc3ehkJ
         Vi3/TD3++NVUTucyzKjQHN9xoLFw9WE52+bNNZTkuRU7wmDCx7F/3O4JERZUnq180l
         /64rAyXbD9Md0H9GZPb8AXbsiEmV2NUIx/i7apqvx2NToucdeRNwm6qrZWBC2IBw5N
         +P5qeWYyfID7pYncpSmQhxPXYW8Tn8FzA2b4tibSORDnv1EnxRz32zYoM02iK/I+Q3
         PjqwTJp5IRZaF9zH3HegCBJBXZM85vIF7+vFCwYdDfn29SlOwtP8xRC2+v0WWKrYxP
         6J2Hu1H0nG2mA==
Date:   Mon, 31 Jul 2023 18:00:20 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        ndesaulniers@google.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, trix@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        naresh.kamboju@linaro.org, dakr@redhat.com
Subject: Re: [PATCH 1/2] drm/exec: use unique instead of local label
Message-ID: <20230731180020.4c47e0e3@collabora.com>
In-Reply-To: <20230731153119.GA773004@dev-arch.thelio-3990X>
References: <20230731123625.3766-1-christian.koenig@amd.com>
        <20230731153119.GA773004@dev-arch.thelio-3990X>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 08:31:19 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Mon, Jul 31, 2023 at 02:36:24PM +0200, Christian K=C3=B6nig wrote:
> > GCC forbids to jump to labels in loop conditions and a new clang
> > check stumbled over this.
> >=20
> > So instead using a local label inside the loop condition use an
> > unique label outside of it.
> >=20
> > Fixes: commit 09593216bff1 ("drm: execution context for GEM buffers v7")
> > Link: https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1890
> > Link: https://github.com/llvm/llvm-project/commit/20219106060208f0c2f5d=
096eb3aed7b712f5067
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > CC: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com> =20
>=20
> Passes my build tests and I inspected the preprocessed output to make
> sure it should work. I ran the KUnit tests, which all pass (although [1]
> is needed to fix a tangential issue):
>=20
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Thanks for fixing this!
>=20
> [1]: https://lore.kernel.org/20230728183400.306193-1-arthurgrillo@riseup.=
net/
>=20
> > ---
> >  include/drm/drm_exec.h | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> > index 73205afec162..e0462361adf9 100644
> > --- a/include/drm/drm_exec.h
> > +++ b/include/drm/drm_exec.h
> > @@ -3,6 +3,7 @@
> >  #ifndef __DRM_EXEC_H__
> >  #define __DRM_EXEC_H__
> > =20
> > +#include <linux/compiler.h>
> >  #include <linux/ww_mutex.h>
> > =20
> >  #define DRM_EXEC_INTERRUPTIBLE_WAIT	BIT(0)
> > @@ -74,13 +75,12 @@ struct drm_exec {
> >   * Since labels can't be defined local to the loops body we use a jump=
 pointer
> >   * to make sure that the retry is only used from within the loops body.
> >   */
> > -#define drm_exec_until_all_locked(exec)				\
> > -	for (void *__drm_exec_retry_ptr; ({			\
> > -		__label__ __drm_exec_retry;			\
> > -__drm_exec_retry:						\
> > -		__drm_exec_retry_ptr =3D &&__drm_exec_retry;	\
> > -		(void)__drm_exec_retry_ptr;			\
> > -		drm_exec_cleanup(exec);				\
> > +#define drm_exec_until_all_locked(exec)					\
> > +__PASTE(__drm_exec_, __LINE__):						\
> > +	for (void *__drm_exec_retry_ptr; ({				\
> > +		__drm_exec_retry_ptr =3D &&__PASTE(__drm_exec_, __LINE__);\
> > +		(void)__drm_exec_retry_ptr;				\
> > +		drm_exec_cleanup(exec);					\
> >  	});)
> > =20
> >  /**
> > --=20
> > 2.34.1
> >=20
> >  =20

