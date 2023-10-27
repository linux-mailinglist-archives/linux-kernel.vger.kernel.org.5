Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB007D97DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjJ0MXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0MXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:23:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532AEFA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:23:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cd566d8dfso304631cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698409384; x=1699014184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iqGvN31QMgS/WE6R9TnV8U7elzS7sYZgvAhoqmNovxw=;
        b=mND/Hp34GOfmiN9zzzO0OT0W0nUFHpan4sL8uD2BFr131jcCmit1StwfLERybrSe41
         HhnMWH3cRkJd8j5/LI50NOQpMRJT+bSzS/txZXa+/lo4MXO3iI0926O8alqBqlF/tFtb
         vjqXTRvwvRhBvhCb2Un5zEhnihPLbRLdI7WloiVV/LwumrKlB6531tTuCfVtsL6yFmc4
         pwNOb4T80EJtSM3DpUaVTpDyVWagXD0uGqmoypYvMwAS0YSklFRvg/EyyjXSTaU3Wk34
         wmU1IzFbkXHbqYgb2hxTlixg7a1YVA8wNSrXSfitXNbVtSac/RQA6yn95grL0biIhRdX
         niCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698409384; x=1699014184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqGvN31QMgS/WE6R9TnV8U7elzS7sYZgvAhoqmNovxw=;
        b=aCSMFDn9lUJUk0jZClAXYOOEWoKJEr1LtVAVAllFAAcjRMenerOFghqcQaIMAgIXfY
         NQIRIkcUpK3SNyd2EbZtR1jMreHX+JoEMYo02+6LKqYe+Ufl3oHOnLLVaODfKvAa1QqM
         upAP5eQnZ4F+txIo9LE9o2dD1HE2IG+xnfB8T6z3JZ9vQP0/TELpkK5r8cHz1riTsqqK
         nNhlmE03xni0YA3XPwv9zWuNOlb0Tcjw6lSntSb8Ut+VFfNeMEx7SjGG07SOU31xg7EB
         T19SdWAsz61LlCqFYT2Ts415n21FBz5i7tH1fA5sEd684g1XlFOQ1uZf480bpAaRk/cs
         UCaA==
X-Gm-Message-State: AOJu0YzmAGlIfXZyaAX72Q8T6E/g9Y1PzPSNTjJrcrs6NS7KV13ppA6b
        skc3/imbzNIieAJ/dldU9KiTBrQ5fQQH/kZnYJANZ84rydjJC/s0H/o=
X-Google-Smtp-Source: AGHT+IF5ivCGWmxdtZn07o9nUqsYy498P5ekFRXRCDKLwLO8+tBImfDDHVjAUMWLfAuKJi0yHYpl39LO9eUJgFg2HJE=
X-Received: by 2002:a05:622a:7619:b0:41e:3699:388c with SMTP id
 kg25-20020a05622a761900b0041e3699388cmr247776qtb.2.1698409384311; Fri, 27 Oct
 2023 05:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230920150443.1789000-1-jackmanb@google.com>
In-Reply-To: <20230920150443.1789000-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Fri, 27 Oct 2023 14:22:53 +0200
Message-ID: <CA+i-1C29rULUPSKNtnnydqEh47KMhLHJw5EbLBJXo=mTvPK-xQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/entry: Avoid redundant CR3 write on paranoid returns
To:     luto@kernel.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        laijs@linux.alibaba.com, yosryahmed@google.com, reijiw@google.com,
        oweisse@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, others, any thoughts on this one?
