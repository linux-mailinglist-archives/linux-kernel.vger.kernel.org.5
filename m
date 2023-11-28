Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE217FB07A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjK1ChA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1Cg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:36:59 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE118E;
        Mon, 27 Nov 2023 18:37:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so64592521fa.1;
        Mon, 27 Nov 2023 18:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139020; x=1701743820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9DehPb+B0avMQIEahya5tFyVOrTp2O4+WIgAS2v9xk=;
        b=FMO7hcbnv3OCuTYDZhns5/GKavPWFd1M2oUl75oFXByMLXpkpM3+JNzPgoU++MtKei
         2KnzR5DbYk/7e9yBi8OaGI4lnykEz/87OtRyVMNtcf3WxksbrObnFSuf8hsorytie4OT
         UR6dcZcm4uUnRhSxEhIBWq5cjLnib54H990xLUfQtmHoIaLohegVY47Gu/PG3SgSUpJB
         YUvlfkxIK6UxtVXcLpVmR2o4GrE65/oLI930N3aYTi5nkoSzmQm7FE428EV/cKbbNHaC
         Vd6Pic8l9RSVK6Y3mQoABTU2Pe5ieGRHSFQf4ReSUjJ3UnjT+AzBWCVWItAYKsHqStbQ
         SCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139020; x=1701743820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9DehPb+B0avMQIEahya5tFyVOrTp2O4+WIgAS2v9xk=;
        b=n9IF974PAVuEyOSUOjSGN6YQgc24ANBiYThbcRYRbvFm91LTEdLKAtLa6SLchdMy0k
         KwbWvTsyqWQxIQJZUlARyolwJSl8iJMtYws5eKz1HsGsUNtOns/J0NwllM7lC7alCP7s
         ger9nH6vy3FRxpwdhgNq+gmhEne6OVDaj9u4uo4xxlP9Z/czcr1jpHXKgn3yY2w8IJ8C
         am3ar3YsFkrGf+BwYZt0ieshuKzLpfKbyTsHquYnr3zEhVpoMPTr7vvUFAKzCFsdJHr5
         h2yts9JO6Sti+5/b6zUhVfsyMEeuCCQc6Ag0pZwewVRYIfhx54ZbwChaYP/qZlhr+FNl
         b7yA==
X-Gm-Message-State: AOJu0YwVOOUEx7IbkQSSJrgBJijW1V1o1hQT0954Cydaih3JNAKPSL3k
        sKh6WtwfEc/wvUzFJ3VBYX700SnndE0MJsAmvjA=
X-Google-Smtp-Source: AGHT+IF6Md78NIt1A4rE+Nxd2qAgloV2QTWu429Ac/B5IF8drR/zassEwyV2rUGEvSdF/ZuusnjIQKQCbQbZcTWYPGU=
X-Received: by 2002:a2e:9490:0:b0:2c8:71d5:abfb with SMTP id
 c16-20020a2e9490000000b002c871d5abfbmr10288257ljh.43.1701139019479; Mon, 27
 Nov 2023 18:36:59 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
In-Reply-To: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Mon, 27 Nov 2023 21:36:47 -0500
Message-ID: <CABWLseuvzphU7+1BxXnjdbBMbqYzvXH-OSX+2bKi6KMNnFiqcA@mail.gmail.com>
Subject: Re: [Bug Report] bpf: zero access_size of stack causes array indix
 oob in check_stack_range_initialized()
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for another great report, Hao! Will investigate.
