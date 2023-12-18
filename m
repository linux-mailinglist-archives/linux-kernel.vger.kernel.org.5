Return-Path: <linux-kernel+bounces-4259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0B8179FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B15C1C2308E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90D71448;
	Mon, 18 Dec 2023 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duhDDjH/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6A26287;
	Mon, 18 Dec 2023 18:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79AEC433C9;
	Mon, 18 Dec 2023 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702925249;
	bh=MNFpGtT+UDTrh+CtH/56pWdeRMJBi6mOCBVEoln6zPk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=duhDDjH/pkjlzzSF5hSbzWfVyBHh5y4eEVQPfd8Ew+i34CDgDiqcdy9XYpKW8FK8x
	 pm9jt9QzWfC4TyqVDv9GJ09DigCsTkIfcegcBLCqKhGkOCDA1NQ1ZUU2t2w+8QdxsI
	 EC0ILgNSRzU4zpM2XhjjW2XejeKFyCh09+pj2r8XT8CMKnbsN4P5MUKND28vpHdt3u
	 VUxULwBDqNKChmhFVg7Gu/BcASIPx8tgwZ1+1cA+exEJ4mRQTK4pXwi35DGMVGtWRO
	 wEVKlFidpkQtdQHI7yBvvfmdBMvI3JdHdl+n7ipDCB25UoI1JOFzrMMJFsWfA+TC2V
	 NdSYAhAvCPU4w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: ath10k: use flexible array in struct
 wmi_host_mem_chunks
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
References: 
 <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>, <ath10k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170292524618.424292.1640750049894446616.kvalo@kernel.org>
Date: Mon, 18 Dec 2023 18:47:27 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently struct wmi_host_mem_chunks defines:
>         struct host_memory_chunk items[1];
> 
> Per the guidance in [1] this should be a flexible array. However there
> is a documented requirement:
>         some fw revisions require at least 1 chunk regardless of count
> 
> To satisfy this requirement, follow the guidance from [2] and wrap the
> array in a union which contains both the flexible array and a single
> instance of the underlying struct. Since the footprint of the struct
> is unchanged, no additional driver changes are required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

6 patches applied to ath-next branch of ath.git, thanks.

d2eb318f4b6b wifi: ath10k: use flexible array in struct wmi_host_mem_chunks
72ca7c4073ac wifi: ath10k: use flexible arrays for WMI start scan TLVs
26eb704a46f8 wifi: ath10k: remove struct wmi_pdev_chanlist_update_event
b0c0794b05ec wifi: ath10k: remove unused template structs
cb188e862c1c wifi: ath10k: use flexible array in struct wmi_tdls_peer_capabilities
6b9923f1f6d1 wifi: ath10k: remove duplicate memset() in 10.4 TDLS peer update

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


