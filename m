Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E455179EC44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbjIMPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjIMPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:14:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E18BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:14:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-770ef4d36f2so305284485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694618084; x=1695222884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX2gyTfQT4O4RDgos1LqqzYheqSwS8qq7SfcfXDWthY=;
        b=VAbWruNj0I6gD2PACRUbN/vCgUJw4er9jjJMcUIOo+2am+TxTWEvYoqDsAOe1p8GmZ
         QS4FQacRGa2umWkJCrN7aMV3gmGWXOi1zpn7SnCZwIb663SA2iCXk8IhkhdIbVb/8Zvh
         EtiQoEaYx3irY/X0IGxWG3S98/g/c67bO0kWjFr86nWbjjVvOst4p5f52yH0NF+Vwp8G
         D1fH6YaBAF7Tesm3VIy9pThQWzbmVu5X9kcg50/l9NusOOheMG2MSG9jyQJlZ27gnXd4
         CflCkA2fP9IKB7PcOC2xVQgPGOg+0XX8L0A3aN+3xYvCt/Ujtbg6JEnf7TK3E6Tb0akT
         wchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618084; x=1695222884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX2gyTfQT4O4RDgos1LqqzYheqSwS8qq7SfcfXDWthY=;
        b=eGI7kRzZ7IwK2encOZHeI0FtE4U2ot1midxCCHf0vj41LMv2u2xvsScFThV8Ci+yts
         2SIfUw1pHspOIaC1hlBKJtRZsIEWJcIeKxZ7/xr3jFIL7NzcjJ7V8wsXLlfqbWogsgJy
         7myzPdNFTWR6v7JQeUayaMTWhfYfMTsz3QihCNYfoTjswHVGtUmhrbpkGlt/PXuQX0OY
         Z12beitH7B6khikR4e3uso08uElATWPzN8Pc3p8xhqhZCalCSr2X3DhyDlKR9S9oOIJM
         KcgQgA06Cwo36CGhGCRgQK5BjaYD//p/WNfgKj/L6usqNYWE2zRD53ghrwk1VYWUjtTh
         KteQ==
X-Gm-Message-State: AOJu0Yx/b7f5MPW019/tN2six37dfcr0J0Y0v0mieAeabKMJgQ69XiOP
        VHmsptJ8Y9JTYVWF5MQrIvsUsw82FQQHoQQh+LAvyQ==
X-Google-Smtp-Source: AGHT+IFsHqst3GwQZXJXAQcIy0+TNzFpKqmlSpLT7CnI4HztrQDdjzD1iwqyMMSfkJZYvG7zAuG3Th7x0fuuA+nDYvc=
X-Received: by 2002:a05:6214:519a:b0:64f:6c68:4463 with SMTP id
 kl26-20020a056214519a00b0064f6c684463mr3491132qvb.11.1694618083633; Wed, 13
 Sep 2023 08:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <202309131848.CgiiHpZu-lkp@intel.com> <20230913114631.2966-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20230913114631.2966-1-guojinhui.liam@bytedance.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Sep 2023 08:14:28 -0700
Message-ID: <CAKwvOdktDE4pG3n+Z=nKSyhDuR6U6OWOYWJ1r5R1w4ukwJYqXg@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: set numa_node before platform_add_device()
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     lkp@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 4:46=E2=80=AFAM Jinhui Guo <guojinhui.liam@bytedanc=
e.com> wrote:
>
> > Hi guojinhui.liam,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v6.6-rc1 next-20230913]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/guojinhui-liam/d=
river-core-platform-set-numa_node-before-platform_add_device/20230912-15111=
9
> > base:   linus/master
> > patch link:    https://lore.kernel.org/r/20230912070900.1862-1-guojinhu=
i.liam%40bytedance.com
> > patch subject: [PATCH] driver core: platform: set numa_node before plat=
form_add_device()
> > config: um-allyesconfig (https://download.01.org/0day-ci/archive/202309=
13/202309131848.CgiiHpZu-lkp@intel.com/config)
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.gi=
t f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20230913/202309131848.CgiiHpZu-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309131848.CgiiHpZu-l=
kp@intel.com/
> > ...
>
> Is there anyone known how to stop this test for my first patch? I have se=
nt a new one to review, which fixes the compile bug.

Then it's ok to either ignore the report, or do as you did and say "I
sent a V+1." Doesn't hurt to have a link to the next revision on lore
if you are to reply.

kbuild test robot will test each patch sent to LKML; it might not stop
ongoing tests if a V+1 is sent.

>
> thanks,
>
> Jinhui Guo
>


--=20
Thanks,
~Nick Desaulniers
