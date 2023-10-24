Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD787D4BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjJXJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjJXJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:25:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21863118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E76C433C7;
        Tue, 24 Oct 2023 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698139508;
        bh=STSijGUWVISfkA9IGb3K0BUTUfHZYyEismBXC+HqXvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2hiTaVeKR9S5iCOx59OrT84D6+C47KdBcuY7cXBTJPtmZIulF/A1mzSh99g0f4mx
         yNB05utFWFLJu77My72FGHp2yU7dAq+FGPUeEFhoIENd0Prd4ejYNt4ToIRL3t7Hp3
         HK+ahQKmCFYqmlWoU+2MoHjPepdUovjQ9HCL8BcdN6JqiaykcwOvO7/iCKo3zjjTBp
         HK1SPg7+ZXOEB3W4fAo9fzFqIYcmq/Dbaaq0mlwdSfd2S5mEg1FM0Ay58bdglWltoT
         GLJvTvLohU6rhLNa0wmlcwaBMjg5MNzpic9Xet+uMdDUaUGuaA6kH6cw4+xqaOl/FL
         WyNTdzzmQBbUA==
Date:   Tue, 24 Oct 2023 10:25:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 07/14] irqchip: Add RISC-V incoming MSI controller
 early driver
Message-ID: <20231024-arbitrate-glitter-2053d17d7260@spud>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-8-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TUEnEqtl71dlQREh"
Content-Disposition: inline
In-Reply-To: <20231023172800.315343-8-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TUEnEqtl71dlQREh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 23, 2023 at 10:57:53PM +0530, Anup Patel wrote:

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

gcc & clang report:
drivers/irqchip/irq-riscv-imsic-state.c:288:14: warning: variable 'is_enabled' set but not used [-Wunused-but-set-variable]

This looks to be a copy-pasta issue, and the move_in_progress here
should be is_enabled?

> +	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "",
> +		   (move_in_progress) ? 1 : 0);
> +	if (move_in_progress) {
> +		seq_printf(m, "%*smove_cpu        : %5u\n", ind, "", mcpu);
> +		seq_printf(m, "%*smove_local_id   : %5u\n", ind, "", mlocal_id);
> +	}
> +}

--TUEnEqtl71dlQREh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTeNbgAKCRB4tDGHoIJi
0hg+AP9hiwEtULaMca2iBSTHNKRnMLEccd171Cmd37iYCpIvngD/QbHaowrk285r
j/XrLdDztdWG1QjItpoXzSrizhks6wo=
=OUuT
-----END PGP SIGNATURE-----

--TUEnEqtl71dlQREh--
