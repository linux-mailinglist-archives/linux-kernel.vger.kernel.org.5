Return-Path: <linux-kernel+bounces-106787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE687F3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26301C21777
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210205C5E8;
	Mon, 18 Mar 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+pym+28"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5215BAF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803120; cv=none; b=M9LuykCe3lSBrQwF2m24/F8hRWpMvpzB2wvKrCZGTl2V2KiIgzl5yzQa16j7q67iNonqt1htKOVmLQsL6p0CFGSeOuVkyCweGWEOyFO5dk/nm7/vm0PCWKMZ86CDlNWPPsE536Yyl+xnQFrNm7KMHgk1zNHeLsETGjL5Kll8TxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803120; c=relaxed/simple;
	bh=2bls1+H3PwlfTa0W9+dh+wYPbk/Ifn6qBH+g0WFfirc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bfde4XVgxyxFu45Me7T8RY5OPwk5PHWKQO/A2PKAMTB740VfUckYEzEFYlbY1CwDtaKQlHeNI4KK7w0pDdrrBH/m3tEbtslmC5jZgbN8L4NNL9AN2VKI5mO5PFgl+0s1JzStGWFnhONHO0O27cwVSFZAlQmJWAx0wX7rg8uk380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+pym+28; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710803094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bls1+H3PwlfTa0W9+dh+wYPbk/Ifn6qBH+g0WFfirc=;
	b=M+pym+28U1slqrHaJl2QZlfzyM+n8fw9RcaG3fAPrSwI3LF8zQfWfssDxJic7ryU2gdrH3
	18yinj+iaXdxW3MiKzEQH6Kb85PzYTHn7WSFQDO1wc0BfnO/nv9cFALFSiIlS29Tt8gOXv
	wZiExeqlC+lQYqfhjXWoztGKvQutbpo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-8LK9V0dPNzy_JqmzKp296g-1; Mon, 18 Mar 2024 19:04:52 -0400
X-MC-Unique: 8LK9V0dPNzy_JqmzKp296g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e40126031so33326395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803092; x=1711407892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bls1+H3PwlfTa0W9+dh+wYPbk/Ifn6qBH+g0WFfirc=;
        b=VC6HaydKyI5xWjO/61kGa1pp10IrFpFLIpSo5jL1Q2Ap+FWOfE5Qk7sg2fh+nC9rzH
         2IIrS9wcfDsO5hMMJIEEc0IGcfbL2dqIxbbM08wv+oiDXbjDUq4QOUUevt7lVJg7HkpO
         W5hxXomKJMZBDoYiChIZwT06nVsod63KbYAwYbdlIwA6Vi613RU9YY5ulzC+djkZOINA
         UAFqkRdE/q5mAodL08fZniQprUsvQFpCofTkbeDtMTObas3AjjFpkAIJiV6K+4WlYdaQ
         yNEHDXqJlZSaW3TksAFbbLD6Tti05GdsmIUyULsxozanlHqK/pEA01CvLrc9/Id0pPre
         NMZA==
X-Gm-Message-State: AOJu0YwA/ZeQtHj592Tdr60YGBjSTJ158a/AE0neIMUE2zdfKX4HIs0Z
	Rk7BQ09c06bbKRTupUyTTx21UHy9qxjW3C4dR9aXhYeds0hUS7L5G+zU9ZyxJOZLsMDZxJZxTga
	GB4dX4y12yDvuiOsOA8eB7W9DxMrjC8qoZriS20O/lBGFKNNmxvQSMNzuUN19jbjstk3qhvfXvW
	dYQeeq/Fu21QlmuBmwmQ6NFw51BR1Tnm3iK7Mk
X-Received: by 2002:a05:600c:1546:b0:412:d68c:8229 with SMTP id f6-20020a05600c154600b00412d68c8229mr7351762wmg.39.1710803091812;
        Mon, 18 Mar 2024 16:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsz9jEEavSJxI8HdinJ0wgKyMLykG+kV8xTe/yLnKDFS+ZJFJrYGYQ0faj3UkXxqFRkIIeBEd9y/uXD7OpJkc=
X-Received: by 2002:a05:600c:1546:b0:412:d68c:8229 with SMTP id
 f6-20020a05600c154600b00412d68c8229mr7351749wmg.39.1710803091498; Mon, 18 Mar
 2024 16:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318221002.2712738-1-pbonzini@redhat.com> <ZfjHKdx3PNqQfkne@google.com>
In-Reply-To: <ZfjHKdx3PNqQfkne@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Mar 2024 00:04:39 +0100
Message-ID: <CABgObfY-w8uK+Ra8tK0e8xFDQYA68V0Jb0SrLmoM72yxgp-2eA@mail.gmail.com>
Subject: Re: [PATCH 0/7] KVM: SEV fixes for 6.9
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:58=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> On Mon, Mar 18, 2024, Paolo Bonzini wrote:
> > A small bugfix and documentation extract of my SEV_INIT2 series, plus
> > 4 patches from Ashish and Sean that I thought would be in the 6.9 pull
> > requests.
>
> Heh, they were in the 6.9 pull requests, but I sent the SVM PR early[1]. =
 Looks
> like another small PR for an async #PF ABI cleanup[2] got missed too.
>
> [1] https://lore.kernel.org/all/20240227192451.3792233-1-seanjc@google.co=
m
> [2] https://lore.kernel.org/all/20240223211621.3348855-3-seanjc@google.co=
m

Duh. Pulled both now.

Paolo


