Return-Path: <linux-kernel+bounces-157875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2C8B17E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAF41C22ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58917F0;
	Thu, 25 Apr 2024 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8iV3JsO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E73629
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714004143; cv=none; b=jZT6wVjCHZPNgk+5zDuE0Kn95Zmh/cb09kpPalq61+5RwcBrFawgAbAQUQUPRnd0Pv4N5ebTjZP6KAPmFzN7/rtuKsPxTqLjW4sbNOmC21QDItIQAtS9yrJbC1v7Ud5G17ZyoQ/Md+wrYKwYh1biW2AYtzIQ+1k2LoorWq1PqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714004143; c=relaxed/simple;
	bh=AoCc2xRVw+eeSuN5RnnkMfbAOu6Mq8awkjYkscN3FUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OuVIwZwvVT1kYGEKWzRzMN48n9XEsSJiysm0OCkkoHAdOWyt9pBE/xR7CP/eYL0qW0ATzua4V3hl1UQRP10ILpXX+U65irdAQ2d631VfBRW9qm7BBe08qL5NxMTRnn8BmYRQeq80w1KQ4A/JTGTrNCZIfrvYiD3N1TUBhF/lCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8iV3JsO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dcab65d604so457321a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714004142; x=1714608942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=phUjQDDq8M6U9JQBTiJHu0B69Sr2zO6j83b67DrRLu8=;
        b=b8iV3JsOo0klDrNZU5qb1QgovGMlzIQB5Q8uilkHT4W+TvluZxT+EsFReE0eqVhg1i
         BjARfdm4YXnzw77zvf7gvEnLuBZLGKr6XxyPM62sjjHmeRGo+5ywBeRw7My8TiLsUxnV
         VtA2Qki3Pkr390x9ByLdtVmugiyVsi6H4zZtBCeCiMr1KJ8/3azIDRHJM/I8MdTUSadV
         K6QpXXedlohXH/8Dstxq4/BHgNLST/iPdl7kP6njogguXiTntEtJI7gDelEZYzpoxu6T
         KjY/GLTkZIRG+LSfHeSoChu6oFr+XIkQUll7XWXzQJbUKpWSTa7GwJM6tVza5Vd63E8h
         IaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714004142; x=1714608942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phUjQDDq8M6U9JQBTiJHu0B69Sr2zO6j83b67DrRLu8=;
        b=I0FHmQSxCtTzqsuDqWMVjL7GA++9FIO0ST8D+0R+PFpMSEkacHOXE6l4ID4gkNx3iF
         Eg6jOUX2H8SGDXsRq+okp46VhQgfNpvksjWL37EU7UL/EPpdh9P5opSUTaOM2eHHPht0
         1HTBfnlOZKhRWwyxffrSe689CVLXjY/EFTRwBcvCGh42pjvPEEk1fz4OXBtSO85xiaIo
         p5SSbsE6G6AmMgRbZG7utyZlBvzAj7vMNNVYJ2+CTzmOa6C4kFUjWTYb8lx5islB5utm
         31Nk1T3O4SGk/rSs3Blwp8P6GlcEF8qTRoR89F4WNXPuTlaNHYXeCfO2hpienoRQkMDX
         NP7w==
X-Forwarded-Encrypted: i=1; AJvYcCV1SF5LFpt3ChlhnSSa9mNLv22cvEfmVqQVmRuwIGeAYXpfVMD8VvSdWqbHzcE2hbPmi51fmqhBHwHGmU5IMgu6hzC6Tz0uijRZiMY/
X-Gm-Message-State: AOJu0Yyoiuzbq0DJsJ8HucUChBR812CDd+o7c58pB78BJCINXuqJ8DCl
	KirmLNj4zl59NVYwT6sUaA4UxMDkgyxTMKbaYGVws57BWeBVLRjMdvJPC6Jp8NAs8O9AEeNIdXU
	9yw==
X-Google-Smtp-Source: AGHT+IFpMCiw3G/yjKQSya55GEaNi7BT0tDLkwsfoAUywNRODVW0WdG85voz0VSIDV0w8EcxGv/B7fSOJOw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:674d:0:b0:5cd:9ea4:c99 with SMTP id
 c13-20020a65674d000000b005cd9ea40c99mr16727pgu.6.1714004141606; Wed, 24 Apr
 2024 17:15:41 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:15:40 -0700
In-Reply-To: <20240421180122.1650812-22-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240421180122.1650812-1-michael.roth@amd.com> <20240421180122.1650812-22-michael.roth@amd.com>
Message-ID: <ZimgrDQ_j2QTM6s5@google.com>
Subject: Re: [PATCH v14 21/22] crypto: ccp: Add the SNP_{PAUSE,RESUME}_ATTESTATION
 commands
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Apr 21, 2024, Michael Roth wrote:
> These commands can be used to pause servicing of guest attestation
> requests. This useful when updating the reported TCB or signing key with
> commands such as SNP_SET_CONFIG/SNP_COMMIT/SNP_VLEK_LOAD, since they may
> in turn require updates to userspace-supplied certificates, and if an
> attestation request happens to be in-flight at the time those updates
> are occurring there is potential for a guest to receive a certificate
> blob that is out of sync with the effective signing key for the
> attestation report.
> 
> These interfaces also provide some versatility with how similar
> firmware/certificate update activities can be handled in the future.

Wait, IIUC, this is using the kernel to get two userspace components to not
stomp over each other.   Why is this the kernel's problem to solve?

