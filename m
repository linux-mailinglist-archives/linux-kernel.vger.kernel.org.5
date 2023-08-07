Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BECC771AAB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjHGGrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHGGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FD1A4;
        Sun,  6 Aug 2023 23:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4463761563;
        Mon,  7 Aug 2023 06:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3A9C433C7;
        Mon,  7 Aug 2023 06:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691390828;
        bh=1jCsoWdlJTQsQF5IZ+gzdQAhBlUO6GA0wb8Hp3Tpm2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdNQrp4B3s23/8MXLecBvUwKr11RDoNkw+A8dWesq8YLdLe2VN7yXzb+3UgkJqak1
         VzzZHLXonZ5s9m3OATYR/eKxHSeULfMwkOcJ6sHXu/bhV0zAdbtbtDD4tYN0Q+jaJL
         M3WOIbagKcjn/NDg2t1jRWutVtrMRgIC/feHCJ7E=
Date:   Mon, 7 Aug 2023 08:47:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jannik Glueckert <jannik.glueckert@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux LLVM Build Support <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: amd-pstate: fix global sysfs attribute type
Message-ID: <2023080748-apprehend-carnation-e71c@gregkh>
References: <20230807-amd-pstate-cfi-v1-1-0263daa13bc3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807-amd-pstate-cfi-v1-1-0263daa13bc3@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:37:45AM +0200, Thomas Weißschuh wrote:
> In commit 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_root()")
> the "amd_pstate" attributes where moved from a dedicated kobject to the
> cpu root kobject.
> While the dedicated kobject expects to contain kobj_attributes the root
> kobject needs device_attributes.
> 
> As the changed arguments are not used by the callbacks it works most of
> the time.
> However CFI will detect this issue:
> 
> [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show_status+0x0/0x70; expected type: 0x8651b1de)
> ...
> [ 4947.849409] Call Trace:
> [ 4947.849410]  <TASK>
> [ 4947.849411]  ? __warn+0xcf/0x1c0
> [ 4947.849414]  ? dev_attr_show+0x24/0x60
> [ 4947.849415]  ? report_cfi_failure+0x4e/0x60
> [ 4947.849417]  ? handle_cfi_failure+0x14c/0x1d0
> [ 4947.849419]  ? __cfi_show_status+0x10/0x10
> [ 4947.849420]  ? handle_bug+0x4f/0x90
> [ 4947.849421]  ? exc_invalid_op+0x1a/0x60
> [ 4947.849422]  ? asm_exc_invalid_op+0x1a/0x20
> [ 4947.849424]  ? __cfi_show_status+0x10/0x10
> [ 4947.849425]  ? dev_attr_show+0x24/0x60
> [ 4947.849426]  sysfs_kf_seq_show+0xa6/0x110
> [ 4947.849433]  seq_read_iter+0x16c/0x4b0
> [ 4947.849436]  vfs_read+0x272/0x2d0
> [ 4947.849438]  ksys_read+0x72/0xe0
> [ 4947.849439]  do_syscall_64+0x76/0xb0
> [ 4947.849440]  ? do_user_addr_fault+0x252/0x650
> [ 4947.849442]  ? exc_page_fault+0x7a/0x1b0
> [ 4947.849443]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Reported-by: Jannik Glückert <jannik.glueckert@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217765
> Link: https://lore.kernel.org/lkml/c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com/
> Fixes: 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_root()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Note:
> 
> This was not tested with CFI as I don't have the toolchain available.
> Jannik, could you give it a spin?

Ah, that was fast, nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
