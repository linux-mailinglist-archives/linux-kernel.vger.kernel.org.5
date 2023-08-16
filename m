Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17E277E21F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbjHPNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245370AbjHPNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:04:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7739D26BA;
        Wed, 16 Aug 2023 06:04:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C08CD75;
        Wed, 16 Aug 2023 06:05:04 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 546F23F6C4;
        Wed, 16 Aug 2023 06:04:20 -0700 (PDT)
Message-ID: <d4bb4680-fbde-00f5-32ca-4e5478f73647@arm.com>
Date:   Wed, 16 Aug 2023 15:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/12] PM: EM: Refactor struct em_perf_domain and add
 default_table
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-7-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721155022.2339982-7-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 17:50, Lukasz Luba wrote:
> The Energy Model is going to support runtime modifications. Refactor old
> implementation which accessed struct em_perf_state and introduce
> em_perf_domain::default_table to clean up the design. This new field
> will help to better distinguish 2 performance state tables.
> 
> Update all drivers or frameworks which used the old field:
> em_perf_domain::table and now should use em_perf_domain::default_table.
> 

This doesn't compile:

  SYNC    include/config/auto.conf.cmd
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CC      arch/arm64/kernel/asm-offsets.s
In file included from ./include/linux/device.h:16,
                 from ./include/linux/acpi.h:14,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
./include/linux/energy_model.h: In function ‘em_cpu_energy’:
./include/linux/energy_model.h:256:10: error: ‘struct em_perf_domain’ has no member named ‘table’
  256 |  ps = &pd->table[pd->nr_perf_states - 1];
      |          ^~
./include/linux/energy_model.h:266:34: error: ‘struct em_perf_domain’ has no member named ‘table’
  266 |  i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
      |                                  ^~
./include/linux/energy_model.h:268:10: error: ‘struct em_perf_domain’ has no member named ‘table’
  268 |  ps = &pd->table[i];
      |          ^~
make[2]: *** [scripts/Makefile.build:116: arch/arm64/kernel/asm-offsets.s] Error 1
make[1]: *** [/opt/git/kernel_org/Makefile:1275: prepare0] Error 2
make: *** [Makefile:234: __sub-make] Error 2

In v2 this patch was much later in the set.



