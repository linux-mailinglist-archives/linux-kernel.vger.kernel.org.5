Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8D7A4337
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjIRHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbjIRHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:43:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6923B10D5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:41:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so5289453a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695022870; x=1695627670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZHZZX2awisr882TDRE7yqEqi53EXQ6avmbEwdMqX9s=;
        b=NFBWrBWEUJzgExS+sD2gsB3h6enf+75j+0z2GkSnQ5qUHDT7UJTQIGWfJkJ3jYt7Iv
         oAQtdP6A5x7BA2vdGS94j3Xjr5SssZ4PCI7enARI+a3KTiV+naStuoYw5hlwByIWpiZO
         2FZGHNMrh/Wzx7dnTQeDKbeQYumSPyJyWwC9Onl65KrjQsH+P571zRXt3Jp5Y8sHHr9q
         5Bgi/khX6zuqXSEd5FGuFDyx+aiSC0973j458tXTpK8LPCHuSE1V5hEE4aCR6nHkKrEh
         lLEzYrB8LCcZw3X5CNqI7lu49xEQCxBkxYk1+CLVRmpDsr7P6gzzDYozydMizyfT6c2L
         Lkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022870; x=1695627670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZHZZX2awisr882TDRE7yqEqi53EXQ6avmbEwdMqX9s=;
        b=psvH0wHQ3iJQmbwdDZl6I0/uy3BEObvaiGQKxrjs+2sdxnlAJnu/m9VJH1eCqZi1+c
         MNga6oQeNpq7vywmuYB++OHLDqry+U/GbXJcaNwY5PEyKEPk1653bHnylLSaQ9YOD3C6
         pgQgIzwV1UGe2hsUMenbdDYC5Ye61zgGj3qg42PQra/HH7nQyIAjlYghwkYJPV3gdsCz
         imp/wkN23n7dBqEjaQsf4jQ/sHEPfJ4sUQu8Fp2GnGhJ75MSWidtliRoaPLUBC/6qqgP
         qpG12OszMnKrc3L1LWbt91hFDaLMElQKAgueXSLKKSb1GqKKecaA1SgDA0tp8pBBLk83
         +htw==
X-Gm-Message-State: AOJu0YwlTVv97vYPAUuk5ANn7V7RtI3uxhw8T4Sj8jhdp+tdqjybSduF
        megd5DZzUuMdX4ReLEQi1UgG8e1OAHA=
X-Google-Smtp-Source: AGHT+IFaoUVQqyjQWuqkZT4VXInIKqT8gQTri7bRVUw3Z38fAe1T4fXEHlCaZlEZzxJaBQD+60CpiQ==
X-Received: by 2002:a05:6512:3096:b0:4fe:1681:9377 with SMTP id z22-20020a056512309600b004fe16819377mr7580562lfd.44.1695022522580;
        Mon, 18 Sep 2023 00:35:22 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003fe17901fcdsm14424890wmf.32.2023.09.18.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:35:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 18 Sep 2023 09:35:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Brendan Jackman <jackmanb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        laijs@linux.alibaba.com, yosryahmed@google.com, reijiw@google.com,
        oweisse@google.com
Subject: Re: [PATCH RESEND] x86/entry: Don't write to CR3 when restoring to
 kernel CR3
Message-ID: <ZQf9twm6n5vNmwbB@gmail.com>
References: <20230817121513.1382800-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817121513.1382800-1-jackmanb@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Brendan Jackman <jackmanb@google.com> wrote:

> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Skip resuming KERNEL pages since it is already KERNEL CR3
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> 
> While staring at paranoid_exit I was confused about why we had this CR3
> write, avoiding it seems like a free optimisation. The original commit
> 21e94459110252 ("x86/mm: Optimize RESTORE_CR3") says "Most NMI/paranoid
> exceptions will not in fact change pagetables" but I didn't't understand
> what the "most" was referring to. I then discovered this patch on the
> mailing list, Andy said[1] that it looks correct so maybe now is the
> time to merge it?
> 
> Note there's another patch in [1] as well, the benefit of that one is
> not obvious to me though.
> 
> We've tested an equivalent patch in our internal kernel.
> 
> [1] https://lore.kernel.org/lkml/20200526043507.51977-3-laijs@linux.alibaba.com/
> -- >8 --
>  arch/x86/entry/calling.h | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

I concur that this is a good change, but it would be really nice to get an 
ack from Andy or Thomas as well.

Thanks,

	Ingo
