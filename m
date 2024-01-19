Return-Path: <linux-kernel+bounces-31422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAEE832E20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E51287CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5D55E64;
	Fri, 19 Jan 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quGWsSGd"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5D55E50
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685244; cv=none; b=Ii8zpL/Feevpr/iTqpTf6YusTJoSIuKJJ7yLLpLw9wQhTXpRX5vgTvk9DOem9uCO0Py/WchtbSj5gZesX5eIiNDcEr567U60+IR/jHQixr8FvIywJaSR8AhHnjfsl7J+w4V8YHoMi5WlHoFiKItTN4vQ8jNiMuQCoFEDusT88o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685244; c=relaxed/simple;
	bh=hQAkoZXDTSlJOPauCujJoN2NrBGM5OoV2NNA7O0qjTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs2zQ+LpPE0GxmzVLX5EKjnL1xJBz+XSndfOCAZWY1Zxx90d34q1qMM0XeBmbcZlM9go7eP7EJVdPEYPpHjNN18NwEIvKdrqbyaJuL5ffkG+b67muYGkv0EPB4H9+4iUW1GZV6nSUCU8g0mNfYI0oQwqkcBOhtRtpCgQ4kQiV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quGWsSGd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6db599d5cb8so1009937b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705685242; x=1706290042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7a9skkOJDoeDAzXAlrhaoQRm2nSLoLLiCg9+PzsFlc=;
        b=quGWsSGdOEtcTU9ih2drDjVvCefQO4cs7BSRcO4Es0flrcpXliW1PexXT+RbsXAYEF
         p2Epbf3X7YseqN8BVVE9nWp55HO44LKdPh1UnVrk72dvv9JHoCxPm7PwahZLLKvbEQMl
         186aMJYA/K2dhm8KXAe3K2m3BuPATWBn5eC0mLCqVVGNLGFeCpqMxpeiyJGbHoG41CqS
         u8j2fGGL4z1RBR2KqICyfEBKy2jN6jzbPDsjjJsxUfKinWrY5vfLE6pmn3JIlCa9awjN
         A5qlk/LUfiMO89gmfIeAKxFw84J/DsLteTI5jJFc6nZUn+T7seFtUGzYtXTWXp1l2TQ9
         DyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705685242; x=1706290042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7a9skkOJDoeDAzXAlrhaoQRm2nSLoLLiCg9+PzsFlc=;
        b=f4oAFUxztifT0KFS3W3yWGf7pO2YrhQOZPEvAhWZaLbNZNAarWcwEqCVo0ofpqmjgm
         p/+N4d5mC9mFoIPPQbLFwxNTp+SmBV9mj3c78SI4p/bNFqp35fOpvfTTu+TPWfQ9Aq60
         gJxa0UEk2HP9o7we0KLoy9Xq2yqvi8VCZt2dJlGSdZ3GURzT426Cw0mSFTkoSb0yAcKo
         okIU5hCrHZtFutzs3vbXZnZTw56pp9SuqP0EYJMGCy+TbVco+JQ5VKdEJ6/prY4VIxnh
         1BG2nBKug4wZZYq4QT/rvr9aqj3O93NlWYwZVpwsaQJZgardp8XVuAzWKICpxJvfjPBA
         J3NA==
X-Gm-Message-State: AOJu0YzYTdyLVLcVBQTkUppy3MOT8UwcKYaAcKTOx+zEuUuaCHdlIV6Y
	ej2Nqs93Lqw6umptEF9SIdY3JYC/KS+x0+nT8ZZXzYG2NX3cDb+HPF5+80tKsw==
X-Google-Smtp-Source: AGHT+IHbPj5dmEcO+DPizzQGXx6W1/gkhwSh7+VkZCpN/lNtDGV1jDgPXi6RNH85CfIegjQ4SZ61pA==
X-Received: by 2002:a05:6a20:e123:b0:19a:e66e:b155 with SMTP id kr35-20020a056a20e12300b0019ae66eb155mr155863pzb.74.1705685242498;
        Fri, 19 Jan 2024 09:27:22 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id i124-20020a62c182000000b006dadc436071sm5574807pfg.36.2024.01.19.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:27:22 -0800 (PST)
Date: Fri, 19 Jan 2024 17:27:18 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/28] binder: fix unused alloc->free_async_space
Message-ID: <Zaqw9k4x7IUh6ys-@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-6-cmllamas@google.com>
 <Zal9HFZcC3rFjogI@google.com>
 <2024011955-quotation-zone-7f20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011955-quotation-zone-7f20@gregkh>

On Fri, Jan 19, 2024 at 06:49:00AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 18, 2024 at 07:33:48PM +0000, Carlos Llamas wrote:
> > On Fri, Dec 01, 2023 at 05:21:34PM +0000, Carlos Llamas wrote:
> > > Each transaction is associated with a 'struct binder_buffer' that stores
> > > the metadata about its buffer area. Since commit 74310e06be4d ("android:
> > > binder: Move buffer out of area shared with user space") this struct is
> > > no longer embedded within the buffer itself but is instead allocated on
> > > the heap to prevent userspace access to this driver-exclusive info.
> > > 
> > > Unfortunately, the space of this struct is still being accounted for in
> > > the total buffer size calculation, specifically for async transactions.
> > > This results in an additional 104 bytes added to every async buffer
> > > request, and this area is never used.
> > > 
> > > This wasted space can be substantial. If we consider the maximum mmap
> > > buffer space of SZ_4M, the driver will reserve half of it for async
> > > transactions, or 0x200000. This area should, in theory, accommodate up
> > > to 262,144 buffers of the minimum 8-byte size. However, after adding
> > > the extra 'sizeof(struct binder_buffer)', the total number of buffers
> > > drops to only 18,724, which is a sad 7.14% of the actual capacity.
> > > 
> > > This patch fixes the buffer size calculation to enable the utilization
> > > of the entire async buffer space. This is expected to reduce the number
> > > of -ENOSPC errors that are seen on the field.
> > > 
> > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > 
> > Sorry, I forgot to Cc: stable@vger.kernel.org.
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Oops, here is the complete info:

Commit ID: c6d05e0762ab276102246d24affd1e116a46aa0c
Subject:   "binder: fix unused alloc->free_async_space"
Reason:    Fixes an incorrect calculation of available space.
Versions:  v4.19+

Note this patch will also have trivial conflicts in v4.19 and v5.4
kernels as commit 261e7818f06e is missing there. Please let me know and
I can send the corresponding patches separately.

Thanks,
--
Carlos Llamas

