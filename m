Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60F8115C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442228AbjLMPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442162AbjLMPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960531BC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702479945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoSF5mLh6ImJekJWin/fEZZ5avu/fIAyMfAem2xD4ZY=;
        b=SL6pActWcxxRUtgxvAQguQxJ0RQlu9fEaHgr1XsA78ykAAlfDVwlgG/Sn2BEnMtmVUvewM
        i2GRKeCXKuw7buQil2MiodwDSmyBpRvZtJrf2pvppC4UcGq9OgwQsW7+R/6rmKygX+He0b
        EKCY3ISFohNNXN/BvWjePW90sMYPBCM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-1YHFMdToOke9h_cUxAdlyw-1; Wed, 13 Dec 2023 10:05:41 -0500
X-MC-Unique: 1YHFMdToOke9h_cUxAdlyw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67ee8a447b3so29737296d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479941; x=1703084741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoSF5mLh6ImJekJWin/fEZZ5avu/fIAyMfAem2xD4ZY=;
        b=WSPB0QuQPg8h+R4JW+/ncuc5CCP14ktRJ9dc1T5Oy6F1/m+GGGNwNJwdKMvdbWyH5C
         Binks1hG/s3m0uBU5E6HrlhpYbO/7M69DFtEMzwoxSqD7g+WW7a8J+PBpKpg5QGHyBAq
         nB0Rcq1Ak8EIsBS8B3wgbb+ukiDu4jVope5BYKwkvm0FVV/wPBKGRenXGyMRHgdO0cAM
         kaTPW4EWu7DOrrBjjFhmDPjD1p93r1lusEFYyQd10YvVatfAdtgY+qnFGJ8M8kf25ODt
         mA0tIGQkL5MkelR1UceB0S5c1C5O6UR5pXMBaamSujlLsi/cBj0fbohM0jmlOlCTCfGG
         2EBg==
X-Gm-Message-State: AOJu0YzUiE6kQUkGUXpTtcGeutjQJty6bpl80YaYTEvgNHFVkw4TaM7f
        1p/QlftwtcjVDgoXziATnSxzOs+0w1Iw8mx16pZlQd0MMIu2nMxzFWueobuW1lOxt9C/r/TIuK4
        nJx5A46JxxBSLVssozKmHCzMy
X-Received: by 2002:ad4:5bcf:0:b0:67a:9a3f:e48a with SMTP id t15-20020ad45bcf000000b0067a9a3fe48amr14553540qvt.26.1702479940764;
        Wed, 13 Dec 2023 07:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrU/rRZmEhuTHny/kM8c/XsgJfvUPgXFsHqsWqJ4MkEhNvzeh7aSdIabdhvIGNLMTPrd8ByQ==
X-Received: by 2002:ad4:5bcf:0:b0:67a:9a3f:e48a with SMTP id t15-20020ad45bcf000000b0067a9a3fe48amr14553521qvt.26.1702479940345;
        Wed, 13 Dec 2023 07:05:40 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id cw14-20020ad44dce000000b0067efe92457bsm308091qvb.0.2023.12.13.07.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:05:39 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:05:37 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: pmic_pdcharger_ulog: Search current
 directory for headers
Message-ID: <j35wn3cc6hnlmwy73ufpz7jyfhvfx54ziykmgcmpn64gbadakg@dil2csq63dqc>
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
 <20231205-pmicpdcharger-ulog-fixups-v1-1-71c95162cb84@redhat.com>
 <320864f5-fdd2-4345-a0dd-b97bcf17f473@linaro.org>
 <k77ayy4xwlnghjefvw3yl4aenwyq272pezjaazx65bvdle37et@5fnbae4fxnjz>
 <zwzpbhcb4ggs3kdf72jvjlpe5cpa26vbjs6qw4nyedhcgwcrza@67in3h243yyx>
 <139f9af0-ca6a-4a58-ae18-79ef6fac47e3@linaro.org>
 <cea465e6-ff24-4552-b4f6-a0594ea9ea6c@linaro.org>
 <qwp3lspu2k4awtn36jebslxqqstmtkoey2a2wnh5pstxbqhko5@i3ktuplsnkir>
 <0346d0cf-d5e6-4d74-b563-1ad3ae717701@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0346d0cf-d5e6-4d74-b563-1ad3ae717701@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:23:12AM +0100, Neil Armstrong wrote:
