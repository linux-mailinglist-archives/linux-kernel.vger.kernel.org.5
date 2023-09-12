Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4423E79C7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjILHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjILHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:09:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66BFC4;
        Tue, 12 Sep 2023 00:09:13 -0700 (PDT)
Received: from kwepemd500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RlF5H1z05zrSjt;
        Tue, 12 Sep 2023 15:07:15 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemd500002.china.huawei.com (7.221.188.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 12 Sep 2023 15:09:10 +0800
Subject: Re: [PATCH 11/19] kbuild: rpm-pkg: use a dummy string for _arch when
 undefined
To:     Masahiro Yamada <masahiroy@kernel.org>,
        <linux-kbuild@vger.kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
 <20230722044806.3867434-11-masahiroy@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <4780dc94-653b-7ae4-0f50-45af625726e7@hisilicon.com>
Date:   Tue, 12 Sep 2023 15:09:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20230722044806.3867434-11-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500002.china.huawei.com (7.221.188.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I build the latest kernel (6.6-rc1) for arm64 platform on x86 server 
(with cross complile), and the complile command is as following:

export 
PATH=$PATH:/opt/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

make -j64 Image (ok)

make binrpm-pkg -j64 (failed)

But when complile binrpm-pkg, it is failed and the error info is as 
following:

rpmbuild -bb kernel.spec --define='_topdir 
/home/chenxiang/kernel/mainline/linux-next/rpmbuild' --target 
aarch64-linux --build-in-place --noprep --define='_smp_mflags %{nil}' 
$(rpm -q rpm >/dev/null 2>&1 || echo --nodeps) --without devel
rpmbuild: --build-in-place: unknown option
make[2]: *** [scripts/Makefile.package:92: binrpm-pkg] Error 1
make[1]: *** [/home/chenxiang/kernel/mainline/linux-next/Makefile:1538: 
binrpm-pkg] Error 2
make: *** [Makefile:234: __sub-make] Error 2

But it is ok with v6.5-rc7, so i bisect the kernel code and find the 
patch (kbuild: rpm-pkg: use a dummy string for _arch when undefined):

706a741595047797872e (v6.6-rc1) good
0bb80ecc33a8fb5a6（v6.5-rc7） bad
[461f35f014466c4e26dca6be0f431f57297df3f2] Merge tag 
'drm-next-2023-08-30' of git://anongit.freedesktop.org/drm/drm good
[e925992671907314b7db6793a28eb39b36bc21a4] Merge tag 'staging-6.6-rc1' 
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging good
[3c31041e37324e143bee98604bb31481e905b4b3] Merge tag 'printk-for-6.6' of 
git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux    good
[4a0fc73da97efd23a383ca839e6fe86410268f6b] Merge tag 's390-6.6-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux bad
[61401a8724c2ce912b243ef95427a9b2e5a1ed50] Merge tag 'kbuild-v6.6' of 
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild bad
[2be6bc48df59c99d35aab16a51d4a814e9bb8c35] Merge tag 'leds-next-6.6' of 
git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds        good
[3f86ed6ec0b390c033eae7f9c487a3fea268e027] Merge tag 'arc-6.6-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc good
[4cdb71b6ba3283fb2b7eaccc333f8f2c5b81797b] sparc: replace #include 
<asm/export.h> with #include <linux/export.h> bad
[975667d02d134f7b48d15ee7ff0d49e69a6774cf] kbuild: rpm-pkg: rename 
binkernel.spec to kernel.spec        bad
[a06d9ef897d59f719102e2890abd8a2b91e29a60] kbuild: rpm-pkg: record ARCH 
option in spec file    good
[d5d2d4cc60888f02dd4a6b2bfb03ff2fd7be4fc2] kbuild: rpm-pkg: derive the 
Version from %{KERNELRELEASE}    good
[b537925fdd689ca33b6d9eed4569bc625550b3ef] kbuild: rpm-pkg: run 
modules_install for non-modular kernel    bad
[1789fc9125414bd9ca4d50a8966752ee6103d547] kbuild: rpm-pkg: invoke the 
kernel build from rpmbuild for binrpm-pkg bad
[d4f651277e9208b580b55da212e17ddd309c91e7] kbuild: rpm-pkg: use a dummy 
string for _arch when undefined


Do you have any idea about this issue?


Thanks

Xiang Chen

在 2023/7/22 星期六 12:47, Masahiro Yamada 写道:
> If this affects only %{buildroot}, it should be enough to use a fixed
> string for _arch when it is undefined.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>   scripts/package/mkspec | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 783e1997d94a..22b980cf3d00 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -36,6 +36,8 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>   %define ARCH ${ARCH}
>   %define KERNELRELEASE ${KERNELRELEASE}
>   
> +# _arch is undefined if /usr/lib/rpm/platform/*/macros was not included.
> +%{!?_arch: %define _arch dummy}
>   %{!?make: %define make make}
>   %define makeflags %{?_smp_mflags} ARCH=%{ARCH}
>   
> @@ -55,9 +57,6 @@ $S	BuildRequires: bc binutils bison dwarves
>   $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
>   $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
>   
> -	# $UTS_MACHINE as a fallback of _arch in case
> -	# /usr/lib/rpm/platform/*/macros was not included.
> -	%{!?_arch: %define _arch $UTS_MACHINE}
>   	%define __spec_install_post /usr/lib/rpm/brp-compress || :
>   	%define debug_package %{nil}
>   

