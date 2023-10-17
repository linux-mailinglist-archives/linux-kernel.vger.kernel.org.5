Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4777CCA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJQRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQRoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:44:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58679B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:43:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e3e7e478bso7327028a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697564638; x=1698169438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ+grLHpGUzgQCivN/ck9HANlKle5gcz1nC0C6eh5V4=;
        b=QqF65grAoYKu2Mqgf4gfrzrq39ihiujhQSENEeytM4A4K3wI4rzF8UMyoBtgm97AIp
         VshqgTJULVVqs9g/7WVIC+k0f7J6oDynXG/IQcfShqXLNQE8o4NrcX+eOP1wU2ck6UOl
         2zbCCXPVEQvUfET5wtLD0uhIQBz7rgZd0KOO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697564638; x=1698169438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ+grLHpGUzgQCivN/ck9HANlKle5gcz1nC0C6eh5V4=;
        b=kzGHtkTPhyjZZB3+NJTh8CDSfG3HMQsxNCkTxqYAkhxuAhMGeziYjGtK72acmuqJnh
         9TmtKOBMux2JOJuVkPcY6/9SZeE1oEPGj34ujOslFmVqs4CUoNWDr8c/vrUIFTQ2ga2M
         Qux2UCwOXhjj0G1/1wL7qHl6FKHC4FM2gigerVox28hedMQlOXAgFti4q+StspcU8/n1
         MA/Jl5Deflw2A32HPph2juAwWOv+PNPQSNCQ7Ic4LTXLnih1SrmFpO6YdpIjAfR01Y30
         XGD5Ooi0dtOCH3Tn1XthJNL5DXckRlg7I5IHva+mv4zvcPwzT7d6WicY+4Zr+TWc+y86
         DKIw==
X-Gm-Message-State: AOJu0YyPF/tte0ZoDNv9Fs96DjYPOcV/D2uF7X0oQ59zjgoDyhRcEZva
        Zjpuitpp9tP5tnZ4MwUP3TVVerSYUPhRqmp0LEurzTg4
X-Google-Smtp-Source: AGHT+IFn4PBCgKzfndLltFyixWlbV6i1hm1q3ILYE4SiSGOhuxAsTV0QG+dkGqJe44ZJBw2MvsWV7w==
X-Received: by 2002:a50:c2c1:0:b0:53e:d0cf:453c with SMTP id u1-20020a50c2c1000000b0053ed0cf453cmr2485210edf.9.1697564637843;
        Tue, 17 Oct 2023 10:43:57 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id s23-20020a508d17000000b00536031525e5sm1547334eds.91.2023.10.17.10.43.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:43:56 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9307009a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:43:56 -0700 (PDT)
X-Received: by 2002:a17:907:9306:b0:9bd:8cfd:e588 with SMTP id
 bu6-20020a170907930600b009bd8cfde588mr2685824ejc.27.1697564636390; Tue, 17
 Oct 2023 10:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-8-jeffxu@chromium.org>
 <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
In-Reply-To: <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 10:43:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
Message-ID: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/8] mseal:Check seal flag for mmap(2)
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

On Tue, 17 Oct 2023 at 10:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, there is only two kinds of sealing that makes sense:
>
>  - you cannot change the permissions of some area
>
>  - you cannot unmap an area

Actually, I guess at least theoretically, there could be three different things:

 - you cannot move an area

although I do think that maybe just saying "you cannot unmap" might
also include "you cannot move".

But I guess it depends on whether you feel it's the virtual _address_
you are protecting, or whether it's the concept of mapping something.

I personally think that from a security perspective, what you want to
protect is a particular address. That implies that "seal from
unmapping" would thus also include "you can't move this area
elsewhere".

But at least conceptually, splitting "unmap" and "move" apart might
make some sense. I would like to hear a practical reason for it,
though.

Without that practical reason, I think the only two sane sealing operations are:

 - SEAL_MUNMAP: "don't allow this mapping address to go away"

   IOW no unmap, no shrinking, no moving mremap

 - SEAL_MPROTECT: "don't allow any mapping permission changes"

Again, that permission case might end up being "don't allow
_additional_ permissions" and "don't allow taking permissions away".
Or it could be split by operation (ie "don't allow permission changes
to writability / readability / executability respectively").

I suspect there isn't a real-life example of splitting the
SEAL_MPROTECT (the same way I doubt there's a real-life example for
splitting the UNMAP into "unmap vs move"), so unless there is some
real reason, I'd keep the sealing minimal and to just those two flags.

We could always add more flags later, if there is a real use case
(IOW, if we start with "don't allow any permission changes", we could
add a flag later that just says "don't allow writability changes").

               Linus
