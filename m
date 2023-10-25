Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD07D6C45
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbjJYMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjJYMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:47:09 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47DD181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:47:05 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3575826ba20so94755ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698238025; x=1698842825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJxjqRLgdOTokPI2dBdsj6G6P4onvQmQvzd+w/Pmuro=;
        b=hOFem64/vgX5LavBOq/2LuRISUF2itHIKMYRE8wZEsXK1l17uTcwvP0lnnCjVRJnpw
         /2UiLdBV7ejqSl13fTIZArgZqGJZFnhZCcuaUYtqU6Gpa6BzAByCPJVy5Z8sENoNm2/f
         0MztQPo5M441WU9uDwnQC9rgP7k5kdiqKh2fkVAhJg3Twt8FA7ufxlrAqrQSaj0JsbNz
         EtNsrmQAXZz5vkOIFMrh6QEInBU2QhmTUkih3XlN29cPUkBCY3ba7pDa8MHFFDqdFx4D
         XwJ3EJVxqhI3EFuo1N+TsPf49s7BmNi4R3iJx5a6U8/LD2rn93lzjYUo9IF8wzTUsMut
         Wo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238025; x=1698842825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJxjqRLgdOTokPI2dBdsj6G6P4onvQmQvzd+w/Pmuro=;
        b=kK63BQ4Ha/hzTzKsIH/ntegE4AtMLmsIvy6iW0ABXTLq6zmdTq7bQRyODWefBOfOlu
         3NFENtQL4G2JHGy+47nubSvr5wpSULblN518n20vW4N38vlhIfIibAGbvPNa+lySLjOG
         z1wDYGLaKU2eHAXXevx6HOftgIpRSjgURbPHJchGBR7XHd44Qy//d68QB/SlTVXbwz7w
         /uo7nFolHpiVMVBRTusX5NkvzXK4VKkfpaZC32SKMAjvP+tn5TU/f4iQLaUw7fQSk0b+
         71o+1/DWTR4RofIrwi6rqfOIiPaVmTJZXJVIxDpiWo+xCdpB0CycLPMmkynu1XSGJJVD
         dJ+w==
X-Gm-Message-State: AOJu0Yz4x2EyX8abbjLAEz1RBGOcYJ/FFMY3zzfzwxSBNSmPvmIXG40B
        BW5XYjfcXeJ+fOiD6RAIEostWmLcEmOAlNbeA4RAuw==
X-Google-Smtp-Source: AGHT+IFGpxrkAvVp6+0E7/WqwAn933CD5Xj0OXEGjguHzqWRxId8NLFOVha5htsC5vsrifflo+7QyGx0F73yiS9Alzs=
X-Received: by 2002:a05:6e02:b24:b0:357:cb1a:9621 with SMTP id
 e4-20020a056e020b2400b00357cb1a9621mr218988ilu.10.1698238024990; Wed, 25 Oct
 2023 05:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231024181600.8270-1-tony.luck@intel.com>
In-Reply-To: <20231024181600.8270-1-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 25 Oct 2023 14:46:53 +0200
Message-ID: <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tue, Oct 24, 2023 at 8:16=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -418,6 +418,14 @@ static int __mon_event_count(u32 rmid, struct rmid_r=
ead *rr)
>         return 0;
>  }
>
> +static struct mbm_state *get_mbm_data(struct rdt_domain *dom_mbm, int rm=
id)
> +{
> +       if (is_mbm_local_enabled())
> +               return &dom_mbm->mbm_local[rmid];
> +
> +       return &dom_mbm->mbm_total[rmid];
> +}

That looks very similar to the get_mbm_state() function I added to
this same file recently:

https://lore.kernel.org/all/20221220164132.443083-2-peternewman%40google.co=
m

I think the name you picked is misleadingly general. "local if
available, otherwise total" seems to be a choice specific to the mbps
controller. I think these functions should be reconciled a little
better.

Other than that, looks good.

Reviewed-by: Peter Newman <peternewman@google.com>
