Return-Path: <linux-kernel+bounces-87743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063DF86D868
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1D12847C1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E02C80;
	Fri,  1 Mar 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UZAW4Az4"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBA2582
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253639; cv=none; b=g2tzrAH8zGnPG+mmH1D8Q4A+VZ7NXpUk/B2dTto9nHTsOtxnvwHg3ZkZX3BS5JGPFiestzbiO6jG+LL1fkUucoqPSjzxuRiVE+KNpZSzKvnvfo+mZnM/iOec/v4tJJkyc16qSY5b2Gaah2mRnt4RNGrXs/i08nHz6lAeSxAnj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253639; c=relaxed/simple;
	bh=muLgGupmanQwoOkaJ46uTZdhMTCwpFMyxV8hvto3RLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3BXjRj/ylZmZiOAT1St/Y1YoZBmedOqztIrRWCQc3F87RvUikzm9BVxAuLz2D/MuOpdBiKa/O+g3+tuNngPY1kQdChMx0KZX90zWIdmFjo+ER44AyK9zsPtitzNChgYw6iOOFIxJmSd6ZXdlA+NCNnKRlk3AAFwTkPXWuIRJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UZAW4Az4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso1118576b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709253637; x=1709858437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLux+aUHo/V4i5EAKecz3RknuLa58zL1C1hJWsd2v88=;
        b=UZAW4Az4iJ8wP3f9OBpYXXgPY/U8beXjkZFTnXJlC8pIWoRutqUDWJNnq8J/Ac5+PG
         884axoo+xguxaWvklp9UTwrJdGHBFE4ngbNc2jSlwGPuoLuCwpUrWaOu+A1jSsLyjKCv
         KQXHiudCSihXgPjFK7nQpSmDlPbILalf4K+H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709253637; x=1709858437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLux+aUHo/V4i5EAKecz3RknuLa58zL1C1hJWsd2v88=;
        b=Qe7dTqD2z37GQ6Nt6gV+GJ3ZmFCdcnmnvo4ERsNHqwul4D98TihhxAjpNClQb/+1wA
         4fmjd5iGTVEbB/vwExM9sHPtxqw3/UfY1mJp7AupzrvnCosjIlAFXYxDeaGCrcMGK7uI
         9xjyJj72woahbaj+aU+C340ANBZNBrrjM5FeVFfZMZvn7Xi3FNo5Dq/8hRZd/DYBbFKd
         EZrmT6hqjNC157M8ll5v/fjIqr7JJBy7woN4y6tksAyonuxRUFBYMxF63oEnO/v+8kKp
         qEyxK+IN7QkDkrENAcsTvKLY2B0EX3pGEJ3K0qkbjqD62x4Z64BAalTpO07VpdbnDjNI
         ihWA==
X-Gm-Message-State: AOJu0YxhUFh7RXogNyrRtSU6kll/bgykT7QW+2YtpWkkaa1D9+2k1bF/
	VPPc/1bmpvNfH6afgTFr7Z4G+qZdIti7lZsDCU5qh+og7Q7rp6dYH5fdFJTBoQ==
X-Google-Smtp-Source: AGHT+IHFUeR1ugKofHFnvWfCfO87r1lfl6kXIYM4J/RlEeAi/4GNXDb6FENvl1zIyk1SVIFJGbZskA==
X-Received: by 2002:a05:6a20:1582:b0:1a0:d57b:1c93 with SMTP id h2-20020a056a20158200b001a0d57b1c93mr50622pzj.33.1709253637593;
        Thu, 29 Feb 2024 16:40:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090ad60800b00296a23e407csm4249537pju.7.2024.02.29.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:40:37 -0800 (PST)
Date: Thu, 29 Feb 2024 16:40:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
	justinstitt@google.com, quic_alokad@quicinc.com,
	jisoo.jang@yonsei.ac.kr, petr.tesarik.ext@huawei.com,
	hdegoede@redhat.com, johannes.berg@intel.com, kvalo@kernel.org,
	arend.vanspriel@broadcom.com
Subject: Re: [PATCH v3] wifi: brcm80211: handle pmk_op allocation failure
Message-ID: <202402291640.9AAD719D3@keescook>
References: <20240229103153.18533-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229103153.18533-1-duoming@zju.edu.cn>

On Thu, Feb 29, 2024 at 06:31:53PM +0800, Duoming Zhou wrote:
> The kzalloc() in brcmf_pmksa_v3_op() will return null if the
> physical memory has run out. As a result, if we dereference
> the null value, the null pointer dereference bug will happen.
> 
> Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
> for pmk_op.
> 
> Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Thanks for the respin! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

