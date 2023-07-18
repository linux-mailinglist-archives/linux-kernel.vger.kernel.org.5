Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD07757967
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGRKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGRKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73540F0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 117E86150F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A67C433C8;
        Tue, 18 Jul 2023 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689676902;
        bh=OUjUdujOU6xee9ci8vr4sbSWtz6K7GK3lKu01CccESI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3ikNNxkzZVm7sBvTch39A392lKdsF/MtLcWBHZrDSjcVZ+SryKeypemdThHWZ+6T
         YlBh1j2T4dcMNoC+ECE/Fuq4UojR2o2lChd6E8f+hQLFOgF8NDA8p9Uoyp2Uc/9VEg
         5pCOqd9GXoOGyyRanr8JMFAqGkbvRn9Ru7nhv33E/iaHALHu26Wp7GYcjoDQkwtJLp
         rTmvuGXAymnL2SRA/3PuA30frH6/MCdmLx82NbedDQPKQbW4kidrmDxvtCkGo5pTJk
         AbB5BqYgyWSe+Cegf7tqkirsUWrAL8gt8bHZsttVgWQM71+UTPPpdGq8JFPTJBnhh7
         iirU7dVHOAjMw==
Date:   Tue, 18 Jul 2023 11:41:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC for
 !dma_coherent
Message-ID: <20230718-regulator-hardened-919cb8f4e562@spud>
References: <20230716165147.1897-1-jszhang@kernel.org>
 <20230716165147.1897-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WaDhwX/tojNUxqXP"
Content-Disposition: inline
In-Reply-To: <20230716165147.1897-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WaDhwX/tojNUxqXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 12:51:47AM +0800, Jisheng Zhang wrote:
> With the DMA bouncing of unaligned kmalloc() buffers now in place,
> enable it for riscv when RISCV_DMA_NONCOHERENT=3Dy to allow the
> kmalloc-{8,16,32,96} caches. Since RV32 doesn't enable SWIOTLB
> yet, and I didn't see any dma noncoherent RV32 platforms in the
> mainline, so skip RV32 now by only enabling
> DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB is available. Once we see
> such requirement on RV32, we can enable it then.
>=20
> NOTE: we didn't force to create the swiotlb buffer even when the
> end of RAM is within the 32-bit physical address range. That's to
> say:
> For RV64 with > 4GB memory, the feature is enabled.
> For RV64 with <=3D 4GB memory, the feature isn't enabled by default. We
> rely on users to pass "swiotlb=3Dmmnn,force" where mmnn is the Number of
> I/O TLB slabs, see kernel-parameters.txt for details.
>=20
> Tested on Sipeed Lichee Pi 4A with 8GB DDR and Sipeed M1S BL808 Dock
> board.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--WaDhwX/tojNUxqXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLZsYgAKCRB4tDGHoIJi
0h6dAQCo44pYvI6nANHuLGtYjW6avnzLGuUsYn5qdzK431TdSwEAvpmfuiQjAx+6
2Y1b6+zCOekk56K2qaOXzuHSDGzw/gg=
=Px5H
-----END PGP SIGNATURE-----

--WaDhwX/tojNUxqXP--
