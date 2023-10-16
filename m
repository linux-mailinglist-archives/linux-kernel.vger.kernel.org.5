Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544167CB284
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjJPS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjJPS2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:28:06 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950AF0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:28:04 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1ea4a3d0a44so783225fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697480883; x=1698085683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bm51Bwy2SpdgE6SyKdoP36JXJJ8T1AHayysY044xqt4=;
        b=FLIplMzcfLk8EUEDpYJJGXVzt83IfMpgjDqPezVP74Ml0ni5HtU9m160CngcNFShrY
         TpopDP5PlplCI44xhq2vOiZsgZavZg0A/1DY7YZm0Pz73PppG/OjY4haCky/NdWdvzr6
         z2gXWt8RWyXI80KvRsnF2edxa21FpGlwwGGEiIoUlZJqw0G6+JpPVrbGG6mSxFlsQ/J5
         ijLOaVGmQb/rTYL4GxSoogIOQzgmHUOSl0B+uLs8lHTfk1ZwUi79tt9vT/xE9a6Ow5Pi
         cIgPD/F20y3KnkNbtQd9Ul0RkWX918UmbPhKJi972YjKMlVOwsyk2U03lHfHPg6dpb0y
         Pjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480883; x=1698085683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm51Bwy2SpdgE6SyKdoP36JXJJ8T1AHayysY044xqt4=;
        b=aVP7a6k78CobX6BVIfkvBGzo+6mdABzUaM/DG1MWteYbd9xAj2uIcrbwzP+UXyp6xR
         KlsVaTiw+Dki/o2ZJrgFn04qwwID++uildSd/zIBfXgzrObvU3NL+iOcp37IsHDac5Dj
         kh5V4ZxontAnsylMB8Y/QQPg2P93L2/1HmSnU5bmemICRX9W0/CKVPZJYOIFhXLzvgGC
         AfJlE0BZm2CzxBSTuxSdbgbtIlTItKkwwv4dr0GKUHPxrzwBV5oZwREjK6vuYYzkpyea
         VwpHPv25MHoouoEvLKmNalNVPk56JOPdB5nfaHCpf4z6fSF2r4rTWX/rafx+Y9PysMyg
         7tBg==
X-Gm-Message-State: AOJu0Yx3zoA+nFV1NhvKraDh+cjCqIyVN0Q/eFDBGkAoONAW/Jjdz1pH
        ifeNhbxRUp9iR/rj75aTK/bkH8ts6taezzX9TFX10g==
X-Google-Smtp-Source: AGHT+IH0b3UYP/NwvVPYsP+quIm8KcdipLbFwgA4UjJRziEIlf48UD0ptL99BDxxzAPpnZ9uEYY5I75/pTi4/zQi4DQ=
X-Received: by 2002:a05:6871:e46:b0:1e9:90ec:140 with SMTP id
 vk6-20020a0568710e4600b001e990ec0140mr13011252oab.58.1697480883424; Mon, 16
 Oct 2023 11:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9> <65e98129-0617-49ca-9802-8e3a46d58d29@efficios.com>
In-Reply-To: <65e98129-0617-49ca-9802-8e3a46d58d29@efficios.com>
From:   Robbin Ehn <rehn@rivosinc.com>
Date:   Mon, 16 Oct 2023 20:27:52 +0200
Message-ID: <CAEEvPLAoznHHq9A5CLQgRkqVhtiuyMDYxig1fgWGK0HsxpoQDg@mail.gmail.com>
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, parri.andrea@gmail.com,
        charlie@rivosinc.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But fence.i would only have effects on the hart it is being called from, right ?
> What is the use-case for allowing user-space to issue this instruction ?

Right now openjdk uses flush_icache for every cmodx write. And it does
a lot of cmodx.
If the hardware does not require an IPI/icache flushing we still need
to serialize the reader.
(locally stopping out-of-order execution/speculation at least)
And in some cases the reader knows the code stream has been changed
and can emit fence.i itself instead.
So we want the option to emit fence.i directly into the code stream.

As fence.i is an unpriv instruction there is no issue with emitting it.
But we need the assurance that context switching to a new hart does
not eliminate the effects of the fence.i.

/Robbin

>
> One more thing: membarrier(2) sync_core only issues things like "fence.i" on
> the various cores in the system running threads belonging to the process, but
> does not intend to take care of doing any kind of cache invalidation per se
> (e.g. invalidating an address range worth of cache). On ARM, this is done by a
> separate system call (e.g. cacheflush(2)), or can be done by instructions
> available from userspace in some cases.
>
> Do you expect to have a need for flushing only specific icache lines, or is
> the intent to always flush the entire icache ?
>
> >
> > Charlie is volunteering to do the work here, so hopefully we'll have
> > something moving forward.
>
> That's great! I hope my feedback will help.
>
> Thanks,
>
> Mathieu
>
> >
> >>
> >>   Andrea
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
