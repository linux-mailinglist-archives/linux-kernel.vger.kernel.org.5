Return-Path: <linux-kernel+bounces-95028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D487485D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCD51C21488
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453DA1CD3D;
	Thu,  7 Mar 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+E1ySXm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD011CBA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794662; cv=none; b=YqpQQePEX+xNN4efnVmmMSco2EPwNoPrjcCmzkTvvH2acBEtLMSKWHo5FfEFECvNTvcF6QlmPF2QewjcREeoJZ44Uo7b5MZv88JDycxzBhiiRnueAV5UFE/fYZrDB7oQPumY/Xbh+6b3rF6lgzK4Flgcr5BvomiONYU9yuLtMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794662; c=relaxed/simple;
	bh=x8eP0o5pZaI9jroRM2oe8B2fByfaYTMaMZG90oE3J8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhHT9Jb9ZRQijtPmbF8Wa1NN+wz9V0ewU+ebMfLz84u8scLHElWGQ7I5xyiUT1qxTVwF6U7iNkC3/ZqWtULlUeP2cvkxEkZkNOt39JAC1jcLhy705iJLELWqg9Ehfn/4oGIReoHmaf2nV31UDamiWroiCGHABFpxihJC09WsuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+E1ySXm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709794660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WahUM+zqL3/MV81SCT1ET9pBkiIjcOfSRMGsDbdTxr8=;
	b=c+E1ySXmiXJ0pHDzh2xITCPm4lhzI5yWYZ5JkYlWuEJsfbGg4dsRO76IJjbv6iC8+1ljkg
	Y5NZLTgUk1RyMLhLv6sROI7lAGzc8bf2OMe46Xf6JtStGJzrcsWkmJof/qCZBN7mFpYDyy
	kR/NtWUeD0m0rOQlYqpYh5XEvSJ6gLA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-QgA5RYt2Mj2GhRtzeEkwbQ-1; Thu, 07 Mar 2024 01:57:38 -0500
X-MC-Unique: QgA5RYt2Mj2GhRtzeEkwbQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e5ef8a99c3so677359b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 22:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794657; x=1710399457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WahUM+zqL3/MV81SCT1ET9pBkiIjcOfSRMGsDbdTxr8=;
        b=WYw73DE4+tHjtKVIiKdN/ScrgfLb7pSB+CzSig9uvqL+h944MFSRMq6D30amwWXzJp
         6rMRHP6vW5HJBopGeHAPuH5WwQLxWQJG1ZPmPpZaaEZVqguoFmUKVsUjDYiGnxPpjQIE
         WATYBn7OPVg1v+M/NUPiaFRQLe4W/abChdBUQFDSGvhMJ1+ILSs12CbgtmzEjdArwv+G
         Bm4vfEMP/WxOTwBF7Bqsq4MS8PkKRh2wF+PEI/wpwBcbsNpxxSsDt/xS9oaYuPPYrTxQ
         nV2z8b9HSUiDg+SJOLpj0jsM724z+1XScXxBhEu7Gr9+NSm05Jm9B6T7C2D3AS8bWnpK
         UV7w==
X-Forwarded-Encrypted: i=1; AJvYcCVIT/n0r97iXhzVHWFcngFPwnsEMqRckwD6cZhDEaGO84ZbJddhIJdvDbgwr27+sfdr4a2nyeDNvNcS8McLB7IFFkeyuUGFYmgVBD+q
X-Gm-Message-State: AOJu0YzcQFyziZn3LjyUAP05lBSI5gOmFT88KKotC6GQPNjE/IT5qyQ5
	luLfQIixoc+8Zwyj/cZ1DfnadGZJQBFf4uy1HFlxu5XxtRL2u1EJJuUAaAzKLpJKoM+NJ5ur8HR
	EwKTlgf/olVmDE9jfqPHeXsqIBGOHge++KyjBacZEYfyJz7i0dgTXKeiQY19z/w==
X-Received: by 2002:a05:6a00:4f8f:b0:6e6:5370:3195 with SMTP id ld15-20020a056a004f8f00b006e653703195mr3240570pfb.33.1709794657474;
        Wed, 06 Mar 2024 22:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE70QkKb4MS4CFQ6y/fKKac0Ls4UH2IM2U09gwVVV4yDxTwO+I27Y1R/Dw4n/JTb1WZMwcj8w==
X-Received: by 2002:a05:6a00:4f8f:b0:6e6:5370:3195 with SMTP id ld15-20020a056a004f8f00b006e653703195mr3240548pfb.33.1709794657163;
        Wed, 06 Mar 2024 22:57:37 -0800 (PST)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o26-20020a056a001b5a00b006e4766d31bcsm11864528pfv.184.2024.03.06.22.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 22:57:36 -0800 (PST)
Date: Thu, 7 Mar 2024 14:57:27 +0800
From: Tao Liu <ltao@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/17, CORRECTED] x86/tdx: Add kexec support
Message-ID: <ZellV+unyyx6C+et@localhost.localdomain>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <4iospuc5oxs7vbgm3driasjeyixvgz6yrmym3kzguzngngo7zm@c6ymrw52fn5v>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4iospuc5oxs7vbgm3driasjeyixvgz6yrmym3kzguzngngo7zm@c6ymrw52fn5v>

Hi Kirill,

On Wed, Mar 06, 2024 at 05:02:45PM +0200, Kirill A. Shutemov wrote:
> On Tue, Feb 27, 2024 at 11:24:35PM +0200, Kirill A. Shutemov wrote:
> > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > TDX guest.
> > 
> > The last patch implements CPU offlining according to the approved ACPI
> > spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> > kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> > 2nd kernel with single CPU.
> > 
> > Please review. I would be glad for any feedback.
> 
> Thomas, Ingo, Borislav, Dave,
> 
> Any feedback?
> 
> Is there anything else I can do to get the patchset moving?
> 
I tested the patchset with Linux 6.8-rc6, no problem found. With the
patchset, a vmcore can be generated successfully in tdx VM and can be
analyzed by crash utility.

Tested-by: Tao Liu <ltao@redhat.com>

Thanks,
Tao Liu

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov


