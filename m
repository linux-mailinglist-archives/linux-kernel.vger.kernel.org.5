Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236E7A78FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjITKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjITKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:18:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56581B4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:18:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c4586b12feso27960235ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1695205088; x=1695809888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaiz04gdR9OAn8hUhTxFnO5z/99PYRYgbxmLEMvi0GU=;
        b=fV5oO6UTGdTPuWxF0IQw/TWTkQJ/B8CFJ4w5rgDXf0k5RmFs7cud6ynn1RoEYS+9DO
         tprHF6OQnGllNLBHpRMPodOG8AAdQ5L+nsG77FDy37b8IOzJ5uJ3AEeMuI89RA/AOwY0
         jUUe9VcyaYHd4saQ8xWYg2Ua7kSV9Ov0tuhudTfDZO0W6UAnn81ZZjJFb+uakSR1qqvZ
         XGtf5MeNdIovdVQjU8iGKVzR5wBrj8zZZ1NNvLQAs8O4718WL2gzpSVdVkJMirIJpgxT
         ZN+s/TS087vZxrvcbE/Vu00uXcwgxP3No7p4IrbqSDRcM5HAvMp/c4xI+vuu15yJsFEK
         Nx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695205088; x=1695809888;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaiz04gdR9OAn8hUhTxFnO5z/99PYRYgbxmLEMvi0GU=;
        b=Lpd3UpAixWTPn3nQdBy34vsgaf/jwYkZ9HjAlpAtzAtkS2osTanAcox0b+SBFHIDwn
         E0b95yRqCJDXgy9IcqWTGMiloDbVAeDr+32VU2lLfmod5w0GLYYPXeP09p6xPkV9ymol
         5VkEMX+lwxrislsx/TTZAlYjZp2cVhEWlvNAri/QRk4aFvw6IR275n5eFbk8LXKwSO1p
         7mzzPE2ZXbVKiS8piC1vVycwwA3QEdKWJ5vLaIga4Be13RodXHo+5Op3chagjMi78rdn
         V71H7OfLfXCpcPrVCF6yesDmCvyidWtawGKXENfnC2jnr8G7xq2tsYIZC83B5kmr5Ld2
         c6cQ==
X-Gm-Message-State: AOJu0YxR9GbHrtAWHyJ61p8cGsPICogu/VDpGL8aATcpU6tX5Zp6NNbq
        V76z6EO0xWD1oEzDgDqqPjLaRl548PXxSythz5F+Nw==
X-Google-Smtp-Source: AGHT+IEQYtBpZ58/YQnBwJBLpvN8uGqez/p/gojg8PHBbN+rUIEdYg4vTrGGIU7fSfJ7RgF2tGOjzA==
X-Received: by 2002:a17:902:748a:b0:1bb:f82f:fb93 with SMTP id h10-20020a170902748a00b001bbf82ffb93mr1759975pll.2.1695205087644;
        Wed, 20 Sep 2023 03:18:07 -0700 (PDT)
Received: from localhost ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001c456b3c012sm7479840plb.298.2023.09.20.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 03:18:07 -0700 (PDT)
Date:   Wed, 20 Sep 2023 03:18:07 -0700 (PDT)
X-Google-Original-Date: Wed, 20 Sep 2023 03:18:02 PDT (-0700)
Subject:     Re: [PATCH] irqchip/sifive-plic: Avoid clearing the per-hart enable bits
In-Reply-To: <86zg3ttvsi.wl-maz@kernel.org>
CC:     samuel.holland@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>, samuel@sholland.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-3622fd7f-23c4-4709-9082-0a62d49762ce@palmer-ri-x1c9a>
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

On Tue, 18 Jul 2023 02:26:37 PDT (-0700), Marc Zyngier wrote:
> On Mon, 17 Jul 2023 19:58:40 +0100,
> Samuel Holland <samuel.holland@sifive.com> wrote:
>>
>> Writes to the PLIC completion register are ignored if the enable bit for
>> that (interrupt, hart) combination is cleared. This leaves the interrupt
>> in a claimed state, preventing it from being triggered again.
>>
>> Originally, the enable bit was cleared in the .irq_mask operation, and
>> commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
>> added a workaround for this issue. Later, commit a1706a1c5062
>> ("irqchip/sifive-plic: Separate the enable and mask operations") moved
>> toggling the enable bit to the .irq_enable/.irq_disable operations and
>> removed the workaround.
>>
>> However, there are still places where .irq_disable can be called from
>> inside the hard IRQ handler, for example in irq_pm_check_wakeup(). As a
>> result, this issue causes an interrupt to get stuck in a claimed state
>> after being used to wake the system from s2idle.
>>
>> There is no real benefit to implementing the .irq_enable/.irq_disable
>> operations using the enable bits. In fact, the existing mask/unmask
>> implementation using the threshold register is already more efficient,
>> as it requires no read/modify/write cycles. So let's leave the enable
>> bits set for the lifetime of the IRQ, using them only to control its
>> affinity.
>
> Side question, which doesn't affect this patch: what happens with
> interrupts that are firing while the interrupt is in a disabled state?
> It's fine for levels, but what of edge interrupts?
>
> My reading of the spec is that it is the role of the "gateway" to hold
> the signal, and that this is upstream of the PLIC itself, so it
> *should* be fine, but I'd like confirmation on that.

Which spec are you reading?  I'm not seeing anything in 
<https://github.com/riscv/riscv-plic-spec>, but I've sort of only 
skimmed it.  I don't remember us ever really figuring out edge triggered 
interrupts, it was sort of just a "vendors should make sure they do 
something reasonable" type plan.

> Thanks,
>
> 	M.
