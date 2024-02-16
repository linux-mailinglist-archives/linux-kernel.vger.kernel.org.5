Return-Path: <linux-kernel+bounces-68663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E2857E03
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4D6281EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482012BF11;
	Fri, 16 Feb 2024 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXCVflRV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32710129A9E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091341; cv=none; b=KMRBX+ufTk37Fws99NXC16FE/PTDMfh+SZCmO0wke13C1hLztrY9MuXrK/35Ve9w0O8Rr02DqxZddZ2kn+2dpUgNHXbWmy8n2Vl7FBizCVTU9vl1liOYiymOhUUPwwbsoRgNKBIRpyx6gy+xC3mOPYcLx2kDpbp+BS4TdTyKJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091341; c=relaxed/simple;
	bh=p+opkInfZweaoUNUs/cXv+2WJrPLxdoqhfkcl28GLEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEhsN12m7PnAsZjA1yAZKldPy5ow1lCDnbyFDYaew3dE0AGfqKPrPW3Nsxhgag/BZMbkUNl0OQxFNPr0GvnSo5R7SKzr17aAcXo7k5RZ0FaKAyVBsHNAOyDCuqijmzCKcQMi3jJiOOrVdUdIw6n2c7CBSaxYo8ruLo1403OUJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXCVflRV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708091338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHwFSfupJsy1hRAlGeBjUd3fBxQOvPgv40N7Q7XfS68=;
	b=aXCVflRVo+2eYCZ+kmxBAEGHGGolrNYHvHfqxXKUCHGy+LAMQTKcnmiHD+CgSk0mCzS0fv
	ULUXN2aiTNrJFjxfEhWMmrsSawE5mTfjk9Bnku8aYe0TpqEKx90ZHNjrBJ/hoGYHbkNrxc
	+1jO4f3wZTT2db17Nu4GdBjHibHL3NY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-OjS15zJtM8uKNBfz_sY6Kg-1; Fri, 16 Feb 2024 08:48:56 -0500
X-MC-Unique: OjS15zJtM8uKNBfz_sY6Kg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33b1ad7dfe1so946393f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091335; x=1708696135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHwFSfupJsy1hRAlGeBjUd3fBxQOvPgv40N7Q7XfS68=;
        b=ou7mL4AtnSobYOvMM/T/6WowQd7EIIIz23iS6sHhlXOLWWZys+qmdlw+0id3z7b/Gw
         HhEzKlYRTDWfzaa9WoTL6yPuFQ3Gou9d/RMW5DXJn8OdGl45VqMITcLNqW1PTb7zuyk7
         vWJzAOB2B9yo2fdPTvnGWR3gZX62+3Q48Y9U7kGzB4cP5hMZQjhScBb0dc46OnbZNcix
         RRzpmoCix8hA+RmFjAGG24wjkQqNYrl/KsSqfByrn3frIo8wCM7pXlg6E3XsR66/DLVb
         loWJYB2mKt8e00IHPU/lU44oILumWpMVQCEs4S6ZBKqUPKWFDrcpkhskQOi7/GIBG8pi
         HdMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpStWgsfOmFu7bsp6Zqwqt5+G9lFiYJ6a+4GrvJdbYab28gG93hWdin0tNrRROURkIGLVAWpwnsFTVYWFjE9PCWW252rXF0CAjCV4Y
X-Gm-Message-State: AOJu0Yxnzmq43CM2+gvDTiL2+I2PhqgrxLjJRiUqZc9dqVt/92ntKYRG
	grZLfZbMrFFL1XPlSuNLiFc2+7oAc52GhYUgklwcP6p2cT22ItI+FSe6KMGL/Zye/xII2Ak2hFg
	pjENZ/X09BFq1MpTIBLTibicsJbvX8bnFzwLWb0utunGyqaVsap8zFTRr3uyY8A==
X-Received: by 2002:adf:a446:0:b0:33d:4e5:b1f2 with SMTP id e6-20020adfa446000000b0033d04e5b1f2mr2846249wra.38.1708091335563;
        Fri, 16 Feb 2024 05:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKRiyhBRn3dqC1O4++DJPl4UeczabTxLsvRYTNlOGCoRxMyc7ZUtF2wusHbWzsZjImqCuLnA==
X-Received: by 2002:adf:a446:0:b0:33d:4e5:b1f2 with SMTP id e6-20020adfa446000000b0033d04e5b1f2mr2846231wra.38.1708091335123;
        Fri, 16 Feb 2024 05:48:55 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:2d32:e5b8:d152:6384:cef9])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b0033d10bd6612sm2343482wry.81.2024.02.16.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:48:54 -0800 (PST)
