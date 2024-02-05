Return-Path: <linux-kernel+bounces-53194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E084A1F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6891F23A62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220847F76;
	Mon,  5 Feb 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuRQ3FRA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826814176E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157041; cv=none; b=OkevZWXXdcgdA2CXKiPr82tkRIZY8iNCPoIG5psUbuqS5YG0MJssOpD8NN0EuGX0JFZ0brLq8NUKWwoWdSkOSIVHbXuYiRa4m1QL9d2XaezlvWEcR2S8tj+wvNmq6mbCrVFeA6xP0i6pq8KyAAASS2yA2O4MmYVm1qho7aJg9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157041; c=relaxed/simple;
	bh=LhCS1ICE+lBvaO8YlYfviwFJHIwlCBRFxZftdvpWuMY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tvl7JbbF8E1eklyCT/UtuYuyWAvV9MOwU5TNFPpussxDwU+yFxz8QuUHssBh5bWzEEz5d3tXgiZzADGCJ276yrrfn0ozBhVVTfOJT8G+hCriqzpsMj6FnnDyijyNjmokvOlqoDEI/hpBjm3EbRxyd7YKwuVNqQBLUbcLNrIsZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JuRQ3FRA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d93b982761so33405ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707157040; x=1707761840; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX9WAPSzH4fqkr2cx56EeyUyPmftS4JQYp9iTqHs4jU=;
        b=JuRQ3FRAO5KqkFSyNJ57C7L+keeBWSt180ENAKkTF5zE+hNHvZ4dRLm2t2M005zKm7
         W7oaghoG8su8AJzsZuVMA/0n18Mm3ddraXGEoqH4BINHoz2DWb3jXIljeygm387K7JWe
         eXgmyTUcYoi+A0zThyw9ynjDnYNFRSKPyeWCukKaAfbnQLIv+vN6nkZ3IH0ux1+ALWwr
         luOJwdvlsdB7WnjIECMQ2d2PedtjzZhCItNBeuhE2dAOu5FEHVQjU51l1opnDnCLvBpJ
         S/mg80CSE8YkfM26yVlq3JMDuKJXqB1M5l8G1t3w9Xw14+RNOFiV9sL6DJtKy6uoSdC6
         sXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157040; x=1707761840;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cX9WAPSzH4fqkr2cx56EeyUyPmftS4JQYp9iTqHs4jU=;
        b=R2MKrlEItw4UrvOtOz+lJphXF03gYXF76jvT8K9LuZhf02UNtvS49Z2TL/A6yeMqR7
         RLa+ayfxzGLR3N7caHbjOMlHydD4SWiTSHweGVFlpA8jDvlCjnaA5HaVnmSHkuHLeqjz
         0UauY9xmFRktrLhdyPCgphIke9EgRVIGx3RMsLZGTSJ6E3wca6/RiviswkypmEQOLhkC
         jWGIUZ1sw1cq1+NOs7wvPfsi/0f4XXOteGpJznWr/R4wHZ0dsBfi+1/vJDtCa6Zg+XiR
         /qNVmRUuRYozj2ls6wLRpD3/qIRWpevhwBQuVkzU7TbxM1czGGjgJW0E4KTwYZAKwOPc
         7v6g==
X-Gm-Message-State: AOJu0Yw98a8zTPfn1m0QltmfPzg8X844ENbJIf7bjGFIglBDbbDCLRUq
	p3mLgvDbdztlXOmGDqm7hMAL3xiRIhGJlndSd4ftcjNzfGQbUrEo+hAT0csC9A==
X-Google-Smtp-Source: AGHT+IFD2bxvnxC7BpQTp8KmxRVWUA+M/qBIDa14XXXsuIVQO9Nh3SCU2daAzOIynb5YUxw92RfoxQ==
X-Received: by 2002:a17:902:d4c5:b0:1d9:3524:3db2 with SMTP id o5-20020a170902d4c500b001d935243db2mr18895plg.11.1707157039512;
        Mon, 05 Feb 2024 10:17:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsxPxLfa2k54v4x5TlGXwZXe1WxnrM5K3MasLtL0cn2JrO90COHkhNgnl0vzB4rw8viOinysHy90WT9cQUFcQ6O9UaCggIf1lU7qbfzQDBZr030iGczwa7K6KT+uEu65oRoPDEplBeOa5TyGGVStwXwXfNYunUe9lZ6ERNKkEcf+gIeacpu8Vp/L6J9PPeAzyzvPUatk53kMeBle07NNZjUZpDKOKwY4hBjLe+1Z25eVfNgftx69+ucJk8fRrb82c/zsKOFSYIV5F4cjUCdfSemDq6
Received: from [2620:0:1008:15:1e99:232a:d721:3dff] ([2620:0:1008:15:1e99:232a:d721:3dff])
        by smtp.gmail.com with ESMTPSA id ch11-20020a17090af40b00b00296a265acbbsm2117063pjb.25.2024.02.05.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:17:19 -0800 (PST)
Date: Mon, 5 Feb 2024 10:17:18 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
    iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 2/3] iommu/iova: Reorganise some code
In-Reply-To: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
Message-ID: <0ffc92e6-9640-293b-8fbf-b2e45badad91@google.com>
References: <cover.1707144953.git.robin.murphy@arm.com> <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Feb 2024, Robin Murphy wrote:

> The iova_cache_{get,put}() calls really represent top-level lifecycle
> management for the whole IOVA library, so it's long been rather
> confusing to have them buried right in the middle of the allocator
> implementation details. Move them to a more expected position at the end
> of the file, where it will then also be easier to expand them. With
> this, we can also move the rcache hotplug handler (plus another stray
> function) into the rcache portion of the file.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: David Rientjes <rientjes@google.com>

