Return-Path: <linux-kernel+bounces-55496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D184BD67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B461F252EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0814014;
	Tue,  6 Feb 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4QsKIKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359651429A;
	Tue,  6 Feb 2024 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245450; cv=none; b=FPr9YGMloOmCmQ6Kxme3F1m52Me3cCuziXbrDt/0Vcb0nW7Tt4omdUaCNEQQ0TLL2pN/eJ8eK/ggHSoPqxoI7db7CdMOm/sI9CTRP2gsbcN5K/HnH1GZTnZ0iC1GHeKqpxWpq9GcWD4ABl1DFCCBEk4GQBhFVqzZVe3jdZrGKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245450; c=relaxed/simple;
	bh=CJTu1gcSgcqV+1ze9f2bKci6UuBLQcJSCQq4p57Llm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDOJqKQzfYiR5rR1pQNwClafcZgk2AyDdCsY0waDQV924Ua6WIymt3JUFn8slHqXWOICtkCe3PgFeoYRMdSCSugATUgeHAvxyFNTNODBHWmqW6mR/GdPOla8fX6kkxv3xoB+tWFDm3mK/W+hSXKdJlRKA/9nx3gjbTKEKAh58I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4QsKIKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A905C433C7;
	Tue,  6 Feb 2024 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707245449;
	bh=CJTu1gcSgcqV+1ze9f2bKci6UuBLQcJSCQq4p57Llm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4QsKIKjshNuYvgVC/ZqgLol9oeVTbNZsur+CJXgKw+Zp+fo3eBiFpBelQGE5gwmn
	 EFVlyfrWn3VOt99VG6V4o4Sco+7lvyOuRHL/LrodMeNZ0CpNLqQavWZJD3YGuODy81
	 N2y47+xTJ2Xg0fKam1lV8e2M23Z8nLtB9wXu6FcnBFrUaB+xdXHId3EqcsfWD2SamR
	 nNobb0joXzLhs3zXzgOotvQ5XhZ87hkARlSkxMkiKLz8ZxgtLowRX0nHQtaGeizXvV
	 SOkla9kWVuCqdxobNkQeTF8PXnYddIbd3IkXkGZE8f4N7aJpl7OZJaJ2iQPPEE3rxh
	 dV1aos3wHsorQ==
Date: Tue, 6 Feb 2024 10:55:21 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-remoteproc@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 70/82] remoteproc: Refactor intentional wrap-around test
Message-ID: <nfxldxqon7xfzqvxhhspzfoueebgczjbner67vtibeeukxd4oa@xgeaofdfgezz>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-70-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-70-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:27:45PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Bjorn Andersson <andersson@kernel.org>

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn


> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: linux-remoteproc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/remoteproc/pru_rproc.c             | 2 +-
>  drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>  drivers/remoteproc/remoteproc_virtio.c     | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 327f0c7ee3d6..834249ee3dd3 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -893,7 +893,7 @@ pru_rproc_find_interrupt_map(struct device *dev, const struct firmware *fw)
>  			continue;
>  
>  		/* make sure we have the entire irq map */
> -		if (offset + size > fw->size || offset + size < size) {
> +		if (offset + size > fw->size || add_would_overflow(size, offset)) {
>  			dev_err(dev, ".pru_irq_map section truncated\n");
>  			return ERR_PTR(-EINVAL);
>  		}
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 94177e416047..b9231cf46d68 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -278,7 +278,7 @@ find_table(struct device *dev, const struct firmware *fw)
>  		table = (struct resource_table *)(elf_data + offset);
>  
>  		/* make sure we have the entire table */
> -		if (offset + size > fw_size || offset + size < size) {
> +		if (offset + size > fw_size || add_would_overflow(size, offset)) {
>  			dev_err(dev, "resource table truncated\n");
>  			return NULL;
>  		}
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 83d76915a6ad..58742c666e35 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -298,7 +298,7 @@ static void rproc_virtio_get(struct virtio_device *vdev, unsigned int offset,
>  	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
>  	cfg = &rsc->vring[rsc->num_of_vrings];
>  
> -	if (offset + len > rsc->config_len || offset + len < len) {
> +	if (offset + len > rsc->config_len || add_would_overflow(len, offset)) {
>  		dev_err(&vdev->dev, "rproc_virtio_get: access out of bounds\n");
>  		return;
>  	}
> @@ -316,7 +316,7 @@ static void rproc_virtio_set(struct virtio_device *vdev, unsigned int offset,
>  	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
>  	cfg = &rsc->vring[rsc->num_of_vrings];
>  
> -	if (offset + len > rsc->config_len || offset + len < len) {
> +	if (offset + len > rsc->config_len || add_would_overflow(len, offset)) {
>  		dev_err(&vdev->dev, "rproc_virtio_set: access out of bounds\n");
>  		return;
>  	}
> -- 
> 2.34.1
> 

