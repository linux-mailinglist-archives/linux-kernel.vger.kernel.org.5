Return-Path: <linux-kernel+bounces-64756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC185427D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478F31C2435D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332B10799;
	Wed, 14 Feb 2024 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olwoA2tA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726133EA;
	Wed, 14 Feb 2024 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707889339; cv=none; b=uvJgiwzfmKUZk0bajge/l32k9ZUAFzTyB4If8lHFzGURlEAoXfXEio77pkR40wjKNRH+lunAQKZ4EiY+v47mYjIxHGnr3MiMLChG4QC9CBBofvm3rh9YdgaPLZM6LFjtGW3doyjpGZr32ai/BGOggc0AOPB1DolW23Gbatjdohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707889339; c=relaxed/simple;
	bh=4mDh0LX7kjicHsC+/bogzJBPJ1vYaIpsGeKF5S23PFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJisoaT1frzfWLKRuXUkMbUA3b/HXpd9QLgPf7XmDQxSUj/jB/e/lYwsOGAKaqtszfK7BZvYTtZSJnEh9Xlk1Jy+2Rr/F1yQFTL0SYkTdP7vTE9tqcMg3vHrzt15vm0jwecLjf7MfNq0ehnis0uyqocxuVKUYSKSx89Eq1tKNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olwoA2tA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D31C433F1;
	Wed, 14 Feb 2024 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707889339;
	bh=4mDh0LX7kjicHsC+/bogzJBPJ1vYaIpsGeKF5S23PFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olwoA2tAvRitfGmHoVY0DqilINYX9nwBfOyF7olEZcMqx33n0FtBZWIgYQgJCaGxl
	 exJUOUaJzi7Ssc3LMxh6CGIgOZyDtszGRinH1/oD7VING9JhKh5Demig9tCgV4UzH+
	 6+zVBaL5wt/3ZYigGrAXeJK7TmLZVHv1VNwolH+c9VTX4CIXpWjP1nuhifk5Ky0UZJ
	 rVujQVWmBoxY6gKOblG88WN2ZJDYWzP2EbFD7aZCpT9N0UVV4sv9e+tSkE0ToAY1vq
	 rx0sNpYOF3pIBRiE9ULnQUmEXcdCsOCZe5VCseayKDQckiijX/y6Axxe20LQg6uNd3
	 MEDY2FUHMijAg==
Date: Tue, 13 Feb 2024 23:42:16 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Auditya Bhattaram <quic_audityab@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
Message-ID: <y6em73mzbh47fzpgfvfsrypw5ktgt6zaqfujscaxkjuqivlxcr@vcke7w4omq7b>
References: <20240213080010.16924-1-quic_audityab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213080010.16924-1-quic_audityab@quicinc.com>

On Tue, Feb 13, 2024 at 01:30:10PM +0530, Auditya Bhattaram wrote:
> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
> is found. Add an upperbound check to phdrs to access within elf size.
> 

How is this compatible with what is being observed on SM8450 and
implemented in commit 8bd42e2341a7 ("soc: qcom: mdt_loader: Allow hash
segment to be split out"?

Regards,
Bjorn

> Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in any segment")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v4:
>  - Added additional prints incase of Invalid access.
> Link to v3 https://lore.kernel.org/stable/1c91c653-cebe-4407-bdd6-cfc73b64c0fb@quicinc.com
> Link to v2 https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
> Link to v1 https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
> ---
>  drivers/soc/qcom/mdt_loader.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 6f177e46fa0f..1a79a7bba468 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -145,6 +143,13 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>  	if (phdrs[0].p_type == PT_LOAD)
>  		return ERR_PTR(-EINVAL);
> 
> +	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
> +		dev_err(dev,
> +			"Invalid phdrs access for fw: %s, e_phnum: %u, fw->size: %zu\n",
> +			fw_name, ehdr->e_phnum, fw->size);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	for (i = 1; i < ehdr->e_phnum; i++) {
>  		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
>  			hash_segment = i;
> --
> 2.17.1
> 

