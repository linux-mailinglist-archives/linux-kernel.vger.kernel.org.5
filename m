Return-Path: <linux-kernel+bounces-31545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2C3832FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6191F21EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA657302;
	Fri, 19 Jan 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJMV/epB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094956B67
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696420; cv=none; b=RJOyl6kXngZOzGy/9fo1DB4B5q/nIX09eEzrH/a4986PB1BeWsoqPSwebuidqOr0HieIIQPYILBGnU3Wafq1Hn8qbCnfAM6dw/5nWVpUk6CYmAoVH3nKfXXZEQ0t56fzIwQ+S4DEouwQKw3gycv09/1y7RAM87nXYYjfyqlrEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696420; c=relaxed/simple;
	bh=h9XBr5HaJ/uFiFMnAreiYyHUr83rMb3XT3dOLAggjgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyD6nVjfwmy1V0gL9owPb8vXm7MCTgn7HXJ1u9jysApR0oF+dcPLo9MNJwBWF30TxAaPnERKh08dx1pCgyszGavdU33iBr4WatHnY/aO9K6cH8FFaMIUN3vv4UJJ+eHdhv5lzNCfyG0l3H2y9jqaCfp56Ll94XiKEu8cq1ZpdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJMV/epB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705696418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8II+sjR5xHcOZI+QrGs/mEkMTr6W1boBv3DnY0zN3sg=;
	b=CJMV/epB+OFsus5avtKNVoCOrXe/d91p3vvYWDkYRzQQfi8+gFPy6fX0XpXg2QWUJRH1Oi
	sxdIFcuQNtvx1BWE6ATzqv/9eO8VSQJhXAdEiOu93qyXFfJVmgC0zhmD21daq+i45MCXL6
	9sWgkjYT1MSSuWMevzHYE88RAB8xq0A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-0Jp_25TKM3a_XXOhvwo00g-1; Fri, 19 Jan 2024 15:33:36 -0500
X-MC-Unique: 0Jp_25TKM3a_XXOhvwo00g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6817865abc0so13739016d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705696416; x=1706301216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8II+sjR5xHcOZI+QrGs/mEkMTr6W1boBv3DnY0zN3sg=;
        b=l2v9OcmLZNm5GrsCjJJVwpUSBYW6QK6YQRvg9h/P5G8MhfEtfmwTRQL8xaf+7BezSH
         7M0HPdfL5IrBIHEiJVRuXJxVzMX2trGEVjrr12bRKUPDeP3XrFuUwmujynXaFNUbEGf9
         vQ7NoUtVZfwR7DlFTwosOTonFfiqNS7V9+Pb02Z/KrUM3TQFotAAOb8i+QrPTX691tmE
         8o2c1PC+6VQ5G6pxP2I3MwllnhkLQAcud//wToNUZ8uGOEIll7TX35/9Q0zwyUQGYbhX
         emkzm01icnCP/fZsYJrG1tHPM1bsm5NTSRda+wk8113zd+LR4yviLU+VmvANUwTtmmqA
         vYmw==
X-Gm-Message-State: AOJu0Yx1apZjle5t8brhO+rHGgC1D4AET4IvLXDwbRCbZWr4gHKtsxOW
	7f5HotnPWPPoj9CM4jgp4tULmrOgpxkQfYeb1pbWaT2YMpSCML3wGlBiqPc0nKWGy771ISFqegs
	FzBfeNy/yQY7XrzgvmnxwRFtv0WNN2GYSB3NNyrXaqRgjJiRI5hwY8m/UylczEQ==
X-Received: by 2002:a05:6214:c83:b0:681:7cbc:5247 with SMTP id r3-20020a0562140c8300b006817cbc5247mr446910qvr.128.1705696416209;
        Fri, 19 Jan 2024 12:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1U3NPFbFHs1OEno9DRkZ6+8DnnbGWhwDnr/B28GJaArTaPnoJu/orv6qcy3AW38MQPjkyEQ==
X-Received: by 2002:a05:6214:c83:b0:681:7cbc:5247 with SMTP id r3-20020a0562140c8300b006817cbc5247mr446900qvr.128.1705696415930;
        Fri, 19 Jan 2024 12:33:35 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id pz12-20020ad4550c000000b0067f82678cebsm7284qvb.12.2024.01.19.12.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:33:35 -0800 (PST)
