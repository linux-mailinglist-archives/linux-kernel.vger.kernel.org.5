Return-Path: <linux-kernel+bounces-28610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D6A8300B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D488287F37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BFC2FD;
	Wed, 17 Jan 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK5pX1U7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77171BE4B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477524; cv=none; b=lRsfQROq5xRsavYkZzdsJu1dc/Oa1lPxqVefONcF9yxHYCmvBQcDMMjQW4m4DKdLolzyJn6iSyEyZq2bytqFs9/hEG8O0FQsyTVw0UeJMcon4wzwkK4HA6xKAPVxPCN7YIdoo6JppV6yNpUFP9b91NHtykgSosoAArELevrcG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477524; c=relaxed/simple;
	bh=Shhx/FKoSiVovdNrE+6my8ZiagZjnjMS2WCYpBGzifw=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ImslpsbkxJ1YoIfOzKPHKrQXRIadmY4CO8/CE+/BdTXZGPJyzgq1z1ST/qhCF+zZsCwz/Uf5RCdziInr+1LOYFGHWxS+68Ib1HeqDR3lkXqzyH6IjZbHIHCvUnNd7Y8OMZhYuxDWeHb46gZNLCL76nTa+1JZfWYlBtX/GQOKOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK5pX1U7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705477521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zQRlhXHXvsZ9EW9ID9S6e0YBzlBTE1L+rSpAnIyeWDk=;
	b=dK5pX1U7a8wtL00MRrphVZx9CjecPMqL3HyCRddhMmF0+moDWFHivbY3JeGFt5EU9hxMnr
	VIpAq/hdE0gfTIf8u9t2cosJD3wn8uOV8cUwQlPgvWQMeNkOz6Z1ZQ1OE5UTft3AO3iiuD
	4VOt+ziErtNz93TL7cW53m8csmOGmX0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-F1r4pmLMOOamGkKyAotx1w-1; Wed, 17 Jan 2024 02:45:16 -0500
X-MC-Unique: F1r4pmLMOOamGkKyAotx1w-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d9b050e9a8so13510824b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477515; x=1706082315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQRlhXHXvsZ9EW9ID9S6e0YBzlBTE1L+rSpAnIyeWDk=;
        b=by8h7xcnx+9shj1QDwqkLXNBEH/kKnfep5I8OLH4rsZWyAmh1qFf6MmYQGqnEWvM5a
         bEXqD+O+AM22EgCVQO7wBJ4fFzlze8/oRqoG1vckJKArOh9runO3VSTIPvxSglSN8FBy
         AXyu6UCNNs9ixhs6DIVKxo5Cq05EesWRD10QBOyJLIr50DriIYa77gfDhdALYESnjJ1+
         7WtE68nq3QXhCLiaLlDLA70jTmd1PsvCDguPZxWBcT+J0tI7j8iFcGsVM4fVYlNvhPcP
         QSF5eTtCRlccRDlpqqBMMZ6x6qETHykO4rFnNvEFomqBC0oQ3dozaMivnVeM/0J0kgPj
         /9Zg==
X-Gm-Message-State: AOJu0YwFXEonFoI9EnnFzFtRjbxtIEZ4xJlbJONRAfaHmGlNyeCziRDL
	girnaJRAkVZ+NCBTZ8DIiv0WTzXS8BTzwifZGNjzzdzxtRCVInZGLhWdPUEXr+eoXhajJm3LOmk
	/ZiwxfIlFs609EbKzITS4YtjXDhi9tQzR
X-Received: by 2002:a05:6a00:8c7:b0:6d9:9126:cab5 with SMTP id s7-20020a056a0008c700b006d99126cab5mr11556293pfu.57.1705477515216;
        Tue, 16 Jan 2024 23:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGcH2MWUG40J/v2AJAZDVhtAU4GRwWSH/jgWPbD8wsqM8XRIdzMPaD3wvgm9yUXrndNlaftg==
X-Received: by 2002:a05:6a00:8c7:b0:6d9:9126:cab5 with SMTP id s7-20020a056a0008c700b006d99126cab5mr11556283pfu.57.1705477514814;
        Tue, 16 Jan 2024 23:45:14 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y14-20020a056a00190e00b006d9a0902937sm791572pfi.149.2024.01.16.23.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 23:45:14 -0800 (PST)
Date: Wed, 17 Jan 2024 15:38:13 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ondrej Kozina <okozina@redhat.com>
Cc: kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: Re: [PATCH v2 0/5] Support kdump with LUKS encryption by reusing
 LUKS volume key
Message-ID: <qsioibxdey2cbxkpyv2gjg6a77votsg6ld2jp7ocvbiezaylxt@me3kgvu24vbs>
References: <20240110071522.1308935-1-coxu@redhat.com>
 <1edc32f2-858b-4afa-a883-2632be6d909e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1edc32f2-858b-4afa-a883-2632be6d909e@redhat.com>

On Tue, Jan 16, 2024 at 11:37:10AM +0100, Ondrej Kozina wrote:
>Hi Coiby,

Hi Ondrej,

>
>I've started working on a patchset for systemd utility. I have one 
>question/suggestion:
>
>On 10/01/2024 08:15, Coiby Xu wrote:
>>LUKS is the standard for Linux disk encryption. Many users choose LUKS
>>and in some use cases like Confidential VM it's mandated. With kdump
>>enabled, when the 1st kernel crashes, the system could boot into the
>>kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
>>specified target. Currently, when dumping vmcore to a LUKS
>>encrypted device, there are two problems,
>>
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes; For cloud confidential VMs, depending on the policy the
>>    kdump kernel may not be able to unseal the key with TPM and the
>>    console virtual keyboard is untrusted
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump. Take Fedora example, by default, only 256M is reserved for
>>    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>>    to be reserved for kdump. Note if the memory reserved for kdump can't
>>    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>>    1st kernel.
>>Besides users (at least for Fedora) usually expect kdump to work out of
>>the box i.e. no manual password input is needed. And it doesn't make
>>sense to derivate the key again in kdump kernel which seems to be
>>redundant work.
>>
>>This patch set addresses the above issues by reusing the LUKS volume key
>>in kdump kernel with the help of cryptsetup's new APIs
>>(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
>>this kdump copy of LUKS volume key,
>>
>>  1. After the 1st kernel loads the initramfs during boot, systemd
>>     use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
>>     volume key and then save the volume key to specified keyring
>>     (using the --link-vk-to-keyring API) and the key will expire within
>>     specified time.
>>
>>  2.  A user space tool (kdump initramfs builder) writes the key description to
>>     /sys/kernel/crash_dm_crypt_key to inform the 1st kernel to save a
>>     temporary copy of the volume key while building the kdump initramfs
>
>So this volume key copy cached by systemd utility in 1st kernel does 
>not have to be readable from userspace.
>
>>
>>  3. The kexec_file_load syscall saves the temporary copy of the volume
>>     key to kdump reserved memory and wipe the copy.
>>
>>  4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
>>     initramfs asks the kdump kernel to create a user key using the
>>     key stored in kdump reserved memory by writing the key
>>     description to /sys/kernel/crash_dm_crypt_key. Then the LUKS
>>     encrypted devide is unlocked with libcryptsetup's
>>     --volume-key-keyring API.
>
>Unlike here where it has to readable from uspace so that libcryptsetup 
>can verify the volume key.
>
>Is it correct?
>O.

Oh, my assumed --link-vk-to-keyring only support user key which must be
wrong. So yes, you are absolutely correct that "volume key copy cached
by systemd utility in 1st kernel does not have to be readable from
userspace". Thanks for the suggestion!


-- 
Best regards,
Coiby


