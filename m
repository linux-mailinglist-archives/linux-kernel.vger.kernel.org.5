Return-Path: <linux-kernel+bounces-71617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3402285A7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5051F24BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4603C49E;
	Mon, 19 Feb 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iHY6Oex"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BE3C082
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357888; cv=none; b=I929k7sBF4Tta2dygrHp8qdtp7d4O7lwmfpNG1ZByL8IC1pF27wL+GJBIPLGt1EYdWgGlUpEy55tcmh93XFpanOCkegQ5RQArjyDJSabaylIwztvzP8N8YOiINYiD1vPq4XVJ4H2U3ibFb4bhApr/26Cj5SOhlbD1SNxMU9wtEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357888; c=relaxed/simple;
	bh=YROZrjdq3gYQCAeXMRavVSWhGIfjVKco/8EJ0nQwWjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYpZue5vcAjiuPMr16QFP3SKnP/eYc4Fq67+r1kzVKM5A1yVEQDgB2Xj6UwACjc7hsM42VCxx4zcjpKS4EO9B1h+J1vO7sacaVf80ip3l39OjjTnUJktbHeZERM6IHeQboFwxhYsXLkelTLtUxiQnMZfJgtGSGcOt6ei6WdnbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iHY6Oex; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso6515013276.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708357886; x=1708962686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g37j1FtPF8B2B6ahbdjOo4C4cedCCq5D/gQif5NDL0M=;
        b=0iHY6OexxSF1ZaZ6jqNaL0QyczVhARwrhhpqwrbHzrq3S/dJnAldeOhBMa1CjE4ybp
         m5p4wajY3UPQyGhGEZe3j10fN+zbXfRMmOvpfV2+/32Kav3bntgMpapZMCMPwEZCBM1T
         AGJdfiHEWFSXXk+Fx58AjCZtSRT0vyDY5ShZKoNDVlACwu+vVz2lknV9On4JyXJDgyKe
         yVa19KbLy0FMy3EamvIs/uIf9nCk/dy3oCZInJFH5WJ/5XuTm1RYYYDYfB7V2SqUCENS
         VNveEGcFzsSdMOqIMxce0lgvcxREVDn0e6GvGl6CVdz896aNUyw45d1MsEg5g2bb3h2O
         je5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708357886; x=1708962686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g37j1FtPF8B2B6ahbdjOo4C4cedCCq5D/gQif5NDL0M=;
        b=g5P+4RxhZ+iSTcKCuAQOYMwwi53ZtHlVx6LT/p9ybvUuC8eDqhO3GzlNkvC8yQTPvR
         KOINQ61nKWuN0XEu3KaTqBHAv6HWg2FLhcpp+O4qnyr6WMjKOoqFwXgU/Pgu6lp3HE5B
         V+/QMxjIsIcG7rwPy2hMdSG8NsAKe+4G3x491nXuBwCF2jML8lk0t2oZ0OQ0Z+tIG2D6
         93hjKhboHqEEkzfmeTHP5OlUvTWzQB/q/ls2iBjonRNawUeYyPEWzwjueT+pwFoiHL8z
         0dsP6cTBUc5GGdiNg+5O5hHxc/PuIGBSkOTdg4fnueq4hg0aFTZVGMkZQ0wbWF02/c61
         xxSg==
X-Forwarded-Encrypted: i=1; AJvYcCVXMb7Jaft+imYmMXJmgz/KAKGIdjGf0GuQ6EWFztKcOcAYhQ013KMTW9dDtu1JiE2cJ9cn6NWr6QqkEWLKdhw7aNpGvVX//ZIxEB4t
X-Gm-Message-State: AOJu0Yz5FX6jEl+sWvqVC7RKSacWbw/sO8bdbHnei7lRQcikkhWfeAna
	uQPFvBeBZgMo+WXoRMvyCWd7wZh+fLwY9AiDqtI7e5kUPgyKdIHw5LocfUF8WBtTSiTi3o2FYOG
	Keg==
X-Google-Smtp-Source: AGHT+IG3bnNo3degTA8nAtDyn4Jeq+yh4DrP36yNtEvgicB6u/1+JruJbPCIsrQ+aNqsLML+HG1SPuwVZpU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:a8e:b0:dc7:6cfa:dc59 with SMTP id
 cd14-20020a0569020a8e00b00dc76cfadc59mr427758ybb.4.1708357885861; Mon, 19 Feb
 2024 07:51:25 -0800 (PST)
Date: Mon, 19 Feb 2024 07:51:24 -0800
In-Reply-To: <ZdNerMaewrcrwBlL@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110011533.503302-1-seanjc@google.com> <20240110011533.503302-2-seanjc@google.com>
 <ZdNerMaewrcrwBlL@yilunxu-OptiPlex-7050>
Message-ID: <ZdN4_ENRMqeBIBkn@google.com>
Subject: Re: [PATCH 1/4] KVM: Always flush async #PF workqueue when vCPU is
 being destroyed
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 19, 2024, Xu Yilun wrote:
> >  void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
> > @@ -114,7 +132,6 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
> >  #else
> >  		if (cancel_work_sync(&work->work)) {
> >  			mmput(work->mm);
> > -			kvm_put_kvm(vcpu->kvm); /* == work->vcpu->kvm */
> >  			kmem_cache_free(async_pf_cache, work);
> >  		}
> >  #endif
> > @@ -126,7 +143,18 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
> >  			list_first_entry(&vcpu->async_pf.done,
> >  					 typeof(*work), link);
> >  		list_del(&work->link);
> > -		kmem_cache_free(async_pf_cache, work);
> > +
> > +		spin_unlock(&vcpu->async_pf.lock);
> > +
> > +		/*
> > +		 * The async #PF is "done", but KVM must wait for the work item
> > +		 * itself, i.e. async_pf_execute(), to run to completion.  If
> > +		 * KVM is a module, KVM must ensure *no* code owned by the KVM
> > +		 * (the module) can be run after the last call to module_put(),
> > +		 * i.e. after the last reference to the last vCPU's file is put.
> > +		 */
> > +		kvm_flush_and_free_async_pf_work(work);
> 
> I have a new concern when I re-visit this patchset.
> 
> Form kvm_check_async_pf_completion(), I see async_pf.queue is always a
> superset of async_pf.done (except wake-all work, which is not within
> concern).  And done work would be skipped from sync (cancel_work_sync()) by:
> 
>                 if (!work->vcpu)
>                         continue;
> 
> But now with this patch we also sync done works, how about we just sync all
> queued work instead.

Hmm, IIUC, I think we can simply revert commit 22583f0d9c85 ("KVM: async_pf: avoid
recursive flushing of work items").

