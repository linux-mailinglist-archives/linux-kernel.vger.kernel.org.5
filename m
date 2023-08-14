Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312A077BD39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjHNPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjHNPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FEF10D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692027506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ftfZzPPxMX01Gby0U/PiwMfwiI0XDF12P1Ajb3ohqCY=;
        b=FRsGB9ZbvgicJynuOCBsaWwxmw5cA+kkycpUwfksH66GLwF0Casi78KMh0Sosf0c6AZHgf
        F9NyJrmc1cLLQMnK+juxkkDfbkfzPWrD+CnwsGbi5l7J++4DsEefCsiIZhceAfRUj+WuiW
        wFZug4Qld+ClKwIfCxx4TiwdbULO12w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-xzP0RZD_MqWmxh3YqXBfsQ-1; Mon, 14 Aug 2023 11:38:24 -0400
X-MC-Unique: xzP0RZD_MqWmxh3YqXBfsQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-645778904dfso8256136d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027504; x=1692632304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftfZzPPxMX01Gby0U/PiwMfwiI0XDF12P1Ajb3ohqCY=;
        b=WJSYaDBAa9hfOiy9ytma5sJNX0AqcyZO7VoZBxjSLAKO7Ew8e4JDrnl9UqmrvErHq0
         LZhn9zCmKy+yb3vxqmo8FL+ZvtzAwzclhJMdxKXKpeTZtGN1gMyXATAj+Khew5a60+8s
         VH81b/lULqcNzVmQzrmLwTgr7RIEzxrf87A+aSh0NzCLBINiB0By9P/ngdKsF3AvpNXw
         9nlHqJ2RSv35/DjmffUQvM+MTxD2yUxWLhCl8O8dfLomFjG+/MOJsBD89D650D7XeqlF
         WP22b6ao7HdLoQMQxTSmha7IE3xrsFHUYt2Yp7H9i4YUWoENMsXIGarxVhSDVfzcqqZZ
         QOkQ==
X-Gm-Message-State: AOJu0Yy9ic1V2EpT5u35Jshfs5AmAucvaMkxV8MG3UQa/W8JkTIz/9Xb
        CcVK7C5pOGRf4YyMQ4VDt150LrI/2zwzePIOFZ7+S7a0BpY/8O2j5RZEXGl6IQjKuaJRXIcPnU5
        6MlOWLarAb9VezXVtTMrH1xHni340uPtB
X-Received: by 2002:ad4:5f0f:0:b0:625:aa48:e50f with SMTP id fo15-20020ad45f0f000000b00625aa48e50fmr13929596qvb.6.1692027503758;
        Mon, 14 Aug 2023 08:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFACOs0OhCKoORZlOJko4R2FENW1W6OqTr5H/q9L0Y8dHpVVK+fY2mYrwhhPkkNvUWN04cF0w==
X-Received: by 2002:ad4:5f0f:0:b0:625:aa48:e50f with SMTP id fo15-20020ad45f0f000000b00625aa48e50fmr13929579qvb.6.1692027503460;
        Mon, 14 Aug 2023 08:38:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id pc5-20020a05620a840500b00767fbfea21dsm3098480qkn.69.2023.08.14.08.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:38:22 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:38:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: Cannot find symbol for section 69: .text.arch_max_swapfile_size.
Message-ID: <ZNpKaiweCbf9i5QS@x1n>
References: <202308120906.Efohswpa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202308120906.Efohswpa-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:11:33AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   190bf7b14b0cf3df19c059061be032bd8994a597
> commit: be45a4902c7caa717fee6b2f671e59b396ed395c mm/swap: cache maximum swapfile size when init swap
> date:   11 months ago
> config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120906.Efohswpa-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120906.Efohswpa-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308120906.Efohswpa-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> Cannot find symbol for section 69: .text.arch_max_swapfile_size.
>    mm/swapfile.o: failed

Hmm.. I don't really know what's the issue here, neither can I reproduce
this locally - the cross build seems to all work with the reproducer and I
can see mm/swapfile.o correctly generated.

$ wget https://download.01.org/0day-ci/archive/20230812/202308120906.Efohswpa-lkp@intel.com/config
$ mv config .config
$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ./make.cross W=1 O=build_dir ARCH=mips olddefconfig
[...]
$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ./make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
[...]
FIT description: Linux 6.5.0-rc4-00492-gad3232df3e41
Created:         Mon Aug 14 11:35:57 2023
 Image 0 (kernel)
  Description:  Linux 6.5.0-rc4-00492-gad3232df3e41
  Created:      Mon Aug 14 11:35:57 2023
  Type:         Kernel Image
  Compression:  gzip compressed
  Data Size:    1767982 Bytes = 1726.54 KiB = 1.69 MiB
  Architecture: MIPS
  OS:           Linux
  Load Address: 0x80100000
  Entry Point:  0x8043e5f0
  Hash algo:    sha1
  Hash value:   750e28c2fdd0d73eec9b0d8dbf5655579cb1364c
 Default Configuration: 'conf-default'
 Configuration 0 (conf-default)
  Description:  Generic Linux kernel
  Kernel:       kernel
$ file build_dir/mm/swapfile.o 
build_dir/mm/swapfile.o: ELF 32-bit MSB relocatable, MIPS, MIPS32 version 1 (SYSV), not stripped

Please let me now if anyone knows what I'm missing.

-- 
Peter Xu

