Return-Path: <linux-kernel+bounces-5130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F078186CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D51F248E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE269168A7;
	Tue, 19 Dec 2023 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owi3TJxZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984F1CF83;
	Tue, 19 Dec 2023 11:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CF6C433C7;
	Tue, 19 Dec 2023 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702987198;
	bh=Slc/Za9XYBMhPi7UfoEhTPhvfB8X5HymBGZAjUc/RO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owi3TJxZmRC2AiSyycVpF7FIucUKejgeWXDjtkjs2seIG4auDL8f/V4/Gqy4pBI8P
	 JnjpxtYFkDxDTdQBYwe6D7FcTllZ8pFxa+BBeqhN8eY6ExPtPbQnOJVDMtA/ANXIv3
	 +XW27BH/NAYTyIOtyYhyNJArjbA1gnPmvO52JhMGE9NJMXbtu0B5cvyu9xr7vuxs3S
	 GH9TA14JlWX+Oz3lalq0HpKDCsHFVUq+Dn6/P7ldEIKLESji+60E2HDdPyD6EgFBDQ
	 Dsn/UeoYqXOWUJ/jy5jH9qatodlw94CGyvxaEll7WEdhGQ4qdA5Gpd7xsaLFM1yxpd
	 3/jYNY4JOQnCg==
Date: Tue, 19 Dec 2023 11:59:52 +0000
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kgraul@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, raspl@linux.ibm.com,
	schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 07/10] net/smc: compatible with 128-bits
 extended GID of virtual ISM device
Message-ID: <20231219115952.GL811967@kernel.org>
References: <20231219084536.8158-1-guwen@linux.alibaba.com>
 <20231219084536.8158-8-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219084536.8158-8-guwen@linux.alibaba.com>

On Tue, Dec 19, 2023 at 04:45:33PM +0800, Wen Gu wrote:
> According to virtual ISM support feature defined by SMCv2.1, GIDs of
> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
> long. So some adaptation work is required. And note that the GIDs of
> existing platform firmware ISM devices still remain 64-bits long.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

...

> @@ -1023,9 +1041,12 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
>  	if (version == SMC_V1) {
>  		clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
>  	} else {
> -		clc->d1.chid = htons(smc_ism_get_chid(smcd));
> +		chid = smc_ism_get_chid(smcd);
> +		clc->d1.chid = htons(chid);
>  		if (eid && eid[0])
>  			memcpy(clc->d1.eid, eid, SMC_MAX_EID_LEN);
> +		if (__smc_ism_is_virtual(chid))
> +			clc->d1.gid_ext = htonll(smcd_gid.gid_ext);

Hi Wen Gu,

The type of clc->d1.gid_ext is u64 (host byte-order)
but here it is being assigned a big endian value.
This does not seem correct.

Flagged by Smatch.

>  		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
>  		if (first_contact) {
>  			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);

...

-- 
pw-bot: changes-requested

