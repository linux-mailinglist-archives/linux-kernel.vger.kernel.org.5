Return-Path: <linux-kernel+bounces-84398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034C86A644
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05BF28D3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063BE1CF98;
	Wed, 28 Feb 2024 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1frM7TW2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20C524B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085655; cv=none; b=Jcz2rM5bj2qt1eDL+3aohmdowC6geGo9NklMoz+aXyKrJyGq5lLO0z4Cl6Phcl0REXXDPxdYjoogOM698WwIPVj5ah1sttHtTpqpPn0Z0sJMG5ceqX8g474UgyAQbAXwFt8JY29ft3kg86rzoOHCV0Q3cwIZfunjndWRu88w4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085655; c=relaxed/simple;
	bh=AeGqh4r9dOP1kwfVwX/m+p2YxJI1dCpAzCe7eQkbPOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ketshLUwY3gOweqVrUH7t2p/Y2a6VVR5JZbKNlQ7ha9aKdNY77AImnhFjK13fT57rlVIX2T9UElsG+qoDQotYN2L6gQ+YsI0dblH+TiKstuR+46BUKTK8FS9tplDxgtbG+wM6FSC1elNAOV1bRjkFsU+IAmrt8qhOoDtwvScKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1frM7TW2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e56f7200so45993547b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709085653; x=1709690453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bH08g0YXsvdxlNeOpXzubbkmdDGzJ3RB+XxBRnvGmk=;
        b=1frM7TW2ehsm+Qnlni4Dt2AAzwZc4T4GvSzHzJsI/VN8OL0omLS5WmzAt6mt3OLsIh
         WL8XNIZNmTcq2LTboX+6HNKYdrL196rsWZ5GJbZnm6AcYaX2+GOyIpAxsoac5DvL4G0S
         QZknUrOIvAZGvyfA2Z5p44K2cnKoPqQ2JE0hw53xho3bQUJyeyGHm9GOTLl6LI29YsAA
         TGuyekphR3UQ4DNokdBOMQNC9Kkj1Fd7XISo4K3EEUG8q4vCC0NPNpMOKLxmNlc8DKyg
         TF+hOoe9EJe6BXrXB5efJp96f4wzqnEy3vzNPuJy+z9HUaIptp6NFm62RN3B26lBQeT8
         waNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709085653; x=1709690453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bH08g0YXsvdxlNeOpXzubbkmdDGzJ3RB+XxBRnvGmk=;
        b=FSie1OF4WK1kUgEO+66JgwcbL88MInqLEGFsbxSo7yqijLqP4TpH6P20B0mvItUfSb
         a9rwJhZXHiMIcN+N9yyUGybuMZdWn8TfBQjf1Y8rSb0K7U5n5mb47db0iipxGq19vi3z
         JuQkO5QpE98if1AES112Iv08ObyxBYnydQD8W0HmSQ/EO0wDlyqCGV5gsZZBGmkoCUqJ
         u1Mgi/HYN5sjoadquAZIp0bhUpeXQT09ghYzu4JZ8XVPJUvJ+gIR350ErwAcx/hwnip+
         MoGiUTQYzojIGHuaehWH2jJh0SPwutsPEQZ5d07LFm5eB28DXTBqHzi+sYNYs3qyAjEW
         rU6A==
X-Gm-Message-State: AOJu0Yx8CWjA5hc/BkDUIo5YhcJrLRTAqOEWLqAgNjWycFOdTwaAfWxI
	y0Awxh5vNhv2wegwBocEnspK7BkXdAvA1UikGkiPINpNuRJS7JGYNWI5dWeLmTz1bqsNcJK3gax
	0pg==
X-Google-Smtp-Source: AGHT+IFgN7TYk0XlfuOYPZslMedGVow73Hppqg/OG9s/zwcwi0yZpG4A0sRX4Fk0DaV1/c/nMc+rIkohxu4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:92d7:0:b0:609:3901:f2b4 with SMTP id
 j206-20020a8192d7000000b006093901f2b4mr253754ywg.4.1709085652718; Tue, 27 Feb
 2024 18:00:52 -0800 (PST)
Date: Tue, 27 Feb 2024 18:00:51 -0800
In-Reply-To: <20240227232100.478238-11-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <20240227232100.478238-11-pbonzini@redhat.com>
Message-ID: <Zd6T06Qghvutp8Qw@google.com>
Subject: Re: [PATCH 10/21] KVM: SEV: Use a VMSA physical address variable for
 populating VMCB
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 27, 2024, Paolo Bonzini wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> In preparation to support SEV-SNP AP Creation, use a variable that holds
> the VMSA physical address rather than converting the virtual address.
> This will allow SEV-SNP AP Creation to set the new physical address that
> will be used should the vCPU reset path be taken.

No, this patch belongs in the SNP series.  The hanlding of vmsa_pa is broken
(KVM leaks the page set by the guest; I need to follow-up in the SNP series).
On top of that, I detest duplicat variables, and I don't like that KVM keeps its
original VMSA (kernel allocation) after the guest creates its own.

I can't possibly imagine why this needs to be pulled in early.  There's no way
TDX needs this, and while this patch is _small_, the functional change it leads
to is not.

