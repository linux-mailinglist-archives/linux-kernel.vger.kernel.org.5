Return-Path: <linux-kernel+bounces-28726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F815830246
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1511F1F25BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1338713FFF;
	Wed, 17 Jan 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AATQ0vj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582448821;
	Wed, 17 Jan 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483589; cv=none; b=lUB+Yhmah55RH8nva0ff3OhUNbSlBkHMULyAm85177Cl0L1RQeN5sTr8ZTADS+STVOQEtLLn4K1AMtqqLbzSCJHS4Milej44DuH/JoHB1zFpojx2OMQtqCuFLIp/QEGdoaPWikFUaoj5UdJvDdgSKq+tEeUkexVuI+y4pGbNlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483589; c=relaxed/simple;
	bh=vgcI4Men/K8+E+y+e//121JlNpWLzGmTMhkjUwvr3yE=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=hbofxCs80j1pn+VJO8wQ9TLA4DwOgHC/YYBwKPJauJCQoUNx2Ymi0IQpwi0ICtBKJYh46w0Cn26c5rilwWvo38+8WRP91eQjkVoWJjjT5NwnArTjkhskS/ElRcD2L0Mh7lAV7EehlgN67IgTAzXJ+ajV6jIN6DXHTTq+kD/KZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AATQ0vj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54277C433C7;
	Wed, 17 Jan 2024 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705483588;
	bh=vgcI4Men/K8+E+y+e//121JlNpWLzGmTMhkjUwvr3yE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AATQ0vj+Nn/ctm8p6xCejQ5lNjjOzWwOCQt1aqbFdHLxbF53kDv+MVt94PMix8WX1
	 pgmffLJ+KUiXWcRvkbtaqqpfd8s2sLsor0TMBVq5UFWjxQysliMEPtyLZS00tI1o+A
	 8YneAY5GRxsOSBewp88QH1us53weN6CsTrdldj1CSieG2NFGFeIVh8cWnugjoZ2fc1
	 UmrgruRr4ACaCPTLrCWjwqV5YGjg8pNqrCA0dtwTh3vXQHzrcCPkhIYMhLGISAisMX
	 JcrXnujrwZzZD1GLn04MiIvJzMj0wu/0b0gXSWD9VJicuMu/EJgP6VE82CE49hZeS/
	 LgDZbVJtpwmIA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240117062310.2030408-1-jpatel2@marvell.com>
References: <20240117062310.2030408-1-jpatel2@marvell.com>
Subject: Re: [net v2 PATCH 1/1] net: mvpp2: clear BM pool before initialization
From: Antoine Tenart <atenart@kernel.org>
Cc: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, marcin.s.wojtas@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Date: Wed, 17 Jan 2024 10:26:25 +0100
Message-ID: <170548358563.6043.512179791104422697@kwain>

Hello,

Quoting Jenishkumar Maheshbhai Patel (2024-01-17 07:23:10)
> +/* Cleanup pool before actual initialization in the OS */
> +static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
> +{
> +       u32 val;
> +       int i;

Please add an empty line here. (You might as well add some below to
improve readability).

> +       /* Drain the BM from all possible residues left by firmware */
> +       for (i =3D 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
> +               mvpp2_read(priv, MVPP2_BM_PHY_ALLOC_REG(pool_id));

Not sure about the above, but I don't have the datasheet. Looks like
MVPP2_BM_PHY_ALLOC_REG contains the buffer dma addr, and is read
multiple times in a loop. Also the driver's comments says:

"""
- global registers that must be accessed through a specific thread
  window, because they are related to an access to a per-thread
  register

  MVPP2_BM_PHY_ALLOC_REG    (related to MVPP2_BM_VIRT_ALLOC_REG)
"""

If that's intended, maybe add a comment about what this does and why
mvpp2_thread_read isn't used?

> +       /* Stop the BM pool */
> +       val =3D mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
> +       val |=3D MVPP2_BM_STOP_MASK;
> +       mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
> +       /* Mask BM all interrupts */
> +       mvpp2_write(priv, MVPP2_BM_INTR_MASK_REG(pool_id), 0);
> +       /* Clear BM cause register */
> +       mvpp2_write(priv, MVPP2_BM_INTR_CAUSE_REG(pool_id), 0);
> +}
> +
>  static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
>  {
>         enum dma_data_direction dma_dir =3D DMA_FROM_DEVICE;
>         int i, err, poolnum =3D MVPP2_BM_POOLS_NUM;
>         struct mvpp2_port *port;
> =20
> +       if (priv->percpu_pools)
> +               poolnum =3D mvpp2_get_nrxqs(priv) * 2;

Since poolnum is now set here, you can remove the one below in the same
function (not shown in the context).

> +
> +       /* Clean up the pool state in case it contains stale state */
> +       for (i =3D 0; i < poolnum; i++)
> +               mvpp2_bm_pool_cleanup(priv, i);
> +
>         if (priv->percpu_pools) {
>                 for (i =3D 0; i < priv->port_count; i++) {
>                         port =3D priv->port_list[i];

Thanks.

