Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030A9807216
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378873AbjLFOQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378870AbjLFOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:16:00 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9FD5E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:15:54 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58cf894544cso4470795eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701872153; x=1702476953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgKI2xyGODCiFPlxyU5+BAAYcrGDTRi9HM+3OhX+AwA=;
        b=Qwq/eM4ItCXyWZSGgBZMVBm2Wl8EqMi+3RSXMLql1SvGQdtto36hK9y1rY6l8mIXtU
         ed9Xvacg570NTSst0QSaIHEQlJ1esrzbKTbOATOdGsivwztsSEnvzGKieHStRW8VXdZ2
         vDtmWb4PNimGmjoTjTvYxA4DxHohDsRSZLMwb2IOdZL4odfEileEoixtKG0lcys6qb0f
         lZTS0PqOJpw1fY65jLBF0YT2Tqkcq2dhfijCv12n9Ij+jx6171LDYniFYneIqmqH5y/7
         IcDaHTWjpHOfeBL6rYxgufq60wxET9R1nL79E9UjeIPR7jfO6eM7bk0MAmX/4+aJ3LGl
         Txxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872153; x=1702476953;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgKI2xyGODCiFPlxyU5+BAAYcrGDTRi9HM+3OhX+AwA=;
        b=uoo/qHfQdciKqWaIsozbvVDqatNHzoj9oybkOc+qbRiUNI6nvfJjU1CIYxWWyLzHCJ
         rNA64oQCi0xq2qlrxrmXCNrsVHj9k7s3zOXOto2hZiGUMrA80ssIaYJofyGPzSv+vZOE
         TAqyu7MeJYbQqwdyrevMjHLHTSnnWNrayWt3MCf4dHzxeQM5CEuEo1plVdp6PWJ1BRDb
         nJ5sNzy+Vq+xY3rGeUevaUfVVNr5JcWBHCSgXbDRiELTOr8H60sC/L+TWgLcEfBuaaBs
         vQwAFm6RQBBtbnSVrzWG3s7fGXKVqzrqzR6Y/EXtKIlZX2ZLCiKf78KZjqnQIwZStJIr
         jx3Q==
X-Gm-Message-State: AOJu0YxmM5Od6F7UI5SKFBUgSsGfMl/pjfQSaS561pCBG331kqJxg899
        5WpM1K3HHId87pPo+FvOv6WlfA==
X-Google-Smtp-Source: AGHT+IFPf3FTqsWC/1qvU045Pf4RvgR8HF5dZsG26N9kr5zXhPC91ObgfpOIjJOaW1hEQNzaFZX8pA==
X-Received: by 2002:a05:6820:80a:b0:581:e089:9e5c with SMTP id bg10-20020a056820080a00b00581e0899e5cmr1092075oob.6.1701872153415;
        Wed, 06 Dec 2023 06:15:53 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id cn1-20020a056820230100b00581debbeeb4sm3836oob.1.2023.12.06.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:15:52 -0800 (PST)
Date:   Wed, 06 Dec 2023 06:15:52 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 06:15:51 PST (-0800)
Subject:     Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
In-Reply-To: <ZXCA+4WyI6D+Somy@andrea>
CC:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     parri.andrea@gmail.com
Message-ID: <mhng-26a1b3dd-ca9e-4b82-86e9-1faf1e3571e5@palmer-ri-x1c9>
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

On Wed, 06 Dec 2023 06:11:07 PST (-0800), parri.andrea@gmail.com wrote:
>> I see
>>
>> $ git grep "config MEMBARRIER" fab957c11efe2f405e08b9f0d080524bc2631428
>> fab957c11efe2f405e08b9f0d080524bc2631428:init/Kconfig:config MEMBARRIER
>>
>> so IMO this is just one of those forever bugs.  So I'd lean towards
>>
>>    Fixes: fab957c11efe ("RISC-V: Atomic and Locking Code")
>
> Works for me, will apply in v2.
>
>
>> (or anything in that original patch set).  It's not that big of a backport,
>> so I think it's safe enough?
>
> Indeed, I think so.
>
> The final version of this fix will likely depend on some machinery/code
> introduced by 3ccfebedd8cf54 ("powerpc, membarrier: Skip memory barrier
> in switch_mm()"); but, yes, nothing we can't safely adjust I think.

Ya, I guess we'll have to look to know for sure but hopefully it's 
manageable.

> Thanks,
>   Andrea
