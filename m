Return-Path: <linux-kernel+bounces-56636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6684CD08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9394C1C21CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEDD7E777;
	Wed,  7 Feb 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0ZEToLx"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A97D3E6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316933; cv=none; b=l4oXOkcHcrg2SiAO7IR5pr176NuSVeVyLbVDbM8vYqvkJa+s3/3+cKG92WZwF/OAbFNVBFinQVyU3oq68ltGziL8MXF9PpWkdM8oYRsDja5/p9xMQFTW+EIFVtz+fcMY7hk5C1hUQI1sfinrBCfbGZYnVqYrxaeC0wRe93TOfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316933; c=relaxed/simple;
	bh=3Cv8/QhBIpD74slYSSoo4vxVIJLl/J4xx5zC5DQgKTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZRxI6CHhPo1XkbhpBc+F/HYrQhb/JkdabPStCeSNJtAC9AUok1/4GzB6WrgqpOA7wZVIkh5YOOvx3jdDME8nwX5pXVZ5PpzirYQxAhTQ3GM6P4D+6Un9D/BpNOh1Cmt9N1eUbWyw8o5Q8ccy0ZnsPYcHHnsz7xNUDygH5kuO1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0ZEToLx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso494694a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316931; x=1707921731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+knB1ngdSyKARG/doZP96ZXvsPHGkqMevFJ+aYaZPk=;
        b=f0ZEToLxMs5TDBDkMEF2LePt9f4ymD9ISzVGM1Ft+/s6mrYclpP04f6PklXj3OTx3H
         wcR+ulr1eIOKWmu3p7Tz5NKfbQqfO1OkP0FjXxVvHLXdkyL3zSquUkDAevegBQYzZwmM
         Iov5KqUInUM7fdr8mHwf2BIAqTCYKAISl+gMTwtyPePd8urAmsgvR532GN4YwS6Ao92a
         MAtUqdoj3LfnnaOQq+1vojACoTQJnhZJcGY9HndsFEBK0l8zd+JxX6qZS6t4DJPjFB7k
         neDSnwGGUyb7YRutDLt+2HBJfkqcZZaHX/kmfREMAnTDfIcGD94l+50XXaADW5vKeMmp
         lF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316931; x=1707921731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+knB1ngdSyKARG/doZP96ZXvsPHGkqMevFJ+aYaZPk=;
        b=SyzqWMjXEaXVMWJTNRLYw8IdBr25WQC5wUZmnacgGCtR608FlZw+/9WIQ2N88uA0OJ
         ytEIatlKNuilMcg5WJZr+/qLUxR3dfmCHbWDOGg2Hs4tHuFwRMVO8cdC7k8+V1FTSa1c
         HwQZbkAOg6swOrrrbyBZTRVwkSYNrUawoOM6atI4ZIHC///sg+HxC3bHsRI/zgPBXtKk
         cHtFJVAoacK+KlyR7anyh/7QA/EZ1w6KhemL2yO8KvkuoAQi22p8FUCcZfhuCUuDiyJY
         rJn0PDPapdarE3PBeP54He5IYpnuSipNFkFx1OKw3Jdi8MnI4DqSZjdMEXUqTnn6ZLxh
         PQfg==
X-Gm-Message-State: AOJu0YzRjvQIw1nLjfRPw5xM/jXMeoX/trj6h4vlW5CEO1VU7G7i3nAM
	Ji5cI0E+aRs8MS5ZYHv+Kynrjf+r+0vzXximQnfqSy5oAsky6naykhSwnPGl9ylMwo8t72PukaW
	9Sw==
X-Google-Smtp-Source: AGHT+IH2CYj13LOcOTolr6P9fTU40Ga1BYphTzszQJKE8pMlAoy03SGK9b1MwI11mOBq96zOCeNblDSCKiQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:190:b0:5ca:439c:86ac with SMTP id
 bj16-20020a056a02019000b005ca439c86acmr8804pgb.8.1707316931114; Wed, 07 Feb
 2024 06:42:11 -0800 (PST)
Date: Wed, 7 Feb 2024 06:42:09 -0800
In-Reply-To: <20240131233056.10845-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240131233056.10845-1-pbonzini@redhat.com>
Message-ID: <ZcOWwYRUxZmpH304@google.com>
Subject: Re: [PATCH 0/8] KVM: cleanup linux/kvm.h
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 31, 2024, Paolo Bonzini wrote:
> More cleanups of KVM's main header:
> 
> * remove thoroughly obsolete APIs
> 
> * move architecture-dependent stuff to uapi/asm/kvm.h
> 
> * small cleanups to __KVM_HAVE_* symbols

Do you have any thoughts on how/when you're going to apply this?  The kvm.h code
movement is likely going to generate conflicts for any new uAPI, e.g. I know Paul's
Xen series at least conflicts.

A topic branch is probably overkill.  Maybe getting this into kvm/next sooner
than later so that kvm/next can be used as a base will suffice?