> Hi Andrew,
>=20
> On 12/12/2023 23:21, Andrew Halaney wrote:
> > On Tue, Dec 12, 2023 at 08:21:41PM +0100, Neil Armstrong wrote:
> > > On 12/12/2023 17:52, Neil Armstrong wrote:
> > > > On 12/12/2023 17:15, Andrew Halaney wrote:
> > > > > On Tue, Dec 12, 2023 at 09:54:48AM -0600, Andrew Halaney wrote:
> > > > > > On Tue, Dec 12, 2023 at 04:23:20PM +0100, Neil Armstrong wrote:
> > > > > > > Hi Andrew,
> > > > > > >=20
> > > > > > > On 06/12/2023 00:05, Andrew Halaney wrote:
> > > > > > > > As specified in samples/trace_events/Makefile:
> > > > > > > >=20
> > > > > > > >  =A0=A0=A0=A0=A0 If you include a trace header outside of i=
nclude/trace/events
> > > > > > > >  =A0=A0=A0=A0=A0 then the file that does the #define CREATE=
_TRACE_POINTS must
> > > > > > > >  =A0=A0=A0=A0=A0 have that tracer file in its main search p=
ath. This is because
> > > > > > > >  =A0=A0=A0=A0=A0 define_trace.h will include it, and must b=
e able to find it from
> > > > > > > >  =A0=A0=A0=A0=A0 the include/trace directory.
> > > > > > > >=20
> > > > > > > > Without this the following compilation error is seen:
> > > > > > > >=20
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0 CC=A0=A0=A0=A0=A0 drivers/soc/qcom/p=
mic_pdcharger_ulog.o
> > > > > > > >  =A0=A0=A0=A0=A0 In file included from drivers/soc/qcom/pmi=
c_pdcharger_ulog.h:36,
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
> > > > > > > >  =A0=A0=A0=A0=A0 ./include/trace/define_trace.h:95:42: fata=
l error: ./pmic_pdcharger_ulog.h: No such file or directory
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 95 | #include TRACE_INCLUDE(TRACE=
_INCLUDE_FILE)
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
> > > > > > > >  =A0=A0=A0=A0=A0 compilation terminated.
> > > > > > >=20
> > > > > > > I never experienced such error, and no CI even reported it, c=
an you explain how you got this ?
> > > > > >=20
> > > > > > To be honest, I am unsure why I'm experiencing this (and until =
I saw
> > > > > > another thread about it today I thought maybe I had screwed som=
ething
> > > > > > up!).
> > > > > >=20
> > > > > > I just took it as an opportunity to try and read up on the trac=
ing
> > > > > > infrastructure and sent this series. Definitely no expertise wi=
th the
> > > > > > in's and out's of tracing :)
> > > > > >=20
> > > > > > I'm able to reproduce this on next-20231211:
> > > > > >=20
> > > > > >  =A0=A0=A0=A0 ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stm=
mac-handle-mdio-enodev] % ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- m=
ake mrproper
> > > > > >  =A0=A0=A0=A0 <snip>
> > > > > >  =A0=A0=A0=A0 ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stm=
mac-handle-mdio-enodev] % ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- m=
ake defconfig
> > > > > >  =A0=A0=A0=A0 <snip>
> > > > > >  =A0=A0=A0=A0 *** Default configuration is based on 'defconfig'
> > > > > >  =A0=A0=A0=A0 #
> > > > > >  =A0=A0=A0=A0 # configuration written to .config
> > > > > >  =A0=A0=A0=A0 #
> > > > >=20
> > > > > Realized I missed a step, actually enabling tracing and the drive=
r at
> > > > > play here... but the result is the same.
> > > > >=20
> > > > > Attached is a config where I hit this.
> > > > >=20
> > > > > >  =A0=A0=A0=A0 130 ahalaney@fedora ~/git/linux-next (git)-[b4/b4=
-stmmac-handle-mdio-enodev] % ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gn=
u- make drivers/soc/qcom/pmic_pdcharger_ulog.o
> > > > > >  =A0=A0=A0=A0=A0=A0 HOSTCC=A0 scripts/dtc/dtc.o
> > > > > >  =A0=A0=A0=A0 <snip>
> > > > > >  =A0=A0=A0=A0=A0=A0 CC=A0=A0=A0=A0=A0 drivers/soc/qcom/pmic_pdc=
harger_ulog.o
> > > > > >  =A0=A0=A0=A0 In file included from drivers/soc/qcom/pmic_pdcha=
rger_ulog.h:36,
> > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from drivers/soc/qcom/pmi=
c_pdcharger_ulog.c:15:
> > > > > >  =A0=A0=A0=A0 ./include/trace/define_trace.h:95:42: fatal error=
: ./pmic_pdcharger_ulog.h: No such file or directory
> > > > > >  =A0=A0=A0=A0=A0=A0=A0 95 | #include TRACE_INCLUDE(TRACE_INCLUD=
E_FILE)
> > > > > >  =A0=A0=A0=A0 <snip>
> > > > > >  =A0=A0=A0=A0 2 ahalaney@fedora ~/git/linux-next (git)-[b4/b4-s=
tmmac-handle-mdio-enodev] %
> > > > > >=20
> > > > > > I even tried it in a fedora container with the above build comm=
ands and
> > > > > > the following podman invocation (plus some package installs) an=
d saw the error:
> > > > > >=20
> > > > > >  =A0=A0=A0=A0 podman run -it -v ~/git/linux-next:/linux-next:z =
quay.io/fedora/fedora:latest /bin/bash
> > > > > >=20
> > > > > > So I'm unsure if it's a fedora package version thing (which I'm=
 running on my host)
