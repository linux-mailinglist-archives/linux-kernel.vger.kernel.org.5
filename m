Return-Path: <linux-kernel+bounces-157633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E18B13DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F2287B44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2CC13BC29;
	Wed, 24 Apr 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdlI8AQz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D17443E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988667; cv=none; b=gcivP74/VzzDDdheCBn1QSN6VI6mGLEELf/H8ASCtrwkQz//q2hwCecCnBFC/vZyHWWhADJ1ps/Ir1FHsH+aQX7xtGY2m6eDNR6uPwQJdt3+dTg4jNBeZUV0kKWYOtUfKYRRgJ5ZCFQ7E9q6FfFppSpgjgR+N8CgrfzcNJlfpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988667; c=relaxed/simple;
	bh=Ezf8HcOmGibT6Ls3EvM1xGDK2E4Z50zZWeh+sz0kp6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rjo+a26Pl7E0kyb1U0ef0leoJnVOaFBh43WehKH+p8P2msvFCZry/DA2zUDg3gcqjlzCTWeaFiPEi2nngGIl4h+xUc4hghiWYjfGGGC2Wb6RY04qAJ2pEsIpO3O/7O30avPjWTzA6sy23y5dqj/Ju96CUzreIRr9rdBlD5DHXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdlI8AQz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso478433276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713988665; x=1714593465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FjCbTQKQdYpMLda6Jiyq7iBjTjuhXyZh4wh3ChdsfU=;
        b=xdlI8AQzarmXF9PJauLE+TL7w4k0wKS9mfgmykURAMH1UC4r4weXICM4V97W52O0sy
         /4bWrkS2gBeji58c/J721ZeJ4tswHyQSDJtlx8vIgtXt0ri0dJ3R6TdP1XWVF+EoEOFf
         313G6j50kWugLmN6ICsPH4Qb5Ybgf4MJTXoQDeurtHZo79U0Bul8Q2exvU0p/g2iHh5z
         VEzykE1/4alSzVvsCxFtVeHJ4V6gsKddofdM73SqWuNiR+cSQACfwT7o8QSwnWhNVhhr
         CK7QjCtsXYLMwZdXEGIW0X6FGCzrDt8patxBxOPvr74HEojphv1MWJeRR+R8WaEY6+DV
         Hphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713988665; x=1714593465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FjCbTQKQdYpMLda6Jiyq7iBjTjuhXyZh4wh3ChdsfU=;
        b=kYBAmROiqtidUA0mhVGei7FobWE07anpjKXkui3+INvvZP+PtdmEGNfWA0ThhkZxAw
         srOFjhXVOnR6+RLEYTVuHIfaJiKmdeoHjJp2oDORqnUYSi8xDwOJlTFazlgncsC9Q3ZB
         HfCsbqOx0q25pn7a3DZsc4MwJZERjuDTyRLiGg9NvtyMqiEuaHr/PI9B6U2Doabo+cxz
         SzRGzbLLgFsjRbGVYiuDY9wfF4dQUDv2OmOO9iOHwPfcK1MVTmnhLu++CpnYCpO1TxWH
         AHuT0HnSHoQ/SVdBEigkFimZmacbnEPWoHtqubwgfPQMhh2biuZL2RGd4KGuFDwkMaAW
         pa7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1emrhVJWWbz1WHdEWk1LmOET3r4V/2BILfIAUOa29MOScYtQt2KGFYwxFTfwM4p6rdvBdTutQfQnIww6hjzYNY2Qwsj7ZbN17sou8
X-Gm-Message-State: AOJu0YyVwGOC+9bvKtd4W/yzh3p1b+FW8Gc6ADnMAA0O2iovmyGMJKTm
	qqGJnWJtrtkzdEJBAxSKPTDzhR0nggEwdckQVHAbSLmYBcpfgl5SBna48xODr2Z8+sMZglC5Y0p
	YkQ==
X-Google-Smtp-Source: AGHT+IHoeI+J4/hNST2TgTwDm1q0K7qJ4IBd7czAr+qCHxvrmSquvkLDEnz4XoEATY2E4+JArBcZjoc1+l8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ce81:0:b0:de5:5304:3206 with SMTP id
 x123-20020a25ce81000000b00de553043206mr373600ybe.11.1713988664900; Wed, 24
 Apr 2024 12:57:44 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:57:43 -0700
In-Reply-To: <6f476d85cdb9dfdc0893e9eb762dca08f0f5f19b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1711035400.git.reinette.chatre@intel.com>
 <6fae9b07de98d7f56b903031be4490490042ff90.camel@intel.com>
 <Ziku9m_1hQhJgm_m@google.com> <26073e608fc450c6c0dcfe1f5cb1590f14c71e96.camel@intel.com>
 <ZilAEhUS-mmgjBK8@google.com> <6f476d85cdb9dfdc0893e9eb762dca08f0f5f19b.camel@intel.com>
Message-ID: <ZilaWM4AmrbeSEy0@google.com>
Subject: Re: [PATCH V4 0/4] KVM: x86: Make bus clock frequency for vAPIC timer configurable
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "jmattson@google.com" <jmattson@google.com>, Chao Gao <chao.gao@intel.com>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, Vishal Annapurve <vannapurve@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Erdem Aktas <erdemaktas@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 24, 2024, Rick P Edgecombe wrote:
> Long term though, I have been wondering about how to prevent TDX regressions
> especially on the MMU pieces. It is one thing to have the TDX setups available
> for maintainers, but most normal developers will likely not have access to TDX
> HW for a bit. Just a problem without a solution.

I wouldn't worry too much about hardware availability.  As you said, it's not
a problem we can really solve, and we already have to be concious of the fact
that not all developers have comparable hardware.  E.g. most people don't have
a 4-sock, multi-hundred CPU system with TiBs of RAM.  Not being able to test at
all is obviously a little different, but it's not entirely new.

Instead, I would encourage spending time and effort (after things have settled
down patch wise) to build out selftests.   I tried to run a "real" SEV-ES VM
and gave up because I needed the "right" OVMF build, blah blah blah.  At some
point I'll probably bite the bullet and get a "full" CoCo setup working, but it's
not exactly at the top of my todo list, in no small part because the triage and
debug experience when things go wrong is miles and miles better in selftests.