Date: Fri, 19 Jan 2024 14:33:32 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] scsi: ufs: qcom: avoid re-init quirk when gears match
Message-ID: <otgj6524k6wiy27depeo7ckopmrr2v3xdnaoph4c5djjohnpmg@f7hyetygcyyr>
References: <20240119185537.3091366-11-echanude@redhat.com>
 <3xnedre2d32rkad6n2ln4rrah7sgg6epxnzsdm54uab3zrutnz@fww7wb5mvykj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xnedre2d32rkad6n2ln4rrah7sgg6epxnzsdm54uab3zrutnz@fww7wb5mvykj>

On Fri, Jan 19, 2024 at 02:07:15PM -0600, Andrew Halaney wrote:
> On Fri, Jan 19, 2024 at 01:55:47PM -0500, Eric Chanudet wrote:
> > On sa8775p-ride, probing the hba will go through the
> > UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info
> > are same during the second init.
> > 
> > If the host is at least v4, ufs_qcom_get_hs_gear() picked the highest
> > supported gear when setting the host_params. After the negotiation, if
> > the host and device are on the same gear, it is the highest gear
> > supported between the two. Skip the re-init to save some time.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> > 
> > "trace_event=ufs:ufshcd_init" reports the time spent where the re-init
> > quirk is performed. On sa8775p-ride:
> > Baseline:
> >   0.355879: ufshcd_init: 1d84000.ufs: took 103377 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> > With this patch:
> >   0.297676: ufshcd_init: 1d84000.ufs: took 43553 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> > 
> >  drivers/ufs/host/ufs-qcom.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index 39eef470f8fa..f9f161340e78 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -738,8 +738,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> >  		 * the second init can program the optimal PHY settings. This allows one to start
> >  		 * the first init with either the minimum or the maximum support gear.
> >  		 */
> > -		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
> > +		if (hba->ufshcd_state == UFSHCD_STATE_RESET) {
> > +			if (host->hw_ver.major >= 0x4 &&
> 
> Is this check really necessary?
> 
> The initial phy_gear state is something like this (my phrasing of
> ufs_qcom_set_phy_gear()):
> 
>     if hw_ver < 4:
>         # Comments about powering up with minimum gear (with no
>         # reasoning in the comment afaict), and mentions switching
>         # to higher gear in reinit quirk. This is opposite of the later
>         # versions which start at the max and scale down
>         phy_gear = UFS_HS_G2
> 
>     else if hw_ver == 4:
>         phy_gear = hs_tx_gear # (so afaict always UFS_HS_G4)
> 
>     else if hw_ver >= 5:
>         phy_gear = hs_tx_gear # (What ever the max is for this version)
> 
>         if dev_major:
>             # Clears the reinit quirk in ufs_qcom_set_phy_gear() if the
>             # device version is provided by bootloader / controller
>             # because we already found it out and can init directly
>             # to the ideal gear
>             quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH
> 
>             if dev_major < 4:
>                 # Sets gear to UFS_HS_G4 to save power for UFS 3.1 and
>                 # older devices
>                 phy_gear = UFS_HS_G4
> 
> I guess what I'm saying is that I'm not totally seeing how this check
> is dependent on the controller version. To me, if we're in the ideal
> gear already and we know it, we should *not* reinit, no matter what the
> controller version is. That's assuming there's not some other reasoning
> for the quirk, but as far as I understand it the quirk exists because we
> have to start with *some* phy gear value so we can talk to the device,
> and once we discover what the device is capable of it makes sense to
> scale down (or up for older controllers) to the ideal gear setting for
> the attached device. Unfortunately to do the change we have to
> reprogram the phy which I guess is only acceptable if we reprogram
> everything (hence the reinit).
> 
> Does that make sense or do you think I'm missing something? I think say
> even for an older controller this makes sense, if its attached to a
> UFS_HS_G2 capable device there is no reason to reinit since we started
> up in the ideal configuration.

I guess what I'm saying is shouldn't the check be something like:

    if (dev_req_params->gear_tx == host->phy_gear) {
        // Skip reinit since we started up in the agreed upon gear
        hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
    }

Which is independent of the controller version?

> 
> Thanks,
> Andrew
> 
> > +			    host_params->hs_tx_gear == dev_req_params->gear_tx)
> > +				hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
> >  			host->phy_gear = dev_req_params->gear_tx;
> > +		}
> >  
> >  		/* enable the device ref clock before changing to HS mode */
> >  		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
> > -- 
> > 2.43.0
> > 
> > 


