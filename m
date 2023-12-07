Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6821808DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjLGQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjLGQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:32:24 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D371713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:32:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cec976b197so40704b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701966747; x=1702571547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esUGZflfku9DXDzsKmGJoCZTKHSMJXxpWGFrjWaHjY4=;
        b=qWROFk9j/J7UnhfyVAxPOwxo5RqYWnL+rvqGvUsirU6+vKFgt/d1C/27dMq0TnHd00
         bOgRsrmTETKEMTUyGdNeGArbJIvvMjJw1AOSmw4RanHTGZyZDLRJ5HXVzpw0+bzdJMlS
         oRYy0bpoX9hahRVlJd8T2L60uGPwAm06IplHB5R0S0l/CwXvEdltx3JLdBjz42h3iE2K
         HZpan3qdL081spUht4BIYnEjQi/rbAUd3REpndR8Zo6SSdWH92YSnnHNi6LMFGI4vzDt
         YYCGKdOAwNhsR1Td5CxSdU3ZwEBGS1ocYh8iiPbSDYqN3AQ3jvN88dQmWICiv9c2DyXH
         thkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966747; x=1702571547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esUGZflfku9DXDzsKmGJoCZTKHSMJXxpWGFrjWaHjY4=;
        b=nBRuvfcDaxjeHfPu61NvXdG1F4XIFetIVmcnqNlRUfklQCxcLVtujScLzd582uw8sC
         A0/Xi32R6Nl7wg2FvGeq7XzJHKa0dv4rXwEkKm8tgck+FXVj+i5LLZO7+pZwL3Z460FK
         pEojXjT4Uu4IFMJmc02sK4QLayRqYScMuioOo/BmP989UlguvEDprjo7Ows/ERbS0v1B
         FFQkYag7z3rIXLlayMiMW5kTiXh6Dk+/Di31a7FLySciJbtO++vyfLdcRR6rm6RP6COz
         rCKMxe8STa8iAZSElWxazx65EmRpfi6oGmPOjZlldND+F+TpT7zYbZckrqyW5aJlnkKR
         eKYQ==
X-Gm-Message-State: AOJu0YxuV5IvKlZIKxm+o3W/9stO08LQ4nf4I7+kvCqy49jXwmsUyvxQ
        YThsP6jeJn8SlVqA/EY64MkuQsGTw+EnBpx6OheyyA==
X-Google-Smtp-Source: AGHT+IFRGlSqxD8x8sx2ixDKNV4Bgn8IR2U64KiJftcFvT6EgKZVa+UqCsno0lRD8ozWGx/9wlUkOGkVbuZ2tQQYsT8=
X-Received: by 2002:a05:6a00:a04:b0:6ce:696f:d0f5 with SMTP id
 p4-20020a056a000a0400b006ce696fd0f5mr2936740pfh.31.1701966747287; Thu, 07 Dec
 2023 08:32:27 -0800 (PST)
MIME-Version: 1.0
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
In-Reply-To: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Dec 2023 17:32:15 +0100
Message-ID: <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at runtime
To:     Gianfranco Dutka <gianfranco.dutka@arista.com>
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gianfranco,

+ Adding all scheduler maintainers and few other people that are
working on similar things

On Thu, 7 Dec 2023 at 16:07, Gianfranco Dutka
<gianfranco.dutka@arista.com> wrote:
>
> Good afternoon maintainers and subscribers to the lkml,
>
> I'm a bit new to kernel development but I had a question with respect to =
the kernel parameters: isolcpus, nohz_full, and rcu_nocbs.
>
> Basically the question is this, am I able to modify the three parameters =
I mentioned above at runtime after the kernel has already started/booted? D=
oing some reading online it seems that it=E2=80=99s not possible but I want=
ed to double check with the maintainers if there wasn=E2=80=99t some sort o=
f change in the works that might make it possible. If not, what would be re=
quired to make the change after boot-time through some kind of patch or som=
ething like that? Would that be something that might be valuable upstream?

It's not possible but you can achieve something close with cgroup
although you will still have some housekeeping activities happening in
your partition.

This thread tries to do something similar:
https://lore.kernel.org/lkml/20230804090858.7605-1-rui.zhang@intel.com/



>
> At the moment we are running an application that might see some benefit f=
rom being able to isolate cpus on the fly without having to reboot everythi=
ng every time we want to modify the parameters mentioned above.
>
> Thanks,
> Gianfranco