> > > > > > or something else... Once I saw it was sort of spelled out in t=
he
> > > > > > examples I referenced here I just decided it was something need=
ed
> > > > > > fixing, regardless of why I'm hitting it while others seem ok.
> > > >=20
> > > > Interesting, I don't get the problem with the same tag, same .confi=
g but with gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu
> > > >=20
> > > > I'll try with gcc 13.
> > >=20
> > > Ok tried with ARM's arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-l=
inux-gnu (https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads=
),
> > > and no error, and I even tried with https://mirrors.edge.kernel.org/p=
ub/tools/crosstool/files/bin/x86_64/13.2.0/ and same no error...
> >=20
> > Hmm. I'm unsure what's up. I tried with a debian container and a fresh
> > clone and still saw it :/
> >=20
> > If you want, something like (swap docker for podman if that's your
> > thing): podman run -it debian:latest /bin/bash
> > should let you reproduce after cloning etc.
>=20
> I was able to reproduce it in fedora:latest:
>   CC [M]  drivers/soc/qcom/pmic_pdcharger_ulog.o
> In file included from drivers/soc/qcom/pmic_pdcharger_ulog.h:36,
>                  from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
> ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.=
h: No such file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> and debian:latest:
>   CC [M]  drivers/soc/qcom/pmic_pdcharger_ulog.o
> In file included from drivers/soc/qcom/pmic_pdcharger_ulog.h:36,
>                  from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
> ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.=
h: No such file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
>=20
> But in my build setup I always build of of tree:
>=20
> $ ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make O=3D$PWD/out/ driv=
ers/soc/qcom/pmic_pdcharger_ulog.o
> ...
>   CC      drivers/soc/qcom/pmic_pdcharger_ulog.o
> make[1]: Leaving directory '/linux-next/out'
>=20
> So why building out of tree works ? (likewise all CI builds out of tree)
>=20

Thanks for poking around with that until reproducing!

Out of curiosity I did this to see that the out of tree does -I the current
directory when compiling (-d is probably not the best approach, but it work=
ed):

    # Assume I did this for the failing in tree build as well, to /tmp/in-t=
