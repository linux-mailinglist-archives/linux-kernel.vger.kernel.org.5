Return-Path: <linux-kernel+bounces-123452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCA8908DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE121F24488
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9BD13791E;
	Thu, 28 Mar 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="3d5thlKH"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645823BBC7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653073; cv=none; b=Jn9IQVriFFRu78mkkMpKdEYl2VZjBkwRQWx1n8rh8s3bAp2ds96wXzqdGbVhJcry+qSwkkZr83XjnmPE0q8OiNlYSl1CO0VNMZh6/Ti67nc+ORshKBuV839V9ZCEmAoW5dtOgJYgLOW8BngExX+VPW1JrbvWGZ84fSK0DNA33VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653073; c=relaxed/simple;
	bh=OlsGVc24cRFBwsqfAO8+K1ji9SM4JgJWySnIA4va+bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNfHzhP4+1WNTbPNSzZGJC4iIm07KJ/6vJU1f+de6TuwXAd2WM0+IZmqJlQOKvb/Qbumy8zVaBzXumoE2Z4lLwOdxx0VSn6z0gctf4PeVG6eiCnVU4rnKk9Ht8itfO/fJahvdcTmXuCccGtq5vjx711xPmzBrz5vDMCEXjHcxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=3d5thlKH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c3ac720bceso818367b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711653070; x=1712257870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYi3n+1dup0vmKpcwHd1ByrK/mila8jNJvnF9Ro8+/Y=;
        b=3d5thlKHtBx6SIdywu1adWsPEaq9KS7KR8jz0YuXkaCSzlPebuO141lC9MUP/Z0eUt
         vSQ1TmhwmV/9rm7qPpNnSEVW2dxj884cfyRgOFftCvrMDuFLNal2VRTKvNnQQwiwJzDX
         2AotnlO0e1c2iCm2GP2NlPEKNN1Q21Agx2xbMJPC3qB/gwrq2lN2qABWTqRdR7qbed2v
         LRrI/uVlRJooD8UTyVjRgJJNBiYUWqH+Cvl8oiYeAYcVCHnsViXj04Sfe3XZTJMnX8Dd
         uEvxbrctvS52X6PYtlr55H/RziChe3O2TTFTaCbmqB4DtA7gfcSJRNvkKyxYHx+pMjfA
         Pmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653070; x=1712257870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYi3n+1dup0vmKpcwHd1ByrK/mila8jNJvnF9Ro8+/Y=;
        b=E36QMy6//zwqmteDWtxE0h8IVXv2wKN16eqVrmiplu0mx+jrLsskLSy9g8OGSBN4DU
         dSD97BfufryFNPga5MCB8eQsl/0WiKQ9oqrJrcRoeWVZfqhnGpJH7WDLY82z9KpkJZo0
         IwyMK7VurrXzOUh954mH6AtdFwG+Kwc1kyE698dvZe0oCp5kIzOJlkU4j64FBFaG09gG
         rtrg+xoILdPTx6r6zKpkLiaia+13y5c+xARZyP/Sj8cWl35zQBebF+rb/3cyou+yYSZz
         AqUm3cDMUTKsuK4xxxbkqiVbHbrQJEV89Z0wVlo/q9QcjTrPg1Y8FxcCuAHMDAkjJLcL
         W/HA==
X-Forwarded-Encrypted: i=1; AJvYcCXcs1NuY96jkqOMclp+OSFbxYlPCGSqYKH/gnIejwZxDhXJnmL2tovdgLw4/qQOuUPwNTKCwbB+1sn7Y0hZObav9UlCNLa6oPWt8jDk
X-Gm-Message-State: AOJu0YxerHlbbYnj6dJSW07UT/4kX01sY94arg0PBgVfhhNmSHAARYOu
	4OX+YKjWddjYwRmsr3bCVNW2vmMcIpn9bMckpr7eI7LqbPRN4kmz+n9C962RGZU=
X-Google-Smtp-Source: AGHT+IED6aKTx2u/XlyNAZMWz9pwnLPD+8mqkNcEiCkQXf6h24tspgZn3twTnL09ahR9madhXG75+g==
X-Received: by 2002:a05:6808:4498:b0:3c3:cd7a:af8 with SMTP id eq24-20020a056808449800b003c3cd7a0af8mr234178oib.35.1711653070517;
        Thu, 28 Mar 2024 12:11:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id eq16-20020a05622a5e1000b004316bafd1afsm869909qtb.3.2024.03.28.12.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:11:09 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:11:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
Message-ID: <20240328191109.GE7597@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325235018.2028408-6-yosryahmed@google.com>

On Mon, Mar 25, 2024 at 11:50:13PM +0000, Yosry Ahmed wrote:
> There is no logical reason to refuse storing same-filled pages more
> efficiently and opt for compression. Remove the userspace knob.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I also think the non_same_filled_pages_enabled option should go
away. Both of these tunables are pretty bizarre.

