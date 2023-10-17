Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38027CC3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbjJQNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjJQNCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:02:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3115BDB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:02:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c2a0725825so389876666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697547750; x=1698152550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yye5FSkZ9L4YYqu9GCTL6x1WAdc6AFySQq6k6hTPYC0=;
        b=IpevMTN+Ol0RpIYKL8T/0PQI+c5U2+a0Td/gDxW4XW2jAsz44YosSibYkSjAolpiOG
         f1qmfaB4crSAj7JSTZkrwLatvI0gct67g3guLYc9S0Tm7qM6k3ND7XA1JFq+v8NLGYQV
         dce57BYOELPeW4AhreJ199UP1Qxi+dGzX03xOA2xtBpqR7VcnCIgLaLxIRuvu+ti8+GU
         Hw0gN3tNOjpE/4eTE4fgsG7DCY+7iDK3D+IQx08mOPV1PEvCVnz4/QT9dzI0Bl7L/aiQ
         hD/tVnEPYA4C0j87lVtpUSADETVT2U2paHkHWNf9fIJzB/ytXI2tvbMchZGcvJKxRPjU
         5a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547750; x=1698152550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yye5FSkZ9L4YYqu9GCTL6x1WAdc6AFySQq6k6hTPYC0=;
        b=f2uBPHiap0m4FTdbIEpCb4Y3gFACNo4scARY3NDqtsNPT1PJ15JhaML7ta1deBsUA5
         0t5pKg3TpaEBLyxHu34AqtI+NH353P9y2nO0AEB1V3oqDLjXDFnMtCQkfB/yKiogsyU7
         T4K5IpiPw8DQf7zHvkvFDV1eZCdDkX87rLXsxfogr5SwBVblnYiARt0SRljMOb90LuCR
         STmuv9lYWPO2jZscoNPc+1hpTUA9tFcnpcXxH3o2WozXebExRy9Fh51nQ6vYogYWcaDk
         XHxFwPFaM+d7y/8pbxkCMS7xCJwI5LZWk6/BmsVbEkIhxj8nuhEdy98LEpoKEuh678F4
         VTSw==
X-Gm-Message-State: AOJu0Yygh5QupV8w0nZISBGNlTxNL4HJScoy9B/j0a3M5J/+bzv4xfuR
        urrhZMYJMc6+JcZB+AlyEIw=
X-Google-Smtp-Source: AGHT+IFFbE/RdmpNvzuZLOc7YOC+gG3zMgT/GyQZCZr+TL0wZax5K5ZsWNdL9fy5TbJe7lVd9lcOXg==
X-Received: by 2002:a17:907:928b:b0:9be:54a9:9b4e with SMTP id bw11-20020a170907928b00b009be54a99b4emr1787819ejc.29.1697547750430;
        Tue, 17 Oct 2023 06:02:30 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id qx1-20020a170906fcc100b009c387ff67bdsm1237916ejb.22.2023.10.17.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:02:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Oct 2023 15:02:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH RFC 1/7] x86/head/64: Mark startup_gdt and
 startup_gdt_descr as __initdata
Message-ID: <ZS6F46vJfca5f6f8@gmail.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
 <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com>
 <ZS0lEmEpQOz4iQ4Q@gmail.com>
 <20231017072311.GA46993@k08j02272.eu95sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017072311.GA46993@k08j02272.eu95sqa>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:

> Hi Ingo,
> 
> I have sent patch #6 separately for x86. Do you have any ideas about 
> building the head code as PIE? Should I resend the patchset for the PIE 
> feature?

So I had a brief look, and despite reading 0/43 it was unclear to me what 
the precise advantages of building as PIE are.

Ie. could you please outline:

 - *Exactly* how much PIE based KASLR randomization would gain us in terms 
   of randomization granularity and effective number of randomization bits, 
   compared to the current status quo?

 - How is code generation changed at the instruction level - how does 
   kernel size change and what are the micro-advantages/disadvantages?

 - Are there any other advantages/motivation than improving KASLR?

Ie. before asking us to apply ~50 patches and add a whole new build mode 
and the maintainance overhead to support it into infinity and beyond, could 
you please offer a better list of pros and cons?

Thanks,

	Ingo
