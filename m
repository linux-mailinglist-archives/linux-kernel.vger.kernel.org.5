Return-Path: <linux-kernel+bounces-164961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADCA8B857A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0875A1C22DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D84CDE0;
	Wed,  1 May 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP9p/LKs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138C1BDCF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714543294; cv=none; b=RfyZa/m0woUhuxzfmQkv6XSZCTNbLpm0vVqOwh0NxpVkq5X+hrt1Oof8jwHD2NF7+KW0x/aSSjVSsWHo4J0JPUbBXSLvx5G/0ti8zQK8vXfGW3fiHlqZnHG9PvB0YAURw9z4lfHWWv/PC78YP9g6faLNuIslmy2g4SGmHRcasqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714543294; c=relaxed/simple;
	bh=826e6puMm6zzTrxffD62gEQ3vdQCaEKJUlUGOq1Xpv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8zBcgSp8MXBFIGxj29BsQHn6d1FOIKJPGqLpY8iUAO2UiJfw8/uk/4hfn7Gf20gBgLZ3JdxSsySV5G3cmKfStmW72NdVlJYLvzSWy44ZgmLvcNLDzNe/HtVhyEsZz9KazcOqU44Qy79kbyWkMDJ9XoBeJA0pzrSdBjuiDXmV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WP9p/LKs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714543290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACs9fP8UeUOFIH6gYeB8LpBxm1NZNbq1XOuqsdPyK04=;
	b=WP9p/LKsTQuPefpgMXTto/pbKquAMY6VUr/xniB1xNPII0E1KfAHYVKX6IkawFw+KUmZWX
	0V1xLQsnLqJlpTuTCZCnbRE9/awc+RANCIfhfCJFtDpqP329RgKBdNsW1QCKOLVrgP5YkY
	mreeMJkTFwI/Mhuk1hKMy78iE2dO10M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-aIQREy5zN8e_AcShuauzww-1; Wed, 01 May 2024 02:01:29 -0400
X-MC-Unique: aIQREy5zN8e_AcShuauzww-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a59324b5fb3so84120066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714543286; x=1715148086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACs9fP8UeUOFIH6gYeB8LpBxm1NZNbq1XOuqsdPyK04=;
        b=ZOp/9E00Tz/4rj4F/RtDUeVxlK9I22q0Q95aTJpGtBqmt1+BiIiB+mm+bB5xkFNDFh
         LYxUTDEluI4aj2EP+LTS8ZPrrm2SY42WW+8VZCD1FSQ5ViEGNZD1q9sFuhAfGEbU1E/8
         EHQ3rOyp9iyRXHj3hcq5N03JMR5eCYC9FsEJM8utkK7Tg03YWHos/B6DqnWwN454Gtsr
         +nspp8fpejFbmfU2RX2pscWBvOQb/TtZZWBJkgqJfaceV1Bx6A9yNiKOnCMkA11lzhMv
         9RT6c9oGFoyfDRrXNxhn3SrWduJg0zw06HVm8m9mkCMjssr+ukjsOKR+J8g6qXSECLFr
         P2zA==
X-Forwarded-Encrypted: i=1; AJvYcCV1wRpPadG1h67UeszLTz0Y1OzmN85G6R26I0+KL8LEgq3CnNuNUtSFz5bLhAsHng/Du/NGV96bOod9mGH0xYuDujlSHmvtDPMWx714
X-Gm-Message-State: AOJu0YzP4DSvpIMqhXvxnY5OxGjl44+L1qoUq+lbUIjgtsQIbvHmuCWr
	NJOxLwCbePDbIU4A4XY/2bbutNZ0qlZgReFrEj/zsnnlPE5ZneLs52PsvcOkBwNrrRM1SK6dhrb
	nON2t20K4ewLKfIuCI8cCibyP4Ju7/XbYt1VRUHBMCczyNkdq2KHQwUdLo6MUZHkPjbi3Cw==
X-Received: by 2002:a17:906:e219:b0:a58:f186:192 with SMTP id gf25-20020a170906e21900b00a58f1860192mr1224393ejb.0.1714543286367;
        Tue, 30 Apr 2024 23:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSlMxEoUZ88OBzUnW9OSy6mbDeqVmGiKA+13uWDb7mOt6quE44mzfAWkhW9+s6sFw1/mZ2+A==
X-Received: by 2002:a17:906:e219:b0:a58:f186:192 with SMTP id gf25-20020a170906e21900b00a58f1860192mr1224363ejb.0.1714543285807;
        Tue, 30 Apr 2024 23:01:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b00a5910978816sm2187459ejb.121.2024.04.30.23.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:01:25 -0700 (PDT)
Date: Wed, 1 May 2024 02:01:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Mike Christie <michael.christie@oracle.com>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501020057-mutt-send-email-mst@kernel.org>
References: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
 <20240501001544.1606-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501001544.1606-1-hdanton@sina.com>

On Wed, May 01, 2024 at 08:15:44AM +0800, Hillf Danton wrote:
> On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> > On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> > >  static int vhost_task_fn(void *data)
> > >  {
> > >  	struct vhost_task *vtsk = data;
> > > @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> > >  			schedule();
> > >  	}
> > >  
> > > -	mutex_lock(&vtsk->exit_mutex);
> > > +	mutex_lock(&exit_mutex);
> > >  	/*
> > >  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> > >  	 * When the vhost layer has called vhost_task_stop it's already stopped
> > > @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> > >  		vtsk->handle_sigkill(vtsk->data);
> > >  	}
> > >  	complete(&vtsk->exited);
> > > -	mutex_unlock(&vtsk->exit_mutex);
> > > +	mutex_unlock(&exit_mutex);
> > >  
> > 
> > Edward, thanks for the patch. I think though I just needed to swap the
> > order of the calls above.
> > 
> > Instead of:
> > 
> > complete(&vtsk->exited);
> > mutex_unlock(&vtsk->exit_mutex);
> > 
> > it should have been:
> > 
> > mutex_unlock(&vtsk->exit_mutex);
> > complete(&vtsk->exited);
> 
> JFYI Edward did it [1]
> 
> [1] https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/

and then it failed testing.

> > 
> > If my analysis is correct, then Michael do you want me to resubmit a
> > patch on top of your vhost branch or resubmit the entire patchset?


