Return-Path: <linux-kernel+bounces-89247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B216486ED39
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341361F22409
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B031396;
	Sat,  2 Mar 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MOuTRwXE"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1215680
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338174; cv=none; b=NhE5ynPYFOVsrDko2euf9iAouoDefEFs+N5jt9WLG/b0phCxqVaTDGWWMkyBzHRZw45TLxdB+FCz/NEptSdYk1z/7Zly5xiKzRt1uocbld/4hdEQcxlDLEMx8kEfia0HPTvBmIwP2MYA3D5SzYVePOrrVH+QHxEez8M3t3xbjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338174; c=relaxed/simple;
	bh=dH+R3CHq13HZg3o2FiRpD3Sc4l20ml1BM78TmQhj43s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmXQaXWhKX9mNlF5opSINCCbv8bsDh6ma5AesW0xG42x/GVCWiFD8m8qxiOsNKQ6888+Dcffsl3m6OHuuIcvTlI3bFnYE4CrpnvMzLC1r37xkHIK8cj9sN4XrIKoHdmJMEvbWyHsf3AmzJKBTpPBdcvsmbalfMbml29tBW+wYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MOuTRwXE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1958950a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709338171; x=1709942971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlEMlXrKVoQ/VI5q1b4zpBL3OsqlVw7CAlvaBiVG6mY=;
        b=MOuTRwXEhIPRWgSif23piWeAVFPc+vdnbxKruPntORcbsZe7Ootk7sViJ1qaDdgx2M
         F3cD09TiuqgzusAKPhmQtslpHuPNr8SczIuJMXdnnZ9haIVfdI5Vs3KAVlvjNTx8pfTd
         yhjULxFjOZValpASY13e1gED6NXKg4FVa6fj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338171; x=1709942971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlEMlXrKVoQ/VI5q1b4zpBL3OsqlVw7CAlvaBiVG6mY=;
        b=Pfo9OPBVp3cQysYzffDBZItd8SSDNtr4bKTB+1yTMv9eocfyPybgqH0yXowSDP/Jcj
         URifFwCUbDsao1CaIpyp8h75gqkSmA1yEmEAiPAtaG7FXXCxp/h37AWTvPCpyTifu0jl
         HkKD3gJvT1zXQJqT0pxJNkiBzStGXxMbe7DxYRxuPB788DU4mgxsjfs/4N5LcH+8ueRV
         hTFJlY/3Bgclbw8VhkYKAK00ViaUHdjkCSKML7ntH47Vv58L1fK0MxeFudKT5bBN1zzR
         vxfvBI/P5uVobKtA9dxQyQEPqEr58tCT0SXgRI0qO6X4kgjjbx72eG/OsWf1v6lMV7gY
         V8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiW3eq3hA4sRpYAHqD4RD+sPC1TSUz/V1mvUBGLNTjPXZ1vb8ioi47TztmFzsYN387l/7Oh2OWXfsrG0U27TNT4jQl7j2nvFKeJ6en
X-Gm-Message-State: AOJu0YyC38Cju0NMLEIek+eTBEJPWR7lhAngrMXxd/WQaudnQy83nIiv
	U2z1EURR1eayB8soScMy83z9GbLUMDbN6gQ7pP4xXPcGIQFncTYDxHw3dkPUog==
X-Google-Smtp-Source: AGHT+IHKe06QTxKDNmVjUj7y4VmLN7+kjewYOtUfSzwCo6UhE83ZK5FaGcdZDV0lptWbQ2W8F/RMaA==
X-Received: by 2002:a05:6a20:6a22:b0:1a1:461a:36ac with SMTP id p34-20020a056a206a2200b001a1461a36acmr494126pzk.11.1709338171344;
        Fri, 01 Mar 2024 16:09:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm3611474pfn.93.2024.03.01.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:09:30 -0800 (PST)
Date: Fri, 1 Mar 2024 16:09:29 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <202403011607.8E903049@keescook>
References: <ZeIhOT44ON5rjPiP@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeIhOT44ON5rjPiP@neat>

On Fri, Mar 01, 2024 at 12:40:57PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There are currently a couple of objects in `struct smc_clc_msg_proposal_area`
> that contain a couple of flexible structures:
> 
> struct smc_clc_msg_proposal_area {
> 	...
> 	struct smc_clc_v2_extension             pclc_v2_ext;
> 	...
> 	struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
> 	...
> };
> 
> So, in order to avoid ending up with a couple of flexible-array members
> in the middle of a struct, we use the `struct_group_tagged()` helper to
> separate the flexible array from the rest of the members in the flexible
> structure:
> 
> struct smc_clc_smcd_v2_extension {
>         struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
>                             u8 system_eid[SMC_MAX_EID_LEN];
>                             u8 reserved[16];
>         );
>         struct smc_clc_smcd_gid_chid gidchid[];
> };
> 
> With the change described above, we now declare objects of the type of
> the tagged struct without embedding flexible arrays in the middle of
> another struct:
> 
> struct smc_clc_msg_proposal_area {
>         ...
>         struct smc_clc_v2_extension_hdr		pclc_v2_ext;
>         ...
>         struct smc_clc_smcd_v2_extension_hdr	pclc_smcd_v2_ext;
>         ...
> };
> 
> We also use `container_of()` when we need to retrieve a pointer to the
> flexible structures.
> 
> So, with these changes, fix the following warnings:
> 
> In file included from net/smc/af_smc.c:42:
> net/smc/smc_clc.h:186:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>   186 |         struct smc_clc_v2_extension             pclc_v2_ext;
>       |                                                 ^~~~~~~~~~~
> net/smc/smc_clc.h:188:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>   188 |         struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
>       |                                                 ^~~~~~~~~~~~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I think this is a nice way to deal with these flex-array cases. Using
the struct_group() and container_of() means there is very little
collateral impact. Since this is isolated to a single file, I wonder if
it's easy to check that there are no binary differences too? I wouldn't
expect any -- container_of() is all constant expressions, so the
assignment offsets should all be the same, etc.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

