Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057F8772DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHGSg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjHGSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A189919A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31DCF62101
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B393C433CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691433376;
        bh=x+9shEnFgT9asbnDHeTcP7gNn7aM/1DmzixkT3zbbC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Anmgxl/Fx7HEN3j+xksubCW7bNIBoz1Y+AbvDIzHnspA9CIhfXyzdY4XM5uE3Ex88
         3fejhVDkdNkOc4hJ6JrcUhNRNfb4stId0MeMKqkcAyzjI3XKJm5ER5jj8FEJYK0+Bj
         eF9igsH8yEU4ceVlUW54ZsXKEtMPt8OIMZSwWPlzrgsXB5ghEgDb6fjyUylwQlQaGR
         J5Vq4y8D1FE8GyAljFkiJq/pnmaccB/F8vJjra7jtVfzQ9yKw+Nk9S3ydEvoEqBVQk
         K+3Kd6WwhOF/ftJRt5KC+ioz5CHa8SMdn46zZk/BuEz8X5ojHvzJqDDeB9zXtx7sRS
         3eehs15M6J/1Q==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6bb07d274feso3950214a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:36:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDL1HJp4vrpx2GpcNxZuG3nfVKZTPOOAiHNWNtXmKSJUaYF6rO
        HQNs5u+2TcOiNlZfNf4XrmzVBvDIs1G4Go4evv8=
X-Google-Smtp-Source: AGHT+IF1Q0TtfxmyXbnTUSy+Pznt7LAa+8JitTwCf7HNyqEzFv9YIjhrmS+Jesz/HayAez5ofYjfL8d47xqadjpWaLI=
X-Received: by 2002:a05:6870:8a0c:b0:1bf:5d1a:41f5 with SMTP id
 p12-20020a0568708a0c00b001bf5d1a41f5mr12266504oaq.26.1691433375768; Mon, 07
 Aug 2023 11:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230321193341.87997-1-sshedi@vmware.com> <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh> <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
 <2023053148-ahead-overbite-863d@gregkh> <730c8712-1553-63e5-ffa1-d75a922f4a42@gmail.com>
 <2023060155-mustard-mating-32b7@gregkh> <CAK7LNASUmc1nFEkEvmd9VKbD6VjOs2HhpwLY-GsduRFDFGOfvg@mail.gmail.com>
 <8d20e867-1c13-4d2a-9802-b9570085fd25@gmail.com>
