Return-Path: <linux-kernel+bounces-74807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266EF85DAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87183B25073
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB67BB0B;
	Wed, 21 Feb 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/g3m916"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837078B4A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522530; cv=none; b=HQVwnCTckQxcbuhoC5gEVSvo238PjT10w/dpgVfYCDDCaDF9DquWACA4pfgMsCTMCV8ff8iaYY4rspMWRyfECqSE1dp933uMZWNLkPb7I2D1mN4vJ1Y2Wn7K0asU+CNhjjfigsGh9QL6le55D0BZYiaAEYZr773nbAEO8Ej0IAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522530; c=relaxed/simple;
	bh=aHbuQtkQc7j/3wUDl5g8D0p6bowESyQfshtkj1PQnKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulBo6sXqvTquWPsDb6e7/a66K1RXSK1JckB17/nK5fMi+FO4+rRC7l8un/b99GrOK4OTz6frXGQ2zMW1Bb3La78h+mbvalrIaqx+Tdm7l83vczH0bzOaKLTvf8jKxBMsyURnyXEDW6g8/iWeHmj+fAzgQ+u92hHAATH1VT1wd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/g3m916; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708522527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUGTjfCB/0L8+aS9L44bC5nmdvFIq/qccvpGMI5yZOo=;
	b=N/g3m916rx2MsJICWMCnZiIR3Icl3QOjyvYQNd2lkNz2kWyyKej0gKmBJP9PZeLI7E3DBc
	/GvPF8w3U2OAwk9tDf0FaDmga+l9gKkOmEbnVp5A/BmGnrVnJ3WUCvn8HHHd2Lpp32KxAZ
	sCgDzq5AWiBT9p7bLwJT+I2Tw9e8NPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-UGqS_xFdMvmHoCUPoilQKg-1; Wed, 21 Feb 2024 08:35:24 -0500
X-MC-Unique: UGqS_xFdMvmHoCUPoilQKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C838859708;
	Wed, 21 Feb 2024 13:35:23 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 635BC40C94A7;
	Wed, 21 Feb 2024 13:35:23 +0000 (UTC)
Date: Wed, 21 Feb 2024 08:37:05 -0500
From: Brian Foster <bfoster@redhat.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: remove redundant assignment to variable
 ret
Message-ID: <ZdX8gTpgqyM/jjvp@bfoster>
References: <20240221115203.3413554-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221115203.3413554-1-colin.i.king@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Feb 21, 2024 at 11:52:03AM +0000, Colin Ian King wrote:
> Variable ret is being assigned a value that is never read, it is
> being re-assigned a couple of statements later on. The assignment
> is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/bcachefs/super-io.c:806:2: warning: Value stored to 'ret' is
> never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/bcachefs/super-io.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
> index 110dcb0337ce..c6d590404425 100644
> --- a/fs/bcachefs/super-io.c
> +++ b/fs/bcachefs/super-io.c
> @@ -804,7 +804,6 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
>  		goto err;
>  	}
>  
> -	ret = 0;
>  	sb->have_layout = true;
>  
>  	ret = bch2_sb_validate(sb, &err, READ);
> -- 
> 2.39.2
> 


