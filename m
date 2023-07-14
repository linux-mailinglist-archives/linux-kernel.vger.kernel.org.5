Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18BB752E25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjGNAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGNAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:07:43 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293B2691;
        Thu, 13 Jul 2023 17:07:40 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R2Bcn3Mnzz9smQ;
        Fri, 14 Jul 2023 02:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689293257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OxAPE5PWCAcXqFIorj18HGTh/eNPcEPw2BzrDqE7QOk=;
        b=REmtctvxEJLDq1JtNm0+KBL/TGwaI3oEFMWaulKzejxxrE1ptEB21Q/D95oMpkwMNuy4NL
        OXlPLuS6jAg8CBCm4smppRN9U1EHg8LI4Z4xHMxsxKMQbXcnN5cVMIShrrlh6kVQWoZCjM
        0oWawiir/mzs+Pl0F5KJCu+op+68v81tUmOA07jATIuFaZB2+TeYs0G8R4Ipvtjg5k65lf
        TsH/dra5lOANgOgPP/6afTuVl7HhJGJPLRczs1A90/AgtKeJjZDKdxC6mG8T8UJfY3dMqy
        fNhteInF8njLziq7XklRiIsj5M+z5Se72b0vtysOMmpSer0CcGsf1XQDxNPMPQ==
Date:   Fri, 14 Jul 2023 10:07:21 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     linux-mm@kvack.org, Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] memfd: remove racheting feature from
 vm.memfd_noexec
Message-ID: <pyylsri7uzypafzv7ar2w4j2lr6puh6bfowedalr226rswdzoo@dg54fdtx5nwd>
References: <20230713143406.14342-1-cyphar@cyphar.com>
 <20230713143406.14342-3-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ubij2xktskdezgp"
Content-Disposition: inline
In-Reply-To: <20230713143406.14342-3-cyphar@cyphar.com>
X-Rspamd-Queue-Id: 4R2Bcn3Mnzz9smQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ubij2xktskdezgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-14, Aleksa Sarai <cyphar@cyphar.com> wrote:
> This sysctl has the very unusal behaviour of not allowing any user (even
> CAP_SYS_ADMIN) to reduce the restriction setting, meaning that if you
> were to set this sysctl to a more restrictive option in the host pidns
> you would need to reboot your machine in order to reset it.
>=20
> The justification given in [1] is that this is a security feature and
> thus it should not be possible to disable. Aside from the fact that we
> have plenty of security-related sysctls that can be disabled after being
> enabled (fs.protected_symlinks for instance), the protection provided by
> the sysctl is to stop users from being able to create a binary and then
> execute it. A user with CAP_SYS_ADMIN can trivially do this without
> memfd_create(2):
>=20
>   % cat mount-memfd.c
>   #include <fcntl.h>
>   #include <string.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <linux/mount.h>
>=20
>   #define SHELLCODE "#!/bin/echo this file was executed from this totally=
 private tmpfs:"
>=20
>   int main(void)
>   {
>   	int fsfd =3D fsopen("tmpfs", FSOPEN_CLOEXEC);
>   	assert(fsfd >=3D 0);
>   	assert(!fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 2));
>=20
>   	int dfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
>   	assert(dfd >=3D 0);
>=20
>   	int execfd =3D openat(dfd, "exe", O_CREAT | O_RDWR | O_CLOEXEC, 0782);
                                                                      0777

Oops. I must've garbled something when copying from my test program.

>   	assert(execfd >=3D 0);
>   	assert(write(execfd, SHELLCODE, strlen(SHELLCODE)) =3D=3D strlen(SHELL=
CODE));
>   	assert(!close(execfd));
>=20
>   	char *execpath =3D NULL;
>   	char *argv[] =3D { "bad-exe", NULL }, *envp[] =3D { NULL };
>   	execfd =3D openat(dfd, "exe", O_PATH | O_CLOEXEC);
>   	assert(execfd >=3D 0);
>   	assert(asprintf(&execpath, "/proc/self/fd/%d", execfd) > 0);
>   	assert(!execve(execpath, argv, envp));
>   }
>   % ./mount-memfd
>   this file was executed from this totally private tmpfs: /proc/self/fd/5
>   %
>=20
> Given that it is possible for CAP_SYS_ADMIN users to create executable
> binaries without memfd_create(2) and without touching the host
> filesystem (not to mention the many other things a CAP_SYS_ADMIN process
> would be able to do that would be equivalent or worse), it seems strange
> to cause a fair amount of headache to admins when there doesn't appear
> to be an actual security benefit to blocking this.
>=20
> It should be noted that with this change, programs that can do an
> unprivileged unshare(CLONE_NEWUSER) would be able to create an
> executable memfd even if their current pidns didn't allow it. However,
> the same sample program above can also be used in this scenario, meaning
> that even with this consideration, blocking CAP_SYS_ADMIN makes little
> sense:
>=20
>   % unshare -rm ./mount-memfd
>   this file was executed from this totally private tmpfs: /proc/self/fd/5
>=20
> This simply further reinforces that locked-down environments need to
> disallow CLONE_NEWUSER for unprivileged users (as is already the case in
> most container environments).
>=20
> [1]: https://lore.kernel.org/all/CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG=
3RmUB5TKHJw@mail.gmail.com/
>=20
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: stable@vger.kernel.org # v6.3+
> Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  kernel/pid_sysctl.h | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
> index b26e027fc9cd..8a22bc29ebb4 100644
> --- a/kernel/pid_sysctl.h
> +++ b/kernel/pid_sysctl.h
> @@ -24,13 +24,6 @@ static int pid_mfd_noexec_dointvec_minmax(struct ctl_t=
able *table,
>  	if (ns !=3D &init_pid_ns)
>  		table_copy.data =3D &ns->memfd_noexec_scope;
> =20
> -	/*
> -	 * set minimum to current value, the effect is only bigger
> -	 * value is accepted.
> -	 */
> -	if (*(int *)table_copy.data > *(int *)table_copy.extra1)
> -		table_copy.extra1 =3D table_copy.data;
> -
>  	return proc_dointvec_minmax(&table_copy, write, buf, lenp, ppos);
>  }

I also have a patch to properly tie the sysctl to the pid namespace
rather that having a global sysctl that magically has its value changed
in this pid_mfd_noexec_dointvec_minmax() and another to do the same for
the other pidns-tied sysctl (kernel.ns_last_pid) but I'm not sure
whether it's needed. It does make vm.memfd_noexec a bit cleaner but
because the two sysctls are in different tables you can't register them
together AFAICS which means a bunch of needless duplication.

> =20
> --=20
> 2.41.0
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--4ubij2xktskdezgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZLCRuQAKCRAol/rSt+lE
bycBAQCsJjBVjXfGnfUjczZi2Uw40z/FGWKZ7Na80SxTTtsRGgEArv1CYjnaQLTR
YVTNeXzuho+Bp3RaPonAbsjEAACsEwM=
=J8sH
-----END PGP SIGNATURE-----

--4ubij2xktskdezgp--
