Return-Path: <linux-kernel+bounces-103670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243A87C2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71621F21CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44473515;
	Thu, 14 Mar 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ8xBZl+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10981A38FB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441109; cv=none; b=He3O6QaEDuXUEkDZ7Guux/kYbHbYdu3HAcjUmWzRMTkCzJYJzh7tbH9yHqTkcStpC7EOnOdKB0mW1pBil30/ZlqHtdKmBnk7lFYMMCie/ACK6l0GkX4uXR2YgLbRPn7HN9KvlfANwk8cvPFUdwxrMdD5jAEWaIbnvr3Mhb1Rc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441109; c=relaxed/simple;
	bh=IDBDzfKssVcMMW6+rwk5o+1AuiqHGwAICo+u93V+rh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVRQBGFC984/cOm9w4Bj03Gx7C6fG1M8UijsDbyKP0SHcbG9gvWy6umq0nYhZelBTVo5v+xHe5Nk8qQN3uZBtBbMPGj/oLauLqKs+/+obT5Da0mfD8SAnIu8fOOmfprWpV6daulWNAXPMMJDCPrZxgXcOwAYdhgIY6YYBahrShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQ8xBZl+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710441106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoWgosSZqI3joHZKAbpl768QMI0gg7fwmXIVJSVSCzg=;
	b=hQ8xBZl+InKIvsiNMMXvBaaQ5zsI4d3fLST6L3JFRU/BjpBiiegoXrt2vyjSuWuf2hhFXJ
	0Kn/FsqCD9qI7vkQ/JqNh1x5DQHNQzIEl3T6+hrVkuB3t672spqEiK6OKCakGmsX2VKYao
	+7EAjzC/9/HTlcqaX7Le7GgjW24ihok=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-PN-5I5_dPLCOOeyLVdybtQ-1; Thu, 14 Mar 2024 14:31:44 -0400
X-MC-Unique: PN-5I5_dPLCOOeyLVdybtQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513cf3f8d67so1222569e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441103; x=1711045903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoWgosSZqI3joHZKAbpl768QMI0gg7fwmXIVJSVSCzg=;
        b=mo4UslS8dXPm0FsPlmE8LKhTwsc9NDdr6GXhtybYgLdgmv5idEdjrgPW7do3GBagmV
         cQ++CjtBfRbmcSfYIQ1el6i+alPbjXF1k3xqm73m/PKp6Ue8vpUFRTZpSEoaxwO/BNI8
         xwbaioqdMIHn1a7LhJQJ6HZOej0HAgvJucsOsvC56wc1mNf43D0B1XBmw85ELMaPZpB9
         4t5zr0q/L8vRGUffs2UsYGL+3PT49cKmqKYvr7v1odpSm1jnc5y4JnO2TEqS1wKVTv+3
         jk/2eHoo9GKTEziRs0Tahb+BQbUeZBHKkN6IPDCdFQoHZNnm+KZR2+hYtTz9Lbxk1sEU
         kh9g==
X-Forwarded-Encrypted: i=1; AJvYcCVoUmAdcKsrZfnUuGutuIQV3Lw1wmWCRW6S2BeTOW8cnA5JDUJW+Na2Y7wS6ocajRyZd6uRTdSiAafYdCHpJIl1wykWpUh3MSmM3vF0
X-Gm-Message-State: AOJu0YyP9E3IpQVSG9zxij7Jn3hxbZpEln5PkRMeuZDbR9IpQ73KPjFh
	IRstoIsKMzQBchCKJ0wMe23BagPnmsVtSFLAA0WwsfQ/87tdKXXwnA8bKVWAoPzCwJ+MuORvu/M
	TRh+MhSC6m8IolmodzjBVN1ftm406AMZ8q0y+wsOsjdmJCcsnzk8jaT5nWNXjH+XrF9uQdFj8Jn
	UEGVc83yL5geKC5m0Vzvl5BSA/wA4o84wW0yml
X-Received: by 2002:a19:5e04:0:b0:513:d021:afc9 with SMTP id s4-20020a195e04000000b00513d021afc9mr1670440lfb.19.1710441103508;
        Thu, 14 Mar 2024 11:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERI/ykUS+EYQxjMLZNZ8K/KE9J1dutx39tYSDbcTu9d8AuNY3JjVGUuVK4CeIO40RB8iL6D3uG04FzFyHq5oM=
X-Received: by 2002:a19:5e04:0:b0:513:d021:afc9 with SMTP id
 s4-20020a195e04000000b00513d021afc9mr1670427lfb.19.1710441103166; Thu, 14 Mar
 2024 11:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308223702.1350851-1-seanjc@google.com> <20240308223702.1350851-5-seanjc@google.com>
In-Reply-To: <20240308223702.1350851-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Mar 2024 19:31:30 +0100
Message-ID: <CABgObfa3By9GU9_8FmqHQK-AxWU3ocbBkQK0xXwx2XRDP828dg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 6.9
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 11:37=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
>  - Zap TDP MMU roots at 4KiB granularity to minimize the delay in yieldin=
g if
>    a reschedule is needed, e.g. if a high priority task needs to run.  Be=
cause
>    KVM doesn't support yielding in the middle of processing a zapped non-=
leaf
>    SPTE, zapping at 1GiB granularity can result in multi-millisecond lag =
when
>    attempting to schedule in a high priority.
>

Would 2 MiB provide a nice middle ground?

Paolo


