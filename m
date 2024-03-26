Return-Path: <linux-kernel+bounces-118328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628788B836
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317BA2E4504
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A8129A65;
	Tue, 26 Mar 2024 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yH9tg9kq"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3057314
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422923; cv=none; b=Utm2AEePFxuZ4O0/CFYFNdzuWpwagOM7Z64jcvCpeW0r172e5dmpmWAiDsnbleXaaRI6eJto8tEQXx5yCP3y5gsR11xuM45IrtQjYoSuTqKRvnvkS0tQGcmZYq4AVqWfVrB+fDRjtEgxaeKRF16ohzGq/PR2CpOzbAy4NeiRN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422923; c=relaxed/simple;
	bh=uU+SdB9hv9VPV/MPXHQAweqQt038vPR1r3h/RhWxy4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVHdR3ELPtDhPz8XKVi9POu7rHr/mRfTjP6FAz0aixDD7xuAdN/zXz/Q13lszRYFWfmJC5o2SJyhEODZWfCNlXbMY8pFJUOn3BKyoUzHD15o/PtsRDD5yBfEfmYx7q8nU3qkNrF9gWwfQgtMCfbJOt8oFouaeSOsN6V4SruQ7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yH9tg9kq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso3319a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711422920; x=1712027720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h59Ujb231n94iPcWksCPCK+dVGEbVXi1Rid0ia0yVGY=;
        b=yH9tg9kqdZA0syl5da9EAo3Aw2xOrDG9aY+7k7k4TubtvKuzIWMgSTM1BBHh9Kf3SZ
         oaE7Br6dZ/lL8xAceMpXibrQ6ebzH+Uh0Yhe3XJO8cf1narVr6+UipGgmzvCZasKhH2R
         QtxGtyiwdbWEYyhZvVEThLoBakbgaHs25hR2ThrrQj8Lkc0GLJn8IL6FSGtbC+CRaiOJ
         E6b1ohAUObrCbEnSCkaE1+deEehpqb9bWMYEl1VMomJKSjNtuSgtHhjIZoJKVGj33Esc
         wQdQPNtPFhCOIePxJOwUMIjO7MhrhxOVrwvAVEBDz+cN7b1xxiwhXDxstGXYS1CyZjWG
         QRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711422920; x=1712027720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h59Ujb231n94iPcWksCPCK+dVGEbVXi1Rid0ia0yVGY=;
        b=VR1Rpibm6x/Rt//aUrn7llWl38wxnW7DKJBUZ4Gb+GcSC2UKwWf2onxaLthlyOlQqC
         YyRI7fvu/2b//iDkNAtgB7OW1FtwDS6rbuL2EywIMlxjHZ5qkchsV2NU96tkjSXF1Pae
         ABEpqPQLGygvGRrPknHnz5d7O4ZfJMNr1r2v6IW2U3hzfXJ1IHCFMC1Q3JstYt8vg8Vc
         GwKNtxsEX9Sio9iAwPsnFidQQAvGCFBXB8X0snunjE0kmakbum/Urct2WkF7LZzSZ9y4
         a4+N1e/8A0BWV8YdpKhgMwxMElmCL8PIYYlJ5mVEqQ42IGpW2LWqg6vSRvpBxWjaD3AJ
         xBNw==
X-Forwarded-Encrypted: i=1; AJvYcCWU4c9mD/N3BQ0B/r8wF9gkkEx+HC8ruTYKhlRXvNot2zDzKa1CYSZi/Xa2szZOyqHV0nJLtibKp7lJeqx+t7oDvQIqHxk/6owGUQdr
X-Gm-Message-State: AOJu0Yx10FbVLvx0e5GOr4zNDizupEIPw/aV+gaI7GF4jYhV5QCRTctL
	A+n49VRFoT+MIVfokyXgpkDUXXNrb3/zg7WjC1BT5a6A4H3sankBF2rHwyGKjpLefZMsuj1Gq3H
	3RVKH8bXh/ZPRRdX9NE4CveJSs/oUAMakTpcx
X-Google-Smtp-Source: AGHT+IGP6HGOjwqsoe8xIsHMkHVJvmdde3hdIBhpI2QSUDVcMgFZE7xVDsp9PhdopqxGx8UfD/7LwsgDAQgcLR5w+Pw=
X-Received: by 2002:a05:6402:7c2:b0:56c:9ae:274a with SMTP id
 u2-20020a05640207c200b0056c09ae274amr28269edy.7.1711422919954; Mon, 25 Mar
 2024 20:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928150428.199929-1-mlevitsk@redhat.com>
In-Reply-To: <20230928150428.199929-1-mlevitsk@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 25 Mar 2024 20:15:06 -0700
Message-ID: <CALMp9eSSCUSOpP64Ho16sU6iV1urbjfTafJ0nThAWGHE6oOkLw@mail.gmail.com>
Subject: Re: [PATCH 0/5] AVIC bugfixes and workarounds
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	Sean Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 8:05=E2=80=AFAM Maxim Levitsky <mlevitsk@redhat.com=
> wrote:
>
> Hi!
>
> This patch series includes several fixes to AVIC I found while working
> on a new version of nested AVIC code.
>
> Also while developing it I realized that a very simple workaround for
> AVIC's errata #1235 exists and included it in this patch series as well.
>
> Best regards,
>         Maxim Levitsky

Can someone explain why we're still unwilling to enable AVIC by
default? Have the performance issues that plagued the Rome
implementation been fixed? What is AMD's guidance?

