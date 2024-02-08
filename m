Return-Path: <linux-kernel+bounces-58324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321884E4B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC8B283AC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DB7BAF2;
	Thu,  8 Feb 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jk6kzPpi"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB47D40E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408576; cv=none; b=PVTW8lCP/U7S7ga+yV8oXTTMTkioE8tv83xAIc3mATT48MObN0AzUqY0BoUAeWETk63siFa+0RQiO7z5AGv9uj4smF82Vqq4inT2m+mZNc6IoP3Vo8WldgHTLnyiemGUZmvKnNeNzxIOlJ3wqLXuwnJO2V4OLcobhbKdvp6F7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408576; c=relaxed/simple;
	bh=aA68IYVKcNH83wAWFAiDF7WtWkrD2FpXaZIUMkfZUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucXBfXhCxDkQ0w1Tc3wRT6bwmWEe3ADbEuK6n2eoP4GUNC/NGQLy9KkvKcNzlRwApmGsuDcNJjVTbSA/z3ZHr5CDOdISQJVZ/xwHG72L1K+1NcZRvs+IQkzVDDw7ki1KDn8TRXXgjcvGiJyPyi3fDhmHno1dX3Fdm6xNZI6lfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jk6kzPpi; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-214c940145bso1066671fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707408573; x=1708013373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aA68IYVKcNH83wAWFAiDF7WtWkrD2FpXaZIUMkfZUgc=;
        b=jk6kzPpihUW+1yL2IHprOjV/0yxcCpxDnE+0bZeWJro5n/S+ljtZH5DPBUBiVrwcIZ
         UKk42gUZLTdpQhVXtoq7cB6plcGkGcQ1p85c4j33BpMZLJHBH84L7yBptDbGYKWPbmgt
         Sh1/XX8ZwMNa/18E/djOqlFO6P8T3lX9w/cj4MBAHmp+i2AsiPbB+Y8Zi436EQO8u12o
         +5bfM8i7YabVhHCvUX5EnVMa2XuJ/4/3nk98eyeVu75Vhy2ReCqZgXRJqiBs26U5vej+
         Yg6NG1u+N8OYI6lrnbd9YsshLoQxSgzVVTqRBjuHhinS36cmFxwZSaTjuEeq4CesWCUY
         Pqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408573; x=1708013373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA68IYVKcNH83wAWFAiDF7WtWkrD2FpXaZIUMkfZUgc=;
        b=HOFeKHiKH378q/Ei2mYelkequDpCFuBDcFxNSDk5Oo9PM87/yQ+clGs/er8Fxc98kh
         dT0MlfVIRRIEYCdM+ZBEnHjqH88fWnwVacccw9F0zkSX3Yf9jfzYbUKhhHSu328di6vz
         4eDd/Xxo8SWH7VcHL9cthn9dBdF5cHGW/XDbMvaVShYaNZN8HhrGgFLwLOsEvcg9GcFE
         D9beYF2Bl7WtAp6Bt37Gc8XSXvKrPEUQaLccBVOL9loipdPxDa9SsPwQDu8N+buQP8aM
         yXSDx9ocmObzt5HNN70eeJIHbDGPnxJXoPsxzHXAZuAr3avrQqbEdL0LYyGNwFcA14kF
         ILkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUI4pwSwbiNuE70ADaCpDHO0xi5tI4363qLKf3/YM/uyU3YQqu5wX31l1pzApJp3nvMy52ECnwhNUzoxWV9bIu78hzeFJ8yOjj92le
X-Gm-Message-State: AOJu0YxnabHJFqjgexmRIZVa9QsILSGV+seBna8nMGctM61bQHzEPF3d
	gQKXKGU56vesnNJcnJD2+XtnADA8BfPy8LGuUSjKUWI6bZTmf1NJnPHlLTiweVY=
X-Google-Smtp-Source: AGHT+IErIu5NJVT0hLIHW0fj+It0NY8NAUd0q2LBBL3NnmeMbz2sfYWipPYkByL/AMAQc/lEsNvDeQ==
X-Received: by 2002:a05:6870:1696:b0:210:a32e:e7d5 with SMTP id j22-20020a056870169600b00210a32ee7d5mr10283269oae.36.1707408573724;
        Thu, 08 Feb 2024 08:09:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBsHol45yKoashMGQhkc/ZTmzPGkNoZ++2p0ShvaFoPWGrfOelckT9dqTmS4wjjoV/hOiM4t6sQarfrrhhe5BCELoSeiyNUaH+VdQhpIE5DK+KmZb2oYkGgB6Y5WpSyct9kOkpP/kiP2V8XTobJYBqawgaXmM1zL+BDYvKAkRA6MnquX3Sm+I8vC1Qzn7GWAQXAaB0vetnk7b00v3T9H9f
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mt15-20020a0568706b0f00b00219a1bf0e44sm792408oab.47.2024.02.08.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:09:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rY6xw-00Ezhm-Gh;
	Thu, 08 Feb 2024 12:09:32 -0400
Date: Thu, 8 Feb 2024 12:09:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240208160932.GT31743@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
 <20240207145656.GJ31743@ziepe.ca>
 <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>
 <20240208011305.GM31743@ziepe.ca>
 <a93e93dd-5cb8-48ee-bf8d-b3bbb19507d6@arm.com>
 <1cb6a33f-57e8-f3d0-9098-755af70cda41@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb6a33f-57e8-f3d0-9098-755af70cda41@quicinc.com>

On Thu, Feb 08, 2024 at 08:47:42PM +0530, Nikhil V wrote:

> Also, as Jason pointed out, this fix would not allow changing the
> default domain for an iommu group. We didn't have any usecase for
> changing default domain, hence couldn't see any issues with the fix
> proposed. So, we would have to rework the patch for it to be
> upstream ready. Any suggestions for this would be really helpful and
> appreciated. Thanks!!!

I think you can lift and duplicate the check into the callers and that
way restrict it only to the probe paths.

Jason

