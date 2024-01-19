Return-Path: <linux-kernel+bounces-31581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D68833054
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F071F23712
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C258220;
	Fri, 19 Jan 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbSo464k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616CC58100
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699996; cv=none; b=UF6HQh6wfGEKLGB+da6tRICR3mRO32dJoPw6mo1pcBWGQRKhYcVz3ImpCcgAYVuE/+OdbOT9qEsXdl6p6LY9x12JCPVyyOA6Wae1TgewMDNghDgnKjsRNN95sPSBeFSN9WXQeDpv9cJrFRPn8q9yUp7C33CLwK4C5W5wjluHt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699996; c=relaxed/simple;
	bh=EkTj7yDGwdkzAs8tBNlRMDUvXzIDCIPdlE7L2nKM844=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7EwyoFEoRPB+oWXcJo4f6890kNFP1b8zfJIzvDVRH0FiM0j57oyrW3w+YWmCSmCfWcW/w1zkDNisX/73HPZi36Inf1PXkwvSFvrV93ZeuvKDIgRloR5hofXjdmJaAIzbwfBGGN16SDbisf3lLpPWJwpzcf6W11iz75aVM5wUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbSo464k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzrWPZR5+3QYuqMx3/O+fwKFrZi0Xwysmh/7OAXDcYM=;
	b=fbSo464k7XvSr96aYW4EOzeJ7XIXlJ4i5DcpvJhnVjvHtD+jxNUXuB3zbABa96Vm4K08mE
	V79LK4qRjvkT2Ose2rTXDUc0mjqXbNLazAkSsSrxI2nupCpXIr0ptFIl2L8YoyfdQsvQHy
	L1fIv/BmblvR01IKGPLVFqHbzOeMN68=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-uajpGbASMFqstPpvxjAzAw-1; Fri, 19 Jan 2024 16:33:12 -0500
X-MC-Unique: uajpGbASMFqstPpvxjAzAw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6855c0719a8so275266d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699992; x=1706304792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzrWPZR5+3QYuqMx3/O+fwKFrZi0Xwysmh/7OAXDcYM=;
        b=txmUSgnzwupHYKcnzMSpnMu17DGTDFdM44QfMMe7/1xj5/Dl5mTvU0LtNNwZEUWwoJ
         n6LCmyImUFqVSxBZDMsDMgHFRo8JJ7nv2fZEFdoY8RAYG5oZ8IttcoSVjwMEraqyUPwi
         lZRLWoI8MG7DZlMVyITX0Gfj75w6JwuizV6cpnX6QJ8ZMUAT5l/4dD2Pcb84SgIy2bai
         Q5aLbAXqA0Lq9xdm/nHFY6ivU7T882YYORjAsxlB5bXkMWvj/wO84lFyVowPWfGEh3kS
         C/52K/wociFe4LyepM1x83qihOBHeBP+IN1V6KRSgSAfoiMjAo+WpUH/KozqDxtIhrvW
         w7gA==
X-Gm-Message-State: AOJu0YxxQRR9RGYgzZnu7mJgKp2XpJ8qubAK+DHeO9R9Off4Bo8GjBXW
	HDEj+p694S9l5uQqY9CCn69802bzI/yQ36qc6lHuLGPAYmnxEkCsK5LaozCpNqVAV6kCxUH2MaC
	4qgeL0hJohlPfbSQ2D7377s7HzcGrPPLCVhE+RBJOBf77Vw/cEYTRzmcnM+WWtw==
X-Received: by 2002:a05:6214:2686:b0:680:c880:6646 with SMTP id gm6-20020a056214268600b00680c8806646mr668649qvb.22.1705699992321;
        Fri, 19 Jan 2024 13:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzzipQRf/AqpwwysE2kv7ZI6fkFW9M4nW61XT5BD6zZ/s+tUut70peKPfzGaEivdj8NjgXpQ==
X-Received: by 2002:a05:6214:2686:b0:680:c880:6646 with SMTP id gm6-20020a056214268600b00680c8806646mr668638qvb.22.1705699992064;
        Fri, 19 Jan 2024 13:33:12 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id di8-20020ad458e8000000b006818a1e269csm39021qvb.102.2024.01.19.13.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:33:11 -0800 (PST)
Date: Fri, 19 Jan 2024 16:33:10 -0500
From: Eric Chanudet <echanude@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] scsi: ufs: qcom: avoid re-init quirk when gears
 match
