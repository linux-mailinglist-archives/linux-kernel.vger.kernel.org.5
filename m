Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CAB7DA8AA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ1Sej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Seh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:34:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22BED;
        Sat, 28 Oct 2023 11:34:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698518073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9szwvGpZuywL6dp6erj+VxB4LJczIuYNLzmOgYi7ek=;
        b=NeHTGIxh0eQnS0Cd32fVx2YA/vomR+9OypHHPX0kzSm75ZcgiHjdT5M6xPvB/yfVxhmvyi
        1sM5E2+wFxlruQYWALPsgD5eb/JjaspdrBL2wRezSKna9SGWO9MOBb4Igi4dWuiSdL7J8W
        KBK1peI9NTizGLIMF5CiThWAkBB8gcbjwYrcIVHmjs85prEEHC63m34Xome6BvD29jUayP
        jUxqBLsNBYhe7Ty81wFnmQRAuyXYYK3amh13W8CJo/MoFyPj6O1R4hgm6oLFo7gtTUpJDl
        w52kC90+HjKSJ6aGvYaMkznAsGmn5sVMF5JWP4E66uS7ulNRlytptMRFUqWX+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698518073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9szwvGpZuywL6dp6erj+VxB4LJczIuYNLzmOgYi7ek=;
        b=ts0KS2ygqcHxtCjXf8TRE5hulx94A+1MZ6UoC0wgNmiBI2U98b5YU4CJ9uHVW40d0kBHVr
        H19FWn/6gWPjwADA==
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v11 07/14] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <20231023172800.315343-8-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-8-apatel@ventanamicro.com>
Date:   Sat, 28 Oct 2023 20:34:33 +0200
Message-ID: <871qde1tqe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 22:57, Anup Patel wrote:
> +#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
> +void imsic_vector_debug_show(struct seq_file *m,
> +			     struct imsic_vector *vec, int ind)
> +{
> +	unsigned int mcpu = 0, mlocal_id = 0;
> +	struct imsic_local_priv *lpriv;
> +	bool move_in_progress = false;
> +	struct imsic_vector *mvec;
> +	bool is_enabled = false;
> +	unsigned long flags;
> +
> +	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
> +	if (WARN_ON(&lpriv->vectors[vec->local_id] != vec))
> +		return;
> +
> +	raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> +	if (test_bit(vec->local_id, lpriv->ids_enabled_bitmap))
> +		is_enabled = true;
> +	mvec = lpriv->ids_move[vec->local_id];
> +	if (mvec) {
> +		move_in_progress = true;
> +		mcpu = mvec->cpu;
> +		mlocal_id = mvec->local_id;
> +	}
> +	raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> +
> +	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
> +	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
> +	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
> +		   (vec->local_id <= IMSIC_IPI_ID) ? 1 : 0);
> +	seq_printf(m, "%*sis_enabled      : %5u\n", ind, "",
> +		   (move_in_progress) ? 1 : 0);
> +	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "",
> +		   (move_in_progress) ? 1 : 0);
> +	if (move_in_progress) {
> +		seq_printf(m, "%*smove_cpu        : %5u\n", ind, "", mcpu);
> +		seq_printf(m, "%*smove_local_id   : %5u\n", ind, "", mlocal_id);
> +	}
> +}
> +
> +void imsic_vector_debug_show_summary(struct seq_file *m, int ind)
> +{
> +	unsigned int cpu, total_avail = 0, total_used = 0;
> +	struct imsic_global_config *global = &imsic->global;
> +	struct imsic_local_priv *lpriv;
> +	unsigned long flags;
> +
> +	for_each_possible_cpu(cpu) {
> +		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
> +
> +		total_avail += global->nr_ids;
> +
> +		raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> +		total_used += bitmap_weight(lpriv->ids_used_bitmap,
> +					    global->nr_ids + 1) - 1;
> +		raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> +	}
> +
> +	seq_printf(m, "%*stotal : %5u\n", ind, "", total_avail);
> +	seq_printf(m, "%*sused  : %5u\n", ind, "", total_used);
> +	seq_printf(m, "%*s| CPU | tot | usd | vectors\n", ind, " ");
> +
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
> +
> +		raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> +		total_used = bitmap_weight(lpriv->ids_used_bitmap,
> +					   global->nr_ids + 1) - 1;
> +		seq_printf(m, "%*s %4d  %4u  %4u  %*pbl\n", ind, " ",
> +			   cpu, global->nr_ids, total_used,
> +			   global->nr_ids + 1, lpriv->ids_used_bitmap);
> +		raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> +	}
> +	cpus_read_unlock();

This looks very close to the matrix alocator information, just done differently.

> +static unsigned int imsic_vector_best_cpu(const struct cpumask *mask,
> +					  unsigned int order)
> +{
> +	struct imsic_global_config *global = &imsic->global;
> +	unsigned int cpu, best_cpu, free, maxfree = 0;
> +	struct imsic_local_priv *lpriv;
> +	unsigned long flags;
> +
> +	best_cpu = UINT_MAX;
> +	for_each_cpu(cpu, mask) {
> +		if (!cpu_online(cpu))
> +			continue;
> +
> +		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
> +		raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> +		free = bitmap_weight(lpriv->ids_used_bitmap,
> +				     global->nr_ids + 1);
> +		free = (global->nr_ids + 1) - free;
> +		raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> +		if (free < BIT(order) || free <= maxfree)
> +			continue;
> +
> +		best_cpu = cpu;
> +		maxfree = free;
> +	}
> +
> +	return best_cpu;

Looks very much like what the matrix allocator provides, right?

What's the actual reason that you can't use it?

Thanks,

        tglx
