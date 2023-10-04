Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2087B856F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbjJDQhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjJDQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:37:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E4A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:37:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690bd8f89baso1871531b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1696437421; x=1697042221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBByGH7WLfxooOHCdCARZqpfIQQBFdcDsbHiFKU/Lk4=;
        b=UZMjoycmBHryvhPm5vn4vjMXES39uxrJvia7iYZ3p7o701Vl2QURqP99OQIegsnX0L
         7uamjylbyW6D5Yej52mRIDDxqSKb7yHDjISkh7C3AVwIIiO96xTh1WwWHg2FHo1uVXOP
         Bjk2dhzj6qPaG3d2n3KUI/gPqKPJMut+ibq3aWUDdmdS/vEGKxdZjqdKvBXKGKEOvWDJ
         WpHjQ1Y96e0z3sQAzDRXabomvUrNYsIiX5AYyGsBAGDr3f2Qrhh9joGhISGqkknd6LoK
         92U3V1GAyy4svm4dAJwKGMSsqAcXHarEZLQQkP2KauU12UxZuTr4XmOKFH95V9Sgdlch
         I3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437421; x=1697042221;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBByGH7WLfxooOHCdCARZqpfIQQBFdcDsbHiFKU/Lk4=;
        b=vKZyAjwGNjx66TEgaRTXTF9EQuqKoraI6UkqcU7E5ztmI86tpNEl788xkInFCV60nr
         cxm+kUGWXV9/CNFK1f6KQQZ+jJzPnYcqZ8Ng3hhBUwZRYB4s8YZnJpUMwt+9lZNNEeZf
         W4sUtIYUely0uP0VwkJJlA08RJuAuwU76vNNxLC0DSnR7VQCDyFRLo7/aUy1fqCZ1BAH
         zbklsglkObmEem0wCM/NqPctly5DRkhFzXVovUMn1rFl9HXeyU1WPMqWOG+W2aX8pP57
         E8HW5odRcQHfR3i6smThnlruGVgILF9sqpe1A7J9Z93aQaNmLbsnhKtDgY0UnkN5o1hd
         +BTQ==
X-Gm-Message-State: AOJu0YzeJ20Y35vSBNo744V9AO4sQun5O5p0hQdE3aqcuoV+mtSLoZJH
        z8Isql1sdUIf0pAywT7KlFZvOg==
X-Google-Smtp-Source: AGHT+IHeF3ptFZw1d8bIM/SHWAP9FEFc1h6dLK/CIBtQtNjlYUixjt9DZxLgYcSIK1sodazHs/r1Yg==
X-Received: by 2002:a05:6a21:8cc5:b0:14c:c393:6af with SMTP id ta5-20020a056a218cc500b0014cc39306afmr2808720pzb.0.1696437420714;
        Wed, 04 Oct 2023 09:37:00 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id jk12-20020a170903330c00b001bc2831e1a8sm3949808plb.80.2023.10.04.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:37:00 -0700 (PDT)
Date:   Wed, 04 Oct 2023 09:37:00 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Oct 2023 09:36:50 PDT (-0700)
Subject:     Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
In-Reply-To: <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
CC:     alex@ghiti.fr, alexghiti@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        panqinglin2020@iscas.ac.cn, ryan.roberts@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akpm@linux-foundation.org
Message-ID: <mhng-83247622-bffb-4bbe-8f2f-89dd5badab64@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 09:04:43 PDT (-0700), akpm@linux-foundation.org wrote:
> On Tue, 3 Oct 2023 17:43:10 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>
>> +cc Andrew: Would  you mind taking this patchset in your tree for the 
>> next rc? This patchset depends on a previous fix for arm64 that you 
>> merged in rc4 which is not in the riscv -fixes branch yet.
>> 
>> I saw with Palmer and he should ack this shortly.
>
> Well I grabbed them into mm.git's mm-hotfixes-unstable queue.  All
> being well I'll move them into mm-hotfixes-stable within a week then
> into Linus shortly after.
>
> Unless something changes.  It's odd that the riscv tree(s) aren't set
> up to merge fixes against -rc4?

It's mostly that I have COVID, so everything's kind of a mess right now.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
