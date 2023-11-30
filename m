Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27AB7FFE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377073AbjK3WAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377048AbjK3WAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:00:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A915172D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:15 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5be30d543c4so1111057a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381614; x=1701986414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3oJFeliwcGWQRUno3CXq/iefN/z87FyQUWuXF3JGq8=;
        b=KVIcu+K7OlsXPkwye8g/BYKLJlKr8R+30mNOdPdoXYIea5Z1sRJykikZYdQfMYjaOf
         u/iJGPPuQPCz1hMizQzgoxlG2mZuqK8MGYj2laJMa3aIOxqqeU05Fiwjl4zM0/ZkQmQi
         hcEGgFdi224y5/1uzm9Vk3cMSiywhUOJh5UX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381614; x=1701986414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3oJFeliwcGWQRUno3CXq/iefN/z87FyQUWuXF3JGq8=;
        b=oQ2znEEvWRTbWpO11x75g4ckPC83MOgkdmUC96oqh6tr9sSsEAuvHc3stkQdzIVDDe
         C07+VaBwqlAjHnzE691qstEpiT/wlcjIcI3yufp9eUnHjBeAecakF3LzTWZhbyxLKLVv
         PchviafNK1bPc6DMrNtDe5pXysnlq0GT8+v38kqrrnCOEx+ntJDBnL7OeeD/9z+Ns091
         rf728PpXGaRqn8GLg5S7I8SMdItOuRLc7l8Kjg+FndfysuI68zIG089d2jtvhoWp8xTk
         K3Bfd2z9qCeu/bxOr00Oxi8Fkm2ZX+cDFcBTPotsCzhQFbzYArrLpW3Q/wqKSSz9oy7n
         pbOg==
X-Gm-Message-State: AOJu0YzziJHU3Dx+sFpq2WpDB+xM+DRdeJDKDdEd8AdqwCytgmQ+kJTu
        cNXZGyu4o9qTEhSx3AdfC5HMnw==
X-Google-Smtp-Source: AGHT+IHXj/e2zptmeZA5+AQNZP+QCtXebes1TXUPHkf0woeufQzAqe9Ylzhwe1YtCnXulknD2ks53A==
X-Received: by 2002:a05:6a20:e123:b0:18b:fde7:71ac with SMTP id kr35-20020a056a20e12300b0018bfde771acmr23958783pzb.60.1701381614459;
        Thu, 30 Nov 2023 14:00:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b00690ca4356f1sm1699814pfo.198.2023.11.30.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:14 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] VMCI: Annotate struct vmci_handle_arr with __counted_by
Date:   Thu, 30 Nov 2023 14:00:09 -0800
Message-Id: <170138160625.3648908.9493256732138039199.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <56bef519d982218176b59bbba64a3a308d8733d5.1696689091.git.christophe.jaillet@wanadoo.fr>
References: <56bef519d982218176b59bbba64a3a308d8733d5.1696689091.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Oct 2023 16:32:34 +0200, Christophe JAILLET wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] VMCI: Annotate struct vmci_handle_arr with __counted_by
      https://git.kernel.org/kees/c/81c643edd8bd

Take care,

-- 
Kees Cook

