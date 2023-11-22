Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4E7F3FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjKVIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjKVIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC51198
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700640958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRmfIAx9MaydzWmtQDZrPT7gVmfLVISSD73kQtcsaEk=;
        b=Wa7rAYtU1qfNRKSSq9u1/IshLLY+rFqLSAFJmxXzbUi60t7ReljZ8QddXC766pF8++K8v3
        1MyvScgp32Nd81FTHPoqDaMotb6nezDwb4275qqOQOXnURDLASqycoehoeG0d3S3fytDYp
        FHw1hivD/nDVAJ8A9Wi7TZN9jX/1bDQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-PLOQjbJWPeucXQYiNR9v1w-1; Wed, 22 Nov 2023 03:15:56 -0500
X-MC-Unique: PLOQjbJWPeucXQYiNR9v1w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a03389a0307so21649366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700640955; x=1701245755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRmfIAx9MaydzWmtQDZrPT7gVmfLVISSD73kQtcsaEk=;
        b=uQUm9fnOCY0xIxsA0jWvJdCzP7kIrGaHIXFcHtQx+jkNFBlzHgntIVQUmRy0SmMtjt
         s3/yaJwCkurbndEPloSxU4SGppGNrJ3IhaW5gO34KzvHz+HfbvO3Gn+fCxI2jMUEFIGb
         PAfyGEQTuTqYmUCcbjN9HvZsmSHta28DRM+DSxZlxFHF5ws4LZZ8skF5ko6w+C0EnvxW
         o3dAWltnvqrRF3nftqjuJjO1oO14LL3Vn/CCVuDlalvc0GmzkIueyj+xBE6KS4DYVJOE
         xxywM/igc1V+wB7mF/1OABJqckiJdwoIDz2lLLbcB8YtOehVtVkmMOGxzZWLXofS/QZu
         ZRyg==
X-Gm-Message-State: AOJu0YxhRPj8TesXmrduQsl/hTA11MAigPQ9OHL23/WXVl4Qat6lspxd
        q69d2/60lM5OouXzFR3k+D85P3IybX7slaBJLKVid/tkeXHsevcbs1lAQUMg/hTDRS2bRXqgoVC
        IS+zXYvdBQKBRngy/mWLVZK0C
X-Received: by 2002:a17:906:ce:b0:9ae:50de:1aaf with SMTP id 14-20020a17090600ce00b009ae50de1aafmr725896eji.4.1700640955008;
        Wed, 22 Nov 2023 00:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiUZWGroCNriOzsL9jf8A18P1e27Cekr39FceTxV7W9j8VXU/13OQNsgXhBVeL6d6QbzamhA==
X-Received: by 2002:a17:906:ce:b0:9ae:50de:1aaf with SMTP id 14-20020a17090600ce00b009ae50de1aafmr725862eji.4.1700640954570;
        Wed, 22 Nov 2023 00:15:54 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32f5:ce00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906354800b0099ddc81903asm6300601eja.221.2023.11.22.00.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:15:54 -0800 (PST)
Message-ID: <9828583bcb49e1adeaa9ac16204b2ad80bd77d4d.camel@redhat.com>
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
From:   Philipp Stanner <pstanner@redhat.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>, lkp <lkp@intel.com>,
        "kmo@daterainc.com" <kmo@daterainc.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "arnd@kernel.org" <arnd@kernel.org>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "dakr@redhat.com" <dakr@redhat.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "sanpeqf@gmail.com" <sanpeqf@gmail.com>,
        "wuqiang.matt@bytedance.com" <wuqiang.matt@bytedance.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "paul@pgazz.com" <paul@pgazz.com>,
        "fazilyildiran@gmail.com" <fazilyildiran@gmail.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Nov 2023 09:15:52 +0100
In-Reply-To: <02aebbffd1b70820648c93efa1003df321b3b19b.camel@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
         <202311212316.a0awwkaE-lkp@intel.com>
         <02aebbffd1b70820648c93efa1003df321b3b19b.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-22 at 01:51 +0000, Liu, Yujie wrote:
> Please kindly ignore these duplicate reports. There seems to be a bug
> in the robot and we will fix this ASAP. Sorry for the noise.

They are not exactly duplicates, I think. You notice that by the mails'
bottoms:

Mail N:
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=3Dn]
     Selected by [y]:
     - SPARC [=3Dy]

Mail N-1:
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=3Dn]
     Selected by [y]:
     - PARISC [=3Dy]

etc...

So it seems to me that it's testing all the architectures and then
sends an email for each one where the build fails.

P.

>=20
> On Tue, 2023-11-21 at 23:56 +0800, kernel test robot wrote:
> > Hi Philipp,
> >=20
> > kernel test robot noticed the following build warnings:
> >=20
> > [auto build test WARNING on pci/next]
> > [also build test WARNING on pci/for-linus linus/master v6.7-rc2
> > next-
> > 20231121]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >=20
> > url:=C2=A0=C2=A0=C2=A0
> > https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-move=
-pci_iomap-c-to-drivers-pci/20231121-060258
> > base:=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git=C2=A0next
> > patch link:=C2=A0=C2=A0=C2=A0
> > https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40redhat.com
> > patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
> > config: sparc64-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_SPARC-0-0
> > (
> > https://download.01.org/0day-ci/archive/20231121/202311212316.a0awwk
> > aE-lkp@intel.com/config)
> > reproduce:
> > (
> > https://download.01.org/0day-ci/archive/20231121/202311212316.a0awwk
> > aE-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a
> > new
> > version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202311212316.a0awwkaE-lkp@intel=
.com/
> >=20
> > kismet warnings: (new ones prefixed by >>)
> > > > kismet: WARNING: unmet direct dependencies detected for
> > > > GENERIC_PCI_IOMAP when selected by SPARC
> > =C2=A0=C2=A0 /usr/bin/grep: /db/releases/20231121182703/kernel-
> > tests/etc/kcflags: No such file or directory
> > =C2=A0=C2=A0 {"timestamp":"2023-11-21 22:16:15 +0800", "level":"WARN",
> > "event":"kbuild.sh:3942:in `add_etc_kcflags': grep exit 2
> > (ShellError)", "detail":"cmd: '/usr/bin/grep' '-v' '-e' '^#' '-e'
> > '^$' '/db/releases/20231121182703/kernel-tests/etc/kcflags'
> > \nstderr:
> > /usr/bin/grep: /db/releases/20231121182703/kernel-
> > tests/etc/kcflags:
> > No such file or directory\n\n", "hostname":"community-kbuild-
> > consumer-123", "host_hostname":"lkp-worker50",
> > "call_stack":"/zday/kernel-tests/lib/kbuild.sh:3942:in
> > `add_etc_kcflags': /usr/bin/grep:
> > /db/releases/20231121182703/kernel-
> > tests/etc/kcflags: No such file or directory (ShellError 2)\n=C2=A0 fro=
m
> > /zday/kernel-tests/lib/kbuild.sh:3971: setup_kcflags\n=C2=A0 from
> > /zday/kernel-tests/lib/kbuild.sh:4016: invoke_make\n=C2=A0 from
> > /zday/kernel-tests/lib/kbuild.sh:4122: make\n=C2=A0 from /zday/kernel-
> > tests/lib/kbuild.sh:5623: make_config_allyes\n=C2=A0 from /zday/kernel-
> > tests/common.sh:209: redirect_error_to_screen\n=C2=A0 from /zday/kernel=
-
> > tests/common.sh:217: redirect_command_errors\n=C2=A0 from /zday/kernel-
> > tests/lib/kbuild.sh:5630: make_config\n=C2=A0 from /zday/kernel-
> > tests/lib/builder/kismet.sh:156:
> > generate_make_olddefconfig_warnings\n=C2=A0 from /zday/kernel-
> > tests/lib/builder/kismet.sh:297: builder_compile\n=C2=A0 from
> > /zday/kernel-tests/bisect-test-build-error.sh:94: main\n"}
> > =C2=A0=C2=A0=20
> > =C2=A0=C2=A0 WARNING: unmet direct dependencies detected for
> > GENERIC_PCI_IOMAP
> > =C2=A0=C2=A0=C2=A0=C2=A0 Depends on [n]: PCI [=3Dn]
> > =C2=A0=C2=A0=C2=A0=C2=A0 Selected by [y]:
> > =C2=A0=C2=A0=C2=A0=C2=A0 - SPARC [=3Dy]
> >=20
>=20

