Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27692811D90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379216AbjLMSyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLMSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:54:15 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619F0B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:54:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf7bc38c0so8298478e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702493658; x=1703098458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NDCS9UOfkoQCbKbgKYdSPqJONg4+Gm4jJWLPZJwATro=;
        b=D8JQWI3p3d3siPDBfFmFRj8zB1ioaEMzRdTmvD7xwQ0chlEh1gyofZ86nYu4wQGtwX
         g1KQ5IsrEl8q7LScJSU1M1unCxfltqY8JiInqVxPAgEN//1xowHGXwWiYMx61TpLG487
         r2BN2sBTituCpy4yEJxUNV8j+Wi1heNr51ZJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493658; x=1703098458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDCS9UOfkoQCbKbgKYdSPqJONg4+Gm4jJWLPZJwATro=;
        b=QpYM/zO/TABkEv/2LI/Dl+SCurONO7EUF5fsF9D1PeYX+xzEBxswU4jRD8QAWwDH8c
         B1Y37Yb7OND9r+JRVuykw44spUIJ5TOZJZb86D8GpsN4pxxVU1LV51F+NqThfop0pnPd
         RZNsrAG0Zu9eo0i2uUttXrAWCk2/WcvquLl/LvdxNSh07LL4M/qZ46FenFfBRtKhEGvR
         yolET+mxxrb4NFcxAxxjmX8d6vwsD30+sY4/pVWdS/CkVD8uC/0ZHyTKEWMs2DrbneoX
         eDV5Q1kCiXJU2mOUlRh6erPDwKpe0LKvheEZZqeoQcgZma3xkJdMrc3w/ff5VfGIlony
         MxcQ==
X-Gm-Message-State: AOJu0YxYSSvUtRs3s3rGYM9sFnlLY0fpe40Hc9RLZfEo6QaezAS268wv
        s/huDeyAUn0bpxd9T43jIUgN6c9gZC68cv+f0JmfPW30
X-Google-Smtp-Source: AGHT+IE1LECKo984YZzQxU+7eE1z9SMZqTmErHQtj49/2OphmUL/NwpBkrrtaaXoVTs78jJXuSWeKg==
X-Received: by 2002:a05:6512:398a:b0:50d:fb24:1224 with SMTP id j10-20020a056512398a00b0050dfb241224mr3709484lfu.129.1702493658247;
        Wed, 13 Dec 2023 10:54:18 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id o20-20020a17090611d400b00a0d02cfa48bsm8213743eja.213.2023.12.13.10.54.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:54:17 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55193d5e8cdso2615338a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:54:17 -0800 (PST)
X-Received: by 2002:a05:6402:2227:b0:547:9f26:e581 with SMTP id
 cr7-20020a056402222700b005479f26e581mr4033634edb.37.1702493657276; Wed, 13
 Dec 2023 10:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-4-brgerst@gmail.com>
In-Reply-To: <20231213163443.70490-4-brgerst@gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Dec 2023 10:54:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXt7QZV+HDA8=PN1pTBSNTL0ZJrcqtc4af=FtJpjPQeQ@mail.gmail.com>
Message-ID: <CAHk-=whXt7QZV+HDA8=PN1pTBSNTL0ZJrcqtc4af=FtJpjPQeQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sigreturn: Reject system segements
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 08:34, Brian Gerst <brgerst@gmail.com> wrote:
>
> @@ -98,7 +98,11 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
>
>         /* Get CS/SS and force CPL3 */
>         regs->cs = sc.cs | 0x03;
> +       if (!valid_user_selector(regs->cs))
> +               return false;
>         regs->ss = sc.ss | 0x03;
> +       if (!valid_user_selector(regs->ss))
> +               return false;

Side note: the SS/CS checks could be stricter than the usual selector tests.

In particular, normal segments can be Null segments. But CS/SS must not be.

Also, since you're now checking the validity, maybe we shouldn't do
the "force cpl3" any more, and just make it an error to try to load a
non-cpl3 segment at sigreturn..

That forcing was literally just because we weren't checking it for sanity...

           Linus
