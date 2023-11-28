Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90987FAF66
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjK1BK6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 20:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1BK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:10:56 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C3D135;
        Mon, 27 Nov 2023 17:11:02 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f9decb7446so2459060fac.2;
        Mon, 27 Nov 2023 17:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701133861; x=1701738661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne/1BGfawz38RnpEDcGFX2lcTtrweNNkz2EvVODo1EA=;
        b=dQz0XNEm5qU7FVlNN//Ce7Ti20FNoWWsO6OHeGYDz2vzaqP7b9Jj6Ci0A9GN2Xs1KN
         kbuwJ7pZ5Fqi2PMXJvcMtdywvF1PKXol2MZI+c/jtQaILfG+T0SsajaFDYoVP8+//cN0
         BLyt+AmLK/5SshT2gdISw7ynAEQUUBYalyGyqmgL+cHnhs6NGJBUPsi9a4NnYGpAfmOd
         +sLVoV070z/CzWuLtEIJFsbwQD8RamBScpa1QVritij6zdKFBCvOR1iofOk9z+4dcVd0
         WC1HPMlH0ckyDDHx0fpXC3bvrV93b4yxnQJBdXQuaqNDQ/u/XG/gRQxUiO+iVDY6S4Mv
         1yFw==
X-Gm-Message-State: AOJu0YwROMARTqjxLe6ru+F3ZT5f6NiktbpTJKJ9mOZQCYVP3sVACtgp
        j/Qu3PZ8TrC75bveB24XWMsaTB13gsqUdDhctkBJZ7Np
X-Google-Smtp-Source: AGHT+IFj+A9tDPPZZ1IPR3GhrwcRUxIkAARPbua8/pydDU5x95PxtY53KncURTsCPPPLL6cuSqdeRSt66DasCi1Tqv0=
X-Received: by 2002:a05:6871:5811:b0:1f9:5e2a:ea2d with SMTP id
 oj17-20020a056871581100b001f95e2aea2dmr15726384oac.37.1701133861529; Mon, 27
 Nov 2023 17:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20231022055221.569634-1-yu.c.chen@intel.com>
In-Reply-To: <20231022055221.569634-1-yu.c.chen@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 27 Nov 2023 20:10:50 -0500
Message-ID: <CAJvTdKkFLTzWdU7bssUSJkTW4ocfKcFEu5c+8m=EVNZ44+iXug@mail.gmail.com>
Subject: Re: [RFC PATCH] tools/power turbostat: Do not print negative LPI residency
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS bugs:-(

I agree that printing 0 is an improvement over printing an insane
negative number.

But printing 0 suggests that there was no residency, and that could be
misleading...

Maybe we should output some kind of warning about the broken BIOS?

On Sun, Oct 22, 2023 at 1:53 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> turbostat prints the abnormal SYS%LPI across suspend-to-idle:
> SYS%LPI = 114479815993277.50
>
> This is reproduced by:
> Run a freeze cycle, e.g. "sleepgraph -m freeze -rtcwake 15".
> Then do a reboot. After boot up, launch the suspend-idle-idle
> and check the SYS%LPI field.
>
> The slp_so residence counter is in LPIT table, and BIOS does not
> clears this register across reset. The PMC expects the OS to calculate
> the LPI residency based on the delta. However, there is an firmware
> issue that the LPIT gets cleared to 0 during the second suspend
> to idle after the reboot, which brings negative delta value.
>
> Prints a simple 0 to indicate this error to not confuse the user.
>
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9a10512e3407..3fa5f9a0218a 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1472,8 +1472,16 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
>         old->pc8 = new->pc8 - old->pc8;
>         old->pc9 = new->pc9 - old->pc9;
>         old->pc10 = new->pc10 - old->pc10;
> -       old->cpu_lpi = new->cpu_lpi - old->cpu_lpi;
> -       old->sys_lpi = new->sys_lpi - old->sys_lpi;
> +       if (new->cpu_lpi > old->cpu_lpi) {
> +               old->cpu_lpi = new->cpu_lpi - old->cpu_lpi;
> +       } else {
> +               old->cpu_lpi = 0;
> +       }
> +       if (new->sys_lpi > old->sys_lpi) {
> +               old->sys_lpi = new->sys_lpi - old->sys_lpi;
> +       } else {
> +               old->sys_lpi = 0;
> +       }
>         old->pkg_temp_c = new->pkg_temp_c;
>
>         /* flag an error when rc6 counter resets/wraps */
> --
> 2.25.1
>


-- 
Len Brown, Intel
