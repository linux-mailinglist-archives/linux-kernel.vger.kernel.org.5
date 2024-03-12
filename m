Return-Path: <linux-kernel+bounces-100545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A043879965
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE53CB22E94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E4137C27;
	Tue, 12 Mar 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="V9mJH0+g"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C0137C20
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262372; cv=none; b=GPEAdjoRkZeB4EVkqdDiQu7KL7FAJqdVKDFLnd3Y1VD2Qntkfaek9FVUPIrxLebNcIR1/GVkGkzhqxVppGWXpVxxt3va0w+kn4/UaLyv7eHuR1Me5fODKn+DxLWyVJtkE+eQ4OH4uQ9FeUYGU3syYGEGcgglsjCDMP1B4Jgu3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262372; c=relaxed/simple;
	bh=EKTNund896Q9/7ibHAEXjcnAqvPX3/YdgYI3hESvoEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q78ovb1DbqMIuP0TK68ssGJMf836Sm2quSo7S1ppCU2BYcHZ1n8VTqFbNu0ZOjM7Ei7XpLHlkwW9Tqy2+0AOSDRlK2D0xTMrnL8s66fVAaMoeKCB7E0EDVf+HQq9Ywb73I1bQojnGRHfa9woGnJc7cuGKDjLscFifhuAxsknjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=V9mJH0+g; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42f2009e559so407851cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710262370; x=1710867170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlwRFf9ZVc7JGOilPoy0XCRhLdO5P5KXBLK8mdvhOh8=;
        b=V9mJH0+gQUH90zF0BMgh6PcQd5sgQciQBmnupCobdwDNyzJ0fIwJXC3EEnG4qk7HCt
         WBgOBovu+YiI0KcGTidFyioi7lJ2PM+ztdBtulbwe2PmuF9q3Cqc0e7fjk65eiKQoXAK
         94qgYy6CuET6+Ou6Mhsm0l6CnNyRu2fnCeoked22kseHktP2+twpOLInzWaNM6AJpCP4
         3Crr84rFrdNAzAL5toGSoN5OWbJ/J6KXQnmfwZSVtjOlDrhFRdMJQb2OJUExez64h9W7
         t5Bl/QlaESwQAH2VTpzCt2AyllnmBbRf0ImV1bWROpqQIUsRy7zco9/qAwqC2o5Az0ht
         tIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262370; x=1710867170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlwRFf9ZVc7JGOilPoy0XCRhLdO5P5KXBLK8mdvhOh8=;
        b=VWd7rXE3M446Zqx8znNX3pCwv9O1eogth0kAKyZDk9nPrcZaLSQS//0VykZIyXLa72
         xcpaf7vHk26L5cA03y/UsZhYMnzygN3+k6cTbDEYH5zyhm0Ela7ESRgZ9udFji9swFqY
         KCVgyxrAgHWXsI4lRHWSQ5iELxyT6qMvo9T/X3jm9lqlmGNuDYBzwQdIpaEUrceDMpmt
         /NANryezzWjQvMn6wSB9h39k/3VQKfDMXjikFXY3/BIE+JXdYB3ZFPYOI8A+dOe9wcrs
         9Fp2SvmLqdAwLfAUSp+IUwt32LNXLptuW82mVR4+pjECLg1hrONwZXSKQyKmQq3JZtsI
         z70A==
X-Gm-Message-State: AOJu0YwkxJ5Uu+ly0XvXJuXeqKdW57uwP3o7JPReS8sC/OqC4C8E2uxU
	QNKGZIKykJeTv4o/ZesRIGdMHsWCHDV+D1z76To/5s0LkBeBS4D5NWYLJGcUEMRk2ye135YKolc
	xZFD0mcRLJ8GWHQJQHeEidyHgziMnqkniVZMDDw==
X-Google-Smtp-Source: AGHT+IEjrl9eIVZLYE98xsKtNHeNrI0FjTWKmTVrh770BgNaPFWpwwPudgPYp4hHrpVXa9quoYjUq/5f8+ZqA9jvRkY=
X-Received: by 2002:a05:622a:613:b0:42e:f759:eee9 with SMTP id
 z19-20020a05622a061300b0042ef759eee9mr169379qta.30.1710262369953; Tue, 12 Mar
 2024 09:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-6-pasha.tatashin@soleen.com> <n7fm2gtlnj76hnlbpmednqpq2nfdrb7lii5gpughsey5omvnxs@mponlekek6ne>
In-Reply-To: <n7fm2gtlnj76hnlbpmednqpq2nfdrb7lii5gpughsey5omvnxs@mponlekek6ne>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 12 Mar 2024 12:52:12 -0400
Message-ID: <CA+CK2bBHghbwSBR29+Dj15XCCJMxfyoW9Atgj+0OGZKmz-NbSA@mail.gmail.com>
Subject: Re: [RFC 05/14] fork: check charging success before zeroing stack
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, lstoakes@gmail.com, luto@kernel.org, mgorman@suse.de, 
	mic@digikod.net, michael.christie@oracle.com, mingo@redhat.com, 
	mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, 
	pmladek@suse.com, rick.p.edgecombe@intel.com, rostedt@goodmis.org, 
	surenb@google.com, tglx@linutronix.de, urezki@gmail.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:57=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Mar 11, 2024 at 04:46:29PM +0000, Pasha Tatashin wrote:
> > No need to do zero cahced stack if memcg charge fails, so move the
>
> Typo.

Thanks, I will fix this.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

