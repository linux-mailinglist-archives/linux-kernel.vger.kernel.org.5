Return-Path: <linux-kernel+bounces-93903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F0873698
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADDC1C23650
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87486ACD;
	Wed,  6 Mar 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UFrgzxrL"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56F85C76
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728635; cv=none; b=NGal5ivp3/kpLiLARZVwyoynpT+lW8cWgBFf38VOwpHmj2g/RSZte3+NKQGot4/vothgFTMp33BFXqYJx0u1Cn0vPrpperUmDISKQriC31x3nvfFqQdB5zIArHSHJH0VKHbVn/x3C5VExmyj+Fc1dMK9wKdtcXhG5Qk1qxVowTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728635; c=relaxed/simple;
	bh=2cqPFlsh8Bco+kqxKon0TchX/KllK599k66M4CaX/as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lg7SUANmsPNn23sqo11QC/qdyo5eKszTuUKOnaTxAO87ImfU30dGVvaAJmoB7qjfGSdnU/PCd1yjBtnY5LQVqKuJz87VtHkj85PIJ4NifpM3K/HTGJJkwel3fy/1LM1+MS4XJ5yR57LbaO9aDePadASueegLk0K9Hy3V1WFN2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UFrgzxrL; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21e63b586fcso3774780fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 04:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709728633; x=1710333433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cqPFlsh8Bco+kqxKon0TchX/KllK599k66M4CaX/as=;
        b=UFrgzxrLG3TWZXFOpLxtUDARQtTXUtZFYzwNOvuHswiI4Ovt4B4cHUrsm6ptwdssRr
         FqFqCU9fSEcD+NKRtGz3GXLLAOnnZtrTQaRvnwOJ3iNZLAm0EexTCAJoakK7UVUQIeka
         tm85K0c49Jhb7ghgvguRsbdHd8w+dqzVdWohAaRQQvCwU3ZnkSN671mpwnpKpX4eJ4z1
         LRe5skY2W0Dk9ZFKXIKEGF9D+Vs9nPw8M1ZBixJlaCGmUwFe1fO4wnDYrIKCm7VVTT7b
         GhDqvVrgPlF4oyvnKu3U47/J++zJHUxdUBJJKzstQ3Zy0wXk6H9eksr/FBJlJDzOzgu4
         nYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728633; x=1710333433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cqPFlsh8Bco+kqxKon0TchX/KllK599k66M4CaX/as=;
        b=erLMjSuS04UYZxmZuCrJzo3leGDI19vr4LQkOeWFRdK8KrnF0gF1gxUcNPN+chK756
         I7A6HnM8pRDLHxONV5PwR3qOV8JCHDWbcLmQQlju63WSut57c64CO/fKLsD9ZBA9nHsN
         oW5vNXmiI9fS39KNgoDn+IkF8Uzuz2J5rjpunOboxlDdZD/f+nWZuVjcxprtToSU5Qwt
         jT8twc7HpHZ6bEkjRacF6HaSo8a8LPti4JIWf3m0RzDQvYXLLAOhG4FfqUW7pKjWaZDu
         NcaLGcy76Em/6Pko3fYxX3b2onK8Ca6wsEbfnZ6pt59u+DWDURB0eXjWQhs8aopxfiKq
         H71g==
X-Forwarded-Encrypted: i=1; AJvYcCXPssjJOz6wRoECE6FbvVQG7uM4RMbIu6X9yvWxsIze2F8zfNbxNVZkA8F+Unf380ULFT5VQUk1Z7VnnhdWySnOgxxz3lSc/oi1O3IL
X-Gm-Message-State: AOJu0YxpHBRJzo6fNZBJab6q/jbY4pGvfCNVLRYTc4Q0I93jINfxT42/
	GM1GvX+YRZqAOIhUmVwVdUczS7TLF1kTOWnCwrab6sd0VLjaX2nc/Mhj1bx9J+7t77fNjZ0qbYU
	3jTHSfo5nGu0mgfmzoTFARMm48XAPDtt7KIEqPA==
X-Google-Smtp-Source: AGHT+IE99raarX6q+utNID5LMaWjIBjAFxPBWNfijTCMPlLwR+cdCHTSC7SvbuWgUttE8dJ1rgbsjINE8A+w7wLhOCc=
X-Received: by 2002:a05:6870:63a6:b0:220:be60:b6fd with SMTP id
 t38-20020a05687063a600b00220be60b6fdmr5349995oap.13.1709728633345; Wed, 06
 Mar 2024 04:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <20240306-zippy-magazine-9a4ecfe1758a@wendy> <CAMj1kXG6k5SZDYwdxhoJDiNxUuAqBOqqANUiys4YTCk_HCF5AQ@mail.gmail.com>
In-Reply-To: <CAMj1kXG6k5SZDYwdxhoJDiNxUuAqBOqqANUiys4YTCk_HCF5AQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 20:37:02 +0800
Message-ID: <CAEEQ3wnb7k7CXaZmNHaqCVH7OjY3dX7yn9G+KB7dbuGmm_WB=A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] Revert "riscv/efistub: Ensure
 GP-relative addressing is not used"
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, 
	alexghiti@rivosinc.com, samitolvanen@google.com, bp@alien8.de, 
	xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard, Conor,

On Wed, Mar 6, 2024 at 5:38=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 at 10:03, Conor Dooley <conor.dooley@microchip.com> wr=
ote:
> >
> > On Wed, Mar 06, 2024 at 04:56:20PM +0800, Yunhui Cui wrote:
> > > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >
> > Reverts are commits too. You still need to write commit messages
> > justifying the revert.
> >
>
> Indeed. Also, please revert them in the right [reverse] order so we
> don't inadvertently break bisect.

Okay, I'll update it in v2.

Thanks,
Yunhui

