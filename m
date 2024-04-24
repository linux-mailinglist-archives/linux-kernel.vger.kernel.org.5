Return-Path: <linux-kernel+bounces-157236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF668B0EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18361C247E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002215FD07;
	Wed, 24 Apr 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUGT+1kw"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73491422AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973493; cv=none; b=dYAF6iSSAoMkGIW9nMji6YQc/xcX4GDHhJfYac/STsPUcQ4CR8L4bzxCVde6WxxhM0yEmhBGukAyngV0Tzh2P6vJYRIKVG7W+Rly7ovKW27s6BGzJMsNCWYlWL08vA2mrY4pZr2OTYX4X1TDeNNbTUxi/8fGoNnAVAYw0g/pIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973493; c=relaxed/simple;
	bh=i+7ca9F3R2iODML9OguZS+G/rK7IFeFMp6FII54jhQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cOlVZxfUcdAduhYJkAcQHXICvW9pOOXBL6xEsqaKpwGIKxUrUZ/+IwnUSZ+qG/vx/VOKt/R5gRNwQAZYgIgFy4opoWOSW3Ii7N+pIqtB/C9NCjug8hugQJs50auwytIc31zqXTAVophsYw/8iUrcD8sADFpkz31+r500P0l0Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUGT+1kw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed03216b70so32881b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713973492; x=1714578292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isygqxg1DADtvvMpbUH5H9PRVRX6wRPPjYc9YMzxz5g=;
        b=xUGT+1kwxEzpMO+O7wS1ziGG9K2H/oUFR7Sjkm1ASnzzl167N+t2sa5pNS2aX5trdE
         rAkedHiECe05XtwIaPeWAYpNC1rZn/jJRJ+Li5R+WhGLG3nKqHGm/diT08GXCeeZgJrB
         6AsjghV6g2LGmo/XYbas1sIWU7Zknc0A5N04cEFYZTyqByNrn1JtlHnkju9UBQ98eaiU
         vK2cUKf+WC3GAl9Cb0aIItgxJ3qy7/tiRBoZs2HJwcb8oI0397cd6tLt9n2ZZdh+ZSEk
         Aao6DWFijn0is0JoFHGVt/7Dt5nRbusadufSYj7kBy7+ruvU9dvI/MJrNa2Ky5/o08wa
         YhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713973492; x=1714578292;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=isygqxg1DADtvvMpbUH5H9PRVRX6wRPPjYc9YMzxz5g=;
        b=d6K5uPHl0qG5lzmyZufSz/j+ZTd5elwPtReq5ANP3skaW1XfHsd14v6NiqT7mDBlRX
         pYhkm/1a3SkGirQN519I4PAkFa7jtHQzPsKVyr+Bq5/HVLR9VQN8jCirbuP/AllkaP9W
         9feiBTS000Kb9YMluHGk8LpBNVYmlV/14d7MaIsZOFIr/MnTtuTUq8gajKq2BQQC/bHt
         4KEyZNRMhwMf0EtgMidBjZbch0tk6D7bhMJSHHFtQDDh/VrAOif36/vIFYN06dnab/Jy
         f7HLB7x8SeQljbQbGZTMq59Ys0srs3A0/iZFHdiaaLQP3J5jP/p1rDDYGvIQLKYzWJJM
         AOtA==
X-Gm-Message-State: AOJu0YwVeG1M7vkjLfhqabbAh3KmXGhbyE4Hllw5LTDXMZdRegqTaTct
	8LlRpjS+5QZxeCKfuUTZLeFtCSDYckQNqbFzIYcjBJUFrHaNQiZik13HCKKr1MeBd4rjX3OGnW1
	X8Q==
X-Google-Smtp-Source: AGHT+IHS0BxqB9PcoPfboy3NmQMn9RV38ybNDU7Su++NB70GwISBmSLNZI5ND+4qFNSlwp+C1XSavho+YNM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:4656:b0:6ec:f5b8:58cc with SMTP id
 kp22-20020a056a00465600b006ecf5b858ccmr437835pfb.6.1713973492116; Wed, 24 Apr
 2024 08:44:52 -0700 (PDT)
Date: Wed, 24 Apr 2024 08:44:50 -0700
In-Reply-To: <20240424103317.28522-1-clopez@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424103317.28522-1-clopez@suse.de>
Message-ID: <Ziko8vNhTeOdfXNu@google.com>
Subject: Re: [PATCH] KVM: fix documentation for KVM_CREATE_GUEST_MEMFD
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024, Carlos L=C3=B3pez wrote:
> The KVM_CREATE_GUEST_MEMFD ioctl returns a file descriptor, and is
> documented as such in the description. However, the "Returns" field
> in the documentation states that the ioctl returns 0 on success.
> Update this to match the description.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Ugh, copy+paste fail.  Good job me.  In case want this backported,=20

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-spe=
cific backing memory")

Reviewed-by: Sean Christopherson <seanjc@google.com>

