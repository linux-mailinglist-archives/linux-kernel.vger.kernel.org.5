Return-Path: <linux-kernel+bounces-65128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5744D85485E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4BE1C26F32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC5519BA2;
	Wed, 14 Feb 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnELTRJR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A96199AB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910230; cv=none; b=OMHDq8WCqVZk8yeckmLXgvm7RDgkEbYLNwN1IwV90KU5VPdYjsThqKPg1Y1N4fiIFtTAz3/lh/Wahwl87K/OcYVLA3JMKjdxexYBn7IL4J4PeiqwstizHLClfotpKjjxk+/6D4VAq8EbY2WjnAnacHLLrKP+bC0Mnu+/IeB58ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910230; c=relaxed/simple;
	bh=wA+l9FLOXe7DpldMydeqojyZQuQ0PE/xvA/Dhu62gk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLf4NTdqgp+f+BfbVu8eN89QLlHinITFfxnoCEYcwtbkyCn6piM1+HcWrusg3kWjfYiFtaOIRNkWXXW1AXuCiXDe2CJKBI5WAoBpJ4ymAs3IWNKExyxehnyXSjhJwpMdDqyKqOniAfxB/e72mxHvGAt6NpnwL8kjQRuAcM8sRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnELTRJR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707910226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+JlxetLqGfgXIuO+M860n27Ubw/CGDuUo/QeS89UmM=;
	b=JnELTRJR7mzqN0jr2uDcOewR+vTV1ZtcwBd8DxJj8/bJg2c30OFCynEIB1DaNoiBedKACP
	wIcNCmfK6ZZ4od0WrRJFKp6QWdCbCLzAyzkkqLhMsZ4HkN5kJpnc/QFdtmmZJKU5O9LFN1
	Mo52ta9kY7XNX+ViSTS59yuvw5HOqlQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-mvIvE464N02sFZTbygKqxA-1; Wed, 14 Feb 2024 06:30:25 -0500
X-MC-Unique: mvIvE464N02sFZTbygKqxA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33cf20c6cf8so82422f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707910224; x=1708515024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+JlxetLqGfgXIuO+M860n27Ubw/CGDuUo/QeS89UmM=;
        b=sCwezyeug+jUQz82rYNb5QcHseG0QyMm78sJM1GVzOlEgr8y6il2Gb17iD1ncSF6Pw
         vke1IrQ2W6Qt0nleUyvEctyRek8e/f8MF9LlkuzoPQvnoklcS1Ykjy8H8n2qMNhmB6ux
         CQtYGEXsH0/sMYBwjMpTkI2jOII4+u5Ggjao5A5kLe2raOiTiscO2UgVf9KgEx/6JmDL
         +ppBlf+JNsJUViPYuFP+ZLC/gTLEkvW6xiQ8+gJGzL/UO2bZoemCcHlJIiaTSYsBpdR0
         dsIfxi9hcPftcwPtsyhbxH7BbvU2M34oJZ4oktUnZpXzW5lrd5Xmy4+c6oM+MDf0n3ZX
         ocvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7jYQa9TeMmhAMAfdvb/XNTelob7ugQzHEe7TVEpKRy5MFHB4XY8CYa+6lI1byFUHCAhAvnrnFNUDz4pQkgltUnt66GH+JVgqA/qK2
X-Gm-Message-State: AOJu0YxoANOO1bSNFl88fClnpR9Von/51qhz1alAZbJMQABPD8/4C39J
	wU+4d7L9xP6tCPgXKiE5o0hER3lThln9voruGLOqP5mcujHaONVgN4NHy9zALFhwYrDFeM0GYeN
	M4c7+u6mAa7dEEoseZmfGUmkhtW5545p7vxHDrD4wBEmtsbsergTdWbHm4ZncoA==
X-Received: by 2002:a5d:6ac3:0:b0:33c:e323:ce39 with SMTP id u3-20020a5d6ac3000000b0033ce323ce39mr1560150wrw.43.1707910224272;
        Wed, 14 Feb 2024 03:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn/7CRCNOkTTcJ4FiqDJfiAfmidzS77K5Cp7PsBHxs2ygLXQq31lQk0BgMb5mWCWD9xGG0qA==
X-Received: by 2002:a5d:6ac3:0:b0:33c:e323:ce39 with SMTP id u3-20020a5d6ac3000000b0033ce323ce39mr1560128wrw.43.1707910223905;
        Wed, 14 Feb 2024 03:30:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDnOrhIMIku8GYfeG5v1QLOIsqpsWLfcFAOxVRTDhWd4QHsJdvn9P/TrtDxxxBc5KEnbVU6j3LWFAgjhA1jUcxp0j32JICPff8+5mX7ke+dqKNjuPGzOi0r3t9rXz9ZrkKP3IOSMM73xsEmNcdk3Br2n7mU2CLbwbFwadQowLPHTmDYFMei2PBySartjQ7qVVffGVKBNNspJnDCQA33QhmhyfShe2Ov1Vfv94C3JkXVHYkJUoo5o6VbuKYmi1st5dmbWrMiZI7VJFotHgrnDIO7eG96f7NfrGTNgDZUjUaq49+bDKxHftvXzUS8hK+BGdysLHtSQcnr2WW9PKk4jyacZVONaQ1unbKeGlva3vCkh+/41CY9jyXysZ4BnkrMDIrW3pCazO+tOomCvo47s2hM6OVxxBFtFHMccATLCMXWLYN
