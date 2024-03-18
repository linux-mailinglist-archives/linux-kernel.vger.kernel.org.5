Return-Path: <linux-kernel+bounces-106470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752687EF10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54194284BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C955C2D;
	Mon, 18 Mar 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UuKaQd/k"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3745579C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783516; cv=none; b=P+YTptspM/G3HM2z7F/jJ/A0AbY2KGCk9pzrbgbMlz1dTq6bALeGaZiOy4bU8vSzC/elBE9prFEm4fb7A/vQ5qC45MmYco6vO5E+ObEazl2O8La5Knw2X7s47JuUKAp6+h+dhrWVOT+5gaJbLawQcSvTPl89KS+Kfqz6ZtQhMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783516; c=relaxed/simple;
	bh=R76I21nWlclOcet2e0P90I1PHkxwCPo5keHk8owejo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLRyzdvIMuUO0yVQOL8I1hX9vnicNA7LqEeYdHUzfDQ9zi2jUlZEjD1MPJO0xCt7fSyzgOxQ6IeIdV7hpUtneqitYKYxndEJtqEXF/D2l7RuyM0Yz/++eIP2WGkw9I69PYGBOi++jt12OKbuBG2Ov2o1Sn+2NGWZa9GIwmJ3hjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UuKaQd/k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e036b76725so5658605ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710783514; x=1711388314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=texmG0Gw1zeNIT3HK3A5521t3H/aX3K5C6j7gLeepPE=;
        b=UuKaQd/kdUfqjFpdzStNEI14LWD6cUu+mlPELBj0uTovOm248wSiuF8z29fsIttms0
         3jK7x5fmUURJ7wCOknt21/mkCZ3wHtLtpde78PS6cjxFx9yKGXU42LOE2stFLBTd5i40
         iOetnjbZ81AcABVxnKR1StvGJXG2rQv3ZZRVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783514; x=1711388314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=texmG0Gw1zeNIT3HK3A5521t3H/aX3K5C6j7gLeepPE=;
        b=OBkgZOc9p4iDRLhHU/EyWo0t8IMAh2oF9h0EJp5VGxOO/qMozeOgkGjmVo7dIeqDo+
         X+Wik4NXRfi+Hj1w9TJC+6gXecahQCuhTSRLyqxPdMn5MxlHjg3AEQaeIaIknu5KB5yM
         i8SYvnk2DHFlMNw2j1oQHIB6sDx6yTNzHDlCN0Y/p1y/34Ug99OQtF80AKBJ4L5PNdS3
         Lv0XbZIxy6Ixt5+EcOPEw1nXHcS1KbQRThrpqK7o4VdQwfELYiM1/KQsCpYHdLIjjXGQ
         ifsDt8I+ibXZ/3wqXuYI7wjf3bh/gbpG1vaNXGGqxp4dPjshhCMxB1VSn84HTzdOE3ov
         yR3w==
X-Forwarded-Encrypted: i=1; AJvYcCWikoc8O7uvRPB6qhnymegSHKUWLjUvPEaRQCrnGQz4WQwQToQdYqKdbQ59SaV3yBHRYfltZO/30/MMkAN8cl3I2TgadrpnQVdNwe8x
X-Gm-Message-State: AOJu0YwzSJ7vqpY9iRxLKTSx/IAg3wtoBGJ4MGMjGs8q2fsyCRHQgAGj
	rOAGILuHChh1PhSUXKuLzFDv2P2QxbI3G9MgmOvNlaTcSclP7FHWzPRqLu4HDg==
X-Google-Smtp-Source: AGHT+IFwifvFDojSxhKBkKKqy3uuDnQSOhhO6SnmFZueyTL3hVRvKoeX4hiPXzD3uMyruoUadtwycA==
X-Received: by 2002:a17:902:e841:b0:1de:e9b5:bb54 with SMTP id t1-20020a170902e84100b001dee9b5bb54mr478461plg.34.1710783514163;
        Mon, 18 Mar 2024 10:38:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001dd7d66aa18sm9500656plo.67.2024.03.18.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:38:33 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:38:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC kspp-next 0/3] compiler_types: add
 Endianness-dependent __counted_by_{le,be}
Message-ID: <202403181037.C66CB5ABE@keescook>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318130354.2713265-1-aleksander.lobakin@intel.com>

On Mon, Mar 18, 2024 at 02:03:51PM +0100, Alexander Lobakin wrote:
> Some structures contain flexible arrays at the end and the counter for
> them, but the counter has explicit Endianness and thus __counted_by()
> can't be used directly.
> 
> To increase test coverage for potential problems without breaking
> anything, introduce __counted_by_{le,be} defined depending on platform's
> Endianness to either __counted_by() when applicable or noop otherwise.
> The first user will be virtchnl2.h from idpf just as example with 9 flex
> structures having Little Endian counters.

Yeah, okay, that makes good sense. It'll give us as much coverage as we
can get until the compilers gain "expression" support for the
'counted_by' attribute.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

