Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF480BBB3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjLJO0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:26:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87648C2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 06:26:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3C6C433C7;
        Sun, 10 Dec 2023 14:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702218371;
        bh=AltcgXfkx0PNaD9wf1JDyoUG7rn4S77782W4sTsGUNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vq7auFPJszjdbN+XSlFWTTSN8msZgwSHdmUs+/mxgnq/dPouFj+2DIVC+c4h6iVld
         SGbt3aLb/7nystgPRKEf7NSSDX0ZqFqtKQr8PwXxuac5QCTzo6t869phO8kPgiNRFe
         54YG+RXdLgh9DzMgc9ORuatGgcji9XMx8WlV6jp7ynFZlP+bW3C1n/kQN+LGdIUKdv
         SZ5EadX1jb+gdpO9EAkrVwJAIKD9u6uLwSKC+3aOwG1CVtbnFxTxqbRvsCaGJlfeIE
         vwGtv5UVMOKBXl6UyHsSQFzlfsZn55aePZLOb+WRCurO11dmN5ZDDuosmWf8s/ijB2
         wlq2W1a0vjr2Q==
Date:   Sun, 10 Dec 2023 14:23:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a6H2z5ZEGXpRtGmb"
Content-Disposition: inline
In-Reply-To: <20231206103702.3873743-6-surenb@google.com>
X-Cookie: Monotheism is a gift from the gods.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6H2z5ZEGXpRtGmb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 02:36:59AM -0800, Suren Baghdasaryan wrote:
> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> into destination buffer while checking the contents of both after
> the move. After the operation the content of the destination buffer
> should match the original source buffer's content while the source
> buffer should be zeroed. Separate tests are designed for PMD aligned and
> unaligned cases because they utilize different code paths in the kernel.
>=20
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c     |  24 +++
>  tools/testing/selftests/mm/uffd-common.h     |   1 +
>  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>  3 files changed, 214 insertions(+)

This breaks the build in at least some configurations with separate
output directories like those used by KernelCI:

make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgcc CR=
OSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf=
- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/kci/l=
inux -j10 kselftest-gen_tar

(full logs for both arm64 and x86_64 at):

   https://storage.kernelci.org/next/master/next-20231208/arm64/defconfig/g=
cc-10/logs/kselftest.log
   https://storage.kernelci.org/next/master/next-20231208/x86_64/x86_64_def=
config/clang-17/logs/kselftest.log

or tuxmake:

make --silent --keep-going --jobs=3D16 O=3D/home/broonie/.cache/tuxmake/bui=
lds/25/build INSTALL_PATH=3D/home/broonie/.cache/tuxmake/builds/25/build/ks=
elftest_install ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPI=
LE_COMPAT=3Darm-linux-gnueabihf- kselftest-install

The specific failure:

aarch64-linux-gnu-gcc -Wall -I /tmp/kci/linux/tools/testing/selftests/../..=
/..  -isystem /tmp/kci/linux/build/usr/include     uffd-stress.c vm_util.c =
uffd-common.c -lrt -lpthread -lm -o /tmp/kci/linux/build/kselftest/mm/uffd-=
stress
uffd-common.c: In function =E2=80=98move_page=E2=80=99:
uffd-common.c:636:21: error: storage size of =E2=80=98uffdio_move=E2=80=99 =
isn=E2=80=99t known
  636 |  struct uffdio_move uffdio_move;
      |                     ^~~~~~~~~~~
uffd-common.c:643:21: error: =E2=80=98UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES=E2=
=80=99 undeclared (first use in this function)
  643 |  uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
uffd-common.c:643:21: note: each undeclared identifier is reported only onc=
e for each function it appears in
uffd-common.c:645:17: error: =E2=80=98UFFDIO_MOVE=E2=80=99 undeclared (firs=
t use in this function); did you mean =E2=80=98UFFDIO_COPY=E2=80=99?
  645 |  if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
      |                 ^~~~~~~~~~~
      |                 UFFDIO_COPY
uffd-common.c:636:21: warning: unused variable =E2=80=98uffdio_move=E2=80=
=99 [-Wunused-variable]
  636 |  struct uffdio_move uffdio_move;
      |                     ^~~~~~~~~~~

--a6H2z5ZEGXpRtGmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV1yfMACgkQJNaLcl1U
h9BZ+gf/UkFwJK/bQHdsM2z3PX8a8hGKETQ2aXDe+QSyV8SLbiBkgQAZt5ZV2EpQ
upT7zDDXsAwZY3f1ovuYd7UNK8KqMjakLxGTaQtNcoEnnGv4d8FjCZYvVODQYTGM
CtvpWTI9IqsgU67qiPHecWVs+HDF6K0y+nLpXkvMwRFeOeMO0uE1IBIhIPrPRK/K
nwhuPLti4PfE/92SMVfCdXIqypM5ZfGkE+7gwege+/lqtGCKiJW8ylFpczBPNSCN
WCasm6E6IOvsnWFhSvGNx/tRZ5YYKpO4ndn9d0onO60JmvBg7PJ1bBmBo7G1gPGv
iUEnb2qdbO4CPRHkGKm03zAW5LfJ3g==
=e4gY
-----END PGP SIGNATURE-----

--a6H2z5ZEGXpRtGmb--
