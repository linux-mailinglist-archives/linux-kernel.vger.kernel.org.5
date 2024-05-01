Return-Path: <linux-kernel+bounces-164957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D850E8B856E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A351B22549
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22A4CB2B;
	Wed,  1 May 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1l2n20s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D981BDCF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714542750; cv=none; b=G09scUBBNBYAnAa2W7Ohqg+Y3WOBBydAiKeQLytvFPNDSS3YAUFZoVASV72PLGZTwXOBLhMVU09E979c8XVAv51BsIH3E6VM0UIRLA1Bohh8dGHdNJobWnIFM/nfBh8sVH+l8htxQLDRpuunfH9wlYfl6hBCBb8ZAEmE956/K9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714542750; c=relaxed/simple;
	bh=1nSr9Dg9aeCD6ofDp9t4KN3z2l/uZPlh2laVEmngj3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcNrgHdWHSNYtsUp6s3A7/PGp5kZ93tJNE2C2KccurQEte8oow0XGdqRSEEBKdTlDfbocWQU6IJ8UF4XInjIFMe2A2lMMhHgGDILrqT5lM7MoLslsCfIMPBgZS0MuoBTIc5anZ0ZZE5DVs9fTL03vRtVJskiUBgOV/vPKUNEdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1l2n20s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714542746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20n5h1sY1heSuCVbLnxOhUJlUUXIFUfl98aiHfNTEi0=;
	b=K1l2n20sCUtdz46j6rJY6Fmw79E5dR+OpCm5xzQXdJCI499iaEQSOn8tC1hstpoozlzDbG
	wMkuBVVUqiRz4w0iQGNPk7y0dQpOWFfQP5kH8aclNMA38tYxBVKdj/n1SasWbngc5ARhw8
	K6Jx/F1Y5E+S6AZrmfZex7LcJjeeggo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-rHuT05i3Oq-f3VKd8_Xz-g-1; Wed, 01 May 2024 01:52:25 -0400
X-MC-Unique: rHuT05i3Oq-f3VKd8_Xz-g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a58bca80981so343834166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714542744; x=1715147544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20n5h1sY1heSuCVbLnxOhUJlUUXIFUfl98aiHfNTEi0=;
        b=hW3qinpUsSgNckfOmMdxAhTz/mp52jX+BRq/5AMx/dVoQViDX+l2Ux+R4ZPF7PEnAL
         hkKnkwjim+bIy7teReOqWXB2NrJ9UipJk3Hzq+h90G3D340zmGpAZDIQtg6uA5b1E1h3
         2FGzmbuatt0BcJF0L+GoV/D0sFEvvG36OKzboQap56vWfP0lBz1M7z+3xUsAiW1Lkc7D
         yid7GXUpZY6PzhRB+3t+1sorW+H/pwWXHOWPnYWMYGzwkhOOe2MeNkCdEtIcRh6niY9z
         4qsR5Ve4Do6/jT9nBRhXHZJrB3WDi6x/vqSj4e+RirjVMDzDCk5DG1+KnrQY7YPPP9yY
         2sdw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8zPvc3ysHUoPztVs+aghdTEnI/cJUB0w/D98GuyAvYMNOK3zhAgZFOAy6aRZejXXV1GG96c0+Bm2BBNuBObfc5Jtd8BOP7QZt6b+
X-Gm-Message-State: AOJu0Yzx3djjT2wvjyis9ah2YwhSQ4ATtzjEqcs0QYhUtP+OXHxnmxvx
	r1588OWGMwUUFPwBPB8mYNtm1YKzh1d5UPh7NQm92Eup4l/HAhUOSixDI4o9+LT2CMQWZlJQUsR
	VU7trk5xIEmwvD47buekmSBJk1BvDIaUlOkMiAcVYT6rVhFWZh0c7jb+FKzXPEg==
X-Received: by 2002:a17:906:a24e:b0:a58:866a:1e80 with SMTP id bi14-20020a170906a24e00b00a58866a1e80mr991886ejb.36.1714542743897;
        Tue, 30 Apr 2024 22:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBGvs60kCUCPWvX1cwlAhol2+CkeL02isqut8YkmaCVV+Z+zcH4uvAU7Plv220noZVfxO0rg==
X-Received: by 2002:a17:906:a24e:b0:a58:866a:1e80 with SMTP id bi14-20020a170906a24e00b00a58866a1e80mr991871ejb.36.1714542743405;
        Tue, 30 Apr 2024 22:52:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm2821481ejb.64.2024.04.30.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 22:52:22 -0700 (PDT)
Date: Wed, 1 May 2024 01:52:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501014753-mutt-send-email-mst@kernel.org>
References: <20240501001544.1606-1-hdanton@sina.com>
 <59d61db8-8d3a-44f1-b664-d4649615afc7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d61db8-8d3a-44f1-b664-d4649615afc7@oracle.com>

On Tue, Apr 30, 2024 at 08:01:11PM -0500, Mike Christie wrote:
> On 4/30/24 7:15 PM, Hillf Danton wrote:
> > On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> >> On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> >>>  static int vhost_task_fn(void *data)
> >>>  {
> >>>  	struct vhost_task *vtsk = data;
> >>> @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> >>>  			schedule();
> >>>  	}
> >>>  
> >>> -	mutex_lock(&vtsk->exit_mutex);
> >>> +	mutex_lock(&exit_mutex);
> >>>  	/*
> >>>  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> >>>  	 * When the vhost layer has called vhost_task_stop it's already stopped
> >>> @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> >>>  		vtsk->handle_sigkill(vtsk->data);
> >>>  	}
> >>>  	complete(&vtsk->exited);
> >>> -	mutex_unlock(&vtsk->exit_mutex);
> >>> +	mutex_unlock(&exit_mutex);
> >>>  
> >>
> >> Edward, thanks for the patch. I think though I just needed to swap the
> >> order of the calls above.
> >>
> >> Instead of:
> >>
> >> complete(&vtsk->exited);
> >> mutex_unlock(&vtsk->exit_mutex);
> >>
> >> it should have been:
> >>
> >> mutex_unlock(&vtsk->exit_mutex);
> >> complete(&vtsk->exited);
> > 
> > JFYI Edward did it [1]
> > 
> > [1] https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/
> 
> Thanks.
> 
> I tested the code with that change and it no longer triggers the UAF.

Weird but syzcaller said that yes it triggers.

Compare
000000000000dcc0ca06174e65d4@google.com
which tests the order
	mutex_unlock(&vtsk->exit_mutex);
	complete(&vtsk->exited);
that you like and says it triggers

and
00000000000097bda906175219bc@google.com
which says it does not trigger.

Whatever you do please send it to syzcaller in the original
thread and then when you post please include the syzcaller report.

Given this gets confusing I'm fine with just a fixup patch,
and note in the commit log where I should squash it.


> I've fixed up the original patch that had the bug and am going to
> resubmit the patchset like how Michael requested.
> 


