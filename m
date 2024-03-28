Return-Path: <linux-kernel+bounces-122549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988188F949
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71F528F947
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111965380F;
	Thu, 28 Mar 2024 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOPpP3K4"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77222EED;
	Thu, 28 Mar 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612664; cv=none; b=R4WV7nbavuDR5sAeUhOd472HHID8EVoqy+cscnIfBvEIlT9+yykNmSuhdKHls8EJ06lKYJa6j5LEiSHa/OPex0EGpe1u8CZgd1grpuNNAPFPL6v4Id6A3lOjhJFoo3PWWtwlK/LjQkJsvP9apddSjlAPro4amIsf8IJUGPP9+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612664; c=relaxed/simple;
	bh=Ykk5j54CrXF8Gc0MNwakndBqctWdj6NqiHrpMavfno8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8TFiXj4xZFY+ifbK1peA65gKlkPHRooPw0IkFqQ+uH+s4aZdOythRpAgN/rxHGkBxJgoCzA58nQmtDf9wRT+HKlCk4UclVab6YTB+3wi2lJWBeS5Vp1mepASgRUUlxorAXEAVbv7oGnMdNg1DOqRalfz3/L/h2apDIErHpQzow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOPpP3K4; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso687959276.1;
        Thu, 28 Mar 2024 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612662; x=1712217462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+F6qq90RMnVCx2dPk6+bOFn/UT39BJkerD8BiiuXch8=;
        b=KOPpP3K4GzYsywSeMRfOs7/QbBiqOLQSOpJ1KPZt3Eg+t6oJ8+prYd6ERUwa5+ylOs
         HEPY4iUyfpSH4NI3CYFD9v4jn/gBFDLvw9Li/xUONTi/wXbarT9MZtthqADPJPjWlDQP
         o+Xp8/mcKBfZoUbwiiQhEGzsbnW0iGoCFBaY1x16DeV7QKOHfPITdA3tqPlFfgu/SghJ
         f0C5wVGCaJj3rjxafv2KVXq+znXF+o65l2uh9KMo2QjKINMxWczXvM49lsbHm4JGkAUd
         k1LRhsaO1gvY5SOFkGJSHJpvNBxCSFyQt6ysTSFd9q5eiqT+5L4THuMFir7NNd3CO9bK
         bI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612662; x=1712217462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F6qq90RMnVCx2dPk6+bOFn/UT39BJkerD8BiiuXch8=;
        b=OBIuw3EoIgyAXykwpFiCNXnaClJ6bipNLQUg8oalKqSBWfPwQ3TWkSWgCAuwAlgOkU
         NkZOU9ShcbXqJRDPRVNf9Yh/M05MldC7gvUXCAlii+yE0+olTJvJC0jM5r50KGvuafUW
         yuNySUpoJ+ejMCCxxP/NEgRGI1g4/Ij8n/E6i80NqOkNf8wB/J6XGTkPNhFzirMb74M8
         9AMvMPWoWzj6dZYPNe22D1I+zYn1kkHGm4DIML5t6ZjViyXsT3iTZodr9PMcy01lXf98
         jYmTEVP7D4nmxP4t44nNaYKxQ3bMVPj5/1nEri4/ZaMrP3YyP4HEPQH6uXLYlmo+F1v0
         dDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfleEz8vOQN7kszfxF4zbtJ7FnVJVvrHo/yJgyYBwORIMlXBUqm7Pl4BKD777cNXb35ZljAeFLbI2SM53y2MArIj363w+neQ+o3VjqdfW9BvIGq7XPfm8SqOrMlxD9DwBnBoiDqMAU70KHRF8M/AMr37Za
X-Gm-Message-State: AOJu0YzGyYqXB4Ej/Y3IxUZj0BpQ2CCU3EcbErmw2WVLUk6Y+wBR4c6V
	p3u5qmbT8Uy4rAfurv1t+8cEvsOpFBStGI6vn2kVaNAkBN7TiwJg
X-Google-Smtp-Source: AGHT+IGiBRtSJtDnu6UbHS1g8MHEybRdjuAtJdLHL0ZTChFAdRKh04+ivgfCmx+b6fiHJMztR/jELQ==
X-Received: by 2002:a25:c381:0:b0:dc7:483d:5903 with SMTP id t123-20020a25c381000000b00dc7483d5903mr2103362ybf.17.1711612661964;
        Thu, 28 Mar 2024 00:57:41 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id q24-20020a656858000000b005f077dce0f6sm644922pgt.31.2024.03.28.00.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:57:41 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:27:36 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <ZgUi8G3q0DvtcIQH@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2024032836-grief-parish-88e7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032836-grief-parish-88e7@gregkh>

On Thu, Mar 28, 2024 at 07:08:04AM +0100, Greg KH wrote:
> On Thu, Mar 28, 2024 at 04:55:57AM +0530, Ayush Tiwari wrote:
> > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > struct landlock_object and update the related dependencies.
> 
> This says what you do, but not why you want to do any of this.  Why is
> this change needed?  What benifit does it bring?
> 
> And why did you cc: the staging mailing list?
> 
> thanks,
> 
> greg k-h
Hello Greg,
Apologies for the errors. I will resend the patch with reason also for
the changes I made. Earlier I didn't mention as I thought this patch is
regarding an Issue from the Issues List. But will keep this in mind from
now. Also, apologies for CC the staging mailing lists. I won't include
it from next time if it's not needed. Thanks.

