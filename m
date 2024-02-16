Return-Path: <linux-kernel+bounces-68520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC9857B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D271C23C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9317690B;
	Fri, 16 Feb 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drFiaenj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096C1E499
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082878; cv=none; b=Y7Jlsxc1jLkK9adksYWguUrpMwIETF5gDfMqdmSHY0DkDBBWWJhxTf3NFsV7XZIWehyfoFjE4OmGcoccn80HiA+KBOm384Qb0eCT8+Gxk/yFWuQu8gV6Ixr/u5NrCFsb6ebe+fkLhhho37RFB7Ii5MYMh+lPN0bN7VNijf8k2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082878; c=relaxed/simple;
	bh=6gMcMyPwgLgEbY6ZF1f8Be8kn6MRW7NRH/o8brCnnoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd2JKqWIXC+nRQGmD1T4t2OS1x0XCvj9O8/fI3SeuNBQazx1sbobEW/hgDLUAvBpmxJ+93e6Us7gJJW7s5a6CaZ0ETuyhot1Eh9xE813lIk0QgPdcwvR3ZU9b/rw6egXFLo9hlq0+TlYt6rrQ3ymZ9t6uA9eNkWRdUKQc70nq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drFiaenj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldTgol2RjHwGuL7/gP1WBAM77N/i279/pdvnyHeoM1E=;
	b=drFiaenjO2VCSOMpqaomR7tDjMyvcCCoe6fkR1ECYkgZuU0dD9GZHpjhEyfWm4nVEyTRuC
	l8MfPgkVZSIbsTEcjoKugGs9qU1yF3io5YYsmuyBsWwegsRapAzRLKtjCFN9Vq//I0r1Lm
	gFxJmzWX5zFCC7IK1J8iUKomBvPCLK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-SFsltHNZMMyCxw5DJakHqQ-1; Fri, 16 Feb 2024 06:27:53 -0500
X-MC-Unique: SFsltHNZMMyCxw5DJakHqQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d0047bd95so728030f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082873; x=1708687673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldTgol2RjHwGuL7/gP1WBAM77N/i279/pdvnyHeoM1E=;
        b=Eh1uxNuyJCEYC/vr49kvhGBIjLTi7fXKHA0mCIuvmlq6yOVfpAnNSwVFjqJjS/u2VM
         DbgcDpwJnVFQNa3eTxSeEyUQPq3Uk135qAnYYjLdEVcfo2v3eWxcYsVbQ/MjqYgCAA71
         HTkWwy38l8rMfnb6Oym4TRLJXBuWKL5IVODsvUOvyhkKOt9RELHCh1iXAgmMwSiyXxsN
         qbSgdnxaaic1RljiQHbx6cV5TvElRPHt0sBA5tN+TRWR+YJkWe5xZRm38KY9po9gEtaG
         DK3b8GBZelsONtb93KmRNfIt2pT9zginLfAj11txrq9AoUsIjtZrqoAGOcxHClgQs3ZC
         0GEg==
X-Forwarded-Encrypted: i=1; AJvYcCV4/8mJtc7vuAyqfzW/Ag398FI8UKb75AFEbfYBepoY52vYuG/GYDRvEeTaZIIkZxhoRH3f46O0xa1DHLVnpvxT6QTZZ22wx6WAOTDb
X-Gm-Message-State: AOJu0YyjYMyW6GMKTnkmlDlhvzjbSxiJ60a5pNh9iCq6p3UwycuAGPIS
	nM13knSXRhqjLqzVgmcv1Tkp1tud35c3BDx6vgUir4mUmIIlIxAYkPrbXk0hTnl86apovB9XNuj
	5fskWqWAkWN9zKc6Az6p5vCp3jfh0Hl9wmkg1VB9ebkWxs/JSd+U7hbto5jvWPA==
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr3738292wrj.26.1708082872848;
        Fri, 16 Feb 2024 03:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgaY3PtAN8z8RgLWyK9s4sch0JhbTy5FoXAS+RRg2r8qkUw3EqgzlI0lsRkHqGluoJTNtjKA==
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr3738275wrj.26.1708082872447;
        Fri, 16 Feb 2024 03:27:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:2d32:e5b8:d152:6384:cef9])
        by smtp.gmail.com with ESMTPSA id u4-20020adfcb04000000b0033d24eab9c3sm189079wrh.76.2024.02.16.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:27:51 -0800 (PST)
Date: Fri, 16 Feb 2024 06:27:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [v4 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240216062630-mutt-send-email-mst@kernel.org>
References: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>

On Fri, Feb 16, 2024 at 11:06:43AM +0100, Aiswarya Cyriac wrote:
> This commit fixes the following warning when building virtio_snd driver.
> 
> "
> *** CID 1583619:  Uninitialized variables  (UNINIT)
> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> 288
> 289     		break;
> 290     	}
> 291
> 292     	kfree(tlv);
> 293
> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "rc".
> 294     	return rc;
> 295     }
> 296
> 297     /**
> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> 299      * @snd: VirtIO sound device.
> "
> 
> This warning is caused by the absence of the "default" branch in the
> switch-block, and is a false positive because the kernel calls
> virtsnd_kctl_tlv_op() only with values for op_flag processed in
> this block.
> 
> Also, this commit unifies the cleanup path for all possible control
> paths in the callback function.
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")



> ---
>  sound/virtio/virtio_kctl.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..7aa79c05b464 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  
>  	tlv = kzalloc(size, GFP_KERNEL);
>  	if (!tlv) {
> -		virtsnd_ctl_msg_unref(msg);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto on_msg_unref;
>  	}
>  
>  	sg_init_one(&sg, tlv, size);
> @@ -281,14 +281,25 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  			hdr->hdr.code =
>  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
>  
> -		if (copy_from_user(tlv, utlv, size))
> +		if (copy_from_user(tlv, utlv, size)) {
>  			rc = -EFAULT;
> -		else
> +			goto on_msg_unref;
> +		} else {
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> +		}
>  
>  		break;
> +	default:
> +		rc = -EINVAL;
> +		/* We never get here - we listed all values for op_flag */
> +		WARN_ON(1);
> +		goto on_msg_unref;
>  	}
> +	kfree(tlv);
> +	return rc;
>  
> +on_msg_unref:
> +	virtsnd_ctl_msg_unref(msg);
>  	kfree(tlv);
>  
>  	return rc;

I don't really like adding code for a false-positive but ALSA
maintainers seem to like this. If yes, this seems like as good
a way as any to do it.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> 2.43.2


