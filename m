Return-Path: <linux-kernel+bounces-45103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1599842BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E73C283D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F2157E77;
	Tue, 30 Jan 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gcywChRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8ED1586D3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639087; cv=none; b=ABaxoTphg7uBlhNymjbluYwABv+mXyZ9R/4UACHt+JlzLIq4ngvO6yYZ7jV73GE8Av0usrrU0V2WG+ZgH5r8Vw+wBdoBuP+U2RzkX3VExCNpbee/V04oVK6ubvBoW2zrFMlM9/LWGUKXOFtsOtJ50Gw2N6mhtAFp161cPiN/rQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639087; c=relaxed/simple;
	bh=YUmfBWFQ6tCEpoMRctNdicF/PTXXo5NEZEPkn6VcDTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvUgU7HXYgHEWthDxzRYD3Xra6yoU++rHkh1vmzi2rHJLhyrLnStfVwe9DH9gtnLTygY/NE/wNu+8BjdS09GfdwfALo9JsereCaxKmBGq5KA45u7MGND8iKUMg3F+0iNiwy5ix+tk2DIq6ky2McK6RR0Ih0vYVLJsgkO8+5Qan4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gcywChRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A5BC43390
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gcywChRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706639082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUmfBWFQ6tCEpoMRctNdicF/PTXXo5NEZEPkn6VcDTI=;
	b=gcywChRk9C9EfkvBCWSeF9jKKanK4DMvWfgFTKboEjcAhVLkjtwZnoG8yNxt7je8xrkq1s
	LgXdgaNglLsN1Daf24pb0dnL7c8WeQIZDXlcZ9RrO6BtNzJXaAw1k0jkB74CkrR9sIOwoD
	S3rOlzguUuWB46PzMh3oFuTI4qtxE98=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e72d9865 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 18:24:42 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6029e069e08so55387927b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:24:41 -0800 (PST)
X-Gm-Message-State: AOJu0YzdH8WLvypa3Z4tO9nwrEXifY8V92zakVF2XYk40kEVa4lR+xQX
	PTspnmSoNmaPh1XI3/wKaGKzrKEd405Tlv2ZWcftbYBObD2DIOQJrLxOBP9F+XM/pigLRe8UeZp
	yBchW/dWYZVKzDkSegMMuoHvmAt0=
X-Google-Smtp-Source: AGHT+IHs1X6GyHofuCm5wWklYUOEkGmQh3S2SxOZMW5eNxNCRUnzVnAuGciDZbV+el+aoBZWnYUODQffo17X7ao8AVE=
X-Received: by 2002:a81:c74d:0:b0:5ff:4e3b:dc89 with SMTP id
 i13-20020a81c74d000000b005ff4e3bdc89mr6687543ywl.11.1706639080294; Tue, 30
 Jan 2024 10:24:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
In-Reply-To: <Zbk6h0ogqeInLa_1@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 19:24:29 +0100
X-Gmail-Original-Message-ID: <CAHmME9rq-_f9C=DMjjYeCXFcMrCooD-AYVZVj2oF8Je7ztGnTw@mail.gmail.com>
Message-ID: <CAHmME9rq-_f9C=DMjjYeCXFcMrCooD-AYVZVj2oF8Je7ztGnTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:06=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> So I'm not convinced we can blindly wave away RDRAND failures as
> guaranteed to mean broken hardware.

Indeed, and now I'm further disturbed by the @intel.com people on the
thread making these claims that are demonstratively false.

