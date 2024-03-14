Return-Path: <linux-kernel+bounces-103571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82987C13B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18914B227CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB27351B;
	Thu, 14 Mar 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDhOua8E"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1B73512
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433673; cv=none; b=RI+FDvmC9Ubs1+/EaDUCGke5rHu4tM6/SAMEJrdzBHD3afS4FpDDqc4kbb5RP5VgzdArWDQu1a0O9bsshXVS863ziM7DOZFis4J/NSIbkWyDXACze3wz5UkHZzFslPOJ3yUN2qc7nHXEDBpW/oATrCFoe24RGWxsizOfHIKeKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433673; c=relaxed/simple;
	bh=YdPCr4InfP4OG9EGwglXBYsVX4V6BqWttPeipUoQlMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2bdeAsvNt1a8Js+vjziKQiw9WPLPWq74G7MQlSGYotolH8bHkk+bLUSeeL9KGgw/AWj5a7i8PhvBTyCQrL8/EHZO6jp+G789IyzX4qd0jVF20vMz9dF8GnkmvHDGVRQbWU+Xv7TA4TF6jQB6kw181ne8UDU+2YSrpOC3jK5/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fDhOua8E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dde2c0f769so6768575ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710433671; x=1711038471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCqqyqrVd1ZT9AtcPC9C9BzKjRf2o6CGP4oxyF2PKO0=;
        b=fDhOua8Eu+PW0yD3MV/CXyR5+OISMCiN68d1b3VNgrGTJ/EBLqmgmPUxUcp0mPucZB
         mK8cfuBuH52L2LxgVQw/9l3LIl9uwBrmwblJcZN88NKRAdu5jNXJDiHqQRaCXS4nPA9B
         lM+54Nct4E+snumZJEjw65k/zzN36bZyp2GW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710433671; x=1711038471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCqqyqrVd1ZT9AtcPC9C9BzKjRf2o6CGP4oxyF2PKO0=;
        b=Wt3xKglV3EhMUjxZCEk1zojdf5FXhaFAd9ctJaxb2vzqZkKSXp8bFLENMrzKQPU+ok
         f8Xki3Ma9bfKXhNs7iUz9oi9GBXLTXOOGqpSgP4/Wlh0rZ4StbQT5nblMUO3G/jRsbUJ
         YBVUwa2VuGcMKYPSbmb95E5p9VDI8aYPNva4rvkMhdan1HmMIGyre6e1g6JLSukhSl+r
         qnv/6VZOevOmdWL8hpQ9b2Pq2fltVdA+1ibnZm0ZuSzobAb2vVcgfsFrJ4bE4EQno6si
         UoPCajE7xNvvDgoK+gENV2MQz6/jEJkQgO6zXq0BAuDjZD83Le4MHj105nwlFs44u0rT
         P0qg==
X-Forwarded-Encrypted: i=1; AJvYcCUoUwsK8uJF1Gr8Xvkiil9oAcLiA/bJ4Hx8/J8nCmSRDNWHykegXpCa9GxwgjlNo8EVGN2+LHOXplL2e3J3AQpKXo9lzjVVnUlrjYe2
X-Gm-Message-State: AOJu0Ywvp4EfG28oHFdLwXO2EVuPq3rhNyzb0YChm9vjeMSfgiqxQfL9
	tQDiN/iVAHrK5Xy+5/ZWzCWCYYQ5vcYiJCzUWxROrQi2qP9DQ/6VUoe/AbTpPQ==
X-Google-Smtp-Source: AGHT+IGB+4KsUsZtAt2GEhKCBD82Z12NV2ggL3N9c8FAaT23sfhQfhvx2qsrcS+ssYSXM7KAVvrcSw==
X-Received: by 2002:a17:902:ba8c:b0:1dd:916d:771f with SMTP id k12-20020a170902ba8c00b001dd916d771fmr1835572pls.39.1710433671438;
        Thu, 14 Mar 2024 09:27:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b001dbae7b85b1sm1893090plg.237.2024.03.14.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:27:50 -0700 (PDT)
Date: Thu, 14 Mar 2024 09:27:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
	x86@kernel.org, akpm@linux-foundation.org, shakeelb@google.com,
	vbabka@suse.cz, rppt@kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	ardb@google.com
Subject: Re: [RFC PATCH v2 00/19] PKS write protected page tables
Message-ID: <202403140927.5A5F290@keescook>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>

On Mon, Aug 30, 2021 at 04:59:08PM -0700, Rick Edgecombe wrote:
> This is a second RFC for the PKS write protected tables concept. I'm sharing to
> show the progress to interested people. I'd also appreciate any comments,
> especially on the direct map page table protection solution (patch 17).

*thread necromancy*

Hi,

Where does this series stand? I don't think it ever got merged?

-Kees

-- 
Kees Cook

