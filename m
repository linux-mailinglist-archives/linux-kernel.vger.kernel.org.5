Return-Path: <linux-kernel+bounces-63175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148BF852BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC2D28374C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4083208CB;
	Tue, 13 Feb 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9wqLetE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC71B7F5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815177; cv=none; b=bJWgZnS9L2b/mQWzcp7CRy2F3Add0gfQ1ZeIryd1jOXk92LYDVi7wlAI9nvmevu51cnAL1VIYahFfa7tz3BsWNmlTVIRmEgLPWARGtEiohSUmU9mnabGVuPkKRLNaUdbArpTfBPmP57Zv7/CBZLl3GJDsRmi37gG5/gxMryFZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815177; c=relaxed/simple;
	bh=fbN4ZqMqELs7B2vKodqWXUHobDmfjtCgV62hSufnm9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD+iB9Mj9VwnD+RB1zGHDvoYX5C3zLYR8jnjA5d0pG9XVrKfhLzD0QOC6MD7BQXGLOSC/XyHK0Q6hoZ+pbgsAeRbYwgMyhvuZ4R1S4iWtRnn5EmPexgunkghQg74wFxKTt6nVx0yDtN/VtpdGDieGX2NFaGLeXjELJuiQ9atnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9wqLetE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707815174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCp+U2tcizd8TQvjWI973O/2/xnroOwuTJofpoENFck=;
	b=a9wqLetEp8gh4X9rBC5fIgRH8kFdikA9Q4QpatGYxx/oAKBLIHI8n/8xnCeBdrukRIDOcU
	CUYh/6Rh1M38giMWdg4wYMZvecxBgAnK0Ob0K+h2k5dzDlLpsky0iDmQnOA1MvzRJPTZoQ
	IKkELMFU5Yi6T+WvuyVrcO+hDRwdKVY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-shatcQy-MDqOIzgN4_1lPg-1; Tue, 13 Feb 2024 04:06:13 -0500
X-MC-Unique: shatcQy-MDqOIzgN4_1lPg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-559555e38b0so3728221a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815172; x=1708419972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCp+U2tcizd8TQvjWI973O/2/xnroOwuTJofpoENFck=;
        b=WCnx2TbNo5EnLWH+BQeZBepYGrVEKzBVgbRIvKsK/tbHm8XyCnUTfcAf+3kWGhYoXk
         Z+SuSBQrBuStHmenY6huASNEwEajzQMlJ7oxls/a8gMAsrRd4HxjeufUWkFDPDhs1hOF
         zDtWDWljxC/9r942lQI4lkXfwzCur0PFT0b/AkRISDw5O4cZWRx0ho4arqSiQen4KChx
         IQRehlDhVIpT7ED+bOv85Us+RtQ1Rae1MB3N9rEJdhny/QgImHpSoxH7AgFmAuiO08ZI
         EE4h5V1nXjfctai27myohUBVvMtyLLgnFFJ0T0xuO+ZfjCjbZeg9CiOgawDpb5g7XI6D
         Mumg==
X-Forwarded-Encrypted: i=1; AJvYcCVBroDmJ4+k5YDiswpXdtEA8oroM77tTfN8muShPdZfn3nq0eRqdPqNsrOt9PG4+VIyiCxsw9IydrWYTnxiYZAWzsuhxELtwnSqvCav
X-Gm-Message-State: AOJu0Yw80QBGXLs81YHC8Vcbk0i8tDF2G8tb0ACSasd5anHk0oCuEf9L
	I8yf1hjWmgmsDgLUOAf8fflIJflXszQhtSOVTfDgZsfA2sSNe6iWMd/p0OgP9JVDnf5QQJYBNSz
	x+9qOpo7qAbVDHChHejhoDKfQ4hy0zUdKdS18Gpip/6K5hEOttrSQb0HVUZWXzA==
X-Received: by 2002:a05:6402:22ec:b0:561:f77b:c0b0 with SMTP id dn12-20020a05640222ec00b00561f77bc0b0mr622570edb.39.1707815171939;
        Tue, 13 Feb 2024 01:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1WxLIbkc9509MADVuZj12YdZkQRBE5ZevDuhFcjxgdr1fVp4moBUIGKQf1C7kGw0aY3jCDA==
X-Received: by 2002:a05:6402:22ec:b0:561:f77b:c0b0 with SMTP id dn12-20020a05640222ec00b00561f77bc0b0mr622553edb.39.1707815171594;
        Tue, 13 Feb 2024 01:06:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsT77fnhrOLUZtwRFl10XYMgZvpCowT2ftQ62g+EnJpk2swblqtcfEL6k9x+GqRZCAjwwyLRx7YRIXccqc4d9awtdWl3QMp0jpWut2UdWzxp+RMY813l3jOGxex+j+KSI+IBR4UL2N1MM9barmOwALJI3DV2VJzQdhXEZcmoqETaKg7DdzxZDzWLJcKNwkHjC2K3Rk1L0kA9mQBrkKjAOQb2BlPWN7/67oXqABJW6pUlMcRZbpCwjkay3Jl7+MLJSrn65kRoPxuttBje9z2eEl6TIhmpsWavi932jiB07eRMUe79h16bcZvxNrKwYn0JanD4ZmadQ2cNm2V0GKs5dl2R1tG5Hm7Sr2ZGJIFkLcuVtwxdUPjt5UUQ==
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id er13-20020a056402448d00b005607825b11bsm3509207edb.12.2024.02.13.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:06:10 -0800 (PST)
Date: Tue, 13 Feb 2024 04:06:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240213035806-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>

On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> Fix the following warning when building virtio_snd driver.
> 
> "
> *** CID 1583619:  Uninitialized variables  (UNINIT)
> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> 288
> 289         break;
> 290       }
> 291
> 292       kfree(tlv);
> 293
> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "rc".
> 294       return rc;
> 295     }
> 296
> 297     /**
> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> 299      * @snd: VirtIO sound device.
> "
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")

I don't know enough about ALSA to say whether the patch is correct.  But
the commit log needs work: please, do not "fix warnings" - analyse the
code and explain whether there is a real issue and if yes what is it
and how it can trigger. Is an invalid op_flag ever passed?
If it's just a coverity false positive it might be ok to
work around that but document this.


> ---
>  sound/virtio/virtio_kctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..d7a160c5db03 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  		else
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
>  
> +		break;
> +	default:
> +		virtsnd_ctl_msg_unref(msg);
> +		rc = -EINVAL;
> +

There's already virtsnd_ctl_msg_unref call above.
Also don't we need virtsnd_ctl_msg_unref on other error paths
such as EFAULT?
Unify error handling to fix it all then?

>  		break;
>  	}
>  
> -- 
> 2.43.0


