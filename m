Return-Path: <linux-kernel+bounces-76224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC985F471
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D32862FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E926381D5;
	Thu, 22 Feb 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBIqfH02"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D03717D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594466; cv=none; b=KoPO0pTh6uwgjv6feogxd+ETpGFWadhR7UHPivltJ1AbANeFJsPFPtFUR2RCfapj9MNlOlB0U23VtOt59Na0qvj2bgenyDrAM5c7qcyovB0wxnxes3DCxUKoIBWoL3jnDvYACoSIrYgD/W9dmpQctTRJc6qkC2e/MVQsDZaMfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594466; c=relaxed/simple;
	bh=jsymz0ZV3wQosB1mc7TrX/RgyOGB8OgHkdfOjJ/GU7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRACuSVnOD6C7FkIdWqThZDF/7JTuFnZl5+uir8im9BhmzV+gC2lYOOs0UO4MGIiRblKYvNYPC0+EUfVryUUJbhw5c1fZLZ4FrNUxAWsO0fch80IezC9SEtg29Fr6l9KhIR6exW+xkkxYhGhmw6ekSF9oqUxHr6oij5BDgnDbVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBIqfH02; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708594463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FvjULRwSsFiCewjz9HeM0ecz107mFZQPYxRhheoHiRQ=;
	b=WBIqfH02LJd0eyDGenVH9+gzFgJ7jFk+9LQ8Ylh3uGODyVt6NwrSPAHmBPYZ62NBRrBGPd
	kUA9Zg/k+qY7iZnS25io0NH8Px2n2fjG33YaPz1p9bR1oLdAv6lQVHPnhhsadm/nrItUiO
	7Ot4mEAujc4WiImXPIUBRy0meRZr7so=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-T8toOdbYN2KNAKyJkAURsg-1; Thu, 22 Feb 2024 04:34:21 -0500
X-MC-Unique: T8toOdbYN2KNAKyJkAURsg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-411e53af2adso12223725e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594460; x=1709199260;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvjULRwSsFiCewjz9HeM0ecz107mFZQPYxRhheoHiRQ=;
        b=dX0VdS9haqH5bYcjP+5ZFfDt+d1dadoorPGnVwyP7egFtonvLmj5xzOMA964/NGYco
         EEtXmyKbTCGj3FZWAjAvbbfJwm+w2DNkBll2HQUHvJ9GJNzu6F06l08gVKyZwxNR32UZ
         Z++DcOA0l5nRim125H0U0NKbK/iYaaTg+NpG8DWRIUmp59P3HCGLs87Tlf3iA18SteyV
         neD0H5znIWMFnoSrQS7ENOjusb5b87Paf9mZYBdPu3RILYNj2S2d10dWCqZjPhDPQiVT
         jRX7QhV4DMVICh6W5WcREII5QOfJiPi+YLUE3DUz/LEJQXXBf0bzDWOD4+IFbiKZyVoN
         zKOA==
X-Forwarded-Encrypted: i=1; AJvYcCW2fYyq9pPzDusoyR1Z6xMdoeKC+ryknB4v4j57cZvU7uDCbc32Mm5bwgrs7UBpFJLFIXWIjO/MCt5T9PlbeMSmyS7+jzI7W5DJTc9H
X-Gm-Message-State: AOJu0YzKUgdf5cnCwvKiT1qODdbYDY6DNPR8EVx1vbPaMVY4OIFOiTVD
	gMJ0ZxLYH+OovDQFhiN4llpQhhboQv2fUWtyhcudQz+pg1Aw+crmESIjKxk/XUw67Nox+yHMaUK
	3n0EKg89B8Iws9d0agQNOkhNpB3CRXB2XbQTaV4fBas7BJvbEYESwN9rmK0+aIA==
X-Received: by 2002:a05:600c:3b94:b0:412:5f44:65b0 with SMTP id n20-20020a05600c3b9400b004125f4465b0mr9416735wms.4.1708594459940;
        Thu, 22 Feb 2024 01:34:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBkknNINCo8PnnlTgxopzPomoqyRPK5E97Pf6S7enUCC1L4kHnSRCcWla8GPghp0VDTO3qYg==
X-Received: by 2002:a05:600c:3b94:b0:412:5f44:65b0 with SMTP id n20-20020a05600c3b9400b004125f4465b0mr9416726wms.4.1708594459603;
        Thu, 22 Feb 2024 01:34:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-236.dyn.eolo.it. [146.241.224.236])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b00411ff030f06sm21781711wmg.9.2024.02.22.01.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:34:19 -0800 (PST)
Message-ID: <2e3cf929a1aad9017cf57871c58675186f6d7939.camel@redhat.com>
Subject: Re: [PATCH] net/core/dev.c: enable timestamp static key if CPU
 isolation is configured
From: Paolo Abeni <pabeni@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker
	 <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>
Date: Thu, 22 Feb 2024 10:34:17 +0100
In-Reply-To: <ZdSAWAwUxc5R46NH@tpad>
References: <ZdSAWAwUxc5R46NH@tpad>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 07:35 -0300, Marcelo Tosatti wrote:
> For systems that use CPU isolation (via nohz_full), creating or destroyin=
g
> a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
> static key to be enabled/disabled. This in turn causes undesired=20
> IPIs to isolated CPUs.
>=20
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
>=20
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

This looks like net-next material, but it does not apply cleanly to the
net-next tree. Could you please rebase and repost including the 'net-
next' tag into the patch prefix?

Thanks!

Paolo


