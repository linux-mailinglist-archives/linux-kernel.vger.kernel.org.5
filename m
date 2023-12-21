Return-Path: <linux-kernel+bounces-8569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239F81B981
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF0283825
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F87360AC;
	Thu, 21 Dec 2023 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fB/4g4yO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330A360AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703168771;
	bh=vbn1EXleyZtDuKIke5KjfSmPkONCiF542/aWo5ip2Jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fB/4g4yOJMpQcH6ewX7Xagioop7Ych+Y1RJftKahCduDTcXMz23/t/HANQilLvoAW
	 GCoAopo4J6TTU+Nf6+9CmVbtSmHKQj1SAvqkHoYyi8PHNrh5BxPaa0O3sBgNBeV8h2
	 eGCUk8AcomhsE4NP6yMxFxrInBgMABF0qHxUxDhf8eAAQSuc+q2P+GiT9o+mDtvpn+
	 k8xp5Z2yXyzZL4iDgufqcKlGPGzlrQwov6lgrOgU+smk5+MQvSWdUY8N+j5Unn7Raf
	 ZT0e6HNciac8L29nbBbCNO+5fbtJwqEI09C42m3ke4K4FOxdH9DVOHLz31J1BpLiaw
	 5w3XvSdXdivHA==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B5A63781FD5;
	Thu, 21 Dec 2023 14:26:07 +0000 (UTC)
Message-ID: <981a49d2-19ed-21fb-77af-ba9684a60cc3@collabora.com>
Date: Thu, 21 Dec 2023 19:56:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/ci: uprev mesa version: fix kdl commit fetch
Content-Language: en-US
To: Helen Koike <helen.koike@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: daniels@collabora.com, emma@anholt.net, freedreno@lists.freedesktop.org,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 dri-devel@lists.freedesktop.org, quic_abhinavk@quicinc.com,
 david.heidelberg@collabora.com, linux-kernel@vger.kernel.org
References: <20231212160448.883358-1-vignesh.raman@collabora.com>
 <CAA8EJpro5Hb0yRaxPWzBQBikKjw9JnNVkUuPFvWeXjegzCuxHw@mail.gmail.com>
 <e747581b-d5e0-4622-827b-48fb51fa9711@collabora.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <e747581b-d5e0-4622-827b-48fb51fa9711@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 14/12/23 17:50, Helen Koike wrote:
> 
> 
> On 14/12/2023 05:00, Dmitry Baryshkov wrote:
>> On Tue, 12 Dec 2023 at 18:04, Vignesh Raman 
>> <vignesh.raman@collabora.com> wrote:
>>>
>>> build-kdl.sh was doing a `clone --depth 1` of the default branch,
>>> then checking out a commit that might not be the latest of that
>>> branch, resulting in container build error.
>>>
>>> https://gitlab.freedesktop.org/mesa/mesa/-/commit/5efa4d56 fixes
>>> kdl commit fetch issue. Uprev mesa in drm-ci to fix this.
>>>
>>> This commit also updates the kernel tag and adds .never-post-merge-rules
>>> due to the mesa uprev.
>>>
>>> Tested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Acked-by: Helen Koike <helen.koike@collabora.com>
> 

With this mesa uprev, the virtio-gpu jobs are not getting created and
other jobs are not affected. The issue is identified and fixed, will be 
sending a v2.

Regards,
Vignesh

