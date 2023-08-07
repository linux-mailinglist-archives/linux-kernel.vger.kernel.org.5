Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA60772623
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjHGNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjHGNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:40:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01491998
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:40:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A458A21A55;
        Mon,  7 Aug 2023 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691415586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bu2FwulHZx7QrlPUtPr+4/23UfCuGmE3RZHxfHgraXk=;
        b=h4aSk6zQSFwd4WqNHA7O40bKLTkOAk/W/YXd3lyrFruCTN7+kDGpLltiOqwfVxFJKblSbP
        saOpwSVaFDJqJdLuOl1nRzJb2d+c8/ZMeRlFgkAX5nSLpOoSY97y0CSTLN6IhxjU/G9siU
        9XZasVjcTAD0Ggx6YOmcPsmWMF1Y4Oo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2EAB02C142;
        Mon,  7 Aug 2023 13:39:46 +0000 (UTC)
Date:   Mon, 7 Aug 2023 15:39:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] watchdog/hardlockup: Avoid large stack frames in
 watchdog_hardlockup_check()
Message-ID: <ZND0HuR2aUt_vd3D@alley>
References: <20230804065935.v4.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
 <20230804065935.v4.2.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804065935.v4.2.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-08-04 07:00:43, Douglas Anderson wrote:
> After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to
> watchdog_hardlockup_check()") we started storing a `struct cpumask` on
> the stack in watchdog_hardlockup_check(). On systems with
> CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
> triggers warnings with `CONFIG_FRAME_WARN` set to 1024.
> 
> We'll use the new trigger_allbutcpu_cpu_backtrace() to avoid needing
> to use a CPU mask at all.
> 
> Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
