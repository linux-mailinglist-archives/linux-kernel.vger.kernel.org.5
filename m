Return-Path: <linux-kernel+bounces-123688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49254890CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0554629332A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0313B591;
	Thu, 28 Mar 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZl8heIg"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA87013AD32
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662695; cv=none; b=g8FKHMXwDrVcJ7By4sUm7t3q65D5QibX+3297G0a2mGQedVmp5sizVBIWOz5nBofq+mcI5eyBIk3hwoa4zs3xGKM92DnHG6pEjacawBl/hl89bRNkwfsifpYXQ/D5Mz3omQa4j2cFNrICsaqTBacRq6QljaioSSvJaH+rXxrTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662695; c=relaxed/simple;
	bh=ZEE26gPTJZ/hBbsHNUyGFvQicSGcferjjPKlGEmy+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHQNpTselRo35DfUqMvyBK/mL6uoq6CWkjbVwW8n1HNylvC1apHpbTxgwXSScq/N3Yu5ud2/mDc96OvMcasUOSvgWyG/bTrYHUaBFJsppZ7Cg47N6jVT5gPZa58qxPoD2wRO36CKBPcdlqYJLy/PXzGc5z5vwkz1PysdO3zMtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YZl8heIg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e00d1e13a2so11370575ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711662693; x=1712267493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHpNoyxs0hG49ZqgEYrAt6uwLA+lg8Ao3v4qhonPl2o=;
        b=YZl8heIgfO51Hm6eSKT1QMTgLXlAKdpvfPUNx+DHG0WTMfqsdc5Rt/zKG+k/Yse23e
         tfcMAToSuR99q5A9o9uPmOxyBTpntieWiDt+gVzgRwqXOelb0x5HZpojOIm+JyMKphsU
         kbeSaHjjp8vv0LZ0IRrui3VpSA0V8+Beq7y+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662693; x=1712267493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHpNoyxs0hG49ZqgEYrAt6uwLA+lg8Ao3v4qhonPl2o=;
        b=RjADhrucpPAgKdOXiWMtPPriEG39fj/cyY0hS6OW4x7hL/CmTHbNOamCRHprRM159O
         OnTaBjNYGz/UnlG08djjA5RhW6rJdI48S7Kjmk0+0FF5z5PMeokBytnS4+dj3yDb8TeU
         WHuxvYTfgJcLDeZ1iUlMxQtfOlQI1JhVz6H5QT0d/LK06O6wLSWfyC1+LbRK5jwDz21K
         f6DB3b8IJBHsCJEewxfV+lnMli6Ae6h958J5JZtaqRDe6hXNXdnVCeXAS7thKdCT0g4Q
         LremhFwkdBWo7fW9NA9Ds6k6278oaCUaG+X8qctvf6F5L9MOWzlmWYx5Jy8I40wQ3jrs
         KgQg==
X-Forwarded-Encrypted: i=1; AJvYcCXSCJxKzLoHVzPXX0wzdbO3F91r7NfGw12wxO2YGwbNwSE4/2v4Y6l5y982xK8FxDhDZdb737KC76Ad3CAcZjmraEtD63QoarETKBiB
X-Gm-Message-State: AOJu0YxkDUhsF4722fMLXWHD4LtSY02/hUR7EXCc7YPwqEGZ3gLiOwgm
	TS33zqTOHzXy3xm+i8VwcniYGshCwpvF63i0SCToeeKpL/puNBLuYBrpvC9YRw==
X-Google-Smtp-Source: AGHT+IEMvDfUims4WapdrR4k340zi5+TetBtVJ7L44Et9CdsFiQpLpmuyGP05ekYi4VrMKMaXxz5qQ==
X-Received: by 2002:a17:903:11d2:b0:1de:f93f:4410 with SMTP id q18-20020a17090311d200b001def93f4410mr818655plh.8.1711662692925;
        Thu, 28 Mar 2024 14:51:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902e75100b001def0897284sm2119344plf.76.2024.03.28.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:51:32 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:51:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-hardening@vger.kernel.org,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [RESEND] wifi: carl9170: re-fix fortified-memset
 warning
Message-ID: <202403281451.6E8EB15E0@keescook>
References: <20240328135509.3755090-1-arnd@kernel.org>
 <20240328135509.3755090-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328135509.3755090-2-arnd@kernel.org>

On Thu, Mar 28, 2024 at 02:55:04PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The carl9170_tx_release() function sometimes triggers a fortified-memset
> warning in my randconfig builds:
> 
> In file included from include/linux/string.h:254,
>                  from drivers/net/wireless/ath/carl9170/tx.c:40:
> In function 'fortify_memset_chk',
>     inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
>     inlined from 'kref_put' at include/linux/kref.h:65:3,
>     inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
> include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   493 |                         __write_overflow_field(p_size_field, size);
> 
> Kees previously tried to avoid this by using memset_after(), but it seems
> this does not fully address the problem. I noticed that the memset_after()
> here is done on a different part of the union (status) than the original
> cast was from (rate_driver_data), which may confuse the compiler.
> 
> Unfortunately, the memset_after() trick does not work on driver_rates[]
> because that is part of an anonymous struct, and I could not get
> struct_group() to do this either. Using two separate memset() calls
> on the two members does address the warning though.
> 
> Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
> Link: https://lore.kernel.org/lkml/20230623152443.2296825-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