In-Reply-To: <8d20e867-1c13-4d2a-9802-b9570085fd25@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Aug 2023 03:35:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATNRchNoj0Y6sdb+_81xwV3kAX57-w5q2zew-q8RyzJVg@mail.gmail.com>
Message-ID: <CAK7LNATNRchNoj0Y6sdb+_81xwV3kAX57-w5q2zew-q8RyzJVg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] refactor file signing program
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, dhowells@redhat.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        sshedi@vmware.com
Content-Type: multipart/mixed; boundary="000000000000863e1406025985ae"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000863e1406025985ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 7, 2023 at 5:17=E2=80=AFPM Shreenidhi Shedi <yesshedi@gmail.com=
> wrote:
>
> On 07/08/23 07:53, Masahiro Yamada wrote:
> > On Thu, Jun 1, 2023 at 6:08=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> >>
> >> On Thu, Jun 01, 2023 at 02:33:23PM +0530, Shreenidhi Shedi wrote:
> >>> On Wed, 31-May-2023 22:20, Greg KH wrote:
> >>>> On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
> >>>>> On Wed, 31-May-2023 20:08, Greg KH wrote:
> >>>>>> On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
> >>>>>>> On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
> >>>>>>> Can you please review the latest patch series? I think I have add=
ressed your
> >>>>>>> concerns. Thanks.
> >>>>>>
> >>>>>> The big question is, "who is going to use these new features"?  Th=
is
> >>>>>> tool is only used by the in-kernel build scripts, and if they do n=
ot
> >>>>>> take advantage of these new options you have added, why are they n=
eeded?
> >>>>>>
> >>>>>> thanks,
> >>>>>>
> >>>>>> greg k-h
> >>>>>
> >>>>> Hi Greg,
> >>>>>
> >>>>> Thanks for the response.
> >>>>>
> >>>>> We use it in VMware Photon OS. Following is the link for the same.
> >>>>> https://github.com/vmware/photon/blob/master/SPECS/linux/spec_insta=
ll_post.inc#L4
> >>>>>
> >>>>> If this change goes in, it will give a slight push to our build per=
formance.
> >>>>
> >>>> What exactly do you mean by "slight push"?
> >>>
> >>> Instead of invoking the signing tool binary for each module, we can p=
ass
> >>> modules in bulk and it will reduce the build time by couple of second=
s.
> >>
> >> Then why not modify the in-kernel build system to also do this, allowi=
ng
> >> everyone to save time and money (i.e. energy)?
> >>
> >> Why keep the build savings to yourself?
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> >
> > If I understand correctly,
> > "sign-file: add support to sign modules in bulk"
> > is the only benefit in the patchset.
> >
> > I tested the bulk option, but I did not see build savings.
> >
> >
> >
> > My evaluation:
> > 1.  'make allmodconfig all', then 'make modules_install'.
> >          (9476 modules installed)
> >
> > 2.  I ran 'perf stat' for single signing vs bulk signing
> >        (5 runs for each).
> >        I changed the -n option in scripts/signfile.sh
> >
> >
> >
> >
> > A.  single sign
> >
> > Sign one module per scripts/sign-file invocation.
> >
> > find "${MODULES_PATH}" -name *.ko -type f -print0 | \
> >          xargs -r -0 -P$(nproc) -x -n1 sh -c "..."
> >
> >
> >
> >   Performance counter stats for './signfile-single.sh' (5 runs):
> >
> >               22.33 +- 2.26 seconds time elapsed  ( +- 10.12% )
> >
> >
> >
> >
> > B. bulk sign
> >
> > Sign 32 modules per scripts/sign-file invocation
> >
> > find "${MODULES_PATH}" -name *.ko -type f -print0 | \
> >          xargs -r -0 -P$(nproc) -x -n32 sh -c "..."
> >
> >
> >   Performance counter stats for './signfile-bulk.sh' (5 runs):
> >
> >               24.78 +- 3.01 seconds time elapsed  ( +- 12.14% )
> >
> >
> >
> >
> > The bulk option decreases the process forks of scripts/sign-file
> > but I did not get even "slight push".
> >
> >
> >
>
> That's some really interesting data. I'm surprised that with stand alone
> run bulk signing is not performing as expected. Can you give the full
> command you used for bulk sign?

Attached.


> Reduced number of forks should
> eventually lead to getting more done in less time.

Not necessarily.

You sign 32 modules per thread.

Assume you have 4 CPUs and 160 modules to sign.
For simplicity, assume every module takes the same time to sign.


[Sign 32 modules per 1 process]

CPU0: <=3DSign 32 mods=3D><=3DSign 32 mods=3D> Finish
CPU1: <=3DSign 32 mods=3D><=3D=3D=3D=3D Idle =3D=3D=3D=3D>
CPU2: <=3DSign 32 mods=3D><=3D=3D=3D=3D Idle =3D=3D=3D=3D>
CPU3: <=3DSign 32 mods=3D><=3D=3D=3D=3D Idle =3D=3D=3D=3D>


[Sign 1 modules per 1 process]

CPU0: <=3D=3D=3DSign 40 mods=3D=3D=3D> Finish
CPU1: <=3D=3D=3DSign 40 mods=3D=3D=3D>
CPU2: <=3D=3D=3DSign 40 mods=3D=3D=3D>
CPU3: <=3D=3D=3DSign 40 mods=3D=3D=3D>



In your approach, if CPU0 eats the last 32 modules
from the command line, the other CPUs end up
just waiting for CPU0 to complete the task.



The more CPUs you have, the more idle CPUs
at the last portion of the signing stage.