Date: Fri, 16 Feb 2024 08:48:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>, jasowang@redhat.com,
	perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [v4 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240216084610-mutt-send-email-mst@kernel.org>
References: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
 <20240216062630-mutt-send-email-mst@kernel.org>
 <87eddcikz6.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eddcikz6.wl-tiwai@suse.de>

On Fri, Feb 16, 2024 at 02:42:37PM +0100, Takashi Iwai wrote:
> On Fri, 16 Feb 2024 12:27:48 +0100,
> Michael S. Tsirkin wrote:
> > 
> > On Fri, Feb 16, 2024 at 11:06:43AM +0100, Aiswarya Cyriac wrote:
> > > This commit fixes the following warning when building virtio_snd driver.
> > > 
> > > "
> > > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > > 288
> > > 289     		break;
> > > 290     	}
> > > 291
> > > 292     	kfree(tlv);
> > > 293
> > > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > > vvv     Using uninitialized value "rc".
> > > 294     	return rc;
> > > 295     }
> > > 296
> > > 297     /**
> > > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > > 299      * @snd: VirtIO sound device.
> > > "
> > > 
> > > This warning is caused by the absence of the "default" branch in the
> > > switch-block, and is a false positive because the kernel calls
> > > virtsnd_kctl_tlv_op() only with values for op_flag processed in
> > > this block.
> > > 
> > > Also, this commit unifies the cleanup path for all possible control
> > > paths in the callback function.
> > > 
> > > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> > 
> > 
> > 
> > > ---
> > >  sound/virtio/virtio_kctl.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> > > index 0c6ac74aca1e..7aa79c05b464 100644
> > > --- a/sound/virtio/virtio_kctl.c
> > > +++ b/sound/virtio/virtio_kctl.c
> > > @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> > >  
> > >  	tlv = kzalloc(size, GFP_KERNEL);
> > >  	if (!tlv) {
> > > -		virtsnd_ctl_msg_unref(msg);
> > > -		return -ENOMEM;
> > > +		rc = -ENOMEM;
> > > +		goto on_msg_unref;
> > >  	}
> > >  
> > >  	sg_init_one(&sg, tlv, size);
> > > @@ -281,14 +281,25 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> > >  			hdr->hdr.code =
> > >  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
> > >  
> > > -		if (copy_from_user(tlv, utlv, size))
> > > +		if (copy_from_user(tlv, utlv, size)) {
> > >  			rc = -EFAULT;
> > > -		else
> > > +			goto on_msg_unref;
> > > +		} else {
> > >  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> > > +		}
> > >  
> > >  		break;
> > > +	default:
> > > +		rc = -EINVAL;
> > > +		/* We never get here - we listed all values for op_flag */
> > > +		WARN_ON(1);
> > > +		goto on_msg_unref;
> > >  	}
> > > +	kfree(tlv);
> > > +	return rc;
> > >  
> > > +on_msg_unref:
> > > +	virtsnd_ctl_msg_unref(msg);
> > >  	kfree(tlv);
> > >  
> > >  	return rc;
> > 
> > I don't really like adding code for a false-positive but ALSA
> > maintainers seem to like this. If yes, this seems like as good
> > a way as any to do it.
> 
> Err, no, you misunderstood the situation.
> 
> I took the v1 patch quickly because:
> - It was with Anton's SOB, who is another maintainer of the driver
> - I assumed you lost interest in this driver since you haven't reacted
>   to the previous patches for long time
> - The change there was small and simple enough
> 
> Now, it grows unnecessarily large, and yet you complained.  Why should
> I take it, then?
> 
> This is a subtle cosmetic issue that isn't worth for wasting too much
> time and energy.  If we want to shut up the compile warning, and this
> is a case where it can't happen, just put the "default:" to the
> existing case.  If you want to be user-friendly, put some comment.
> That's all.  It'll be a one-liner.
> 
> OTOH, if we do care and want to catch any potential logical mistake,
> you can put WARN().  But, this doesn't have to go out as an error.
> Simply putting WARN() for the default and going through would work,
> too.
> 
> Or we can keep this lengthy changes if we want, too.
> 
> So, I really don't mind which way to fix as long as it works correctly
> (and doesn't look too ugly).  Please make agreement among you guys,
> and resubmit if needed.
> 
> 
> thanks,
> 
> Takashi

OK sorry about too verbose.  I mean since Anton wants it, I ack this.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


-- 
MST


