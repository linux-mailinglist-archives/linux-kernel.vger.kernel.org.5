Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B76771860
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjHGCfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGCfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028DA7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAAF261316
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6AFC433CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691375743;
        bh=qJXxuldYf6v3Y5q+RX+QwMkxvthbEddeTfNL/SI+3jU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tQoA2LmTHKJYb96f/bJu42Nf76hls7noQq43VLiW0SwbYgYGX0OuqREbIcbUi2iMi
         vFDdR0UE9q+jkmebfjZ3qa4LABvpyJjJaQpkgZ14g9ACexmigoybnXey9PsRwfp710
         Gfls/DUIiJe/Qb6TBPdJUhSa5yAvAA/FysoMizUTIzKhHjXRPYnVjj9DK2AXxnfD+y
         lftWIukQjF8H4Fcz7wfqnUTOrQMd0ICe53BC0tOyMXv4jSdsSkkEDnDH+AdUzsKSD9
         dtJikVJnIKUTlNoR0XtU9HJjuBH5AVrm+HqMVcmx+HnTJSavs7EOxOt4yry+mMVp+3
         9keH5/WRg8R1g==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3a77ddccb2bso1507551b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 19:35:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwSnSS7YybNIEDyyIB6+fwvogrvFUzIrACfv0xFQGxNQa0+PgQv
        QXTI9I10lV+IL8T/RV+lp7CZGhiBSZ/a6gBoRGM=
X-Google-Smtp-Source: AGHT+IH+M28iSBOoMSh5FQJJ3y6wYF4HeVHwNGeVdHXSlCXtLStiHiV3E7rbHsetd1nl3JoczNEwZ2+OWSK0w+u6hwE=
X-Received: by 2002:a05:6808:13cc:b0:3a7:5638:10f0 with SMTP id
 d12-20020a05680813cc00b003a7563810f0mr5183257oiw.19.1691375742304; Sun, 06
 Aug 2023 19:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230623145358.568971-1-yesshedi@gmail.com> <20230623145358.568971-3-yesshedi@gmail.com>
In-Reply-To: <20230623145358.568971-3-yesshedi@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 7 Aug 2023 11:35:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPVv99Vzxt2M=FO6OOaBvs+DyZS2rni+-DLEPbAGGoFQ@mail.gmail.com>
Message-ID: <CAK7LNATPVv99Vzxt2M=FO6OOaBvs+DyZS2rni+-DLEPbAGGoFQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] sign-file: inntroduce few new flags to make
 argument processing easy.
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:54=E2=80=AFPM Shreenidhi Shedi <yesshedi@gmail.c=
om> wrote:
>
> - Add some more options like help, x509, hashalgo to command line args
> - This makes it easy to handle and use command line args wherever needed
>
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> ---
>  scripts/sign-file.c | 63 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 94228865b6cc..b0f340ea629b 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -215,6 +215,11 @@ static X509 *read_x509(const char *x509_name)
>
>  struct cmd_opts {
>         char *raw_sig_name;
> +       char *hash_algo;
> +       char *dest_name;
> +       char *private_key_name;
> +       char *x509_name;
> +       char *module_name;
>         bool save_sig;
>         bool replace_orig;
>         bool raw_sig;
> @@ -233,6 +238,12 @@ static void parse_args(int argc, char **argv, struct=
 cmd_opts *opts)
>  #ifndef USE_PKCS7
>                 {"usekeyid",    no_argument,        0,  'k'},
>  #endif
> +               {"help",        no_argument,        0,  'h'},
> +               {"privkey",     required_argument,  0,  'i'},
> +               {"hashalgo",    required_argument,  0,  'a'},
> +               {"x509",        required_argument,  0,  'x'},
> +               {"dest",        required_argument,  0,  'd'},
> +               {"replaceorig", required_argument,  0,  'r'},
>                 {0, 0, 0, 0}
>         };
>
> @@ -241,10 +252,10 @@ static void parse_args(int argc, char **argv, struc=
t cmd_opts *opts)
>
>         do {
>  #ifndef USE_PKCS7
> -               opt =3D getopt_long_only(argc, argv, "pds:",
> +               opt =3D getopt_long_only(argc, argv, "hpds:i:a:x:t:r:",
>                                 cmd_options, &opt_index);
>  #else
> -               opt =3D getopt_long_only(argc, argv, "pdks:",
> +               opt =3D getopt_long_only(argc, argv, "hpdks:i:a:x:t:r:",
>                                 cmd_options, &opt_index);
>  #endif
>                 switch (opt) {
> @@ -268,6 +279,30 @@ static void parse_args(int argc, char **argv, struct=
 cmd_opts *opts)
>                         break;
>  #endif
>
> +               case 'h':
> +                       format();
> +                       break;
> +
> +               case 'i':
> +                       opts->private_key_name =3D optarg;
> +                       break;
> +
> +               case 'a':
> +                       opts->hash_algo =3D optarg;
> +                       break;
> +
> +               case 'x':
> +                       opts->x509_name =3D optarg;
> +                       break;
> +
> +               case 't':
> +                       opts->dest_name =3D optarg;
> +                       break;
> +
> +               case 'r':
> +                       opts->replace_orig =3D true;
> +                       break;
> +
>                 case -1:
>                         break;
>
> @@ -281,9 +316,6 @@ static void parse_args(int argc, char **argv, struct =
cmd_opts *opts)
>  int main(int argc, char **argv)
>  {
>         struct module_signature sig_info =3D { .id_type =3D PKEY_ID_PKCS7=
 };
> -       char *hash_algo =3D NULL;
> -       char *private_key_name =3D NULL;
> -       char *x509_name, *module_name, *dest_name;
>         unsigned char buf[4096];
>         unsigned long module_size, sig_size;
>         unsigned int use_signed_attrs;
> @@ -315,32 +347,27 @@ int main(int argc, char **argv)
>         argv +=3D optind;
>
>         const char *raw_sig_name =3D opts.raw_sig_name;
> +       const char *hash_algo =3D opts.hash_algo;
> +       const char *private_key_name =3D opts.private_key_name;
> +       const char *x509_name =3D opts.x509_name;
> +       const char *module_name =3D opts.module_name;
>         const bool save_sig =3D opts.save_sig;
>         const bool raw_sig =3D opts.raw_sig;
>         const bool sign_only =3D opts.sign_only;
>         bool replace_orig =3D opts.replace_orig;
> +       char *dest_name =3D opts.dest_name;
>  #ifndef USE_PKCS7
>         const unsigned int use_keyid =3D opts.use_keyid;
>  #endif
>
> -       if (argc < 4 || argc > 5)
> +       if (!argv[0] || argc !=3D 1)
>                 format();



You are breaking the bisect'ability.

You are turning the positional parameters into options
but not adjusting scripts/Makefile.modinst in the same commit.





masahiro@oscar:~/ref/linux((HEAD detached at 41cb7c94595d))$ make
INSTALL_MOD_PATH=3D/tmp/modules  modules_install
  INSTALL /tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/po=
wer.ko
  SIGN    /tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/po=
wer.ko
Usage: scripts/sign-file [OPTIONS]... [MODULE]...
Available options:
-h, --help             Print this help message and exit

Optional args:
-s, --rawsig <sig>     Raw signature
-p, --savesig          Save signature
-d, --signonly         Sign only
-k, --usekeyid         Use key ID
-b, --bulksign         Sign modules in bulk
-r, --replaceorig      Replace original
-t, --dest <dest>      Destination path (Exclusive with bulk option)

Mandatory args:
-i, --privkey <key>    Private key
-a, --hashalgo <alg>   Hash algorithm
-x, --x509 <x509>      X509

Examples:

    Regular signing:
     scripts/sign-file -a sha512 -i certs/signing_key.pem -x
certs/signing_key.x509 <module>

    Signing with destination path:
     scripts/sign-file -a sha512 -i certs/signing_key.pem -x
certs/signing_key.x509 <module> -t <path>

    Signing modules in bulk:
     scripts/sign-file -a sha512 -i certs/signing_key.pem -x
certs/signing_key.x509 -b <module1> <module2> ...
make[2]: *** [scripts/Makefile.modinst:87:
/tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/power.ko]
Error 2
make[2]: *** Deleting file
'/tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/power.ko'
make[1]: *** [/home/masahiro/ref/linux/Makefile:1964: modules_install] Erro=
r 2
make: *** [Makefile:234: __sub-make] Error 2










--
Best Regards
Masahiro Yamada