Do not try to save such a small cost of process forking.

Leave the task scheduling to GNU Make.





>
> But I got ~1.4 seconds boost when I did "make module_install".
>
> I gave the data in my other response as well. Copying the same here
> because this has in better context.
>
> root@ph5dev:~/linux-6.3.5 # ./test.sh orig
>
> real    0m14.699s
> user    0m55.519s
> sys     0m9.036s
>
> root@ph5dev:~/linux-6.3.5 # ./test.sh new
>
> real    0m13.327s
> user    0m46.885s
> sys     0m6.770s
>
> Here is my test script.
> ```
> #!/bin/bash
>
> set -e
>
> if [ "$1" !=3D "new" ] && [ "$1" !=3D "orig" ]; then
>     echo "invalid arg, ($0 [orig|new])" >&2
>     exit 1
> fi
>
> rm -rf $PWD/tmp
>
> s=3D"scripts/sign-file.c"
> m=3D"scripts/Makefile.modinst"
> fns=3D($s $m)
>
> for f in ${fns[@]}; do
>       cp $f.$1 $f
> done
>
> cd scripts
> gcc -o sign-file sign-file.c -lcrypto
> cd -
>
> time make modules_install INSTALL_MOD_PATH=3D$PWD/tmp -s -j$(nproc)
> ```


Just in case, I followed your
'time make modules_install'  measurement.
allmodconfig based on the mainline.



[Setup]

masahiro@oscar:~$ nproc
24
masahiro@oscar:~$ for ((cpu=3D0; cpu<$(nproc); cpu++)); do sudo sh -c
"echo performance >
/sys/devices/system/cpu/cpu${cpu}/cpufreq/scaling_governor"; done



[Mainline  (3 runs)]

masahiro@oscar:~/ref/linux(master)$ git log -1 --oneline
0108963f14e9 (HEAD -> master, origin/master, origin/HEAD) Merge tag
'v6.5-rc5.vfs.fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
masahiro@oscar:~/ref/linux(master)$ make -s -j24
masahiro@oscar:~/ref/linux(master)$ wc modules.order
  9476   9476 314661 modules.order
masahiro@oscar:~/ref/linux(master)$ rm -rf /tmp/modules; sudo sh -c
"echo 1 > /proc/sys/vm/drop_caches"; time make -s -j24
INSTALL_MOD_PATH=3D/tmp/modules modules_install

real 0m21.743s
user 1m49.849s
sys 0m18.345s
masahiro@oscar:~/ref/linux(master)$ rm -rf /tmp/modules; sudo sh -c
"echo 1 > /proc/sys/vm/drop_caches"; time make -s -j24
INSTALL_MOD_PATH=3D/tmp/modules modules_install

real 0m22.246s
user 1m49.303s
sys 0m18.390s
masahiro@oscar:~/ref/linux(master)$ rm -rf /tmp/modules; sudo sh -c
"echo 1 > /proc/sys/vm/drop_caches"; time make -s -j24
INSTALL_MOD_PATH=3D/tmp/modules modules_install

real 0m28.210s
user 1m46.584s
sys 0m17.678s


[Mainline + your patch set (3 runs)]

masahiro@oscar:~/ref/linux(sig-file)$ git log -9 --oneline
7c95522599c5 (HEAD -> sig-file) kbuild: modinst: do modules_install step by=
 step
1cc212890d9a sign-file: fix do while styling issue
0f9c5c01d378 sign-file: use const with a global string constant
6ddc845c5976 sign-file: improve help message
4573855b7e90 sign-file: add support to sign modules in bulk
f9f0c2c4200c sign-file: move file signing logic to its own function
41cb7c94595d sign-file: inntroduce few new flags to make argument
processing easy.
af85d6eaa481 sign-file: use getopt_long_only for parsing input args
0108963f14e9 (origin/master, origin/HEAD, master) Merge tag
'v6.5-rc5.vfs.fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
masahiro@oscar:~/ref/linux(sig-file)$ make -s -j24
masahiro@oscar:~/ref/linux(sig-file)$ wc modules.order
  9476   9476 314661 modules.order
