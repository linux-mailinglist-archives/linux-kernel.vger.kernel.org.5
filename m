Return-Path: <linux-kernel+bounces-48349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B27845AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8FE1C20B22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB15F496;
	Thu,  1 Feb 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+PRPxaI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E785D473
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799598; cv=none; b=cd3JeGkm8Aka3XNz/H0GZ6dkhU3VVFlhrigqDAXpK4bc0Avwetrt1euK3UpmK2KqaVIdRkqPJYC3GDMQcF8IBl3FNX6N3XUi14vUd/uJbwk8yxx0xAEnAQEiGJ/rXUabsG0lKGf1cElVTRCoHoQKB1+HvyS6QXnRZz/ysFIu1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799598; c=relaxed/simple;
	bh=94I4Hngt7inm0HyyqmR8znoRw2619UwGASlJ5ipJCpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/RvynMJBk9TNE6bUAMdNrnK0TRiErKAs4hyVcB3om3gyQDG3xt3Cr8tVN9DkFb5PzjEMP19UJtq1H0MCNB+nE3JQnGQ0XG2VxHO+ptnYwE/D2jy61BHpl477MDGIBSPGpetwLGDt3CUHLSPs9M4CQXuTy8kbqpxPtVnCco8W/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+PRPxaI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706799595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94I4Hngt7inm0HyyqmR8znoRw2619UwGASlJ5ipJCpI=;
	b=K+PRPxaIRvzsCTsZgjPtVnFlILUP+mwkdJczWGc3Q/5bpgdnLlqxV1QiiLqn/duKXBFNHA
	M2rfaKn/eMXgt43Xt/G+eepAquzjE2ftafInBorvn3hjc211ZyAk8iESpNa9nKa9zTye7w
	YWOB493KbynOSa/w2IkDGiKXm7TxKyM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-j-kUNqvdPPGTCpQ5563IAQ-1; Thu, 01 Feb 2024 09:59:54 -0500
X-MC-Unique: j-kUNqvdPPGTCpQ5563IAQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a30f9374db7so234397866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799593; x=1707404393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94I4Hngt7inm0HyyqmR8znoRw2619UwGASlJ5ipJCpI=;
        b=lVeY0lQ/P+51fcdT2naJMOdg/VhWBzRkdSLv5eM00NdA9FKUC6D8++twGGE9WKbfUf
         ztMVc1+ZyhjXWfja9OllTWdp+u3QYob4ZYr7GsU3im0eXk1nyAJnkVmJeybQlTmYU/Aa
         MPtFnazgx9dE5slGty3rQLIulZ0POvfD45G3dHfi+v7owvPFnFJ3wNpsQwN/9Ko1Qr1Y
         U1HRheKOsfMIWHVD65dnyKewS3TU7H6ANv2Avc6TBRc5LE4P7Yuq++qwXooC4fk4331C
         hB9fRQjwNuxQZXJUHPGMNIDo0e7j30A/YeokblmSCrn7XhY1sdF74DSBkDJoUi3d/DIL
         MH1g==
X-Gm-Message-State: AOJu0Yx2YVMJXHKU2ELeVeWYew8MkL1M2B4gsf9mdVF/B0jpE361dyRD
	iyNc4RXU+fHlLjiNBhROGGl69k81EtJZftUvZbi3Et6m3SGbfFFBMgGRj0Fudnge020bnhWnK0O
	ImTS1/N5vmjnRb9gOGD83Nhb/NF0dME1aEO3NAuf5fZsCqnG7MsCLbcia7ppn/ciW/JgQ4DNEro
	Y59od1Rgw5g0UZ5QJNPAicIx+zRj7Y9w8UVpFy
X-Received: by 2002:a17:906:e0a:b0:a36:86be:aa76 with SMTP id l10-20020a1709060e0a00b00a3686beaa76mr4193439eji.15.1706799593201;
        Thu, 01 Feb 2024 06:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Y5YQ9ZRCSFznfVuD8jaL3DWybT5I6SS9dOL/ws+LXeyzrCIM/drqeWDfWguj4Svx99xGj/ZIFZu2ZX9UUnI=
X-Received: by 2002:a17:906:e0a:b0:a36:86be:aa76 with SMTP id
 l10-20020a1709060e0a00b00a3686beaa76mr4193429eji.15.1706799592901; Thu, 01
 Feb 2024 06:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113204809.4052009-1-aahringo@redhat.com>
In-Reply-To: <20231113204809.4052009-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Feb 2024 09:59:41 -0500
Message-ID: <CAK-6q+hh_A0Ldwsmmy0BdagDotNBV=Xgk35ZZQ3DAzB9OXwLgw@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] refcount: introduce __refcount_dec_and_lock macro
To: peterz@infradead.org
Cc: will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com, 
	mark.rutland@arm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 13, 2023 at 3:48=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch adds the __refcount_dec_and_lock macro to generate code for a
> lock specific refcount_dec_and_lock implementation. Existing
> refcount_dec_and_lock implementation are updated to use the new
> __refcount_dec_and_lock macro. In future other lock implementation can
> added to use the refcount_dec_and_lock trick to only hold the lock when
> the refcount is going to be zero. Per subsystem own lock implementation
> can use the macro as well to provide such implementation for their own
> locking type.
>

ping? :)

Any chance to bring this upstream?

- Alex


