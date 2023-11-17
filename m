Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476907EEA72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQAqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQAql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:46:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E038182;
        Thu, 16 Nov 2023 16:46:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE8C433C8;
        Fri, 17 Nov 2023 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700181997;
        bh=52vZZ4VMa5VvfSK6bdVL9eIeuQTagBJSJmhIefXMmvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gu0DYQvVWiloU+XZjg1t6aQpHDspYNz9EFsI/JHPaj7asPSduRu33hwihLM4rfnWx
         flBTwoAqD7c+332titbC1ubdj41p+rH1glcBUP43QMF5kfWehlOXnoYWlMS0+bLltH
         1F6ExDac5br/IURc7CKiGjVVDtWbtUhfRQhnhQ5F4fCRWxludqckgEWUK2XdpAf4/h
         SFIPlbBL3ggiIUGD4zuwTK1aUFFEaWVjHB7qzLB42fyKI32PUAcHsKMl94Ggqf24aT
         2mfDiGjpzXrKoEgL4D+OlYHGiXa1q87cK6ZrQW8T40Sei0Nk8wRJ1dJFQL8JxFKzcf
         /vBxqznkIlEOQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso2814111a12.0;
        Thu, 16 Nov 2023 16:46:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yxix1u35d+/pwMyAXOyyowGE3kbDyxaKW7JtfcWnuEGsTU81bLR
        lNXTfxqA+0vwKzeQeGBuRjoFR6/qPVbhhzaHBNQ=
X-Google-Smtp-Source: AGHT+IEwy7rkqpvK5sSI31UXRwIOzu/GaTn7Twr3XZgTgzDxW4cNQ8kR+1DN605eFM+iKOytn+iw9cUWvz9K9XQFr0g=
X-Received: by 2002:a05:6402:2490:b0:544:3ad0:37ad with SMTP id
 q16-20020a056402249000b005443ad037admr4133052eda.3.1700181995418; Thu, 16 Nov
 2023 16:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20231115033350.1228588-1-sashal@kernel.org> <20231115033350.1228588-4-sashal@kernel.org>
 <CAAhV-H61R006eHGN+ujvDqrT_6AYV0XBcSaT2zyVLJi1rR=kMA@mail.gmail.com> <ZVZT27pS16Y7S9wQ@sashalap>
In-Reply-To: <ZVZT27pS16Y7S9wQ@sashalap>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 17 Nov 2023 08:46:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H78xGOBpjOW7K-dQEK3J_dQGMKDSPPET_n2A2cCMGctug@mail.gmail.com>
Message-ID: <CAAhV-H78xGOBpjOW7K-dQEK3J_dQGMKDSPPET_n2A2cCMGctug@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 4/6] LoongArch/smp: Call rcutree_report_cpu_starting()
 earlier
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>, maobibo@loongson.cn,
        palmer@rivosinc.com, yangtiezhu@loongson.cn, wangliupu@loongson.cn,
        jpoimboe@kernel.org, zhoubinbin@loongson.cn,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 1:39=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Wed, Nov 15, 2023 at 11:55:24AM +0800, Huacai Chen wrote:
> >Hi, Sasha,
> >
> >In 6.6 and earlier versions, rcutree_report_cpu_starting() should be
> >rcu_cpu_starting().
>
> I'll drop this one. Happy to apply a backport...
You can simply replace rcutree_report_cpu_starting() with
rcu_cpu_starting(), just one line change. :)

Huacai
>
> --
> Thanks,
> Sasha
