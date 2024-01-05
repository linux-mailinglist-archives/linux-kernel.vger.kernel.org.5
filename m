Return-Path: <linux-kernel+bounces-17739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41D8251C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BB7B213AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB318250E9;
	Fri,  5 Jan 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3fbB6Tj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323224B48;
	Fri,  5 Jan 2024 10:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2CBC433C7;
	Fri,  5 Jan 2024 10:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704450135;
	bh=oQGOEMuZwhCeZ13+phWxoQu6BEy+A6aOg5LpzwI7iRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3fbB6TjVbslLJNPhjQfrDhvlyjSRyanKmCbk0YWFUz265z7ZAaranr1naJsVccNZ
	 f/ZVvvsdyhOFCO78G8/QyIEvJIZmKAoPv/yqHkQVlmnJ/9b6wGU7/+5qmd860xWBaO
	 JR28x4VLae9CE1nRfl/rBFB26xNuhXah1xm9t8DMXgqVtHB8dqi1ICS8Ch2sa0XIZW
	 jZhEQ25nAA3no30MxSUawrAtdEZkZ6+yk5EVhrTxXNX/0cc8GEjiqxd36g1WPCeh4U
	 /b+HqnAd1Wp7UbutG+4WD1O8h66w4kBNa1pFLVI+ZXll9fOXlPEw8kYzI+LI/53N80
	 JZuY8oHjjnAog==
Date: Fri, 5 Jan 2024 10:22:09 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, sedara@marvell.com, egallen@redhat.com,
	mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 2/8] octeon_ep_vf: add hardware configuration
 APIs
Message-ID: <20240105102209.GR31813@kernel.org>
References: <20231223134000.2906144-1-srasheed@marvell.com>
 <20231223134000.2906144-3-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223134000.2906144-3-srasheed@marvell.com>

On Sat, Dec 23, 2023 at 05:39:54AM -0800, Shinas Rasheed wrote:
> Implement hardware resource init and shutdown helper APIs, like
> hardware Tx/Rx queue init/enable/disable/reset.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Hi Shinas,

some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c

...

> +/* Reset Hardware Tx queue */
> +static int cn93_vf_reset_iq(struct octep_vf_device *oct, int q_no)
> +{
> +	u64 val = 0ULL;
> +
> +	dev_dbg(&oct->pdev->dev, "Reset VF IQ-%d\n", q_no);
> +
> +	/* Disable the Tx/Instruction Ring */
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(q_no), val);
> +
> +	/* clear the Instruction Ring packet/byte counts and doorbell CSRs */
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q_no), val);
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_PKT_CNT(q_no), val);
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_BYTE_CNT(q_no), val);
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_BADDR(q_no), val);
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_RSIZE(q_no), val);
> +
> +	val = 0xFFFFFFFF;
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(q_no), val);
> +
> +	val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CNTS(q_no));
> +	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_CNTS(q_no), val & 0xFFFFFFFF);

This function uses values that appear to have special values:
0, and 0xFFFFFFFF (as a value and a mask).

I think it would be nice to name these using #defines
In the case of masks, using GENMASK_ULL() and FILED_PREP()
may be appropriate.

Likewise elsewhere in this patch.
Usage of BIT() and BIT_ULL() may also be appropriate.

> +
> +	return 0;
> +}

...

>  /* Tx/Rx queue interrupt handler */
>  static irqreturn_t octep_vf_ioq_intr_handler_cn93(void *data)
>  {
> +	struct octep_vf_ioq_vector *vector = (struct octep_vf_ioq_vector *)data;

nit: there is no need to cast a void pointer.

> +	struct octep_vf_oq *oq = vector->oq;
> +	struct octep_vf_device *oct = vector->octep_vf_dev;
> +	u64 reg_val = 0ULL;

As it looks like there will be a v3 of this patchset,
please consider arranging local variables in Networking code
in reverse xmas tree order - longest line to shortest.

	struct octep_vf_ioq_vector *vector = data;
	struct octep_vf_device *oct;
	struct octep_vf_oq *oq;
	u64 reg_val = 0ULL;

	oct = vector->octep_vf_dev;
	oq = vector->oq;

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c

...

>  /* Tx/Rx queue interrupt handler */
>  static irqreturn_t octep_vf_ioq_intr_handler_cnxk(void *data)
>  {
> +	struct octep_vf_ioq_vector *vector = (struct octep_vf_ioq_vector *)data;
> +	struct octep_vf_oq *oq = vector->oq;
> +	struct octep_vf_device *oct = vector->octep_vf_dev;
> +	u64 reg_val = 0ULL;

Likewise, here too.

...

