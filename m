Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFCA807715
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjLFR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjLFR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:56:11 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F6ED42
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:56:17 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d7e56f6845so31442a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701885376; x=1702490176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzmOds210uOLMoqUxUrCLSQtsPcHifLKozmBM1oKPoo=;
        b=rgsk+fXmwfOtpzhA+iN3t9CjJdk7u5+m/oIz9Uap6AdURbAn06Ukz0RVvIrTKpQ20u
         3d8HTuNtHWPCYtR3xPxZsu3kAzCJ5wg7/djU9jA5PmPbxhOlGYTpB+20GVIdOE4qxgbS
         +ggG/JNrXlwvLKxHRW0NTq34QZZuTFWyqIk2oZt6g5ChHcVtFSN+E7hXQLS9tY1dcxkp
         M7YE84bO8yGZcGErOCduAStWPGztCMp3GPzJKEiKlsHM4M9P5KOtYDmTqChCzNrwuLYC
         iliQCI11ICQVq1tdWcwvY8ZbAvT9S3hZpmd4DmNzzWabMh70yH5U+dptnQ+u6f9VWatR
         LxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885376; x=1702490176;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzmOds210uOLMoqUxUrCLSQtsPcHifLKozmBM1oKPoo=;
        b=G6hzWV9tF7CR4G7DDQSVvTY3Yh0lqs2RBPMC6WnfsBVGrK+I/y8hagLtYxBngGab1i
         P4l61poaqq8eCzi2/r/X6bOAEtbX7/P485zK4z6uKVNJIzdLhW3oZjjjmOdG1dk2k1da
         xg8509b2nDymPEn9i8Yffq6D2nOFlMYDWe4CX5W5BK1FNCUbL9WVU5DDjl6+60X4BmNW
         /IRqfA+MJBKY5JeVA/AkZYpdIL4v9z5wUpStbldaapf+Bw24T9BGKL8YlKNvh/CynRGb
         lNDPa7GqHvYephG4n2G5ZzB2X+2AmXOG7SonefRKbL8pTwtf2uZFlMXwhKF3XDP7w0fA
         EWuw==
X-Gm-Message-State: AOJu0YyD+K2slUx6W0TY4GL29Le0+gDdOCeevVqXqXbzNRp7j3AM+PIV
        maxtst2gQ7t0bjxUUGlqQES6NA==
X-Google-Smtp-Source: AGHT+IGuLe3uXFDTYJvCW1TreYHsP4rbqmaZqL0yKN+0sgi7VOo/WQy0nBuEdy5xTo8VjXoiNfBFSQ==
X-Received: by 2002:a05:6830:1e69:b0:6d8:74e2:a3d3 with SMTP id m9-20020a0568301e6900b006d874e2a3d3mr1377709otr.47.1701885376195;
        Wed, 06 Dec 2023 09:56:16 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id l11-20020a0568301d6b00b006d81e704023sm52207oti.2.2023.12.06.09.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:56:15 -0800 (PST)
Date:   Wed, 06 Dec 2023 09:56:15 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 09:56:13 PST (-0800)
Subject:     Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
In-Reply-To: <ZXCylOEXSbEMGB96@andrea>
CC:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     parri.andrea@gmail.com
Message-ID: <mhng-5a4880f5-926c-4087-8bb9-b6c09fd4e288@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 09:42:44 PST (-0800), parri.andrea@gmail.com wrote:
>> > The final version of this fix will likely depend on some machinery/code
>> > introduced by 3ccfebedd8cf54 ("powerpc, membarrier: Skip memory barrier
>> > in switch_mm()"); but, yes, nothing we can't safely adjust I think.
>>
>> Ya, I guess we'll have to look to know for sure but hopefully it's
>> manageable.
>
> Absolutely.  One approach would be to follow what PowerPC did: AFAIU, before
> 3ccfebedd8cf54 membarrier/powerpc used to hard code the required barrier in
> in finish_task_switch(), "masking" it as an smp_mb__after_unlock_lock(); riscv
> could use a similar approach (though with a different/new mask function).

IIRC we patterned our MMIOWB/after-spinlock barriers after PPC, so 
that's probably a good place to start here as well.

> Alternatively, we could maybe keep the barrier in switch_mm().
>
> But let me complete and send out v2 with the fix at stake...  this should give
> us a more concrete basis to discuss about these matters.
>
>   Andrea
