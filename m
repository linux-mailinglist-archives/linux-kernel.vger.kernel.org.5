Return-Path: <linux-kernel+bounces-105016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7402D87D7AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7C1F22EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18191C27;
	Sat, 16 Mar 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DhsaRMTY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E91109
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550309; cv=none; b=o7lkQKtf7WeUkIpmdeJnRTlb2jqF9fuCuP9Jqpl0IzKoMHbh0q2CmLUErsXuqXopDozpKk+cJDT4Om1NGXdzz3007cK5pwiW9PAlm3dx0I8qA5fEbEp2ueJLspKPx2x8LPg8qtgyiMce61JYM3Kpm1GHFVVltEgeK/YZ2csvmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550309; c=relaxed/simple;
	bh=veGHBF3H13JsJeE4FDnKI5tpEmZeeZRyQgx+bxMNAi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acaE6kZQz1rKwbBYt4U9fuL39WldlZmAkR3AumAnHRju09GkMaX2xKUeqy9nZsayVnj3RAQlIQYa+GXsfN5qSlnJK4VIal+01lNDXExrNj74zh2gc1Q8Rh86Jg46J0eXPJTqeknqsWcFcpqPRusyCXlovnQdOeyt8XUSMtQJaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DhsaRMTY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so3706656a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710550304; x=1711155104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=krWZ+WRoA2zaA7Cdw3TM52PMtly6Zf/um2GekWUiV7E=;
        b=DhsaRMTYKD6KBFla3XYneZZPu0dalWil4DjkZnfoVdYYdMVmS8ZTqybQi7qReC3Vcg
         4QrSbvc88R6Muy3Z4S6exncnF2j4I5Fn2ksiVY+wQ2QLLaWNEkrbLnLYNToUFSsDFhZ3
         Td43G97+UVvMp7GGkhv9ibc95ZrecoKFRT3PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710550304; x=1711155104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krWZ+WRoA2zaA7Cdw3TM52PMtly6Zf/um2GekWUiV7E=;
        b=uBIrLP7sBY0iD9fXDtMPq6Zrwp1itNoqVNU0j7Qr1fMhy5DVmrkBV0Z+gpiVTeEjD4
         xuJ67nsBfYljNzmLiztPKUtsQjgSciFaXykjfuU8dy0YEx4GSwPDxN6UWJ7AfKytPtsD
         wx5j+Pf8nm+skBRpLDvU3MQg6ZMhphFc/U80oawHTi4b53UaYjkqw6Y0oQXpkgNGNpEe
         YOoo+N7TLeobfHPf/Er2gK8jf6q5mhOEF+BVRzzGRzSgTp4iYOCThfDVoQQ+9bdM0DoY
         mjjog4N7kvUodFyFALepDgkkfop6n53cqyTc7uVXx2kNR/dwOZTvS1H9kZCv3OBEU6oX
         +faQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaYIxxDtdcSTn/Rez3wV3h4bidHNC33GZydKkf+xIbE39Kq9GWoRI74W36c/aCP1w4s2BFBgOdYFDF2g4wQ6jYWvhUFhni581mmSUP
X-Gm-Message-State: AOJu0Yxmhutjglufr4u/7AOJtyHTVfh+OoJPx5LhhaDJlKtOryeRgSQO
	Yv8gbKXSIyPKHVGSx58puiL0hnRMkzq+ElKRItP14WUG49NfyuQ27KTwXi51PO4rraF4i8k757z
	oizIkxQ==
X-Google-Smtp-Source: AGHT+IFb3o0A+TKAGYiuuIgsUUDpbi7rDbta5Vlu+9UGiBxAIhMdnk7exdHLgs9HoxmAqpy++Mv+pQ==
X-Received: by 2002:a17:907:7e89:b0:a46:8c0a:6b91 with SMTP id qb9-20020a1709077e8900b00a468c0a6b91mr2474632ejc.11.1710550303832;
        Fri, 15 Mar 2024 17:51:43 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709065ad900b00a466af74ef2sm2183322ejs.2.2024.03.15.17.51.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:51:42 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a466c85ae5fso123799966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:51:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKmzzvApBGCJOh8Pi26g+fPcvgmAykPCiVA1OG0j9LNLq+Fe7VqJMT9Gtd6urAvWJ6+CL02OT7pyzIo/jdGcWraf5DMdXKGWnb0CiW
X-Received: by 2002:a17:906:eb0a:b0:a46:59c6:2a42 with SMTP id
 mb10-20020a170906eb0a00b00a4659c62a42mr4188815ejb.76.1710550302338; Fri, 15
 Mar 2024 17:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com>
 <20240316002457.3568887-1-oliver.upton@linux.dev>
In-Reply-To: <20240316002457.3568887-1-oliver.upton@linux.dev>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 17:51:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJv-Y1ZXbusknXpQVTx_kWudtORoKQPc+Rh9F944+Rvw@mail.gmail.com>
Message-ID: <CAHk-=wjJv-Y1ZXbusknXpQVTx_kWudtORoKQPc+Rh9F944+Rvw@mail.gmail.com>
Subject: Re: [PATCH] Revert "KVM: arm64: Snapshot all non-zero RES0/RES1
 sysreg fields for later checking"
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 17:25, Oliver Upton <oliver.upton@linux.dev> wrote:
>
> This reverts commits 99101dda29e3186b1356b0dc4dbb835c02c71ac9 and
> b80b701d5a67d07f4df4a21e09cb31f6bc1feeca.

Applied.  Thanks,

          Linus

