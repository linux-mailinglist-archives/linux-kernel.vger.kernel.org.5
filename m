Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532937A0C80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbjINSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbjINSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:17:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1530C1FD7;
        Thu, 14 Sep 2023 11:17:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so1231900f8f.2;
        Thu, 14 Sep 2023 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715461; x=1695320261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slgEAK+XoFog52OsY7C5eWDU4QO7+bjpMrPdH4n5j/g=;
        b=jBkVvJPDPeCwON89BeCJ2C8gPNHQo40lZ4q+6QJK2AAQNFgxsTcK8eV4piGFIDeRXh
         gGkn91KfEYv85qdqU0tJEE6bXbvsh8EWM/Mhc/6t3iBm9TWQnPvc+ABjLzn0cyPKw2Sh
         kyUBhc49Mj3gn5OBLUYOBa7pdfr2f/fhPnUdRbv9zt1uoR6f0k/cio0HW0Rk2x9zAOUR
         KGS01A35+aQbsAU6FNev2CFAuYLlk+E4qqSVNbkfhpv5XRXxQ/Gf31RipF4Kc8zypJdd
         z2LoH+rFnpNAr7Qd+CRFhFsIqM63P/GtYYC6IPvUqe44j/I0mLCvWECA6Qhx+avV7hRk
         T2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715461; x=1695320261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slgEAK+XoFog52OsY7C5eWDU4QO7+bjpMrPdH4n5j/g=;
        b=pMc9YU43pLzDMZ+QjOO285i4l8G8JhA9E/t8c3Q5tuvSfng9/EaE1nbga3BnE5Uc5s
         axdilaIGE03ojAikSB+c/wYYnNi6JeFqi9/axu0igAUlJY9FVnIBZWhSvGJHdUWXzKR7
         aVUSTLkNvXnyANw5TXSI3bAh1UGwPuuBTcBgmUCa+eKQrjpNGithmgPErOQU3ToQQXzX
         VBN15pTQeIQat/vmPVz5uIV+hI9OH8y5m3GF8LtP5utKnqo5xsCI8MVbO9lXv7MxBFDL
         YU0/SPOla6HqQpon7HgFyHWSeLdPVCu5IFObQga5G6CZRxWAX1MQgVemgRZkQ9SCKXQS
         kgow==
X-Gm-Message-State: AOJu0YzuyFo8JjlKq8nNvr936Iuj5EmhI6hKIaYvTn53srPU7AtiVDWP
        sHePTUh52SnbQrqwNwAK/arG3uA9daTP+J+UF1OPe+u4/Ak=
X-Google-Smtp-Source: AGHT+IHescFL/juEmVe99nxg45LPqBJUBmV9LSzGNUPX3mQ/Z61pHUW6jN6QvgQxmkHxa8Zup2aqNHQW/QMd/WIHwyM=
X-Received: by 2002:a5d:6a11:0:b0:31f:a256:4bbb with SMTP id
 m17-20020a5d6a11000000b0031fa2564bbbmr4596839wru.71.1694715461194; Thu, 14
 Sep 2023 11:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230914124928.340701-1-asavkov@redhat.com>
In-Reply-To: <20230914124928.340701-1-asavkov@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Sep 2023 11:17:29 -0700
Message-ID: <CAEf4BzaAgSSj7W7S4uX=NormhaG1=ty8XumTRcSSEPd0XC4ocg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip module_fentry_shadow test
 when bpf_testmod is not available
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, vmalik@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 5:49=E2=80=AFAM Artem Savkov <asavkov@redhat.com> w=
rote:
>
> This test relies on bpf_testmod, so skip it if the module is not availabl=
e.
>
> Fixes: aa3d65de4b900 ("bpf/selftests: Test fentry attachment to shadowed =
functions")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.=
c b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> index c7636e18b1ebd..cdd55e5340dec 100644
> --- a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> +++ b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> @@ -61,6 +61,11 @@ void test_module_fentry_shadow(void)
>         int link_fd[2] =3D {};
>         __s32 btf_id[2] =3D {};
>
> +        if (!env.has_testmod) {
> +                test__skip();
> +                return;
> +        }
> +

you used spaces for indentation, please don't do that. It was also
obvious if you looked at patchworks status ([0]). I fixed it up while
applying, but keep this in mind for the future. Thanks.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230914124928.3=
40701-1-asavkov@redhat.com/

>         LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
>                 .expected_attach_type =3D BPF_TRACE_FENTRY,
>         );
> --
> 2.41.0
>