Received: from redhat.com ([2.52.26.67])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b003392206c808sm12083778wrv.105.2024.02.14.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 03:30:23 -0800 (PST)
Date: Wed, 14 Feb 2024 06:30:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <Aiswarya.Cyriac@opensynergy.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240214062348-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
 <20240213035806-mutt-send-email-mst@kernel.org>
 <FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>

On Wed, Feb 14, 2024 at 09:08:26AM +0000, Aiswarya Cyriac wrote:
> Hi Michael,
> 
> Thank you for reviewing. I have updated my response inline
> 
> On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> >> Fix the following warning when building virtio_snd driver.
> >>
> >> "
> >> *** CID 1583619:  Uninitialized variables  (UNINIT)
> >> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> >> 288
> >> 289         break;
> >> 290       }
> >> 291
> >> 292       kfree(tlv);
> >> 293
> >> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> >> vvv     Using uninitialized value "rc".
> >> 294       return rc;
> >> 295     }
> >> 296
> >> 297     /**
> >> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> >> 299      * @snd: VirtIO sound device.
> >> "
> >>
> >> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> >> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> >> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> >> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> >> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> >I don't know enough about ALSA to say whether the patch is correct.  But
> >the commit log needs work: please, do not "fix warnings" - analyse the
> >code and explain whether there is a real issue and if yes what is it
> >and how it can trigger. Is an invalid op_flag ever passed?
> >If it's just a coverity false positive it might be ok to
> >work around that but document this.
> 
> This warning is caused by the absence of the "default" branch in the
> switch-block, and is a false positive because the kernel calls
> virtsnd_kctl_tlv_op() only with values for op_flag processed in
> this block.

Well we don't normally have functions validate inputs.
In this case I am not really sure we should bother
with adding dead code. If you really want to, add BUG_ON.



> I will update the fix and send a v2 patch
> 
> >> ---
> >>  sound/virtio/virtio_kctl.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> >> index 0c6ac74aca1e..d7a160c5db03 100644
> >> --- a/sound/virtio/virtio_kctl.c
> >> +++ b/sound/virtio/virtio_kctl.c
> >> @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> >>                else
> >>                        rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> >>
> >> +             break;
> >> +     default:
> >> +             virtsnd_ctl_msg_unref(msg);
> >> +             rc = -EINVAL;
> >> +
> 
> >There's already virtsnd_ctl_msg_unref call above.
> >Also don't we need virtsnd_ctl_msg_unref on other error paths
> >such as EFAULT?
> >Unify error handling to fix it all then?
> 
> This also need to be handled and virtsnd_ctl_msg_unref needed in case of EFAULT as well.
> I will update the patch.
> 
> 
> Thanks,
> Aiswarya Cyriac
> Software Engineer
> ​
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> EMail: aiswarya.cyriac@opensynergy.com
> 
> www.opensynergy.com
> Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616B
> Geschäftsführer/Managing Director: Régis Adjamah
> 
> ________________________________________
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 13, 2024 10:06 AM
> To: Aiswarya Cyriac
> Cc: jasowang@redhat.com; perex@perex.cz; tiwai@suse.com; linux-kernel@vger.kernel.org; alsa-devel@alsa-project.org; virtualization@lists.linux-foundation.org; virtio-dev@lists.oasis-open.org; Anton Yakovlev; coverity-bot
> Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
> 
> On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> > Fix the following warning when building virtio_snd driver.
> >
> > "
> > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > 288
> > 289         break;
> > 290       }
> > 291
> > 292       kfree(tlv);
> > 293
> > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > vvv     Using uninitialized value "rc".
> > 294       return rc;
> > 295     }
> > 296
> > 297     /**
> > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > 299      * @snd: VirtIO sound device.
> > "
> >
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> I don't know enough about ALSA to say whether the patch is correct.  But
> the commit log needs work: please, do not "fix warnings" - analyse the
> code and explain whether there is a real issue and if yes what is it
> and how it can trigger. Is an invalid op_flag ever passed?
> If it's just a coverity false positive it might be ok to
> work around that but document this.
> 
> 
> > ---
> >  sound/virtio/virtio_kctl.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> > index 0c6ac74aca1e..d7a160c5db03 100644
> > --- a/sound/virtio/virtio_kctl.c
> > +++ b/sound/virtio/virtio_kctl.c
> > @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> >               else
> >                       rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> >
> > +             break;
> > +     default:
> > +             virtsnd_ctl_msg_unref(msg);
> > +             rc = -EINVAL;
> > +
> 
> There's already virtsnd_ctl_msg_unref call above.
> Also don't we need virtsnd_ctl_msg_unref on other error paths
> such as EFAULT?
> Unify error handling to fix it all then?
> 
> >               break;
> >       }
> >
> > --
> > 2.43.0
> 
> 


