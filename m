Return-Path: <linux-kernel+bounces-10386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2005D81D3A3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444F71C21043
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA9C8D2;
	Sat, 23 Dec 2023 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q300wlgk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEBCA56;
	Sat, 23 Dec 2023 10:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96464C433C9;
	Sat, 23 Dec 2023 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703328588;
	bh=FtggtEImPvw95n90Auf9mAwaxwIFRqcgNE0ZubwH2OQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q300wlgkTR1w/FL7QeVaCx3j0La3x0oLRWFSdFh3sJ7gaIue+PjdrSzpSNVnl6v5E
	 BXc3jKfwKTKMmUW8mMNEbOD17Np7N19JSFigwvdrMkxTcsxDi4B2UgxzQFZjLXHnLf
	 VJxcB3nruXwADRhW7vK24z1vTdA2G1gg48OTzkyUpTPZgdVDsb9m25HYaReeJEs3UJ
	 P3UwSmO7QbijA6nqT2LENX/1gDa4WRl0u1lv+OeS37jQURLr0PYJY5r83+SPwt9WoH
	 M2flnXyfC/1Jz5Y6DwPZUx7EQLyqh/n0CtRWmy7dxzJPYJ2DO63g7v9Z3iyVV4zqdm
	 /BYBeyNdwvn2w==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59451ae06c2so643884eaf.0;
        Sat, 23 Dec 2023 02:49:48 -0800 (PST)
X-Gm-Message-State: AOJu0YybfxbGq+3zMQKEg5dmlnijwggukeUaSoGXsEX68OkGxI/sy2If
	sW1ek0RWgRLtc8rbth7xEmU9s588sQ1trz1nquQ=
X-Google-Smtp-Source: AGHT+IE1nIT2imxyMVRTgnb0tT8xk1Nv5lNE+67xixUNc1XD1A/OEhZ4knRjZHssqFH6kezLtv/zO3719u4P1xCbvvU=
X-Received: by 2002:a05:6870:b250:b0:1fb:75c:4016 with SMTP id
 b16-20020a056870b25000b001fb075c4016mr3870732oam.118.1703328587938; Sat, 23
 Dec 2023 02:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-gen_init_cpio-reproducible-v1-1-d40da0b2c15c@arista.com>