masahiro@oscar:~/ref/linux(sig-file)$ rm -rf /tmp/modules; sudo sh -c
"echo 1 > /proc/sys/vm/drop_caches"; time make -s -j24
INSTALL_MOD_PATH=3D/tmp/modules modules_install

real 0m25.931s
user 1m40.787s
sys 0m8.390s
masahiro@oscar:~/ref/linux(sig-file)$ rm -rf /tmp/modules; sudo sh -c
"echo 1 > /proc/sys/vm/drop_caches"; time make -s -j24
INSTALL_MOD_PATH=3D/tmp/modules modules_install

real 0m33.393s
user 1m41.782s
sys 0m8.390s
masahiro@oscar:~/ref/linux(sig-file)$ rm -rf /tmp/modules; sudo sh -c
"echo 1 > /proc/sys/vm/drop_caches"; time make -s -j24
INSTALL_MOD_PATH=3D/tmp/modules modules_install

real 0m26.311s
user 1m39.205s
sys 0m8.196s



With your apprach, 'sys' is much shorter,
presumably due to less number of process forks.

But, 'real' is not attractive.


--
Best Regards
Masahiro Yamada

--000000000000863e1406025985ae
Content-Type: application/x-shellscript; name="signfile-single.sh"
Content-Disposition: attachment; filename="signfile-single.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_ll17qbpr1>
X-Attachment-Id: f_ll17qbpr1

IyEvYmluL3NoCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIwojIEEgc2lnbi1m
aWxlIHdyYXBwZXIgdXNlZCBieSBzY3JpcHRzL01ha2VmaWxlLnNpZ24KCiNzZXQgLXgKCgpTSUdf
SEFTSD1zaGExClNJR19LRVk9Y2VydHMvc2lnbmluZ19rZXkucGVtCgpNT0RVTEVTX1BBVEg9L3Rt
cC9tb2R1bGVzCgpmaW5kICIke01PRFVMRVNfUEFUSH0iIC1uYW1lICoua28gLXR5cGUgZiAtcHJp
bnQwIHwgXAogICAgeGFyZ3MgLXIgLTAgLVAkKG5wcm9jKSAteCAtbjEgc2ggLWMgIlwKc2NyaXB0
cy9zaWduLWZpbGUgXAotYSBcIiR7U0lHX0hBU0h9XCIgXAotaSBcIiR7U0lHX0tFWX1cIiBcCi14
IGNlcnRzL3NpZ25pbmdfa2V5Lng1MDkgXAotYiBcJEAgXCQwIgo=
--000000000000863e1406025985ae
Content-Type: application/x-shellscript; name="signfile-bulk.sh"
Content-Disposition: attachment; filename="signfile-bulk.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_ll17qbpc0>
X-Attachment-Id: f_ll17qbpc0

IyEvYmluL3NoCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIwojIEEgc2lnbi1m
aWxlIHdyYXBwZXIgdXNlZCBieSBzY3JpcHRzL01ha2VmaWxlLnNpZ24KCiNzZXQgLXgKCgpTSUdf
SEFTSD1zaGExClNJR19LRVk9Y2VydHMvc2lnbmluZ19rZXkucGVtCgpNT0RVTEVTX1BBVEg9L3Rt
cC9tb2R1bGVzCgpmaW5kICIke01PRFVMRVNfUEFUSH0iIC1uYW1lICoua28gLXR5cGUgZiAtcHJp
bnQwIHwgXAogICAgeGFyZ3MgLXIgLTAgLVAkKG5wcm9jKSAteCAtbjMyIHNoIC1jICJcCnNjcmlw
dHMvc2lnbi1maWxlIFwKLWEgXCIke1NJR19IQVNIfVwiIFwKLWkgXCIke1NJR19LRVl9XCIgXAot
eCBjZXJ0cy9zaWduaW5nX2tleS54NTA5IFwKLWIgXCRAIFwkMCIK
--000000000000863e1406025985ae--
