Return-Path: <linux-kernel+bounces-155135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021928AE5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E422840E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB7184FAC;
	Tue, 23 Apr 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usxrKTft"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C382865
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874333; cv=none; b=fvz5/2ky758/IMi+I6iI7geKqJpQ5FezV4aqhkeTzgyfb5ShkzNSDsxYYYNNFNMLwE7yfLyVaV7qiS+JKJi091dqODtv/nyPN9gSadbRpfHadPUQoxsuyBEPs+DVbw+LMaH3S/CLdqgLbGJ27a7y8nqXUJJFIzpfJtRC/t1+zKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874333; c=relaxed/simple;
	bh=QUMOkPeMucCrVnY3P+UvLezzWpEMIoKiJLXkw/+9teg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j++FYKYFNYnBhdVLWKlIvZBy3cJOofRIUEMBYjTwQBU4tE/9uwJKjbigw6wkhKSnVqb95Xwh92b743yI2vOSnbhMDkWocl+IPBXh77tkCldJoQTv0vm2tsSmO7SvRp5raFtYXxJGQREz50/M/k3z1jQ0Jys8Xv989iFUSCG2Z54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usxrKTft; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5720583df54so9657a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713874330; x=1714479130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUMOkPeMucCrVnY3P+UvLezzWpEMIoKiJLXkw/+9teg=;
        b=usxrKTftqr0M1ywr7mtAx68AfLSglhIAYTYKR/O6op6vPqR6oLMCnAjGsKlJxW/eqH
         gckISObPuWCsATxL3TkHE3ca9TMbXusUKyHCYFX3B0M3gtFrAXDQsGSdLo7/75lCnEjr
         tlN93vgScYksR/Bm0lL5r07CC7/ybqRTl2SJjqgryvageV3hyMljbO70a+j41ZO/P+GX
         dddJR05QJltVAxpQrQ/rfKTMAPR9JnuuMWLdOYjhSK1drNmiHnCEmq0DVZx1X29h128O
         9eidYD6vQzRJZQUkx3SybExOQrXs2VCp0GqkiYMs96FVbGenwSzH3WhDqk4Pfzx3vwlH
         rOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874330; x=1714479130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUMOkPeMucCrVnY3P+UvLezzWpEMIoKiJLXkw/+9teg=;
        b=pfE4alDD3TQLNa+jTHe/0oaHjgjFGTStHCj9WQxPe/mEPTXVsnDkXHiKc7A/+flVHy
         iq2VRRZOAPQPhDyjMhPwTdPEQ+GqnTwNYGv1HkZtnGeCOelOcm+qV4+T+fttUCjkWXj6
         AH70j7Qlbu/mdd4C0AE0yMjPFYgq2shsEz5JNSXu1M7KgsCvqP4dNvobb47ynJzRXtli
         CKEd/fBCLpakIWeADXKfAJFsqk1B8lhQbuio97Zto9q8kXW7wr97Mjq7FkSVDwb3auge
         Q0I75rQhtNIbblM4sLAVwIPHCiSOQ4JsYoPmF0/nUzMIWCTSy8yXdR2pNu0Gr46HiQ43
         quqw==
X-Forwarded-Encrypted: i=1; AJvYcCW7nNfSBhwS5HMfQgT6YwkcHKMp4zjfonOJ3uCuCZIlkm2tTD7oIagmj0b9BZ8xi6JpxUCW6S0R3QBkVa33GqeQ4nznswCFJKukHhfR
X-Gm-Message-State: AOJu0Yyx4BIgGGSZuXcMdIjUFUhboSs1Pdt3EMjoEIddYdphJNVvQJiN
	AYLKkAHK97zn4WLSA8jwZx9cghsYDkG4u0YrxjFX0jIZCW0RyBQo9Eu0zzfIyDMxFcfMWMUHncH
	1wzUq0bYdRge09VleoPQRiMtfqfR2KpGkC8sU
X-Google-Smtp-Source: AGHT+IFVlB2LLAc63mkiYhIlX/rzXgT9wq/+wtd+D/UFA8YHSy2TBcn+TwTyewKoFydcmZ6uWZynzLAtkEJ38ocmXeE=
X-Received: by 2002:a05:6402:884:b0:572:145e:d6de with SMTP id
 e4-20020a056402088400b00572145ed6demr173985edy.0.1713874329999; Tue, 23 Apr
 2024 05:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name> <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name> <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
In-Reply-To: <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 14:11:55 +0200
Message-ID: <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 1:55=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> In the world of consumer-grade WiFi devices, there are a lot of chipsets
> with limited or nonexistent SG support, and very limited checksum
> offload capabilities on Ethernet. The WiFi side of these devices is
> often even worse. I think fraglist GRO is a decent fallback for the
> inevitable corner cases.

What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST_GRO alre=
ady ?

Many of these devices are probably using NAT.

