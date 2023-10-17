Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E667CC92D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:54:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07653A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:54:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so75186181fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697561693; x=1698166493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K1bTNFT87lr+HVy46GvlRl8WsLt2mWlRGa4YdiUNjuo=;
        b=PFM3RQvqEe7u45KgiION4fPKs+KtXOGSvg0QTKUlrHz7SWoJEBVTrjq658S9W55ebn
         d5Z/RURWGQhF9DXWCVda+CFLc1tKSMUDUpeqX49o5op9URYMUrjokEbRLabqKG967oxM
         cyeyE7xOpyC3OqcuJCwTT6AU4Eoynlp8pLuJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561693; x=1698166493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1bTNFT87lr+HVy46GvlRl8WsLt2mWlRGa4YdiUNjuo=;
        b=hCIr8ko3v25PExTEp2UEjtL71dyyb2MaRP3qYYRfXMLnLk1y9QXG00hWY5oEavCWRC
         L0UBy6KaY8BpsCB+Gd0/9pd1CROUA4YopQjYhwHeey/4iM+q/FzWfQrqbMyYPVdf+RMh
         X1XnLCmSvGpWGlDKIBg3IApEAajTnR9lYVGQ7I2L34RG8ow0oWxqwI8oX6rEKG5XhrP+
         GNXyUl4XFt6KhCXaCluBWQMWUa5rKU9gLMzTc+3QjZ3vRbVKZ9rUE6nsoIPiIniu+EBC
         GxiZIID8SgKmVh1udLW1zurADwDmMs1f9/4/SwiHpm7rmR/HR1hxxclPqNI4ftX4KcpC
         LJtA==
X-Gm-Message-State: AOJu0YzEHyw3OH9uWC9Cln9qA0K5+Rc8nAW/ZATjOuuv0JkI4WyNWfNP
        evUHJg3wiPu+HqQX+f+xPeupJOfjrYtsaWJu/gVHBnge
X-Google-Smtp-Source: AGHT+IG+WMoNr+WwVLJlhkF9cU67eFxvoMngO11iNFkdSeqr5dRzVZYC6hFJYdiCtpwyAV4vHxewSw==
X-Received: by 2002:ac2:484c:0:b0:503:35b3:aa31 with SMTP id 12-20020ac2484c000000b0050335b3aa31mr2075805lfy.27.1697561693204;
        Tue, 17 Oct 2023 09:54:53 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id v23-20020a056402175700b0053dd8898f75sm1491571edx.81.2023.10.17.09.54.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:54:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so950964066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:54:52 -0700 (PDT)
X-Received: by 2002:a17:907:3cd:b0:9c4:b8c9:1bf2 with SMTP id
 su13-20020a17090703cd00b009c4b8c91bf2mr1497085ejb.60.1697561692367; Tue, 17
 Oct 2023 09:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
In-Reply-To: <20231017090815.1067790-6-jeffxu@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 09:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
Message-ID: <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 02:08, <jeffxu@chromium.org> wrote:
>
> Of all the call paths that call into do_vmi_munmap(),
> this is the only place where checkSeals = MM_SEAL_MUNMAP.
> The rest has checkSeals = 0.

Why?

None of this makes sense.

So you say "we can't munmap in this *one* place, but all others ignore
the sealing".

Crazy.

             Linus
