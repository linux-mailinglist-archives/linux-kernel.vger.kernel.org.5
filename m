Return-Path: <linux-kernel+bounces-76555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94A85F918
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA611F2664C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6212F393;
	Thu, 22 Feb 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kG6nU4Z7"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644412DD93
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606968; cv=none; b=sJQQWoGHbZMHmgzMo4Kj3SjzVg8VEFZvvbdyTyyjtoE5CPU9T7NUgTFM3nMSG7AUVqR6PgNm34JIYv8slinl6XlNuhk425bSghBKGHfnO0AYaxZEdIeegZf7bGdvqOvVHHkDAU3kviVZOmoqL9gWIiY1IFNpic01+PKuHmGJb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606968; c=relaxed/simple;
	bh=mLihlxLtwpBjewJipEa6FRB39ptkzFSdsuzkpNHKxJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtAlj4TO+5mXL0Y69KxqZcMgLo4n9Pa483sb5v8/FUiUaAanPE+Jq9Hh4EagIe1AEpPpX2GZmrScG6ZD7kQK83MPbLnDtlYO3Su82rfxo0KsP9v5DQKhrMGfpzFO9i3lRKLLvf95TU179nNXs1pnKF/AI4qRImscueQ9KFGn3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kG6nU4Z7; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68fb803a4c8so3458216d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708606962; x=1709211762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5AaVii71/VY2wZ+q8F0jNvSLMQ/WesHh9hxpdt+FDPE=;
        b=kG6nU4Z7+Q6FCz463hLsA756uwb15cy542whL12gyDB4rgN8f7anLjDdi0ntm7SzK2
         r3dNrCWKpP6gRFDjSxaLeg7sx4x9EgLzKV44m/Wt7KIsjfHTWHFiseYP4FJwgTcaxyGZ
         ojwQiCz8i8FW4fzcczIPtm//dbX3YhF9aG1DdNrYtQZ2TtPx57SVauEdvwoGxygS+SLT
         AmZWVQPDM+lNNB2g+0dkBqGNv4CCegMayaSA6Nul2jc7KJrLoQaHHOFfgYDfDtfXIhvQ
         DK+3sak3puL+6TN1AnOhnBC8JoQLVPgGESNhhm6Dmwta2W699g/kBYDnnN8mqbIkPuhf
         gKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606962; x=1709211762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AaVii71/VY2wZ+q8F0jNvSLMQ/WesHh9hxpdt+FDPE=;
        b=YpvpeeKeKwas2Xtd2dv83sbrv6qdCmhrdGnYP4oVThPCif8qAIq8vqZqzaKvYt6CPV
         fQL3MsYi4bms0BrEICI1nyiSrcorFD8HjyubPw+vNQ0ZtcDX9EaoFr9b6EDa47e+gzP6
         J0Mo8VHZJwY/FRdtpYc13C/w4aU1DOYzbJvYIK34AnrR7IVNO7T01/kHh+BX1OlAPabo
         D9t7mboeT/6LomiJub/9Qnc6wsX940fhhHZ77NXK34zIK/+8QCtdVlK2bB2a9E32BfRC
         iqAwAHj/IJ+dDYn8l+IjPeC4bbKib4gh8bQbno0TfBF9WNBiHD0R+fgMk44bUU/0rZXL
         etaA==
X-Forwarded-Encrypted: i=1; AJvYcCUEd7swVG7Srg0LcmyXNYrZ4De/stkDuKTB/b/DqT+nwvf3sw5OF0VJ76Jv7FyIKfaMDsq4PZQlJ+ZbdWV/Ro6W2ErhWQjLZsOO88vu
X-Gm-Message-State: AOJu0YzRo9NkkAsGe5mRBrikofYD3TZ1MP/EiOWUStvUmMItJK69iDYC
	Y1t3Ckoh/jFVhj118iy3g1IMwkWarWSzX9NyyIDiVNBo0II52yIg76E5IsH0QiY=
X-Google-Smtp-Source: AGHT+IGAK7E+kzRE8+YA/j2lb1I8Y61tiNcJdozr2Qvcpk6aaDKEVgEQPQJ+SEeGp2gh8IK9zaw/sg==
X-Received: by 2002:a0c:da82:0:b0:68f:2c72:a76a with SMTP id z2-20020a0cda82000000b0068f2c72a76amr22568368qvj.3.1708606962586;
        Thu, 22 Feb 2024 05:02:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068c88a31f1bsm1309293qvb.89.2024.02.22.05.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:02:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rd8im-00G85D-DJ;
	Thu, 22 Feb 2024 09:02:40 -0400
Date: Thu, 22 Feb 2024 09:02:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	Yi Liu <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: fix the config fragment
Message-ID: <20240222130240.GA3220539@ziepe.ca>
References: <20240222074934.71380-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222074934.71380-1-usama.anjum@collabora.com>

On Thu, Feb 22, 2024 at 12:49:33PM +0500, Muhammad Usama Anjum wrote:
> The config fragment doesn't follow the correct format to enable those
> config options which make the config options getting missed while
> merging with other configs.
> 
> ➜ merge_config.sh -m .config tools/testing/selftests/iommu/config
> Using .config as base
> Merging tools/testing/selftests/iommu/config
> ➜ make olddefconfig
> .config:5295:warning: unexpected data: CONFIG_IOMMUFD
> .config:5296:warning: unexpected data: CONFIG_IOMMUFD_TEST
> 
> While at it, add CONFIG_FAULT_INJECTION as well which is needed for
> CONFIG_IOMMUFD_TEST. If CONFIG_FAULT_INJECTION isn't present in base
> config (such as x86 defconfig), CONFIG_IOMMUFD_TEST doesn't get enabled.
> 
> Fixes: 57f0988706fe ("iommufd: Add a selftest")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/iommu/config | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Appled, thanks

Jason

