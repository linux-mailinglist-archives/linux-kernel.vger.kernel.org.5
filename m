Return-Path: <linux-kernel+bounces-55881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78584C2F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D3E2890C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87672FC08;
	Wed,  7 Feb 2024 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK9gWW37"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A79FC02
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275600; cv=none; b=OnwyA1DYUhs+EhEjnVYwz0W6e7mDCHZ0ayYREBOQ5+aMElWQlxXOGfd/+oDO5WG/11JAelKQgeNKvCN9fzv5K9KPfAwa+eWbbFrCRLpf7nAdYzmiEHaPDgWRbnzaGkMBJJRZIiujzmL/FDb1twd5jvoz9QcDBhtQXhoIllwu224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275600; c=relaxed/simple;
	bh=qLTvqD/ssU4qZJmW1fUoq81bEGmNuhl5i23qQLLkIpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2VsOQ2DG9m/6c94k4KkifokwVfjI7bjF2oFCXkAyRZ21yIrrHz1Uyz5kN71q+rdlE6Gqwlk5ZeXlLSwZvNoZR/7qfJPJ1dH8TsHjbdBCb++zMVoab93KG/cMvl5BlmfajYchPPJFXYTU+ob4yYQ1tUBqbCWIAs149081mCeoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK9gWW37; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e1214ae9d4so50100a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707275598; x=1707880398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZa2rDtQygSVd/zKMjyhQzpij43YQZ3f+RmrbEh9TGc=;
        b=IK9gWW37oD7A2YNOT9pCTSacwW+3UQLb6Ocjj1VDYiF+rfaxACsLnb5X4eSjeUn1MR
         hoqUYrvdpWcP5L0Eo+LVtx+F2iVWgt6fFBvlT6I21W5nFj63ur/5DPut9fgIEXBdg6Ox
         a++21eTxKUQj9DgtU8aRWpgjhn7qkx4wFaGLc/rLWXU5s2Yw4xEnekMChqmBU9PXTuRo
         5sjxxZbmtHL5ENfCHDt4S5oUBnGJL7myATs/MBnFNPrlBp2iMyZ0H9toHSHfFUGuDYyr
         5z1XkyEEpIriVF5D2ugIwwxXscUQ18bEB8QgDWI6CDJ8y4s9Qq6eSb9b8A45jgqsSq94
         7Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275598; x=1707880398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZa2rDtQygSVd/zKMjyhQzpij43YQZ3f+RmrbEh9TGc=;
        b=aVMCYyA9Jk21F/ADZFQ1TbefeyiL5sA4kq/Sly/71Zw1JrzerTxqVGBDmYJz3ERRsb
         hThAn3RcEoH/o21dw4b4y9dtrS+uhU8iSd1SjqyzJuaIgWWKsK1ce2K4Ac1I9Qz1nnCx
         vLAuSZ1Gc3crdrU2IEpFhDMrK5HsaApNtXr/WEbB50qKI4PXwBxrdGBXeco1gmKnpGb7
         OLs2xkod/2vS0kVxLyYzeW1u7/TyayTQy61B3h4bSp+G1yLVsJWk/WUCleJstiTRFiQk
         ahnj+l0GAX03eGwK6e0J5nTlTqIlH/KiFtB4E6sat96HZDATyLoI0E6AnlG9Zt6Vq7op
         J13Q==
X-Gm-Message-State: AOJu0Ywbi0pkCm1FQPlG8NlOv/btr+4ELVTBqisN2OYIcCcbiEizpapy
	+Bj4QVgu5YheSs7oQwmGV82hKaZt0q11JPHy97Yw4AqiqJdcE/hYvhLjkyQcr5E=
X-Google-Smtp-Source: AGHT+IGwIPMor0Ue5yhPu9dVznv0djj3c41mGTsQsVxLOFnBlZD8fpLhpx/T2n3beX4dmuhIhxLNcg==
X-Received: by 2002:a05:6358:224d:b0:178:9393:176b with SMTP id i13-20020a056358224d00b001789393176bmr1563416rwc.16.1707275598258;
        Tue, 06 Feb 2024 19:13:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxp6Q6f9Wjf0/McXuRvi5WJYdC1h/9TqdiaVJ+Z8BCkz9I9iVWCXKSWoer5EFANET4ILIlJ4wIJWStTJjOjZwxn+UgE8DQA2Pl8YY6SSn3bcB6uwB+qzw+7bMPDvvPv2+9bxpLzFLsu9WlHhx1yOT8dKbX9YKwKYB03aexmjLCuJa1bldMi9rt/32uMuSQI3Z2gejisKIxTKtP25vEdo5rp/ZkIFuGaJzQAByVSjybm0MRPoQr6bAPmPd3/SsA
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id sw4-20020a17090b2c8400b0029608793122sm333228pjb.20.2024.02.06.19.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:13:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Feb 2024 17:13:14 -1000
From: Tejun Heo <tj@kernel.org>
To: yunlong xing <yunlongxing23@gmail.com>
Cc: Yunlong Xing <yunlong.xing@unisoc.com>, jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org, hongyu.jin@unisoc.com,
	zhiguo.niu@unisoc.com, zhengxu.zhang@unisoc.com
Subject: Re: [PATCH] workqueue: Fix pool->nr_running type back to atomic
Message-ID: <ZcL1SofG_uul0732@slm.duckdns.org>
References: <20240206080024.2373490-1-yunlong.xing@unisoc.com>
 <ZcJj2dUUyAY_7XFS@slm.duckdns.org>
 <CA+3AYtQBci3WgTfhSA-8V34qWbnQ23V86rw7rGArGqStdpnVPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+3AYtQBci3WgTfhSA-8V34qWbnQ23V86rw7rGArGqStdpnVPw@mail.gmail.com>

Hello,

On Wed, Feb 07, 2024 at 10:06:56AM +0800, yunlong xing wrote:
> Yes, WARN_ON is triggered. The reason of  set_cpus_allowed_ptr() fail  still
> needs to be further investigated.

I see. Please include context like the above when posting patches.

> I was originally planning to inquire workqueue whether or not allows the worker
> that associated with one cpu running on the other cpus？From your reply，the
> answer of my question is not allow，right？

Yes, you're right. set_cpus_allowed_ptr() shouldn't fail.

Thanks.

-- 
tejun

