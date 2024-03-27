Return-Path: <linux-kernel+bounces-122080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0C88F19C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DFC1F2C521
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8315358B;
	Wed, 27 Mar 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HoJfIWVP"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9681DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577267; cv=none; b=ql9oVsjr1TWPkB4S9uxdILnahYjdk6d0iJTE5qVeIKkeK1OQqYwIhMs0X9L5r495z6tSI0jWGbXQAuKMRej2yIWvWWCm8eqhbLwiAs69SloKEUnrxbO2XAk48f+WBBcLQwut4JbRJi4tWA3j/qCltRGue/Mx9zpum9UvKgiBS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577267; c=relaxed/simple;
	bh=xmsi4tssHxt114eaMgANhLSOFgLyXDTeohNPFVjpX28=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=R8Iaa9cAacLOYdyBsiD7oWvYa85MVgwdpbOQOq1Rf/38o9aWt0Rg3e6sRKfGQUjDBI/oWWL/uC73eoyC0CwbcFJo7FR9puhF8de/9Ea3H/4ZaHHNQ1RGNPK5PMJUX7HCYFinB3HDDGmDRFnAdvXDp4jEzHrjXLGgXkqdAxf+I1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HoJfIWVP; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221a9e5484aso214591fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711577265; x=1712182065; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HB2DMTq4mJOSqX6vaF/OZpNWN7tzmVjhi+E2QWx9csQ=;
        b=HoJfIWVPmekb8ZV0LQgyQluYU5+sldwZzZRc9bwHgAkccnYY4MgDDEVesXhB4keuNv
         pWEdXT9ToSis7VQMwesjlirkJlfO7J4sfEDWafKvvUnfbLmkSEthDh0HIH98Uy+1lVmU
         C+9EEHu/3dcIDzAoyC+TITIGVAH6hvDUCl5PR2r/b7SFY/5WZVjgFV8ZKKLVZY1jDnjC
         6zLyznmNQ0LD5pWit1r0s/C9B3v2/0cSuwlPSS/xgfSaFxV2PMyNg+LVbA3ifIq/xdqG
         JLzb7nHJaOy1R5BY8lMctBxaG1hFKNUilWPEo9Cw7gHHuv55lv/XOQJb4beiH7lHcOkR
         ikHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577265; x=1712182065;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB2DMTq4mJOSqX6vaF/OZpNWN7tzmVjhi+E2QWx9csQ=;
        b=igzNkWDPoT9jc0XoFiSp9jybA9e1nlNeoefO9qHpgMSZUJ809y0rjeZPFHHAbUXdY7
         vdmyOI8jZk8hMsMthGjAO5hVGyiaNkql6kMCefXjwoabFLsOmUxIlMQul2a+DIm5f82I
         bRBVRp7yZPCxahr+trx0rmrIzH+aN/4x7mYC89v376BTSt35JhoMe5K4N+Uve7RFBl6C
         sh0hbvaQynQJS6KB11kn8HM6foVi3ZhIWtL/uCk0b/Qs1Xq5hLfgKPuXu2JbhgUZrk5m
         U6R4bpOivHGn+U1G6Q5ptMEGKjVO5kNBCZC0d09x7zMQgOVM9GNEMd+pf9H+T6/cKEIj
         GmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrgN8JiOBPRnP05E4bjpTMNlSNVEKZnDGAhapUZc6bEij2mtErSBGh2xKwtiU4l30+Kww86jcFNMswHFG7IrQRqfrEZETbgTh24N52
X-Gm-Message-State: AOJu0YzgeULaA9NdPsGtJWj9VksLdVK2CmNO/LSeN/mlUbda4IWrmlsg
	WQKzKYG6ym/DqitODMV0UMdQ8ebRn8h0anS2udqlAliE1m7y4hrNIAd+5j4cbw==
