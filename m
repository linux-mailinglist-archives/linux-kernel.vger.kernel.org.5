Return-Path: <linux-kernel+bounces-83731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AA0869E68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F17B31E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F24EB32;
	Tue, 27 Feb 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNhJ3hpw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C14E1A0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055015; cv=none; b=saVsyThnzCOBqax5eHmNT+y5GmzWXzHGi3JvekPMVU7xlxx4CRt/+pHk3tjKxBVzel/Adk/dZAG2nH+y4uRvQ+pfsYDfTL0fH3t4NOSpXiAhhjMwXWIMIiTU1kRSchYOQ3t+k18dsf0ycPzlQJcdrPHrMSrQrs0eRJNQMLYC4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055015; c=relaxed/simple;
	bh=8+NKIgDuplqSo1ytFo3UoMuMYGOqUqX9fn9PGu7Vej8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kikCoyBnVg0DSCpdRBtN5uT7yeeTXN5TWC4/pbZi1ghzsndthnoMgndgw/8A7WGgeqq92SEeyga4BpZ18HicAvD29TS7LAuOymsldhC/2VfPlRVtwYj4fxC0pcP6++mfI+knUhI1PgvioD2F1K7/W82xqCETjJxf0vUi4yX1DvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNhJ3hpw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608852fc324so74354337b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709055013; x=1709659813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6AD0bkdjAOp/lWXwKRvybpOt3bz+Spb+REH1Kt9KeA=;
        b=FNhJ3hpw7fBNPBWtilTToL375qv3hSFwWeS8tSzfAHTQWT9SSFIUXeM6bDxLYePEI2
         89K9LYSCcy9IYh7JOCPGPBYoccwpnLGtCuajQwD1c5dUU2ky1HEe8o32D5HRmXrW1ZVP
         QKFVAUMQgWynPAKKQLEy6KABpwosg6Zvd0TjP6zvzsbCP92PVHuhBVU0uNoHdY2DGzH/
         bL7m1svhwkghBcIjd9rfLCd55uANusItwBdMsL25iN9FVNEgu/ul2DZMz7+XrwgRuKlo
         QwURat+xO2TzitBcnUaRtb22mEYeGfT4v2s18Aa2dEp7b2i8faSHPmyAhty2T/EYhSyC
         +Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709055013; x=1709659813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6AD0bkdjAOp/lWXwKRvybpOt3bz+Spb+REH1Kt9KeA=;
        b=nAfHeq1kXgsYFm7wWqKw29y9jYsO4cSf/F+FoM41glhJaXVIoE1dlZAHq351BJJdxy
         mxNeOhzCrTaAdWdOue+Cj5VoX8uP8U8zR6K06DAH0irF7T4S1wPlxvjIua93uZMBK0A2
         DKObc1jMTQwuWexYOI2PeTBJbW5nJnq91MoIl9/Vi4XYkZZlWPNvINVx6R9as7oleuvu
         AYI47+3zkV/5HHfJu+Dn359HbiVOWAul2P8VnC8qjlSp4PsQLmEGtljgiICptnjnXFR/
         kq0oJiF2rSUOf2fXT8Bad60/zeA+B7nYL7r0Xg1Pd1xvEqfXxPd2MEFnkT10Y97ea+Q5
         7hUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3bQTkUkkYisdy8iQ6W58udLHyb2Ryjui7KWO0SeHIpeV8+FIzdnmKuojqOVdt1XNYa8df5lNRoXmfxmsJfFbExAVwro+Zy6RHOTVe
X-Gm-Message-State: AOJu0YxolIeQU19k2k/xyo72Eg4SR/wEn/sHJ/8zgatyIX4j4Fo/MKp9
	sDLbwFvjJgjfTMTPCkeRiKAx+Hbjepr7UtWmc6Vr3Yfbgne5MZdYmF4eVbg1eWwbCDEaq/A7ZON
	5/Q==
X-Google-Smtp-Source: AGHT+IHQl47+M65O9sQwAMBDDVepTiqQ/zh20Xdi+gr8WdMeGRRwBphUz6L7sK8iZPfM7Z8V6cSN6FbvT0U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:7256:0:b0:607:d016:d85c with SMTP id
 n83-20020a817256000000b00607d016d85cmr643698ywc.9.1709055012763; Tue, 27 Feb
 2024 09:30:12 -0800 (PST)
Date: Tue, 27 Feb 2024 09:30:11 -0800
In-Reply-To: <20240227141242.GT177224@ls.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com>
 <97bb1f2996d8a7b828cd9e3309380d1a86ca681b.1705965635.git.isaku.yamahata@intel.com>
 <Zbrj5WKVgMsUFDtb@google.com> <CALzav=diVvCJnJpuKQc7-KeogZw3cTFkzuSWu6PLAHCONJBwhg@mail.gmail.com>
 <20240226180712.GF177224@ls.amr.corp.intel.com> <Zdzdj6zcDqQJcrNx@google.com> <20240227141242.GT177224@ls.amr.corp.intel.com>
Message-ID: <Zd4cIxZPABFlt-sE@google.com>
Subject: Re: [PATCH v18 064/121] KVM: TDX: Create initial guest memory
From: Sean Christopherson <seanjc@google.com>
To: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc: David Matlack <dmatlack@google.com>, isaku.yamahata@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, Sagi Shahar <sagis@google.com>, 
	Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, hang.yuan@intel.com, 
	tina.zhang@intel.com, gkirkpatrick@google.com, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 27, 2024, Isaku Yamahata wrote:
> On Mon, Feb 26, 2024 at 10:50:55AM -0800,
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > Please post an RFC for _just_ this functionality, and follow-up in existing,
> > pre-v19 conversations for anything else that changed between v18 and v19 and might
> > need additional input/discussion.
> 
> Sure, will post it. My plan is as follow for input/discussion
> - Review SEV-SNP patches by Paolo for commonality 
> - RFC patch to KVM_MAP_MEMORY or KVM_FAULTIN_MEMORY
> - RFC patch for uKVM for confidential VM

uKVM?

