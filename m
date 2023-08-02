Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD22476D737
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjHBSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjHBSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:54:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D552129
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:54:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf1f632b8so22640666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691002447; x=1691607247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOvJemkz8MAV7rkDv/s31q26dZgdbiAYujbRCsOrvF8=;
        b=iAJoALiqtAbdQA87RmsAUnXZA1DIpIrj6EBAyzQ29CwXAsd1jXvMnU6jawbCRiZxkw
         MO3Hyie+UDR5MuVg7zawY4kOg/B1dlb1qinzOGkMV/PeZ21PziYIFA2zI7OgXvj7MSWG
         Phb2xmkRhTsrgx0XSeWRscKqti8AqniVr3Mb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002447; x=1691607247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOvJemkz8MAV7rkDv/s31q26dZgdbiAYujbRCsOrvF8=;
        b=P6rvOJigDuMF2+udA9lZVF5b+TgYC2LcRcoM0JO6uiD5cRe84pHsOPITFaN2/nIurI
         FBJGahxDJLVm1hi2pSN9Q9fQ35+boWCe55t/AW2OJAPEqF0qBzbrnCeH3BSp+gJ9/Lpe
         fZMRGeDwAqupKgao+7SeEkXx8ZQ3GF/bNGjwaiC24QWKM952klhIpHbQM4sx9L29aZzY
         5EAD5KxQYQvruaKW7YjiXf6YHxAEpAT3r63ebGzdp5ktlCq30w4O0Bq3nGEv9pkVRtwJ
         DBI7SMaMTQVwYEh2IuD1/J2EsjBlrhUM2bs65RX+qrcwEVIEDxON2t/28PxF/jhut4Jh
         Y2sg==
X-Gm-Message-State: ABy/qLar0lA5HB9O7AtYY7CwZzarvWWQ6LntEP/8k+lAXptltrWh5ilo
        JkIFt0VoD/yZAlMHtg6Hi2W5ynB3Ygtf0eEMOkm2bWpk
X-Google-Smtp-Source: APBJJlG2da0Mef25OfCbW3WnBwioSZBj1tyrjx0dbqOFUma3aLmVsPlsfSn4yvBXCjIGX9Crpob7LQ==
X-Received: by 2002:a17:907:77d7:b0:99b:cf57:11e3 with SMTP id kz23-20020a17090777d700b0099bcf5711e3mr5474420ejc.59.1691002447441;
        Wed, 02 Aug 2023 11:54:07 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709061c1100b009937dbabbd5sm9439864ejg.220.2023.08.02.11.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 11:54:07 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so75534a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:54:06 -0700 (PDT)
X-Received: by 2002:aa7:df18:0:b0:522:289d:8dcd with SMTP id
 c24-20020aa7df18000000b00522289d8dcdmr4973875edy.35.1691002446423; Wed, 02
 Aug 2023 11:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-5-surenb@google.com>
 <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com> <CAJuCfpFYq4yyj0=nW0iktoH0dma-eFhw1ni7v9R-fCsYH7eQ3Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFYq4yyj0=nW0iktoH0dma-eFhw1ni7v9R-fCsYH7eQ3Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 11:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
Message-ID: <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: lock vma explicitly before doing
 vm_flags_reset and vm_flags_reset_once
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 11:09, Suren Baghdasaryan <surenb@google.com> wrote:
>
> Ok, IOW the vma would be already locked before mmap() is called...

Yup.

> Just to confirm, you are suggesting to remove vma_start_write() call
> from hfi1_file_mmap() and let vm_flags_reset() generate an assertion
> if it's ever called with an unlocked vma, correct?

Correct.

               Linus
