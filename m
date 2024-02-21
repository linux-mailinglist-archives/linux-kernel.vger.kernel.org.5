Return-Path: <linux-kernel+bounces-74694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE485D7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160631F21CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723845380D;
	Wed, 21 Feb 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LOz3TSA4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0508535C2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518287; cv=none; b=Xk8BMTa7REqej+I3hTXd2M2clisriaSoE1hvPJkCX6BO11jY1Bv97jvutdKnO2SHib8tQDowAzfDVq9Tvm7WwlnbJL1lHQYpPHpQAGV22LQJCzUfobSV+BTfgS4CL/TUmAzhTOtapHkpkoFtX4VAVe7jJOPh4Y2RTjdOoxgxjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518287; c=relaxed/simple;
	bh=Ly1OljPClTEhYVlaS04JNgtxOhq4z3DM0goo7tKAqGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2Gszr8DwUNZME7wtffRJl4kFbvxdRRjANsRvqR2/KmI4RCRnFI7j0w7nWikBqXl3sqz//DqEYVJiQCWB2f6+HLH6sUJxElHp4wgfmeTtZxESyQrNv+Z6Uh1FS13RTIFoUzjhKEVyrFJJUb9Nr4qjJRr26CaBrAWTLq/Ktf4y6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LOz3TSA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729ABC433F1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LOz3TSA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708518283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly1OljPClTEhYVlaS04JNgtxOhq4z3DM0goo7tKAqGE=;
	b=LOz3TSA4LwFnM1kFAY/Wu4AccqIDweiSBSKb1DhFx8TB7GGrQ0Wj6XNNN1F7+y3pATx7iI
	ce4vI6+0XNekPnMDO5NWUOYYPrbih3ypQSCz3BPefH/rM6pfh+BNNhLCuvHW4jXDyIhKwu
	Fu1cPQfSmpbXeUK6pe9Th5+KRuK92Ec=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fe1aa697 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Wed, 21 Feb 2024 12:24:42 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607f8482b88so49487827b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:24:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgnlkdmnxyLpYalQ40d4vkeYf8Yd5OWbY05is7Zq6vOBWkk8cQdlMYEa/HLBknWvNts3KpWRJgYwVnDoX3uDeCnoaUSFnUyRvHsrPk
X-Gm-Message-State: AOJu0Yzwmtn/sLibyOBbZn41JfDiMaGpSKeUyrK51tXYQHh0bb36DiJg
	ALSnATiH8GQgITf8+9lTYjZiyHPysaRS41/8Yj/WmM3GfN9oAdtoAlAUBH4Fy9wdcU9dRZflX9o
	+GcSORqkhtX3Qt6KqX7aBUD2xHX8=
X-Google-Smtp-Source: AGHT+IGcQVxItvjPz64aHU5TSkaBdXuleuO0dyyXrm9yPdRl8vXTB++OymHOd5YHCLzOZ2wWsiLhI4ACxCC/lZyyvKo=
X-Received: by 2002:a81:98d8:0:b0:604:9167:ccf2 with SMTP id
 p207-20020a8198d8000000b006049167ccf2mr15357940ywg.42.1708518280739; Wed, 21
 Feb 2024 04:24:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214195744.8332-1-Jason@zx2c4.com> <20240214195744.8332-3-Jason@zx2c4.com>
 <DM8PR11MB57501389AE5518CB26E037D7E74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zc4QMAnrMiiCwkmX@zx2c4.com> <DM8PR11MB57503009DDA05C9F0CD683E7E74C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oj_LepJfMJHNxbTL+EBYHsnJUf2Q5WTwDotto4S5LrQg@mail.gmail.com> <DM8PR11MB5750FFAC83A7899DC2A5EBBAE7572@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5750FFAC83A7899DC2A5EBBAE7572@DM8PR11MB5750.namprd11.prod.outlook.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 21 Feb 2024 13:24:29 +0100
X-Gmail-Original-Message-ID: <CAHmME9oSO0AYXf_FW-YXJxFmEkuSni-jRRnby+0acY9czn+YAQ@mail.gmail.com>
Message-ID: <CAHmME9oSO0AYXf_FW-YXJxFmEkuSni-jRRnby+0acY9czn+YAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo systems
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:52=E2=80=AFAM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
> Would you submit the patch or how do we proceed on this?

I need to send in a v3 anyway. So I'll do that, and then you can reply
with your `Reviewed-by: First Last <email>` line and then someone
handling tip@ will hopefully pull it in.

Jason

