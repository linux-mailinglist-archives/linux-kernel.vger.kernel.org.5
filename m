Return-Path: <linux-kernel+bounces-102590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3487B452
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB562B21DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9F59B6E;
	Wed, 13 Mar 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCo3Zjb3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDA273DC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368797; cv=none; b=Rcv3eJanti+9r5rdEB6TmSooeWqAUMt8oJfWcQwaUFu5jz01HvsPhG2HojvWJFC11ykqbCrZ9yosWIHESMwgd+ariNEMkjgck/1grgf8tr1LQRxCFqstiSLF4xi87syJxoheFydFRm+VQILWMgZmmMGcjRK9/2ssRe6K/9P8y7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368797; c=relaxed/simple;
	bh=7t2g8GHVH47753LDXxWWeDsYtFpmH386oBAW9FhlzDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egjBC/UpIQFLtTIlNVW+OCaeU58RK2R1GrF8btujwazHRQQVkOcPlrs89BAaoZQTMFgw9nBLto5d8JzyTUnQ90qwUu3VdYP9CPmc+nVGUKPFt3/KNj+TUuXfG3HT9sAkHagJ+Gz7c54AuRm4EPA8NtPMxbHP8ZW5SWFVkzevFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCo3Zjb3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710368794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmtTd9EKYIV2ElEzvy2se9UCmMxZ4RexG7SoSlWBNsI=;
	b=NCo3Zjb3hV133F0wI1pNWimuKG/tFjBJEWPFzOvblp1lo0oUmsXoqGMXqVdaD1DOzzdBdZ
	K9E7dJD6i6kxpyknw1hGj5vSzWHMf1RCh42eX280j7BVMgh2gFuLTPdk6PPyCXeAUbuWll
	V2TdG0c47aHWVVugZM0oEEGv9VAwh8U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-xLRpWRAdNTCihpW3C6Kpqw-1; Wed, 13 Mar 2024 18:26:31 -0400
X-MC-Unique: xLRpWRAdNTCihpW3C6Kpqw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7830635331bso7130785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710368791; x=1710973591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmtTd9EKYIV2ElEzvy2se9UCmMxZ4RexG7SoSlWBNsI=;
        b=Ec73KC0YkExORmSO5L8vnqBN/2ji35xwuDHauwc8ctOAIU9Yy69KULzmzhySY3CWyw
         icz+jeXxoSeGDxHpYwILc9ugralg4sQHzlR23DOSNJuqfaOrXv9MBlfO8XBzLdw9S78J
         GZGjqhrvnqWblymxz3Gx+WAzVZj+a7Sk/OuG+0XfQfd0Lgbo96bVJQJ/v+Ecx80tESXo
         Sc3sSTxbBvdCaEaxYUm8u9XSBns+BfVur+ptusredWrIQA4ACxRFqO+VWOONfn8f4gUd
         IeyxeCUXpubARoXMkxVaULCPuJ/954pmZzBrqdu3KV2teJDsrdaFYIDW63dq6vwkgVGc
         1Fvw==
X-Forwarded-Encrypted: i=1; AJvYcCVSrsa/FjT76xsdxZS9KG7Bp5KhNOjURxmtXsmErkv//LXyxag5h3NVWCDWUyxxNY+hWo7vrpILg0xBT2Sh1CyGBS2CQU0WGpFnW3ti
X-Gm-Message-State: AOJu0YyquEUVJlNGlvnySoWT9Fejd/+BsKHoEK8Cbgp7CoR1VEarOK0j
	IWwRqBt8Uflpbtgw+3eMHR1yuVOmXAqHLL4yRGp7xPEARZfVt52YDm9UJzEszCIyn8knmD8Jot6
	UJYlUd/HNaQvJI709UNqa09vfPMuUFb9nO0XUhmX44LfEVQIfPCSdh5tkKk3HsQ==
X-Received: by 2002:a05:620a:2408:b0:788:46ef:67ca with SMTP id d8-20020a05620a240800b0078846ef67camr122022qkn.2.1710368791360;
        Wed, 13 Mar 2024 15:26:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJAB4opU4XfRtuc8thUEjP3QE73Fto6VzagJuRR1SueJVLvEA1hO2rdslOY9a4VV9g4yLgSA==
X-Received: by 2002:a05:620a:2408:b0:788:46ef:67ca with SMTP id d8-20020a05620a240800b0078846ef67camr122004qkn.2.1710368790947;
        Wed, 13 Mar 2024 15:26:30 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b007883f2f48absm77221qkh.108.2024.03.13.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:26:30 -0700 (PDT)
Date: Wed, 13 Mar 2024 18:26:28 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH] mm/memory: Fix missing pte marker for !page on pte zaps
Message-ID: <ZfIoFP4lGXW3el8b@x1n>
References: <20240313213107.235067-1-peterx@redhat.com>
 <c04c81bc-dfc1-4dd6-972c-23c2eb8a5d0d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c04c81bc-dfc1-4dd6-972c-23c2eb8a5d0d@redhat.com>

On Wed, Mar 13, 2024 at 11:03:04PM +0100, David Hildenbrand wrote:
> On 13.03.24 22:31, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Commit 0cf18e839f64 of large folio zap work broke uffd-wp.  Now mm's uffd
> > unit test "wp-unpopulated" will trigger this WARN_ON_ONCE().
> 
> Good that I added the WARN_ON_ONCE() :)

To be explict, VM_WARN_ON_ONCE. :) And that's my guess that you didn't hit
it when you posted the series and did the tests, as I know latest distros
like Fedora dropped DEBUG_VM, so maybe you had your base config out of
there (but I normally have it irrelevant of that).

> 
> > 
> > The WARN_ON_ONCE() asserts that an VMA cannot be registered with
> > userfaultfd-wp if it contains a !normal page, but it's actually possible.
> > One example is an anonymous vma, register with uffd-wp, read anything will
> > install a zero page.  Then when zap on it, this should trigger.
> 
> Are you sure? zap_install_uffd_wp_if_needed() contains right at the start:
> 
> 	/* Zap on anonymous always means dropping everything */
> 	if (vma_is_anonymous(vma))
> 		return;

My example is not exactly how the test failed, but should be a simpler
version of it.  To trigger this warning I don't think it requires the zero
page to be wr-protected at all or have any pte marker involved.
UFFDIO_REGISTER should suffice, afaiu (feel free to read the example above
again; there's no mention of ioctl(UFFDIO_WRITEPROTECT)).

> 
> So if that's the case the unit test triggers, I'm confused.
> 
> > 
> > What's more, removing that WARN_ON_ONCE may not be enough either, because
> > we should also not rely on "whether it's a normal page" to decide whether
> > pte marker is needed.  For example, one can register wr-protect over some
> > DAX regions to track writes when UFFD_FEATURE_WP_ASYNC enabled, in which
> > case it can have page==NULL for a devmap but we may want to keep the marker
> > around.
> 
> I thought uffd-wp was limited to specific backends only. But looks like that
> changed with UFFD_FEATURE_WP_ASYNC, I guess?

Correct.  That was also what the new PAGEMAP ioctl relies on.

> 
> 
> Change itself looks, good. Not sure about the anon_vma example above.
> 
> Thanks!
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu


