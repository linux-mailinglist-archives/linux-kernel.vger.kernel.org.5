Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67807A65C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjISNy3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjISNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:54:28 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691783;
        Tue, 19 Sep 2023 06:54:22 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5711d5dac14so1416763eaf.0;
        Tue, 19 Sep 2023 06:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131661; x=1695736461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGZwcNp/BDkTKowBUFhaDEFH4i6kTTCF8Ze198+CeFs=;
        b=Efu8ZKIsTDMNR/N1Lv0RT8Vcl5iQbu6Dl2s+AETx4tzXfHtpYVfHvUUNi1i/R/26yz
         ep/pbjbmunLL/V3fnd0Zu16GyBUuirrPN/taMe6KQbeNSm3XAnfSSG5l4B3sCppKEHEF
         CsGnLokx+ZCZM05iuqoJiMad5DOmQmRLucHcRKAV+9OHVQ1qAUHnHIqd3K729Yo5oMNY
         tqELaF/81UyCnutj7IE6CRPQ0g0HA7kODdb/4Jd4YD+eiFEMizJRo0DM+NcH1hgj8eJv
         NPiWC16b+jUb7BznxStM6pPS30r4j5VCaH0LNZ57VTwF2vnjKgIKY+i9fQQcSrgQE52r
         qNBg==
X-Gm-Message-State: AOJu0Yws7G6dXw3lHdo/9AomrSBqwHZCC3GaRaGQ1jRy/l6ebOBb2p9K
        w7ezPkqmExpLn/FvHJsm71f6MrjZzAEYC4PtejqyVgDz
X-Google-Smtp-Source: AGHT+IFQB7YxuOS88mI54AX4AvOgSEg4or2jItYtcrjeKPDUXY02dmKR/Z7d/TdkCkis8oHfOuq35bTUnaTOZnZphFM=
X-Received: by 2002:a4a:d88d:0:b0:573:2a32:6567 with SMTP id
 b13-20020a4ad88d000000b005732a326567mr11216372oov.0.1695131661262; Tue, 19
 Sep 2023 06:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230913164659.9345-3-sumitg@nvidia.com> <202309140915.2J9OzWIZ-lkp@intel.com>
 <c180c1e9-c15c-b4e2-678a-35a388a4a613@nvidia.com>
In-Reply-To: <c180c1e9-c15c-b4e2-678a-35a388a4a613@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Sep 2023 15:54:09 +0200
Message-ID: <CAJZ5v0iJYb3cAq6VMY8s+AOmuMdCBY9KvshM8rcGnCT-tn8CmQ@mail.gmail.com>
Subject: Re: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     kernel test robot <lkp@intel.com>, rafael@kernel.org,
        rui.zhang@intel.com, lenb@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com,
        bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 1:27 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>
>
>
> > Hi Sumit,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on rafael-pm/linux-next]
> > [also build test WARNING on linus/master v6.6-rc1 next-20230913]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-thermal-Add-Thermal-fast-Sampling-Period-_TFP-support/20230914-004929
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> > patch link:    https://lore.kernel.org/r/20230913164659.9345-3-sumitg%40nvidia.com
> > patch subject: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
> > config: i386-defconfig (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/config)
> > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309140915.2J9OzWIZ-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/acpi/processor_thermal.c:141:6: warning: no previous declaration for 'acpi_thermal_cpufreq_config_nvidia' [-Wmissing-declarations]
> >      void acpi_thermal_cpufreq_config_nvidia(void)
> >           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
>
> Thank you for the report.
> The below change fixes the warning for me.
>
>   -void acpi_thermal_cpufreq_config_nvidia(void)
>   +static void acpi_thermal_cpufreq_config_nvidia(void)
>
>
> Hi Rafael,
> If there is no other comment. Could you please add the change while
> applying or you prefer me sending new version ?

Please update.

Besides, I haven't said that I will apply it without changes yet.

Thanks!
