Return-Path: <linux-kernel+bounces-65437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7423B854CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB5028CFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176D5C91F;
	Wed, 14 Feb 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+ct2Cj1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563C5A4E1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924972; cv=none; b=pvOMYxxgvcOFr6o2+UI6DUtboE1SES26tKqYHoCP46IPS5OfL5oPx6P6J6kSSyOQ0cMSuu+3rDVZ8FnlsEfhvkIBDF7bmZiZvhJ+OqkH5jKCbjpY3MQPVXcSH/oWxrM0w/YhMyQfMzKSxGCmTXoT9iIuMvP7ppcA1T43XAYPDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924972; c=relaxed/simple;
	bh=manMnYEz4pn6s1Xo/dIku30u35/Fk2loq3Yh54oRS+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGAP9wyPcGKKxgb/vinalEMkOwmLERVzJAWuIveA8Kj+27axco+FSzJ05Sgo3zMRH0TeczyVbJrJwAZiWZKUGhpiKCtT2WIc4CunktPsLtya0DrYa2Eubr3ReryPrHDmXFxWEsYkLe5vIEKcLO+9pdAjb1FvlUn1KkcGTkLHsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+ct2Cj1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707924969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yk+r5+Jl2RkVcClg72bssLx2pLXyZ58wrDSewZoLn+8=;
	b=O+ct2Cj16hZgtX0cuGOib8kqdur437Q9L9SW7ozPRBvcV8dIfnSrchz0nAjheyN4X4QRF3
	51VRlCLFenR/PmbjTNKsnxC3oCFqivA1R7Q2SujEg96o19HLAHG1JJlLZ3lgMGmvbxtuEg
	L9HKpxl51XYMtVviF8K2vVUHUqNqR84=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-mTppHZoVMy210umGU9pp7g-1; Wed, 14 Feb 2024 10:36:07 -0500
X-MC-Unique: mTppHZoVMy210umGU9pp7g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33cf67eb36dso1192f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924966; x=1708529766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk+r5+Jl2RkVcClg72bssLx2pLXyZ58wrDSewZoLn+8=;
        b=NPnkB+o99vwnLHpiloIRu74Q5cMtf4DCEgJt+CD1KA8GyRyOdxyZc7ISbxXdhqvAAz
         EUATR9PQlHxG4fMrNhKqpAjyTqz41v00C5eneyd1fkYfDoxnPRMnuMjFqbzZOjRTYCbp
         DvtRQ+T+jl0xRmQ4dn2bJ6kOl91Nepk+0CXfQs9vOqpY//CPz86adHGBBbt12a9zAd11
         j0GKn9ipT+YWar80HA8LNGzwWtSKwfFvAXoIBMRU67N4EA99sL9iJKNd5pseUgolSloE
         gTMKcdAY0vcVG4ifzByZ/b+vOPGBbKJo9v0uryNoWV1clbSHTIJRoMZMdahjh1iwS8aw
         uREQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyd12Ql7AAgj+j5eNLgC93UdEpFTSa1cI7QDDbUd5On12UT/KKWe+7YiUQjX7W4bOmSuHE+D7ivjQzOCtgjSkRmKX6X4LfDPFxh6y0
X-Gm-Message-State: AOJu0YyvqaDGOt76J74jwPzgm+5Rw1rflRuW6XQo0eE//pF9knrR4D6n
	XL79cZxZORs2XShKL7b+ntrHllLYCnAWXq93U0N9M3g/6Zgsx8pZiAHVKJTFWK/AwcjUr5OjE+W
	rjwrFvvubvnM2txWYu/ryDZFzEOK/jjuWUZENFJhn545W8D61ZKsbnVsDZc/9Vw==
X-Received: by 2002:adf:f588:0:b0:33c:d8ac:c182 with SMTP id f8-20020adff588000000b0033cd8acc182mr2030158wro.41.1707924966172;
        Wed, 14 Feb 2024 07:36:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN4rsvb3h0+DO6dhzov4nViL7vH02SlEqXlo+Dh8Cvpkddkjlq+Lr8v5C5Scgn75uJes+DVg==
