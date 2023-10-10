Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F737BF06C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441805AbjJJBoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441802AbjJJBoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:44:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425F591;
        Mon,  9 Oct 2023 18:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696902239;
        bh=TDEkRZ8kDojPfNWycOzBus5z/cW2lt53AV98aJOTPl4=;
        h=Date:From:To:Cc:Subject:From;
        b=YCJtbSXFidKaZ5JfQF18W5dXVSkLHbId3h2MJy8+11mZZBIKamHxYBK3Ek04mdgEn
         IFjGOABcd+PrwvL8xHgH3rWFfYy4ILvUYa4d9IyT1q6/k3BZ+nPQjLLPf3YABos99+
         Yhpov++3QoQmgX1dgraiCGG1nxJ0tTtg6b+9V5paja8oxOoo7ykI5OyaU9SG7aZyPR
         SLE7o5ENe3BqtM5i4aoeUhyEhqYJUKAb1fhPLo/+/MYNe8LNckzcnN+myZcXDxaHlJ
         uDBEL0j0c68r0PgdEEiOIX36v3ESqrF3ljh5g0oV8si1k4M0Mf4T+A+uUi2jsM9Q9W
         CkhQ/3Va7xvWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4JbL621zz4xQd;
        Tue, 10 Oct 2023 12:43:58 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 12:43:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20231010124357.5251e100@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KpSwQG225d_fQIOAFSnZh=E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KpSwQG225d_fQIOAFSnZh=E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In funct=
ion 'dml_core_mode_support':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8229:1: e=
rror: the frame size of 2736 bytes is larger than 2048 bytes [-Werror=3Dfra=
me-larger-than=3D]
 8229 | } // dml_core_mode_support
      | ^
cc1: all warnings being treated as errors

Caused by commit

  7966f319c66d ("drm/amd/display: Introduce DML2")

(or maybe something later that changed storage size).

I have used the amdgpu tree from next-20231009 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/KpSwQG225d_fQIOAFSnZh=E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkrF0ACgkQAVBC80lX
0GzxDQf+JfIdTbdJ5V4MvCPEn6Kz75ZINinIjnu3lf4RN+kqXLcVgafinhSNF2r9
Vl4hRyKVJyV4crd5ybo2Z/WpSCvjuksxC2JVcz9bhOElKNF2mfDyItvbEf6tExN5
TvCa3XWEkTKRjiQEfgGk07dqvUSqkV802ylC2jtqlNvGjFA3ElBDgfpUah4kRsuG
CcRpSny4PM59iU6tigJrFUVHSeQUsDJjFsbkvvyOgDij7QK7aBpA7OGsq/dokGM4
xqkWPcP9fgjyPvKqN3fvHRWnIbriIWyX16omYVLBB2rV9ZS3dzxe8NnQ7UDutE3p
I2ryQckkTOBoIHYZzVpo2b0XszsiMQ==
=e8K0
-----END PGP SIGNATURE-----

--Sig_/KpSwQG225d_fQIOAFSnZh=E--