ree.txt
    # -d was the best thing I could find to make "make" be verbose enough...
    ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev=
] % ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-  make -d O=3D$PWD/out/ =
drivers/soc/qcom/pmic_pdcharger_ulog.o &> /tmp/out-tree.txt
    ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev=
] % grep -e "-I.\S*qcom" /tmp/in-tree.txt                                  =
           :(
    ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev=
] % grep -e "-I.\S*qcom" /tmp/out-tree.txt                                 =
             :(
    set -e;  echo '  CC [M]  drivers/soc/qcom/pmic_pdcharger_ulog.o';   tra=
p 'rm -f drivers/soc/qcom/pmic_pdcharger_ulog.o; trap - HUP; kill -s HUP $$=
' HUP;  trap 'rm -f drivers/soc/qcom/pmic_pdcharger_ulog.o; trap - INT; kil=
l -s INT $$' INT;  trap 'rm -f drivers/soc/qcom/pmic_pdcharger_ulog.o; trap=
 - QUIT; kill -s QUIT $$' QUIT;  trap 'rm -f drivers/soc/qcom/pmic_pdcharge=
r_ulog.o; trap - TERM; kill -s TERM $$' TERM;  trap 'rm -f drivers/soc/qcom=
/pmic_pdcharger_ulog.o; trap - PIPE; kill -s PIPE $$' PIPE; aarch64-linux-g=
nu-gcc -Wp,-MMD,drivers/soc/qcom/.pmic_pdcharger_ulog.o.d -nostdinc -I../ar=
ch/arm64/include -I./arch/arm64/include/generated -I../include -I./include =
-I../arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi -I../inc=
lude/uapi -I./include/generated/uapi -include ../include/linux/compiler-ver=
sion.h -include ../include/linux/kconfig.h -include ../include/linux/compil=
er_types.h -D__KERNEL__ -mlittle-endian -DCC_USING_PATCHABLE_FUNCTION_ENTRY=
 -DKASAN_SHADOW_SCALE_SHIFT=3D -fmacro-prefix-map=3D../=3D -std=3Dgnu11 -fs=
hort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -mgene=
ral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=3D1 -Wno-psabi -mabi=3Dlp64 -fno=
-asynchronous-unwind-tables -fno-unwind-tables -mbranch-protection=3Dpac-re=
t -Wa,-march=3Darmv8.5-a -DARM64_ASM_ARCH=3D'"armv8.5-a"' -DKASAN_SHADOW_SC=
ALE_SHIFT=3D -fno-delete-null-pointer-checks -O2 -fno-allow-store-data-race=
s -fstack-protector-strong -fno-omit-frame-pointer -fno-optimize-sibling-ca=
lls -ftrivial-auto-var-init=3Dzero -fno-stack-clash-protection -fpatchable-=
function-entry=3D4,2 -falign-functions=3D8 -fstrict-flex-arrays=3D3 -fno-st=
rict-overflow -fno-stack-check -fconserve-stack -Wall -Wundef -Werror=3Dimp=
licit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -We=
rror=3Dstrict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-add=
ress -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-prototy=
pes -Wframe-larger-than=3D2048 -Wno-main -Wno-unused-but-set-variable -Wno-=
unused-const-variable -Wno-dangling-pointer -Wvla -Wno-pointer-sign -Wcast-=
function-type -Wstringop-overflow -Wno-array-bounds -Wno-alloc-size-larger-=
than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompatible-=
pointer-types -Werror=3Ddesignated-init -Wenum-conversion -Wno-unused-but-s=
et-variable -Wno-unused-const-variable -Wno-restrict -Wno-packed-not-aligne=
d -Wno-format-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno=
-missing-field-initializers -Wno-type-limits -Wno-shift-negative-value -Wno=
-maybe-uninitialized -Wno-sign-compare -g -mstack-protector-guard=3Dsysreg =
-mstack-protector-guard-reg=3Dsp_el0 -mstack-protector-guard-offset=3D1152 =
-I ../drivers/soc/qcom -I ./drivers/soc/qcom  -DMODULE  -DKBUILD_BASENAME=
=3D'"pmic_pdcharger_ulog"' -DKBUILD_MODNAME=3D'"pmic_pdcharger_ulog"' -D__K=
BUILD_MODNAME=3Dkmod_pmic_pdcharger_ulog -c -o drivers/soc/qcom/pmic_pdchar=
ger_ulog.o ../drivers/soc/qcom/pmic_pdcharger_ulog.c  ; scripts/basic/fixde=
p drivers/soc/qcom/.pmic_pdcharger_ulog.o.d drivers/soc/qcom/pmic_pdcharger=
_ulog.o 'aarch64-linux-gnu-gcc -Wp,-MMD,drivers/soc/qcom/.pmic_pdcharger_ul=
og.o.d -nostdinc -I../arch/arm64/include -I./arch/arm64/include/generated -=
I../include -I./include -I../arch/arm64/include/uapi -I./arch/arm64/include=
/generated/uapi -I../include/uapi -I./include/generated/uapi -include ../in=
clude/linux/compiler-version.h -include ../include/linux/kconfig.h -include=
 ../include/linux/compiler_types.h -D__KERNEL__ -mlittle-endian -DCC_USING_=
PATCHABLE_FUNCTION_ENTRY -DKASAN_SHADOW_SCALE_SHIFT=3D -fmacro-prefix-map=
=3D../=3D -std=3Dgnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -=
fno-strict-aliasing -mgeneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=3D1 -W=
no-psabi -mabi=3Dlp64 -fno-asynchronous-unwind-tables -fno-unwind-tables -m=
branch-protection=3Dpac-ret -Wa,-march=3Darmv8.5-a -DARM64_ASM_ARCH=3D'\''"=
armv8.5-a"'\'' -DKASAN_SHADOW_SCALE_SHIFT=3D -fno-delete-null-pointer-check=
s -O2 -fno-allow-store-data-races -fstack-protector-strong -fno-omit-frame-=
pointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=3Dzero -fno-sta=
ck-clash-protection -fpatchable-function-entry=3D4,2 -falign-functions=3D8 =
-fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -fconserve-s=
tack -Wall -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplic=
it-int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-securi=
ty -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissin=
g-declarations -Wmissing-prototypes -Wframe-larger-than=3D2048 -Wno-main -W=
no-unused-but-set-variable -Wno-unused-const-variable -Wno-dangling-pointer=
 -Wvla -Wno-pointer-sign -Wcast-function-type -Wstringop-overflow -Wno-arra=
y-bounds -Wno-alloc-size-larger-than -Wimplicit-fallthrough=3D5 -Werror=3Dd=
ate-time -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -We=
num-conversion -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno=
-restrict -Wno-packed-not-aligned -Wno-format-overflow -Wno-format-truncati=
on -Wno-stringop-truncation -Wno-missing-field-initializers -Wno-type-limit=
s -Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -g -=
mstack-protector-guard=3Dsysreg -mstack-protector-guard-reg=3Dsp_el0 -mstac=
k-protector-guard-offset=3D1152 -I ../drivers/soc/qcom -I ./drivers/soc/qco=
m  -DMODULE  -DKBUILD_BASENAME=3D'\''"pmic_pdcharger_ulog"'\'' -DKBUILD_MOD=
NAME=3D'\''"pmic_pdcharger_ulog"'\'' -D__KBUILD_MODNAME=3Dkmod_pmic_pdcharg=
er_ulog -c -o drivers/soc/qcom/pmic_pdcharger_ulog.o ../drivers/soc/qcom/pm=
ic_pdcharger_ulog.c  ' > drivers/soc/qcom/.pmic_pdcharger_ulog.o.cmd; rm -f=
 drivers/soc/qcom/.pmic_pdcharger_ulog.o.d
    ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev=
] %

I guess that makes sense, out of tree builds would need to include the local
folder to grab local headers when compiling in the new working directory,
whereas in tree works in the current directory so that's not a necessary
inclusion by default (but is in this case for tracing purposes).