X-Received: by 2002:adf:f588:0:b0:33c:d8ac:c182 with SMTP id f8-20020adff588000000b0033cd8acc182mr2030138wro.41.1707924965759;
        Wed, 14 Feb 2024 07:36:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVw1n6ntQ1Pnj6sCIZ79pFaffBrcPDQR2hDKsPPQZ9IaU/EWNYc2o+8XL7GMNl3hIEGE+3WhvWomNOtpns6/JE0L9GvLXFqZ06y4TTX2o5b3SzR33+bwq/J3EzYnJenvTfpD1Rq/3fOERcPkQqoveY0/BZeMuHKmpEkWP0NsVzTgGo9VQt8gH7huNpHKP5p3ninOeLsg0bTAoryzv5Wbn5ah+1BJjpfEm90i3vf/XoSU/0hcVaMjfUcoxRyd4HEzhhXjVirHBBthb5gt1V4nMutvxDgH5T+uj2hllvq2MTuG3YKawnJhDx/5Wi6hsV/Vl6q/1jZtjLwN+SqRG+outmBHFRXluLJu/muoACgCOJwT3Dlwm9vZM8a7Q==
Received: from redhat.com ([2.52.26.67])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056000061c00b0033cf095b9a2sm1612543wrb.78.2024.02.14.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:36:05 -0800 (PST)
Date: Wed, 14 Feb 2024 10:36:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [v3 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240214102727-mutt-send-email-mst@kernel.org>
References: <20240214140110.606171-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214140110.606171-1-aiswarya.cyriac@opensynergy.com>

On Wed, Feb 14, 2024 at 03:01:10PM +0100, Aiswarya Cyriac wrote:
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
>  sound/virtio/virtio_kctl.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..40606eb381af 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  
>  	tlv = kzalloc(size, GFP_KERNEL);
>  	if (!tlv) {
> -		virtsnd_ctl_msg_unref(msg);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto on_cleanup;
>  	}
>  
>  	sg_init_one(&sg, tlv, size);
> @@ -266,6 +266,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  	case SNDRV_CTL_TLV_OP_READ:
>  		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
>  
> +		/* Since virtsnd_ctl_msg_send() drops the reference, we increase
> +		 * the counter to be consistent with the on_cleanup path.
> +		 */


This is not how multi-line comments should look.


Adding overhead here is just a waste of cycles.
Instead, separate error handling and normal exit paths.
Then you will not need to increase the refcount here.

> +		virtsnd_ctl_msg_ref(msg);
> +
>  		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
>  		if (!rc) {
>  			if (copy_to_user(utlv, tlv, size))
> @@ -281,14 +286,26 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  			hdr->hdr.code =
>  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
>  
> -		if (copy_from_user(tlv, utlv, size))
> +		if (copy_from_user(tlv, utlv, size)) {
>  			rc = -EFAULT;
> -		else
> +		} else {
> +			/* Same as the comment above */

Same thing.
Besides, this kind of cross referencing breaks immediately when
someone adds a comment in the middle.

> +			virtsnd_ctl_msg_ref(msg);
> +
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> +		}
> +
> +		break;
> +	default:
> +		rc = -EINVAL;


	/* We never get here - we listed all values for op_flag */

> +		WARN_ON(1);
>  
>  		break;
>  	}
>  
> +on_cleanup:
> +	virtsnd_ctl_msg_unref(msg);
> +
>  	kfree(tlv);
>  
>  	return rc;

on_cleanup is not informative, coding style says:
"Choose label names which say what the goto does or why the goto
exists."

And saving on duplication here by paying elsewhere does not make sense.
So you do this instead:


  	kfree(tlv);
  	return rc;

on_error:
	virtsnd_ctl_msg_unref(msg);
 	kfree(tlv);
 	return rc;


This is very ideomatic.

> -- 
> 2.43.0


