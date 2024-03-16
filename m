Return-Path: <linux-kernel+bounces-105241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8DA87DAFC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2166BB21523
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76E1BDE2;
	Sat, 16 Mar 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O82n/udP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAE1BDCD;
	Sat, 16 Mar 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710609443; cv=none; b=tuSwe7+ywvco/LknIE1RVl/s0Bw8fv2Mhf174JtHcqunCd5KFuIIXJzdSmqCIdnQq8GhjJ+okh/17VVmKggJ8RJmgKbLO990oJTYO9fI+pL+AbbS4qIQeODE53jy3QXXncHzjii8yjPkwTZplSYDtGMVvmR7WNaWv0LaZ1Z2Wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710609443; c=relaxed/simple;
	bh=Y7MMok4/WVkHSrSRtc7DvUedfEzlbaDNki4+7DUNy14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMMAzunRJ/D458aaDbIcfK8dr59bqgXx5ydGfK2oW80oiDKVGQ42jp9ofJgQSbsxOv+Ds+vQDbY8VTPVFK2iYzyu1jP2H+0sKrPtZulEGoIRfFQ6eZgmdkkGmGKKCSDeDoMfRdVEm9WaCMviLuD99tQv76C/s+nDBq+SxIZZ/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O82n/udP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F13C433F1;
	Sat, 16 Mar 2024 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710609442;
	bh=Y7MMok4/WVkHSrSRtc7DvUedfEzlbaDNki4+7DUNy14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O82n/udPHZsXGhrOdHp3YwXVBKYHxRyitzXa2IawL4hHCDHHLB8igqPY+jmI9AAO4
	 aBbU+ZhdDufIrPkF/YTLhMIp6wusPe+zgWhdR1wFQBuF30AeB7rBMuTFtj3FuwQHpc
	 tmRSXD4SCG06wfbGaLSvcW+n6vw76xFNI4JLRCxGu0ZpJxXe2z75rsxD+7e+wa7lNP
	 X3gP33ZefdASj55rnVFR5fEdm3eRbqrpveeGksGmRZXWL0Mlugn8pF15eMGrUyfPG3
	 PYc9glpMLnvSG0hP3f1wzdQMg4XTJQHIp6CFK42Xgz3PTGtiTLe1PWA0IjMl7Zy0ku
	 l+SRWl3cfj7Gw==
Date: Sat, 16 Mar 2024 12:17:20 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Auditya Bhattaram <quic_audityab@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
Message-ID: <2m2sbrg2d667ciiiog3nekfjt3gfn4na64avtp6yctxasejtal@6pipid473s7h>
References: <20240213080010.16924-1-quic_audityab@quicinc.com>
 <y6em73mzbh47fzpgfvfsrypw5ktgt6zaqfujscaxkjuqivlxcr@vcke7w4omq7b>
 <38e6cf32-78fc-4a5a-a98c-18b126bdf50f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38e6cf32-78fc-4a5a-a98c-18b126bdf50f@quicinc.com>

On Wed, Feb 14, 2024 at 11:27:01AM +0530, Auditya Bhattaram wrote:
> 
> 
> On 2/14/2024 11:12 AM, Bjorn Andersson wrote:
> > On Tue, Feb 13, 2024 at 01:30:10PM +0530, Auditya Bhattaram wrote:
> > > hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
> > > is found. Add an upperbound check to phdrs to access within elf size.
> > > 
> > 
> > How is this compatible with what is being observed on SM8450 and
> > implemented in commit 8bd42e2341a7 ("soc: qcom: mdt_loader: Allow hash
> > segment to be split out"?
> > 
> > Regards,
> > Bjorn
> > 
> 
> Calculating hash_index is introduced with this commit 8bd42e2341a7 ("soc:
> qcom: mdt_loader: Allow hash segment to be split out"
> 
>     for (i = 1; i < ehdr->e_phnum; i++) {
>  	if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) ...
> 
> I'm trying to add an upper bound for this access "phdrs[i]"
> 

Ahh, sorry, you're of course correct. I think I would have preferred a
more obvious check of offset >= fw->size though...

That said, this code used to sit behind rproc_elf_sanity_check(), but
that seem to have been lost in the refactorings. As such, your patch is
incomplete and we should reintroduce a whole bunch of these sanity
checks!

Regards,
Bjorn

> > > Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in any segment")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
> > > Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > > Changes in v4:
> > >   - Added additional prints incase of Invalid access.
> > > Link to v3 https://lore.kernel.org/stable/1c91c653-cebe-4407-bdd6-cfc73b64c0fb@quicinc.com
> > > Link to v2 https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
> > > Link to v1 https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
> > > ---
> > >   drivers/soc/qcom/mdt_loader.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > > index 6f177e46fa0f..1a79a7bba468 100644
> > > --- a/drivers/soc/qcom/mdt_loader.c
> > > +++ b/drivers/soc/qcom/mdt_loader.c
> > > @@ -145,6 +143,13 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
> > >   	if (phdrs[0].p_type == PT_LOAD)
> > >   		return ERR_PTR(-EINVAL);
> > > 
> > > +	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
> > > +		dev_err(dev,
> > > +			"Invalid phdrs access for fw: %s, e_phnum: %u, fw->size: %zu\n",
> > > +			fw_name, ehdr->e_phnum, fw->size);
> > > +		return ERR_PTR(-EINVAL);
> > > +	}
> > > +
> > >   	for (i = 1; i < ehdr->e_phnum; i++) {
> > >   		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
> > >   			hash_segment = i;
> > > --
> > > 2.17.1
> > > 

