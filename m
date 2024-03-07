Return-Path: <linux-kernel+bounces-96100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9C875717
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB9F1F24B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD6136664;
	Thu,  7 Mar 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lfzr0luF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DA13664F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839509; cv=none; b=Qxn7xW5zzcb+CVaNtspcf7sMsphCZhrSZKtVzk2RYMQkrPAm5B9wVaVj2AhuX9HGOHVS3gcMnDlIJZYxgCS9K2VrZh+7BvcppW79s/4S3LOUF36E9bvWNMAKpMaBfxT9TL7TQNeiR7YyjNNszajYd8HQpWRHWmL/L833FK2CIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839509; c=relaxed/simple;
	bh=oEjMPJubQwQ+yWGuBB6rWcBvplbsprHnS4lKv/UZf2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWO09XNaWlcOof881RBcIB+F8/T3BFwqePJa1I4A3SmCpSk6N6ohE3K1zzsCpTK8bibJOkAWpxTyXxHC9sRNqS/ru4Uh6iUNCjKyOCNPvwmF2lRAcbknaFxlGukwLcoQ2uWvihCB8p8NlNzh7kT2vKI3/pEFMnPBpe4M1SwUpb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lfzr0luF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so9817625ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709839508; x=1710444308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5DlqCDcPf8EWWXtnaR5E80+mf1MXP/hKxTNVmmfHrg=;
        b=lfzr0luF6IMg2BdP2uO75Y/EXFfucKeCJ9+VM+UngEgzn7e8goRDaHqfmovCwGocHl
         xqtG6WPoi73ek60KiEI23luRE3EhXFTzsMQ//OTvEhXCd2hdVUhjo/HLk/JGO3egLLG7
         9dBsMzuheTmKfWY/VSzqdSk4LudOuiYbS7xbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839508; x=1710444308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5DlqCDcPf8EWWXtnaR5E80+mf1MXP/hKxTNVmmfHrg=;
        b=ti5lM0z9ntgulhRD3o4isVun6TRRb/V5EMsEYBhsZKJcOcciMYJFcwRGDTStzVktDU
         NbJZAfiOc8IukUxg2W24LMUQl8rblwCOlJhKvRZMoL+mUEPnB9lc+xim4mLsOM3ObZrc
         gOOfEetbjmWtPcihqVrBLzT0LynyBnsRxKOr4OIPIqvEANxnFA4J41QLnbJxjaV70myO
         jETtaZqMQBWwX8uEgx7p1+AMGtpls3DnZ15xnDWSfCWxYnuFfsXX3D/gT2/OHZBDTe2j
         eBK+hx8c1IpwjL9kYtlQzwDiTF0VM+RbkcK+7e0Kozwh/VulFu8pyN9G3RnYY7DD4yoi
         1Xvg==
X-Gm-Message-State: AOJu0YxDTcsSagHaUv3W/Vb8089WaFapB17JEb6KW2MvoGFRakjxNzaQ
	W94v/ThKXXLbV31AD8lmJSEet0QtoteIVKA0YgQeLOHfL6zuQ3skKJ6n+a3CdXoKgT4DCJ/1w38
	=
X-Google-Smtp-Source: AGHT+IHo7EsASiOmxXFqs8Zb1/yv8lcNgfCtRpzQ8cUgN7QpnZcXS9cPD0omc0MWoR4KVtDZ3FWjVw==
X-Received: by 2002:a17:903:1c5:b0:1dd:66e6:ec81 with SMTP id e5-20020a17090301c500b001dd66e6ec81mr76517plh.18.1709839507714;
        Thu, 07 Mar 2024 11:25:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001dc2d1bd4d6sm15050839plc.77.2024.03.07.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:25:07 -0800 (PST)
Date: Thu, 7 Mar 2024 11:25:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the kspp tree
Message-ID: <202403071124.36DC2B617A@keescook>
References: <20240307171603.45e9c8b2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307171603.45e9c8b2@canb.auug.org.au>

On Thu, Mar 07, 2024 at 05:16:03PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> include/linux/overflow.h:408: warning: Excess function parameter 'initializer...' description in '_DEFINE_FLEX'
> 
> Introduced by commit
> 
>   014dc22af922 ("overflow: Change DEFINE_FLEX to take __counted_by member")

Thanks! I've fixed this now. (Weird that kern-doc will take "..." as an
argument name, but "foo..." becomes "foo" not "foo...", but okay.)

-- 
Kees Cook

