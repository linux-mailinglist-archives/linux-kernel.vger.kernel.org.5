Return-Path: <linux-kernel+bounces-36080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C25839B37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEB51C236FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867B3B78E;
	Tue, 23 Jan 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZWZDETR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CCC8FD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045558; cv=none; b=mNjiWwp3j3NmBxmgvK4JyF6n6EVDCBH7yQcBjElYwPAkLV0l4L2iQGuGxHcW35hnGVU4vxnfnSagCB6s4WNsdjzlzDzE03u0S5lokcjNAyuukPSAjZL7/zYW5p+yqtkoJfNFy45hCEEdsFsZTtkxpD9N+jYP1ijjkoLDnjaLfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045558; c=relaxed/simple;
	bh=N2eMKxGKC9fb0PjB8BggX+mn9jsS+yaW0VK2ox0w8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKeWjfqy2JQ0FuY+PSc6HyM/s+qSTjz7NiUwgQHC3ohLOAQg8jv+vkdXBlCI9JTQufqV8kGppKQyX2Jw8ivHA3YvggZ9Sp5iE3qVID7j37sf+u/q71KVbfX4Zmh589G2gY4ejmejyjUq3fqDLy2q9smG9aTgD4lGP1h2P7xsDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RZWZDETR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d74678df08so16070815ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706045556; x=1706650356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swQh+tXC7wjzygjmlvxoa7jnM24RYNaNqlf/2tnlFpM=;
        b=RZWZDETRJ3tdK1x5X6K5KNtiJ9OFq2PbD0OBYuOj5ncE/kICqyYGWyiipWArPUcV+R
         I+VcKv+e80Px86gl3C4eF6UjVc0z6kUBEQ/9X4Yswd3eUeustu+K4+ttSrKMPRUpJqOF
         Sj0lAePTvUusLq9GYw+KSHDTQyNdvGhRNvpBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045556; x=1706650356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swQh+tXC7wjzygjmlvxoa7jnM24RYNaNqlf/2tnlFpM=;
        b=Ot26w71HGyKXB+iVWRaiFeK+D5wxAmzmnbGYkkwAlGPO3F+ZJHa7mQn7AVT5m66/E8
         Am2ovbxNHEcRFAaFLd2DozLVViIy4UsNOfOYjh7dhMzcmHX77qvIDiakVwFYpSnM0r1e
         HW0zxYIaulv6WAKTcKjEDaBlv8CfpquolsBDsQ0F/AGQFq8rf50txrf+87trgOtVg2v9
         geoNDOXZ5Tc9LP6RJJt7o/fK9V7Fr/8LiG7i6/MNL/MMfWX8B0LD7C6RpcGs8ykHTYyM
         l06if8Q+O1f9yBtUstykbAbjhLtHmGLTUKVITz4+KbXBrdFQ0DilQ3/VAc+kevZpY28u
         rC+w==
X-Gm-Message-State: AOJu0Yy698qGZSMQCzjtnRmhFAM+fAcMyUqHSw7Hq00EomGX9GbR+dug
	xq1Ultzn2RDdGMBW7sVnEw+UbzyIKn8DUvdpr5p04WsYDTjCjBFTqyYCLehUQA==
X-Google-Smtp-Source: AGHT+IEQgobK3CRi+ljenTCG6shvI0FXYyD3FQGn2ZQQGUseg7yif9UwvyOavRLNcvr02zSwCtZc7A==
X-Received: by 2002:a17:903:120d:b0:1d5:7316:c9fb with SMTP id l13-20020a170903120d00b001d57316c9fbmr3866864plh.37.1706045556284;
        Tue, 23 Jan 2024 13:32:36 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902740800b001d714ccf7b3sm8100220pll.180.2024.01.23.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:32:35 -0800 (PST)
Date: Tue, 23 Jan 2024 13:32:35 -0800
From: Kees Cook <keescook@chromium.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 80/82] xen-netback: Refactor intentional wrap-around test
Message-ID: <202401231331.0BD2925D4E@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-80-keescook@chromium.org>
 <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>

On Tue, Jan 23, 2024 at 08:55:44AM +0100, Jan Beulich wrote:
> On 23.01.2024 01:27, Kees Cook wrote:
> > --- a/drivers/net/xen-netback/hash.c
> > +++ b/drivers/net/xen-netback/hash.c
> > @@ -345,7 +345,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
> >  		.flags = GNTCOPY_source_gref
> >  	}};
> >  
> > -	if ((off + len < off) || (off + len > vif->hash.size) ||
> > +	if ((add_would_overflow(off, len)) || (off + len > vif->hash.size) ||
> 
> I'm not maintainer of this code, but if I was I would ask that the
> excess parentheses be removed, to improve readability.

Good call. I will adjust that. Thanks!

-Kees

-- 
Kees Cook