Message-ID: <graeyylgohsukni35djpbxibnz5ya7laqvsydharkzcktv2iwz@knbu5uq5fa4x>
References: <20240119185537.3091366-11-echanude@redhat.com>
 <3xnedre2d32rkad6n2ln4rrah7sgg6epxnzsdm54uab3zrutnz@fww7wb5mvykj>
 <otgj6524k6wiy27depeo7ckopmrr2v3xdnaoph4c5djjohnpmg@f7hyetygcyyr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <otgj6524k6wiy27depeo7ckopmrr2v3xdnaoph4c5djjohnpmg@f7hyetygcyyr>

On Fri, Jan 19, 2024 at 02:33:32PM -0600, Andrew Halaney wrote:
> On Fri, Jan 19, 2024 at 02:07:15PM -0600, Andrew Halaney wrote:
> > On Fri, Jan 19, 2024 at 01:55:47PM -0500, Eric Chanudet wrote:
> > > On sa8775p-ride, probing the hba will go through the
> > > UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info
> > > are same during the second init.
> > > 
> > > If the host is at least v4, ufs_qcom_get_hs_gear() picked the highest
> > > supported gear when setting the host_params. After the negotiation, if
> > > the host and device are on the same gear, it is the highest gear
> > > supported between the two. Skip the re-init to save some time.
> > > 
> > > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > > ---
> > > 
> > > "trace_event=ufs:ufshcd_init" reports the time spent where the re-init
> > > quirk is performed. On sa8775p-ride:
> > > Baseline:
> > >   0.355879: ufshcd_init: 1d84000.ufs: took 103377 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> > > With this patch:
> > >   0.297676: ufshcd_init: 1d84000.ufs: took 43553 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> > > 
> > >  drivers/ufs/host/ufs-qcom.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > index 39eef470f8fa..f9f161340e78 100644
> > > --- a/drivers/ufs/host/ufs-qcom.c
> > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > @@ -738,8 +738,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> > >  		 * the second init can program the optimal PHY settings. This allows one to start
> > >  		 * the first init with either the minimum or the maximum support gear.
> > >  		 */
> > > -		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
> > > +		if (hba->ufshcd_state == UFSHCD_STATE_RESET) {
> > > +			if (host->hw_ver.major >= 0x4 &&
> > 
> > Is this check really necessary?

I *think* so.

For example, if hw_ver < 4, ufs_qcom_set_phy_gear() has a comment saying
"power up the PHY using minimum supported gear (UFS_HS_G2). Switching to
max gear will be performed during reinit if supported."

> > 
> > The initial phy_gear state is something like this (my phrasing of
> > ufs_qcom_set_phy_gear()):
> > 
> >     if hw_ver < 4:
> >         # Comments about powering up with minimum gear (with no
> >         # reasoning in the comment afaict), and mentions switching
> >         # to higher gear in reinit quirk. This is opposite of the later
> >         # versions which start at the max and scale down
> >         phy_gear = UFS_HS_G2

IIUC, the device would not be able to negotiate a gear higher than the
minimum set for the phy_gear on initialization.

ufshcd_init_host_params() and ufs_qcom_get_hs_gear() both set the
controller <v4 host_params to G3. So if the device is HS capable, the
re-init would set G3, instead of the G2 selected by
ufs_qcom_set_phy_gear().

Assuming I'm not loosing track somewhere, the sequence of calls would go
something like this:

ufshcd_init
 ufshcd_hba_init
  ufshcd_variant_hba_init
   ufshcd_vops_init
    ufs_qcom_init
     ufs_qcom_set_host_params /* if hw_ver < 4: phy_gear = G2 */
 ufshcd_hba_enable
  ufshcd_hba_execute_hce
   ufshcd_vops_hce_enable_notify(PRE_CHANGE)
    ufs_qcom_hce_enable_notify /* vops.hce_enable_notify */
     ufs_qcom_power_up_sequence
      phy_set_mode_ext(phy, mode, host->phy_gear);
 async_schedule(ufshcd_async_scan, hba)
 ...
 ufshcd_async_scan
  ufshcd_device_init
  ufshcd_probe_hba /* where the re-init quirk happens */
   ufshcd_device_init
    ufshcd_vops_pwr_change_notify(PRE_CHANGE)
  
So that would limit the device to G2? In this circumstances, the re-init
would instead re-initialize to G3.

> I guess what I'm saying is shouldn't the check be something like:
> 
>     if (dev_req_params->gear_tx == host->phy_gear) {
>         // Skip reinit since we started up in the agreed upon gear
>         hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>     }

-- 
Eric Chanudet