In-Reply-To: <20231220-gen_init_cpio-reproducible-v1-1-d40da0b2c15c@arista.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 19:49:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcocw+MtQE3DUoQNyhcWO3dSUDuBCxwTzi7YqdBFpNcw@mail.gmail.com>
Message-ID: <CAK7LNAQcocw+MtQE3DUoQNyhcWO3dSUDuBCxwTzi7YqdBFpNcw@mail.gmail.com>
Subject: Re: [PATCH] gen_init_cpio: Apply mtime supplied by user to all file types
To: Dmitry Safonov <dima@arista.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Baptiste Covolato <baptiste@arista.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Kevin Mitchell <kevmitch@arista.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:33=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Currently gen_init_cpio -d <timestamp> is applied to symlinks,
> directories and special files. These files are created by
> gen_init_cpio from their description. Without <timestamp> option
> current time(NULL) is used. And regular files that go in initramfs
> are created before cpio generation, so their mtime(s) are preserved.
>
> This is usually not an issue as reproducible builds should rebuild
> everything in the distribution, including binaries, configs and whatever
> other regular files may find their way into kernel's initramfs.
>
> On the other hand, gen_initramfs.sh usage claims:
> >       -d <date>      Use date for all file mtime values
>
> Ar Arista initramfs files are managed with version control system
> that preserves mtime. Those are configs, boot parameters, init scripts,
> version files, platform-specific files, probably some others, too.
>
> While it's certainly possible to work this around by copying the file
> into temp directory and adjusting mtime prior to gen_init_cpio call,
> I don't see why it needs workarounds.
>
> The intended user of -d <date> option is the one that needs to create
> a reproducible build, see commit a8b8017c34fe ("initramfs: Use
> KBUILD_BUILD_TIMESTAMP for generated entries"). If a user wants
> the build reproduction, they use -d <date>, which can be set on all
> types of files, without surprising exceptions and workarounds.
> Let's KISS here and just apply the time that user specified
> with -d option.
>
> Based-on-a-patch-by: Baptiste Covolato <baptiste@arista.com>
> Link: https://lore.kernel.org/lkml/20181025215133.20138-1-baptiste@arista=
.com/
> Signed-off-by: Dmitry Safonov <dima@arista.com>



Applied to linux-kbuild.
Thanks.


> ---
>  usr/gen_init_cpio.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index 61230532fef1..edcdb8abfa31 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -27,6 +27,7 @@
>  static unsigned int offset;
>  static unsigned int ino =3D 721;
>  static time_t default_mtime;
> +static bool do_file_mtime;
>  static bool do_csum =3D false;
>
>  struct file_handler {
> @@ -329,6 +330,7 @@ static int cpio_mkfile(const char *name, const char *=
location,
>         int file;
>         int retval;
>         int rc =3D -1;
> +       time_t mtime;
>         int namesize;
>         unsigned int i;
>         uint32_t csum =3D 0;
> @@ -347,16 +349,21 @@ static int cpio_mkfile(const char *name, const char=
 *location,
>                 goto error;
>         }
>
> -       if (buf.st_mtime > 0xffffffff) {
> -               fprintf(stderr, "%s: Timestamp exceeds maximum cpio times=
tamp, clipping.\n",
> -                       location);
> -               buf.st_mtime =3D 0xffffffff;
> -       }
> +       if (do_file_mtime) {
> +               mtime =3D default_mtime;
> +       } else {
> +               mtime =3D buf.st_mtime;
> +               if (mtime > 0xffffffff) {
> +                       fprintf(stderr, "%s: Timestamp exceeds maximum cp=
io timestamp, clipping.\n",
> +                                       location);
> +                       mtime =3D 0xffffffff;
> +               }
>
> -       if (buf.st_mtime < 0) {
> -               fprintf(stderr, "%s: Timestamp negative, clipping.\n",
> -                       location);
> -               buf.st_mtime =3D 0;
> +               if (mtime < 0) {
> +                       fprintf(stderr, "%s: Timestamp negative, clipping=
.\n",
> +                                       location);
> +                       mtime =3D 0;
> +               }
>         }
>
>         if (buf.st_size > 0xffffffff) {
> @@ -387,7 +394,7 @@ static int cpio_mkfile(const char *name, const char *=
location,
>                         (long) uid,             /* uid */
>                         (long) gid,             /* gid */
>                         nlinks,                 /* nlink */
> -                       (long) buf.st_mtime,    /* mtime */
> +                       (long) mtime,           /* mtime */
>                         size,                   /* filesize */
>                         3,                      /* major */
>                         1,                      /* minor */
> @@ -536,8 +543,9 @@ static void usage(const char *prog)
>                 "file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0\n"
>                 "\n"
>                 "<timestamp> is time in seconds since Epoch that will be =
used\n"
> -               "as mtime for symlinks, special files and directories. Th=
e default\n"
> -               "is to use the current time for these entries.\n"
> +               "as mtime for symlinks, directories, regular and special =
files.\n"
> +               "The default is to use the current time for all files, bu=
t\n"
> +               "preserve modification time for regular files.\n"
>                 "-c: calculate and store 32-bit checksums for file data.\=
n",
>                 prog);
>  }
> @@ -594,6 +602,7 @@ int main (int argc, char *argv[])
>                                 usage(argv[0]);
>                                 exit(1);
>                         }
> +                       do_file_mtime =3D true;
>                         break;
>                 case 'c':
>                         do_csum =3D true;
>
> ---
> base-commit: 55cb5f43689d7a9ea5bf35ef050f12334f197347
> change-id: 20231219-gen_init_cpio-reproducible-99c707d8e66c
>
> Best regards,
> --
> Dmitry Safonov <dima@arista.com>
>


--=20
Best Regards
Masahiro Yamada

