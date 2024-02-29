Return-Path: <linux-kernel+bounces-86427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B686C534
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7011C24053
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2895D744;
	Thu, 29 Feb 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6t2X0ub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5F5CDF2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199047; cv=none; b=m6YkE0ZrFBJFIfVJkOFOyp7WAnHz7tJNjsoQjBgtTydLMCFinwqL3m26gpRpLj+xrYUIreb3+7cBWuRs7hcFLkl8fVzZ7ozQl/DnqBopJB2OAF1h876lY+M25bGEblspjTfG1LwHRFoF2rFLgKw9LQAjp9prrtxXm7LJv6QTgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199047; c=relaxed/simple;
	bh=J54H/uh13Y+M+2G/ErtbMohc9y1aCVSoOZ0Yj1zPpBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Slzhys9j2ANWFLOOlrPIhanV1Jp5vK0w1bZRErwOVxVmUEbwB3oH2fcg84rs7K5m+XJ38zzwdZrbvLx6VG1esEXOsE19Gn+5htYU+3fcinnasSyoMnNu6/1ClSe6mm2Gsx44tyHcbAd3ZXkF4m7v1XMoVhhoP4QXhZX07QbIOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6t2X0ub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709199044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J54H/uh13Y+M+2G/ErtbMohc9y1aCVSoOZ0Yj1zPpBU=;
	b=f6t2X0ubEWvxlfOwIjDCf/nYK4N/bbccekNrKN+EdQOySgEW1Gt2s1T9Ee4pDkEopvbKJE
	49lpMNeb/tl000WjUpcWYFe14umEt18kL8sBjl3tr57Q6UcjFeEyJWdXX0CAHb1I2cgiO0
	zsVNe6RggizXB6mHfk4Yi64sqwSBIO8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-dPfbyM8GPWuE9vQCGl_LWA-1; Thu, 29 Feb 2024 04:30:42 -0500
X-MC-Unique: dPfbyM8GPWuE9vQCGl_LWA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d2a83b6628so616241fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199041; x=1709803841;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J54H/uh13Y+M+2G/ErtbMohc9y1aCVSoOZ0Yj1zPpBU=;
        b=DMT98Gl0DcScAwbnFBuV7xRMTsacoBCDqUVP52+3ohLD10FHKCIfVLEiM5DKVeKFWa
         S4Rwtnp2s35WjFm7nIXo2XzNTJF+w1aH9r/8O8V8yQviaTp16eEld4dpfeezYHBWV+59
         DCyQn7vuGfOeV0jv8+Pb2YlIwkcN/L6QkjrX+QKAPi38DWfIhWHogXenDsqaX1xyVQxK
         EEt5/k+9mf0LUQpKgMQvEbeaHHNOZkhqPe1f+C2gREMYh7ShlS7Kx+CRsYNbDD3JHw2B
         7Ld+849FVeiIe/Q+AuLjHBZBLmSjN4+5O0XAbOq4ATSUKLlNnzgtBh5AoP7unCZNS/2W
         LiWg==
X-Forwarded-Encrypted: i=1; AJvYcCXEkVbeOzoXWA7F/TjrzdW13IwON5bfUK08PLguBf2I85iJ9R2AKZ5ZUn2Uyfhbv8hvZCNacMmnVSi7fFMsQnsMH2SJJm0HT8pxqXdG
X-Gm-Message-State: AOJu0YzFH1kt/vhkKKO657EDe89sso86Hwzf6DUTD0NyoLT2YxUB6i7j
	jIM2t4wNfH2HQ5QfI0jjRwT4UoryY7Rmu7IzD9hYZvG5uL1oIgIqgUGeoi78V3GzVb5m2pisW2l
	nYlHMyyC7N3TUAix4u3aGhE5CjH2EEGI8G4GhJN9ixigF0CvSS94NsS0KJvEcwg==
X-Received: by 2002:a2e:9993:0:b0:2d2:a2f6:c75b with SMTP id w19-20020a2e9993000000b002d2a2f6c75bmr822893lji.4.1709199041469;
        Thu, 29 Feb 2024 01:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRs2aus3xuPxlmhWBnifSxaK01b0GZMeCNAv3128sAHZ6gaXpzAUSdXnzqYRWTKd7MwScDcA==
X-Received: by 2002:a2e:9993:0:b0:2d2:a2f6:c75b with SMTP id w19-20020a2e9993000000b002d2a2f6c75bmr822876lji.4.1709199041086;
        Thu, 29 Feb 2024 01:30:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b00412a9a60f83sm1506441wmb.3.2024.02.29.01.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:30:40 -0800 (PST)
Message-ID: <2fc6a4f7ea0308626cfd06d95564486d187b16e0.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
From: Paolo Abeni <pabeni@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com
Date: Thu, 29 Feb 2024 10:30:39 +0100
In-Reply-To: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 17:12 -0800, Abhishek Chauhan wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
>=20
> Existing functionality of mono_delivery_time is not altered here
> instead just extended with userspace tstamp support for bridge
> forwarding path.
>=20
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Since this is touching a quite sensitive code path, I think v3 would
deserve some paired self-tests.

Thanks!

Paolo