X-Google-Smtp-Source: AGHT+IHKXENcqgAKprgJ7uHSgNo6K4eUY3VdATdPSVCzwulf8HbC/9B6tWMAWus21sh0IiqiGLTAwg==
X-Received: by 2002:a05:6870:2b13:b0:22a:9e26:f372 with SMTP id ld19-20020a0568702b1300b0022a9e26f372mr897629oab.11.1711577265073;
        Wed, 27 Mar 2024 15:07:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fy21-20020a05622a5a1500b00430ea220b32sm19817qtb.71.2024.03.27.15.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:07:44 -0700 (PDT)
Date: Wed, 27 Mar 2024 18:07:44 -0400
Message-ID: <66718f36ae0e8dbad8bbf74038e9e0d6@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: optimize ebitmap_and()
References: <20240315181204.647182-1-cgzones@googlemail.com>
In-Reply-To: <20240315181204.647182-1-cgzones@googlemail.com>

On Mar 15, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Iterate on nodes instead of single bits to save node resolution for each
> single bit.
> 
> Similar to userspace patch efcd00814879 ("libsepol: optimize
> ebitmap_and").
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   apply format style
> v2:
>   fix array size computation
> ---
>  security/selinux/ss/ebitmap.c | 50 +++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 8 deletions(-)

Some minor comments below, but do you have any performance measurements
for this change?  I realize that ebitmap_and() isn't widely used, but
it would be nice to understand the performance difference, and if there
isn't much/any difference we might want to stick with the original code
as it is much simpler.

> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 67c1a73cd5ee..47cb90106118 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -78,19 +78,53 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
>  int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
>  		const struct ebitmap *e2)
>  {
> -	struct ebitmap_node *n;
> -	int bit, rc;
> +	const struct ebitmap_node *n1, *n2;
> +	struct ebitmap_node *new = NULL, **prev;
>  
>  	ebitmap_init(dst);
>  
> -	ebitmap_for_each_positive_bit(e1, n, bit)
> -	{
> -		if (ebitmap_get_bit(e2, bit)) {
> -			rc = ebitmap_set_bit(dst, bit, 1);
> -			if (rc < 0)
> -				return rc;
> +	prev = &dst->node;

Later in this function you include parenthesis, that might be nice
here too:

  prev = &(dst->node);

> +	n1 = e1->node;
> +	n2 = e2->node;
> +	while (n1 && n2) {
> +		if (n1->startbit == n2->startbit) {
> +			unsigned long testmap[EBITMAP_UNIT_NUMS];

This is very bikeshed-y, but I much prefer "dstmaps" over "testmap".

> +			unsigned int i;
> +			bool match = false;
> +
> +			for (i = 0; i < ARRAY_SIZE(testmap); i++) {
> +				testmap[i] = n1->maps[i] & n2->maps[i];
> +				if (testmap[i] != 0)

If I'm going to be nitpicky, I'd probably prefer 'if (!dstmaps[i])'.

> +					match = true;
> +			}
> +
> +			if (match) {
> +				new = kmem_cache_zalloc(ebitmap_node_cachep,
> +							GFP_ATOMIC);
> +				if (!new) {
> +					ebitmap_destroy(dst);
> +					return -ENOMEM;
> +				}
> +				new->startbit = n1->startbit;
> +				memcpy(new->maps, testmap, EBITMAP_SIZE / 8);

Why not just use 'sizeof(dstmaps)'?

  memcpy(new->maps, dstmaps, sizeof(dstmaps));

> +				new->next = NULL;

You shouldn't need the line above since you're doing a _zalloc().

> +				*prev = new;
> +				prev = &(new->next);
> +			}
> +
> +			n1 = n1->next;
> +			n2 = n2->next;
> +		} else if (n1->startbit > n2->startbit) {
> +			n2 = n2->next;
> +		} else {
> +			n1 = n1->next;
>  		}
>  	}
> +
> +	if (new)
> +		dst->highbit = new->startbit + EBITMAP_SIZE;
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0

--
paul-moore.com

